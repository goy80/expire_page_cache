namespace :expire_page_cache do
  desc 'delete expired page cache'
  task :delete do
    ExpirePageCache.run
  end
end
