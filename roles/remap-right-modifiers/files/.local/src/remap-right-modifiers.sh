# MacOS key IDs
# https://developer.apple.com/library/archive/technotes/tn2450/_index.html
#
# Script to convert MacOS Key Ids to hexes
# https://apple.stackexchange.com/a/283331

# Must be run on every boot

# To view the status:
# hidutil property --get UserKeyMapping
#
# To reset:
# hidutil property --set "{\"UserKeyMapping\": []}"

RIGHT_CTRL=0x7000000e4
RIGHT_ALT=0x7000000e6
RIGHT_COMMAND=0x7000000e7
LEFT_COMMAND=0x7000000e3


hidutil property --set "
{
    \"UserKeyMapping\": [
        {
            \"HIDKeyboardModifierMappingSrc\": $RIGHT_ALT,
            \"HIDKeyboardModifierMappingDst\": $LEFT_COMMAND
        }
    ]
}"
