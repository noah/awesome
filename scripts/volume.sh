#!/bin/sh


# Adjust desktop PCM and squeezebox system volume
# this is intended to be an awesome keyboard shortcut callback
#
# Usage:
#   ./volume.sh [+|-]

have_pulse="$(pgrep -u $(whoami) pulse)"

if [[ -n $have_pulse ]]; then 
  # pulse is running.  do stuff

  # The following convoluted ugliness brought to you courtesy of the
  # creators of pulseaudio.

  first_sink="$(pacmd list-sinks |grep index|head -n 1 |cut -d":" -f 2 |tr -d ' ')"

  # current volume in hex, strip '0x' prefix
  vol_max=65536
  vol_h="$(pacmd dump|grep set-sink-volume|cut -d' ' -f 3|head -n1|sed -e 's:^0x::'|tr '[a-f]' '[A-F]')"
  vol_d=$(echo "ibase=16; $vol_h"|bc|head -1)

  # need fp division
  vol_pct=$(echo "scale=2;($vol_d/$vol_max.0)*100" | bc)

  if [[ $# -ne 1 ]]; then
    # print the volume level and die
    #echo -n "$(cut -d '[' -f 2 <<<"$(amixer get Master | tail -n 1)" | sed 's/%.*//g')%"
    # strip fp
    echo -n "$vol_pct" | sed 's:\.[[:digit:]]*::'
    exit 0
  fi

  # plugging in a webcam might break this line
  # amixer -Dpulse -q -c 0 set Master 1$1
  # So, this is not the right way to do it anymore. (F*CKing pulseaudio)
  increment=1000 # this corresponds to a roughly 2% increase in volume
  vol_d_new="$(echo "$vol_d$1$increment"|bc)"
  #
  # ...
  #
  #
  # "Volumes commonly span between muted (0%), and normal (100%). It is
  # possible to set volumes to higher than 100%, but clipping might
  # occur."
  # -- http://freedesktop.org/software/pulseaudio/doxygen/volume.html
  #
  # ...
  # 
  # Fact:  PulseAudio was designed by monkeys.
  # 
  if [[ $vol_d_new -gt $vol_max ]]; then
    vol_d_new="$vol_max"
  fi

  vol_h_new="$(echo "ibase=10; obase=16; $vol_d_new"|bc)"
  pacmd set-sink-volume "$first_sink" "0x$vol_h_new"
else
  echo -n "0% (no pulse)"
fi

###
# Squeezebox
# yes, I am lazy
# scriptable consumer electronics are sooooooooooooooooooo rad
# http://7be:9000/html/docs/cli-api.html?player=#mixer%20volume

# HOST=localhost
# PORT=9090
# VOL_STEP=5
# player_id="00:04:20:12:97:e5"
# 
# # Don't send commands to the squeezebox in the middle of the night,
# # people might be sleeping
# #
# HOUR=$(date +"%H")
# if [[ $HOUR -gt 07 && $HOUR -lt 02 ]]; then
#   (echo "$player_id mixer volume $1${VOL_STEP}"; sleep 1)|telnet $HOST $PORT
# fi
