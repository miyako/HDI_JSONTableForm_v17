//%attributes = {"invisible":true}
var $iTable; $iField; $type : Integer

$iTable:=arrTableID{arrTableName}

CLEAR VARIABLE:C89(arrFieldName)
CLEAR VARIABLE:C89(arrFieldLabel)
CLEAR VARIABLE:C89(arrFieldType)
CLEAR VARIABLE:C89(arrFieldPic)
CLEAR VARIABLE:C89(arrFieldDisplay)


For ($iField; 1; Last field number:C255($iTable))
	
	If (Is field number valid:C1000($iTable; $iField))
		
		GET FIELD PROPERTIES:C258($iTable; $iField; $type)
		
		If ($type#Is BLOB:K8:12)
			APPEND TO ARRAY:C911(arrFieldType; $type)
			APPEND TO ARRAY:C911(arrFieldPic; arrPict{$type})
			APPEND TO ARRAY:C911(arrFieldName; Field name:C257($iTable; $iField))
			APPEND TO ARRAY:C911(arrFieldLabel; Field name:C257($iTable; $iField))
			APPEND TO ARRAY:C911(arrFieldDisplay; True:C214)
		End if 
		
	End if 
	
End for 



