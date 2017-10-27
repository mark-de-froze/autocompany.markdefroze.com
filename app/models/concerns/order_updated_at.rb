module OrderUpdatedAt
  extend ActiveSupport::Concern

  included do
    default_scope { order(updated_at: :desc) }
  end
end

