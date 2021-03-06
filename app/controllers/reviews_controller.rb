class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_review, only: [:destroy]
    before_action :authorize!, only: [:edit, :update, :destroy]

    def create
        @idea = Idea.find(params[:idea_id])
        @review = Review.new review_params
        @review.idea = @idea
        @review.user = current_user
        if @review.save
            redirect_to @idea, notice: 'Review created'
        else
            @reviews = @idea.reviews.order(created_at: :desc)
            render '/ideas/show'
        end      
    end

    def destroy
        @review.destroy
        redirect_to @review.idea, notice: 'Review Deleted'
    end



    private

    def review_params
        params.require(:review).permit(:rating, :body)
    end

    def find_review
        @review = Review.find params[:id]
    end

    def authorize!
        redirect_to root_path, alert: "access denied" unless can? :crud, @review
    end
    




end
