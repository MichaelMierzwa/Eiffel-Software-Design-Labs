note
	description: "A Dictionary ADT mapping from keys to values"
	author: "Jackie and Michael Mierzwa"
	date: "$Date$"
	revision: "$Revision$"

class
	DICTIONARY[V, K]

inherit
	ITERABLE[TUPLE[V,K]]

create
	make

feature {INSTRUCTOR_DICTIONARY_TESTS} -- Do not modify this export status!
	-- You are required to implement all dictionary features using these two attributes.
	values: ARRAY[V]
	keys: LINKED_LIST[K]

feature -- Feature(s) required by ITERABLE
	new_cursor: ITERATION_CURSOR[TUPLE[V,K]]
		local
			cursor: TUPLE_ITERATION_CURSOR[V,K]
		do
			create cursor.make(values,keys)
			Result:= cursor
		end
	-- See test_iterable_dictionary and test_iteration_cursor in INSTRUCTOR_DICTIONARY_TESTS.
	-- As soon as you make the current class iterable,
	-- define the necessary feature(s) here.

feature -- Alternative Iteration Cursor
	another_cursor: ITERATION_CURSOR[ENTRY[V,K]]
		local
			cursor: ENTRY_ITERATION_CURSOR[V,K]
		do
			create cursor.make(values, keys)
			Result:= cursor
		end

feature -- Constructor
	make
			-- Initialize an empty dictionary.
		do
			create keys.make
			create values.make_empty

			--ensure is equal is not comparing references
			keys.compare_objects
			values.compare_objects
		ensure
			empty_dictionary: count ~ 0
			object_equality_for_keys:
				keys.object_comparison
			object_equality_for_values:
				values.object_comparison
		end

feature -- Commands

	add_entry (v: V; k: K)
			-- Add a new entry with key 'k' and value 'v'.
			-- It is required that 'k' is not an existing search key in the dictionary.
		require
			non_existing_key: not exists(k)
		do
			--add v and k to keys and values
			keys.force (k)
			values.force (v,values.count + 1)
		ensure
			--entry added checks that we return the proper value with get_value after adding it, and that
			--it is inserted at the end
			entry_added: get_value(k) ~ v and then
						 keys.at (count) ~ k and then
						 values.at (count) ~ v and then
						 keys.count ~ (old keys.deep_twin.count) + 1 and then
						 values.count ~ (old values.deep_twin.count) + 1
				-- Hint: In the new dictionary, the associated value of 'k' is 'v'
		end

	remove_entry (k: K)
			-- Remove the corresponding entry whose search key is 'k'.
			-- It is required that 'k' is an existing search key in the dictionary.
		require
			existing_key: exists(k)
		local
			i, firstK:	INTEGER

		do
			firstK := keys.index_of (k, 1)
			--this loop shifts the values in values over starting from the value we remove
			from
				i := firstK
			until
				i = keys.count
				--this loop runs from the first ocurrance of k in keys until keys.count-1
			loop
				values[i] := values[i+1]
				i :=i+1
			end
			--remove the now duplicated tail
			values.remove_tail (1)
			--remove the key k from the keys linked list
			keys.go_i_th (firstK)
			keys.remove
		ensure
			dictionary_count_decremented: values.count ~ (old values.deep_twin.count) -1 and then
										  keys.count ~ (old keys.deep_twin.count) -1
			key_removed: not exists(k)
		end

feature -- Queries

	count: INTEGER
			-- Number of entries in the dictionary.
		do
			Result := keys.count
		ensure
			correct_result: Result ~ keys.count and then
							Result ~ values.count
		end

	exists (k: K): BOOLEAN
			-- Does key 'k' exist in the dictionary?
		do
		Result:= false
			across
				keys as cursor
			loop
				if cursor.item ~ k then
					Result:= true
				end
			end
		ensure
			correct_result: Result implies
			across
				keys as cursor
			some
				cursor.item ~ k
			end
		end


	get_keys (v: V): ITERABLE[K]
			-- Return an iterable collection of keys that are associated with value 'v'.
			-- Hint: Refere to the architecture BON diagram of the Iterator Pattern, to see
			-- what classes can be used to instantiate objects that are iterable.
		local
			array_of_keys: ARRAY[K]
		do
			create array_of_keys.make_empty

			across
				1 |..| values.count as i
			loop
				if values.at (i.item) ~ v then
					-- if there is a value that has a key that maps to it, add that key to the array
					array_of_keys.force (keys.at (i.item), array_of_keys.upper + 1)
				end
			end

			Result:= array_of_keys
		ensure
			--note: iterable_match is a hidden helper feature that takes in an iterable and a value
			--and returns an integer of how many times value occurs in the iterable
			correct_result: (across
								Result as j
							all
								values[keys.index_of (j.item, 1)] ~ v
							end) and then iterable_match(Result, v) = iterable_match(keys,v)
				-- Hint: Since Result is iterable, go accross it and make sure
				-- that every key in that iterable collection has its corresponding
				-- value equal to 'v'. Remember that in this naive implementation
				-- strategy, an existing key and its associated value have the same index.
		end

	get_value (k: K): detachable V
			-- Return the assocated value of search key 'k' if it exists.
			-- Void if 'k' does not exist.
			-- Declaring "detachable" besides the return type here indicates that
			-- the return value might be void (i.e., null).
		do
			if exists(k) then
				across
					1 |..| keys.count as i
				loop
					if (k ~ keys[i.item]) then
						Result:= values.at (i.item)
					end
				end
			end
		ensure
			case_of_void_result: not exists(k) implies Result ~ void
			case_of_non_void_result:(across
										1 |..| keys.count as  j
									some
										keys[j.item] ~ k
									end) implies Result ~ values.at (keys.index_of (k,1))
		end

feature {NONE} -- Helper feature
	--returns the an integer of how many times v occurs in iter
	iterable_match(iter:ITERABLE[K]; v:V):INTEGER
		do
			across
				iter as cursor
			loop
				if
					get_value(cursor.item) ~ v
				then
					Result:= Result + 1
				end

			end
		end

invariant
	consistent_counts_of_keys_and_values:
		keys.count = values.count
	consistent_counts_of_imp_and_adt:
		keys.count = count
end
