class TopController < ApplicationController
  def index
    @mood = Mood.find_by(name: "落ち着いた")
  end
end
