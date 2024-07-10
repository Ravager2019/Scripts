# Path to the drive
$sharedDrivePath = "D:\\Applications"
 
# Function to determine laptop type
function Get-LaptopType {
    $laptopType = Read-Host -Prompt "Enter the laptop type (O for Office, W for Warehouse)"
    if ($laptopType -eq "O") {
        return "Office"
    } elseif ($laptopType -eq "W") {
        return "Warehouse"
    } else {
        throw "Invalid laptop type. Please enter 'O' for Office or 'W' for Warehouse."
    }
}
 
# Function to install applications using winget
function Install-Applications {
    param (
        [string]$type,
        [string]$location
    )
 
    try {
        Write-Host "Installing applications for $type laptop..."
        if ($type -eq "Warehouse") {
            winget install --id Google.Chrome -e --source winget
            winget install --id TheDocumentFoundation.LibreOffice -e --source winget
            winget install --id Adobe.Acrobat.Reader.64-bit -e --source winget
            winget install --id Microsoft.Teams -e --source winget
            # Add more winget installs for Warehouse
        } elseif ($type -eq "Office") {
            winget install --id Google.Chrome -e --source winget
            winget install --id Adobe.Acrobat.Reader.64-bit -e --source winget
            winget install --id Microsoft.Teams -e --source winget
            winget install --id Microsoft.Office -e --source winget
            # Add more winget installs for Office
        }
 
        # Install applications from the shared drive based on location
        Write-Host "Installing applications from shared drive at $sharedDrivePath..."
        $installers = Get-ChildItem -Path "$sharedDrivePath"
        foreach ($installer in $installers) {
            Write-Host "Installing $installer.FullName..."
            Start-Process -FilePath $installer.FullName -ArgumentList "/S" -Wait
        }
    } catch {
        Write-Error "An error occurred during application installation: $_"
    }
}
 
# Main script execution
try {
    $location = Read-Host -Prompt "Input Location Code"
    switch ($location) {
        "BB" {
            $BBPath = "D:\\Applications\\Agent_Install BlackBurn.MSI"
            Write-Host "Installing LabTech Agent in BlackBurn..."
            Start-Process msiexec.exe -ArgumentList "/i `"$BBPath`" /norestart" -Wait
            Write-Host "Installation complete."
        }
        "BOS" {
            $BOSPath = "D:\\Applications\\Agent_Install Boston.MSI"
            Write-Host "Installing LabTech Agent in Boston..."
            Start-Process msiexec.exe -ArgumentList "/i `"$BOSPath`" /norestart" -Wait
            Write-Host "Installation complete."
        }
        "DC" {
            $DCPath = "D:\\Applications\\Agent_Install DC.MSI"
            Write-Host "Installing LabTech Agent in DC..."
            Start-Process msiexec.exe -ArgumentList "/i `"$DCPath`" /norestart" -Wait
            Write-Host "Installation complete."
        }
        "DET" {
            $DETPath = "D:\\Applications\\Agent_Install Detroit.MSI"
            Write-Host "Installing LabTech Agent in Detroit..."
            Start-Process msiexec.exe -ArgumentList "/i `"$DETPath`" /norestart" -Wait
            Write-Host "Installation complete."
        }
        "HOU" {
            $HOUPath = "D:\\Applications\\Agent_Install Houston.MSI"
            Write-Host "Installing LabTech Agent in Houston..."
            Start-Process msiexec.exe -ArgumentList "/i `"$HOUPath`" /norestart" -Wait
            Write-Host "Installation complete."
        }
        "LA" {
            $LAPath = "D:\\Applications\\Agent_Install Los Angeles.MSI"
            Write-Host "Installing LabTech Agent in Los Angeles..."
            Start-Process msiexec.exe -ArgumentList "/i `"$LAPath`" /norestart" -Wait
            Write-Host "Installation complete."
        }
        "LV" {
            $LVPath = "D:\\Applications\\Agent_Install Las Vegas.MSI"
            Write-Host "Installing LabTech Agent in Las Vegas..."
            Start-Process msiexec.exe -ArgumentList "/i `"$LVPath`" /norestart" -Wait
            Write-Host "Installation complete."
        }
        "MIA" {
            $MIAPath = "D:\\Applications\\Agent_Install Miami.MSI"
            Write-Host "Installing LabTech Agent in Miami..."
            Start-Process msiexec.exe -ArgumentList "/i `"$MIAPath`" /norestart" -Wait
            Write-Host "Installation complete."
        }
        "NAS" {
            $NASPath = "D:\\Applications\\Agent_Install Nashville.MSI"
            Write-Host "Installing LabTech Agent in Nashville..."
            Start-Process msiexec.exe -ArgumentList "/i `"$NASPath`" /norestart" -Wait
            Write-Host "Installation complete."
        }
        "NJ" {
            $NJPath = "D:\\Applications\\Agent_Install New Jersey.MSI"
            Write-Host "Installing LabTech Agent in New Jersey..."
            Start-Process msiexec.exe -ArgumentList "/i `"$NJPath`" /norestart" -Wait
            Write-Host "Installation complete."
        }
        "ORL" {
            $ORLPath = "D:\\Applications\\Agent_Install Orlando.MSI"
            Write-Host "Installing LabTech Agent in Orlando..."
            Start-Process msiexec.exe -ArgumentList "/i `"$ORLPath`" /norestart" -Wait
            Write-Host "Installation complete."
        }
        "PA" {
            $LITPath = "D:\\Applications\\Agent_Install Lititz.MSI"
            Write-Host "Installing LabTech Agent in Lititz..."
            Start-Process msiexec.exe -ArgumentList "/i `"$LITPath`" /norestart" -Wait
            Write-Host "Installation complete."
        }
        "SAC" {
            $SACPath = "D:\\Applications\\Agent_Install Sacramento.MSI"
            Write-Host "Installing LabTech Agent in Sacramento..."
            Start-Process msiexec.exe -ArgumentList "/i `"$SACPath`" /norestart" -Wait
            Write-Host "Installation complete."
        }
        Default {
            $DefaultPath = "D:\\Applications\\Agent_Install Default.MSI"
            Write-Host "Installing LabTech Agent with Default settings..."
            Start-Process msiexec.exe -ArgumentList "/i `"$DefaultPath`" /norestart" -Wait
            Write-Host "Installation complete."
        }
    }
 
    $laptopType = Get-LaptopType
    Install-Applications -type $laptopType -location $location
    Write-Host "Applications installed successfully for $laptopType laptop at $location."
} catch {
    Write-Host "An error occurred: $_"
}
