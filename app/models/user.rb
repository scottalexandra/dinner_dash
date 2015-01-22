class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :email,
            format: {
              with: /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
            },
            uniqueness: true
  validates :display_name,
            length: { in: 2..32,
            too_long: "%{count} is the alowed number of characters"
            },
            allow_blank: true

  has_many :orders
end
