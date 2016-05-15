workflow shutdown-allazurevm {
    inlineScript {
        Import-Module Azure;
        Import-Module AzureRM.Automation;
        Import-Module AzureRM.Compute;
        Import-Module AzureRM.Resources;

        $Credential = Get-AutomationPSCredential `
            -Name 'AzurePowerShell';

        Login-AzureRmAccount `
            -Credential $Credential;

        $subs = Get-AzureRmSubscription
        $VMs = @()
        foreach ($sub in $subs)
        {
            "Getting VMs for Subscription '$sub.SubscriptionName'";
            Select-AzureRmSubscription -SubscriptionName ($sub.SubscriptionName)
            $VMs += @(Get-AzureRmVM);
        }

        if ($VMs.Count -gt 0)
        {
            foreach ($VM in $VMs)
            {
                "Stopping '$VM.Name'";
                Stop-AzureRmVM -Name ($VM.Name);
                "Stopped '$VM.Name'";
            }
        }
        else
        {
            "No VMs found";
        }
    }
}
