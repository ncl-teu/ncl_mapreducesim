# GW-モバイル環境でのMapReduceシミュレータ
Mapperをモバイル端末，ReducerをGW1台の端末した場合のMapReduceシミュレータです．

# 概要
- 特定のスケジューリングアルゴリズムと特定のmapper数でMap/Reduce処理を行います．
- Mapper数, 入力ファイルサイズ，InputSplitサイズ＋数(入力ファイルの分割したもの）, スケジューリングアルゴリズム等のパラメータを，configファイルにて設定します．
# 実行方法
- configファイルは`mr.properties`であり，システム全体とアプリの振る舞いを定義します． 
- **Build**: [Ant](https://dlcdn.apache.org//ant/binaries/apache-ant-1.9.16-bin.zip)を使ってビルドします．例えば，JDK/Antを設定済みであれば，コマンドラインから `ant build`してください．Antのインストールを行わずにbuildする場合は，[Ant](https://dlcdn.apache.org//ant/binaries/apache-ant-1.9.16-bin.zip)をDL+解凍後，ncl_mapreducesim-master/antというようにディレクトリ名をantへ変更した上で，`compile.bat`をダブルクリックしてください．
- **Run**: `MRRun.bat`をダブルクリックして実行してください．またはLinux系OSの場合は`./MRRun.sh`を実行してください．
- シミュレーション結果は`mr/mrlog.csv`に書き込まれます．ファイルフォーマットは↓です．
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

# APIについて
## 設定ファイルの内容
- [mr.properties](https://github.com/ncl-teu/ncl_mapreducesim/blob/mobile/mr.properties)を参照．
## 処理フロー
- Mainクラスは[MRTest.java](https://github.com/ncl-teu/ncl_mapreducesim/blob/mobile/src/net/gripps/cloud/mapreduce/main/MRTest.java)で，MRMgrクラスの起動を行います．
- [MRMgr.java](https://github.com/ncl-teu/ncl_mapreducesim/blob/mobile/src/net/gripps/cloud/mapreduce/MRMgr.java)が，全体の処理を制御しています．[プロビジョニングアルゴリズム](https://github.com/ncl-teu/ncl_mapreducesim/blob/mobile/src/net/gripps/cloud/mapreduce/MRMgr.java#L93)，[スケジューリングアルゴリズムの選択](https://github.com/ncl-teu/ncl_mapreducesim/blob/mobile/src/net/gripps/cloud/mapreduce/MRMgr.java#L87)，[システム環境](https://github.com/ncl-teu/ncl_mapreducesim/blob/mobile/src/net/gripps/cloud/mapreduce/MRMgr.java#L83)，また，大域的なデータも保持しているので，シミュレーションの実行時情報が欲しい場合はこのクラスへ問い合わせます．Singletonクラスのため，インスタンス生成せずに情報を取得します．
~~~
//環境情報を取得する例．MRMgrをインスタンス化せずに直接取得できる．
MRCloudEnvironment env = MRMgr.getIns().getEnv();
~~~
- 
## InputSplit（入力ファイルの分割部）を割り当てるアルゴリズムの作成方法
- 独自のスケジューリングアルゴリズムを作る方法を説明します．具体的には，InputSplitをどのMapperへ割り当てるか，というアルゴリズムです．
- mr.propertiesにおいて，下記の箇所を設定します．
~~~
# Schedulingアルゴリズムの総数(新たに追加するのであれば+1させる）
# Number of scheduling algorithms.
mr_algorithm_scheduling_num=1

# Schedulingアルゴリズムで，使うものを指定する．
# 0: Base 1:??? 2:???
mr_algorithm_scheduling_using=0
~~~
- [BaseMRScheduling.java](https://github.com/ncl-teu/ncl_mapreducesim/blob/mobile/src/net/gripps/cloud/mapreduce/scheduling/BaseMRScheduling.java)を継承したクラスを作る．
~~~
public NEWSchedulingAlgorithm extends BaseMRScheduling{
....
}
~~~
- [sendInputSplitsメソッド](https://github.com/ncl-teu/ncl_mapreducesim/blob/mobile/src/net/gripps/cloud/mapreduce/scheduling/BaseMRScheduling.java#L29)をオーバーライドさせる．具体的には[InputSplitの送信先決定部](https://github.com/ncl-teu/ncl_mapreducesim/blob/mobile/src/net/gripps/cloud/mapreduce/scheduling/BaseMRScheduling.java#L61)を新たに考える．

# Copyright

see [LICENSE](https://github.com/ncl-teu/ncl_mapreducesim/blob/mobile/LICENSE)

Copyright (c) 2019 Hidehiro Kanemitsu <kanemitsuh@stf.teu.ac.jp>
