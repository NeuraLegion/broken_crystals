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

  class Category < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema "categories" do # table name
      field :name, String
      has_many :product, Product
    end
  end

  class Product < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema "products" do # table name
      field :name, String
      field :short_description, String
      field :description, String
      belongs_to :category, Category
      has_many :photos, Photo, foreign_key: :product_id
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

  class Testimonial < Crecto::Model
    set_created_at_field nil
    set_updated_at_field nil

    schema "testimonials" do # table name
      field :name, String
      field :title, String
      field :testimonial, String
    end
  end
end
