# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_captcha_audio/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_captcha_audio"
  spec.version       = SimpleCaptchaAudio::VERSION
  spec.authors       = ["Aditya Kapoor"]
  spec.email         = ["adityakapoor.mait@gmail.com"]
  spec.summary       = "Simple Audio Extension to Simple Captcha"
  spec.description   = ""
  spec.homepage      = "https://github.com/aditya-kapoor/simple-captcha-audio"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", '~> 1.6'
  spec.add_development_dependency "rake",    '~> 10.0'
  spec.add_dependency "simple_captcha2",     '~> 0.3.4'
  spec.add_dependency "espeak-ruby",         '~> 1.0.2'
  spec.add_dependency "ruby-sox",            '~> 0.0.3'
end
