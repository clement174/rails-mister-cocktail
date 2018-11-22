class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
    @ingredients = Ingredient.all
  end

  def create
    @dose = Dose.new(dose_params)

    if params[:dose][:ingredient_id] == ""
      ingredient = Ingredient.new
    elsif params[:ingredient_id].nil?
      ingredient = Ingredient.find(params[:dose][:ingredient_id])
    else
      ingredient = Ingredient.find(params[:ingredient_id])
    end

    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose.ingredient = ingredient
    @dose.cocktail = @cocktail

    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      @ingredients = Ingredient
      render :new
    end
  end

  def destroy
    dose = Dose.find(params[:id])
    dose.destroy

    redirect_to cocktail_path(dose.cocktail_id)
  end

  private

  def dose_params
    params.require(:dose).permit(:description)
  end
end
