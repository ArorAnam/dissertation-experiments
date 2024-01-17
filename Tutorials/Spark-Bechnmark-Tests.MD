[naman@densiflora .phoronix-test-suite]$ ph info spark



Phoronix Test Suite v10.8.4
Apache Spark 3.3

Run Identifier:              pts/spark-1.0.1
Profile Version:             1.0.1
Maintainer:                  Michael Larabel
Test Type:                   System
Software Type:               Application
License Type:                Free
Test Status:                 Verified
Supported Platforms:         Linux
Project Web-Site:            https://spark.apache.org/
Source Repository Location:  https://github.com/apache/spark
Estimated Run-Time:          920 Seconds
Estimated Install Time:      5 Seconds
Download Size:               570.91 MB
Environment Size:            2100 MB

Description: This is a benchmark of Apache Spark with its PySpark interface. Apache Spark is an open-source unified analytics engine for large-scale data processing and dealing with big data. This test profile benchmars the Apache Spark in a single-system configuration using spark-submit.   The test makes use of DIYBigData's pyspark-benchmark (https://github.com/DIYBigData/pyspark-benchmark/) for generating of test data and various Apache Spark operations.


OpenBenchmarking.org Test Profile: https://openbenchmarking.org/test/pts/spark-1.0.1

Test Installed:  Yes
Last Run:        Never
Install Time:    5 Seconds
Install Size:    624044 Bytes

Software Dependencies:
- Java
- Python

OpenBenchmarking.org Overview Metrics:

Row Count: 1000000 - Partitions: 100 - Calculate Pi Benchmark
[Performance Overview] Average Deviation Between Runs: 0.33% Sample Analysis Count: 418
    Comparison of 418 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 108 Seconds. Box plot of samples:
    [                             |----------------------------------------------*------------------######################!#####*###*----*-|  ]
                                                            10th Percentile: 340 ^                          60th Percentile: 82 ^
                                                                                                                75th Percentile: 62 ^
                                                                                                                  90th Percentile: 32.32 ^
[Run-Time Requirements] Average Run-Time: 14 Minutes
    Comparison of 218 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 628 Seconds. Box plot of samples:
    [   |-------------------------------*------------------------------------------##*########################!###########*#####*----*|       ]
                  10th Percentile: 2027 ^                      25th Percentile: 1151 ^
                                                                                                     60th Percentile: 417 ^
                                                                                                           75th Percentile: 289 ^
                                                                                                                90th Percentile: 202 ^

Row Count: 1000000 - Partitions: 100 - SHA-512 Benchmark Time
[Performance Overview] Average Deviation Between Runs: 1.02% Sample Analysis Count: 417
    Comparison of 417 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 3.68 Seconds. Box plot of samples:
    [                      |---------------------------*----------------###############!##############*--------*|                             ]
                                 10th Percentile: 5.88 ^                        75th Percentile: 2.71 ^
                                                                                         90th Percentile: 2.12 ^
[Run-Time Requirements] Average Run-Time: 15 Minutes
    Comparison of 217 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 628 Seconds. Box plot of samples:
    [-------------------------------------*-----------------------------------##*##############################!##########*######*---*|       ]
                    10th Percentile: 2032 ^               25th Percentile: 1274 ^
                                                                                                     60th Percentile: 417 ^
                                                                                                            75th Percentile: 291 ^
                                                                                                                90th Percentile: 205 ^

Row Count: 1000000 - Partitions: 100 - Inner Join Test Time
[Performance Overview] Average Deviation Between Runs: 2% Sample Analysis Count: 408
    Comparison of 408 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 2.06 Seconds. Box plot of samples:
    [                                              |------------------------------*--------------#########!#####*######*-----*                ]
                                                            10th Percentile: 3.48 ^       60th Percentile: 1.77 ^
                                                                                                 75th Percentile: 1.39 ^
                                                                                                       90th Percentile: 1.05 ^
[Run-Time Requirements] Average Run-Time: 15 Minutes
    Comparison of 210 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 646 Seconds. Box plot of samples:
    [----------------------------------*--------------------------------------#*##############################!#######*#########*----*|       ]
                 10th Percentile: 2100 ^                 25th Percentile: 1289 ^
                                                                                                 60th Percentile: 498 ^
                                                                                                           75th Percentile: 293 ^
                                                                                                                90th Percentile: 208 ^

Row Count: 1000000 - Partitions: 100 - Calculate Pi Benchmark Using Dataframe
[Performance Overview] Average Deviation Between Runs: 0.85% Sample Analysis Count: 407
    Comparison of 407 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 6.91 Seconds. Box plot of samples:
    [                             |------------------------------------------*------------------------#*#################!#####*##*--*|       ]
                                                      10th Percentile: 21.41 ^  25th Percentile: 12.89 ^
                                                                                                          60th Percentile: 5.2 ^
                                                                                                            75th Percentile: 4.18 ^
                                                                                                               90th Percentile: 3.25 ^
[Run-Time Requirements] Average Run-Time: 15 Minutes
    Comparison of 207 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 606 Seconds. Box plot of samples:
    [   |-------------------------------*------------------------------------#*################################!##########*#####*---*-|       ]
                  10th Percentile: 2027 ^               25th Percentile: 1274 ^
                                                                                                     60th Percentile: 417 ^
                                                                                                           75th Percentile: 291 ^
                                                                                                               90th Percentile: 208 ^

Row Count: 1000000 - Partitions: 100 - Repartition Test Time
[Performance Overview] Average Deviation Between Runs: 1.59% Sample Analysis Count: 407
    Comparison of 407 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 2.08 Seconds. Box plot of samples:
    [                                               |---------------*-------------------##*################!###*###*------*|                  ]
                                              10th Percentile: 4.46 ^25th Percentile: 3.2 ^
                                                                                         60th Percentile: 1.91 ^
                                                                                             75th Percentile: 1.66 ^
                                                                                                    90th Percentile: 1.27 ^
[Run-Time Requirements] Average Run-Time: 15 Minutes
    Comparison of 209 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 642 Seconds. Box plot of samples:
    [----------------------------------*--------------------------------------#*##############################!########*########*----*|       ]
                 10th Percentile: 2100 ^                 25th Percentile: 1289 ^
                                                                                                  60th Percentile: 480 ^
                                                                                                           75th Percentile: 293 ^
                                                                                                                90th Percentile: 205 ^

Row Count: 1000000 - Partitions: 100 - Broadcast Inner Join Test Time
[Performance Overview] Average Deviation Between Runs: 2.38% Sample Analysis Count: 404
    Comparison of 404 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 1.62 Seconds. Box plot of samples:
    [                                    |----------------*------------------------###########!#######*#######*------*-|                      ]
                                    10th Percentile: 2.86 ^                     60th Percentile: 1.39 ^
                                                                                        75th Percentile: 1.12 ^
                                                                                               90th Percentile: 0.88 ^
[Run-Time Requirements] Average Run-Time: 15 Minutes
    Comparison of 206 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 646 Seconds. Box plot of samples:
    [----------------------------------*--------------------------------------#*##############################!##########*#######*---*|       ]
                 10th Percentile: 2100 ^                 25th Percentile: 1289 ^
                                                                                                    60th Percentile: 438 ^
                                                                                                            75th Percentile: 291 ^
                                                                                                                90th Percentile: 205 ^

Row Count: 1000000 - Partitions: 100 - Group By Test Time
[Performance Overview] Average Deviation Between Runs: 1.01% Sample Analysis Count: 392
    Comparison of 392 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 4.19 Seconds. Box plot of samples:
    [                       |--------------------------------------*-----------##############!######*########*---*-|                          ]
                                      10th Percentile: 6.479692439 ^          60th Percentile: 3.69 ^
                                                                                       75th Percentile: 2.92 ^
                                                                                           90th Percentile: 2.56 ^
[Run-Time Requirements] Average Run-Time: 15 Minutes
    Comparison of 194 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 606 Seconds. Box plot of samples:
    [            |----------------------------------*------------------------------------##*#######################!########*######---*|      ]
                              10th Percentile: 2032 ^                25th Percentile: 1170 ^
                                                                                                       60th Percentile: 424 ^
                                                                                                                 90th Percentile: 202 ^

Row Count: 1000000 - Partitions: 2000 - Calculate Pi Benchmark
[Performance Overview] Average Deviation Between Runs: 0.32% Sample Analysis Count: 257
    Comparison of 257 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 124 Seconds. Box plot of samples:
    [                                                                            |--------------------------------*--------#########!###*##*-*]
                                                                                             10th Percentile: 379 ^ 60th Percentile: 85 ^
                                                                                                                    75th Percentile: 55.89 ^
                                                                                                                      90th Percentile: 23.81 ^
[Run-Time Requirements] Average Run-Time: 13 Minutes
    Comparison of 143 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 667 Seconds. Box plot of samples:
    [|-------------------------------------*--------------------------#*########################!#####*###############*---------*-|           ]
                     10th Percentile: 1442 ^     25th Percentile: 1035 ^
                                                                                 60th Percentile: 589 ^
                                                                                                 75th Percentile: 357 ^
                                                                                                           90th Percentile: 223 ^

Row Count: 1000000 - Partitions: 2000 - SHA-512 Benchmark Time
[Performance Overview] Average Deviation Between Runs: 1.01% Sample Analysis Count: 257
    Comparison of 257 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 4.99 Seconds. Box plot of samples:
    [                                                                                                   |-------------*----####!##-----|      ]
                                                                                                10th Percentile: 8.09 ^
[Run-Time Requirements] Average Run-Time: 13 Minutes
    Comparison of 143 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 667 Seconds. Box plot of samples:
    [|-------------------------------------*--------------------------#*########################!#####*###############*---------*-|           ]
                     10th Percentile: 1442 ^     25th Percentile: 1035 ^
                                                                                 60th Percentile: 589 ^
                                                                                                 75th Percentile: 357 ^
                                                                                                           90th Percentile: 223 ^

Row Count: 1000000 - Partitions: 2000 - Calculate Pi Benchmark Using Dataframe
[Performance Overview] Average Deviation Between Runs: 0.94% Sample Analysis Count: 252
    Comparison of 252 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 8.29 Seconds. Box plot of samples:
    [                                                                       |---------------------------*------------###########!#####*##*|   ]
                                                                                 10th Percentile: 22.66 ^       60th Percentile: 5.55 ^
                                                                                                                   75th Percentile: 3.65 ^
[Run-Time Requirements] Average Run-Time: 13 Minutes
    Comparison of 138 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 649 Seconds. Box plot of samples:
    [|-------------------------------------*--------------------------#*#########################!####*################*--------*-|           ]
                     10th Percentile: 1442 ^     25th Percentile: 1035 ^
                                                                                 60th Percentile: 584 ^
                                                                                                  75th Percentile: 348 ^
                                                                                                           90th Percentile: 223 ^

Row Count: 1000000 - Partitions: 2000 - Repartition Test Time
[Performance Overview] Average Deviation Between Runs: 1.6% Sample Analysis Count: 246
    Comparison of 246 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 3.27 Seconds. Box plot of samples:
    [              |-------------------------------------------------------*--------------------##*##########!####*###*------*-|              ]
                                                     10th Percentile: 6.66 ^25th Percentile: 4.47 ^
                                                                                            60th Percentile: 2.87 ^
                                                                                                75th Percentile: 2.46 ^
                                                                                                       90th Percentile: 1.79 ^
[Run-Time Requirements] Average Run-Time: 13 Minutes
    Comparison of 137 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 649 Seconds. Box plot of samples:
    [|-------------------------------------*--------------------------#*#########################!####*###############*---------*-|           ]
                     10th Percentile: 1442 ^     25th Percentile: 1035 ^
                                                                                 60th Percentile: 584 ^
                                                                                                 75th Percentile: 357 ^
                                                                                                           90th Percentile: 223 ^

Row Count: 1000000 - Partitions: 2000 - Group By Test Time
[Performance Overview] Average Deviation Between Runs: 1.1% Sample Analysis Count: 246
    Comparison of 246 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 6.12 Seconds. Box plot of samples:
    [  |----------------------------------------------------------------*------------##########!##*######*--------*----|                      ]
                                                  10th Percentile: 9.26 ^   60th Percentile: 5.77 ^
                                                                                   75th Percentile: 4.93 ^
                                                                                            90th Percentile: 3.81 ^
[Run-Time Requirements] Average Run-Time: 13 Minutes
    Comparison of 137 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 649 Seconds. Box plot of samples:
    [|-------------------------------------*--------------------------#*#########################!####*###############*---------*-|           ]
                     10th Percentile: 1442 ^     25th Percentile: 1035 ^
                                                                                 60th Percentile: 584 ^
                                                                                                 75th Percentile: 357 ^
                                                                                                           90th Percentile: 223 ^

Row Count: 1000000 - Partitions: 2000 - Broadcast Inner Join Test Time
[Performance Overview] Average Deviation Between Runs: 3.05% Sample Analysis Count: 234
    Comparison of 234 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 2.72 Seconds. Box plot of samples:
    [      |----------------------------------------*-----------------------#####################!####*#####*--------*---|                    ]
                              10th Percentile: 5.55 ^                           60th Percentile: 2.49 ^
                                                                                      75th Percentile: 2.15 ^
                                                                                               90th Percentile: 1.58 ^
[Run-Time Requirements] Average Run-Time: 13 Minutes
    Comparison of 127 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 620 Seconds. Box plot of samples:
    [             |------------------------*--------------------------#*###########################!#####*#############*--------*-|           ]
                     10th Percentile: 1442 ^     25th Percentile: 1034 ^
                                                                                    60th Percentile: 553 ^
                                                                                                  75th Percentile: 339 ^
                                                                                                           90th Percentile: 222 ^

Row Count: 1000000 - Partitions: 2000 - Inner Join Test Time
[Performance Overview] Average Deviation Between Runs: 1.98% Sample Analysis Count: 234
    Comparison of 234 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 3.49 Seconds. Box plot of samples:
    [            |-----------------------------------------------------*-----------------------#*##########!###*###*------*----|              ]
                                                 10th Percentile: 7.17 ^  25th Percentile: 4.67 ^
                                                                                          60th Percentile: 3.2 ^
                                                                                             75th Percentile: 2.79 ^
                                                                                                    90th Percentile: 2.05 ^
[Run-Time Requirements] Average Run-Time: 13 Minutes
    Comparison of 127 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 620 Seconds. Box plot of samples:
    [             |------------------------*--------------------------#*###########################!#####*#############*--------*-|           ]
                     10th Percentile: 1442 ^     25th Percentile: 1034 ^
                                                                                    60th Percentile: 553 ^
                                                                                                  75th Percentile: 339 ^
                                                                                                           90th Percentile: 222 ^

Row Count: 1000000 - Partitions: 500 - Calculate Pi Benchmark Using Dataframe
[Performance Overview] Average Deviation Between Runs: 0.86% Sample Analysis Count: 206
    Comparison of 206 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 7.61 Seconds. Box plot of samples:
    [                                                            |-----------------------------------*----------------###########!####*##*|   ]
                                                                              10th Percentile: 24.51 ^          60th Percentile: 5.55 ^
                                                                                                                   75th Percentile: 3.49 ^
[Run-Time Requirements] Average Run-Time: 14 Minutes
    Comparison of 100 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 608 Seconds. Box plot of samples:
    [         |-----------------------------------------*--------------------------##*#######################!###*###########*-----*|         ]
                                  10th Percentile: 1625 ^      25th Percentile: 1086 ^
                                                                                            60th Percentile: 556 ^
                                                                                                        75th Percentile: 333 ^
                                                                                                              90th Percentile: 217 ^

Row Count: 1000000 - Partitions: 500 - Calculate Pi Benchmark
[Performance Overview] Average Deviation Between Runs: 0.24% Sample Analysis Count: 206
    Comparison of 206 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 124 Seconds. Box plot of samples:
    [                                                                         |----------------------------------*----------########!###*##*-*]
                                                                                            10th Percentile: 381 ^  60th Percentile: 85 ^
                                                                                                                 75th Percentile: 56.41292 ^
                                                                                                                   90th Percentile: 32.00732 ^
[Run-Time Requirements] Average Run-Time: 14 Minutes
    Comparison of 100 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 608 Seconds. Box plot of samples:
    [         |-----------------------------------------*--------------------------##*#######################!###*###########*-----*|         ]
                                  10th Percentile: 1625 ^      25th Percentile: 1086 ^
                                                                                            60th Percentile: 556 ^
                                                                                                        75th Percentile: 333 ^
                                                                                                              90th Percentile: 217 ^

Row Count: 40000000 - Partitions: 100 - Calculate Pi Benchmark
[Performance Overview] Average Deviation Between Runs: 0.27% Sample Analysis Count: 204
    Comparison of 204 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 93.62 Seconds. Box plot of samples:
    [                                   |---------------------------------------------*-----------------######################!##*###*---*-|  ]
                                                                 10th Percentile: 329 ^                      60th Percentile: 82 ^
                                                                                                              75th Percentile: 54.84 ^
                                                                                                               90th Percentile: 31.80834 ^
[Run-Time Requirements] Average Run-Time: 20 Minutes
    Comparison of 112 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 1068 Seconds. Box plot of samples:
    [  |--------------------------------------*------------------------#*#######################!###############*######*----*--|              ]
                        10th Percentile: 2253 ^   25th Percentile: 1638 ^
                                                                                           60th Percentile: 709 ^
                                                                                                  75th Percentile: 552 ^
                                                                                                       90th Percentile: 443 ^

Row Count: 40000000 - Partitions: 100 - SHA-512 Benchmark Time
[Performance Overview] Average Deviation Between Runs: 0.65% Sample Analysis Count: 204
    Comparison of 204 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 47.38 Seconds. Box plot of samples:
    [                          |----------------------*--------------------------##*#############!#####*#######*-------*-----|                ]
                                  10th Percentile: 94 ^        25th Percentile: 64 ^
                                                                                 60th Percentile: 42.4 ^
                                                                                        75th Percentile: 33.94 ^
                                                                                                90th Percentile: 25.05 ^
[Run-Time Requirements] Average Run-Time: 20 Minutes
    Comparison of 112 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 1068 Seconds. Box plot of samples:
    [  |--------------------------------------*------------------------#*#######################!###############*######*----*--|              ]
                        10th Percentile: 2253 ^   25th Percentile: 1638 ^
                                                                                           60th Percentile: 709 ^
                                                                                                  75th Percentile: 552 ^
                                                                                                       90th Percentile: 443 ^

Row Count: 1000000 - Partitions: 500 - SHA-512 Benchmark Time
[Performance Overview] Average Deviation Between Runs: 0.8% Sample Analysis Count: 204
    Comparison of 204 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 4.32 Seconds. Box plot of samples:
    [                                                                                                 |--------------*---#####!####---|       ]
                                                                                               10th Percentile: 6.96 ^
[Run-Time Requirements] Average Run-Time: 14 Minutes
    Comparison of 98 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 653 Seconds. Box plot of samples:
    [         |-----------------------------------------*--------------------------##*#####################!#####*###########*-----*-|        ]
                                  10th Percentile: 1625 ^      25th Percentile: 1086 ^
                                                                                            60th Percentile: 568 ^
                                                                                                        75th Percentile: 333 ^
                                                                                                              90th Percentile: 217 ^

Row Count: 40000000 - Partitions: 100 - Calculate Pi Benchmark Using Dataframe
[Performance Overview] Average Deviation Between Runs: 1% Sample Analysis Count: 201
    Comparison of 201 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 6.11 Seconds. Box plot of samples:
    [                                  |-----------------------*------------------------------##*#######################!###*#####*-*|        ]
                                        10th Percentile: 21.73 ^         25th Percentile: 12.86 ^
                                                                                                      60th Percentile: 5.09 ^
                                                                                                            75th Percentile: 3.63 ^
                                                                                                              90th Percentile: 2.86 ^
[Run-Time Requirements] Average Run-Time: 20 Minutes
    Comparison of 109 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 1068 Seconds. Box plot of samples:
    [  |--------------------------------------*--------------------------#*#####################!#############*########*----*--|              ]
                        10th Percentile: 2253 ^     25th Percentile: 1593 ^
                                                                                         60th Percentile: 758 ^
                                                                                                  75th Percentile: 562 ^
                                                                                                       90th Percentile: 443 ^

Row Count: 40000000 - Partitions: 2000 - SHA-512 Benchmark Time
[Performance Overview] Average Deviation Between Runs: 0.76% Sample Analysis Count: 197
    Comparison of 197 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 45.25 Seconds. Box plot of samples:
    [      |----------------------------------------------------*---------------------#*###############!####*######*------*----|              ]
                                            10th Percentile: 92 ^  25th Percentile: 65 ^
                                                                                     60th Percentile: 40.33 ^
                                                                                            75th Percentile: 32.67 ^
                                                                                                   90th Percentile: 24.28 ^
[Run-Time Requirements] Average Run-Time: 24 Minutes
    Comparison of 109 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 1157 Seconds. Box plot of samples:
    [          |-------------------------------*------------------------##*###########################!###*################*---*-|            ]
                         10th Percentile: 2762 ^    25th Percentile: 1995 ^
                                                                                    60th Percentile: 1058 ^
                                                                                                      75th Percentile: 563 ^
                                                                                                          90th Percentile: 467 ^

Row Count: 40000000 - Partitions: 2000 - Calculate Pi Benchmark
[Performance Overview] Average Deviation Between Runs: 0.3% Sample Analysis Count: 197
    Comparison of 197 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 98.62 Seconds. Box plot of samples:
    [                                   |---------------------------------------------*-----------------#####################!###*###*---*-|  ]
                                                                 10th Percentile: 331 ^                      60th Percentile: 82 ^
                                                                                                           75th Percentile: 56.00128 ^
                                                                                                                  90th Percentile: 32.23 ^
[Run-Time Requirements] Average Run-Time: 24 Minutes
    Comparison of 109 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 1157 Seconds. Box plot of samples:
    [          |-------------------------------*------------------------##*###########################!###*################*---*-|            ]
                         10th Percentile: 2762 ^    25th Percentile: 1995 ^
                                                                                    60th Percentile: 1058 ^
                                                                                                      75th Percentile: 563 ^
                                                                                                          90th Percentile: 467 ^

Row Count: 40000000 - Partitions: 2000 - Calculate Pi Benchmark Using Dataframe
[Performance Overview] Average Deviation Between Runs: 0.97% Sample Analysis Count: 196
    Comparison of 196 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 6.86 Seconds. Box plot of samples:
    [       |------------------------------------------------------*-----------------------------#*###################!######*####*-*-|       ]
                                            10th Percentile: 22.07 ^       25th Percentile: 12.96 ^
                                                                                                       60th Percentile: 5.26 ^
                                                                                                            75th Percentile: 3.67 ^
                                                                                                              90th Percentile: 3.07 ^
[Run-Time Requirements] Average Run-Time: 24 Minutes
    Comparison of 108 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 1164 Seconds. Box plot of samples:
    [          |-------------------------------*------------------------##*###########################!###*################*---*-|            ]
                         10th Percentile: 2762 ^    25th Percentile: 1995 ^
                                                                                    60th Percentile: 1061 ^
                                                                                                      75th Percentile: 563 ^
                                                                                                          90th Percentile: 467 ^

Row Count: 1000000 - Partitions: 500 - Repartition Test Time
[Performance Overview] Average Deviation Between Runs: 1.59% Sample Analysis Count: 194
    Comparison of 194 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 2.36 Seconds. Box plot of samples:
    [      |------------------------------------------------------------*-----------------------#*##############!####*#*-----*--|             ]
                                                   10th Percentile: 5.5 ^  25th Percentile: 3.56 ^
                                                                                               60th Percentile: 2.02 ^
                                                                                                 75th Percentile: 1.87 ^
                                                                                                       90th Percentile: 1.36 ^
[Run-Time Requirements] Average Run-Time: 13 Minutes
    Comparison of 97 OpenBenchmarking.org samples since 4 August 2022 to 11 December; median result: 607 Seconds. Box plot of samples:
    [         |--------------------------------------------*---------------------------##*####################!#######*#######*----*-|        ]
                                     10th Percentile: 1572 ^       25th Percentile: 1015 ^
                                                                                                 60th Percentile: 465 ^
                                                                                                         75th Percentile: 326 ^
                                                                                                              90th Percentile: 216 ^

Test Profile Change History:
v1.0.1 - 20 January 2023
Update download mirror for Spark 3.3.0. Closes: https://github.com/phoronix-test-suite/test-profiles/issues/265
v1.0.0 - 4 August 2022
Initial commit of Apache Spark benchmark.

Results Containing This Test
spark6         spark_6
sparkestrun5   spark_est_run_5
sparkfirstrun  spark_first_run
sparkrun7      sparK_run_7
sparkrun8      spark_run_8
sparksecondrun spark_second_run
sparktestrun3  spark_test_run_3
sparktestrun4  spark_test_run_4

    [8192] strpos(): Passing null to parameter #1 ($haystack) of type string is deprecated in phodevi_parser:35

    [8192] strpos(): Passing null to parameter #1 ($haystack) of type string is deprecated in phodevi_parser:35

    [8192] strpos(): Passing null to parameter #1 ($haystack) of type string is deprecated in phodevi_parser:35

Test Suites Containing This Test
pts/server Server