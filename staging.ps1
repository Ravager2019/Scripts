# Path to the drive
$sharedDrivePath = "W:\Applications"

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


try {
    Add-Computer -DomainName $domain -Credential $credential -ComputerName $computerName
    Write-Host "Successfully joined the domain and restarting the computer."
} catch {
    Write-Host "Failed to join the domain: $_"
    exit 1
}

# Function to install applications using winget
function Install-Applications {
    param (
        [string]$type,
        [string]$location
    )

    if ($type -eq "Warehouse") {
        winget install --id Google.Chrome -e --source winget
        winget install --id TheDocumentFoundation.LibreOffice -e --source winget
        winget install --id Adobe.Acrobat.Reader.64-bit -e --source winget
        winget install --id Microsoft.Teams -e --source winget
        # Add more winget installs for Warehouse
    } elseif ($type -eq "Office") {
        winget install --id Microsoft.Office -e --source winget
        winget install --id Google.Chrome -e --source winget
        winget install --id Adobe.Acrobat.Reader.64-bit -e --source winget
        winget install --id Microsoft.Teams -e --source winget
        winget install --Microsoft.Office -e --source winget
        # Add more winget installs for Office
    }

    # Install applications from the shared drive based on location
    $installers = Get-ChildItem -Path "$sharedDrivePath\$location"
    foreach ($installer in $installers) {
        Start-Process -FilePath $installer.FullName -ArgumentList "/S" -Wait
    }
}
$location = Read-Host "Input Location Code"
# Switch Case for location
switch ($location) {
    "ATL"{

        break
    }
    "BOS"{

        break
    }
    "DET"{

        break
    }
    "PA"{

        break
    }
    "LON"{

        break
    }
    "BB"{

        break
    }
    "HOU"{

        break
    }
    "LV"{
        $LVPath = "W:\Applications\LabTech\Agent_Install Las Vegas.MSI"

        Write-Host "Installing LabTech Agent in Las Vegas..."
        Start-Process msiexec.exe -ArgumentList "/i `"$LVPath`" /quiet /norestart" -NoNewWindow -Wait
        Write-Host "Installation complete."

        break
    }
    "SS"{

        break
    }
    "MD"{

    }
    "MIA"{

    }
    "ORL"{

    }
    "TN"{

    }
    "NY"{

    }
    "SAC"{

    }
    Default {
        Write-Host "Invalid Location Name Try Again."
        
    }
}

# Main script execution
try {
    $laptopType = Get-LaptopType
    Install-Applications -type $laptopType -location $location
    Write-Host "Applications installed successfully for $laptopType laptop at $location."
} catch {
    Write-Host "An error occurred: $_"
}
