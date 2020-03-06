#!/usr/bin/env bash

multipass delete $(echo k3s-master k3s-worker1 k3s-worker2 k3s-worker3)
multipass purge