#include <calculator/calculator.h>
#include <iostream>
#include <resources/resource_txt.h>

int main() {
  std::cout << "4 * 4 = " << Calculator(4).Multiply(4) << std::endl;
  std::cout << "4 / 2 = " << Calculator(4).Divide(2) << std::endl;
  std::cout << Resource::Data << std::endl;
  return 0;
}
