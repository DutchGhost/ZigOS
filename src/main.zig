const terminal = @import("terminal.zig");
const Terminal = terminal.Terminal;
const Vga = terminal.Vga;
const Color = terminal.VGA_COLOR;

pub fn panic(msg: []const u8, error_return_trace: ?*builtin.StackTrace) noreturn {
    @setCold(true);
    Terminal.write("KERNEL PANIC: ");
    Terminal.write(msg);
    while (true) {}
}

pub fn kmain() void {
    Terminal.initialize();
    Terminal.setColor(Vga.entry_color(Color.LIGHT_GREEN, Color.BLACK));
    Terminal.write("Hello, kernel World!\nThis is a test\n");
}
