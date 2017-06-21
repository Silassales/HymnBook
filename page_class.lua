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
		table.insert( self.page_table, "1.png" )
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
-- helper
local function tableContains (table, value)
    for i = 1,#table do
        if table[i] == value then
            return true
        end
    end
    return false
end

local two_page = { 2,7,15,16,18,24,30,35,36,43,44,48,57,63,68,72,75,76,77,78,81,82,83,84,85,88,89,98,99,100,101,104,105,106,109,110,113,120,121,122,125,128,129,132,135,143,144,147,150,151,161,163,173,176,181,188,189,194,195,196,197,202,205,210,213,222,227,228,237,240,245,246,247,248,253,256,257,260,265,268,269,270,273,274,275,278,279,285,286,289,291,294,295,296,301,314,317,320,325,330,335,338,345,350,355,356,361,364,369,372,377,380,383,384,385,386,389,400,403,414,421,429,430,435,436 }
local three_page = { 3,10,28,37,93,95,116,127,134,183,209,299,307,328,339,360,367,373,394 }
local four_page = { 62,140,170,283,290,308,309,326,327 }

local page_table = { ["2"]=two_page, ["3"]=three_page, ["4"]=four_page }

local function generateHymnTable ( hymn_page_count_table, num_hymns )
    hymn_table = {}
    current_page = 1

    for i = 1, num_hymns do
        if tableContains( hymn_page_count_table["2"], i) then
            table.insert( hymn_table, Hymn.new( i, 2, { RPTI .. "/" .. current_page .. ".png", RPTI .. "/" .. current_page+1 .. ".png"}))
            current_page = current_page + 2
        elseif tableContains( hymn_page_count_table["3"], i) then
            table.insert( hymn_table, Hymn.new( i, 3, { RPTI .. "/" .. current_page .. ".png", RPTI .. "/" .. current_page+1 .. ".png", RPTI .. "/" .. current_page+2 .. ".png"}))
            current_page = current_page + 3
        elseif tableContains( hymn_page_count_table["4"], i) then
            table.insert( hymn_table, Hymn.new( i, 4, { RPTI .. "/" .. current_page .. ".png", RPTI .. "/" .. current_page+1 .. ".png", RPTI .. "/" .. current_page+2 .. ".png", RPTI .. "/" .. current_page+3 .. ".png"}))
            current_page = current_page + 4
        else 
            table.insert( hymn_table, Hymn.new( i, 1, { RPTI .. "/" .. current_page .. ".png"}))
            current_page = current_page + 1
        end
    end

    return hymn_table
end

-- FIXME change page_table to a instance member of the table class so that the call can be 
-- directly to generateHymnTable instead of through this wrapper function
local function GetHymnTable ( num_hymns )
	return generateHymnTable( page_table, num_hymns )
end


page_lib.GetHymnTable = GetHymnTable
	
return page_lib
