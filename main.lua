local util = require("libs.util")
local file_to_processing = ... -- like arg[1]

if not file_to_processing then
    util.print_error("You forgot to specify the file")
end

local file = require(file_to_processing)

if type(file) ~= "table" then -- если файл ничего не возвращает
    util.print_error("File doesn't return the page!")
end

local content = file:Build()

if not content or type(content) ~= "table" then
    util.print_error("Page hasn't content!")
end

local html_content = content.html
local css_content = content.css

if html_content then
    os.execute("mkdir \"output\\" .. file_to_processing .. "\"")

    local html_file = io.open("output/" .. file_to_processing .. "/index.html", "w")

    if not html_file then
        util.print_error("Cannot create HTML file!")
    end

    html_file:write(html_content)
    html_file:close()
end

print("Project \"" .. file_to_processing .. "\" output saved to ./output/" .. file_to_processing)