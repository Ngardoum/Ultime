class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.order(published_at: :desc)
  end

  # Dans ton contrôleur
  def show
    @restaurant = Restaurant.find(params[:id]) # Assure-toi de récupérer le bon restaurant
    @post = Post.first # Ou un autre moyen pour récupérer un article spécifique
  end


  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.published_at = Time.current

    if @post.save
      redirect_to @post, notice: 'Article publié avec succès.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end

