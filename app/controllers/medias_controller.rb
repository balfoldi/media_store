class MediasController < ApplicationController
  layout "index", only: [:index]
  before_action :authenticate_admin, only: [:create, :new]

  def index

    @medias = Media.all

  end

  def show
    @media = Media.find(params[:id])
  end

  def new
    @media = Media.new
  end

  def create
    @media = Media.new(post_params)

    puts @media

    puts "%"*30
    @media.picture.attach(params[:picture])
    puts "%"*30

    puts  @media.picture.attached?

    if @media.picture.attached?
      if @media.save
        flash[:success] = "Media créé"
        redirect_to medias_path
      else
        flash[:error] = @media.errors
        redirect_to new_media
      end
    else
      flash[:error] = "media have no file"
      redirect_to new_media_path
    end

    puts flash[:dan]
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def authenticate_admin
    unless current_user
      flash[:danger] = "Reservé aux administrateurs."
      redirect_to new_session_path
    end
  end

  private

  def post_params
    post_params = params.require(:media).permit(:title, :description, :price, :picture)
  end

end
