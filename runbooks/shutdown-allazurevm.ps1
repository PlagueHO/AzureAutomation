workflow shutdown-allazurevm
{
    $VMs = Get-AzureVM
    if ($VMs)
    {
        foreach ($VM in $VMs)
        {
            Write-Host "Stopping $VM.Name"
            Stop-AzureVM -Name ($VM.Name)
            Write-Host "Stopped $VM.Name"
        }
    }
    else
    {
        Write-Host "No VMs found"
    }
}