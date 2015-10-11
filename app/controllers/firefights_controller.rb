class FirefightsController < ApplicationController

  def index
    @firefights = Firefight.all
  end

end
