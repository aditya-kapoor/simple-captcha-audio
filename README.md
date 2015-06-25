# SimpleCaptchaAudio

Simple audio support for the `simple_captcha`.

## Installation

Add this line to your application's Gemfile:

```ruby
  gem 'simple_captcha_audio'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_captcha_audio

## Usage

The extension adds another parameter to the image generation URL to facilitate the generation of audio file for the same captcha.

Suppose if the URL for the generation for image is
`http://localhost:3000/simple_captcha?code=3b803d95a91435997917b24046041cc31427aea3&time=1433768850` then simply append `audio=true` to the above URL to facilitate the generation of the audio file.

So visiting
`http://localhost:3000/simple_captcha?code=3b803d95a91435997917b24046041cc31427aea3&time=1433768850&audio=true` would generate the audio file.

## Requirements
* Ruby >= 1.9.3
* Rails >= 3.2
* You need to install `espeak`, `lame` and `sox` system libraries which would help you in the text to speech conversion and exporting the audio to the `mp3` format. `sox` is used for multiple audio files in a single consolidated mp3 file.

You might need to install the above libraries on a Mac-System:

```
brew install espeak lame
brew install flac sox chromaprint
```

On ubuntu system

```
apt-get install espeak lame
apt-get install libsox-fmt-all sox libchromaprint-dev
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/simple_captcha_audio/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
