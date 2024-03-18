rm -r bigdatacoursera/hadoopdata/hdfs/datanode/*
rm -r bigdatacoursera/hadoopdata/hdfs/namenode/*
hadoop namenode -format
hadoop datanode -format
