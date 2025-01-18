const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const dep_x = b.dependency("dep_x", .{
        .target = target,
        .optimize = optimize,
        .bar = true,
    });

    // uncommenting this line works around the issue
    // if (b.graph.needed_lazy_dependencies.entries.len != 0) return;

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const exe = b.addExecutable(.{
        .name = "lazy_test",
        .root_module = exe_mod,
    });

    exe.linkLibrary(dep_x.artifact("dep_x"));
    b.installArtifact(exe);
}
