class LikesController < ApplicationController

  before_action :authenticate_user!

  def create
    review = Review.find params[:review_id]
    like = Like.new user: current_user, review: review
    if !can?(:like, review)
      redirect_to review.idea, alert: "can't like review"
    elsif like.save
      redirect_to review.idea, notice: 'Liked'
    else
      redirect_to review.idea, alert: 'Not Liked'
    end
  end

  def destroy
    like = Like.find params[:id]
    if can? :destroy, like
      like.destroy
      redirect_to like.review.idea, notice: 'Like removed'
    else
      redirect_to like.review.idea, alert: "can't delete like"
    end
  end



end
