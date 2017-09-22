class Admin::User < User
  has_one :client
  has_one :worker
  has_and_belongs_to_many :clients
end
