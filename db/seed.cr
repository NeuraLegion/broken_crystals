require "./repo"
require "../src/models"

Query = Crecto::Repo::Query.new

CATEGORY_NAMES = {"Healing", "Jewellery", "Gemstones"}

category = Models::Category.new

CATEGORY_NAMES.each do |name|
  category.name = name
  Repo.insert(category)
end

CATEGORIES = {
  healing:   Repo.get_by(Models::Category, name: "Healing"),
  jewellery: Repo.get_by(Models::Category, name: "Jewellery"),
  gemstones: Repo.get_by(Models::Category, name: "Gemstones"),
}

PRODUCTS = {
  {
    name:              "Amethyst",
    short_description: "Purple Quartz",
    description:       "",
    category:          :gemstones,
    images:            {
      "img/crystals/amethyst.jpg",
    },
  },
  {
    name:              "Ruby",
    short_description: "Intense Heart Crystal",
    description:       "",
    category:          :gemstones,
    images:            {
      "img/crystals/ruby.jpg",
    },
  },
  {
    name:              "Opal",
    short_description: "The Precious Stone",
    description:       "",
    category:          :healing,
    images:            {
      "img/crystals/opal.jpg",
    },
  },
  {
    name:              "Sapphire",
    short_description: "The Virgo",
    description:       "",
    category:          :jewellery,
    images:            {
      "img/crystals/sapphire.jpg",
    },
  },
  {
    name:              "Pyrite",
    short_description: "Fools Gold",
    description:       "",
    category:          :gemstones,
    images:            {
      "img/crystals/pyrite.jpg",
    },
  },
  {
    name:              "Amber",
    short_description: "Fossilized Tree Resin",
    description:       "",
    category:          :jewellery,
    images:            {
      "img/crystals/amber.jpg",
    },
  },
  {
    name:              "Emerald",
    short_description: "Symbol of Fertility and Life",
    description:       "",
    category:          :healing,
    images:            {
      "img/crystals/emerald.jpg",
    },
  },
  {
    name:              "Shattuckite",
    short_description: "Mystery",
    description:       "",
    category:          :healing,
    images:            {
      "img/crystals/shattuckite.jpg",
    },
  },
  {
    name:              "Bismuth",
    short_description: "Rainbow",
    description:       "",
    category:          :jewellery,
    images:            {
      "img/crystals/bismuth.jpg",
    },
  },
}

product = Models::Product.new

PRODUCTS.each do |entry|
  product.name = entry[:name]
  product.short_description = entry[:short_description]
  product.description = entry[:description]
  product.category = CATEGORIES[entry[:category]]
  changeset = Repo.insert(product)

  photo = Models::Photo.new

  entry[:images].each do |url|
    photo.url = url
    photo.product = changeset.instance
    Repo.insert(photo)
  end
end
