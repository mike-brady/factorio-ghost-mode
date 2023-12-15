function cursor_stack_to_ghost(player)
	if player.cursor_stack and player.cursor_stack.valid and player.cursor_stack.valid_for_read then
		player.get_main_inventory().insert({name=player.cursor_stack.name, count=player.cursor_stack.count})
		player.cursor_ghost = player.cursor_stack.name
		player.cursor_stack.clear()
	end
end

function cursor_ghost_to_stack(player)
	if player.cursor_ghost then
		player.pipette_entity(player.cursor_ghost.place_result)
	end
end


function toggle_ghost_mode(player)
	local state = player.is_shortcut_toggled('ghost_mode_toggle_shortcut')

	player.set_shortcut_toggled('ghost_mode_toggle_shortcut', not state)

	if state then
		cursor_ghost_to_stack(player)
	else
		cursor_stack_to_ghost(player)
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
			cursor_stack_to_ghost(player)
		end
	end
)
