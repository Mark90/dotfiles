# Placeholder

# DEBUG=1 provides debug logging to diagnose performance
DEBUG=0

# Debug function for other scripts to use
ts () {
  if [ $DEBUG -eq 0 ]; then
    return
  fi
  echo "[$(/opt/homebrew/bin/gdate +%s.%3N)] > $@"
}

whatami=${(%):-%N}
ts "$whatami starting (sourced by $0)"
