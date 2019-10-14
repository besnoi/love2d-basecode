require 'src/resources'
lovecc=require 'lib/lovecc'
Class=require 'lib/class'

require 'src/constants'

require 'lib/StateMachine'
require 'src/states/BaseState'

--[[
	Every State is broken into three parts:-
	init -> init functions of state go here 
	util -> update functions of state go here
	custom -> rendering functions of state go here

	And as a result the main file of the state is very small
	which saves a lot of overhead later
]]
require 'src/states/PromptState/main'
-- require 'src/states/PromptState/init'
require 'src/states/PromptState/util'
require 'src/states/PromptState/custom'

