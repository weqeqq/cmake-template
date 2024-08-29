#include <calculator/calculator.h>

Calculator::Calculator(const int32_t &lhs) : lhs_(lhs) {}

int Calculator::Multiply(const int32_t &rhs) { return lhs_ * rhs; }
int Calculator::Divide(const int32_t &rhs) { return lhs_ / rhs; }
