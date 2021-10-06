pub const VGA_COLOR = packed enum(u8) {
    BLACK = 0,
    BLUE = 1,
    GREEN = 2,
    CYAN = 3,
    RED = 4,
    MAGENTA = 5,
    BROWN = 6,
    LIGHT_GREY = 7,
    DARK_GREY = 8,
    LIGHT_BLUE = 9,
    LIGHT_GREEN = 10,
    LIGHT_CYAN = 11,
    LIGHT_RED = 12,
    LIGHT_MAGENTA = 13,
    LIGHT_BROWN = 14,
    WHITE = 15,
};

pub const Vga = struct {
    const WIDTH = 80;
    const HEIGHT = 25;

    const buffer = @intToPtr([*]volatile u16, 0xB8000);

    pub fn entry_color(fg: VGA_COLOR, bg: VGA_COLOR) u8 {
        return @enumToInt(fg) | (@enumToInt(bg) << 4);
    }

    fn entry(uc: u8, color: u8) u16 {
        return @as(u16, uc) | (@as(u16, color) << 8);
    }

    pub fn putCharAt(char: u8, color: u8, x: usize, y: usize) void {
        const index = y * WIDTH + x;
        buffer[index] = entry(char, color);
    }
};

pub const Terminal = struct {
    var row = @as(usize, 0);
    var column = @as(usize, 0);
    var color = Vga.entry_color(VGA_COLOR.RED, VGA_COLOR.BLACK);

    pub fn initialize() void {
        clear();
    }

    pub fn clear() void {
        row = 0;
        column = 0;
        var y = @as(usize, 0);
        while (y < Vga.HEIGHT) : (y += 1) {
            var x = @as(usize, 0);
            while (x < Vga.WIDTH) : (x += 1) {
                Vga.putCharAt(' ', color, x, y);
            }
        }
    }

    pub fn setColor(new_color: u8) void {
        color = new_color;
    }

    fn putChar(c: u8) void {
        if (c == '\n') {
            column = 0;
            row += 1;
            return;
        }
        Vga.putCharAt(c, color, column, row);

        column += 1;
        if (column == Vga.WIDTH) {
            column = 0;
            row += 1;
            if (row == Vga.HEIGHT)
                row = 0;
        }
    }

    pub fn write(data: []const u8) void {
        for (data) |c|
            putChar(c);
    }
};
