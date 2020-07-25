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

  def post_time(post)
    if post.created_at > (Time.zone.today - 1)
      post.created_at.strftime('%H:%M')
    else
      post.created_at.strftime('%b %d')
    end
  end

  def post_avatar(post)
    if post.user.avatar.attached?
      image_tag post.user.avatar.variant(resize: '48x48!'),
                class: 'rounded-full'
    else
      render partial: 'user/avatar', locals: { user: post.user }
    end
  end

  def post_user_initials(user)
    initials = user.username.upcase.split
    if initials.length >= 2
      "#{initials[0][0]}#{initials[1][0]}"
    else
      initials[0][0]
    end
  end
end
