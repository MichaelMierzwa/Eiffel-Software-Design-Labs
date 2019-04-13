note
	description: "Summary description for {GAME_ACCESS}."
	author: "Michael Mierzwa?"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	GAME_ACCESS

feature -- Games
	game: GAME
		once
			create Result.make_from_board (
				create {BOARD}.make_default)
		end

invariant
	game = game
end
