local page_lib = {}
-- My Page Class
local Hymn = {}
Hymn.__index = Hymn
page_lib.Hymn = Hymn

-- some nice "constants"
-- relative_path_to_images -> shortened to clean up code
local RPTI = "images"

function Hymn.new ( hymn_number, num_pages, pages ) 
	self = setmetatable( {}, Hymn )

	-- memeber init
	self.hymn_number = hymn_number or 0
	self.current_page = 1
	self.num_pages = num_pages or 1
	
	-- if pages is nil, set the first url to a default hymn 0 page -> prevent runtime errors
	self.page_table = {}
	if pages == nil then
		table.insert( self.page_table, "hymn0.jpg" )
	else
		-- perform a copy instead of assignment as lua deals with pointers
		for i = 1, self.num_pages do
			table.insert( self.page_table, pages[i] )
		end
	end

	return self
end

-- returns either next page or 'nil' indicating to go to the next hymn
function Hymn.next(self)
	if (self.current_page + 1) > self.num_pages then
		self.current_page = 1
		return nil
	else 
		local next_page = self.current_page + 1
		self.current_page = self.current_page + 1
		return self.page_table[next_page]
	end
end

-- returns either previous page or 'nil' indicating to go to the previous hymn
function Hymn.prev(self)
	if (self.current_page - 1) < 1 then
		self.current_page = 1
		return nil
	else
		local prev_page = self.current_page - 1
		self.current_page = self.current_page - 1
		return self.page_table[prev_page]
	end
end

-- returns the url of the first page in the hymn
-- could be done by just accessing Hymn[i].page_table[1] instead of calling this function, but following typical OOP abstraction
function Hymn.first(self)
	return self.page_table[1]
end

-- returns the url of the last page in the hymn
-- assume that when requesting the last page, they are viewing the last page so set current page to
-- the last page
function Hymn.last(self)
	self.current_page = self.num_pages
	return self.page_table[self.num_pages]
end

-- Some functions for setting up the hymn table used by page_view.lua
function GetHymnTable()
	hymn_table = {}

	-- hymn_table, constructor ( hymn_number, num_pages, pages )
	table.insert( hymn_table, Hymn.new( 1, 1, { RPTI .. "/004.jpg" }))
	table.insert( hymn_table, Hymn.new( 2, 2, { RPTI .. "/005.jpg", RPTI .. "/006.jpg" }))
	table.insert( hymn_table, Hymn.new( 3, 3, { RPTI .. "/007.jpg", RPTI .. "/008.jpg", RPTI .. "/009.jpg" }))
	table.insert( hymn_table, Hymn.new( 4, 1, { RPTI .. "/010.jpg" }))
	table.insert( hymn_table, Hymn.new( 5, 1, { RPTI .. "/011.jpg" }))
	table.insert( hymn_table, Hymn.new( 6, 1, { RPTI .. "/012.jpg" }))
	table.insert( hymn_table, Hymn.new( 7, 2, { RPTI .. "/013.jpg", RPTI .. "/014.jpg" }))
	table.insert( hymn_table, Hymn.new( 8, 1, { RPTI .. "/015.jpg" }))
	table.insert( hymn_table, Hymn.new( 9, 1, { RPTI .. "/016.jpg" }))
	table.insert( hymn_table, Hymn.new( 10, 3, { RPTI .. "/017.jpg", RPTI .. "/018.jpg", RPTI .. "/019.jpg" }))
	table.insert( hymn_table, Hymn.new( 11, 1, { RPTI .. "/020.jpg" }))
	table.insert( hymn_table, Hymn.new( 12, 1, { RPTI .. "/021.jpg" }))
	table.insert( hymn_table, Hymn.new( 13, 1, { RPTI .. "/022.jpg" }))
	table.insert( hymn_table, Hymn.new( 14, 1, { RPTI .. "/023.jpg" }))
	table.insert( hymn_table, Hymn.new( 15, 2, { RPTI .. "/024.jpg", RPTI .. "/025.jpg" }))
	table.insert( hymn_table, Hymn.new( 16, 2, { RPTI .. "/026.jpg", RPTI .. "/027.jpg" }))
	table.insert( hymn_table, Hymn.new( 17, 1, { RPTI .. "/028.jpg" }))
	table.insert( hymn_table, Hymn.new( 18, 2, { RPTI .. "/029.jpg", RPTI .. "/030.jpg" }))
	table.insert( hymn_table, Hymn.new( 19, 1, { RPTI .. "/031.jpg" }))
	table.insert( hymn_table, Hymn.new( 20, 1, { RPTI .. "/032.jpg" }))
	table.insert( hymn_table, Hymn.new( 21, 1, { RPTI .. "/033.jpg" }))
	table.insert( hymn_table, Hymn.new( 22, 1, { RPTI .. "/034.jpg" }))
	table.insert( hymn_table, Hymn.new( 23, 1, { RPTI .. "/035.jpg" }))
	table.insert( hymn_table, Hymn.new( 24, 2, { RPTI .. "/036.jpg", RPTI .. "/037.jpg" }))
	table.insert( hymn_table, Hymn.new( 25, 1, { RPTI .. "/038.jpg" }))
	table.insert( hymn_table, Hymn.new( 26, 1, { RPTI .. "/039.jpg" }))
	table.insert( hymn_table, Hymn.new( 27, 1, { RPTI .. "/040.jpg" }))
	table.insert( hymn_table, Hymn.new( 28, 3, { RPTI .. "/041.jpg", RPTI .. "/042.jpg", RPTI .. "/043.jpg" }))
	table.insert( hymn_table, Hymn.new( 29, 1, { RPTI .. "/044.jpg" }))
	table.insert( hymn_table, Hymn.new( 30, 2, { RPTI .. "/045.jpg", RPTI .. "/046.jpg" }))
	table.insert( hymn_table, Hymn.new( 31, 1, { RPTI .. "/047.jpg" }))
	table.insert( hymn_table, Hymn.new( 32, 1, { RPTI .. "/048.jpg" }))
	table.insert( hymn_table, Hymn.new( 33, 1, { RPTI .. "/049.jpg" }))
	table.insert( hymn_table, Hymn.new( 34, 2, { RPTI .. "/050.jpg", RPTI .. "/051.jpg" }))
	table.insert( hymn_table, Hymn.new( 35, 2, { RPTI .. "/051.jpg", RPTI .. "/052.jpg" }))
	table.insert( hymn_table, Hymn.new( 36, 2, { RPTI .. "/053.jpg", RPTI .. "/054.jpg" }))
	table.insert( hymn_table, Hymn.new( 37, 3, { RPTI .. "/055.jpg", RPTI .. "/056.jpg", RPTI .. "/057.jpg" }))
	table.insert( hymn_table, Hymn.new( 38, 1, { RPTI .. "/058.jpg" }))
	table.insert( hymn_table, Hymn.new( 39, 1, { RPTI .. "/059.jpg" }))
	table.insert( hymn_table, Hymn.new( 40, 1, { RPTI .. "/060.jpg" }))
	table.insert( hymn_table, Hymn.new( 41, 1, { RPTI .. "/061.jpg" }))
	table.insert( hymn_table, Hymn.new( 42, 1, { RPTI .. "/062.jpg" }))
	table.insert( hymn_table, Hymn.new( 43, 2, { RPTI .. "/063.jpg", RPTI .. "/064.jpg" }))
	table.insert( hymn_table, Hymn.new( 44, 2, { RPTI .. "/065.jpg", RPTI .. "/066.jpg" }))
	table.insert( hymn_table, Hymn.new( 45, 1, { RPTI .. "/067.jpg" }))
	table.insert( hymn_table, Hymn.new( 46, 1, { RPTI .. "/068.jpg" }))
	table.insert( hymn_table, Hymn.new( 47, 1, { RPTI .. "/069.jpg" }))
	table.insert( hymn_table, Hymn.new( 48, 2, { RPTI .. "/070.jpg", RPTI .. "/071.jpg" }))
	table.insert( hymn_table, Hymn.new( 49, 1, { RPTI .. "/072.jpg" }))
	table.insert( hymn_table, Hymn.new( 50, 1, { RPTI .. "/073.jpg" }))
	table.insert( hymn_table, Hymn.new( 51, 1, { RPTI .. "/074.jpg" }))
	table.insert( hymn_table, Hymn.new( 52, 1, { RPTI .. "/075.jpg" }))
	table.insert( hymn_table, Hymn.new( 53, 1, { RPTI .. "/076.jpg" }))
	table.insert( hymn_table, Hymn.new( 54, 1, { RPTI .. "/077.jpg" }))
	table.insert( hymn_table, Hymn.new( 55, 1, { RPTI .. "/078.jpg" }))
	table.insert( hymn_table, Hymn.new( 56, 1, { RPTI .. "/079.jpg" }))
	table.insert( hymn_table, Hymn.new( 57, 2, { RPTI .. "/080.jpg", RPTI .. "/081.jpg" }))
	table.insert( hymn_table, Hymn.new( 58, 1, { RPTI .. "/082.jpg" }))
	table.insert( hymn_table, Hymn.new( 59, 1, { RPTI .. "/083.jpg" }))
	table.insert( hymn_table, Hymn.new( 60, 1, { RPTI .. "/084.jpg" }))
	table.insert( hymn_table, Hymn.new( 61, 1, { RPTI .. "/085.jpg" }))
	table.insert( hymn_table, Hymn.new( 62, 4, { RPTI .. "/086.jpg", RPTI .. "/087.jpg", RPTI .. "/088.jpg", RPTI .. "/089.jpg" }))
	table.insert( hymn_table, Hymn.new( 63, 1, { RPTI .. "/090.jpg", RPTI .. "/091.jpg" }))
	table.insert( hymn_table, Hymn.new( 64, 1, { RPTI .. "/092.jpg" }))
	table.insert( hymn_table, Hymn.new( 65, 1, { RPTI .. "/093.jpg" }))
	table.insert( hymn_table, Hymn.new( 66, 1, { RPTI .. "/094.jpg" }))
	table.insert( hymn_table, Hymn.new( 67, 1, { RPTI .. "/095.jpg" }))
	table.insert( hymn_table, Hymn.new( 68, 2, { RPTI .. "/096.jpg", RPTI .. "/097.jpg" }))
	table.insert( hymn_table, Hymn.new( 69, 1, { RPTI .. "/098.jpg" }))
	table.insert( hymn_table, Hymn.new( 70, 1, { RPTI .. "/099.jpg" }))
	table.insert( hymn_table, Hymn.new( 71, 1, { RPTI .. "/100.jpg" }))
	table.insert( hymn_table, Hymn.new( 72, 1, { RPTI .. "/101.jpg", RPTI .. "/102.jpg" }))
	table.insert( hymn_table, Hymn.new( 73, 1, { RPTI .. "/103.jpg" }))
	table.insert( hymn_table, Hymn.new( 74, 1, { RPTI .. "/104.jpg", RPTI .. "/105.jpg" }))
	table.insert( hymn_table, Hymn.new( 75, 1, { RPTI .. "/105.jpg", RPTI .. "/106.jpg" }))
	table.insert( hymn_table, Hymn.new( 76, 1, { RPTI .. "/107.jpg", RPTI .. "/108.jpg" }))
	table.insert( hymn_table, Hymn.new( 77, 1, { RPTI .. "/109.jpg" }))




	return hymn_table
end
page_lib.GetHymnTable = GetHymnTable
	
return page_lib
