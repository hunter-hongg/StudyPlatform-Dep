const std = @import("std");
const callocator = std.heap.c_allocator;

pub const BookShelfFiles = extern struct {
    Level1: [*:0]u8,
    Level2: [*:0]u8,
    Level3: [*:0]u8,
    Addnum: c_int,
};
pub const BookShelfResult = extern struct {
    Level1: c_int,
    Level2: c_int,
    Level3: c_int,
};

export fn BookShelfFiles_New(Level1: [*:0]u8, Level2: [*:0]u8, Level3: [*:0]u8, Addnum: c_int) *BookShelfFiles {
    const tmp = callocator.create(BookShelfFiles) catch unreachable;

    tmp.Level1 = callocator.dupeZ(u8, std.mem.span(Level1)) catch unreachable;
    tmp.Level2 = callocator.dupeZ(u8, std.mem.span(Level2)) catch unreachable;
    tmp.Level3 = callocator.dupeZ(u8, std.mem.span(Level3)) catch unreachable;
    tmp.Addnum = Addnum;

    return tmp;
}
export fn BookShelfFiles_Free(bookshelf: *BookShelfFiles) void {
    callocator.free(std.mem.span(bookshelf.Level1));
    callocator.free(std.mem.span(bookshelf.Level2));
    callocator.free(std.mem.span(bookshelf.Level3));
    callocator.destroy(bookshelf);
}
export fn BookShelfFiles_Read(bookshelf: *BookShelfFiles) *BookShelfResult {
    const tmp = callocator.create(BookShelfResult) catch unreachable;

    const Level1Path = std.mem.span(bookshelf.Level1);
    if (std.fs.cwd().openFile(Level1Path, .{ .mode = .read_only })) |Level1File| {
        defer Level1File.close();
        var buffer: [16]u8 = undefined;
        if (Level1File.readAll(&buffer)) |bytes_read| {
            if (bytes_read == 0) {
                tmp.Level1 = 0;
            } else {
                const content = std.mem.trim(u8, buffer[0..bytes_read], " \t\n\r");
                if (std.fmt.parseInt(i32, content, 10)) |readint| {
                    tmp.Level1 = @as(c_int, readint - bookshelf.Addnum);
                } else |_| {
                    tmp.Level1 = 0;
                }
            }
        } else |_| {
            tmp.Level1 = 0;
        }
    } else |err| {
        if (err == error.FileNotFound) {
            if (std.fs.cwd().createFile(Level1Path, .{})) |new_file| {
                defer new_file.close();

                var buffer: [20]u8 = undefined;
                if (std.fmt.bufPrint(&buffer, "{d}", .{bookshelf.Addnum})) |str| {
                    if (new_file.writeAll(str)) |_| {
                        tmp.Level1 = 0;
                    } else |_| {
                        tmp.Level1 = 0;
                    }
                } else |_| {
                    tmp.Level1 = 0;
                }
            } else |_| {
                tmp.Level1 = 0;
            }
        }
    }

    const Level2Path = std.mem.span(bookshelf.Level2);
    if (std.fs.cwd().openFile(Level2Path, .{ .mode = .read_only })) |Level2File| {
        defer Level2File.close();
        var buffer: [16]u8 = undefined;
        if (Level2File.readAll(&buffer)) |bytes_read| {
            if (bytes_read == 0) {
                tmp.Level2 = 0;
            } else {
                const content = std.mem.trim(u8, buffer[0..bytes_read], " \t\n\r");
                if (std.fmt.parseInt(i32, content, 10)) |readint| {
                    tmp.Level2 = @as(c_int, readint - bookshelf.Addnum);
                } else |_| {
                    tmp.Level2 = 0;
                }
            }
        } else |_| {
            tmp.Level2 = 0;
        }
    } else |err| {
        if (err == error.FileNotFound) {
            if (std.fs.cwd().createFile(Level2Path, .{})) |new_file| {
                defer new_file.close();

                var buffer: [20]u8 = undefined;
                if (std.fmt.bufPrint(&buffer, "{d}", .{bookshelf.Addnum})) |str| {
                    if (new_file.writeAll(str)) |_| {
                        tmp.Level2 = 0;
                    } else |_| {
                        tmp.Level2 = 0;
                    }
                } else |_| {
                    tmp.Level2 = 0;
                }
            } else |_| {
                tmp.Level2 = 0;
            }
        }
    }

    const Level3Path = std.mem.span(bookshelf.Level3);
    if (std.fs.cwd().openFile(Level3Path, .{ .mode = .read_only })) |Level3File| {
        defer Level3File.close();
        var buffer: [16]u8 = undefined;
        if (Level3File.readAll(&buffer)) |bytes_read| {
            if (bytes_read == 0) {
                tmp.Level3 = 0;
            } else {
                const content = std.mem.trim(u8, buffer[0..bytes_read], " \t\n\r");
                if (std.fmt.parseInt(i32, content, 10)) |readint| {
                    tmp.Level3 = @as(c_int, readint - bookshelf.Addnum);
                } else |_| {
                    tmp.Level3 = 0;
                }
            }
        } else |_| {
            tmp.Level3 = 0;
        }
    } else |err| {
        if (err == error.FileNotFound) {
            if (std.fs.cwd().createFile(Level3Path, .{})) |new_file| {
                defer new_file.close();

                var buffer: [20]u8 = undefined;
                if (std.fmt.bufPrint(&buffer, "{d}", .{bookshelf.Addnum})) |str| {
                    if (new_file.writeAll(str)) |_| {
                        tmp.Level3 = 0;
                    } else |_| {
                        tmp.Level3 = 0;
                    }
                } else |_| {
                    tmp.Level3 = 0;
                }
            } else |_| {
                tmp.Level3 = 0;
            }
        }
    }

    return tmp;
}
export fn BookShelfResult_Free(result: *BookShelfResult) void {
    callocator.destroy(result);
}
export fn BookShelfFiles_WriteLevel1(bookshelf: *BookShelfFiles, number: c_int) c_int {
    const file = bookshelf.Level1;
    const tmp = BookShelfFiles_Read(bookshelf);
    defer BookShelfResult_Free(tmp);
    const result = tmp.Level1;
    if (std.fs.cwd().createFile(std.mem.span(file), .{})) |file1| {
        defer file1.close();
        var buffer: [20]u8 = undefined;
        if (std.fmt.bufPrint(&buffer, "{d}", .{@as(i32, result) + bookshelf.Addnum + number})) |str| {
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
export fn BookShelfFiles_WriteLevel2(bookshelf: *BookShelfFiles, number: c_int) c_int {
    const file = bookshelf.Level2;
    const tmp = BookShelfFiles_Read(bookshelf);
    defer BookShelfResult_Free(tmp);
    const result = tmp.Level2;
    if (std.fs.cwd().createFile(std.mem.span(file), .{})) |file1| {
        defer file1.close();
        var buffer: [20]u8 = undefined;
        if (std.fmt.bufPrint(&buffer, "{d}", .{@as(i32, result) + bookshelf.Addnum + number})) |str| {
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
export fn BookShelfFiles_WriteLevel3(bookshelf: *BookShelfFiles, number: c_int) c_int {
    const file = bookshelf.Level3;
    const tmp = BookShelfFiles_Read(bookshelf);
    defer BookShelfResult_Free(tmp);
    const result = tmp.Level3;
    if (std.fs.cwd().createFile(std.mem.span(file), .{})) |file1| {
        defer file1.close();
        var buffer: [20]u8 = undefined;
        if (std.fmt.bufPrint(&buffer, "{d}", .{@as(i32, result) + bookshelf.Addnum + number})) |str| {
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
