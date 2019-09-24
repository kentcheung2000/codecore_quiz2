require 'rails_helper'

RSpec.describe IdeasController, type: :controller do

    let(:current_user) { FactoryBot.create :user }
    let(:unauthorized_user) { FactoryBot.create :user }

    describe '#new' do
    context 'without user signed in' do
      it "redirects to the sign in page" do
        get(:new)
        expect(response).to redirect_to(new_session_path)
      end

      it "sets an alert flash" do
        get(:new)

        expect(flash[:alert]).to be
      end
    end
    context 'with user signed in' do
      before do
        session[:user_id] = current_user.id
      end

      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end
 
      it 'sets an instance variable with a new news article' do
        get :new
        expect(assigns(:idea)).to be_a_new(Idea)
      end
    end
   end


   describe '#create' do
    context 'with no user signed in' do
      it 'redirects to the sign in page' do
        post :create, params: { idea: FactoryBot.attributes_for(:idea) }
        expect(response).to redirect_to new_session_path
      end
    end
    
    context 'with user signed in do' do
      before do
        session[:user_id] = current_user.id
      end

      context 'with valid parameters' do
        def valid_request
          post :create, params: {
            idea: FactoryBot.attributes_for(:idea)
          }
        end
 
        it 'create a idea in the db' do
          count_before = Idea.count
          valid_request
          count_after = Idea.count       
          expect(count_after).to eq(count_before + 1)
        end
 
        it 'redirects to the show page of that idea' do
          valid_request
          expect(response).to redirect_to(idea_path(Idea.last))
        end
 
        it 'sets a flash message' do
          valid_request
          expect(flash[:notice]).to be
        end
    end
 
      context 'with invalid parameters' do
        def invalid_request
          post :create, params: {
            idea: FactoryBot.attributes_for(:idea, title: nil)
          }
        end
 
        it "doesn't create a news idea in the database" do
          count_before = Idea.count
          invalid_request
          count_after = Idea.count
          expect(count_after).to eq(count_before)
        end
 
        it "renders the new template" do
          invalid_request
          expect(response).to render_template(:new)
        end
      end
     end
   end



end
