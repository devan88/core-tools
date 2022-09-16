# Tools

This a tool to get the semantic version based on the git repo

# Build

docker build -f ./Dockerfile . -t git-semver:0.0.1

# Test

docker run --rm git-semver:0.0.2 git-semver "0.0.1" "feature/test" "ec69968"
