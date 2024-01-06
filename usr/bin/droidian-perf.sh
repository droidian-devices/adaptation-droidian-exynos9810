#!/bin/bash

[ -f /proc/sys/kernel/sched_child_runs_first ] && echo 0 > /proc/sys/kernel/sched_child_runs_first # spotted on sm7125 and msm8996 and sdm670 and sdm845 exynos9810
[ -f /proc/sys/kernel/perf_cpu_time_max_percent ] && echo 20 > /proc/sys/kernel/perf_cpu_time_max_percent # spotted on sm7125 and msm8996 and sdm670 and sdm845 exynos9810
[ -f /proc/sys/kernel/sched_tunable_scaling ] && echo 0 > /proc/sys/kernel/sched_tunable_scaling # spotted on sm7125 and msm8996 and sdm670 and sdm845 exynos9810
[ -f /proc/sys/kernel/sched_migration_cost_ns ] && echo 0 > /proc/sys/kernel/sched_migration_cost_ns # spotted on sm7125 and msm8996 and sdm670 and sdm845 exynos9810
[ -f /proc/perfmgr/boost_ctrl/eas_ctrl/m_sched_migrate_cost_n ] && echo 0 > /proc/perfmgr/boost_ctrl/eas_ctrl/m_sched_migrate_cost_n # spotted on sdm845
[ -f /proc/sys/kernel/sched_min_task_util_for_colocation ] && echo 0 > /proc/sys/kernel/sched_min_task_util_for_colocation # spotted on sdm845
[ -f /proc/sys/kernel/sched_min_task_util_for_boost ] && echo 0 > /proc/sys/kernel/sched_min_task_util_for_boost # spotted on sm7125
[ -f /proc/sys/kernel/sched_nr_migrate ] && echo 128 > /proc/sys/kernel/sched_nr_migrate # spotted on sm7125 and msm8996 and sdm670 and sdm845 exynos9810
[ -f /proc/sys/kernel/sched_schedstats ] && echo 0 > /proc/sys/kernel/sched_schedstats # spotted on sm7125 and sdm670 and sdm845 exynos9810
[ -f /proc/sys/kernel/sched_cstate_aware ] && echo 1 > /proc/sys/kernel/sched_cstate_aware # spotted on sm7125 and sdm670 and sdm845 exynos9810
[ -f /proc/sys/kernel/timer_migration ] && echo 0 > /proc/sys/kernel/timer_migration # spotted on sm7125 and msm8996 and sdm670 and sdm845 exynos9810
[ -f /proc/sys/kernel/sched_boost ] && echo 1 > /proc/sys/kernel/sched_boost # spotted on sm7125 and msm8996 and sdm670 and sdm845
[ -f /sys/devices/system/cpu/eas/enable ] && echo 0 > /sys/devices/system/cpu/eas/enable # spotted on sm7125
[ -f /proc/sys/kernel/sched_walt_rotate_big_tasks ] && echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks # spotted on sdm845 and sdm670 and sdm845
[ -f /proc/sys/kernel/sched_prefer_sync_wakee_to_waker ] && echo 1 > /proc/sys/kernel/sched_prefer_sync_wakee_to_waker # spotted on sm7125 and msm8996
[ -f /proc/sys/kernel/sched_boost_top_app ] && echo 1 > /proc/sys/kernel/sched_boost_top_app # spotted on sm7125
[ -f /proc/sys/kernel/sched_init_task_load ] && echo 30 > /proc/sys/kernel/sched_init_task_load # spotted on sm7125 and msm8996
[ -f /proc/sys/kernel/sched_migration_fixup ] && echo 0 > /proc/sys/kernel/sched_migration_fixup # spotted on sm7125
[ -f /proc/sys/kernel/sched_energy_aware ] && echo 0 > /proc/sys/kernel/sched_energy_aware # spotted on sm7125
[ -f /proc/sys/kernel/hung_task_timeout_secs ] && echo 0 > /proc/sys/kernel/hung_task_timeout_secs # spotted on sm7125 and msm8996 and sdm670 exynos9810
[ -f /proc/sys/kernel/sched_conservative_pl ] && echo 0 > /proc/sys/kernel/sched_conservative_pl # spotted on sm7125 and msm8996
[ -f /sys/kernel/debug/debug_enabled ] && echo 0 > /sys/kernel/debug/debug_enabled # spotted on msm8996 and sdm670 and sdm845
[ -f /sys/kernel/debug/msm_vidc/fw_debug_mode ] && echo 0 > /sys/kernel/debug/msm_vidc/fw_debug_mode # spotted on sm7125 and msm8996 and sdm670 and sdm845
[ -f /sys/module/cryptomgr/parameters/notests ] && echo Y > /sys/module/cryptomgr/parameters/notests # spotted on sm7125 and sdm670
[ -f /proc/sys/dev/tty/ldisc_autoload ] && echo 0 > /proc/sys/dev/tty/ldisc_autoload # spotted on sm7125 and sdm845 exynos9810
[ -f /sys/kernel/rcu_normal ] && echo 1 > /sys/kernel/rcu_normal # spotted on sm7125 and sdm670 and sdm845 exynos9819
[ -f /sys/kernel/rcu_expedited ] && echo 0 > /sys/kernel/rcu_expedited # spotted on sm7125 and msm8996 and sdm670 and sdm845 exynos9810
[ -f /sys/module/spurious/parameters/noirqdebug ] && echo 1 > /sys/module/spurious/parameters/noirqdebug # spotted on sm7125 and msm8996 and sdm670 and sdm845 exynos9810
