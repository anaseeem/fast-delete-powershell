param (
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Paths
)

$QuotedPaths = $Paths | ForEach-Object { "`"$_`"" }
$PathArguments = $QuotedPaths -join ' '


Start-Process -FilePath "pwsh.exe" `
    -ArgumentList "-ExecutionPolicy Bypass -File `".\src\command.ps1`" $PathArguments" `
    -NoNewWindow