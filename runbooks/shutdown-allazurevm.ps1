workflow shutdown-allazurevm
{
    $VMs = Get-AzureVM
    if ($VMs)
    {
        foreach ($VM in $VMs)
        {
            "Stopping '$VM.Name'"
            $null = Stop-AzureVM -Name ($VM.Name)
            "Stopped '$VM.Name'"
        }
    }
    else
    {
        "No VMs found"
    }
}