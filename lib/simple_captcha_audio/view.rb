module SimpleCaptcha
  module ViewHelper
    # TODO: Devise some way to use super here..
    alias_method :__simple_captcha_options__, :simple_captcha_options

    def simple_captcha_options(options = {})
      super_options = __simple_captcha_options__(options)

      key = super_options[:field_value]

      super_options.merge({
        audio: simple_captcha_audio(key, options)
      })
    end

    private
      def simple_captcha_audio(simple_captcha_key, options = {})
        url = simple_captcha_audio_url simple_captcha_key, options: options
        id  = simple_captcha_audio_id(options)
        tag('audio', :src => url, :id => id, controls: true)
      end

      def simple_captcha_audio_url(simple_captcha_key, options = {})
        defaults = {}
        defaults[:time] = options[:time] || Time.now.to_i

        query = defaults.to_query
        path = "/simple_captcha?code=#{simple_captcha_key}&#{query}&audio=true"
        build_url(options, path)
      end

      def simple_captcha_audio_id(options={})
        "#{ simple_captcha_id_prefix }-#{options[:field_value][0..10]}"
      end

      def simple_captcha_id_prefix
        "simple_captcha-audio"
      end
  end
end
