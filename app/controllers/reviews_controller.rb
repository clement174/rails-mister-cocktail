class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @cocktail = Cocktail.find(params[:cocktail_id])

    @review.cocktail = @cocktail
    @review.save
    redirect_to cocktail_path(@cocktail)
  end

  def edit
    @review = Review.find(params[:id])
    @cocktail = Cocktail.find(params[:cocktail_id])

    redirect_to cocktail_path(@cocktail)
  end

  def update

  end

  def destroy
    review = Review.find(params[:id])
    review.destroy

    redirect_to cocktail_path(review.cocktail_id)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
