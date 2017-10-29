#$uid = Array.new

class CreateMessageController < ApplicationController
    MIN_RND = 1000
    MAX_RND = 9999
    
    def index
    end
    
    def create
        
        $cur_uid = get_free_uid.to_s
        text = params[:text]
        puts text
        Database.create(:uid => $cur_uid, :text => text) 
        #redirect_back(fallback_location: "create_message")
        render plain: "https://private-note.herokuapp.com/read_message/#{$cur_uid}"
    end

    def get_free_uid
        loop do
            new_uid = rand(MIN_RND..MAX_RND)
            #unless $uid.include?(new_uid)
            if (Database.find_by uid: new_uid) == nil
                #$uid << new_uid
                return new_uid
                break
            end
        end
    end
end
