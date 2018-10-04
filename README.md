```
Name                    ips        average  deviation         median         99th %
control              8.26 M       0.121 μs   ±328.07%       0.110 μs        0.21 μs
in_memory_ets        1.50 M        0.66 μs   ±357.30%        0.60 μs           1 μs
fst                  0.37 M        2.69 μs   ±763.55%           3 μs           4 μs

Comparison:
control              8.26 M
in_memory_ets        1.50 M - 5.49x slower
fst                  0.37 M - 22.23x slower
```
