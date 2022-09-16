#!/bin/bash
function get_version {
    local CurrentVersion=$1;
    local CurrentBranch=$2;
    local CommitHead=$3;
    # major, minor, patch, premajor, preminor, prepatch, or prerelease.  Default level is 'patch'. Only one version may be specified.
    local ReleaseType="prerelease";
    case $CurrentBranch in
        "development" | "hotfix"*)
            ReleaseType="minor";
            ;;
        "feature"*)
            CurrentVersion="${CurrentVersion}-${CommitHead}";
            ;;
    esac
    local NextVersion=$(semver -l -i ${ReleaseType} ${CurrentVersion});
    echo $NextVersion;
}
get_version $1 $2 $3