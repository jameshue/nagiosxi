#!/usr/bin/bash
LASTSERVICECHECK=$1
HOSTNAME="$2"
HOSTADDRESS=$3
SERVICEDESC="$4"
SERVICESTATE=$5
SERVICEATTEMPT=$6
SERVICESTATETYPE=$7
SERVICEOUTPUT=$8
SERVICEEXECUTIONTIME=$9
SERVICELATENCY=$10
SERVICEPERFDATA=$11
echo "LASTSERVICECHECK="$LASTSERVICECHECK
echo "HOSTNAME="$HOSTNAME
echo "HOSTADDRESS="$HOSTADDRESS
echo "SERVICEDESC="$SERVICEDESC
echo "SERVICESTATE="$SERVICESTATE
echo "SERVICEATTEMPT="$SERVICEATTEMPT
echo "SERVICESTATETYPE="$SERVICESTATETYPE
echo "SERVICEOUTPUT="$SERVICEOUTPUT
echo "SERVICEEXECUTIONTIME="$SERVICEEXECUTIONTIME
echo "SERVICELATENCY="$SERVICELATENCY
echo "SERVICEPERFDATA="$SERVICEPERFDATA
if [ $SERVICESTATETYPE == 'SOFT' ]
then
        case "$SERVICESTATE" in
        OK)
        echo "The host $HOSTNAME [$SERVICEDESC] changed to a $SERVICESTATE state @ $DATE" >> /tmp/status.txt
        ;;
        WARNING)
        echo "The host $HOSTNAME [$SERVICEDESC] changed to a $SERVICESTATE state @ $DATE" >> /tmp/status.txt
        ;;
        UNKNOWN)
        echo "The host $HOSTNAME [$SERVICEDESC] changed to a $SERVICESTATE state @ $DATE" >> /tmp/status.txt
        ;;
        CRITICAL)
        echo "The host $HOSTNAME [$SERVICEDESC] changed to a $SERVICESTATE state @ $DATE" >> /tmp/status.txt
        ;;
        esac
else
        case "$SERVICESTATE" in
        WARNING)
        /usr/local/nagios/libexec/postzmsg -f /usr/local/nagios/etc/tec.cfg -r $SERVICESTATE -m "$SERVICEOUTPUT" hostname=$HOSTNAME sub_origin=$SUBORIGIN $SERVICESTATE Nagios
        ;;
        UNKNOWN)
        /usr/local/nagios/libexec/postzmsg -f /usr/local/nagios/etc/tec.cfg -r $SERVICESTATE -m "$SERVICEOUTPUT" hostname=$HOSTNAME sub_origin=$SUBORIGIN $SERVICESTATE Nagios
        ;;
        CRITICAL)
        /usr/local/nagios/libexec/postzmsg -f /usr/local/nagios/etc/tec.cfg -r $SERVICESTATE -m "$SERVICEOUTPUT" hostname=$HOSTNAME sub_origin=$SUBORIGIN $SERVICESTATE Nagios
        ;;
        esac
fi	
