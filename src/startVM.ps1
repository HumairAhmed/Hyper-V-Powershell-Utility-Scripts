#provide the VM name as an argument, otherwise 
#the script will prompt for the name of the vM to start 

$vmName = $args[0] 

write-host

if (!$vmName) 
{ 
   $vmName = read-host "Enter the name of the Virtual Machine to start"  
}  

$vm = gwmi -namespace root\virtualization Msvm_ComputerSystem -filter "ElementName='$vmName'"
 
if ( $vm.EnabledState -eq 2 ) 
{ 
  "Error starting Virtual machine $vmName!" 
} 
else 
{  
  $result = $vm.RequestStateChange(2) 

   if ($result.returnvalue -match "0") 
   {
      "$vmName started successfully"
   }
   else
   {
      "$vmName failed to start!"
   }
} 

write-host