require 'spec_helper'

describe Target, :type => :model do
  let(:appliance) {Appliance.create! name: 'app1', customer: 'WhiteHat'}

  describe "#new" do
    it "validates IP addresses" do
      target = Target.new hostname: 'foo', address: '8.8.8.8', appliance: appliance
      expect(target.valid?).to be(true)
    end

    it "fails missing address" do
      target = Target.new hostname: 'foo', appliance: appliance
      expect(target.valid?).to be(false)
    end

    it "fails missing hostname" do
      target = Target.new address: '8.8.8.8', appliance: appliance
      expect(target.valid?).to be(false)
    end

    it "fails mising appliance id" do
      target = Target.new hostname: 'foo', address: '8.8.8.8'
      expect(target.valid?).to be(false)
    end
  end

  describe "#address" do
    it "fails bad IP addresses" do
      target = Target.new hostname: 'foo', address: '888.888.888.888', appliance: appliance
      expect(target.valid?).to be(false)
    end
  end

  describe "#hostname" do
    it "validates unique hostnames" do
      Target.create hostname: 'foo', address: '8.8.8.8', appliance: appliance
      target = Target.new hostname: 'foo', address: '8.8.8.8', appliance: appliance
      expect{target.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

end
