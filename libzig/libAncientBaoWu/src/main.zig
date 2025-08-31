const std = @import("std");
// const testing = std.testing;

pub const AncientBaoWuStruct = extern struct {
    MingZhu: [*:0]u8,
    YuDiao: [*:0]u8,
    YuBi: [*:0]u8,
    ChouDuan: [*:0]u8,
    AddNum: c_int,
};

pub const AncientBaoWuResult = extern struct {
    MingZhu: c_int,
    YuDiao: c_int,
    YuBi: c_int,
    ChouDuan: c_int,
};

export fn AncientBaoWuStruct_Create(MingZhu: [*:0]u8, YuDiao: [*:0]u8, YuBi: [*:0]u8, ChouDuan: [*:0]u8, AddNum: c_int) *AncientBaoWuStruct {
    const allocator = std.heap.c_allocator;
    const baowustruct = allocator.create(AncientBaoWuStruct) catch unreachable;

    baowustruct.MingZhu = allocator.dupeZ(u8, std.mem.span(MingZhu)) catch unreachable;
    baowustruct.YuDiao = allocator.dupeZ(u8, std.mem.span(YuDiao)) catch unreachable;
    baowustruct.YuBi = allocator.dupeZ(u8, std.mem.span(YuBi)) catch unreachable;
    baowustruct.ChouDuan = allocator.dupeZ(u8, std.mem.span(ChouDuan)) catch unreachable;
    baowustruct.AddNum = AddNum;

    return baowustruct;
}

export fn AncientBaoWuStruct_Write(baowustruct: *AncientBaoWuStruct, which: c_int, howmany: c_int) c_int {
    const file = if (which == 0)
        baowustruct.MingZhu
    else if (which == 1)
        baowustruct.YuDiao
    else if (which == 2)
        baowustruct.YuBi
    else
        baowustruct.ChouDuan;
    const tmp = AncientBaoWuResult_CreateFrom(baowustruct);
    defer AncientBaoWuResult_Free(tmp);
    const result = if (which == 0)
        tmp.MingZhu
    else if (which == 1)
        tmp.YuDiao
    else if (which == 2)
        tmp.YuBi
    else
        tmp.ChouDuan;
    if (std.fs.cwd().createFile(std.mem.span(file), .{})) |file1| {
        defer file1.close();
        var buffer: [20]u8 = undefined;
        if (std.fmt.bufPrint(&buffer, "{d}", .{@as(i32, result) + baowustruct.AddNum + howmany})) |str| {
            if (file1.writeAll(str)) |_| {
                return 0;
            } else |_| {
                return -1;
            }
        } else |_| {
            return -1;
        }
    } else |_| {
        return -1;
    }
}

export fn AncientBaoWuStruct_Free(baowustruct: *AncientBaoWuStruct) void {
    const allocator = std.heap.c_allocator;

    allocator.free(std.mem.span(baowustruct.MingZhu));
    allocator.free(std.mem.span(baowustruct.YuDiao));
    allocator.free(std.mem.span(baowustruct.YuBi));
    allocator.free(std.mem.span(baowustruct.ChouDuan));

    allocator.destroy(baowustruct);
}

export fn AncientBaoWuResult_CreateFrom(baowustruct: *AncientBaoWuStruct) *AncientBaoWuResult {
    const allocator = std.heap.c_allocator;
    const baowuresult = allocator.create(AncientBaoWuResult) catch unreachable;

    // 读取操作
    const MingZhuPath = std.mem.span(baowustruct.MingZhu);
    if (std.fs.cwd().openFile(MingZhuPath, .{ .mode = .read_only })) |MingZhuFile| {
        defer MingZhuFile.close();
        var buffer: [16]u8 = undefined;
        if (MingZhuFile.readAll(&buffer)) |bytes_read| {
            if (bytes_read == 0) {
                baowuresult.MingZhu = 0;
            } else {
                const content = std.mem.trim(u8, buffer[0..bytes_read], " \t\n\r");
                if (std.fmt.parseInt(i32, content, 10)) |readint| {
                    baowuresult.MingZhu = @as(c_int, readint - baowustruct.AddNum);
                } else |_| {
                    baowuresult.MingZhu = 0;
                }
            }
        } else |_| {
            baowuresult.MingZhu = 0;
        }
    } else |err| {
        if (err == error.FileNotFound) {
            if (std.fs.cwd().createFile(MingZhuPath, .{})) |new_file| {
                defer new_file.close();

                var buffer: [20]u8 = undefined;
                if (std.fmt.bufPrint(&buffer, "{d}", .{baowustruct.AddNum})) |str| {
                    if (new_file.writeAll(str)) |_| {
                        baowuresult.MingZhu = 0;
                    } else |_| {
                        baowuresult.MingZhu = 0;
                    }
                } else |_| {
                    baowuresult.MingZhu = 0;
                }
            } else |_| {
                baowuresult.MingZhu = 0;
            }
        }
    }

    const YuDiaoPath = std.mem.span(baowustruct.YuDiao);
    if (std.fs.cwd().openFile(YuDiaoPath, .{ .mode = .read_only })) |YuDiaoFile| {
        defer YuDiaoFile.close();
        var buffer: [16]u8 = undefined;
        if (YuDiaoFile.readAll(&buffer)) |bytes_read| {
            if (bytes_read == 0) {
                baowuresult.YuDiao = 0;
            } else {
                const content = std.mem.trim(u8, buffer[0..bytes_read], " \t\n\r");
                if (std.fmt.parseInt(i32, content, 10)) |readint| {
                    baowuresult.YuDiao = @as(c_int, readint - baowustruct.AddNum);
                } else |_| {
                    baowuresult.YuDiao = 0;
                }
            }
        } else |_| {
            baowuresult.YuDiao = 0;
        }
    } else |err| {
        if (err == error.FileNotFound) {
            if (std.fs.cwd().createFile(YuDiaoPath, .{})) |new_file| {
                defer new_file.close();

                var buffer: [20]u8 = undefined;
                if (std.fmt.bufPrint(&buffer, "{d}", .{baowustruct.AddNum})) |str| {
                    if (new_file.writeAll(str)) |_| {
                        baowuresult.YuDiao = 0;
                    } else |_| {
                        baowuresult.YuDiao = 0;
                    }
                } else |_| {
                    baowuresult.YuDiao = 0;
                }
            } else |_| {
                baowuresult.YuDiao = 0;
            }
        }
    }

    const YuBiPath = std.mem.span(baowustruct.YuBi);
    if (std.fs.cwd().openFile(YuBiPath, .{ .mode = .read_only })) |YuBiFile| {
        defer YuBiFile.close();
        var buffer: [16]u8 = undefined;
        if (YuBiFile.readAll(&buffer)) |bytes_read| {
            if (bytes_read == 0) {
                baowuresult.YuBi = 0;
            } else {
                const content = std.mem.trim(u8, buffer[0..bytes_read], " \t\n\r");
                if (std.fmt.parseInt(i32, content, 10)) |readint| {
                    baowuresult.YuBi = @as(c_int, readint - baowustruct.AddNum);
                } else |_| {
                    baowuresult.YuBi = 0;
                }
            }
        } else |_| {
            baowuresult.YuBi = 0;
        }
    } else |err| {
        if (err == error.FileNotFound) {
            if (std.fs.cwd().createFile(YuBiPath, .{})) |new_file| {
                defer new_file.close();

                var buffer: [20]u8 = undefined;
                if (std.fmt.bufPrint(&buffer, "{d}", .{baowustruct.AddNum})) |str| {
                    if (new_file.writeAll(str)) |_| {
                        baowuresult.YuBi = 0;
                    } else |_| {
                        baowuresult.YuBi = 0;
                    }
                } else |_| {
                    baowuresult.YuBi = 0;
                }
            } else |_| {
                baowuresult.YuBi = 0;
            }
        }
    }

    const ChouDuanPath = std.mem.span(baowustruct.ChouDuan);
    if (std.fs.cwd().openFile(ChouDuanPath, .{ .mode = .read_only })) |ChouDuanFile| {
        defer ChouDuanFile.close();
        var buffer: [16]u8 = undefined;
        if (ChouDuanFile.readAll(&buffer)) |bytes_read| {
            if (bytes_read == 0) {
                baowuresult.ChouDuan = 0;
            } else {
                const content = std.mem.trim(u8, buffer[0..bytes_read], " \t\n\r");
                if (std.fmt.parseInt(i32, content, 10)) |readint| {
                    baowuresult.ChouDuan = @as(c_int, readint - baowustruct.AddNum);
                } else |_| {
                    baowuresult.ChouDuan = 0;
                }
            }
        } else |_| {
            baowuresult.ChouDuan = 0;
        }
    } else |err| {
        if (err == error.FileNotFound) {
            if (std.fs.cwd().createFile(ChouDuanPath, .{})) |new_file| {
                defer new_file.close();

                var buffer: [20]u8 = undefined;
                if (std.fmt.bufPrint(&buffer, "{d}", .{baowustruct.AddNum})) |str| {
                    if (new_file.writeAll(str)) |_| {
                        baowuresult.ChouDuan = 0;
                    } else |_| {
                        baowuresult.ChouDuan = 0;
                    }
                } else |_| {
                    baowuresult.ChouDuan = 0;
                }
            } else |_| {
                baowuresult.ChouDuan = 0;
            }
        }
    }

    return baowuresult;
}

export fn AncientBaoWuResult_Free(baowuresult: *AncientBaoWuResult) void {
    const allocator = std.heap.c_allocator;

    allocator.destroy(baowuresult);
}
