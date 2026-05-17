require("sshfs"):setup()
require("zoxide"):setup()

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
	local left, right = {}, {}
	for i, f in ipairs(files) do
		local entity = Entity:new(f)
		local abs_pos = offset + i - 1
		local rel = math.abs(abs_pos - cursor)
		local num_str = rel == 0
			and string.format("%3d ", cursor + 1)
			or string.format("%3d ", rel)
		local num = ui.Span(num_str):style(ui.Style():fg("darkgray"))
		left[#left + 1] = ui.Line { num, entity:redraw() }
		right[#right + 1] = Linemode:new(f):redraw()

		local max = math.max(0, self._area.w - right[#right]:width() - 4)
		left[#left]:truncate { max = max, ellipsis = entity:ellipsis(max) }
	end

	return {
		ui.List(left):area(self._area),
		ui.Text(right):area(self._area):align(ui.Align.RIGHT),
	}
end
