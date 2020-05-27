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

  describe 'GET new' do
    it 'assigns @course' do
      course = build(:course)
      get :new
      expect(assigns[:course]).to be_a_new(Course)
    end
  end

  describe 'POST create' do
    it 'create a new course record' do
      course = build(:course)
      expect do
        post :create, params: { course: {:title => 'name', :description => 'description'}}
        # post :create, params: { :course => attributes_for(:course) }
      end.to change{Course.count}.by(1)
    end

    it 'redirect to index when success' do
      course = build(:course)
      post :create, params: { course: {:title => 'name', :description => 'description'}}
      expect(response).to redirect_to courses_path
    end

    it 'render new when fail' do
      course = build(:course)
      post :create, params: { course: { :description => 'description'}}
      expect(response).to render_template('new')
    end
  end
end