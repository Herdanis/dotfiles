require("sshfs"):setup()
require("zoxide"):setup()
require("relative-motions"):setup({ show_numbers = "none", show_motion = true })

-- ============================================
-- Line Numbers (left side)
-- ============================================
function Current:redraw()
	local files = self._folder.window
	if #files == 0 then
		return self:empty()
	end

	local offset = self._folder.offset
	local cursor = self._folder.cursor
	local entities, linemodes = {}, {}
	for i, f in ipairs(files) do
		local entity = Entity:new(f)
		local abs_pos = offset + i - 1
		local rel = math.abs(abs_pos - cursor)
		local num_str = rel == 0
			and string.format("%3d ", cursor + 1)
			or string.format("%3d ", rel)
		local num = ui.Span(num_str):style(ui.Style():fg("darkgray"))
		entities[#entities + 1] = ui.Line({ num, entity:redraw() }):style(entity:style())
		linemodes[#linemodes + 1] = Linemode:new(f):redraw()
	end

	return {
		ui.List(entities):area(self._area),
		ui.Text(linemodes):area(self._area):align(ui.Align.RIGHT),
	}
end
