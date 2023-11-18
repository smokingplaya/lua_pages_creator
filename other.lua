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
center_div:SetWide("20%")
center_div:SetTall("25%")
center_div:SetBackgroundColor("#FFFFFF")
center_div:Center()
center_div:SetBorderRadius("10px")

local other_div = center_div:Add()
other_div:Set("div")
other_div:SetBackgroundColor("#CCCCCC")
other_div:Dock(BOTTOM)
other_div:SetTall("100px")
other_div:SetBorderRadius("10px")

local title_text = other_div:Add()
title_text:Set("h1", "Test text #1 Lorem inpsum")
title_text:SetFont("Manrope")
title_text:SetWide("100%")
title_text:SetFontSize("24px")
title_text:SetTextAlign("center")
title_text:Center()

--local texts = {
--    "В Lua сила!",
--    "Привет братья славяне!",
--    "luapagecreatortool2023"
--}
--
--for k, v in pairs(texts) do
--    local parent = center_div:Add()
--    parent:Set("div")
--    --parent:SetBackgroundColor("#CCCCCC")
--
--    local center_text = parent:Add()
--    center_text:Set("h1", v)
--    center_text:Center()
--    --center_text:SetTall("20px")
--    center_text:SetFont("Manrope")
--    center_text:SetColor("black")
--    center_text:SetFontSize("24px")
--end

return page