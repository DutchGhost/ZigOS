const terminal = @import("terminal.zig");
const Terminal = terminal.Terminal;
const vga = @import("vga.zig");
const VgaColor = vga.VgaColor;
const Color = vga.Color;

pub fn panic(msg: []const u8, error_return_trace: ?*builtin.StackTrace) noreturn {
    @setCold(true);
    Terminal.write("KERNEL PANIC: ");
    Terminal.write(msg);
    while (true) {}
}

pub fn kmain() void {
    Terminal.initialize();
    Terminal.setColor(Color{ .fg = VgaColor.LIGHT_GREEN, .bg = VgaColor.BLACK });
    Terminal.write("Hello, kernel World!\nThis is a test\n");
}
