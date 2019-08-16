#!/bin/bash
[[ $DEBUG ]] && set -x

if [ ! -f ${MM_HOME}/conf/template.conf ];then
cp -a ${MM_HOME}/mm-wiki.conf.template ${MM_HOME}/conf/template.conf
fi

if [ ! -f ${MM_HOME}/conf/inited ];then
nohup ./install/install > ${MM_HOME}/conf/inited 2>&1 &
fi
[[ $PAUSE ]] && sleep $PAUSE
while true
do
grep ""
if [ $? == 0 ];then
break
fi
done


./mm-wiki --conf conf/mm-wiki.conf