class PostsController < ApplicationController
  before_action :config_opentok,:except => [:index]
  def index
    @posts = Post.all
    @new_post = Post.new
  end

  def create
  	session = session = @opentok.create_session
  	params[:post][:session_id] = session.session_id
  	@new_post = Post.new post_params
  	# @new_post.session_id = session.session_id

    respond_to do |format|
      if @new_post.save
        format.html { redirect_to("/posts/"+@new_post.id.to_s) }
      else
        format.html { render :controller => 'rooms',
          :action => "index" }
      end
    end
  end

  def show 
    @post = Post.find_by id: params[:id]
    @tok_token = @opentok.generate_token(@post.session_id)
  end
  private
  def config_opentok
    if @opentok.nil?
     @opentok = OpenTok::OpenTok.new("46208892", "43b5177576063e734c9090beba34d31da615afb3")
    end
  end

  def post_params
    params.require(:post).permit(:title,:session_id)
  end
end
