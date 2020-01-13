#!/bin/sh
buss_no_cur=$1
buss_no_cur_1=$1.csv
user=$2
passwd=$3
sid=$4
filename=${HOME}/${buss_no_cur_1}
sqlplus -s ${user}/${passwd}@${sid}<<EOF
set echo off;
set wrap off;
set feedback off;
set heading off;
set pagesize 0;
set linesize 4096;
set numwidth 50;
set verify off;
set term off;
set trimout on;
set trimspool on;
spool $filename;
select buss_no||','||card_no||','||sign_no from alipay_sign where buss_no=$buss_no_cur;
spool off;
EOF