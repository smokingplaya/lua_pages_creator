<h1 align="center">LPC Docs</h1>

The principle of LPC is based on [metatables](https://www.lua.org/pil/13.html).

Metatables in Lua = classes

There are two classes in LPC: gui_element and attributes. Let's consider them separately.

### gui_element
gui_element is the main class, through which the work with the elements of the web page goes. Now it has the following methods:
* GetParent() -> parent gui_element
* [only for [link tag](https://developer.mozilla.org/en/docs/Web/HTML/Element/link)] Include(href: String, ref: String, ...: Vararg) -> TODO
* Set(k: String, v: String, b: Boolean) -> gui_element; Sets tag for element. k - tag name, v - value, b - is tag needs end
* GetAttributes() -> attributes of gui_element
* Add(...: Vararg) -> new gui_element
* AddStyle(k, v) -> gui_element
* [only for [html](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/html)] InnerStyle(k, v) -> gui_element
* Center() -> gui_element
* Dock(dockMode: Number) -> gui_element
* SetMargin(v1, v2, v3, v4) -> gui_element
* SetPadding(v1, v2, v3, v4) -> gui_element
* SetSize(w, h) -> gui_element
* SetWide(w) -> gui_element
* SetTall(h) -> gui_element
* ApplyBlur(r (optional)) -> gui_element
* ApplyShadow(s (optional)) -> gui_element
* SetBackgroundColor(c) -> gui_element
* SetColor(c) -> gui_element
* SetTextAlign(c) -> gui_element

Will be continued