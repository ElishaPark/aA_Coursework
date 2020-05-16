class CatsController < ApplicationController

  def index
    @cats = Cat.all 
    render :index 
  end

  def show 
    @cat = Cat.find(params[:id])
    render :show 
  end

  def new
    @cat = Cat.new
    render :new 
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      debugger
      render :new 
    end
  end




  private

  def cat_params
    params.require(:cat).permit(:name, :color, :sex, :birth_date, :description)
  end
end
