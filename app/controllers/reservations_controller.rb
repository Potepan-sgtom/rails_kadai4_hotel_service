class ReservationsController < ApplicationController
  def index
    @reservations = current_user.reservations
  end
  
  def new
  end
  
  def show
    @reservation = Reservation.find_by(id: params[:id])
  end
  
  def create
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.total_fee = calc_total_fee(@reservation)
    if @reservation.save
      flash[:success] = "ルームの予約が完了しました"
      redirect_to @reservation
    else
      @hotel = Hotel.find(@reservation.hotel_id)
      render 'rooms/show'
    end
  end
   
  def edit
    @reservation = Reservation.find_by(id: params[:id])
  end
  
  def update
    @reservation = Reservation.find_by(id: params[:id])
    @reservation.total_fee = calc_total_fee(@reservation)
    if @reservation.update(reservation_params)
      flash[:success] = "予約情報を更新しました"
      redirect_to @reservation
    else
      render 'edit'
    end
  end
  
  def destroy
    @reservation = Reservation.find(params[:id])
    #binding.pry
    @reservation.delete
    @reservations = current_user.reservations
    flash[:info] = "予約をキャンセルしました"
    redirect_to reservations_path
  end
  
    private

    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :guests, :total_fee, :room_id)
    end
    
    #宿泊費用を計算
    def calc_total_fee(reservation)
      if reservation.start_date.present? && reservation.end_date.present?
        price = Hotel.find(reservation.hotel_id).price
        term = (reservation.end_date - reservation.start_date).to_i
        guests = reservation.guests.to_i
        price * term * guests
      end
    end
  
end
