param (
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Paths
)
$TimeTaken = Measure-Command {
    foreach ($CurrentPath in $Paths) {
        Write-Host $CurrentPath
        Write-Host [string]::IsNullOrWhiteSpace($CurrentPath)
        if ([string]::IsNullOrWhiteSpace($CurrentPath)) { return }

        if (Test-Path $CurrentPath -PathType Container) {
            Write-Host "Listing contents of: $CurrentPath"

            Get-ChildItem -LiteralPath $CurrentPath -Force | ForEach-Object -Parallel {

                $ItemToDelete = $_

                # Write-Host "Parallel Deleting: $($ItemToDelete.FullName)"
                Remove-Item -LiteralPath $ItemToDelete -Force -Recurse -ErrorAction SilentlyContinue


            } -ThrottleLimit 4

        }

        elseif (Test-Path $CurrentPath) {
            # Write-Host "Deleting: $CurrentPath" 
            Remove-Item -LiteralPath $CurrentPath -Force -Recurse -ErrorAction SilentlyContinue
        }
    }
}

# 3. Output the result
Write-Host "---"
Write-Host "Using powershell : $($PSVersionTable.PSVersion)"
Write-Host "✅ Process Complete!"
Write-Host "Total time taken in seconds: $($TimeTaken.TotalSeconds) seconds"

Read-Host "Press Enter to close the test window."