
#include <calculator/calculator.h>
#include <gtest/gtest.h>

TEST(Calculator, Multiply) { EXPECT_EQ(6, Calculator(3).Multiply(2)); }
TEST(Calculator, Divide) { EXPECT_EQ(2, Calculator(6).Divide(3)); }
