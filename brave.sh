#!/usr/bin/bash

# Merge the policies with the host ones.
policy_root=/etc/brave/policies

for policy_type in managed recommended enrollment; do
  policy_dir="$policy_root/$policy_type"
  mkdir -p "$policy_dir"

  if [[ "$policy_type" == 'managed' ]]; then
    ln -sf /app/share/flatpak-chrome/flatpak_policy.json "$policy_dir"
  fi

  if [[ -d "/run/host/$policy_root/$policy_type" ]]; then
    find "/run/host/$policy_root/$policy_type" -type f -name '*' \
      -maxdepth 1 -name '*.json' -type f \
      -exec ln -sf '{}' "$policy_root/$policy_type" \;
  fi
done

exec cobalt "$@"
