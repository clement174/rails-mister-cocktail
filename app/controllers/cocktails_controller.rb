class CocktailsController < ApplicationController
  def index
    if params[:name].nil?
      @cocktails = Cocktail.eager_load(doses: :ingredient).all
      # eager_load permet de pre load les ingredients et donc de ne faire qu'une
      # seule grosse requete dans la vue.
    else
      @cocktails = Cocktail.where('LOWER(cocktails.name) LIKE ?', "%#{params[:name]}%")
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @dose = Dose.new
    @review = Review.new
    @ingredients = Ingredient.all
  end

  def new
    @cocktail = Cocktail.new
    @ingredients = Ingredient.all
    @doses = Dose.all
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name)
  end
end
