# Connect to Azure if required
# Connect-AzAccount

$resourceGroups = Get-AzResourceGroup

foreach ($rg in $resourceGroups) {

    Write-Host "Checking Resource Group: $($rg.ResourceGroupName)"

    # Check if deployment=terraform tag exists
    if (
        $rg.Tags -and
        $rg.Tags.ContainsKey("deployment") -and
        $rg.Tags["deployment"] -eq "terraform"
    ) {
        Write-Host "  -> Terraform managed. Skipping."
        continue
    }

    # Check if RG contains resources
    $resources = Get-AzResource -ResourceGroupName $rg.ResourceGroupName

    if ($resources.Count -eq 0) {
        Write-Host "  -> Empty Resource Group. Leaving untagged."
        continue
    }

    # Preserve existing tags
    $tags = @{}

    if ($rg.Tags) {
        foreach ($key in $rg.Tags.Keys) {
            $tags[$key] = $rg.Tags[$key]
        }
    }

    # Add deployment=manual
    $tags["deployment"] = "manual"

    Set-AzResourceGroup `
        -Name $rg.ResourceGroupName `
        -Tag $tags

    Write-Host "  -> Added deployment=manual tag."
}

Write-Host "Completed."