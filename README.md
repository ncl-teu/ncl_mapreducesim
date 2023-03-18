# モバイル環境でのMapReduceシミュレータ
Mapperをモバイル端末，Reducerを1台の端末した場合のMapReduceシミュレータです．

# 概要
- MRSim runs a MapReduce procedures with the specific number of mappers/reducers and a specific scheduling/provisioning algorithm. 
- Those parameters (number of mappers/reducers, sizes of input data, InputSplits,scheduling algorithm, and provisioning algorithm) can be set the configuration file. Thus, you can test a MapReduce processes in various kinds of situations. 
# How to run
- The configuration file is `mr.properties`, that defines the whole system and application parameters. 
- **Build**: use ant and run `ant build`. 
- **Run**: Run `MRRun.bat` for Windows, or `./MRRun.sh` for Linux. 
- The result of written to mr/mrlog.csv. The log format is as follows: 
~~~
TIMESTAMP ,Type,Column1,Column2,Column3,Column4,Column5,Column6,Column7,Column8,
2020/07/25 13:23:22.625  ,1:DFS->Mapper[pal],mID,558^0^0^0^0,comTime,8000.0
...
2020/07/25 13:23:26.663  ,2:MapProcess,mID,558^0^0^0^0,Proc.Time,2.1333
...
2020/07/25 13:23:26.729  ,3:Part.+Seri.,mID,558^0^0^0^0,Time,23.8731
...
2020/07/25 13:23:26.889  ,4:SpillProc.,mID,558^0^0^0^0,time,12.80000000000001
...
2020/07/25 13:23:27.177  ,5:Merge Proc.,mID,558^0^0^0^0,time,15.600000000000014
...
2020/07/25 13:23:27.322  ,6':ShuffleSend_candidate[para]:,mID,39^0^0^0^0,rID,665^0^0^0^0,keyID,58,comTime,0.0
~~~

# Copyright

see [LICENSE](https://github.com/ncl-teu/ncl_mapreducesim/blob/master/LICENSE)

Copyright (c) 2019 Hidehiro Kanemitsu <kanemitsuh@stf.teu.ac.jp>
