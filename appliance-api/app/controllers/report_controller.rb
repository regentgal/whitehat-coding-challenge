class ReportController < ApplicationController

  def report

    @appliances = Appliance.all
    @targets = @appliances.collect{ |a| a.targets.to_a}.flatten
    refresh_target_reachability(@targets)
  
    @report = ReachableReport.new(@appliances)
  end

  # TODO: where does this go? it sure isn't here!
  private
  def refresh_target_reachability(targets)  

    # TODO: This certainly gets the time down, but spinning up so many threads at once isn't exactly 
    # efficient either. Let's see what we can do later.
    threads = @targets.map do |t|
      Thread.new do
        t.ping!
      end
    end

    threads.each do |t|
      t.join
    end
  end

end