#!/usr/bin/env bash

# A Genmon (xfce4-genmon-plugin) plugin for Kuberenetes.
#
# Displays the current context and opens the Kuberenetes Engine/Workloards
# page on click.
#
# For more information see:
# https://goodies.xfce.org/projects/panel-plugins/xfce4-genmon-plugin

DEFAULT_COLOR=""
PRODUCTION_COLOR="#FF6A6F"
PANEL_FONT="Monospace Bold 9"

api_version=$(cat $HOME/.kube/config | grep -Po 'apiVersion: \K.*')
current_context=$(cat $HOME/.kube/config | grep -Po 'current-context: \K.*')
cluster=$(echo $current_context | cut -d '_' -f 4)
region=$(echo $current_context | cut -d '_' -f 3)
project=$(echo $current_context | cut -d '_' -f 2)

fgcolor=""
if [[ ! -z "$DEFAULT_COLOR" ]]; then
  fgcolor="fgcolor='$DEFAULT_COLOR'"
fi
if [[ "$project" == *production* && ! -z "$PRODUCTION_COLOR" ]]; then
  fgcolor="fgcolor='$PRODUCTION_COLOR'"
fi

k8s_url="https://console.cloud.google.com/kubernetes/workload?project=$project"

echo "<txt><span font='$PANEL_FONT' $fgcolor>$project/$cluster</span></txt>"
echo "<txtclick>xdg-open $k8s_url</txtclick>"
echo -ne "<tool>"
echo -ne "<span font='Monospace'>"
echo -ne "Project     <span font_weight='bold'>$project</span>\n"
echo -ne "Cluster     <span font_weight='bold'>$cluster</span>\n"
echo -ne "Region      <span font_weight='bold'>$region</span>\n"
echo -ne "API Version <span font_weight='bold'>$api_version</span>\n"
echo -ne "\n"
echo -ne "Context\n$current_context\n"
echo -ne "</span>"
echo -ne "\n"
echo -ne "<span font_style='italic'>Click to open Kuberenetes Engine in $project.</span>"
echo -ne "</tool>"
