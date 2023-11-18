local lib = {}
lib.author = "smokingplaya"

-- page

local gui_mt = {}
gui_mt.__index = gui_mt

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
        str = str .. " " .. k .. "=\"" .. v .. "\""
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

-- gui

local element_count = 0
function lib.create_element()
    element_count = element_count+1

    local obj = {
        id = element_count,
        content = {},
        attributes = new_attributes(),
        is_block = class == BLOCK,
        is_text = class == TEXT,
        styles = {}
    }

    setmetatable(obj, gui_mt)

    return obj
end

function gui_mt:GetParent()
    return self.parent
end

local rels = {
    css = "stylesheet",
    ico = "icon"
}

function gui_mt:Include(href, rel, ...) -- 3 - other args
    local link = self:Add()
    link:Set("link", nil, false)

    local attrs = link:GetAttributes()
    attrs:Set("href", href)
    attrs:Set("rel", rels[rel] and rels[rel] or rel)
end

function gui_mt:Set(k, v, b) -- set element name
    b = b == nil and true

    self.element_name = {k, v}
    self.require_end = b
    return self
end

function gui_mt:GetAttributes()
    return self.attributes
end

function gui_mt:Add(name) -- add child element
    local elem = lib.create_element(name)
    elem.parent = self

    self.content[#self.content+1] = elem

    return elem
end

function gui_mt:Build(tab_size) -- TODO: Пофиксить лишние \n
    local tab_size = tab_size or 0
    local n = self.element_name[1] or ""
    local children_content_html = ""
    local children_content_css = ""

    -- html

    for k, v in pairs(self.content) do
        local builded = v:Build(tab_size+1)

        children_content_html = children_content_html .. builded.html .. "\n"
        children_content_css = children_content_css .. builded.css .. "\n"
    end

    print("here", self.element_name[2], children_content)
    if children_content_html == "" and self.element_name[2] then
        print(self.element_name[2])
        children_content_html = self.element_name[2]
    end

    local class_name = "eid_" .. self.id

    local css = ""
    if #self.styles > 0 then
        local attrs = self:GetAttributes()
        attrs:Set("class", class_name)


        css = "." .. class_name .. " {\n"

        for k, v in ipairs(self.styles) do
            css = css .. "\t" .. v .. "\n"
        end

        css = css .. "}"
    end

    css = css .. "\n" .. children_content_css

    local margin = string.rep("\t", tab_size)
    local html = margin .. "<" .. n .. tostring(self.attributes) .. ">\n" .. (self.require_end and children_content_html .. margin .. "</" .. n .. ">" or "")
    -- css

    return {html = html, css = css}
end

-- other fns

function gui_mt:AddStyle(k, v)
    self.styles[#self.styles+1] = k .. ": " .. v .. ";"
end

function gui_mt:Center()
    self.parent:AddStyle("display", "flex")
    self.parent:AddStyle("flex-direction", "row")
    self.parent:AddStyle("flex-wrap", "wrap")
    self.parent:AddStyle("justify-content", "center")
    self.parent:AddStyle("align-items", "center")
end

function gui_mt:Dock()
end

--

function gui_mt:SetSize(w, h)
    self:SetWide(w)
    self:SetTall(w)
end

function gui_mt:SetWide(w)
    self:AddStyle("width", w)
end

function gui_mt:SetTall(h)
    self:AddStyle("height", h)
end

-- Background

function gui_mt:SetBackgroundColor(c)
    self:AddStyle("background-color", c)
end

-- Font

function gui_mt:SetFont(n)
    self:AddStyle("font-family", n)
end

function gui_mt:SetFontSize(size)
    self:AddStyle("font-size", size)
end

-- enums of DOCK_

DOCK_LEFT = 0
DOCK_RIGHT = 1
DOCK_TOP = 2
DOCK_BOTTOM = 3
DOCK_CENTER = 4
DOCK_NO = 5

-- mt funcs

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