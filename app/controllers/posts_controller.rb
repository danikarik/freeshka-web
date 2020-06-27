class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :search]
  before_action :check_permission, only: [:search]

  # GET /posts
  # GET /posts.json
  def index
    set_page_and_extract_portion_from(Post.all, ordered_by: { created_at: :desc,
                                                              id: :desc })

    respond_to do |format|
      format.html
      format.json do
        render json: { entries: render_to_string(@page.records, formats: [:html]),
                       pagination: render_to_string(partial: 'next_link', formats: [:html]) }
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        # create new room
        @room = Room.new(name: @post.title, post_id: @post.id)
        if @room.save
          # create room user
          @room_user = @room.room_users.new(user_id: current_user.id)
          unless @room_user.save
            format.html { render :new, notice: @room_user.errors }
            format.json { render json: @room_user.errors, status: :unprocessable_entity }
          end
        else
          format.html { render :new, notice: @room.errors }
          format.json { render json: @room.errors, status: :unprocessable_entity }
        end

        # response
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

  def delete_attachment
    @attachment = ActiveStorage::Attachment.find(params[:attachment_id])
    @attachment.purge
    redirect_back(fallback_location: @post)
  end

  def search
    if params[:q].blank?
      @members = []
    else
      query = "%#{params[:q]}%"
      @members = User.joins(:room_users).where('(users.email LIKE ? OR users.name LIKE ?) AND room_users.room_id = ? AND users.id <> ?', query, query, @post.room, @post.user)
    end

    render partial: 'search'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content, attachments: [],
                                                   category_ids: [],
                                                   city_ids: [])
  end

  def check_permission
    redirect_back fallback_location: posts_url unless current_user == @post.user
  end
end
