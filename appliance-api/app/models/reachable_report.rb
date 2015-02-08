# A nice viewmodel makes our view-life easier.
class ReachableReport

  def initialize(appliances)
    @appliances = appliances
    @targets = @appliances.collect{ |a| a.targets.to_a}.flatten

  end

  def customer_count
    @customer_count ||= @appliances.count
  end

  def target_count 
    @target_count ||= @targets.count
  end
 
  def sad_customer_count
    @sad_customers ||= sad_customers.count
  end

  def sad_customers
    @appliances.select{|a| a.targets.any?{|t| !t.reachable? }}
  end

  def unreachable_count
    @unreachables_count ||= unreachables.count
  end

  def unreachables
    @unreachables ||= @targets.select{|t| !t.reachable?}
  end
  
  def targets
    @targets
  end
end