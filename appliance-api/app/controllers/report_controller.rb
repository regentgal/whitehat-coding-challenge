class ReportController < ApplicationController

  def report

    @appliances = Appliance.all
    @targets = @appliances.collect{ |a| a.targets}.flatten
    BatchPing.ping!(@targets)
  
    @report = ReachableReport.new(@appliances)
  end

end