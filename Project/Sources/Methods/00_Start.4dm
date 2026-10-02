//%attributes = {}
#DECLARE($params : Object)

var $splashWindowTitle : Text
var $i; $window : Integer
var $x; $y; $bottom; $right : Integer
var $options : Object

$splashWindowTitle:=""

If (Count parameters=0)
	
	ARRAY LONGINT($windows; 0)
	WINDOW LIST($windows)
	
	For ($i; 1; Size of array($windows))
		$window:=$windows{$i}
		If (Window process($window)=1) && (Get window title($window)=$splashWindowTitle)
			GET WINDOW RECT($x; $y; $bottom; $right; $window)
			CALL FORM($window; Formula(SET WINDOW RECT($x; $y; $bottom; $right; $window)))
			return 
		End if 
	End for 
	
	CALL WORKER(1; Current method name; {})
	
Else 
	
	SET MENU BAR(1)
	
	$options:=New object
	$options.title:=Localized string("HDI_Title")
	$options.blog:="blog.4d.com"
	$options.info:=Localized string("HDI_Info")
	$options.minimumVersion:="1660"  // 1650 means 16R5   1601 means 16.1 (do not use !)
	//$options.license:=4D Write license  // IF ANY NEEDED
	
	// THE BACKGROUND PICTURE IS IN THE RESOURCES : Resources/Images/HDIabout.png
	// the picture size is 724 * 364
	
	$window:=Open form window("HDI"; Plain form window; Horizontally centered; Vertically centered)
	SET WINDOW TITLE($splashWindowTitle; $window)
	DIALOG("HDI"; $options; *)
	
End if 
