#!/bin/bash


# Print and optionall adjust pulse audio active sink volume.  This is
# intended to be an awesome keyboard shortcut callback
#
# Usage:
#   ./volume.sh [+|-]

have_pulse="$(pgrep -u $(whoami) pulse)"

if [[ -n $have_pulse ]]; then 
  # pulse is running.  do stuff

  # The following convoluted ugliness brought to you courtesy of the
  # creators of pulseaudio.

  active_sink="$(pacmd list-sinks | \
          # the "active" sink is denoted by an asterisk prefix
          grep '* index:' | \
          # the sink number is the 5th column
          cut -d' ' -f 5)"

  # current volume
  vol_pct=$(pacmd list-sinks | \
          # print 15 lines after the active sink
          grep -A 15 "index: $active_sink" | \
          # pull out the volume: row
          egrep '^[[:space:]]+volume:.+' | \
          # extract the numeric volume
          egrep -o '[[:digit:]]+%' | \
          # take the first (there may be multiple due to multiple [left/right] channels)
          tail -n 1 | \
          # strip off the percent sign
          tr -d '%')

  if [[ $# -ne 1 ]]; then
    # print the volume level and die
    echo -n "$vol_pct"
    exit 0
  fi

  # plugging in a webcam might break this line
  # amixer -Dpulse -q -c 0 set Master 1$1
  # So, this is not the right way to do it anymore. (F*CKing pulseaudio)
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
  #
  operator=$1
  if [ "$operator" = "m" ]; then
          pactl set-sink-mute $active_sink toggle
          exit
  fi
  vol_inc="1"
  vol_pct_min=0
  vol_pct_max=100
  vol_pct_new="$(echo "ibase=10;obase=10; $vol_pct$operator$vol_inc"|bc)"

  test $vol_pct_new -gt $vol_pct_max && vol_pct_new=$vol_pct_max
  test $vol_pct_new -lt $vol_pct_min && vol_pct_new=$vol_pct_min

  pactl set-sink-volume $active_sink "${vol_pct_new}%"
else
  echo -n "0% (no pulse)"
fi
