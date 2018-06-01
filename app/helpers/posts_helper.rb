module PostsHelper
  def like_button post, user
    if @post.like_users.include?(current_user)
      link_to 'Unlike', like_post_path, method: :post
    else
      link_to 'Like', like_post_path, method: :post
    end
  end
end
