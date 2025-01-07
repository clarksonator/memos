class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :rememberable, :registerable
  has_many :memos, -> { order(created_at: :desc) }

  def email_required?
    false
  end

  ## for ActiveRecord 5.1+
  def will_save_change_to_email?
    false
  end
end
