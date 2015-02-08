require 'spec_helper'

describe ReachableReport, :type => :model do
  
  before :each do 
    appliances = ["Bob", "Linda", "Amy"].collect do |s|
      Appliance.new(customer: s, name: s)
    end

    appliances.each do |a| 
      a.targets << Target.new(hostname: a.customer, address: "127.0.0.1", appliance_id: a.id)      
    end

    @report = ReachableReport.new(appliances)
  end

  describe "#customer_count" do
    it 'returns the correct number of customers' do          
      expect(@report.customer_count).to eq 3
    end
  end

  describe '#target_count' do
    it 'returns the correct number of targets' do
      expect(@report.target_count).to eq 3
    end
  end

  xdescribe '#sad_customer_count' do
    it 'returns the correct number of sad customers' do
      # TODO: Can't test this right now unless we actually stub out ping and make the
      # update calls... Need to pull ping out of target and just leave status there.
    end
  end

  xdescribe '#sad_customers' do
    it 'returns the correct list of sad customers' do
    end
  end

  xdescribe "#unreachable_count" do
    it 'returns the correct number of unreachable targets' do
    end
  end

  xdescribe "#unreachables" do
    it 'returns the correct list of unreachable targets' do      
    end
  end

  describe "#targets" do
    it 'returns the correct list of targets' do
      expect(@report.targets.count).to eq(3)
      expect(@report.targets[0].hostname).to eq "Bob"
      expect(@report.targets[1].hostname).to eq "Linda"
      expect(@report.targets[2].hostname).to eq "Amy"
    end
  end

end
