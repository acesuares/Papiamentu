# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://bankodipalabra.com"

SitemapGenerator.verbose = true
#SitemapGenerator::Sitemap.sitemaps_path = 'shared/'

SitemapGenerator::Sitemap.create do
  add "/founa"
  add "/flora"
  add "/musiká"
  add "/konstrukshon"

  Word.find_each do |word|
    images = word
    if word.has_pictures?
      image = word.pictures.first
      add "palabra/#{word.name}", :lastmod => word.updated_at, :priority => 0.3, :changefreq => 'weekly', :images => [{
      :loc => "https://bankodipalabra.com#{image.image_url}",
      :title => word.name }]
    else
      add "palabra/#{word.name}", :lastmod => word.updated_at, :priority => 0.3, :changefreq => 'monthly'
    end
  end
end
