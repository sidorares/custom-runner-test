#!/usr/bin/env bash
# Local agent: runs on your machine via the self-hosted runner.
# Exit 0 → GitHub marks this check as successful (approved).
# Exit non-zero → check fails.
set -euo pipefail

banner() {
  printf '\n======== %s ========\n' "$1"
}

banner "Local agent starting"
echo "time:     $(date -u +%Y-%m-%dT%H:%M:%SZ)"
echo "host:     $(hostname)"
echo "user:     $(whoami)"
echo "cwd:      $(pwd)"
echo "uname:    $(uname -a)"

banner "GitHub context (from the workflow)"
echo "repo:     ${AGENT_REPO:-unknown}"
echo "event:    ${AGENT_EVENT:-unknown}"
echo "ref:      ${AGENT_REF:-unknown}"
echo "sha:      ${AGENT_SHA:-unknown}"
echo "actor:    ${AGENT_ACTOR:-unknown}"
echo "run_id:   ${AGENT_RUN_ID:-unknown}"
echo "attempt:  ${AGENT_RUN_ATTEMPT:-unknown}"

banner "Local activity"
# Demo work: write a small receipt under the workspace so you can see
# that this process really ran on this machine.
mkdir -p .agent-output
receipt=".agent-output/last-run.txt"
{
  echo "agent_ok=true"
  echo "finished_at=$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  echo "host=$(hostname)"
  echo "sha=${AGENT_SHA:-unknown}"
  echo "run_id=${AGENT_RUN_ID:-unknown}"
} >"$receipt"
echo "wrote receipt: $receipt"
cat "$receipt"

banner "Approving check"
echo "Exiting 0 so GitHub Actions marks this job as success."
exit 0
