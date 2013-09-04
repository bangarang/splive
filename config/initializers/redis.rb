if Rails.env.development?
	$redis = Redis.new
elsif Rails.env.production?
	# use provided URL or default to localhost
	redis_uri = URI.parse(ENV['REDISTOGO_URL']
	# set up a connection to Redis for manual caching
	REDIS = Redis.new(:host => redis_uri.host, :port => redis_uri.port, :password => redis_uri.password)
	$redis = REDIS
end