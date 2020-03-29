# LTSpiceBenchmark
LTSpice XVII Performance Benchmark

How to Run
1. Download and install [LTSpice](https://www.analog.com/en/design-center/design-tools-and-calculators/ltspice-simulator.html) (Make sure to select x64 and use the defualt install location)
2. Dowload the [LTSpiceBenchmark](https://github.com/ericsims/LTSpiceBenchmark/archive/master.zip)
3. Unzip
4. Right click on benchmark.ps1 and select properties. At the bottom of the general tab, select unblock
5. Disable windows defender's real time protection (LTSpice write results to disk during simulation with many small writes. Windows Defender real time protection increases the latency of these writes an slows the benchmark down.)
6. Right click on bencmark.ps1 and select 'Run with PowerShell'
7. PowerShell may ask for confirmation to run a unsigned script, type Y and hit enter
8. The benchmark will run for 5-10mins
9. Once the script is done, press enter to exit,
10. Open the 'LTSpiceBenchmarkReport.txt' file to see your times and total.

Example from my system:
```
LTSpice Benchmark Report
ERIC-PC Sun Mar 29 01:51:58 MDT 2020

Name                                     NumberOfCores NumberOfEnabledCore NumberOfLogicalProcessors
----                                     ------------- ------------------- -------------------------
Intel(R) Xeon(R) CPU E5-2670 0 @ 2.60GHz             8                   8                        16
Intel(R) Xeon(R) CPU E5-2670 0 @ 2.60GHz             8                   8                        16


LTSpice avg startup time: 0.35287812 seconds

File                   ExecTime
----                   --------
.\DCopPnt.asc        0.35226618
.\LT3845_TA01.asc   23.94856118
.\BuckBoost.asc     28.65363998
.\MonteCarlo.asc     3.75842268
.\SettleTime.asc   108.95997988
.\Electrometer.asc 135.71078378


Total time: 301.38365368 seconds
```
