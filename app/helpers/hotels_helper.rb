module HotelsHelper
    
def owner?(hotel)
    logged_in? && current_user.hotels.include?(hotel)
end
end
