const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    const target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("ZigOS", "src/boot.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.setLinkerScriptPath("linker.ld");
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
}

// const std = @import("std");
// const builtin = std.builtin;

// pub fn build(b: *std.build.Builder) void {
//     const kernel = buildKernel(b);

//     const qemu = b.step("qemu", "Run the OS with Qemu");
//     const qemu_params = &.{
//         "C:\\Program Files\\qemu\\qemu-system-i386",
//         "-kernel", kernel,
//     };

//     const run_qemu = b.addSystemCommand(qemu_params);
//     run_qemu.step.dependOn(b.default_step);
//     qemu.dependOn(&run_qemu.step);
//     // const run_cmd = exe.run();
//     // run_cmd.step.dependOn(b.getInstallStep());
//     // if (b.args) |args| {
//     //     run_cmd.addArgs(args);
//     // }

//     // const run_step = b.step("run", "Run the app");
//     // run_step.dependOn(&run_cmd.step);

//     // const boot_step = b.step("boot", "boot in qemu");
//     // boot_step.dependOn(&exe.step);
//     // boot_step.makeFn()

// }

// fn buildKernel(b: *std.build.Builder) []const u8 {

//     const kernel = b.addExecutable("ZigOS", "src/boot.zig");
//     kernel.setLinkerScriptPath("linker.ld");

//     const target = b.standardTargetOptions(.{});
//     kernel.setTarget(target);
//     kernel.setBuildMode(b.standardReleaseOptions());
//     b.default_step.dependOn(&kernel.step);

//     kernel.install();

// //    return kernel.getOutputPath();

//     return "zig-out/bin/ZigOS";
// }
