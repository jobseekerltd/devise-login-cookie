#require "active_support/core_ext/hash/slice"

module DeviseLoginCookie

  class Cookie

    # for non-Rails test environment.
    attr_writer :session_options

    def initialize(cookies, scope)
      @cookies = cookies
      @scope = scope
    end

    # Sets the cookie, referencing the given resource.id (e.g. User)
    def set(resource)
      @cookies.signed[cookie_name] = {value: [resource.id, Time.now.to_i]}.merge(cookie_options)
    end

    # Unsets the cookie via the HTTP response.
    def unset
      @cookies.delete cookie_name, cookie_options
    end

    # The id of the resource (e.g. User) referenced in the cookie.
    def id
      value[0]
    end

    # The Time at which the cookie was created.
    def created_at
      valid? ? Time.at(value[1]) : nil
    end

    # Whether the cookie appears valid.
    def valid?
      value
    end

    # Whether the cookie was set since the given Time
    def set_since?(time)
      created_at && created_at >= time
    end

    def self.cookie_name(scope)
      :"#{scope}_token"
    end

  private

    def value
      @cookies.signed[cookie_name]
    end

    def cookie_name
      self.class.cookie_name(@scope)
    end


    def cookie_options
      @session_options ||= Rails.configuration.session_options
      @session_options.slice(:path, :domain, :secure, :httponly)
    end


  end

end
