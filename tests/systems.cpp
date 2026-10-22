#include <gtest/gtest.h>

#include "systems.hpp"

// Demonstrate some basic assertions.
TEST(HelloTest, BasicAssertions) {
    // Expect two strings not to be equal.
    EXPECT_STRNE("hello", "world");
    // Expect equality.
    EXPECT_EQ(7 * 6, 42);

    EXPECT_NO_THROW({ bt::ecs::example_fun(0); });
}