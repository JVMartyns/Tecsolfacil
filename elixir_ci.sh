#!/bin/bash

# format code
mix format

# Install dependencies
mix deps.get

# Run tests
mix test

# Check unused deps in lockfile
mix deps.unlock --check-unused

# Check compile warnings
mix compile --warnings-as-errors

# Check code formating
mix format --check-formatted

# Check code smells
mix credo --strict

# Check tests
mix test --warnings-as-errors