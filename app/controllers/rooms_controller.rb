class RoomsController < ApplicationController

  before_action :config_opentok,:except => [:index]
  def index
    @rooms = Room.where(:public => true)
    @new_room = Room.new
  end
  
  def create
    session = @opentok.create_session
    params[:room][:session_id] = session.session_id

    @new_room = Room.new room_params

    respond_to do |format|
      if @new_room.save
        format.html { redirect_to("/party/"+@new_room.id.to_s) }
      else
        format.html { render :controller => 'rooms',
          :action => "index" }
      end
    end
  end

  def destroy
    @room = Room.find_by id: params[:id]
    @room.destroy
    redirect_to root_path
  end

  def party
    @room = Room.find(params[:id])

    @tok_token = @opentok.generate_token(@room.session_id)
  end

  private
  def config_opentok
    if @opentok.nil?
     @opentok = OpenTok::OpenTok.new("46208892", "43b5177576063e734c9090beba34d31da615afb3")
    end
  end

  def room_params
    params.require(:room).permit(:name, :public, :session_id)
  end
end