note
	description: "A Dictionary ADT mapping from keys to values"
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

class
	-- Constrained genericity because V and K will be used
	-- in the math model class FUN, which require both to be always
	-- attached for void safety.
	DICTIONARY[V -> attached ANY, K -> attached ANY]
inherit
	ITERABLE[TUPLE[V, K]]
create
	make

feature {NONE} -- Do not modify this export status!
	values: ARRAY[V]
	keys: LINKED_LIST[K]

feature -- Abstraction function
	model: REL[K, V] -- Do not modify the type of this query.
			-- Abstract the dictionary ADT as a mathematical function.

		do
			create Result.make_empty

			across
				1 |..| count as cursor
			loop
				Result.extend (create {PAIR[K,V]}.make(keys.at (cursor.item), values.at (cursor.item)))
			end

		ensure
			consistent_model_imp_counts: Result.count = count
			consistent_model_imp_contents: across 1|..| count as cursor all Result.has(create {PAIR[K, V]}.make (keys.at (cursor.item), values.at (cursor.item)))end
		end

feature -- feature required by ITERABLE
	new_cursor: ITERATION_CURSOR[TUPLE[V, K]]
		local
			cursor: TUPLE_ITERATION_CURSOR[V,K]
		do
			create cursor.make(values,keys)
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
			empty_model: model.is_empty
			object_equality_for_keys:
				keys.object_comparison
			object_equality_for_values:
				values.object_comparison
		end

feature -- Commands

	add_entry (v: V; k: K)
		do
			--add v and k to keys and values
			if(keys.has (k))then
				keys.force (k)
				values.force (v,values.count + 1)
			end
		ensure
			overwritten: (old model).has (create {PAIR[K, V]}.make (k,v)) implies model.has (create {PAIR[K, V]}.make (k,v))
			entry_added_to_model: model.has (create {PAIR[K, V]}.make (k,v))
				-- Your Task: Look at feature 'test_model' in class 'INSTRUCTOR_DICTIONARY_TESTS' for hints.
		end

	remove_entry (k: K)
		local
			i, firstK:	INTEGER

		do
			if(keys.has (k)) then
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
			end
		ensure
			still_doesnt_exist: not(old model).domain.has (k) implies not(model.domain.has(k))
			entry_removed_from_model: not(model.domain.has (k))
		end

feature -- Queries

	count: INTEGER
			-- Number of keys in BST.
		do
			Result := keys.count
		ensure
			correct_model_result: model.count = count
		end

	get_keys (v: V): ITERABLE[K]
			-- Keys that are associated with value 'v'.
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
			correct_model_result: across Result as cursor all model.has (create {PAIR[K, V]}.make (cursor.item,v)) end

		end

	get_value (k: K): detachable V
			-- Assocated value of 'k' if it exists.
			-- Void if 'k' does not exist.
		do
			across
				1 |..| keys.count as i
			loop
				if (k ~ keys[i.item]) then
					Result:= values.at (i.item)
				end
			end
		ensure
			case_of_void_result: not(model.domain.has (k)) implies Result ~ void
			case_of_non_void_result: model.domain.has (k) implies not(Result ~ void)
		end
invariant
	consistent_keys_values_counts:
		keys.count = values.count
	consistent_imp_adt_counts:
		keys.count = count
end
