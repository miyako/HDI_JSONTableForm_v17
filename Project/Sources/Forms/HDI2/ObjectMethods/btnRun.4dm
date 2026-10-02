
//load input form file
$path:=Get 4D folder:C485(Current resources folder:K5:16)+"JSONForms"+Folder separator:K24:12+arrTableName{arrTableName}+"Input.json"
If (Test path name:C476($path)=Is a document:K24:1)
	
	$path:="/RESOURCES/JSONForms/"+arrTableName{arrTableName}+"Input.json"
	FORM SET INPUT:C55(Table:C252(arrTableID{arrTableName})->; $path)
	
	//load output form file
	$path:=Get 4D folder:C485(Current resources folder:K5:16)+"JSONForms"+Folder separator:K24:12+arrTableName{arrTableName}+"Output.json"
	If (Test path name:C476($path)=Is a document:K24:1)
		
		
		C_LONGINT:C283($ref)
		ALL RECORDS:C47(Table:C252(arrTableID{arrTableName})->)
		$path:="/RESOURCES/JSONForms/"+arrTableName{arrTableName}+"Output.json"
		$ref:=Open form window:C675($path; Plain form window:K39:10)
		DIALOG:C40($path; *)
		
	Else 
		ALERT:C41("Please, generate an output form for the "+arrTableName{arrTableName}+"table.")
		
	End if 
	
Else 
	ALERT:C41("Please, generate an input form for the "+arrTableName{arrTableName}+"table.")
	
End if 

