local lpc_gui = require("libs.base_gui")

local page = lpc_gui.create_element("html")

local head = page:Add("head")
    :Include("style.css", "css")
    :Add("title", "Example Title")

local body = page:Add("body")

body.center_div = body:Add("div")
    :SetSize("50vw", "50vh")
    :SetBackgroundColor("gray")
    :SetBorderRadius("16px")
    :Center()

body.text = body.center_div:Add("h1", "Example Text")
    :SetFont("Roboto")
    :SetFontSize("24px")
    :SetColor("white")
    :Center()

return page