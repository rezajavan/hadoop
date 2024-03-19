rm -r $PWD/hadoopdata/hdfs/datanode/*
rm -r $PWD/hadoopdata/hdfs/namenode/*
hadoop namenode -format
hadoop datanode -format
