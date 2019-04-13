note
	description: "Summary description for {BAD_DELETE_AT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BAD_DELETE_AT
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
			insert_last("get hacked son")
		end
	insert_at (i: INTEGER; s: STRING)
		do
			Precursor(i,s)
			insert_last("get hacked son")
		end
end
