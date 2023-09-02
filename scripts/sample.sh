#!/bin/bash
set -e

RES=$(cat ./scripts/install.sh)

echo "{out:\"${RES}\"}"