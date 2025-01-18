extern fn foo() callconv(.C) c_int;
extern fn bar() callconv(.C) c_int;

pub fn main() !void {
    std.debug.print("All your foo={} and bar={} are belong to us.\n", .{ foo(), bar() });
}

const std = @import("std");
