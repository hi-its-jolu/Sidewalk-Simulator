return {
    arrayContains = function(tab, val)
        for index, value in ipairs(tab) do -- Use ipairs for array-like tables
            if value == val then
                return true -- Value found
            end
        end
        return false -- Value not found after checking all elements
    end
}