const std = @import("std");

const ParticipantError = error{RoleAlreadyAssigned};

const Role = enum { Driver, Navigator, Observer };

const Participant = struct {
    name: []const u8,
    currentRole: Role,
    fn update(self: *Participant, role: Role) ParticipantError!void {
        if (self.role == role) {
            return ParticipantError.RoleAlreadyAssigned;
        }
        self.currentRole = role;
    }
};

pub fn main() !void {
    var participants = std.ArrayList(Participant).init(std.heap.page_allocator);
    defer participants.deinit();

    try participants.append(Participant{ .currentRole = Role.Driver, .name = "Jesper" });

    for (participants.items) |participant| {
        std.debug.print("participant: {s}", .{participant.name});
    }
}
