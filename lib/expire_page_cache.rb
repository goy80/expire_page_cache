require "expire_page_cache/version"

module ExpirePageCache
  def self.run
    cache_dir = Rails.root.join('public','cache')
    %w(pc sp).each do | device |
      Dir.glob("#{cache_dir}/#{device}/**/*").each do | path |
        stat = File::Stat.new(path)
        if(stat.file? &&  stat.mtime < DateTime.now - 1.day)
          File.delete(path)
          puts "[expire_page_cache] #{path} elapsed 24hour. remove it."
        end
      end
    end
  end

  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'tasks/expire_page_cache.rake'
    end
  end
end
