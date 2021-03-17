class User < ApplicationRecord
  has_many :articles

  before_save {self.useremail=useremail.downcase}

  validates :username, presence: true,
            uniqueness: {case_sensitive: false},
            length: {minimum: 3}
  VALID_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :useremail, presence: true,
            uniqueness: {case_sensitive: false},
            format: {with: VALID_REGEX}
end
