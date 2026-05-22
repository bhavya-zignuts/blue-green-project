#!/bin/bash

PREVIOUS=$1

/opt/blue-green-deployment/scripts/switch.sh $PREVIOUS


echo "Rollback Completed"