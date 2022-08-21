class HotelsController < ApplicationController

  def index
    if params[:name].present? || params[:area].present?
      @hotels = Hotel.where('name like?', "%#{params[:name]}%").where('area like?', "%#{params[:area]}%").order(updated_at: "ASC")
      @keyword = params[:name]
      @area = params[:area]
    else
      @hotels = Hotel.all.order(updated_at: "ASC")
    end
  end
  
  def create
    @hotel = current_user.hotels.build(hotel_params)
    if @hotel.save
      flash[:success] = "宿泊先登録が完了しました"
      redirect_to @hotel
    else
      render 'new'
    end
  end
  
  def edit
    @hotel = Hotel.find_by(params[:id])  
  end 
  
  def update
    @hotel = Hotel.find_by(params[:id])
    if @hotel.update(hotel_params)
      flash[:success] = "ユーザー情報を更新しました"
      redirect_to @hotel
    else
      render 'edit'
    end
  end
  
  def destroy
    @hotel = Hotel.find_by(params[:id])
    hotel.delete
    flash[:info] = "宿泊先情報を削除しました"
    redirect_to current_user
  end
  
  def show
    @hotel = Hotel.find(params[:id])
    @reservation = Reservation.new
  end
  
  def new
    @hotel = Hotel.new
  end  
  
  private
    
    def hotel_params
      params.require(:hotel).permit(:name, :introduction, :area, :price, :image)
    end
    
  protect_from_forgery  
end
