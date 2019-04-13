note
	description: "Summary description for {TEST_SOLITAIRE_UI}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SOLITAIRE_UI
inherit
	ES_TEST
create
	make
feature
	make
		do
			add_boolean_case (agent test)
		end
feature
	test: BOOLEAN
		local
			ui: SOLITAIRE_USER_INTERFACE
			bta: BOARD_TEMPLATES_ACCESS
			b1: BOARD
		do
			comment ("test_cross_game: undo")
			
			create ui.new_cross_game
			Result := ui.game.board ~ bta.templates.cross_board
			check Result end

			b1 := ui.game.board.deep_twin
			ui.move_left (3, 4)

			ui.undo
			Result :=
				ui.game.board ~ b1 and
				ui.message ~ ui.success
			check Result end
		end
end
