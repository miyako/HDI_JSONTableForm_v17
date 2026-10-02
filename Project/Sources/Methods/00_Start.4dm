//%attributes = {}
#DECLARE($params : Object)

var $splashWindowTitle : Text
var $i; $window : Integer
var $x; $y; $bottom; $right : Integer
var $options : Object

$splashWindowTitle:=""

If (Count parameters:C259=0)
	
	var $dataClass; $project; $path : Text
	For each ($dataClass; ds:C1482)
		If (ds:C1482[$dataClass].getCount()=0)
			$path:=File:C1566("/RESOURCES/"+$dataClass+".4ie").platformPath
			If (Test path name:C476($path)=Is a document:K24:1)
				$project:=File:C1566("/RESOURCES/"+$dataClass+".4si").getText()
				IMPORT DATA:C665($path; $project)
			End if 
		End if 
	End for each 
	
	ARRAY LONGINT:C221($windows; 0)
	WINDOW LIST:C442($windows)
	
	For ($i; 1; Size of array:C274($windows))
		$window:=$windows{$i}
		If (Window process:C446($window)=1) && (Get window title:C450($window)=$splashWindowTitle)
			GET WINDOW RECT:C443($x; $y; $bottom; $right; $window)
			CALL FORM:C1391($window; Formula:C1597(SET WINDOW RECT:C444($x; $y; $bottom; $right; $window)))
			return 
		End if 
	End for 
	
	CALL WORKER:C1389(1; Current method name:C684; {})
	
Else 
	
	SET MENU BAR:C67(1)
	
	$options:=New object:C1471
	$options.title:=Localized string:C991("HDI_Title")
	$options.blog:="blog.4d.com"
	$options.info:=Localized string:C991("HDI_Info")
	$options.minimumVersion:="1660"  // 1650 means 16R5   1601 means 16.1 (do not use !)
	//$options.license:=4D Write license  // IF ANY NEEDED
	
	// THE BACKGROUND PICTURE IS IN THE RESOURCES : Resources/Images/HDIabout.png
	// the picture size is 724 * 364
	
	$window:=Open form window:C675("HDI"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	SET WINDOW TITLE:C213($splashWindowTitle; $window)
	DIALOG:C40("HDI"; $options; *)
	
End if 
