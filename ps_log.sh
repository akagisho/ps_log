#!/usr/bin/env bash

PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin
unalias -a

DATE=`date +"%Y%m%d"`
TIME=`date +"%Y%m%d_%H%M"`
DIR=$DATE
PID_FILE=ps_log.pid
LOG_GENERATION=${LOG_GENERATION:-14}

function ERROR_EXIT {
  echo $@ 1>&2
  exit 1
}

function CHECK_DUPLICATION {
  if [ -f $PID_FILE ]; then
    ps --pid `head -1 $PID_FILE` > /dev/null \
      && ERROR_EXIT "another process is running"
  fi

  echo $$ > $PID_FILE
}

function EXEC {
  local FILE=$DIR/$TIME.log
  echo "===== begin $@ =====" >> $FILE
  nice "$@" >> $FILE 2>&1
  echo "===== end $@ =====" >> $FILE
}

function LOG_ROTATE {
  local num=`ls | sort -n | grep -cE '^[0-9]{8}$'`
  if [ $num -gt $LOG_GENERATION ]; then
    local del=`expr $num - $LOG_GENERATION`
    for i in `ls | sort -n | grep -E '^[0-9]{8}$' | head -n $del`; do
      rm -rf $i
    done
  fi
}

mkdir -p $DIR

CHECK_DUPLICATION

EXEC df
EXEC ps -eflm
EXEC vmstat
EXEC netstat -an
EXEC iostat
EXEC top -b -n 1
EXEC free
EXEC w

LOG_ROTATE
