#!/bin/bash
[[ $DEBUG ]] && set -x

if [ ! -f ${MM_HOME}/conf/mm-wiki.conf ];then
cp -a ${MM_HOME}/mm-wiki.conf.template ${MM_HOME}/conf/mm-wiki.conf
fi

# if [ ! -f ${MM_HOME}/conf/inited ];then
# nohup ./install/install > ${MM_HOME}/conf/inited 2>&1 &
# fi

# while true
# do
# grep "make conf file success" ${MM_HOME}/conf/inited
# if [ $? == 0 ];then
# break
# fi
# done

[[ $PAUSE ]] && sleep $PAUSE
./mm-wiki --conf conf/mm-wiki.conf