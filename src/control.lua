function stack_to_ghost(player)
	if player.cursor_stack and player.cursor_stack.valid and player.cursor_stack.valid_for_read then
		if player.cursor_stack.prototype.place_result or player.cursor_stack.prototype.place_as_tile_result then
			player.get_main_inventory().insert(player.cursor_stack)
			player.cursor_ghost = player.cursor_stack
			player.cursor_stack.clear()
		end
	end
end

function ghost_to_stack(player)
	if player.cursor_ghost and player.cursor_ghost.valid then
		local stack, idx = player.get_main_inventory().find_item_stack(player.cursor_ghost.name)
		if stack then
			player.cursor_stack.transfer_stack(stack)
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
		local player = game.get_player(event.player_index)
		toggle_ghost_mode(player)
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
