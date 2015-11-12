class Report
  attr_accessor :customer_count, :sad_customer_count,
                :unreachable_count, :target_count, :targets

  def initialize(appliances)
    @targets = appliances.map { |a| a.targets.to_a }.flatten
    @customer_count = appliances.count
    @sad_customer_count = appliances.count { |a| a.targets.any? { |t| !t.reachable? } }
    @unreachable_count = @targets.count { |t| !t.reachable? }
    @target_count = @targets.count
  end
end
