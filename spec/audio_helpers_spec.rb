require 'spec_helper'
require 'simple_captcha/utils'
require 'simple_captcha_audio/audio_helpers'

class TestAudioHelper
  include SimpleCaptcha::AudioHelpers
end

describe SimpleCaptcha::AudioHelpers do
  let(:audio_helper_object) { TestAudioHelper.new }

  context 'Constants' do
    it { expect(SimpleCaptcha::AudioHelpers::TMP_FILES_PATH).to eq 'tmp/simple_captcha' }
  end

  context 'Instance Methods' do
    context '#generate_simple_captcha_audio' do
      pending 'TODO: Write without too much mocks and stubs.'
    end
  end
end