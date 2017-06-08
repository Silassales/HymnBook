-- helper
local function tableContains (table, value)
    for i = 1,#table do
        if table[i] == value then
            return true
        end
    end
    return false
end

local two_page = { 1,5,10,15,20 }
local three_page = { 2,4,6,8,12,14,16 }
local four_page = { 3,9,18,21,24,27 }

local page_table = { ["2"]=two_page, ["3"]=three_page, ["4"]=four_page }

local function generateTable ( hymn_page_count_table )
    hymn_table = {}
    current_page = 1

    for i = 1, 27 do
        if tableContains( hymn_page_count_table["2"], i) then
            table.insert( hymn_table, Hymn.new( i, 2, { RPTI .. "/" .. current_page .. ".jpg", RPTI .. "/" .. current_page+1 .. ".jpg"}))
            current_page = current_page + 2
        elseif tableContains( hymn_page_count_table["3"], i) then
            table.insert( hymn_table, Hymn.new( i, 3, { RPTI .. "/" .. current_page .. ".jpg", RPTI .. "/" .. current_page+1 .. ".jpg", RPTI .. "/" .. current_page+2 .. ".jpg"}))
            current_page = current_page + 3
        elseif tableContains( hymn_page_count_table["4"], i) then
            table.insert( hymn_table, Hymn.new( i, 4, { RPTI .. "/" .. current_page .. ".jpg", RPTI .. "/" .. current_page+1 .. ".jpg", RPTI .. "/" .. current_page+2 .. ".jpg", , RPTI .. "/" .. current_page+3 .. ".jpg"}))
            current_page = current_page + 4
        else 
            table.insert( hymn_table, Hymn.new( i, 1, { RPTI .. "/" .. current_page .. ".jpg"}))
            current_page = current_page + 1
        end
    end

    return hymn_table
end

generateTable ( page_table )