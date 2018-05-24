module ApplicationHelper
  
  def gravatar_for(user, options = {size: 80})
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase) # Get this from: google - "gravatar digest" / Ruby Image requests / # create the md5 hash
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.chefname, class: "img-rounded" )
  end
  
end
