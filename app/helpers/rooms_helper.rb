module RoomsHelper
  def current_user_room_owner(room)
    room.post.user_id == current_user.id
  end

  def current_user_room_member(room)
    room.room_users.exists?(user_id: current_user.id)
  end
end
