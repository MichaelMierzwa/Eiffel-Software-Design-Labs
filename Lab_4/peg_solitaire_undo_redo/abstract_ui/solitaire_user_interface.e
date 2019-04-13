note
	description: "Summary description for {SOLITAIRE_USER_INTERFACE}."
	author: "Michael Mierzwa"
	date: "$Date$"
	revision: "$Revision$"

class
	SOLITAIRE_USER_INTERFACE

create
	new_cross_game,
	new_plus_game,
	new_pyramid_game,
	new_arrow_game,
	new_diamond_game,
	new_skull_game

feature -- Attributes
	ga: GAME_ACCESS
	game: GAME
	history: HISTORY
	message: STRING

feature -- Events
	new_cross_game
			-- Start a cross game.
		do

			game:= ga.game
			game.make_cross
			create history.make
			message:= success

		end

	new_plus_game
			-- Start a plus game.
		do

			game:= ga.game
			game.make_plus
			create history.make
			message:= success

		end

	new_pyramid_game
			-- Start a pyramid game.
		do

			game:= ga.game
			game.make_pyramid
			create history.make
			message:= success
		end

	new_arrow_game
			-- Start a new arrow game.
		do

			game:= ga.game
			game.make_arrow
			create history.make
			message:= success
		end

	new_diamond_game
			-- Start a new diamond game.
		do

			game:= ga.game
			game.make_diamond
			create history.make
			message:= success
		end

	new_skull_game
			-- Start a new skull game.
		do

			game:= ga.game
			game.make_skull
			create history.make
			message:= success
		end

	move_left (r, c: INTEGER)
			-- User decides to move slot at (r, c) left.
		local
			command:COMMAND_MOVE_LEFT
		do
			if(not game.board.is_valid_row (r))	then
				message:= error_row_not_valid (r)
			elseif(not game.board.is_valid_column (c)) then
				message:= error_column_not_valid(c)
			elseif(not game.board.is_valid_column (c - 1))then
				message:= error_column_not_valid(c-1)
			elseif(not game.board.is_valid_column (c - 2))then
				message:= error_column_not_valid(c-2)
			elseif(not (game.board.status_of (r, c    ) = game.board.occupied_slot))then
				message:= error_slot_not_of_status (r, c, game.board.occupied_slot)
			elseif(not (game.board.status_of (r, c -1  ) = game.board.occupied_slot))then
				message:= error_slot_not_of_status (r, c-1, game.board.occupied_slot)
			elseif(not (game.board.status_of (r, c -2   ) = game.board.unoccupied_slot))then
				message:= error_slot_not_of_status (r, c-2, game.board.unoccupied_slot)
			else
					create command.make(r,c)
					command.execute
					history.extend_history (command)
					history.forth
					message:= success
			end

			-- Error reporting should be done here
			-- before you invoke the corresponding game feature.
		end

	move_right (r, c: INTEGER)
			-- User decides to move slot at (r, c) right.
		local
			command:COMMAND_MOVE_RIGHT
		do
			if(not game.board.is_valid_row (r))	then
				message:= error_row_not_valid (r)
			elseif(not game.board.is_valid_column (c)) then
				message:=  error_column_not_valid(c)
			elseif(not game.board.is_valid_column (c + 1))then
				message:= error_column_not_valid(c+1)
			elseif(not game.board.is_valid_column (c + 2))then
				message:= error_column_not_valid(c+2)
			elseif(not (game.board.status_of (r, c    ) = game.board.occupied_slot))then
				message:= error_slot_not_of_status (r, c, game.board.occupied_slot)
			elseif(not (game.board.status_of (r, c +1  ) = game.board.occupied_slot))then
				message:= error_slot_not_of_status (r, c+1, game.board.occupied_slot)
			elseif(not (game.board.status_of (r, c +2   ) = game.board.unoccupied_slot))then
				message:= error_slot_not_of_status (r, c+2, game.board.unoccupied_slot)
			else
					create command.make(r,c)
					command.execute
					history.extend_history (command)
					history.forth
					message:= success
			end
			-- Error reporting should be done here
			-- before you invoke the corresponding game feature.
		end

	move_up (r, c: INTEGER)
			-- User decides to move slot at (r, c) up.
		local
			command:COMMAND_MOVE_UP
		do
			if(not game.board.is_valid_row (r))	then
				message:= error_row_not_valid (r)
			elseif(not game.board.is_valid_column (c)) then
				message:= error_column_not_valid(c)
			elseif(not game.board.is_valid_row (r + 1))then
				message:= error_row_not_valid (r+1)
			elseif(not game.board.is_valid_row (r + 2))then
				message:= error_row_not_valid (r+2)
			elseif(not (game.board.status_of (r    , c) = game.board.occupied_slot))then
				message:= error_slot_not_of_status (r, c, game.board.occupied_slot)
			elseif(not (game.board.status_of (r +1   , c) = game.board.occupied_slot))then
				message:= error_slot_not_of_status (r+1, c, game.board.occupied_slot)
			elseif(not (game.board.status_of (r +2   , c) = game.board.unoccupied_slot))then
				message:= error_slot_not_of_status (r+2, c, game.board.unoccupied_slot)
			else
					create command.make(r,c)
					command.execute
					history.extend_history (command)
					history.forth
					message:= success
			end
			-- Error reporting should be done here
			-- before you invoke the corresponding game feature.
		end

	move_down (r, c: INTEGER)
			-- User decides to move slot at (r, c) down.
		local
			command:COMMAND_MOVE_DOWN
		do
			if(not game.board.is_valid_row (r))	then
				message:= error_row_not_valid (r)
			elseif(not game.board.is_valid_column (c)) then
				message:= error_column_not_valid(c)
			elseif(not game.board.is_valid_row (r - 1))then
				message:= error_row_not_valid (r-1)
			elseif(not game.board.is_valid_row (r - 2))then
				message:= error_row_not_valid (r-2)
			elseif(not (game.board.status_of (r    , c) = game.board.occupied_slot))then
				message:= error_slot_not_of_status (r, c, game.board.occupied_slot)
			elseif(not (game.board.status_of (r -1   , c) = game.board.occupied_slot))then
				message:= error_slot_not_of_status (r-1, c, game.board.occupied_slot)
			elseif(not (game.board.status_of (r -2   , c) = game.board.unoccupied_slot))then
				message:= error_slot_not_of_status (r-2, c, game.board.unoccupied_slot)
			else
					create command.make(r,c)
					command.execute
					history.extend_history (command)
					history.forth
					message:= success
			end
			-- Error reporting should be done here
			-- before you invoke the corresponding game feature.
		end

	undo
			-- Undo the last command not yet undone, if any.
		do
			if
				history.is_empty
				--history.on_item
			then
				message:= error_nothing_to_undo
			else
				history.item.undo
				history.back
				message := success
			end

		end

	redo
			-- Redo the next command not yet redone, if any.
		do
			if
				history.is_last
			then
				message:= error_nothing_to_redo
			else
				history.forth
				history.item.redo
				message := success
			end
		end

feature -- Messages
	success: STRING
		do
			Result := "Operation successfully completed."
		end

	error_row_not_valid (r: INTEGER): STRING
		do
			create Result.make_from_string (
				"Row " + r.out + " is not valid.")
		end

	error_column_not_valid (c: INTEGER): STRING
		do
			create Result.make_from_string (
				"Column " + c.out + " is not valid.")
		end

	error_slot_not_of_status (r, c: INTEGER; status: SLOT_STATUS): STRING
		do
			create Result.make_from_string (
				"Slot at (" + r.out + ", " + c.out +
					") is not " + status.out)
		end

	error_nothing_to_undo: STRING
		do
			Result := "Nothing to undo."
		end

	error_nothing_to_redo: STRING
		do
			Result := "Nothing to redo."
		end
end
