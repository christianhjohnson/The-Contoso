$rg = 'armtest-01'
New-AzResourceGroup -Name $rg -Location westus -Force

New-AzResourceGroupDeployment `
-Name 'new-storage' `
-ResourceGroupName $rg `
-TemplateParameterFile 'JSON-storage' `
-storageName 'vastmegastorge'
-storageSKU 'Standard_LRS'