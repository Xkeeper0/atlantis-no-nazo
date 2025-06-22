

while true do

	local px	= memory.readbyte(0x210)
	local px2	= memory.readbyte(0x211)
	local py	= memory.readbyte(0x212)
	local py2	= memory.readbyte(0x213)

	local scry	= (py - 0x48) * 4 + (py2 / 0x40)
	gui.text(122, scry, string.format("\n%02X\n%02X", px, py))

	emu.frameadvance()

end
