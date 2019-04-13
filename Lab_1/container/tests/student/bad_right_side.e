note
	description: "Summary description for {BAD_RIGHT_SIDE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BAD_RIGHT_SIDE

inherit
	ARRAYED_CONTAINER
		redefine
			delete_at,
			insert_at
		end
create
	make

feature --bad delete
	delete_at (i: INTEGER)
		do
			Precursor(i)
			assign_at(i, "get hacked son")


		end
	insert_at (i: INTEGER; s: STRING)
		do
			Precursor(i,s)
			assign_at(i+1, "get hacked son")

		end


end
