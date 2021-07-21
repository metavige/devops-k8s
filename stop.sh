#!/bin/bash

all_instances="k3s-devops-master"
for ins for $all_instances
do
  multipass stop $ins
done