#provide the VM name as an argument, otherwise 
#the script will prompt for the name of the vM to shutdown 
  
  
$vmName = $args[0] 

write-host

if (!$vmName) 
{ 
   $vmName = read-host "Enter the name of the Virtual Machine to shut down"  
}  

write-host
write-host "Shutting down $vmName"  

#get the VM   
$vm = gwmi -namespace root\virtualization Msvm_ComputerSystem -filter "ElementName='$vmName'"   
     
#get the shutdown component  for the VM 
$shutdown = gwmi -namespace root\virtualization  -query "Associators of {$vm} where ResultClass=Msvm_ShutdownComponent"   
     
if (!$shutdown) 
{ 
   write-host "Error shutting down Virtual machine $vmName!"  
} 
else 
{     
   #initiate a forced shutdown 
   $result = $shutdown.InitiateShutdown($true,"Planned Shutdown")  

   if ($result.returnvalue -match "0") 
   {
      "$vmName shutdown successfully"
   }
   else
   {
      "$vmName failed to shutdown!"
   }
}

write-host
