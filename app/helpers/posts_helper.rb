module PostsHelper
  def category_options
    Category.all.where(parent: nil)
  end

  def sub_category_options(category_id)
    Category.find(category_id).categories
  end

  def city_options
    City.all.where(parent: nil)
  end

  def state_city_options(city_id)
    City.find(city_id).cities
  end
end
