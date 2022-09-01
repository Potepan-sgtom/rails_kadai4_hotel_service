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
    #puts 1234
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.total_fee = calc_total_fee(@reservation)
    #puts @reservation.total_fee
    if @reservation.save
      flash[:success] = "部屋の予約が完了しました"
      redirect_to @reservation
    else
      @hotel = Hotel.find(@reservation.hotel_id)
      render 'hotels/show'
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
      params.require(:reservation).permit(:checkin, :checkout, :member, :total_fee, :hotel_id)
    end
    
    #宿泊費用を計算
    
    def calc_total_fee(reservation)
      if reservation.checkin.present? && reservation.checkout.present?
        price = Hotel.find(reservation.hotel_id).price
        #三回目提出時変更箇所↓(1日の秒数が合計金額に算出されたため、.to_iから÷86400でtermを日数表示に置き換え)
        term = (reservation.checkout - reservation.checkin)/86400
        #三回目提出時変更箇所↑
        
        #下のputsはエラー確認用
        #puts reservation.checkin
        #puts reservation.checkout
        #puts (reservation.checkout - reservation.checkin)
        member = reservation.member.to_i
        #puts price
        #puts term
        #puts member
        #puts 9900
        price * term * member
      end
    end
    
    
    
  
end
