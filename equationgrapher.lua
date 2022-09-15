-- mod-version:3 -- lite-xl 2.1

local core = require "core"
local command = require "core.command"
local common = require "core.common"
local config = require "core.config"
local View = require "core.view"
local style = require "core.style"

config.plugins.equationgrapher = common.merge({
	point_size = 3,
	steps = 10000,
	background_color = style.background,
	cross_color = style.text,
	graph_color = style.caret,
	font = style.big_font,
	config_spec = {
		name = "Equation Grapher",
		{
			label = "Point Size",
			description = "Enter point size.",
			path = "point_size",
			type = "number",
			default = 3,
			min = 1,
			max = 100
		},
		{
			label = "Steps",
			description = "Enter the steps.",
			path = "steps",
			type = "number",
			default = 10000,
			min = 1,
			max = 100000000
		},
	}
},config.plugins.equationgrapher) 


local GraphView = View:extend()

function GraphView:new(equation)
	GraphView.super.new(self)
	if equation == "" then error("No equation inputted.") end
	self.name = equation
	local eq = assert(load("return function(x) return "..equation.." end"))()
	if type(eq(0)) ~= "number" then error("Why is your equation returning a "..type(eq(0)).."?!") end
	self.equation = eq
	self.range = 1000
end

function GraphView:get_name()
	return "Graph: y = "..self.name
end

function GraphView:update()
	GraphView.super.update(self)
end

function GraphView:draw()
	self:draw_background(config.plugins.equationgrapher.background_color)
	
	local conf = config.plugins.equationgrapher
	local xPos, yPos = self.position.x, self.position.y
	local xSize, ySize = self.size.x, self.size.y
	local pointSize = conf.point_size
	
	-- draw cross
	local cross_color = conf.cross_color
	local font = conf.font
	local y = ySize/2-font:get_height()*0.2
	renderer.draw_rect(xPos+xSize/2, yPos, pointSize, ySize, cross_color)
	renderer.draw_rect(xPos, yPos+ySize/2, xSize, pointSize, cross_color)
	renderer.draw_text(font, tostring(-self.range), xPos, y, cross_color)
	renderer.draw_text(font, tostring(self.range), xPos+(xSize-(font:get_width(self.range))), y, cross_color)
	renderer.draw_text(font, "0", xPos+xSize/2+font:get_width("0")*0.2, y, cross_color)
	
	--draw equation
	for t=0, 1, 1/math.max(500, conf.steps) do
		renderer.draw_rect(
			(xPos+xSize/2)+common.lerp(-xSize/2, xSize/2, t),
			(yPos+ySize/2)-self.equation(common.lerp(-self.range, self.range, t)),
			pointSize, pointSize, conf.graph_color
		)
	end
end

function GraphView:on_mouse_wheel(d)
	self.range = self.range + d*10
end

command.add(nil, {
	["equation-grapher:graph-equation"] = function()
		core.command_view:enter("Equation to graph", {submit=function(e)
			local node = core.root_view:get_active_node()
			node:add_view(GraphView(e))
		end})
	end,
})

return GraphView
