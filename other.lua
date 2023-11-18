local base_gui = require("libs.base_gui")

local page = base_gui.create_element()
page:Set("html")

page.head = page:Add()
page.head:Set("head")
page.head:Include("style.css", "css")

page.title = page.head:Add()
page.title:Set("title", "Test page")

local body = page:Add()
body:Set("body")

local div_attr = body:GetAttributes()
div_attr:Set("style", "background: black;width:100%;height:100%;margin:0;")

local center_div = body:Add()
center_div:Set("div")
center_div:SetWide("50%")
center_div:SetTall("25%")
center_div:SetBackgroundColor("#FFFFFF")
center_div:Center()

local texts = {
    "Lua = power",
    "test string",
    "aboba"
}

for k, v in pairs(texts) do
    local parent = center_div:Add()
    parent:Set("div")

    local center_text = parent:Add()
    center_text:Set("h1", v)
    center_text:Center()
    center_text:SetFont("Manrope")
    center_text:SetFontSize("24px")
end

return page