//%attributes = {"invisible":true}

// ----------------------------------------------------
// Method: generateForm
// Description
// 
//
// Parameters
//    $isOutput: boolean; type of the form (true = input - false = output)
//    $isTemplate1: template
// ----------------------------------------------------
#DECLARE($isOutput : Boolean; $isTemplate1 : Boolean)

var $oFormTemplate; $oObjectTemplate; $oFormTemp; $oStatic; $oInput; $oColumn : Object
var $i; $lastElementPos; $numItem : Integer
var $path : Text

// Load Object Template
$oObjectTemplate:=JSON Parse:C1218(Document to text:C1236(Get 4D folder:C485(Current resources folder:K5:16)+"template"+Folder separator:K24:12+"objectTemplate.json"))


If ($isOutput=False:C215)  //input Form
	
	// load input form template
	If ($isTemplate1)
		$oFormTemplate:=JSON Parse:C1218(Document to text:C1236(Get 4D folder:C485(Current resources folder:K5:16)+"template"+Folder separator:K24:12+"inputTemplate.json"))
	Else 
		$oFormTemplate:=JSON Parse:C1218(Document to text:C1236(Get 4D folder:C485(Current resources folder:K5:16)+"template"+Folder separator:K24:12+"inputTemplate2.json"))
	End if 
	
	//Form
	$oFormTemp:=OB Copy:C1225($oFormTemplate)
	$oFormTemp.windowTitle:=arrTableName{arrTableName}
	$oFormTemp.name:="ListForm:"+arrTableName{arrTableName}
	
	
	$lastElementPos:=$oFormTemplate.definition.mostTop
	
	For ($i; 1; Size of array:C274(arrFieldName))
		
		If (arrFieldDisplay{$i}=True:C214)
			
			// create label object
			$oStatic:=OB Copy:C1225($oObjectTemplate.staticText)
			$oStatic.left:=$oFormTemp.definition.mostLeft
			$oStatic.text:=arrFieldLabel{$i}+":"
			$oStatic.top:=$lastElementPos+$oFormTemp.definition.spacingY
			
			// insert label object in form
			$oFormTemp.pages[1].objects["text"+arrFieldName{$i}]:=$oStatic
			
			
			// create input object
			Case of 
				: (arrFieldType{$i}=Is picture:K8:10)
					$oInput:=OB Copy:C1225($oObjectTemplate.pictureInput)
					
				: (arrFieldType{$i}=Is object:K8:27)
					$oInput:=OB Copy:C1225($oObjectTemplate.objectInput)
					
				: (arrFieldType{$i}=Is boolean:K8:9)
					$oInput:=OB Copy:C1225($oObjectTemplate.booleanInput)
					
				: (arrFieldType{$i}=Is time:K8:8)
					$oInput:=OB Copy:C1225($oObjectTemplate.timeInput)
					
				: (arrFieldType{$i}=Is date:K8:7)
					$oInput:=OB Copy:C1225($oObjectTemplate.dateInput)
					
				Else 
					$oInput:=OB Copy:C1225($oObjectTemplate.textInput)
					
			End case 
			
			$oInput.dataSource:="["+arrTableName{arrTableName}+"]"+arrFieldName{$i}
			$oInput.left:=$oStatic.left+$oStatic.width+$oFormTemp.definition.spacingX
			$oInput.top:=$oStatic.top
			
			If ($oInput.sizingX="grow")
				$oInput.width:=$oFormTemp.windowMinWidth-$oInput.left-20
			End if 
			
			// insert input object in form
			$oFormTemp.pages[1].objects["var"+arrFieldName{$i}]:=$oInput
			
			
			// memorize the Y position of the last input element
			$lastElementPos:=$oInput.top+$oInput.height
			
		End if 
		
	End for 
	
	//if necessary, define the new  minimal height of the form
	If ($oFormTemp.windowMinHeight<($lastElementPos+20))
		$oFormTemp.windowMinHeight:=$lastElementPos+20
		$oFormTemp.definition.mostBottom:=$lastElementPos
	End if 
	
	
	
Else   // Output Form
	
	// load output Form template
	If ($isTemplate1)
		$oFormTemplate:=JSON Parse:C1218(Document to text:C1236(Get 4D folder:C485(Current resources folder:K5:16)+"template"+Folder separator:K24:12+"outputTemplate.json"))
	Else 
		$oFormTemplate:=JSON Parse:C1218(Document to text:C1236(Get 4D folder:C485(Current resources folder:K5:16)+"template"+Folder separator:K24:12+"outputTemplate2.json"))
	End if 
	
	//Form
	$oFormTemp:=OB Copy:C1225($oFormTemplate)
	$oFormTemp.windowTitle:=arrTableName{arrTableName}
	$oFormTemp.name:="ListForm:"+arrTableName{arrTableName}
	$oFormTemp.pages[1].objects.myListBox.table:=arrTableName{arrTableName}
	$oFormTemp.pages[1].objects.myListBox.columns:=New collection:C1472()
	
	$numItem:=0
	
	For ($i; 1; Size of array:C274(arrFieldName))
		
		If (arrFieldDisplay{$i}=True:C214)
			
			// create a listbox column
			$oColumn:=OB Copy:C1225($oObjectTemplate.colListbox)
			$oColumn.objectName:="col"+arrFieldName{$i}
			$oColumn.dataSource:="["+arrTableName{arrTableName}+"]"+arrFieldName{$i}
			$oColumn.header:=New object:C1471("text"; arrFieldLabel{$i})
			
			// insert the column in form
			$oFormTemp.pages[1].objects.myListBox.columns[$numItem]:=$oColumn
			
			$numItem:=$numItem+1
		End if 
		
	End for 
	
End if 



// create  a preview in a subform
ALL RECORDS:C47(Table:C252(arrTableID{arrTableName})->)
FIRST RECORD:C50(Table:C252(arrTableID{arrTableName})->)
OBJECT SET SUBFORM:C1138(*; "Subform"; $oFormTemp)



// save the for in a JSON file

$path:=Get 4D folder:C485(Current resources folder:K5:16)+"JSONForms"
If (Test path name:C476($path)<0)
	CREATE FOLDER:C475($path)
End if 

If ($isOutput)
	$path:=$path+Folder separator:K24:12+arrTableName{arrTableName}+"Output"+".json"
Else 
	$path:=$path+Folder separator:K24:12+arrTableName{arrTableName}+"Input"+".json"
End if 

TEXT TO DOCUMENT:C1237($path; JSON Stringify:C1217($oFormTemp; *))

