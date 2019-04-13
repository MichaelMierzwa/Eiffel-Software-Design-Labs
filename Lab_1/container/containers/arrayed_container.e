note
	description: "A linear container implemented via an array."
	author: "Jackie and Michael Mierzwa AKA mierzwam"
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAYED_CONTAINER

create
	make

feature {NONE} -- Implementation of container via an array

	imp : ARRAY[STRING]

feature -- Constructors

	make
			-- Initialize an empty container.
		do
			-- This implementation is correct, just given to you.
			create imp.make_empty
		ensure
			empty_container: imp.is_empty
		end


feature -- Commands

	assign_at (i: INTEGER; s: STRING)
			-- Change the value at position 'i' to 's'.
		require
			valid_index: valid_index(i)
		do
			imp [i] := s
			-- Uncomment this to produce a wrong implementation
--			if i > 1 then
--				imp [1] := s
--			end
		ensure
			size_unchanged: imp.count = (old imp.twin).count
			item_assigned: imp [i] ~ s
			others_unchanged:
				across
					1 |..| imp.count as j
				all
					j.item /= i implies imp [j.item] ~ (old imp.twin) [j.item]
				end
		end

	insert_at (i: INTEGER; s: STRING)
			-- Insert value 's' into index 'i'.
		require
			valid_index: valid_index(i)
		local
			k : INTEGER
		do
			--go from the end of the array till you pass i
			--forcing each object into the index + 1
			from
				k := imp.count
			until
				k < i
			loop
				imp.force(imp[k],k+1)
				k := k-1
			end

			-- after forcing all strings from i into i +1, i is now void
			-- assign s into the void space
			assign_at(i, s)
			count := count+1
		ensure
			size_changed: imp.count = (old imp.twin).count + 1
			inserted_at_i: imp[i] ~ s
			left_half_the_same:
				across
					1 |..|  (i-1) as j
				all
					imp[j.item] ~ (old imp.twin)[j.item]
				end
			right_half_the_same:
				across
					(i+1) |..| imp.count as j
				all
					imp[j.item] ~ (old imp.twin)[j.item - 1]
				end
		end

	delete_at (i: INTEGER)
			-- Delete element stored at index 'i'.
		require
			valid_index: valid_index(i)
		local
			k : INTEGER
		do
			--go from i+1 till end of array
			--assign imp at index i, the item in i + 1
			from
				k := i + 1
			until
				k > imp.count
			loop
				assign_at(k-1,imp[k])
				k := k+1
			end

			-- after forcing everything from i+1 into i
			-- the end of the array is void, remove that
			imp.remove_tail(1)
			count := count-1
		ensure
			size_changed: imp.count = (old imp.twin).count - 1
			left_half_the_same:
				across
					1 |..|  (i-1) as j
				all
					imp[j.item] ~ (old imp.twin)[j.item]
				end
			right_half_the_same:
				across
					(i)|..| imp.count as j
				all
					imp[j.item] ~ (old imp.twin)[(j.item + 1)]
				end
		end

	insert_last (s: STRING)
			-- Insert 's' as the last element of the container.
		do
			imp.force(s, (imp.count+1))
			count := count+1
		ensure
			size_changed: imp.count = (old imp.twin).count + 1
			last_inserted: imp [imp.count] ~ s
			others_unchanged:
				across
					1 |..| (imp.count-1) as j
				all
					imp[j.item] ~ (old imp.twin)[j.item]
				end
		end

	remove_first
			-- Remove first element from the container.
		require
			not_empty: (count > 0)
		local
			i: INTEGER

		do
			imp.remove_head (1)
			imp.rebase (1)
--			from
--				i := 1
--			until
--				i = imp.count
--			loop
--				imp.force (imp[i + 1], i)
--				i := i+1
--			end

--			--instead of the loop, i used remove_head before and got errors
--			imp.remove_tail(1)
--		
			count := count-1
		ensure
			size_changed: imp.count = (old imp.twin).count - 1
			others_unchanged:
				across
					1 |..| (imp.count-1) as j
				all
					imp[j.item] ~ (old imp.twin)[(j.item+1)]
				end
		end

feature -- Queries

	count: INTEGER
	  -- Number of items currently stored in the container.
      -- It is up to you to either implement 'count' as an attribute,
      -- or to implement 'count' as a query (uniform access principle).

	valid_index (i: INTEGER): BOOLEAN
			-- Is 'i' a valid index of current container?
		do
			Result := i > 0 and i <= count
		ensure
			size_unchanged: imp.count ~ (old imp.twin).count
			result_correct: Result ~ ((old imp.twin).lower <= i and i <= (old imp.twin).upper)
			no_elements_changed:
				across
					1 |..| (imp.count) as j
				all
					imp[j.item] ~ (old imp.twin)[j.item]
				end
		end

	get_at (i: INTEGER): STRING
			-- Return the element stored at index 'i'.
		require
			valid_index: valid_index(i)
		do
			Result := imp[i]
		ensure
			size_unchanged: imp.count ~ (old imp.twin).count
			result_correct: Result ~ (old imp.twin)[i]
			no_elements_changed:
				across
					1 |..| (imp.count) as j
				all
					imp[j.item] ~ (old imp.twin)[j.item]
				end
		end

invariant
	-- Size of container and size of implementation array always match.
	consistency: imp.count = count
end
