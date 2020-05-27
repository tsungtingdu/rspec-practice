require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET index' do
    before do
      @course1 = create(:course)
      @course2 = create(:course)
      get :index
    end

    it 'assigns @courses' do
      expect(assigns[:courses]).to eq([@course1, @course2])
    end

    it 'render template' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET show' do
    before do
      @course = create(:course)
      get :show, params: {id: @course.id}
    end

    it 'assigns @course' do
      expect(assigns[:course]).to eq(@course)
    end

    it 'render template' do
      expect(response).to render_template('show')
    end
  end
end