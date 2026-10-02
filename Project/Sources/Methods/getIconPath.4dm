//%attributes = {"invisible":true}
//Get application resources path
#DECLARE->$result : Text

var $Lon_i; $Lon_platform : Integer
var $Path_buffer : Text


$Path_buffer:=Application file:C491

_O_PLATFORM PROPERTIES:C365($Lon_platform)

If ($Lon_platform=Windows:K25:3)
	
	//Get parent path
	For ($Lon_i; Length:C16($Path_buffer); 1; -1)
		
		If ($Path_buffer[[$Lon_i]]=Folder separator:K24:12)
			
			$Path_buffer:=Substring:C12($Path_buffer; 1; $Lon_i)
			$Lon_i:=0
			
		End if 
		
	End for 
	
Else 
	
	//Content path
	$Path_buffer:=$Path_buffer+Folder separator:K24:12+"Contents"+Folder separator:K24:12
	
End if 

$result:=$Path_buffer+"Resources"+Folder separator:K24:12+"Images"+Folder separator:K24:12+"StructureEditor"+Folder separator:K24:12