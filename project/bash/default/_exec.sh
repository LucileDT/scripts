#!/usr/bin/env bash

# This file is called by SSH to execute script with wexample context.
# Wexample is loaded from .bashrc by default which is not loaded
# during deployment from SSH.

# The better approach may be to create a real bundle with wexample scripts,
# or install it into profile.

# Install wexample, do not print result to
# keep clean returned value.
. /opt/wexample/project/bash/default/_installLocal.sh

# Run script.
/bin/bash -c "${1}"
