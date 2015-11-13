require 'spec_helper'

describe Report, type: :model do
  let(:customers) do
    appliances = ["Bob", "Linda", "Amy"].map { |s| Appliance.new(customer: s, name: s) }

    appliances.each do |a|
      a.targets << Target.new(hostname: a.customer, address: "127.0.0.1", appliance_id: a.id)
    end

    appliances.first.targets.first.last_reachable_at = Time.now.utc

    appliances
  end

  before :each do
    @report = Report.new(customers)
  end

  describe '#customer_count' do
    it 'returns the correct number of customers' do
      expect(@report.customer_count).to eq(customers.count)
    end
  end

  describe '#sad_customer_count' do
    it 'returns the correct number of sad customers' do
      sads = customers.select { |c| c.targets.any? { |t| !t.reachable? } }
      expect(@report.sad_customer_count).to eq(sads.count)
    end
  end

  describe "#unreachable_count" do
    it 'returns the correct number of unreachable targets' do
      unreachables = customers.map { |a| a.targets }.flatten.select { |t| !t.reachable? }
      expect(@report.unreachable_count).to eq(unreachables.count)
    end
  end

  describe "#target_count" do
    it 'returns he correct number of targets' do
      targets = customers.map { |c| c.targets }.flatten
      expect(@report.target_count).to eq(targets.count)
    end
  end

  describe "#target" do
    it 'returns the correct list of targets' do
      targets = customers.map { |c| c.targets }.flatten
      expect(@report.targets).to match_array(targets)
    end
  end
end
