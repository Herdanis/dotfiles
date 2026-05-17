return {
	entry = function(self, job)
		local dir = job.args[1] or "down"
		local sign = dir == "up" and -1 or 1

		local value, event = ya.input {
			pos   = { "top-center", y = 3, w = 20 },
			title = "Jump " .. dir .. ":",
		}

		if event == 1 then
			local n = tonumber(value)
			if n and n > 0 then
				ya.emit("arrow", { n * sign })
			end
		end
	end,
}
