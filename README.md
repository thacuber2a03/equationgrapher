# equationgrapher
A plugin for Lite XL that graphs y=x equations.

## How to use
To use, open it through the command palette as you would with any other command.
`x` is the plugin's independent variable.
You can also use Lua's functions, but you need to wrap them inside parentheses and then call them, like 
```lua
(function(x) --[[your code here]] end)(x)
```

## Configuration

You can configure the grapher's settings through the user module:

```lua
local conf = config.plugins.equationgrapher
conf.point_size = 3 -- size of the grapher's dots
conf.steps = 10000 -- amount of steps that the equation takes to render
conf.background_color = style.background -- self explanatory
conf.cross_color = style.text -- color of the background's cross.
conf.graph_color = style.caret -- color of the graph.
conf.font = style.font -- yes
```
## Screenshots

![image](https://user-images.githubusercontent.com/70547062/157139008-29eea875-9456-4e43-8e9c-bfe7c4b9d051.png)
![image](https://user-images.githubusercontent.com/70547062/157139046-ff49ea5c-7965-449e-8c67-6058f4882259.png)
![image](https://user-images.githubusercontent.com/70547062/157139011-07259591-d2b9-42c7-988d-b7da53623a52.png)
