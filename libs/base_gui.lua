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
function lib.create_element(...)
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

    local a = {...}
    if a[1] then
        obj:Set(a[1], a[2], a[3])
    end

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

    return self
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

function gui_mt:Add(...) -- add child element
    local elem = lib.create_element(...)
    elem.parent = self

    self.content[#self.content+1] = elem

    return elem
end

-- other fns

function gui_mt:AddStyle(k, v)
    self.styles[#self.styles+1] = k .. (v and ": " .. v .. ";" or "")

    return self
end

function gui_mt:InnerStyle(k)
    if self.parent then return end -- только для <html></html>

    if not self.inner_style then
        self.inner_style = {}
    end

    self.inner_style[#self.inner_style+1] = k
end

function gui_mt:Center()
    self:AddStyle("position", "absolute")
    self:AddStyle("top", "50%")
    self:AddStyle("left", "50%")
    self:AddStyle("transform", "translate(-50%, -50%)")

    return self
end

-- Margins and positions
-- Enums of DOCK

LEFT = 0
RIGHT = 1
TOP = 2
BOTTOM = 3
FILL = 4

function gui_mt:Dock(dockMode) -- TODO: пересмотреть Dock, SetMargin, SetPadding
    if dockMode == LEFT then
        self:AddStyle("float", "left")
        self:AddStyle("height", "100%")
        self:AddStyle("margin-right", "10px")
    elseif dockMode == RIGHT then
        self:AddStyle("float", "right")
        self:AddStyle("height", "100%")
        self:AddStyle("margin-left", "10px")
    elseif dockMode == TOP then
        self.parent:AddStyle("position", "relative")
        self:AddStyle("position", "absolute")
        self:AddStyle("top", "0")
        self:AddStyle("width", "100%")
    elseif dockMode == BOTTOM then
        self.parent:AddStyle("position", "relative")
        self:AddStyle("position", "absolute")
        self:AddStyle("bottom", "0")
        self:AddStyle("width", "100%")
    elseif dockMode == FILL then
        self:AddStyle("width", "100%")
        self:AddStyle("height", "100%")
    end

    return self
end

function gui_mt:SetMargin(m1, m2, m3, m4)
    self:AddStyle("margin", (m1 or 0) .. " " .. (m2 or 0) .. " " .. (m3 or 0) .. " " .. (m4 or 0))

    return self
end

function gui_mt:SetPadding(p1, p2, p3, p4)
    self:AddStyle("padding", (p1 or 0) .. " " .. (p2 or 0) .. " " .. (p3 or 0) .. " " .. (p4 or 0))

    return self
end

-- Sizes

function gui_mt:SetSize(w, h)
    self:SetWide(w)
    self:SetTall(h)

    return self
end

function gui_mt:SetWide(w)
    self:AddStyle("width", w)

    return self
end

function gui_mt:SetTall(h)
    self:AddStyle("height", h)

    return self
end

-- Background & Colors

function gui_mt:ApplyBlur(r)
    r = "blur(" .. (r or "6") .. "px)"
    self:AddStyle("-webkit-filter", r)
    self:AddStyle("-moz-filter", r)
    self:AddStyle("-o-filter", r)
    self:AddStyle("-ms-filter", r)
    self:AddStyle("filter", r)

    return self
end

function gui_mt:ApplyShadow(s)
    s = s or "rgba(0, 0, 0, 0.5) 0px 1px 4px;"

    self:AddStyle("-moz-box-shadow", s)
    self:AddStyle("-webkit-box-shadow", s)
    self:AddStyle("box-shadow", s)

    return self
end

function gui_mt:SetBackgroundColor(c)
    self:AddStyle("background-color", c)

    return self
end

function gui_mt:SetColor(c)
    self:AddStyle("color", c)

    return self
end

-- Font & Text

function gui_mt:SetTextAlign(c)
    self:AddStyle("text-align", c)

    return self
end

function gui_mt:SetFont(n)
    self:AddStyle("font-family", n)

    return self
end

function gui_mt:SetFontSize(size)
    self:AddStyle("font-size", size)

    return self
end

-- Border

function gui_mt:SetBorder(v)
    self:AddStyle("border", v)

    return self
end

function gui_mt:SetBorderRadius(r)
    self:AddStyle("border-radius", r)

    return self
end

-- набор правил для билда
local function generate_css(self)
    local children_content = ""

    for _, child in pairs(self.content) do
        children_content = children_content .. generate_css(child)
    end

    local class_name = "e_" .. self.id
    local css = ""

    if #self.styles > 0 then
        local attrs = self:GetAttributes()
        attrs:Set("class", class_name)

        css = "." .. class_name .. " {\n"

        for _, style in ipairs(self.styles) do
            css = css .. "\t" .. style .. "\n"
        end

        css = css .. "}\n\n"
    end

    css = css .. (children_content == "" and "" or (css == "" and "" or "") .. children_content)

    if not self.parent and self.inner_style then
        local inner_style_str = ""

        for _, inner_style in ipairs(self.inner_style) do
            inner_style_str = inner_style_str .. (inner_style_str == "" and "" or "\n") .. inner_style
        end

        css = css .. inner_style_str
    end

    return css
end


-- генерирует чистейший HTML код, но в конце есть \n (лишняя строчка)
local function generate_html(self, indentation_level)
    local element_name = self.element_name[1] or ""
    local children_content = ""

    for _, child in pairs(self.content) do
        children_content = children_content .. generate_html(child, indentation_level + 1)
    end

    if children_content == "" and self.element_name[2] then
        children_content = self.element_name[2]
    end

    local indentation = string.rep("\t", indentation_level)
    local end_tag = "</" .. element_name .. ">"
    local content = (children_content == self.element_name[2]) and children_content or ("\n" .. children_content .. indentation)
    content = content .. (self.require_end and end_tag or "")

    local attributes_str = tostring(self.attributes)
    local html = indentation .. "<" .. element_name .. attributes_str .. ">" .. (self.require_end and content or "") .. "\n"

    return html
end

-- билд
function gui_mt:Build(tab_size)
    tab_size = tab_size or 0

    -- сначала нужно генерировать css, так как он добавляет в дум-элементы (дум пацаны) аттрибут с классом
    local css = generate_css(self, tab_size)
    local html = generate_html(self, tab_size)

    return {html = html, css = css}
end

return lib