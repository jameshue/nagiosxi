#!/usr/bin/bash
LASTHOSTCHECK=$1
HOSTNAME=$2
HOSTSTATE=$3
HOSTATTEMPT=$4
HOSTSTATETYPE=$5
HOSTEXECUTIONTIME=$6
HOSTOUTPUT=$7
HOSTPERFDATA=$8
echo "LASTHOSTCHECK="$LASTHOSTCHECK
echo "HOSTNAME="$HOSTNAME
echo "HOSTSTATE="$HOSTSTATE
echo "HOSTATTEMPT="$HOSTATTEMPT
echo "HOSTSTATETYPE="$HOSTSTATETYPE
echo "HOSTEXECUTIONTIME="$HOSTEXECUTIONTIME
echo "HOSTOUTPUT="$HOSTOUTPUT
echo "HOSTPERFDATA="$HOSTPERFDATA
if [ $HOSTSTATETYPE == 'SOFT' ]
then
        case "$HOSTSTATE" in
        UP)
        echo "The host $HOSTNAME changed to a $HOSTSTATE state @ $DATE" >> /tmp/soft-host-status.txt
        ;;
        DOWN)
        echo "The host $HOSTNAME changed to a $HOSTSTATE state @ $DATE" >> /tmp/soft-host-status.txt
        ;;
        UNREACHABLE)
        echo "The host $HOSTNAME changed to a $HOSTSTATE state @ $DATE" >> /tmp/soft-host-status.txt
        ;;
        esac
else
        case "$HOSTSTATE" in
        UP)
        /usr/local/nagios/libexec/postzmsg -f /usr/local/nagios/etc/tec.cfg -r $HOSTSTATE -m "$HOSTNAME $HOSTSTATE" hostname=$HOSTNAME sub_origin=$SUBORIGIN PING Nagios
        ;;
        DOWN)
        /usr/local/nagios/libexec/postzmsg -f /usr/local/nagios/etc/tec.cfg -r $HOSTSTATE -m "$HOSTNAME $HOSTSTATE" hostname=$HOSTNAME sub_origin=$SUBORIGIN PING Nagios
        ;;
        UNREACHABLE)
        /usr/local/nagios/libexec/postzmsg -f /usr/local/nagios/etc/tec.cfg -r $HOSTSTATE -m "$HOSTNAME $HOSTSTATE" hostname=$HOSTNAME sub_origin=$SUBORIGIN PING Nagios
        ;;
        esac
fi
