class NewsItem
  include DataMapper::Resource
  
  property :id, Serial
  property :updated_at, DateTime, :default => 'NOW()'
  property :message, String
end
