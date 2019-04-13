note
	description: "Entry in a dictionary consisting of a search key and a value."
	author: "Jackie and Michael Mierzwa"
	date: "$Date$"
	revision: "$Revision$"

class
	ENTRY[V,K]
inherit
	ANY

redefine
	is_equal
	end

create
	make

feature -- Attributes
	value: V
	key: K

feature -- Constructor
	make (v: V; k: K)
		do
			value := v
			key := k
		end

feature --is_equal
	is_equal(other: Like current) :BOOLEAN
		do
			Result := other.value ~ current.value
		end
end
