module SimpleCaptcha
  class Middleware
    include SimpleCaptcha::AudioHelpers

    def call(env) # :nodoc:
      if env["REQUEST_METHOD"] == "GET" && captcha_path?(env['PATH_INFO'])
        request = Rack::Request.new(env)
        if request.params.present? && request.params['code'].present?
          if request.params['audio'] && request.params['audio'].eql?('true')
            make_audio(env)
          else
            make_image(env)
          end
        else
          refresh_code(env)
        end
      else
        @app.call(env)
      end
    end

    protected
      def make_audio(env)
        request = Rack::Request.new(env)
        code = request.params["code"]
        body = []

        if Utils::simple_captcha_value(code)
          #status, headers, body = @app.call(env)
          #status = 200
          #body = generate_simple_captcha_audio(code)
          #headers['Content-Type'] = 'audio/mpeg3'
          send_data(generate_simple_captcha_audio(code), type: 'audio/mpeg3', disposition: 'inline', filename: 'simple_captcha_audio.mp3', stream: 'true', buffer_size: '4096')
        else
          [status, headers, body]
        end
      end
  end
end
