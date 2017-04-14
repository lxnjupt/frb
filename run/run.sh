read_verilog ../src/top.v
read_verilog ../src/test_unit.v

exec echo "Starting Testing" >ts.log

foreach i {4} {
set_param general.maxThreads $i
exec echo "Starting with $i Thread" >>ts.log

set ts_start [exec date +%s]
synth_design -top top -part xcvu095-ffvc2104-2-i -generic SUB_MODULE=1999
set ts_end [exec date +%s]
set ts_int [exec expr $ts_end - $ts_start]
exec echo -n "synth_design time elapsed--------" >>ts.log
exec echo $ts_int >>ts.log



set ts_start [exec date +%s]
opt_design
set ts_end [exec date +%s]
set ts_int [exec expr $ts_end - $ts_start]
exec echo -n "opt_design time elapsed----------" >>ts.log
exec echo $ts_int >>ts.log



set ts_start [exec date +%s]
place_design
set ts_end [exec date +%s]
set ts_int [exec expr $ts_end - $ts_start]
exec echo -n "place_design time elapsed--------" >>ts.log
exec echo $ts_int >>ts.log


set ts_start [exec date +%s]
route_design
set ts_end [exec date +%s]
set ts_int [exec expr $ts_end - $ts_start]
exec echo -n "route_design time elapsed--------" >>ts.log
exec echo $ts_int >>ts.log
exec echo "   " >>ts.log
}

exit
