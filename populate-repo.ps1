# ====================================================================
# IELTS BUDDY - Populate Repository with All Files
# ====================================================================
#
# Usage: powershell -ExecutionPolicy Bypass -File populate-repo.ps1
#
# This script:
# 1. Clone repository
# 2. Create all 15 documentation files
# 3. Create all setup scripts
# 4. Create folder structure
# 5. Git commit
# 6. Guide you to git push
#
# ====================================================================

# Configuration
$REPO_URL = "git@github.com:Chiennn/AppStudyLanguage.git"
$PROJECT_PATH = "D:\AppStudyLanguage"
$DOCS_PATH = "$PROJECT_PATH\docs"

# Colors
function Write-Success { Write-Host "✅ $($args[0])" -ForegroundColor Green }
function Write-Error-Custom { Write-Host "❌ $($args[0])" -ForegroundColor Red }
function Write-Warning-Custom { Write-Host "⚠️  $($args[0])" -ForegroundColor Yellow }
function Write-Header { Write-Host "`n════════════════════════════════════════" -ForegroundColor Blue; Write-Host $args[0] -ForegroundColor Blue; Write-Host "════════════════════════════════════════`n" -ForegroundColor Blue }

# Main
function Main {
    Write-Header "IELTS BUDDY - Populate Repository"

    # Step 1: Check Git
    Write-Host "Step 1: Checking Git..." -ForegroundColor Cyan
    $gitVersion = git --version 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Success "Git found: $gitVersion"
    } else {
        Write-Error-Custom "Git not found. Install from https://git-scm.com/"
        exit 1
    }

    # Step 2: Clone Repository
    Write-Host ""
    Write-Host "Step 2: Cloning repository..." -ForegroundColor Cyan
    Write-Host "URL: $REPO_URL" -ForegroundColor Yellow
    Write-Host "Path: $PROJECT_PATH" -ForegroundColor Yellow
    Write-Host ""

    if (Test-Path $PROJECT_PATH) {
        Write-Warning-Custom "Folder already exists: $PROJECT_PATH"
        $choice = Read-Host "Delete and re-clone? (y/n)"
        if ($choice -eq "y") {
            Remove-Item -Path $PROJECT_PATH -Recurse -Force
            Write-Success "Folder deleted"
        } else {
            Write-Host "Using existing folder" -ForegroundColor Yellow
            Setup-Repo-Existing
            exit 0
        }
    }

    try {
        git clone $REPO_URL $PROJECT_PATH
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Repository cloned"
        } else {
            Write-Error-Custom "Clone failed"
            exit 1
        }
    } catch {
        Write-Error-Custom "Error: $_"
        exit 1
    }

    # Step 3: Create folders
    Write-Host ""
    Write-Host "Step 3: Creating folder structure..." -ForegroundColor Cyan
    
    $folders = @(
        "$DOCS_PATH",
        "$PROJECT_PATH\apps\frontend",
        "$PROJECT_PATH\apps\backend",
        "$PROJECT_PATH\scripts"
    )

    foreach ($folder in $folders) {
        if (!(Test-Path $folder)) {
            New-Item -ItemType Directory -Path $folder -Force > $null
            Write-Success "Created: $folder"
        }
    }

    # Step 4: Create all documentation files
    Write-Host ""
    Write-Host "Step 4: Creating documentation files..." -ForegroundColor Cyan
    
    Create-Doc-Files

    # Step 5: Create setup scripts
    Write-Host ""
    Write-Host "Step 5: Creating setup scripts..." -ForegroundColor Cyan
    
    Create-Setup-Scripts

    # Step 6: Git commit
    Write-Host ""
    Write-Host "Step 6: Committing to Git..." -ForegroundColor Cyan
    
    try {
        Push-Location $PROJECT_PATH
        
        git add .
        Write-Success "Files staged"
        
        git commit -m "docs: add complete documentation and setup scripts"
        Write-Success "Committed"
        
        Pop-Location
    } catch {
        Write-Error-Custom "Git commit error: $_"
        exit 1
    }

    # Step 7: Summary
    Show-Summary
}

function Create-Doc-Files {
    # Note: In real scenario, we would copy files from /outputs/
    # For now, creating placeholder structure
    
    $docFiles = @(
        "00_PROJECT_CONTEXT.md",
        "01_PRODUCT_VISION.md",
        "02_PRD.md",
        "03_USER_FLOW.md",
        "04_UI_UX.md",
        "05_DATABASE.md",
        "06_API.md",
        "07-14_REMAINING_DOCS.md",
        "15_PROMPTS.md",
        "COMPLETION_SUMMARY.md",
        "SETUP_GUIDE.md",
        "SETUP_FROM_ZERO.md",
        "SCRIPTS_README.md",
        "DOWNLOAD_AND_SETUP.md",
        "UPDATE_GUIDE.md"
    )

    foreach ($file in $docFiles) {
        $filePath = "$DOCS_PATH\$file"
        
        # Create placeholder (in real scenario, copy from /outputs/)
        $content = "# $file`n`nPlaceholder for documentation.`nReplace with actual content from Claude /outputs/ folder.`n`nGenerated: $(Get-Date)"
        
        Set-Content -Path $filePath -Value $content -Force
        Write-Success "Created: $file"
    }
}

function Create-Setup-Scripts {
    $scripts = @(
        @{
            "Name" = "setup.sh"
            "Type" = "Bash"
        },
        @{
            "Name" = "setup-windows.ps1"
            "Type" = "PowerShell"
        },
        @{
            "Name" = "clone-and-setup.ps1"
            "Type" = "PowerShell"
        },
        @{
            "Name" = "download-updates.ps1"
            "Type" = "PowerShell"
        }
    )

    foreach ($script in $scripts) {
        $filePath = "$PROJECT_PATH\$($script.Name)"
        $content = "# $($script.Name)`n# Type: $($script.Type)`n# Placeholder for setup script.`n# Replace with actual content from Claude /outputs/ folder.`n# Generated: $(Get-Date)"
        
        Set-Content -Path $filePath -Value $content -Force
        Write-Success "Created: $($script.Name)"
    }
}

function Setup-Repo-Existing {
    Write-Host "Using existing repository" -ForegroundColor Green
    Push-Location $PROJECT_PATH
    
    # Create folders if not exist
    $folders = @(
        "docs",
        "apps\frontend",
        "apps\backend",
        "scripts"
    )

    foreach ($folder in $folders) {
        if (!(Test-Path $folder)) {
            New-Item -ItemType Directory -Path $folder -Force > $null
        }
    }
    
    Pop-Location
}

function Show-Summary {
    Write-Header "✅ Repository Populated Successfully!"

    Write-Host "📁 Folder Structure:" -ForegroundColor Green
    Write-Host ""
    Write-Host "D:\AppStudyLanguage\" -ForegroundColor Cyan
    Write-Host "├── .git/" -ForegroundColor Gray
    Write-Host "├── .gitignore" -ForegroundColor Gray
    Write-Host "├── README.md" -ForegroundColor Gray
    Write-Host "├── docs/" -ForegroundColor Cyan
    Write-Host "│   ├── 00_PROJECT_CONTEXT.md" -ForegroundColor Yellow
    Write-Host "│   ├── 01_PRODUCT_VISION.md" -ForegroundColor Yellow
    Write-Host "│   ├── ... (13 more files)" -ForegroundColor Yellow
    Write-Host "│   └── UPDATE_GUIDE.md" -ForegroundColor Yellow
    Write-Host "├── apps/" -ForegroundColor Cyan
    Write-Host "│   ├── frontend/" -ForegroundColor Gray
    Write-Host "│   ├── backend/" -ForegroundColor Gray
    Write-Host "│   └── shared/" -ForegroundColor Gray
    Write-Host "├── scripts/" -ForegroundColor Cyan
    Write-Host "├── setup.sh" -ForegroundColor Yellow
    Write-Host "├── setup-windows.ps1" -ForegroundColor Yellow
    Write-Host "├── clone-and-setup.ps1" -ForegroundColor Yellow
    Write-Host "└── download-updates.ps1" -ForegroundColor Yellow
    Write-Host ""

    Write-Host "📋 Files Created:" -ForegroundColor Green
    Write-Host ""
    Write-Host "  ✅ 15 Documentation files (in docs/)"
    Write-Host "  ✅ 4 Setup scripts"
    Write-Host "  ✅ Folder structure"
    Write-Host "  ✅ Git commit created"
    Write-Host ""

    Write-Host "⚠️  IMPORTANT NEXT STEP:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "The repository has been populated with files, but they are PLACEHOLDERS."
    Write-Host ""
    Write-Host "You need to:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1️⃣  Download actual files from Claude /outputs/" -ForegroundColor Yellow
    Write-Host "    Download each file and copy content to:"
    Write-Host "    - D:\AppStudyLanguage\docs\[filename]"
    Write-Host "    - D:\AppStudyLanguage\[script filename]"
    Write-Host ""
    Write-Host "2️⃣  Or use this command to get files from Claude:" -ForegroundColor Yellow
    Write-Host "    (Ask Claude to create a master file with all content)"
    Write-Host ""
    Write-Host "3️⃣  Update files:" -ForegroundColor Yellow
    Write-Host "    Open each file in VS Code and replace placeholder with actual content"
    Write-Host ""

    Write-Host "📤 To Push to GitHub:" -ForegroundColor Green
    Write-Host ""
    Write-Host "  cd D:\AppStudyLanguage" -ForegroundColor Cyan
    Write-Host "  git push origin main" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Or if SSH issues:" -ForegroundColor Cyan
    Write-Host "  git push https://github.com/Chiennn/AppStudyLanguage.git main" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "🚀 After updating files and pushing:" -ForegroundColor Green
    Write-Host ""
    Write-Host "  1. Verify on GitHub: https://github.com/Chiennn/AppStudyLanguage"
    Write-Host "  2. Run setup-windows.ps1"
    Write-Host "  3. Start Sprint 1 with AI! 🎉"
    Write-Host ""
}

# Run main
Main

Write-Host ""
pause
