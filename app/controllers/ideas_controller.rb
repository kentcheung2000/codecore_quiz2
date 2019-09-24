class IdeasController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]
    before_action :find_idea, only: [:show, :edit, :update, :destroy]
    before_action :authorize!, only: [:edit, :update, :destroy]

    def new
        @idea = Idea.new
    end

    def create
        idea_params = params.require(:idea).permit(:title, :description)
        @idea = Idea.new idea_params
       
        @idea.user = current_user
        if @idea.save
            flash[:notice] = 'New Idea created!'
            redirect_to idea_path(@idea)
        else
            render :new
        end
    end

    def show
        @review = Review.new
        @reviews = @idea.reviews.order(created_at: :desc)
        @idea = Idea.find params[:id]
    end

    def index
        @ideas = Idea.all
    end

    def edit
        @idea = Idea.find params[:id]
        #@idea = Idea.find params[:id]
    end

    def update
        flash[:notice] = "Idea updated"
        idea_params = params.require(:idea).permit(:title, :description)
        @idea = Idea.find params[:id]
        if @idea.update idea_params
            redirect_to idea_path(@idea)
        else
            render :edit
        end
    end

    def destroy
        flash[:notice] = "Idea deleted"
        idea = Idea.find params[:id]
        idea.destroy
        redirect_to ideas_path
    end

    private

    def find_idea
        @idea = Idea.find params[:id]
    end

    def idea_params
        params.require(:idea).permit(:title, :description)
    end

    def authorize!
        redirect_to root_path, alert: "access denied" unless can? :crud, @idea
    end

end
