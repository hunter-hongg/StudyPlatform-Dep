const std = @import("std");
const callocator = std.heap.c_allocator;

pub const YuZhan = extern struct {
    file: [*:0]u8,
    AddNum: c_int,
};
export fn YuZhan_Create(file: [*:0]u8, addnum: c_int) *YuZhan {
    const tmp = callocator.create(YuZhan) catch unreachable;

    tmp.file = callocator.dupeZ(u8, std.mem.span(file)) catch unreachable;
    tmp.AddNum = addnum;

    return tmp;
}
export fn YuZhan_Free(yuzhan: *YuZhan) void {
    callocator.free(std.mem.span(yuzhan.file));
    callocator.destroy(yuzhan);
}
export fn YuZhan_Get(yuzhan: *YuZhan) c_int {
    const Path = std.mem.span(yuzhan.file);
    if (std.fs.cwd().openFile(Path, .{ .mode = .read_only })) |File| {
        defer File.close();
        var buffer: [16]u8 = undefined;
        if (File.readAll(&buffer)) |bytes_read| {
            if (bytes_read == 0) {
                return 0;
            } else {
                const content = std.mem.trim(u8, buffer[0..bytes_read], " \t\n\r");
                if (std.fmt.parseInt(i32, content, 10)) |readint| {
                    return @as(c_int, readint - yuzhan.AddNum);
                } else |_| {
                    return 0;
                }
            }
        } else |_| {
            return 0;
        }
    } else |err| {
        if (err == error.FileNotFound) {
            if (std.fs.cwd().createFile(Path, .{})) |new_file| {
                defer new_file.close();

                var buffer: [20]u8 = undefined;
                if (std.fmt.bufPrint(&buffer, "{d}", .{yuzhan.AddNum})) |str| {
                    if (new_file.writeAll(str)) |_| {
                        return 0;
                    } else |_| {
                        return 0;
                    }
                } else |_| {
                    return 0;
                }
            } else |_| {
                return 0;
            }
        } else {
            return 0;
        }
    }
}
export fn YuZhan_Write(yuzhan: *YuZhan, addnum: c_int) void {
    const file = yuzhan.file;
    const tmp = YuZhan_Get(yuzhan);
    const result = tmp;
    if (std.fs.cwd().createFile(std.mem.span(file), .{})) |file1| {
        defer file1.close();
        var buffer: [20]u8 = undefined;
        if (std.fmt.bufPrint(&buffer, "{d}", .{@as(i32, result) + yuzhan.AddNum + addnum})) |str| {
            if (file1.writeAll(str)) |_| {
                return;
            } else |_| {
                return;
            }
        } else |_| {
            return;
        }
    } else |_| {
        return;
    }
}
