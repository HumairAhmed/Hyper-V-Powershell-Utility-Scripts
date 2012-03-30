#get a list of all VMs

$vms = gwmi MSVM_ComputerSystem -computer "." -namespace "root\virtualization" 

write-host
"Virtual Machines:"
write-host
foreach ($vm in $vms) 
{ 
   if ($vm.name -ne $vm.elementname) #skip the parent's name 
   {   
        $vm.elementname 
   } 
}
write-host
