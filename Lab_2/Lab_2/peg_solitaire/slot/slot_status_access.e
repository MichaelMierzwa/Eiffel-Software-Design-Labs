note
	description: "Shared access to the possible statuses of a board slot."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

expanded class
	SLOT_STATUS_ACCESS

feature -- Accesses
	unavailable_slot: UNAVAILABLE_SLOT
			-- Return the unavailable status of a slot.
		once
			create Result.make
		end

	occupied_slot: OCCUPIED_SLOT
			-- Return the occupied status of a slot.
		once
			create Result.make
		end

	unoccupied_slot: UNOCCUPIED_SLOT
			-- Return the unoccupied status of a slot.
		once
			create Result.make
		end

invariant
	singleton_slot_statuses:
		(Current.unavailable_slot = Current.unavailable_slot and
		Current.occupied_slot = Current.occupied_slot and
		Current.unoccupied_slot = Current.unoccupied_slot)

end
