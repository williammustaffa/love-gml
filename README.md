## Love App Boilerplate

### Running the project
This project uses Löve2d along with lua language. To prepare your development environment you`ll need to install both.
Lua

**Löve2D:** Go to [Löve2d website](https://love2d.org) and follow the instructions for your OS

**Lua:** Go to [Lua's website](https://www.lua.org/start.html) and follow the instructions for your OS

### Structure
* [libs/](./libs)
  * [middleclass.lua](./libs/middleclass.lua)
  * [tick.lua](./libs/tick.lua)
  * [debugger.lua](./libs/debugger.lua)
* [core/](./core)
  * [entities/](./core/entities)
    * [Actor.lua](./core/entities/Actor.lua)
    * [Scene.lua](./core/entities/Scene.lua)
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
  * [scenes/](./src/scenes)
  * [App.lua](./src/App.lua)
* [main.lua](./main.lua)
* [README.md](./README.md)

### Libs
- **[middleclass](https://github.com/kikito/middleclass)**: Object-orientation for Lua with class support
- **[tick](https://github.com/rxi/tick)**: Lua module for delaying function calls
- **[debugger](https://github.com/slembcke/debugger.lua)**: A simple, embedabble CLI debugger for Lua.

## Usage
TODO
