#!/usr/bin/env bash
kubectl_current_context=$(cat ~/.kube/config | grep -Po 'current-context: \K.*')
kubectl_cluster=$(echo $kubectl_current_context | cut -d '_' -f 4)
kubectl_project=$(echo $kubectl_current_context | cut -d '_' -f 2 | grep -Po 'syb-\K.*')

icon=""
if [[ "$kubectl_project" == *production* ]]; then
  icon="🚨 "
fi

echo "<txt>$icon$kubectl_project/$kubectl_cluster</txt>"
