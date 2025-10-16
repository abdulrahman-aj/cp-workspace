#include <memory.h>
#include <string.h>
#include <unistd.h>

#include <algorithm>
#include <array>
#include <bitset>
#include <cassert>
#include <cctype>
#include <chrono>
#include <climits>
#include <cmath>
#include <complex>
#include <cstdio>
#include <cstdlib>
#include <ctime>
#include <fstream>
#include <functional>
#include <iomanip>
#include <iostream>
#include <list>
#include <map>
#include <memory>
#include <numeric>
#include <optional>
#include <queue>
#include <random>
#include <ranges>
#include <set>
#include <stack>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

#ifdef __cpp_lib_ranges
#include <ranges>
#endif

#include <sys/resource.h>

class StackInitializer {
public:
  StackInitializer() {
    const rlim_t val = 268435456;
    struct rlimit lim = {.rlim_cur = val, .rlim_max = val};
    if (setrlimit(RLIMIT_STACK, &lim)) {
      std::cerr << "ERROR!\n";
    }
  }

  ~StackInitializer() {}
};

class Timer {
public:
  Timer() { _startTime = std::chrono::system_clock::now(); }

  ~Timer() {
    auto _endTime = std::chrono::system_clock::now();
    auto ms = std::chrono::duration_cast<std::chrono::milliseconds>(_endTime -
                                                                    _startTime)
                  .count();
    std::cerr << "\033[1;31mTime elapsed:\033[0m \033[1;33m" << ms / 1000.0
              << "s.\033[0m\n";
  }

private:
  std::chrono::time_point<std::chrono::system_clock> _startTime;
};

StackInitializer __s;
Timer __t;
