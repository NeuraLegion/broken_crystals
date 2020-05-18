require "crecto"

module Models
  class User < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema "users" do # table name
      field :username, String
      field :password, String
      field :email, String
    end

    validate_required [:email]
  end

  class Comment < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema "comments" do # table name
      field :name, String
      field :content, String
    end
  end

  class Product < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    enum Category
      Healing
      Jewellery
      Gemstones
    end

    schema "products" do # table name
      field :name, String
      field :short_description, String
      field :description, String
      enum_field :category, Category
    end
  end

  class Photo < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema "photos" do # table name
      field :url, String
      belongs_to :product, Product
    end
  end
end
