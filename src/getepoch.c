#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <netinet/ip_icmp.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/time.h>
#include <errno.h>
#include <curl/curl.h>

#define MAX_WAIT_TIME 1
#define ICMP_SIZE (sizeof(struct icmphdr))
#define PING_PACKET_SIZE 64
#define PING_SUCCESS_THRESHOLD 5
#define PING_SLEEP_DURATION 1
#define COMMAND_TEMPLATE "date -s @%ld"
#define URL "http://worldtimeapi.org/api/ip"

struct MemoryStruct {
    char* memory;
    size_t size;
};

unsigned short icmp_checksum(unsigned short *buffer, int size) {
    unsigned long sum = 0;

    while(size > 1) {
        sum += *buffer++;
        size -= sizeof(unsigned short);
    }

    if(size) {
        sum += *(unsigned char*)buffer;
    }

    sum = (sum >> 16) + (sum & 0xFFFF);
    sum += (sum >> 16);

    return (unsigned short)~sum;
}

int icmp_ping(const char* ip_addr) {
    struct hostent *host;
    struct sockaddr_in addr;
    int sd, cnt;
    char buffer[PING_PACKET_SIZE] = "";
    struct icmphdr *icmp = (struct icmphdr*)buffer;

    if((host = gethostbyname(ip_addr)) == NULL) {
        perror("gethostbyname");
        return -1;
    }

    if((sd = socket(PF_INET, SOCK_RAW, IPPROTO_ICMP)) < 0) {
        perror("socket");
        return -1;
    }

    addr.sin_family = host->h_addrtype;
    addr.sin_port = 0;
    addr.sin_addr.s_addr = *(long*)host->h_addr;

    icmp->type = ICMP_ECHO;
    icmp->un.echo.sequence = cnt++;
    icmp->checksum = 0;
    icmp->checksum = icmp_checksum((unsigned short*)icmp, ICMP_SIZE);

    if(sendto(sd, buffer, ICMP_SIZE, 0, (struct sockaddr*)&addr, sizeof(addr)) <= 0) {
        perror("sendto");
        return -1;
    }

    struct sockaddr_in r_addr;
    int len = sizeof(r_addr);
    if(recvfrom(sd, buffer, sizeof(buffer), 0, (struct sockaddr*)&r_addr, &len) <= 0) {
        perror("recvfrom");
        return -1;
    }

    return 0;
}

int ensure_internet_connectivity() {
    int success_count = 0;

    while(success_count < PING_SUCCESS_THRESHOLD) {
        if(icmp_ping("8.8.8.8") == 0) {
            success_count++;
        } else {
            success_count = 0;
        }

        sleep(PING_SLEEP_DURATION);
    }

    return 0;
}

static size_t WriteMemoryCallback(void* contents, size_t size, size_t nmemb, void* userp)
{
    size_t realsize = size * nmemb;
    struct MemoryStruct* mem = (struct MemoryStruct*)userp;

    char* ptr = realloc(mem->memory, mem->size + realsize + 1);
    if(ptr == NULL) {
        printf("Not enough memory (realloc returned NULL)\n");
        return 0;
    }

    mem->memory = ptr;
    memcpy(&(mem->memory[mem->size]), contents, realsize);
    mem->size += realsize;
    mem->memory[mem->size] = 0;

    return realsize;
}

void set_system_time(long epoch)
{
    char command[30];
    sprintf(command, COMMAND_TEMPLATE, epoch);
    system(command);
}

void fetch_and_set_time()
{
    CURL* curl_handle;
    CURLcode res;

    struct MemoryStruct chunk;

    chunk.memory = malloc(1);
    chunk.size = 0;

    curl_global_init(CURL_GLOBAL_ALL);
    curl_handle = curl_easy_init();

    do {
        curl_easy_setopt(curl_handle, CURLOPT_URL, URL);
        curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteMemoryCallback);
        curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, (void*)&chunk);
        res = curl_easy_perform(curl_handle);

        if(res != CURLE_OK) {
            fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
            chunk.size = 0;
        } else {
            char* pos = strstr(chunk.memory, "\"unixtime\":");
            if(pos) {
                long epoch = 0;
                sscanf(pos, "\"unixtime\":%ld", &epoch);
                set_system_time(epoch);
                break;
            } else {
                printf("Cannot find the key \"unixtime\" in the response\n");
                chunk.size = 0;
            }
        }
    } while(1);

    curl_easy_cleanup(curl_handle);
    free(chunk.memory);

    curl_global_cleanup();
}

int main(void) {
    ensure_internet_connectivity();

    fetch_and_set_time();

    return 0;
}
