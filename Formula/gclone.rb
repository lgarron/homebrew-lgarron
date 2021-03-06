# frozen_string_literal: true

class Gclone < Formula
  desc 'Git clone script.'
  homepage 'https://github.com/lgarron/scripts'
  head 'https://github.com/lgarron/scripts.git', :branch => 'main'

  def install
    bin.install 'git/gclone'
  end

  test do
    system 'false'
  end
end
