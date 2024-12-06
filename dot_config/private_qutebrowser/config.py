
config.load_autoconfig(False)

#### tab-close 

config.unbind ("d")
config.bind("<Shift+d>", "tab-close")

#### Back in history
config.unbind ("H")
config.bind("<Shift+w>", "back")

#### Start page
c.url.start_pages=['qute://start']

config.bind('<Shift+X>', 'jseval (function () { '+
            '  var i, elements = document.querySelectorAll("body *");'+
            ''+
            '  for (i = 0; i < elements.length; i++) {'+
            '    var pos = getComputedStyle(elements[i]).position;'+
            '    if (pos === "fixed" || pos == "sticky") {'+
            '      elements[i].parentNode.removeChild(elements[i]);'+
            '    }'+
            '  }'+
            '})();');

config.bind(',ko', 'jseval (function () { '+
'  var i, elements = document.querySelectorAll("body *");'+
''+
'  for (i = 0; i < elements.length; i++) {'+
'    var pos = getComputedStyle(elements[i]).position;'+
'    if (pos === "fixed" || pos == "sticky") {'+
'      elements[i].parentNode.removeChild(elements[i]);'+
'    }'+
'  }'+
'})();');


