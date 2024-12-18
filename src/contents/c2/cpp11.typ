= C++11 Multithreading

C++11 introduced native support for multithreading directly in the standard
library @williams2019c. This eliminated the previous reliance on
platform-specific threading libraries like pthread, offering a more portable and
standardized approach to parallel computing.

== Thread Management
The `<thread>` header has now become the pivot of C++11's multithreading
support. It provides a lightweight, platform-independent mechanism for creating
and managing threads:

```cpp
#include <thread>
#include <iostream>

void worker_function() {
    std::cout << "Thread is running" << std::endl;
}

int main() {
    std::thread t(worker_function);  // Create a thread
    t.join();  // Wait for the thread to complete
    return 0;
}
```

== Synchronization Primitives
C++11 introduced robust synchronization mechanisms:

1. Mutex Operations
```cpp
#include <mutex>

std::mutex mtx;  // Basic mutex
mtx.lock();     // Acquire lock
mtx.unlock();   // Release lock
```

2. Condition Variables
```cpp
#include <condition_variable>

std::condition_variable cv;  // Allows thread synchronization
std::mutex cv_mutex;
```

== Atomic Operations
The `<atomic>` header provides lock-free concurrency primitives:

```cpp
#include <atomic>

std::atomic<int> counter(0);  // Thread-safe integer
counter++;  // Atomic increment
```

== Future and Promise
C++11 introduced powerful asynchronous programming constructs:

```cpp
#include <future>

std::future<int> result = std::async(std::launch::async, []() {
    return 42;  // Compute something asynchronously
});
```

== Key Advantages
- Platform-independent threading
- Standard library support
- Type-safe synchronization
- Reduced dependency on platform-specific libraries
- Simplified concurrent programming model

The introduction of these features marked a pivotal moment in C++ development,
providing developers with powerful, standardized tools for concurrent and
parallel programming without resorting to platform-specific libraries like
pthread.
