note
	description: "Summary description for {TEST_GAME}."
	author: "Michael Mierzwa"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_GAME

inherit
	ES_TEST

create
	make

feature -- Constructor
	make
		do
			add_boolean_case (agent bad_loses_pyramid)
			add_boolean_case (agent bad_loses_arrow)
			add_boolean_case (agent bad_loses_diamond)
			add_boolean_case (agent bad_loses_skull)
			add_boolean_case (agent good_wins_cross)
			add_boolean_case (agent good_wins_plus)
			add_boolean_case (agent matches_slots_except_good)
			add_violation_case_with_tag("correct_result",agent test_bad_match_post)
			add_violation_case_with_tag("valid_row_range",agent test_bad_match_pre)
		end

feature -- Tests
	bad_loses_pyramid: BOOLEAN
		local
			player: BAD_PLAYER
		do
			comment ("test: bad player loses pyramid board")
			create player.make

			player.game.make_pyramid
			player.loses_pyramid_game
			Result :=
					player.game.is_over
				and not(player.game.is_won)
			check Result end
		end

		bad_loses_arrow: BOOLEAN
			local
				player: BAD_PLAYER
			do
				comment ("test: bad player loses arrow board")
				create player.make

				player.game.make_arrow
				player.loses_arrow_game
				Result :=
						player.game.is_over
					and not(player.game.is_won)
				check Result end
			end

		bad_loses_diamond: BOOLEAN
			local
				player: BAD_PLAYER
			do
				comment ("test: bad player loses diamond board")
				create player.make

				player.game.make_diamond
				player.loses_diamond_game
				Result :=
						player.game.is_over
					and not(player.game.is_won)
				check Result end
			end

		bad_loses_skull: BOOLEAN
			local
				player: BAD_PLAYER
			do
				comment ("test: bad player loses skull board")
				create player.make

				player.game.make_skull
				player.loses_skull_game
				Result :=
						player.game.is_over
					and not(player.game.is_won)
				check Result end
			end
		good_wins_cross: BOOLEAN
			local
				player: GOOD_PLAYER
			do
				comment ("test: good player wins cross board")
				create player.make

				player.game.make_cross
				player.wins_cross_board
				Result :=
						player.game.is_over
					and player.game.is_won
				check Result end
			end
		good_wins_plus: BOOLEAN
			local
				player: GOOD_PLAYER
			do
				comment ("test: good player wins plus board")
				create player.make

				player.game.make_plus
				player.wins_plus_board
				Result :=
						player.game.is_over
					and player.game.is_won
				check Result end
			end


		matches_slots_except_good: BOOLEAN
		local
			board, b2: BOARD
		do
			comment ("test: matches_slots_except")
			create board.make_default
			b2:= board
			board.set_status (1, 1, board.unoccupied_slot)
			Result := board.matches_slots_except (b2, 1, 1, 1, 1)
			check Result end
		end

		test_bad_match_post
		local
			board: BOARD
			b2: BAD_BOARD
			test: BOOLEAN
		do
			comment ("test: matches_slots_except post")
			create board.make_arrow
			create b2.make
			test:=	b2.matches_slots_except (board, 1, 1, 1, 1)
		end

		test_bad_match_pre
		local
			board: BOARD
			test: BOOLEAN
		do
			comment ("test: matches_slots_except pre")
			create board.make_default
			test:=	board.matches_slots_except (board, 3, 1, 1, 2)
		end

end
