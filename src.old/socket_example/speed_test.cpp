#include <iostream>
#include <stdio.h>
#include <string.h>
#include "comms_control.hpp"
#include <chrono>

#define RUNS 1000

int main (int argc, char const *argv[])
{

    int times[RUNS];
    comms::initComms();
    for (size_t i = 0; i < RUNS; i++) {
        auto start = std::chrono::high_resolution_clock::now();
            comms::msgStruct msg = comms::getData();
        auto stop = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);

        times[i] = duration.count();
    }

    long long avg = 0;
    for (size_t i = 0; i < RUNS; i++)
        avg += times[i];
    avg /= RUNS;

    std::cout << "AVG TIME (μs): " << avg << '\n';

    return 0;
}
