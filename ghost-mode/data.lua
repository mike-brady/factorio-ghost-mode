local custom_input = {
	type = 'custom-input',
	action = 'lua',
	name = 'ghost_mode_toggle_custom_input',
	key_sequence =  'SHIFT + G',
	consuming = 'none'
}

local shortcut = {
	type = 'shortcut',
	name = 'ghost_mode_toggle_shortcut',
	localised_name = {'controls.ghost_mode_toggle_custom_input'},
	associated_control_input = 'ghost_mode_toggle_custom_input',
	toggleable = true,
	action = 'lua',
	icon = {
		filename = '__core__/graphics/icons/mip/ghost-entity.png',
		width = 32,
		height = 32,
		scale = 1,
		flags = {'icon'}
	},
}

data:extend({custom_input, shortcut})
