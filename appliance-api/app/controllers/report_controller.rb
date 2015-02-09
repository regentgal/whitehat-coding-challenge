class ReportController < ApplicationController

  before_action :load_data
  
  def report
  end

  def report_data
    load_report
    render json: @report
  end

  private
  # This still takes about 4 seconds. In real life, I'd recommend moving it
  # into a background job that periodically polls the targets in batches. Then
  # use some fault tolerance time/criteria to determine if it's reachable
  def load_data
    @customers = Appliance.all
    @targets = @customers.map{ |a| a.targets }.flatten
  end

  def load_report
    BatchPing.ping!(@targets)
    @report = Report.new(@customers)
  end

end