# setup-deploy.ps1
# Helper script to initialize git, commit files, and optionally create a GitHub repo using gh CLI.
# Run from the project folder: powershell -NoProfile -ExecutionPolicy Bypass -File .\setup-deploy.ps1

$project = Get-Location
Write-Host "Project path: $project"

# Check for Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error "Git is not installed. Please install Git from https://git-scm.com/downloads and rerun this script."
    exit 1
}

# Initialize git repo if necessary
if (-not (Test-Path .git)) {
    Write-Host "Initializing git repository..."
    git init
    git branch -M main
} else {
    Write-Host "Git repository already initialized."
}

# Stage changes and commit
Write-Host "Staging files..."
git add .
try {
    git commit -m "Initial site commit" --quiet
    Write-Host "Committed changes."
} catch {
    Write-Host "No changes to commit or commit failed. Continuing..."
}

# Offer to create GitHub repo using gh
$gh = Get-Command gh -ErrorAction SilentlyContinue
if ($gh) {
    $create = Read-Host "gh CLI detected. Create a new GitHub repo from this folder now? (Y/n)"
    if ($create -eq "" -or $create -match '^[Yy]') {
        $defaultName = Split-Path -Leaf $project.Path
        $repoName = Read-Host "Enter GitHub repo name (default: $defaultName)"
        if ([string]::IsNullOrWhiteSpace($repoName)) { $repoName = $defaultName }
        $pub = Read-Host "Make repo public? (Y/n)"
        if ($pub -eq "" -or $pub -match '^[Yy]') {
            $vis = "--public"
        } else {
            $vis = "--private"
        }
        Write-Host "Creating repo $repoName (visibility: $vis)..."
        gh repo create $repoName $vis --source=. --remote=origin --push
        if ($LASTEXITCODE -eq 0) { Write-Host "Repository created and pushed to GitHub." } else { Write-Warning "gh repo create returned an error. Check the output above." }
    } else {
        Write-Host "Skipping gh repo creation. To push manually, run:"
        Write-Host "  git remote add origin https://github.com/GITHUB_USERNAME/REPO_NAME.git"
        Write-Host "  git push -u origin main"
    }
} else {
    Write-Host "gh CLI not found. To push to GitHub, create a repo on github.com and then run:"
    Write-Host "  git remote add origin https://github.com/GITHUB_USERNAME/REPO_NAME.git"
    Write-Host "  git push -u origin main"
}

Write-Host "Done. You can now connect this GitHub repo to Render (or deploy to Firebase)."