One iteration = 500 lookups
```
Name                          ips        average  deviation         median         99th %
control                  102.67 K        9.74 μs    ±25.78%        9.10 μs       17.40 μs
in_memory_ets              9.86 K      101.38 μs    ±15.01%         100 μs         163 μs
bloomex                    3.98 K      251.41 μs    ±11.18%         246 μs      374.91 μs
fst                        2.55 K      392.14 μs     ±7.99%         390 μs      501.89 μs
flower (rust bloom)        0.44 K     2264.26 μs    ±10.83%        2200 μs     3315.76 μs

Comparison:
control                  102.67 K
in_memory_ets              9.86 K - 10.41x slower
bloomex                    3.98 K - 25.81x slower
fst                        2.55 K - 40.26x slower
flower (rust bloom)        0.44 K - 232.48x slower
```
