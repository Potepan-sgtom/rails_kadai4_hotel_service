class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :hotel
  validates :hotel_id, presence: true
  validates :checkin, presence: true
  validates :checkout, presence: true
  validates :total_fee, presence: true
  validates :member, numericality: {
      only_integer: true, 
      greater_than: 0, 
      less_than: 100
  }
  validate :checkin_check
  validate :dates_check

  private

    def dates_check
      if !checkin.nil? && !checkout.nil?
        if self.checkout <= self.checkin
          self.errors.add(:base, "チェックアウト予定日はチェックイン以降の日付を選択してください") 
        end
        if self.checkin.since(1.month) < self.checkout
          self.errors.add(:base, "1ヶ月以上の連泊はできません")
        end
        #期間に重複がないか確認
        if (self.id.nil? && self.hotel.reservations.where(
              'checkout >= ? and checkin <= ?',self.checkin, self.checkout).present?) ||
           (!self.id.nil? && self.hotel.reservations.where(
               'checkout >= ? and checkin <= ? and id != ?',self.checkin, self.checkout, self.id).present?)
          self.errors.add(:base, "指定された日付は予約済です")
        end
      end
    end
    
    def checkin_check
      if !checkin.nil?
        if self.checkin < Date.today
          self.errors.add(:base, "チェックインは本日以降の日付を選択してください") 
        end
        if Date.today.since(3.month) < self.checkin
          self.errors.add(:base, "チェックインは本日より3ヶ月以内の日付を選択してください") 
        end
      end
    end  
end
