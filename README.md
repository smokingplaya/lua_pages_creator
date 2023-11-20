<h1 align="center">Lua Pages Creator</h1>
<h2 align="center">

LPC is a Lua-script that allows you to create static web pages using Lua objects, which makes web development much easier.

<img src="https://img.shields.io/badge/LUA POWERED-2C2D72?style=for-the-badge&logo=lua&logoColor=white">
</h2>

### Code Example

```lua
-- example.lua
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
```

### How to work with LPC?
(You must have Lua installed)

1. Create a *.lua file in the root directory of the LPC (this is where the main.lua file is located).
2. Write your page code according to the [documentation](DOCS.md) in the newly created file.
3. Type the command lua main.lua * (where * is the name of the file you created; for example lua main.lua example.lua) into the terminal
4. Go to the output/* directory and find the files of your project.

Done!