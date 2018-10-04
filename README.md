```
Name                    ips        average  deviation         median         99th %
control            107.60 K        9.29 μs    ±60.97%           9 μs          14 μs
in_memory_ets        9.16 K      109.16 μs    ±29.93%         102 μs         221 μs
fst                  2.54 K      393.89 μs     ±8.11%         389 μs         512 μs

Comparison:
control            107.60 K
in_memory_ets        9.16 K - 11.75x slower
fst                  2.54 K - 42.38x slower
```
