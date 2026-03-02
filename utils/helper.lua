return {
    arrayContains = function(tab, val)
        for index, value in ipairs(tab) do -- Use ipairs for array-like tables
            if value == val then
                return true -- Value found
            end
        end
        return false -- Value not found after checking all elements
    end,

    arraySpread = function(table1, table2)
        for index, value in ipairs(table2) do
            table.insert(table1, value)
        end
        return table1
    end

    
}