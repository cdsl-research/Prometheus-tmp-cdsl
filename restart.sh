#!/bin/bash

kubectl rollout restart -n monitoring deployment/prometheus 
kubectl rollout restart -n alert deployment/alertmanager
