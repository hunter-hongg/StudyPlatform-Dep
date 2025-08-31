const std = @import("std");
const callocator = std.heap.c_allocator;

pub const BaoWuChaFiles = extern struct {
    ChaHu: [*:0]u8,
    ChaZhan: [*:0]u8,
    AddNum: c_int,
};

export fn BaoWuChaFiles_Make(chahu: [*:0]u8, chazhan: [*:0]u8, addnum: c_int) *BaoWuChaFiles {
    const tmp = callocator.create(BaoWuChaFiles) catch unreachable;

    tmp.ChaHu = callocator.dupeZ(u8, std.mem.span(chahu)) catch unreachable;
    tmp.ChaZhan = callocator.dupeZ(u8, std.mem.span(chazhan)) catch unreachable;
    tmp.AddNum = addnum;

    return tmp;
}
export fn BaoWuChaFiles_Free(file: *BaoWuChaFiles) void {
    callocator.free(std.mem.span(file.ChaHu));
    callocator.free(std.mem.span(file.ChaZhan));
    callocator.destroy(file);
}
export fn BaoWuChaFiles_Read(file: *BaoWuChaFiles, flag: c_int) c_int {
    const Path = if (flag == 0)
        std.mem.span(file.ChaHu)
    else
        std.mem.span(file.ChaZhan);
    if (std.fs.cwd().openFile(Path, .{ .mode = .read_only })) |File| {
        defer File.close();
        var buffer: [16]u8 = undefined;
        if (File.readAll(&buffer)) |bytes_read| {
            if (bytes_read == 0) {
                return 0;
            } else {
                const content = std.mem.trim(u8, buffer[0..bytes_read], " \t\n\r");
                if (std.fmt.parseInt(i32, content, 10)) |readint| {
                    return @as(c_int, readint - file.AddNum);
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
                if (std.fmt.bufPrint(&buffer, "{d}", .{file.AddNum})) |str| {
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
export fn BaoWuChaFiles_Add(filea: *BaoWuChaFiles, flag: c_int, addnum: c_int) void {
    const file = if(flag == 0)
        std.mem.span(filea.ChaHu)
    else 
        std.mem.span(filea.ChaZhan);
    const tmp = BaoWuChaFiles_Read(filea, flag);
    const result = @as(i32, tmp);
    if (std.fs.cwd().createFile(file, .{})) |file1| {
        defer file1.close();
        var buffer: [20]u8 = undefined;
        if (std.fmt.bufPrint(&buffer, "{d}", .{result + filea.AddNum + addnum})) |str| {
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
