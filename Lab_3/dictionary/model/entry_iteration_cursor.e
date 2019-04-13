note
	description: "Summary description for {ENTRY_ITERATION_CURSOR}."
	author: "Michael Mierzwa"
	date: "$Date$"
	revision: "$Revision$"

class
	ENTRY_ITERATION_CURSOR[V,K]

inherit
	ITERATION_CURSOR [ENTRY[V,K]]

create
	make

feature --Constructor
	make(v:ARRAY[V];k:LINKED_LIST[K])
		do
			keys := k
			values := v
			current_pos := k.lower
		end

feature --Iteration
	item: ENTRY[V,K]
		local
			value: V
			key: K
		do
			key := keys[current_pos]
			value := values[current_pos]
			create Result.make (value, key)
		end

	after: BOOLEAN
		do
			Result:= (current_pos > keys.count)
		end

	forth
		do
			current_pos := current_pos + 1
		end

feature {NONE} --Hidden storage
	keys: LINKED_LIST[K]
	values: ARRAY[V]
	current_pos: INTEGER
end

