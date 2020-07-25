# frozen_string_literal: true

class Admin::TestsController < Admin::BaseController

  before_action :find_tests, only: %i[index update_inline ]
  before_action :find_test, only: %i[show start edit update destroy update_inline]
  before_action :set_user, only: :start

  def index; end

  def edit; end

  def new
    @test = Test.new
  end

  def create
    @test = current_user.created_tests.new(test_params)
    if @test.save
      redirect_to admin_tests_path
    else
      render :new
    end
  end

  def destroy # Удаление вопроса
    @test.destroy
    redirect_to admin_tests_path
  end

  def update
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :edit
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  private

  def test_params
    params.require(:test).permit(:title, :difficulty, :category_id, :user_id, :timer)
  end

  def find_tests
    @tests = Test.all
  end

  def find_test
    @test = Test.find(params[:id])
  end

end
