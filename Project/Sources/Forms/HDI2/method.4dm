Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		initHDI
		OBJECT Get pointer:C1124(Object named:K67:5; "varTxt")->:=TextTabControl{TabControl}
		
		
		ARRAY LONGINT:C221(arrTableID; 0)
		ARRAY TEXT:C222(arrTableName; 0)
		ARRAY TEXT:C222(arrFieldName; 0)
		ARRAY TEXT:C222(arrFieldLabel; 0)
		ARRAY LONGINT:C221(arrFieldType; 0)
		ARRAY PICTURE:C279(arrFieldPic; 0)
		ARRAY BOOLEAN:C223(arrFieldDisplay; 0)
		
		For ($iTable; 1; Last table number:C254)
			If (Is table number valid:C999($iTable))
				
				If ($iTable#1)  //only for HDI
					APPEND TO ARRAY:C911(arrTableID; $iTable)
					APPEND TO ARRAY:C911(arrTableName; Table name:C256($iTable))
				End if 
				
			End if 
		End for 
		
		
		ARRAY PICTURE:C279(arrPict; 38)
		
		$path:=getIconPath
		
		READ PICTURE FILE:C678($path+"Field_1.png"; arrPict{Is alpha field:K8:1})
		READ PICTURE FILE:C678($path+"Field_2.png"; arrPict{Is text:K8:3})
		READ PICTURE FILE:C678($path+"Field_3.png"; arrPict{Is date:K8:7})
		READ PICTURE FILE:C678($path+"Field_4.png"; arrPict{Is time:K8:8})
		READ PICTURE FILE:C678($path+"Field_5.png"; arrPict{Is boolean:K8:9})
		READ PICTURE FILE:C678($path+"Field_6.png"; arrPict{Is integer:K8:5})
		READ PICTURE FILE:C678($path+"Field_7.png"; arrPict{Is longint:K8:6})
		READ PICTURE FILE:C678($path+"Field_8.png"; arrPict{Is integer 64 bits:K8:25})
		READ PICTURE FILE:C678($path+"Field_9.png"; arrPict{Is real:K8:4})
		READ PICTURE FILE:C678($path+"Field_10.png"; arrPict{_o_Is float:K8:26})
		READ PICTURE FILE:C678($path+"Field_12.png"; arrPict{Is picture:K8:10})
		READ PICTURE FILE:C678($path+"Field_14.png"; arrPict{Is object:K8:27})
		
		
		
		If (Size of array:C274(arrTableName)>0)
			arrTableName:=1
			loadField
		End if 
		
		C_BOOLEAN:C305(isOutput)
		isOutput:=True:C214
		
		C_BOOLEAN:C305(isTemplate1)
		isTemplate1:=True:C214
		
		If (Is Windows:C1573)
			ST SET ATTRIBUTES:C1093(TextTabControl{1}; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 14)
		Else 
			ST SET ATTRIBUTES:C1093(TextTabControl{1}; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 16)
		End if 
		
	: (Form event code:C388=On Page Change:K2:54)
		
		If (Is Windows:C1573)
			ST SET ATTRIBUTES:C1093(TextTabControl{TabControl}; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 14)
		Else 
			ST SET ATTRIBUTES:C1093(TextTabControl{TabControl}; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 16)
		End if 
		
		OBJECT Get pointer:C1124(Object named:K67:5; "varTxt")->:=TextTabControl{TabControl}
		
		
End case 