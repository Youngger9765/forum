class LegislatorsController < ApplicationController
  
  def index
    @legislators = Legislator.all
  end

end
