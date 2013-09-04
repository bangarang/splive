uri = URI.parse("redis://redistogo:6bbd03d7ffa787087172602eebc92f7a@koi.redistogo.com:9851")
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)