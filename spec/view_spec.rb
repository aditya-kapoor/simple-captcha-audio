require 'spec_helper'
require 'active_support/core_ext/hash'
require 'action_view'
require 'simple_captcha/view'
require 'simple_captcha_audio'

class TestView < ActionView::Base
  include SimpleCaptcha::ViewHelper
end

describe SimpleCaptcha::ViewHelper do
  let(:view_helper_object) { TestView.new }
  let(:field_value)        { '1234567890' }
  let(:now)                { Time.now.to_i }

	context 'Instance Methods' do
    context 'simple_captcha_options' do
      before { expect(view_helper_object).to receive(:__simple_captcha_options__).and_return({}) }
      it { expect(view_helper_object.simple_captcha_options(field_value: field_value).keys).to include :audio }
      it { expect(view_helper_object.simple_captcha_options(field_value: field_value)[:audio]).to eq "<audio src=\"/simple_captcha?code=&amp;time=#{now}&amp;audio=true\" id=\"simple_captcha-audio-#{ field_value }\" controls=\"controls\" />" }
    end

    context '#simple_captcha_audio_id' do
      it { expect(view_helper_object.send(:simple_captcha_audio_id, field_value: field_value)).to eq "simple_captcha-audio-#{ field_value }" }
    end

    context '#simple_captcha_id_prefix' do
      it { expect(view_helper_object.send(:simple_captcha_id_prefix)).to eq 'simple_captcha-audio' }
    end

    context '#simple_captcha_audio_url' do
      it { expect(view_helper_object.send(:simple_captcha_audio_url, 'some_dummy_id', time: now)).to eq "/simple_captcha?code=some_dummy_id&time=#{now}&audio=true" }
    end

    context '#simple_captcha_audio' do
      it { expect(view_helper_object.send(:simple_captcha_audio, 'some_dummy_id', time: now, field_value: field_value)).to eq "<audio src=\"/simple_captcha?code=some_dummy_id&amp;time=#{ now }&amp;audio=true\" id=\"simple_captcha-audio-#{ field_value }\" controls=\"controls\" />" }
    end
  end
end