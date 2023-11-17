local lib = {}
lib.author = "smokingplaya"

-- page

local gui_mt = {}
gui_mt.__index = gui_mt

local block_mt = {}
block_mt.__index = gui_mt

local text_mt = {}
text_mt.__index = gui_mt

BLOCK = 0
TEXT = 1

local element_types = {
    [BLOCK] = block_mt,
    [TEXT] = text_mt,
}

-- attributes
local attr_mt = {}
attr_mt.__index = attr_mt

local function new_attributes()
    local obj = {
        content = {}
    }

    setmetatable(obj, attr_mt)

    return obj
end

function attr_mt:__tostring()
    local str = ""

    for k, v in pairs(self.content) do
        str = " " .. k .. "=\"" .. v .. "\""
    end

    return str
end

function attr_mt:Set(k, v)
    self.content[k] = v

    return self
end

function attr_mt:Get(k)
    return self.content[k]
end
--

function lib.create_element(class)
    if not element_types[class] then print("BLYAAAAD") return end -- TODO: error handler

    local obj = {
        content = {},
        attributes = new_attributes(),
        is_block = class == BLOCK,
        is_text = class == TEXT
    }

    setmetatable(obj, element_types[class])

    return obj
end

function gui_mt:GetParent()
    return self.parent
end

function gui_mt:Set(n)
    self.element_name = n
    return self
end

function gui_mt:GetAttributes()
    return self.attributes
end

function gui_mt:Add(name)
    local elem = lib.create_element(name)
    elem.parent = self

    self.content[#self.content+1] = elem

    return elem
end

function gui_mt:Center()
end

function gui_mt:Build(tab_size)
    local tab_size = tab_size or 0
    local n = self.element_name or ""
    local children_content = ""

    for k, v in pairs(self.content) do
        children_content = children_content .. v:Build(tab_size+1).html .. "\n"
    end

    local margin = string.rep("\t", tab_size)
    local html = margin .. "<" .. n .. tostring(self.attributes) .. ">\n" .. children_content .. margin .. "</" .. n .. ">"


    return {html = html, css = ""}
end

-- enums of DOCK_

DOCK_LEFT = 0
DOCK_RIGHT = 1
DOCK_TOP = 2
DOCK_BOTTOM = 3
DOCK_CENTER = 4
DOCK_NO = 5

-- mt funcs

function block_mt:SetSize(w, h)
end

function block_mt:Dock()
end

--local function replace_char(pos, str, r)
--    return str:sub(pos, pos - 1) .. r .. str:sub(pos + 1, str:len())
--end

--local vars = {"text", "block"}
--
--for k, v in ipairs(vars) do
--    gui_mt["Is" .. (replace_char(1, v, v:sub(1, 1):upper()))] = function(self)
--        return self["is_" .. v]
--    end
--end

return lib