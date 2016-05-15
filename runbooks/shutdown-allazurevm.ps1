workflow shutdown-allazurevm {
    inlineScript {
        Import-Module Azure;
        Import-Module AzureRM.Automation;
        Import-Module AzureRM.Compute;
        Import-Module AzureRM.Resources;

        $Credential = Get-AutomationPSCredential `
            -Name 'AzurePowerShell';

        Write-Output $Credential
        
        Write-Output "Logging in"

        Login-AzureRmAccount `
            -Credential $Credential;

        Write-Output "Getting subscriptions"

        $subs = Get-AzureRmSubscription

        $VMs = @()
        foreach ($sub in $subs)
        {
            Write-Output "Getting VMs for Subscription '$sub.SubscriptionName'";
            Select-AzureRmSubscription -SubscriptionName ($sub.SubscriptionName)
            $VMs += @(Get-AzureRmVM);
        }

        if ($VMs.Count -gt 0)
        {
            foreach ($VM in $VMs)
            {
                Write-Output "Stopping '$VM.Name'";
                Stop-AzureRmVM -Name ($VM.Name);
                Write-Output "Stopped '$VM.Name'";
            }
        }
        else
        {
            Write-Output "No VMs found";
        }
    }
}
