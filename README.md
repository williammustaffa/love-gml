## Love App Boilerplate

### Running the project
This project uses Löve2d along with lua language. To prepare your development environment you`ll need to install both.

**Löve2D:** Go to [Löve2d website](https://love2d.org) and follow the instructions for your OS

**Lua:** Go to [Lua's website](https://www.lua.org/start.html) and follow the instructions for your OS

### Structure
* [libs/](./libs)
  * [middleclass.lua](./libs/middleclass.lua)
  * [debugger.lua](./libs/debugger.lua)
  * [anim8.lua](./libs/anim8.lua)
* [core/](./core)
  * [entities/](./core/entities)
    * [Game.lua](./core/entities/Game.lua)
    * [Object.lua](./core/entities/Object.lua)
    * [Room.lua](./core/entities/Room.lua)
    * [Sound.lua](./core/entities/Sound.lua)
    * [Sprite.lua](./core/entities/Sprite.lua)
    * [Background.lua](./core/entities/Background.lua)
    * [Tileset.lua](./core/entities/Tileset.lua)
    * [Viewport.lua](./core/entities/Viewport.lua)
* [src/](./src)
  * [assets/](./src/assets)
    * [images](./src/assets/images)
    * [sounds](./src/assets/sounds)
  * [objects/](./src/objects)
  * [rooms/](./src/rooms)
  * [App.lua](./src/App.lua)
* [main.lua](./main.lua)
* [conf.lua](./conf.lua)
* [README.md](./README.md)

### Libs
- **[middleclass](https://github.com/kikito/middleclass)**: Object-orientation for Lua with class support.
- **[debugger](https://github.com/slembcke/debugger.lua)**: A simple, embedabble CLI debugger for Lua.
- **[STALKER-X](https://github.com/adnzzzzZ/STALKER-X)**: Camera module for LÖVE
- **[anim8](https://github.com/kikito/anim8)**: Animation library for LÖVE.

## Love App Boilerplate

### Running the project
This project uses Löve2d along with lua language. To prepare your development environment you`ll need to install both.

**Löve2D:** Go to [Löve2d website](https://love2d.org) and follow the instructions for your OS

**Lua:** Go to [Lua's website](https://www.lua.org/start.html) and follow the instructions for your OS

### Structure
* [libs/](./libs)
  * [middleclass.lua](./libs/middleclass.lua)
  * [debugger.lua](./libs/debugger.lua)
  * [anim8.lua](./libs/anim8.lua)
* [core/](./core)
  * [entities/](./core/entities)
    * [Game.lua](./core/entities/Game.lua)
    * [Object.lua](./core/entities/Object.lua)
    * [Room.lua](./core/entities/Room.lua)
    * [Sound.lua](./core/entities/Sound.lua)
    * [Sprite.lua](./core/entities/Sprite.lua)
    * [Background.lua](./core/entities/Background.lua)
    * [Tileset.lua](./core/entities/Tileset.lua)
    * [Viewport.lua](./core/entities/Viewport.lua)
* [src/](./src)
  * [assets/](./src/assets)
    * [images](./src/assets/images)
    * [sounds](./src/assets/sounds)
  * [objects/](./src/objects)
  * [rooms/](./src/rooms)
  * [App.lua](./src/App.lua)
* [main.lua](./main.lua)
* [conf.lua](./conf.lua)
* [README.md](./README.md)

### Libs
- **[middleclass](https://github.com/kikito/middleclass)**: Object-orientation for Lua with class support.
- **[debugger](https://github.com/slembcke/debugger.lua)**: A simple, embedabble CLI debugger for Lua.
- **[STALKER-X](https://github.com/adnzzzzZ/STALKER-X)**: Camera module for LÖVE
- **[anim8](https://github.com/kikito/anim8)**: Animation library for LÖVE.

### GML Support
#### Object instance properties
| Property | Type | Descriptions | Support |
| --- | --- | --- | --- |
| id | Integer | Instance id on current room | :x: |
| solid | Boolean |Add solid behavior on collision | :heavy_check_mark: |
| visible | Boolean |Run draw event from instance | :x: |
| persistent | Boolean | Persist instance attributes on current room | :x: |
| depth | Integer |Instance draw depth | :x: |
| alarm | Array | Set of event alarms |:x: |
| object_index | Integer | Index of the instance object | :x: |
| sprite_index | Sprite Instance | Sprite to be rendered on object instance | :heavy_check_mark: |
| sprite_width | Float | Current sprite_index width | :x: |
| sprite_height | Float | Current sprite_index height | :x: |
| sprite_xoffset | Float | Current sprite_index offset on x axis | :heavy_check_mark: |
| sprite_yoffset | Float | Current sprite_index offset on y axis | :heavy_check_mark: |
| image_alpha | Float | Current sprite_index opacity | :x: |
| image_angle | Float | Current sprite_index angle | :heavy_check_mark: |
| image_blend | undefined | Current sprite_index blend effect | :x: |
| image_index | Integer | Current sprite_index frame index | :x: |
| image_number | Integer | Current sprite_index number of frames | :x: |
| image_speed | Float | Current sprite_index animation velocity | :x: |
| image_xscale | Float | Current sprite_index scale on x axis | :heavy_check_mark: |
| image_yscale | Float | Current sprite_index scale on y axis | :heavy_check_mark: |
| mask_index | undefined | Current mask of the object instance | :x: |
| bbox_bottom | undefined | TODO | :x: |
| bbox_left | undefined | TODO | :x: |
| bbox_right | undefined | TODO | :x: |
| bbox_top | undefined | TODO | :x: |
| direction | Float | Direction of the object applied on speed | :heavy_check_mark: |
| speed | Float | speed of the object towards direction | :heavy_check_mark: |
| gravity_direction | Float | Direction of the object applied on gravity | :heavy_check_mark: |
| gravity | Float | speed of the object towards gravity_direction | :heavy_check_mark: |
| friction | Float | friction applied to hspeed and vspeed of a instance | :heavy_check_mark: (partial) |
| hspeed | Float | horizontal speed of the instance | :heavy_check_mark: |
| vspeed | Float | vertical speed of the instance | :heavy_check_mark: |


## Usage
TODO


## Usage
TODO
