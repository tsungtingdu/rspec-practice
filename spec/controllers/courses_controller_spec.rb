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

  describe 'GET edit' do
    it 'assign course' do
      course = create(:course)
      get :edit, params: {id: course.id}
      expect(assigns[:course]).to eq(course)
    end

    it 'render tempalte' do
      course = create(:course)
      get :edit, params: {id: course.id}
      expect(response).to render_template('edit')
    end
  end

  describe 'PUT update' do
    context 'when there is title' do
      it 'assign @course' do
        course = create(:course)
        put :update, params: {id: course.id, course: {title: 'new title', description: 'new description'}}
        expect(assigns[:course]).to eq(course)
      end

      it 'change value' do
        course = create(:course)
        put :update, params: {id: course.id, course: {title: 'new title', description: 'new description'}}
        expect(assigns[:course].title).to eq('new title')
        expect(assigns[:course].description).to eq('new description')
      end

      it 'redirect_to course_path' do
        course = create(:course)
        put :update, params: {id: course.id, course: {title: 'new title', description: 'new description'}}
        expect(response).to redirect_to course_path(course)
      end
    end
    
    context 'when there is no title' do
      it "doesn't update" do
        course = create(:course)
        put :update, params: {id: course.id, course: {title: '', description: 'new description'}}
        expect(assigns[:course]).not_to eq('new description')
      end

       it "render edit" do
        course = create(:course)
        put :update, params: {id: course.id, course: {title: '', description: 'new description'}}
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'assigns @course' do
      course = create(:course)
      delete :destroy, params: {id: course.id}
      expect(assigns[:course]).to eq(course)
    end

    it 'delete a course' do
      course = create(:course)
       expect do
        delete :destroy, params: {id: course.id}
      end.to change{Course.count}.by(-1)
    end

    it 'redirect to index' do
      course = create(:course)
      delete :destroy, params: {id: course.id}
      expect(response).to redirect_to courses_path
    end
  end
end