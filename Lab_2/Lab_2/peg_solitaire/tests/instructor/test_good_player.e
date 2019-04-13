note
	description: "Tests on good players."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_GOOD_PLAYER

inherit
	ES_TEST

create
	make

feature -- Constructor
	make
		do
			add_boolean_case (agent test_good_player_wins_easy_board)
		end

feature -- Tests
	test_good_player_wins_easy_board: BOOLEAN
		local
			player: GOOD_PLAYER
		do
			comment ("test: good player wins an easy board")
			create player.make

			player.game.make_easy
			player.wins_easy_board
			Result :=
					player.game.is_over
				and player.game.is_won
			check Result end
		end
end
