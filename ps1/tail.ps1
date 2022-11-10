﻿[CmdletBinding(PositionalBinding = $false)]
param(
    [int] $n = 10,
    [switch]$v = $false,
    [switch]$f = $false,
    [Parameter(
        Mandatory=$false, 
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true)
    ][String[]]$pipe_dummy_var,
    [Parameter(ValueFromRemainingArguments = $true)] $remainingArgs = $null
)

# https://stackoverflow.com/questions/885349/how-do-i-write-a-powershell-script-that-accepts-pipeline-input
# in order to accept pipe, we have to set the param()

Set-StrictMode -Version Latest
function usage {
    param([string]$message = $null)
    if ($message) { Write-Host $message }
    Write-Host "
Usage:
    tail -f filename
    tail [-n count] filename
    cat filename | tail [-n count]
    powershell -ExecutionPolicy Bypass -File ./tail.ps1 [-n count] filename
"
    exit 1
}

if ($v) {
    $verbosePreference = "Continue"
}

if ($remainingArgs) {
    if ($remainingArgs.Count -gt 1) { usage ("wrong numnber of args") }
    $file = $remainingArgs[0]

    Write-Verbose "input from file"

    if ($f) {
        Get-Content $file -Tail $n -Wait
    } else {
        Get-Content $file -Tail $n
    }
} else {

    Write-Verbose "input from pipe"

    $Input | Select-Object -Last $n
}