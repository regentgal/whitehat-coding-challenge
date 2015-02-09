require 'spec_helper'

describe ReachableReport, :type => :model do
  
  let(:customers) {
    appliances = ["Bob", "Linda", "Amy"].map {|s| Appliance.new(customer: s, name: s) }

    appliances.each do |a| 
      a.targets << Target.new(hostname: a.customer, address: "127.0.0.1", appliance_id: a.id)      
    end

    appliances.first.targets.first.last_reachable_at = Time.now
    
    appliances
  }

  before :each do
    @report = ReachableReport.new(customers)
  end

  describe '#customers' do
    it 'returns the correct list of customers' do
      expect(@report.customers).to match_array(customers)    
    end
  end
  describe '#sad_customers' do
    it 'returns the correct list of sad customers' do
      sads = customers.select {|c| c.targets.any? { |t| !t.reachable? }}
      expect(@report.sad_customers).to match_array(sads)
    end
  end

  describe "#unreachables" do
    it 'returns the correct list of unreachable targets' do  
      unreachables = customers.map { |a| a.targets }.flatten.select { |t| !t.reachable? }
      expect(@report.unreachable_targets).to match_array(unreachables)
    end
  end

  describe "#targets" do
    it 'returns the correct list of targets' do
      targets = customers.map {|c| c.targets}.flatten
      expect(@report.targets).to match_array(targets)
    end
  end

end
