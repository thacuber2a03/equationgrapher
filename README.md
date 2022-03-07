# equationgrapher
A plugin for Lite XL that graphs y/x equations.

## How to use
To use, open it through the command palette as you would with any other command.
`x` is the plugin's independent variable.
You can also use Lua's functions, but you need to wrap them inside parentheses and then call them, like `(function)()`

NOTE: When making a graph, you should scale it up, since the grapher uses pixels as units.

## Configuration

You can configure the grapher's settings through the user module:

```lua
local conf = config.plugins.equationgrapher
conf.point_size = 3 -- size of the grapher's dots
conf.steps = 10000 -- amount of steps that the equation takes to render
conf.background_color = {common.color("#F8F8F8")} -- self explanatory
conf.cross_color = {common.color("#999999")} -- color of the background's cross.
conf.graph_color = {common.color("#000000")} -- color of the graph.
```
