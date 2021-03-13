#!/bin/sh

cp .github/hooks/pre-commit .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit

cp .github/hooks/pre-push .git/hooks/pre-push
chmod +x .git/hooks/pre-push
