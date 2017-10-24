class MailList < ApplicationRecord
  belongs_to :login, foreign_key: :logins_id

  scope :by_user, ->(user, order) {
    where(logins_id: Login.where(user: user)).order( order.blank? ? "id asc" : "#{order.downcase} desc")
  }
end
