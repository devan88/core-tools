#!/bin/bash
function get_version {
    local CurrentVersion=$1;
    # major, minor, patch, premajor, preminor, prepatch, or prerelease.  Default level is 'patch'. Only one version may be specified.
    local ReleaseType=:"prerelease";
    local CurrentBranch=$(git rev-parse --abbrev-ref HEAD);
    case $CurrentBranch in
        "development" | "hotfix"*)
            ReleaseType="minor";
            ;;
        "feature"*)
            CurrentVersion="${CurrentVersion}-$(git rev-parse --short HEAD)";
            ;;
        *)
            CurrentVersion="${CurrentVersion}-$(git rev-parse --short HEAD)";
            ;;
    esac
    local NextVersion=$(/bin/bash docker run --rm alpine/semver:latest semver -l -i $(ReleaseType) $(CurrentVersion));
    echo $NextVersion;
}