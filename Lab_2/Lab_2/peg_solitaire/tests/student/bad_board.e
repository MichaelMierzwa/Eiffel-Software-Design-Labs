note
	description: "Summary description for {BAD_BOARD}."
	author: "Michael Mierzwa"
	date: "$Date$"
	revision: "$Revision$"

class
	BAD_BOARD
inherit
	BOARD
		redefine
			matches_slots_except
		end
create
	make

feature
	make
	do
		create imp.make_filled (ssa.unavailable_slot, 7, 7)
	end

feature --bad matches
	matches_slots_except(board: BOARD; r1,r2,c1,c2:INTEGER):BOOLEAN
		do
			Result := not(Precursor(board,r1,r2,c1,c2))
	--	ensure then
	--		correct_result: Result implies (across 1 |..| number_of_rows as i all across 1 |..| number_of_columns as j all (i.item < r1 or i.item > r2) or (j.item < c1 or j.item > c2) implies board.status_of (i.item, j.item) ~ current.status_of (i.item, j.item) end end)
		end

end


