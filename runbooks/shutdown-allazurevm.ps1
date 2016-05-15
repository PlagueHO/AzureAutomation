workflow shutdown-allazurevm
{
    $VMs = Get-AzureVM
    foreach ($VM in $VMs)
    {
        Stop-AzureVM -Name ($VM.Name)
    }
}