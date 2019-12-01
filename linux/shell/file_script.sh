#!/bin/bash

begin=$(date +%s)
 
root_dir="E:\log"
 
if [ ! -d $root_dir ]; then
	mkdir -p $root_dir
fi
cd $root_dir
 
function create_dir()
{
 
	mkdir $1
}
 
count=100
rsnum=10
cishu=$(expr $count / $rsnum)
for ((i=0; i<$cishu;))
do
	start_num=$(expr $i \* $rsnum + 1)
	end_num=$(expr $rsnum \* \( $i + 1 \))
	echo "$start_num"
	echo "$end_num"

	for j in `seq $start_num $end_num`
	do
		create_dir $j &
	done
	wait
	i=$(expr $i + 1)
done
 
end=$(date +%s)
spend=$(expr $end - $begin)
echo "花费时间为$spend秒"
