class Role < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => :users_roles

  belongs_to :resource,
             :polymorphic => true,
             :optional => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  validates :name, presence: true

  def to_label
    if resource_id
      resource_label = resource.to_label
    else
      resource_label = resource_type
    end

    "#{name.humanize} #{resource_label}"
  end

  scopify
end
