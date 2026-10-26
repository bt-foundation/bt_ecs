#include <gtest/gtest.h>

#include "systems.hpp"

struct Schedule1 {};

struct Schedule2 {};

static void sys1() {}

static void sys2() {}

static void sys3() {}

static void sys4() {}

TEST(SystemsAndSchedules, ParallelSystems) {
    size_t num_workers = std::thread::hardware_concurrency();
    size_t max_systems_per_worker = 1024;

    bt::ecs::DefaultExecutor exec {num_workers, max_systems_per_worker};

    // Schedule1 will run before Schedule2
    exec.add_schedules<Schedule1, Schedule2>();

    // Add a function to be ran in Schedule1
    bt::ecs::SystemHandle handle = exec.add_system<Schedule1>(sys1);

    // The function that handle points to will run in parallel with the provided function inside the same schedule
    handle.with(exec, sys2);

    // Add two functions that run in parallel in Schedule2
    std::tuple < bt::ecs::SystemHandle, bt::ecs::SystemHandle> handles =
        exec.add_systems<Schedule2>(sys3, sys4);
    // Run all schedules
    exec.run();
}

TEST(SystemsAndSchedules, ParallelSystemsAndSchedules) {
    size_t num_workers = std::thread::hardware_concurrency();
    size_t max_systems_per_worker = 1024;

    bt::ecs::DefaultExecutor exec {num_workers, max_systems_per_worker};

    // Schedule1 and Schedule2 will run in parallel
    exec.add_schedules<bt::ecs::Par<Schedule1, Schedule2>>();

    // Add a function to be ran in Schedule1
    bt::ecs::SystemHandle handle_sys1 = exec.add_system<Schedule1>(sys1);

    // The function that handle points to will run in parallel with the provided function inside the same schedule
    bt::ecs::SystemHandle handle_sys2 = handle_sys1.with(exec, sys2);

    // Add two functions that run in parallel in Schedule2
    std::tuple<bt::ecs::SystemHandle, bt::ecs::SystemHandle> handles =
        exec.add_systems<Schedule2>(sys3, sys4);
    // Run all schedules
    exec.run();
}

static int s_TestPriority = 0;

static void test_priority_1() {
    s_TestPriority = 1;
}

static void test_before_2() {
    s_TestPriority = 2;
}

TEST(SystemsAndSchedules, SystemBefore) {
    s_TestPriority = 0;

    size_t num_workers = std::thread::hardware_concurrency();
    size_t max_systems_per_worker = 1024;

    bt::ecs::DefaultExecutor exec {num_workers, max_systems_per_worker};

    // Schedule1 and Schedule2 will run in parallel
    exec.add_schedules<Schedule1>();

    // Add a function to be ran in Schedule1
    bt::ecs::SystemHandle handle = exec.add_system<Schedule1>(test_before_1);

    // The function that handle points to will run before the provided function inside the same schedule
    handle.before(exec, test_before_2);

    // Run all schedules
    exec.run();

    // Wait for all schedules to finish
    exec.wait_all();

    EXPECT_EQ(test_before, 2);
}

TEST(SystemsAndSchedules, SystemAfter) {
    s_TestPriority = 0;

    size_t num_workers = std::thread::hardware_concurrency();
    size_t max_systems_per_worker = 1024;

    bt::ecs::DefaultExecutor exec {num_workers, max_systems_per_worker};

    // Schedule1 and Schedule2 will run in parallel
    exec.add_schedules<Schedule1>();

    // Add a function to be ran in Schedule1
    bt::ecs::SystemHandle handle = exec.add_system<Schedule1>(test_before_1);

    // The function that handle points to will run after the provided function inside the same schedule
    handle.after(exec, test_before_2);

    // Run all schedules
    exec.run();

    // Wait for all schedules to finish
    exec.wait_all();

    EXPECT_EQ(test_before, 1);
}