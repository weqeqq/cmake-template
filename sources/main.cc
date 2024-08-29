#include <calculator/calculator.h>
#include <iostream>

int main() {
  std::cout << "4 * 4 = " << Calculator(4).Multiply(4) << std::endl;
  std::cout << "4 / 2 = " << Calculator(4).Divide(2) << std::endl;
  return 0;
}
