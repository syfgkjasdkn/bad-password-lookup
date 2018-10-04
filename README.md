One iteration = 500 lookups
```
Name                    ips        average  deviation         median         99th %
control            106.43 K        9.40 μs    ±83.05%           9 μs          14 μs
in_memory_ets        8.76 K      114.10 μs    ±72.85%         101 μs      360.88 μs
bloomex              3.99 K      250.47 μs     ±9.63%         246 μs      363.28 μs
fst                  2.08 K      480.08 μs   ±366.18%         383 μs     1667.14 μs

Comparison:
control            106.43 K
in_memory_ets        8.76 K - 12.14x slower
bloomex              3.99 K - 26.66x slower
fst                  2.08 K - 51.09x slower
```
