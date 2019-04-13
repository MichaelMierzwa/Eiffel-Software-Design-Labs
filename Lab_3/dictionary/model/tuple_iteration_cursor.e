note
	description: "Summary description for {TUPLE_ITERATION_CURSOR}."
	author: "Michael Mierzwa"
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE_ITERATION_CURSOR[V,K]
inherit
	ITERATION_CURSOR [TUPLE[V,K]]

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
	item: TUPLE[V,K]
		local
			value: V
			key: K
		do
			key := keys[current_pos]
			value := values[current_pos]
			create Result
			Result := [value, key]
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


