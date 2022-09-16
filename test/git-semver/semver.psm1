function Get-Version {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidatePattern('^((([0-9]+)\.([0-9]+)\.([0-9]+)(?:-([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?)(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?)$')]
        [string] $CurrentVersion
    )

    # major, minor, patch, premajor, preminor, prepatch, or prerelease.  Default level is 'patch'. Only one version may be specified.
    $ReleaseType = "prerelease";
    $CurrentBranch = $(git rev-parse --abbrev-ref HEAD);
    switch -wildcard ($CurrentBranch) {
        ("development" -or "hotfix*") { $ReleaseType = "minor"; break; }
        ("feature*") { $CurrentVersion = "$($CurrentVersion)-$(git rev-parse --short HEAD)"; break; }
        Default { $CurrentVersion = "$($CurrentVersion)-$(git rev-parse --short HEAD)"; break; }
    }
    $NextVersion = $(docker run --rm alpine/semver:latest semver -l -i $ReleaseType $CurrentVersion);
    Write-Host $NextVersion;
}