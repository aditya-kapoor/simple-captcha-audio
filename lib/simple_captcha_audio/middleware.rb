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

      def refresh_code(env)
        request = Rack::Request.new(env)

        request.session.delete :captcha
        key = simple_captcha_key(nil, request)
        options = {}
        options[:field_value] = set_simple_captcha_data(key, options)
        url = simple_captcha_image_url(key, options)

        status = 200
        id = request.params['id']
        captcha_hidden_field_id = simple_captch_hidden_field_id(id)

        audio_id = generate_audio_id(id)
        audio_url = simple_captcha_audio_url(key, options)

        body = %Q{
                    $("##{id}").attr('src', '#{url}');
                    $("##{audio_id}").attr('src', '#{audio_url}')
                    $("##{ captcha_hidden_field_id }").attr('value', '#{key}');
                  }
        headers = {'Content-Type' => 'text/javascript; charset=utf-8', "Content-Disposition" => "inline; filename='captcha.js'", "Content-Length" => body.length.to_s}.merge(SimpleCaptcha.extra_response_headers)
        [status, headers, [body]]
      end

      def generate_audio_id(id)
        id.gsub('simple_captcha', simple_captcha_id_prefix)
      end
  end
end
