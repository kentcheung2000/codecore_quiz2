require 'rails_helper'

RSpec.describe Idea, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  def idea
    @idea ||= Idea.new(
      title: 'First New Idea',
      description: 'This is just the best idea.'
    )
  end


  describe 'validations' do

    it "has a title" do
      n = idea
      n.title = nil
      n.valid?
      expect(n.errors).to have_key(:title)
    end

   
  end
end
