const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const build_bar = b.option(bool, "bar", "include bar!") orelse false;

    const lib_mod = b.createModule(.{
        .root_source_file = null,
        .target = target,
        .optimize = optimize,
    });
    lib_mod.addCSourceFiles(.{ .root = b.path("src/"), .files = &.{"foo.c"} });
    if (build_bar) {
        const bar = b.lazyDependency("bar", .{}) orelse return;
        lib_mod.addCSourceFiles(.{ .root = bar.path("."), .files = &.{"bar.c"} });
    }

    const lib = b.addStaticLibrary(.{
        .name = "dep_x",
        .root_module = lib_mod,
    });

    b.installArtifact(lib);
}
