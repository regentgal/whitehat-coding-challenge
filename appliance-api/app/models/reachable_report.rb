# A nice viewmodel makes our view-life easier.
class ReachableReport

  def initialize(appliances)
    @appliances = appliances
    @targets = @appliances.collect{ |a| a.targets.to_a}.flatten

  end

  def target_count 
    @target_count ||= @targets.count
  end
  
  def unreachables_count
    @unreachables_count ||= unreachables.count
  end

  def unreachables
    @unreachables ||= @targets.select{|t| !t.reachable?}
  end
  
  def targets
    @targets
  end
end