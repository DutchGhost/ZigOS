pub const vga = @import("vga.zig");
pub const VgaColor = vga.VgaColor;
pub const Color = vga.Color;

pub const Terminal = struct {
    var row = @as(usize, 0);
    var column = @as(usize, 0);
    var color = Color{ .fg = VgaColor.RED, .bg = VgaColor.BLACK };

    pub fn initialize() void {
        clear();
    }

    pub fn clear() void {
        row = 0;
        column = 0;
        var y = @as(usize, 0);
        while (y < vga.HEIGHT) : (y += 1) {
            var x = @as(usize, 0);
            while (x < vga.WIDTH) : (x += 1) {
                vga.putCharAt(' ', color, x, y);
            }
        }
    }

    pub fn setColor(new_color: Color) void {
        color = new_color;
    }

    fn putChar(c: u8) void {
        if (c == '\n') {
            column = 0;
            row += 1;
            return;
        }
        vga.putCharAt(c, color, column, row);

        column += 1;
        if (column == vga.WIDTH) {
            column = 0;
            row += 1;
            if (row == vga.HEIGHT)
                row = 0;
        }
    }

    pub fn write(data: []const u8) void {
        for (data) |c|
            putChar(c);
    }
};
