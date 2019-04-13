note
	description: "Summary description for {TEST_ARRAYED_CONTAINER}."
	author: "Michael Mierzwa"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_ARRAYED_CONTAINER

inherit
	ES_TEST

create
	make

feature -- Add Tests
	make
		do
			--add test cases for insert at, assign at, and fix remove first.
			--then figure out how to do hard test cases
			add_boolean_case (agent test_arrayed_container_count)
			add_boolean_case (agent test_arrayed_container_valid_index)
			add_boolean_case (agent test_arrayed_container_get_at)
			add_boolean_case (agent test_arrayed_container_delete_at)
			add_boolean_case (agent test_arrayed_container_insert_last)
			add_boolean_case (agent test_arrayed_container_remove_first)
			add_boolean_case (agent test_arrayed_container_insert_at)
			add_boolean_case (agent test_arrayed_container_assign_at)
			add_violation_case_with_tag ("not_empty", agent test_not_empty)
			add_violation_case_with_tag ("size_changed", agent test_bad_delete_at)
			add_violation_case_with_tag ("size_changed", agent test_bad_insert_at)
			add_violation_case_with_tag ("right_half_the_same", agent test_bad_delete_at_right)
			add_violation_case_with_tag ("right_half_the_same", agent test_bad_insert_at_right)


		end

feature -- Tests

	--tests that when delete_at removes an item, the item after it replaces it
	test_arrayed_container_delete_at: BOOLEAN
		local
			imp: ARRAYED_CONTAINER
		do
			comment("Test delete_at feature.")
			create {ARRAYED_CONTAINER} imp.make
			imp.insert_last("pls work")
			imp.insert_last ("my future rests on this")
			imp.insert_last ("funny test cases get good marks")
			imp.delete_at(2)
			Result:=
				imp.get_at(1) ~ "pls work"
				and imp.get_at(2) ~ "funny test cases get good marks"
			check Result end
		end

	--test that insert_last inserted the item at the tail
	test_arrayed_container_insert_last: BOOLEAN
		local
			imp: ARRAYED_CONTAINER
		do
			comment("Test insert_last feature.")
			create {ARRAYED_CONTAINER} imp.make
			imp.insert_last("pls work")
			imp.insert_last ("my future rests on this")
			Result:=
				imp.get_at(1) ~ "pls work" and imp.get_at(2) ~ "my future rests on this"
			check Result end
		end

	--test that remove_first properly shifts the elements from i+1 after deletion
	test_arrayed_container_remove_first: BOOLEAN
		local
			imp: ARRAYED_CONTAINER
		do
			comment("Test remove_first feature.")
			create {ARRAYED_CONTAINER} imp.make
			imp.insert_last("pls work")
			imp.insert_last ("my future rests on this")
			imp.remove_first
			Result:=
				imp.get_at(1) ~ "my future rests on this"
			check Result end
		end

	--test that insert_at properly shifts the array's elements
	test_arrayed_container_insert_at: BOOLEAN
		local
			imp: ARRAYED_CONTAINER
		do
			comment("Test insert_at feature.")
			create {ARRAYED_CONTAINER} imp.make
			imp.insert_last("pls work")
			imp.insert_last ("my future rests on this")
			imp.insert_at (1, "This should be 1st")
			imp.insert_at (3, "This should be third")
			Result:=
				imp.get_at(1) ~ "This should be 1st"
				and imp.get_at(2) ~ "pls work"
				and imp.get_at(3) ~ "This should be third"
				and imp.get_at(4) ~ "my future rests on this"
			check Result end
		end

	--test assign_at properly overwrites
	test_arrayed_container_assign_at: BOOLEAN
		local
			imp: ARRAYED_CONTAINER
		do
			comment("Test assign_at feature.")
			create {ARRAYED_CONTAINER} imp.make
			imp.insert_last("pls work")
			imp.insert_last ("my future rests on this")
			imp.insert_last ("funny test cases get good marks")
			imp.assign_at (2, "what is love?")
			Result:=
				imp.get_at(2) ~ "what is love?"
			check Result end
		end


feature -- Test queries for testing expected values

	--test if the count of imp is 0 upon creation, and 3 after adding 3 elements
	test_arrayed_container_count: BOOLEAN
		local
			imp: ARRAYED_CONTAINER
			i: INTEGER
		do
			comment("Test count attribute.")
			create {ARRAYED_CONTAINER} imp.make
			i := imp.count
			imp.insert_last ("1")
			imp.insert_last ("2")
			imp.insert_last ("3")
			Result :=
				i ~ 0 and imp.count ~ 3
			check Result end
		end

	--test if valid index is true for a valid index, and is flase for 0 and greater than count
	test_arrayed_container_valid_index:BOOLEAN
		local
			imp: ARRAYED_CONTAINER
		do
			comment("Test valid_index query.")
			create {ARRAYED_CONTAINER} imp.make
			imp.insert_last ("pls work")
			imp.insert_last ("my future rests on this")
			imp.insert_last ("funny test cases get good marks")

			Result :=
				imp.valid_index(3) and imp.valid_index (0) ~ False and imp.valid_index (4) ~ False
			check Result end
		end

	--test if get_at returns the values in the proper positions they were entered
	test_arrayed_container_get_at: BOOLEAN
		local
			imp: ARRAYED_CONTAINER
		do
			comment("Test get_at query.")
			create {ARRAYED_CONTAINER} imp.make
			imp.insert_last ("pls work")
			imp.insert_last ("my future rests on this")
			imp.insert_last ("funny test cases get good marks")
			Result :=
				imp.get_at(1) ~ "pls work" and imp.get_at(2) ~ "my future rests on this" and imp.get_at (3) ~ "funny test cases get good marks"
			check Result end
		end


feature -- Test commands for testing contract violations

	--see if not_empty precondition for remove_first properly works
	test_not_empty
		local
			ac: ARRAYED_CONTAINER
		do
			comment("Test not_empty precondition for remove_first.")
			create {ARRAYED_CONTAINER} ac.make
			ac.remove_first
		end

	--test that size_changed postcondition is thrown when using a malicious implementation of delete_at
	test_bad_delete_at
		local
			ac: BAD_DELETE_AT
		do
			comment("Test size_changed postcondition for delete_at.")
			create {BAD_DELETE_AT} ac.make
			ac.insert_last("pls work")
			ac.insert_last ("my future rests on this")
			ac.insert_last ("funny test cases get good marks")
			ac.delete_at(2)
		end

	--test that size_changed postcondition is thrown when using a malicious implementation of insert_at
	test_bad_insert_at
		local
			ac: BAD_DELETE_AT
		do
			comment("Test size_unchanged postcondition for insert_at.")
			create {BAD_DELETE_AT} ac.make
			ac.insert_last("pls work")
			ac.insert_last ("my future rests on this")
			ac.insert_last ("funny test cases get good marks")
			ac.insert_at(2,"test")
		end

	--test that right_half_the_same postcondition is thrown when using a malicious implementation of delete_at
	test_bad_delete_at_right
		local
			ac:BAD_RIGHT_SIDE
		do
			comment("Test right_half_the_same postcondition for delete_at.")
			create {BAD_RIGHT_SIDE} ac.make
			ac.insert_last("pls work")
			ac.insert_last ("my future rests on this")
			ac.insert_last ("funny test cases get good marks")
			ac.delete_at(1)
		end

	--test that right_half_the_same postcondition is thrown when using a malicious implementation of insert_at
	test_bad_insert_at_right
		local
			ac:BAD_RIGHT_SIDE
		do
			comment("Test right_half_the_same postcondition for insert_at.")
			create {BAD_RIGHT_SIDE} ac.make
			ac.insert_last("pls work")
			ac.insert_last ("my future rests on this")
			ac.insert_last ("funny test cases get good marks")
			ac.insert_at(1, "hi")
		end
end
