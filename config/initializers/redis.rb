# # use provided URL or default to localhost
# redis_uri = URI.parse(ENV['REDISTOGO_URL'] ||= 'http://localhost:6379')
# # set up a connection to Redis for manual caching
# REDIS = Redis.new(:host => redis_uri.host, :port => redis_uri.port, :password => redis_uri.password)

$redis = Redis.new