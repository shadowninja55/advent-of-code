#include <bitset>
#include <fstream>
#include <iostream>
#include <numeric>
#include <sstream>
#include <vector>

int main() {
  std::ifstream input("input.txt");
  std::vector<std::string> lines;
  for (std::string line; getline(input, line); ) 
    lines.push_back(line);
  std::vector<int> copies(lines.size(), 1);

  int part_one = 0;
  for (int i = 1; i <= lines.size(); i++) {
    std::string line = lines[i - 1];
    std::string numbers = line.substr(line.find(":") + 2);
    int middle = numbers.find("|");
    std::istringstream left(numbers.substr(0, middle - 1));
    std::istringstream right(numbers.substr(middle + 2)); 

    std::bitset<100> wins, have;
    int num;
    while (left >> num) wins.set(num);
    while (right >> num) have.set(num);

    int n = (wins & have).count();
    part_one += n ? 1 << (n - 1) : 0;
    for (int j = i; j < i + n; j++)
      copies[j] += copies[i - 1];
  }

  std::cout << part_one << std::endl;
  std::cout << std::accumulate(copies.begin(), copies.end(), 0) << std::endl;
}
