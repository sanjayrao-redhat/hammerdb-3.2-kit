#!/bin/tclsh
#

puts "SETTING CONFIGURATION"

global complete
proc wait_to_complete {} {
global complete
set  complete [vucomplete]
if {!$complete} {after 5000  wait_to_complete} else { exit } 
}


dbset db mssqls
dbset bm TPC-C
diset connection mssqls_linux_server 127.0.0.1
diset connection mssqls_pass 100yard-
diset tpcc mssqls_driver timed
diset tpcc mssqls_count_ware 500
diset tpcc mssqls_num_vu 100
diset tpcc mssqls_rampup 1
diset tpcc mssqls_duration 15

loadscript
vuset vu 20
vurun
wait_to_complete
vwait forever
