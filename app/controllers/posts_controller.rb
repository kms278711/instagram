class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
  before_action :authenticate_user!
  # before_action :check_user, only: [:edit, :update, :destroy]
  load_and_authorize_resource
  
  # GET /posts
  # GET /posts.json
  def index
    if params.has_key?(:content)
      @posts = Post.where('content like ?', "%#{params[:content]}%")
    else
      @posts = Post.where(user_id: current_user.followees.ids.push(current_user.id))
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)
    # @post.user _id = current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def mypage
    @posts = current_user.posts
  end
  
  # POST posts/:id/like
  def like
    @post.toggle_like(current_user)
    redirect_back(fallback_location: root_path)
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:image, :content)
    end
    
    # def check_user
    #   redirect_to root_path, notice: '권한이 없습니다.' and return unless @post.user == current_user
    # end
end
