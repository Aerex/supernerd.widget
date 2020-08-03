#!/bin/sh

PATH=$HOME/.nix-profile/bin:$PATH

# Attemps to return:
# LHS | MHS | RHS
# LHS: type of tiling on space
# MHS: number of spaces (e.g. 1 2 (3))
# RHS: name of focused window
#
# Tries chunkc first, falls back to kwmc

get_yabai() {
  yabai=$(which yabai)
  jq=$(which jq)

  # Test to see if yabai file exists 
  if ! [ -x "$(command -v yabai)" ]; then
    echo "{\"error\":\"yabai binary not found\"}"
    exit 1
  fi

  if ! [ -x "$(command -v jq)" ]; then
    echo "{\"error\":\"jq binary not found\"}"
    exit 1
  fi
    #TODO Find a way to detrmine if yabai is active
    # Test if yabai is active/exists first
    # Exit if not running so spaces.sh can handle it
    # if ! MODE=$($yabai -m query --spaces)
    # then
    #     return 1
    # fi

    # Test if jq exists
    # if [[ ! -z $(command -v $(which jq) 2>/dev/null) ]]; then
    #   return 1
    # fi

    # LHS:
    # Get tiling mode + number of windows in monocle
    LHS=$($yabai -m query --spaces --space | jq -r '.type')

    # case $MODE in
    #     bsp)
    #         LHS="bsp"
    #         ;;
    #     float)
    #         LHS="float"
    #         ;;
    #     # monocle)
    #     #     # list of windows (use for monocle)
    #     #     WINDOWS=$($chunkc tiling::query -d windows | /usr/bin/sed '/(invalid)/d')
			# # NUM_WIN=$(echo "$WINDOWS" | wc -l | tr -d ' ')
    #     #     LHS="[""$NUM_WIN"w"]"
    #     #     ;;
    #     *)
    #         LHS="[ ]"
    #         ;;
    # esac

    # MHS:
    # Get list of spaces, and surround active space with ()
    # NOTE - this route is frackin' killing chunkwm so ... (?)
    #SPACES="$($chunkc tiling::query --desktops-for-monitor $MONITOR)"
    #SPACES="$($yabai -m query --space)
    #MHS=$(echo $SPACES | sed "s|\($($chunkc tiling::query -d id)\)|(\1)|")
    #MHS="$($chunkc tiling::query -d id)"
    MHS=$(yabai -m query --spaces | jq -r '.[].index' | awk 'BEGIN {ORS=" "} {print $1 " "}')


    # RHS:
    # get name of focused window
    RHS=$(yabai -m query --windows --window | jq -r '.app')
    if [[ -z "$RHS" ]]; then RHS="~~"; fi

    echo "{\"lhs\":\"$LHS\", \"mhs\": \"$MHS\", \"rhs\": \"$RHS\"}"

    # echo "$LHS | $MHS | $RHS"
}


get_yabai
code=$?
if [ $code != 0 ]; then
  echo "[ ] | (0) | rip wms :/"
fi
