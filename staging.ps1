# Path to the shared drive
$sharedDrivePath = "\\sw-fs\share\las vegas\load\apps\Starter Pack"

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

# Function to get locations from Active Directory
function Get-ADLocations {
    $locations = Get-ADOrganizationalUnit -Filter * | Select-Object -ExpandProperty Name
    return $locations
}

# Prompt for computer name
$computerName = Read-Host -Prompt "Enter the computer name"

# Prompt for location
$locations = Get-ADLocations
Write-Host "Available locations:"
$locations | ForEach-Object { Write-Host $_ }
$location = Read-Host -Prompt "Enter the location"

if (-not ($locations -contains $location)) {
    throw "Invalid location. Please enter a valid location from the list."
}

# Join the domain
$domain = "acadia.local"
$username = "placeholder"  # Placeholder, replace with actual username
$password = "placeholder"  # Placeholder, replace with actual password
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

try {
    Add-Computer -DomainName $domain -Credential $credential -ComputerName $computerName -Restart
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
        winget install --id Microsoft.VisualStudioCode -e --source winget
        winget install --id Mozilla.Firefox -e --source winget
        # Add more winget installs for Warehouse
    } elseif ($type -eq "Office") {
        winget install --id Microsoft.Office -e --source winget
        winget install --id Google.Chrome -e --source winget
        # Add more winget installs for Office
    }

    # Install applications from the shared drive based on location
    $installers = Get-ChildItem -Path "$sharedDrivePath\$location"
    foreach ($installer in $installers) {
        Start-Process -FilePath $installer.FullName -ArgumentList "/S" -Wait
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
