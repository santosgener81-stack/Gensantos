Set-Location 'C:\Users\gener\joshua-portfolio'

# Check git
try {
    git --version | Out-Null
} catch {
    Write-Error "Git is not available in PATH. Install Git and retry."
    exit 1
}

# Ensure user.name
$name = (git config user.name) -join ''
if ([string]::IsNullOrWhiteSpace($name)) {
    git config user.name "Gener"
    Write-Host "Set git user.name to Gener"
} else {
    Write-Host "git user.name is set to '$name'"
}

# Ensure user.email
$email = (git config user.email) -join ''
if ([string]::IsNullOrWhiteSpace($email)) {
    git config user.email "gener@example.com"
    Write-Host "Set git user.email to gener@example.com"
} else {
    Write-Host "git user.email is set to '$email'"
}

# Init repo if needed
if (-not (Test-Path '.git')) {
    git init
    git branch -M main
    Write-Host "Initialized git repo and set branch main"
} else {
    Write-Host "Git repo already initialized"
}

# Add and commit
git add .
$commitOutput = git commit -m "Initial site commit" 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "Commit created"
} else {
    Write-Host $commitOutput
    Write-Host "No changes to commit or commit failed"
}

git branch -M main
Write-Host "DONE"
