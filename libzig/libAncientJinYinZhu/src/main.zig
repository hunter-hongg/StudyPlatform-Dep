const std = @import("std");
const callocator = std.heap.c_allocator;

pub const AncientJinYinZhu = extern struct {
    JinZhu: [*:0]u8,
    YinZhu: [*:0]u8,
    AddNum: c_int,
};

export fn AncientJinYinZhu_New(jinzhu: [*:0]u8, yinzhu: [*:0]u8, addnum: c_int) *AncientJinYinZhu {
    const tmp = callocator.create(AncientJinYinZhu) catch unreachable;

    tmp.JinZhu = callocator.dupeZ(u8, std.mem.span(jinzhu)) catch unreachable;
    tmp.YinZhu = callocator.dupeZ(u8, std.mem.span(yinzhu)) catch unreachable;
    tmp.AddNum = addnum;

    return tmp;
}
export fn AncientJinYinZhu_Free(jinyinzhu: *AncientJinYinZhu) void {
    callocator.free(std.mem.span(jinyinzhu.JinZhu));
    callocator.free(std.mem.span(jinyinzhu.YinZhu));
    callocator.destroy(jinyinzhu);
}
export fn AncientJinYinZhu_Read(jinyinzhu: *AncientJinYinZhu, flag: c_int) c_int {
    const Path = if (flag == 0)
        std.mem.span(jinyinzhu.JinZhu)
    else
        std.mem.span(jinyinzhu.YinZhu);
    if (std.fs.cwd().openFile(Path, .{ .mode = .read_only })) |File| {
        defer File.close();
        var buffer: [16]u8 = undefined;
        if (File.readAll(&buffer)) |bytes_read| {
            if (bytes_read == 0) {
                return 0;
            } else {
                const content = std.mem.trim(u8, buffer[0..bytes_read], " \t\n\r");
                if (std.fmt.parseInt(i32, content, 10)) |readint| {
                    return @as(c_int, readint - jinyinzhu.AddNum);
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
                if (std.fmt.bufPrint(&buffer, "{d}", .{jinyinzhu.AddNum})) |str| {
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
export fn AncientJinYinZhu_Write(jinyinzhu: *AncientJinYinZhu, flag: c_int, addnum: c_int) void {
    const file = if (flag == 0)
        std.mem.span(jinyinzhu.JinZhu)
    else
        std.mem.span(jinyinzhu.YinZhu);
    const tmp = AncientJinYinZhu_Read(jinyinzhu, flag);
    const result = @as(i32, tmp);
    if (std.fs.cwd().createFile(file, .{})) |file1| {
        defer file1.close();
        var buffer: [20]u8 = undefined;
        if (std.fmt.bufPrint(&buffer, "{d}", .{result + jinyinzhu.AddNum + addnum})) |str| {
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
