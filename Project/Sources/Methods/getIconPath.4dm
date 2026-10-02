//%attributes = {"invisible":true}
//Get application resources path
C_TEXT:C284($0)

C_LONGINT:C283($Lon_i; $Lon_platform)
C_TEXT:C284($Path_buffer)


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

$0:=$Path_buffer+"Resources"+Folder separator:K24:12+"Images"+Folder separator:K24:12+"StructureEditor"+Folder separator:K24:12