## Introduction to Big Data Course Repository

This repository is dedicated to materials related to the Introduction to Big Data course on Coursera. [Link to the course.]

### Course Overview

In this course, one of the key tasks is implementing a Word Count MapReduce program to pass the exam. While the course recommends downloading VirtualBox and Cloudera, totaling around 4 GB in size, I opted for a more hands-on approach by installing Hadoop directly. This decision not only reduced the overall installation size to approximately 1.5 GB but also provided a deeper engagement with Hadoop and HDFS, enhancing the learning experience. However, download VM and Cloudera is simpler than we're gonna do.



### Install JDK
Install JDK
```
sudo apt install openjdk-11-jdk
java -version
```

(Also we can install an isolated JDK... but it's global.)



### Setup Instructions

1. **Create a New User:** `sudo adduser hadoopuser`.
2. **Install SSH:** `sudo apt install ssh`
3. **Install Net-tools (Optional):** `sudo apt install net-tools`
`note: from step 4. to forward you have to be in the hadoopuser.` 
4. **Generate SSH Keys:** 
Loggin to hadoopuser:
   ```
   sudo -iu hadoopuser
   ```
   ```
   cd
   ssh-keygen -t rsa
   cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
   chmod 640 ~/.ssh/authorized_keys
   ```

### clone this repository 
```
git clone "https://github.com/rezajavan/hadoop.git"
cd hadoop
```
We need the file address
```
PWD=$(pwd)
```
### Download and install hadoop

Download hadoop 

```
cd PWD
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
```
then,
``` 
tar -xvf hadoop-3.3.6.tar.gz

```

**Update Bashrc: Open ~/.bashrc and append the following lines:**
```
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

export HADOOP_HOME=$HOME/bigdatacoursera/hadoop-3.3.6  # note: this directory is different for you which is: $PWD/hadoop-3.3.6 (Execute ` echo $PWD` to see the address)
export HADOOP_INSTALL=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
```
then,
```
source ~/.bashrc
```

**Configure HDFS:**
First we have to create directories for name node and data node.
```
mkdir $PWD/hadoopdata/hdfs/namenode
mkdir $PWD/hadoopdata/hdfs/datanode
```
Next we should change some files.
first:
```
nano $HADOOP_HOME/etc/hadoop/hdfs-site.xml
```

Add the following configuration:

```
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:///home/hadoopuser/bigdatacoursera/hadoopdata/hdfs/namenode</value> # like above, the address is different for you, address is $PWD/hadoopdata/hdfs/namenode
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>file:///home/hadoopuser/bigdatacoursera/hadoopdata/hdfs/datanode</value> #$PWD/hadoopdata/hdfs/datanode
    </property>
</configuration>
```
merge remain configs:

```
cd $PWD/etc
./merge.sh
```

**Start Hadoop Services:**
```
start-all.sh
```
Ensure all required nodes are running: NodeManager, DataNode, NameNode, ResourceManager, SecondaryNameNode. 

```
jps
```
# Course Practices
## Word Count Task
```
hdfs dfs -mkdir /test
hdfs dfs -put $PWD/etc/words.txt /test/
hadoop jar $PWD/etc/hadoop-mapreduce-examples-3.3.6.jar wordcount /test/words.txt /test/result1
hdfs dfs -ls /test/result
hdfs dfs -cat /test/result/part*
```
## exam 
Wordcount and wordmediation

1. **Prepare Data:**
   ```
   hdfs dfs -put $PWD/etc/11-0.txt /test
   ```
2. **Word Count:**
   ```
   hadoop jar $PWD/etc/hadoop-mapreduce-examples-3.3.6.jar wordcount /test/11-0.txt /test/result2
   ```
3. **Review the output and search for the specific word 'Cheshire' that we are interested in.** 
   ```
   hdfs dfs -cat /test/resul2/part* | grep "Cheshire"
   ```
4. **word median:**
   ```
   hadoop jar $PWD/etc/hadoop-mapreduce-examples-3.3.6.jar wordmedian /test/11-0.txt /test/result2
   ```
If you encounter any issues or need further assistance, feel free to reach out.

Happy Hadooping!
   
