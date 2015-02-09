# A nice viewmodel makes our view-life easier.
class ReachableReport

  def initialize(appliances)
    @appliances = appliances
    @targets = @appliances.map{ |a| a.targets.to_a}.flatten
  end

  def customers
    @appliances
  end

  def sad_customers
    @appliances.select{|a| a.targets.any?{|t| !t.reachable? }}
  end

  def unreachable_targets
    @unreachables ||= @targets.select{|t| !t.reachable?}
  end
  
  def targets
    @targets
  end
end