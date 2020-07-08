## Love GML

This is basically a love2d abstraction based on the game maker architecture and definitions.

### Running the project
This project requires only Löve2d, really simple:

**Löve2D:** Go to [Löve2d website](https://love2d.org) and follow the instructions for your OS

### Game structure
* [core/](./core)
  * [entities/](./core/entities)
  * [libs/](./core/libs)
  * [modules/](./core/modules)
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
- **[STALKER-X](https://github.com/adnzzzzZ/STALKER-X)**: Camera module for LÖVE
- **[anim8](https://github.com/kikito/anim8)**: Animation library for LÖVE.

### GML Support
#### Object instance properties
<table>
   <thead>
      <tr>
         <th>Property</th>
         <th>Type</th>
         <th>Descriptions</th>
         <th>Support</th>
      </tr>
   </thead>
   <tbody>
      <tr>
        <td colspan="4" align="center">
          <strong>General variables</strong>
        </td>
      </tr>
      <tr>
         <td>id</td>
         <td>Integer</td>
         <td>Instance id on current room</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>solid</td>
         <td>Boolean</td>
         <td>Add solid behavior on collision</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>visible</td>
         <td>Boolean</td>
         <td>Run draw event from instance</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>persistent</td>
         <td>Boolean</td>
         <td>Persist instance attributes on current room</td>
         <td>:x:</td>
      </tr>
      <tr>
         <td>depth</td>
         <td>Integer</td>
         <td>Instance draw depth</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>alarm</td>
         <td>Array</td>
         <td>Set of event alarms</td>
         <td>:x:</td>
      </tr>
      <tr>
         <td>object_index</td>
         <td>Integer</td>
         <td>Index of the instance object</td>
         <td>:x:</td>
      </tr>
      <tr>
        <td colspan="4" align="center">
          <strong>Sprite variables</strong>
        </td>
      </tr>
      <tr>
         <td>sprite_index</td>
         <td>Sprite Instance</td>
         <td>Sprite to be rendered on object instance</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>sprite_width</td>
         <td>Float</td>
         <td>Current sprite_index width</td>
         <td>:x:</td>
      </tr>
      <tr>
         <td>sprite_height</td>
         <td>Float</td>
         <td>Current sprite_index height</td>
         <td>:x:</td>
      </tr>
      <tr>
         <td>sprite_xoffset</td>
         <td>Float</td>
         <td>Current sprite_index offset on x axis</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>sprite_yoffset</td>
         <td>Float</td>
         <td>Current sprite_index offset on y axis</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>image_alpha</td>
         <td>Float</td>
         <td>Current sprite_index opacity</td>
         <td>:x:</td>
      </tr>
      <tr>
         <td>image_angle</td>
         <td>Float</td>
         <td>Current sprite_index angle</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>image_blend</td>
         <td>undefined</td>
         <td>Current sprite_index blend effect</td>
         <td>:x:</td>
      </tr>
      <tr>
         <td>image_index</td>
         <td>Integer</td>
         <td>Current sprite_index frame index</td>
         <td>:x:</td>
      </tr>
      <tr>
         <td>image_number</td>
         <td>Integer</td>
         <td>Current sprite_index number of frames</td>
         <td>:x:</td>
      </tr>
      <tr>
         <td>image_speed</td>
         <td>Float</td>
         <td>Current sprite_index animation velocity</td>
         <td>:x:</td>
      </tr>
      <tr>
         <td>image_xscale</td>
         <td>Float</td>
         <td>Current sprite_index scale on x axis</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>image_yscale</td>
         <td>Float</td>
         <td>Current sprite_index scale on y axis</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
        <td colspan="4" align="center">
          <strong>Mask variables</strong>
        </td>
      </tr>
      <tr>
         <td>mask_index</td>
         <td>undefined</td>
         <td>Current mask of the object instance</td>
         <td>:x:</td>
      </tr>
      <tr>
         <td>bbox_bottom</td>
         <td>undefined</td>
         <td>TODO</td>
         <td>:x:</td>
      </tr>
      <tr>
         <td>bbox_left</td>
         <td>undefined</td>
         <td>TODO</td>
         <td>:x:</td>
      </tr>
      <tr>
         <td>bbox_right</td>
         <td>undefined</td>
         <td>TODO</td>
         <td>:x:</td>
      </tr>
      <tr>
         <td>bbox_top</td>
         <td>undefined</td>
         <td>TODO</td>
         <td>:x:</td>
      </tr>
      <tr>
        <td colspan="4" align="center">
          <strong>Movement variables</strong>
        </td>
      </tr>
      <tr>
         <td>direction</td>
         <td>Float</td>
         <td>Direction of the object applied on speed</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>speed</td>
         <td>Float</td>
         <td>speed of the object towards direction</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>gravity_direction</td>
         <td>Float</td>
         <td>Direction of the object applied on gravity</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>gravity</td>
         <td>Float</td>
         <td>speed of the object towards gravity_direction</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>friction</td>
         <td>Float</td>
         <td>friction applied to hspeed and vspeed of a instance</td>
         <td>:heavy_check_mark: (partial)</td>
      </tr>
      <tr>
         <td>hspeed</td>
         <td>Float</td>
         <td>horizontal speed of the instance</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>vspeed</td>
         <td>Float</td>
         <td>vertical speed of the instance</td>
         <td>:heavy_check_mark:</td>
      </tr>
   </tbody>
</table>



## Usage
TODO
