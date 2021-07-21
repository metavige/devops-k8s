#!/bin/bash

multipass list | grep "k3s-devops" | xargs multipass delete