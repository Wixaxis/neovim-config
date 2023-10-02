local M = {}

M.confirm_mapping = function(cmp)
	return cmp.mapping.confirm {
		behavior = cmp.ConfirmBehavior.Replace,
		select = true,
	}
end

M.next_item = function(cmp, luasnip)
	return cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_locally_jumpable() then
			luasnip.expand_or_jump()
		else
			fallback()
		end
	end, { 'i', 's' })
end

M.prev_item = function(cmp, luasnip)
	return cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.locally_jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, { 'i', 's' })
end

return M
