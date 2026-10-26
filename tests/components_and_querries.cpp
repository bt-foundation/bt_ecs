#include <gtest/gtest.h>

#include "systems.hpp"
#include "types.hpp"

struct Schedule1 {};

struct Schedule2 {};

struct Component1 {
    int num = 0;
};

struct Component2 {
    bt::types::Vector<int> vec = {1, 2, 3, 4};
};

static void sys_read_component1(bt::ecs::Querry<Component1> comps) {
    for (const Component1& comp : comps) {
        // Do sth
    }
}

static void sys_read_write_component1(bt::ecs::QuerryMut<Component1> comps) {
    for (Component1& comp : comps) {
        comp.num = 1;
    }
}

static bt::ecs::EntityID s_Eid = -1;

static void sys_add_entity_empty(bt::ecs::World& world) {
    s_Eid = world.add_entity();
}

static void sys_attach_components(bt::ecs::World& world) {
    world.add_components(eid, (Component1 {}, Component2 {}));
}

TEST(ComponentsAndQuerries, ComponentReadAccess) {
    size_t num_workers = std::thread::hardware_concurrency();
    size_t max_systems_per_worker = 1024;

    bt::ecs::DefaultExecutor exec {num_workers, max_systems_per_worker};

    bt::ecs::World world {};

    // Schedule1 and Schedule2 will run in parallel
    exec.add_schedules<Schedule1, Schedule2>();

    // Add entity
    auto handle = exec.add_system<Schedule1>(sys_add_entity_empty);
    
    // Then add components
    handle.before(exec, sys_attach_components);

    // Querry components
    exec.add_system<Schedule1>(sys_read_component1)

    // Run all schedules with a world for storage
    exec.run(world);
}