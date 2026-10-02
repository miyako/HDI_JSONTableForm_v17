var $path : Text

If (isOutput)
	$path:=Get 4D folder:C485(Current resources folder:K5:16)+"JSONForms"+Folder separator:K24:12+arrTableName{arrTableName}+"Output"+".json"
Else 
	$path:=Get 4D folder:C485(Current resources folder:K5:16)+"JSONForms"+Folder separator:K24:12+arrTableName{arrTableName}+"Input"+".json"
End if 

If (Test path name:C476($path)=Is a document:K24:1)
	OPEN URL:C673($path)
End if 