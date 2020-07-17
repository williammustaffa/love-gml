# Love GML

This is basically a love2d abstraction based on the game maker architecture and definitions.

## Table of contents

   * [Love GML](#love-gml)
   * [Table of contents](#table-of-contents)
   * [Instalation](#instalation)
   * [Usage](#usage)
   * [Usage](#usage)
   * [GML support](#gml-support)
      * [Object instance properties](#object-instance-properties)
   * [Third-party libraries](#third-party-libraries)
   * [License](#license)

## Instalation
This project requires only Löve2d to run locally:

**Löve2D:** Go to [Löve2d website](https://love2d.org) and follow the instructions for your OS

## Usage
TODO

## GML support
### Object instance properties
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
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>object_index</td>
         <td>Integer</td>
         <td>Index of the instance object</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
        <td colspan="4" align="center">
          <strong>X and Y</strong>
        </td>
      </tr>
      <tr>
         <td>x</td>
         <td>Float</td>
         <td>the x position of the instance</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>y</td>
         <td>Float</td>
         <td>the y position of the instance</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>xprevious</td>
         <td>Float</td>
         <td>previous x position of the instance</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>yprevious</td>
         <td>Float</td>
         <td>previous y position of the instance</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>xstart</td>
         <td>Float</td>
         <td>initial x position of the instance</td>
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>ystart</td>
         <td>Float</td>
         <td>initial y position of the instance</td>
         <td>:heavy_check_mark:</td>
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
         <td>:heavy_check_mark:</td>
      </tr>
      <tr>
         <td>sprite_height</td>
         <td>Float</td>
         <td>Current sprite_index height</td>
         <td>:heavy_check_mark:</td>
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
         <td>:heavy_check_mark:</td>
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

## Third-party libraries
- **[middleclass](https://github.com/kikito/middleclass)**: Object-orientation for Lua with class support.
- **[STALKER-X](https://github.com/adnzzzzZ/STALKER-X)**: Camera module for LÖVE
- **[anim8](https://github.com/kikito/anim8)**: Animation library for LÖVE.

## License
The MIT License (MIT)

Copyright (c) 2020 William Lima

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
