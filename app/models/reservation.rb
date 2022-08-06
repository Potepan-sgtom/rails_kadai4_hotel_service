class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :guests, numericality: {
      only_integer: true, 
      greater_than: 0, 
      less_than: 100
  }
  validate :start_date_check
  validate :dates_check

  private

    def dates_check
      if !start_date.nil? && !end_date.nil?
        if self.end_date <= self.start_date
          self.errors.add(:base, "チェックアウト予定日はチェックイン以降の日付を選択してください") 
        end
        if self.start_date.since(1.month) < self.end_date
          self.errors.add(:base, "1ヶ月以上の連泊はできません")
        end
        #期間に重複がないか確認
        if (self.id.nil? && self.room.reservations.where(
              'end_date >= ? and start_date <= ?',self.start_date, self.end_date).present?) ||
           (!self.id.nil? && self.room.reservations.where(
               'end_date >= ? and start_date <= ? and id != ?',self.start_date, self.end_date, self.id).present?)
          self.errors.add(:base, "指定された日付は予約済です")
        end
      end
    end
    
    def start_date_check
      if !start_date.nil?
        if self.start_date < Date.today
          self.errors.add(:base, "チェックインは本日以降の日付を選択してください") 
        end
        if Date.today.since(3.month) < self.start_date
          self.errors.add(:base, "チェックインは本日より3ヶ月以内の日付を選択してください") 
        end
      end
    end  
end
