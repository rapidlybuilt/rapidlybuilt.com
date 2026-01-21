# Copied from RapidUI v0.1.1
# Source: rapid_ui/docs/app/models/user.rb
module UiDocs
  class User
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :first_name, :string
    attribute :last_name, :string
    attribute :email, :string
    attribute :user_type, :string
    attribute :country, :string
    attribute :id, :integer

    # Make it behave like a persisted record
    def persisted?
      id.present?
    end

    # Needed for form routing
    def to_key
      persisted? ? [ id ] : nil
    end

    def to_param
      id&.to_s
    end
  end
end
