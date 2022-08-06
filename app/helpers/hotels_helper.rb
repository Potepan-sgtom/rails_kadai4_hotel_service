module HotelsHelper
    
def owner?(room)
    logged_in? && current_user.rooms.include?(room)
end
end
