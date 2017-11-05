#$uid = Array.new
require 'json'
require 'nokogiri'

class CreateMessageController < ApplicationController
    protect_from_forgery with: :null_session
    
    MIN_RND = 1000
    MAX_RND = 9999
        
    def index
    end
    
    def create
        
        cur_uid = get_free_uid.to_s
        text = params[:text]
        puts text
        Database.create(:uid => cur_uid, :text => text) 
        #redirect_back(fallback_location: "create_message")
        url =  "https://private-note.herokuapp.com/create_message/#{cur_uid}"
        render plain: url
    end
    
    def read
        id = params[:id]
        data_rec = Database.find_by uid: id.to_s 
        if data_rec.class == NilClass
            render_404
            #render :status => 404
            #raise ActionController::RoutingError.new('Not Found') 
            #$read_text = "DUM FUK"
        else
            $read_text = data_rec.send(:text)
            read_id = data_rec.send(:id)
            Database.destroy(read_id.to_i)
        end
        #Database.destroy(id)

        #if $read_text.equals?(nil)
            
    end

    def api
        
        if request.headers["Content-Type"] == 'application/json'
            text = params[:message].to_s
        elsif request.headers["Content-Type"] == 'text/xml'
            text = Nokogiri::XML.fragment(request.body.read).content.to_s
        end

        p text
        
        cur_uid = get_free_uid.to_s
        Database.create(:uid => cur_uid, :text => text) 
        
        url =  "https://private-note.herokuapp.com/create_message/#{cur_uid}"       
        
        response = {"url" => url}
       
        if request.headers["Content-Type"] == 'application/json'
            render json: response
        elsif request.headers["Content-Type"] == 'text/xml'
            render xml: response
        end
    end

    def render_404
      respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
      end
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
