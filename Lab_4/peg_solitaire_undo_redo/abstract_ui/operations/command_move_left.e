note
	description: "Summary description for {COMMAND_MOVE_LEFT}."
	author: "Michael Mierzwa"
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_MOVE_LEFT

inherit
	COMMAND

create
	make

feature -- operations of the command
	execute
		do
			game.move_left (row, column)
		end

	undo
		do
			game.board.set_status (row, column    , game.board.occupied_slot)
			game.board.set_status (row, column - 1, game.board.occupied_slot)
			game.board.set_status (row, column - 2, game.board.unoccupied_slot)
		end

	redo
		do
			game.move_left (row, column)
		end
end
