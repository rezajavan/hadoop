## Introduction to Big Data Course Repository

This repository is dedicated to materials related to the Introduction to Big Data course on Coursera.

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

1. **Create a New User:** 
```
sudo adduser hadoopuser
```
**Incorporating the `hadoopuser` name is crucial as certain configuration files rely on it.**

2. **Install SSH:** 
```
sudo apt install ssh
```
3. **Install Net-tools (Optional):** 
```
sudo apt install net-tools
```
**note: from step 4. to forward you have to be in the hadoopuser.**

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
L=$(pwd)
```
### Download and install hadoop

Download hadoop 

```
cd $L
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
```
then,
``` 
tar -xvf hadoop-3.3.6.tar.gz

```

**edit Bashrc:**
```
cd $L/etc
./editbashrc.sh
```
then,

```
source ~/.bashrc
```

**Configure HDFS:**
First we have to create directories for name node and data node.
```
mkdir -p $L/hadoopdata/hdfs/namenode
mkdir -p $L/hadoopdata/hdfs/datanode
```

merge configs:

```
cd $L/etc
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
**Sometimes the NameNode and DataNode fail to start up. If you encounter this issue, stop Hadoop using the method mentioned below.**

## Stop hadoop
**to stop hadoop** we should excute `stop-all.sh`, but I recommend first clean datanode and namenode by execute `./removedatnamenode.sh` placed @ `$L/etc`, next execute `stop-all.sh`.
```
./removedatnamenode.sh
```
```
stop-all.sh
```

# Course Practices
## Word Count Task
```
hdfs dfs -mkdir /test
hdfs dfs -put $L/etc/words.txt /test/
hadoop jar $L/etc/hadoop-mapreduce-examples-3.3.6.jar wordcount /test/words.txt /test/result1
hdfs dfs -ls /test/result1
hdfs dfs -cat /test/result1/part*
```
## exam 
Wordcount and wordmediation

1. **Prepare Data:**
   ```
   hdfs dfs -put $L/etc/11-0.txt /test
   ```
2. **Word Count:**
   ```
   hadoop jar $L/etc/hadoop-mapreduce-examples-3.3.6.jar wordcount /test/11-0.txt /test/result2
   ```
3. **Review the output and search for the specific word 'Cheshire' that we are interested in.** 
   ```
   hdfs dfs -cat /test/result2/part* | grep "Cheshire"
   ```
   **You will encounter instances of both 'Cheshire' and '"Cheshire' in the output. The number preceding 'Cheshire' indicates our success in passing the exam.**

4. **word median:**
   ```
   hdfs dfs -rm -r /test/result3
   hadoop jar $L/etc/hadoop-mapreduce-examples-3.3.6.jar wordmedian /test/11-0.txt /test/result3
   ```
If you encounter any issues or need further assistance, feel free to reach out.

Happy Hadooping!
   
