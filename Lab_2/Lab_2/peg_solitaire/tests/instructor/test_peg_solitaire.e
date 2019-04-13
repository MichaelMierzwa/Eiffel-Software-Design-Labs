note
	description: "Tests on peg solitaire games."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_PEG_SOLITAIRE

inherit
	ES_TEST

create
	make

feature -- Constructor
	make
		do
			add_boolean_case (agent test_easy_game_creation)
		end

feature -- Templates
	bta: BOARD_TEMPLATES_ACCESS

feature -- Tests of Creation
	test_easy_game_creation: BOOLEAN
		local
			g: GAME
		do
			comment ("test: game creation with easy board")
			create g.make_easy
			Result :=
					g.board ~ bta.templates.easy_board
				and not g.is_over
				and not g.is_won
			check Result end

			Result := g.out ~ "[
			Game is over: No
			Game is won : No
			Board Status:
			***.***
			***O***
			***O***
			***.***
			***O***
			***.***
			*******
			]"
			check Result end
		end
end
