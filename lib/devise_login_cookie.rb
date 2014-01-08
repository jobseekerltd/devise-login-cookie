require "devise_login_cookie/cookie"
require "devise_login_cookie/strategy"

Warden::Strategies.add(:devise_login_cookie, DeviseLoginCookie::Strategy)

Warden::Manager.after_authentication do |user, warden, options|
  DeviseLoginCookie::Cookie.new(warden.cookies, options[:scope]).set(user)
end

Warden::Manager.before_logout do |user, warden, options|
  DeviseLoginCookie::Cookie.new(warden.cookies, options[:scope]).unset
end

Warden::Manager.after_fetch do |record, warden, options|
  scope = options[:scope]
  cookie_name = DeviseLoginCookie::Cookie.cookie_name(scope)
  if warden.authenticated? && warden.cookies[cookie_name].blank?
    warden.logout(scope) 
    throw :warden, :scope => scope, :message => :unauthenticated
  end
end

