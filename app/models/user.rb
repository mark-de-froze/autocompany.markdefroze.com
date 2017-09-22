class User < ApplicationRecord
  resourcify

  rolify

  has_and_belongs_to_many :clients
  has_many :worker

  scope :except_id, ->(id) { where('id != ?', id) }

  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable
  #, :recoverable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  def to_label
    "#{email}"
  end
end
