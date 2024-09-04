#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <calculator/export.h>
#include <cstdint>

class CALCULATOR_EXPORT Calculator {
public:
  Calculator(const int32_t &lhs);

  int Multiply(const int32_t &rhs);
  int Divide(const int32_t &rhs);

private:
  int32_t lhs_;
};

#endif
