class PicturesController < ApplicationController

  before_action :ensure_logged_in, except: [:show, :index]
  before_action :load_picture, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user_owns_picture, only: [:edit, :update, :destroy]

  def create
    @picture = Picture.new
    @picture.title = params[:picture][:title]
    @picture.description = params[:picture][:description]
    @picture.url = params[:picture][:url]
    @picture.user = current_user



    if @picture.save
      redirect_to pictures_path
    else
      render :new
    end
  end

  def new
    @picture = Picture.new
  end

  def index
    @pictures = Picture.all
  end

  def show
    @picture = Picture.find(params[:id])
  end

  def edit
    @picture = Picture.find(params[:id])
  end

  def update
    @picture.title = params[:picture][:title]
    @picture.description = params[:picture][:description]
    @picture.url = params[:picture][:url]

    if @picture.save
      redirect_to picture_path(@picture)
    else
      render :edit
    end
  end

  def destroy
    if @picture.destroy
      redirect_to pictures_path
    else
      render :show
    end
  end

  def load_picture
    @picture = Picture.find(params[:id])
  end

  def ensure_user_owns_picture
    unless current_user == @picture.user
      flash[:alert] = "Please log in"
      redirect_to new_session_url
    end
  end



end
