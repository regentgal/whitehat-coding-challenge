class ReportController < ApplicationController

  def index
    @customers = Appliance.all.map { |a| [a.customer, a.id] }
  end

  def show
    @appliance = Appliance.find(params[:customer])
  end
end