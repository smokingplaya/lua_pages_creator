local base_gui = require("libs.base_gui")

local page = base_gui.create_element(BLOCK)
page:Set("html")

local page_attr = page:GetAttributes()
page_attr:Set("text", "aasss")

local center_div = page:Add(BLOCK)
center_div:Set("div")
center_div:Center()

local div_attr = center_div:GetAttributes()
div_attr:Set("class", "btn btn-primary")

local ul = center_div:Add(BLOCK)
ul:Set("ul")

local ul1 = ul:Add(BLOCK)
ul1:Set("ul")

local ul1_attr = ul1:GetAttributes()
ul1_attr:Set("id", "download")

return page