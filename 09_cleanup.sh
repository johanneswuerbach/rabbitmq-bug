#!/usr/bin/env bash
set -eo pipefail

kind delete cluster --name rabbit
