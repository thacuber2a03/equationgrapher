-- mod-version:2 -- lite-xl 2.0

local core = require "core"
local command = require "core.command"
local common = require "core.common"
local config = require "core.config"
local View = require "core.view"
local style = require "core.style"

config.plugins.equationgrapher = {
	point_size = 3,
	steps = 10000,
	background_color = style.background,
	cross_color = style.text,
	graph_color = style.caret
}

local GraphView = View:extend()

function GraphView:new(equation)
	GraphView.super.new(self)
	if equation == "" then error("No equation inputted.") end
	self.name = equation
	local eq = assert(load("return function(x) return "..equation.." end"))()
	if not pcall(eq, 0) then error("Someting went wrong. Doublecheck your equation and try again.") end
	if type(eq(0)) == "string" then error("Why is your equation returning a string?!") end
	self.equation = eq
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
	renderer.draw_rect(xPos+xSize/2, yPos, pointSize, ySize, cross_color)
	renderer.draw_rect(xPos, yPos+ySize/2, xSize, pointSize, cross_color)
	
	--draw equation
	for t=0, 1, 1/math.max(500, conf.steps) do
		renderer.draw_rect(
			(xPos+xSize/2)+common.lerp(-xSize/2, xSize/2, t),
			(yPos+ySize/2)-self.equation(common.lerp(-xSize/2, xSize/2, t)),
			pointSize, pointSize, conf.graph_color
		)
	end
end

command.add(nil, {
	["equation-grapher:graph-equation"] = function()
		core.command_view:enter("Equation to graph", function(e)
			local node = core.root_view:get_active_node()
			node:add_view(GraphView(e))
		end)
	end,
})

return GraphView
