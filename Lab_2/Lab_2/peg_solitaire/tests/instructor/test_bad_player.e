note
	description: "Tests on bad players."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_BAD_PLAYER

inherit
	ES_TEST

create
	make

feature -- Constructor
	make
		do
			add_boolean_case (agent test_bad_player_loses_easy_board)
		end

feature -- Tests
	test_bad_player_loses_easy_board: BOOLEAN
		local
			player: BAD_PLAYER
		do
			comment ("test: bad player loses an pyra board")
			create player.make

			player.game.make_easy
			player.loses_easy_board
			Result :=
					player.game.is_over
				and not player.game.is_won
			check Result end
		end
end
