param (
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Paths
)
Write-Host "Using powershell : $($PSVersionTable.PSVersion)"


foreach ($CurrentPath in $Paths) {
    $TimeTaken = Measure-Command {
        if ([string]::IsNullOrWhiteSpace($CurrentPath)) { return }

        if (Test-Path $CurrentPath) {
            # Write-Host "Deleting: $CurrentPath" 
            Remove-Item -LiteralPath $CurrentPath -Force -Recurse -ErrorAction SilentlyContinue
        }
        
    }
    Write-Host "--------"
    Write-Host "✅ Process Complete!"
    Write-Host "Total time taken in seconds: $($TimeTaken.TotalSeconds) seconds"
}


Read-Host "Press Enter to close the test window."