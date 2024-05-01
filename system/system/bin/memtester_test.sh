#!/system/bin/sh

#开始时间
timer_start=`date "+%Y-%m-%d %H:%M:%S"`
echo dd test Start $timer_start

STR_FRUIT="`cat /proc/meminfo`"
echo $STR_FRUIT | awk '{ print $5; }' > /data/memtester_mem_free
mem_free="`cat /data/memtester_mem_free`"
max_test_mem=$((mem_free*8/10))
echo max_test_mem=$max_test_mem
param=$1
test_mem=$2
if [ "$param" -ne "" -a "$test_mem" -eq "" ];then
	echo "$0:usage: [-b B]|[-k K/KB]|[-m M/MB]|[-g G/GB] space[]"
	exit 1  #退出码
fi
case ${param} in
	"")
		echo "Default test memory size 10M"
		test_mem=10M
		;;
	-b)
		test_mem_k=$((test_mem/1024))
		if [ "$test_mem_k" -gt "$max_test_mem" ];then
			test_mem="$max_test_mem"K
		else
			test_mem="$test_mem"B
		fi
		;;
	-k)
		if [ "$test_mem" -gt "$max_test_mem" ];then
			test_mem="$max_test_mem"K
		else
			test_mem="$test_mem"K
		fi
		;;
	-m) 
		test_mem_k=$((test_mem*1024))
		if [ "$test_mem_k" -gt "$max_test_mem" ];then
			test_mem=$((max_test_mem))K
		else
			test_mem="$test_mem"M
		fi
		;;
	-g) 
		test_mem_k=$((test_mem*1024*1024))
		if [ "$test_mem_k" -gt "$max_test_mem" ];then
			test_mem=$((max_test_mem))K
		else
			test_mem="$test_mem"G
		fi
		;;
	*) 
		echo "$0:usage: [-b B]|[-k K/KB]|[-m M/MB]|[-g G/GB] space[]"
		exit 1  #退出码
		;;
esac

memtester $test_mem 1 2>&1 | tee /sdcard/memtester_result.txt

rm -rf /data/memtester_mem_free

#结束时间
timer_end=`date "+%Y-%m-%d %H:%M:%S"`
#echo ">>>>>>>>>>>>>>>结束时间：$timer_end"
start_seconds=$(date -d"$timer_start" +%s);
end_seconds=$(date -d"$timer_end" +%s);
echo ""
echo "------------------------------本次运行时间：$((end_seconds-start_seconds))s------------------------------"
echo test done.
