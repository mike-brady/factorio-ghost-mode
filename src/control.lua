function set_cursor_ghost(player, item)
	player.clear_cursor()
	player.cursor_ghost = item
end

function stack_to_ghost(player)
	if player.cursor_stack and player.cursor_stack.valid and player.cursor_stack.valid_for_read then
		if player.cursor_stack.prototype.place_result or player.cursor_stack.prototype.place_as_tile_result then
			set_cursor_ghost(player, player.cursor_stack.name)
		end
	end
end

function ghost_to_stack(player)
	if player.cursor_ghost and player.get_main_inventory() then
		local stack, idx = player.get_main_inventory().find_item_stack(player.cursor_ghost.name)
		if stack and stack.prototype and stack.prototype.place_result then
			player.pipette_entity(stack.prototype.place_result)
		else
			player.cursor_stack.clear()
		end
		player.cursor_ghost = nil
	end
end

function toggle_ghost_mode(player)
	local state = player.is_shortcut_toggled('ghost_mode_toggle_shortcut')

	player.set_shortcut_toggled('ghost_mode_toggle_shortcut', not state)

	if state then
		ghost_to_stack(player)
	else
		stack_to_ghost(player)
	end
end

script.on_event('ghost_mode_toggle_custom_input',
	function(event)
		local player = game.get_player(event.player_index)
		toggle_ghost_mode(player)
	end
)

script.on_event(defines.events.on_lua_shortcut,
	function(event)
		if event.prototype_name == 'ghost_mode_toggle_shortcut' then
			local player = game.get_player(event.player_index)
			toggle_ghost_mode(player)
		end
	end
)

script.on_event(defines.events.on_player_cursor_stack_changed,
	function(event)
		local player = game.get_player(event.player_index)
		if player.is_shortcut_toggled('ghost_mode_toggle_shortcut') then
			stack_to_ghost(player)
		end
	end
)

script.on_event(defines.events.on_player_pipette,
	function(event)
		local player = game.get_player(event.player_index)
		if player.is_shortcut_toggled('ghost_mode_toggle_shortcut') then
			set_cursor_ghost(player, event.item.name)
		end
	end
)
