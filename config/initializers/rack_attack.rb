# config/initializers/rack_attack.rb
class Rack::Attack
  Rack::Attack.enabled = ENV['ENABLE_RACK_ATTACK'] || Rails.env.production?

  Rack::Attack.cache.store = Redis.new(host: ENV["REDIS_HOST"], port: ENV["REDIS_PORT"]) if ENV['REDIS_HOST'] && ENV["REDIS_PORT"]

  # Trying to limit by 1 request per minute by ip, change later to more lax throttle
  throttle("req/ip/proxy-tries", limit: 10, period: 1.minute) do |req|
    req.ip if req.path.include?('/categories') && req.get?
  end


  # track hits to "categories" path
  track("categories") do |req|
      req.path.include?('/categories')
  end

  # response when throttled
  self.throttled_responder = ->(env) {
    retry_after = (env['rack.attack.match_data'] || {})[:period]
    [
      429,
      {'Content-Type' => 'application/json', 'Retry-After' => retry_after.to_s},
      [{error: "Throttle limit reached. Retry later."}.to_json]
    ]
  }
  # Track it using ActiveSupport::Notification
  ActiveSupport::Notifications.subscribe("rack.attack") do |_name, _start, _finish, _request_id, payload|
    if false && payload[:request].env['rack.attack.matched'] == :throttle && payload[:request].env['rack.attack.match_type'] == :track
      Rails.logger.info "Categories Endpoint Touched: #{payload.path}"
    end
  end
end