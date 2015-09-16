module SoftDelete
  extend ActiveSupport::Concern

  included do
    field :deleted_at, type: DateTime
    default_scope ->{ where(deleted_at: nil) }

    def soft_destroy
      Rails::logger.info("-----------delfg--------#{self.inspect}")
      self.update_attributes(deleted_at: Time.now)
    end

  end
end