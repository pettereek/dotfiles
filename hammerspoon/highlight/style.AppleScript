-- See https://sourceforge.net/p/syntaxhighlight/code/HEAD/tree/highlight/themes/

set styles to {"acid", "autumn", "baycomb", "bclear", "biogoo", "bipolar", "blacknblue", "bluegreen", "breeze", "bright", "camo", "candy", "clarity", "dante", "darkblue", "darkbone", "darkness", "darkslategray", "darkspectrum", "denim", "dusk", "earendel", "easter", "ekvoli", "fine_blue", "freya", "fruit", "github", "matrix", "molokai", "moria", "navajo-night", "oxygenated", "rdark", "solarized", "vampire", "whitengrey", "zmrok"}

choose from list styles with title "Select color theme" with prompt "Please select the color theme" default items {"molokai"} without multiple selections allowed and empty selection allowed

return the result as string
