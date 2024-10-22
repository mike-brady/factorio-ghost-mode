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
	icon = '__core__/graphics/icons/technology/effect/effect-ghost.png',
	icon_size = 64,
	small_icon = '__core__/graphics/icons/technology/effect/effect-ghost.png',
	small_icon_size = 64
}

data:extend({custom_input, shortcut})
