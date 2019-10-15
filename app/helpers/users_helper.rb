module UsersHelper
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.user_name, class: "gravatar")
  end

  def user_initial_picture(user, width: 100, height: 100)
    image_tag("user_initial.png", width: "#{width}", height: "#{height}")
  end
end
