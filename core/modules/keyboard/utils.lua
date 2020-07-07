local ctrl = require ('core.libs.ctrl')()
function ctrl:inputpressed ( name, value ) print ( "pressed", name, value ) end
function ctrl:inputreleased ( name, value ) print ( "released", name, value ) end
function ctrl:inputmoved ( name, value ) print ( "moved", name, value ) end
ctrl:bind( "fire", { "keyboard", "space" } )
ctrl:bind( "fire", { "joystick", "default", "button", 1 } )
ctrl:bind( "fire", { "mouse", "left" } )
ctrl:hookup()