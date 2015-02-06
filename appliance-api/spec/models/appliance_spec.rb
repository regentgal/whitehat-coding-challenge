require 'spec_helper'

describe Appliance, :type => :model do
  describe "#new" do
    
    it "validates presence of name and customer" do
      appliance = Appliance.new name: 'app1', customer: 'WhiteHat'
      expect(appliance.valid?).to be(true)
    end

    it "validates unique appliance names" do
      Appliance.create name: 'app1', customer: 'WhiteHat'
      appliance = Appliance.new name: 'app1', customer: 'WhiteHat'
      expect{appliance.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "fails missing name" do
      appliance = Appliance.new customer: 'WhiteHat'
      expect(appliance.valid?).to be(false)
    end

    it "fails missing customer" do
      appliance = Appliance.new name: 'app1'
      expect(appliance.valid?).to be(false)
    end

  end
end
