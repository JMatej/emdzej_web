#!/bin/bash

# Ensure you're on the main branch
git checkout main

# Fetch the latest changes from the public repository
git fetch public

# Create a temporary branch from the main branch (or any branch you want to publish)
git checkout -b temp-branch main

# Squash all commits into one
git reset $(git commit-tree HEAD^{tree} -m "Update website")

# Force push to the public repository
git push -f public HEAD:main

# Delete the temporary branch
git checkout main
git branch -D temp-branch
