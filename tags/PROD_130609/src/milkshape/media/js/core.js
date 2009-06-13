$(document).ready(function(){
	 $("textarea, input")
		 .focus(function(event){ $(this).css('border','solid 1px #56ccfe'); })
		 .blur(function(event){ $(this).css('border','solid 1px #cccccc'); });
});
