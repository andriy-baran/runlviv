# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://runlviv.otaman.co"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  add runs_path, :priority => 1, :changefreq => 'daily'
  add challenges_path, :priority => 1, :changefreq => 'weekly'
  #
  # Add all articles:
  #
  Run.find_each do |run|
    add run_path(run), :lastmod => run.updated_at
  end
  User.find_each do |user|
    add profile_user_path(user), :lastmod => user.updated_at
  end
end
