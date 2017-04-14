for i in 1 
do
vivado -mode tcl -source run.sh
#touch ts.og
mv ts.log ts.log$i
done
