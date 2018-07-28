<!--
function resizeFrame(f)
	{
	// Firefox worked fine. Internet Explorer shows scrollbar because of frameborder 
	f.style.height = f.contentWindow.document.body.scrollHeight + "px";
	//f.style.height = "400px";
	}
	
function ChangeHeight()
	{
	// quit if this function has already been called
	if (arguments.callee.done) return;
	// flag this function so we dont do the same thing twice
	arguments.callee.done = true;

	if (document.getElementById)
		{
		//не нужно, так как работает изнутри фрейма
		//document.getElementById("MainTD").height = document.getElementById("MainFrame").contentWindow.document.getElementById("maintable").clientHeight;
		
		resizeFrame(document.getElementById("LeftMenu"));
		resizeFrame(document.getElementById("MainFrame"));
		resizeFrame(document.getElementById("CopyRight"));
		resizeFrame(document.getElementById("Adress"));
		
		max = 1;//Картинки в названии имеют числа от 1 до max
		document.getElementById("BigLogo").src="images/biglogo" + Math.floor(Math.random()*max+1) + ".gif";
		//если левое меню выше картинки, то картинка вытянется в высоту (но не сожмется, если меню ниже картики)
		//document.getElementById("BigLogo").style.height = document.getElementById("LeftMenu").clientHeight + "px";
		
		resizeFrame(document.getElementById('Left').contentWindow.document.getElementById('Send'));
		resizeFrame(document.getElementById('Left'));

		}
	}

function ChangeHeightFromChild()
	{
	// quit if this function has already been called
	//if (arguments.callee.done) return;
	// flag this function so we dont do the same thing twice
	//arguments.callee.done = true;
	if (document.getElementById)
		{
		max = 1;//Картинки в названии имеют числа от 1 до max
		parent.document.getElementById("BigLogo").src="images/biglogo" + Math.floor(Math.random()*max+1) + ".gif";
		//parent.document.getElementById("BigLogo").style.height = parent.document.getElementById("LeftMenu").clientHeight + "px";

		parent.document.getElementById("MainFrame").style.height = Math.max(document.getElementById("maintable").clientHeight,parent.document.getElementById("LeftMenu").clientHeight) + "px";
		//повтор из-за глюков чтоб докрутился до нужного якоря #low
		parent.document.getElementById("MainFrame").style.height = Math.max(document.getElementById("maintable").clientHeight,parent.document.getElementById("LeftMenu").clientHeight) + "px";
		}
	results = document.getElementsByClass('none');

		for (i = 0; current = results[i]; i++) 
		{
		document.body.setAttribute("class", "attribute-test");
		if (document.body.className == "attribute-test")
			{
			// Атрибуты работают корректно (не Internet Explorer или будущая исправленная версия)
			// Работаем с атрибутами
			current.href = "";
			current.setAttribute("onClick", "return false;");
			current.setAttribute("onMouseOver", "return false;");
			}
		else
			{
  			// Использовать атрибуты нельзя (Internet Explorer)
			// Альтернативный код только для Internet Explorer
			current.href = "";
			current.onmouseover = function() {window.status='no'; return true;};
			current.onclick = function() {window.status='no'; return false;};
			}
		}
	}

function redirectOutput(myForm)
	{
	var w = window.open('about:blank','Popup_Window','...param s...');
	myForm.target = 'Popup_Window';
	return true;
	}

function setFormAttributes(form) //нужен для заполнения значений в форме для FF и Crome (для IE не мешает)
	{
    for (var i in form.elements)
    	{
        var cel = form.elements[i];
        if (cel)
        switch (cel.tagName)
        	{
            case 'INPUT':
            switch (cel.type)
            	{
                case 'text':
                cel.setAttribute('value', cel.value);
                break;
                case 'checkbox': case 'radio':
                (cel.checked) ? cel.setAttribute('checked', 'checked') : cel.removeAttribute('checked');
                break;
                }
            break;
            case 'TEXTAREA':
            cel.firstChild.data = cel.value;
            break;
            case 'SELECT':
            var opts = cel.getElementsByTagName('option');
            for (var j = 0; j < opts.length; j++)
            	{
            	(cel.selectedIndex == j) ? opts[j].setAttribute('selected', 'selected') : opts[j].removeAttribute('selected');
                }
            break;
            }
        }
    }
function sendRequest()
	{
	var S = "";
	for (i=0; i < document.data_form.elements.length; i++)
		{
		if (document.data_form.elements[i].type == "button")
			document.data_form.elements[i].disabled = true;
		document.data_form.elements[i].readonly = true;
		}
	setFormAttributes(document.data_form);
	document.post_form.saved_data.value=document.data_form.innerHTML;
	document.post_form.from.value = document.data_form.mailfrom.value;
	document.post_form.name.value = document.data_form.username.value;

	for (i=0; i < document.data_form.elements.length; i++)
		{
		document.data_form.elements[i].disabled = false;
		document.data_form.elements[i].readonly = false;
		}
	document.post_form.elements["page"].value = "<BR>" + '<A href="' + parent.parent.document.getElementById("MainFrame").contentWindow.document.location.href + '">' + parent.parent.document.getElementById("MainFrame").contentWindow.document.title + "</A><BR>(" + parent.parent.document.getElementById("MainFrame").contentWindow.document.location.href + ")";
	document.post_form.submit();
	}
function loadFormVal()
	{
	window.location.href.substring(window.location.href.lastIndexOf("=")+1,window.location.href.length-1);
	return true;
	}

document.getElementsByClass = function(searchClass,node,tag)
	{
  	 var classElements = new Array();
  	 if ( node == null )
  	    node = document;
  	 if ( tag == null )
 	     tag = '*';
  	 var elements = node.getElementsByTagName(tag);
  	 var elemLength = elements.length;
  	 var pattern = new RegExp('(^|\\\\s)'+searchClass+'(\\\\s|$)');
  	 for (var i = 0, j = 0; i < elemLength; i++) 
  	 	{
   	   	if ( pattern.test(elements[i].className) ) 
   	   		{
    	     classElements[j] = elements[i];
  	       	j++;
  	    	}
   		}
   	return classElements;
	}
//-->