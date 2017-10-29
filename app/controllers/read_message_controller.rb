class ReadMessageController < ApplicationController
    def index
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

    def render_404
      respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
      end
   end
end
