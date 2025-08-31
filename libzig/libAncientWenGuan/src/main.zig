const std = @import("std");
const c = @cImport(@cInclude("stdlib.h"));

fn Create(file_path: []const u8) !void {
    const file = std.fs.cwd().openFile(
        file_path,
        .{ .mode = .read_write },
    ) catch |err| switch (err) {
        error.FileNotFound => {
            _ = try std.fs.cwd().createFile(file_path, .{});
            return;
        },
        else => return err,
    };
    defer file.close();
}

pub const AncientWenGuanConfig = extern struct {
    file: [*:0]u8,
    addnum: c_int,
};

export fn AncientWenGuanConfig_Create(file: [*:0]const u8, addnum: c_int) *AncientWenGuanConfig {
    const allocator = std.heap.c_allocator;
    const wenguanconfig = allocator.create(AncientWenGuanConfig) catch unreachable;

    wenguanconfig.addnum = addnum;
    wenguanconfig.file = allocator.dupeZ(u8, std.mem.span(file)) catch unreachable;
    return wenguanconfig;
}

export fn AncientWenGuanConfig_Free(wenguanconfig: *AncientWenGuanConfig) void {
    const allocator = std.heap.c_allocator;
    allocator.free(std.mem.span(wenguanconfig.file));
    allocator.destroy(wenguanconfig);
}

export fn AncientWenGuanConfig_ReadLevel(wenguanconfig: *AncientWenGuanConfig) c_int {
    const file_path = std.mem.span(wenguanconfig.file);

    const file = std.fs.cwd().openFile(file_path, .{ .mode = .read_only }) catch |err| {
        if (err == error.FileNotFound) {
            const new_file = std.fs.cwd().createFile(file_path, .{}) catch return 9;
            defer new_file.close();
            var buffer: [20]u8 = undefined;
            const str = std.fmt.bufPrint(&buffer, "{d}", .{wenguanconfig.addnum + 9}) catch return 9;
            new_file.writeAll(str) catch return 9;
            return 9;
        }
        return 9;
    };
    defer file.close();

    var buffer: [16]u8 = undefined;
    const bytes_read = file.readAll(&buffer) catch return 9;
    if (bytes_read == 0) return 9;

    const content = std.mem.trim(u8, buffer[0..bytes_read], " \t\n\r");
    var readint = std.fmt.parseInt(i32, content, 10) catch return 9;
    readint -= wenguanconfig.addnum;
    if (readint < 1 or readint > 9) return 9;

    return @as(c_int, std.math.clamp(readint, 1, 9));
}

export fn AncientWenGuanConfig_NewLevel(wenguanconfig: *AncientWenGuanConfig, newlevel: c_int) c_int {
    const file_path = std.mem.span(wenguanconfig.file);
    const file = std.fs.cwd().createFile(file_path, .{}) catch return -1;
    defer file.close();
    var buffer: [20]u8 = undefined;
    const str = std.fmt.bufPrint(&buffer, "{d}", .{wenguanconfig.addnum + newlevel}) catch return -1;
    file.writeAll(str) catch return -1;
    return 0;
}

export fn AncientWenGuanConfig_LevelUp(wenguanconfig: *AncientWenGuanConfig) c_int {
    const a = @as(i32, AncientWenGuanConfig_ReadLevel(wenguanconfig)) - 1;
    if (a < 1 or a > 9) return -1;
    return AncientWenGuanConfig_NewLevel(wenguanconfig, @as(c_int, a));
}

export fn AncientWenGuanConfig_LevelDown(wenguanconfig: *AncientWenGuanConfig) c_int {
    const a = @as(i32, AncientWenGuanConfig_ReadLevel(wenguanconfig)) + 1;
    if (a < 1 or a > 9) return -1;
    return AncientWenGuanConfig_NewLevel(wenguanconfig, @as(c_int, a));
}

export fn AncientWenGuanConfig_GetFengLu(wenguanconfig: *AncientWenGuanConfig) c_int {
    const a = @as(i32, AncientWenGuanConfig_ReadLevel(wenguanconfig));
    if (a >= 6) return @as(c_int, (10 - a) * 5);
    return @as(c_int, (10 - a) * 6);
}
