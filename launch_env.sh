#!/usr/bin/env bash

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export NUMEXPR_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
export VECLIB_MAXIMUM_THREADS=1

# models get lower priority than ui
# - ui is ~5ms
# - modeld is 20ms
# - DM is 10ms
# in order to run ui at 60fps (16.67ms), we need to allow
# it to preempt the model workloads. we have enough
# headroom for this until ui is moved to the CPU.
export QCOM_PRIORITY=12

if [ -z "$AGNOS_VERSION" ]; then
  export AGNOS_VERSION="16"
fi

export STAGING_ROOT="/data/safe_staging"
# Forced platform. FW fingerprinting cannot match the 2026 Outback yet: only one
# non-logging ECU answers the firmware query. Override at runtime if needed, e.g.
#   FINGERPRINT=SUBARU_CROSSTREK_2025 ./launch_openpilot.sh
export FINGERPRINT="${FINGERPRINT:-SUBARU_OUTBACK_2026}"
