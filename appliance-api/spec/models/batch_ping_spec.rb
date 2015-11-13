require 'spec_helper'
require 'em-synchrony'

describe BatchPing, type: :model do
  let(:targets) { (1..5).map { |n| Target.new(hostname: n, address: n) } }

  describe '#ping!' do
    it "updates all targets appropriately" do
      allow(EventMachine::Protocols::TcpConnectTester).to receive(:test) do |addr, _|
        d = EventMachine::DefaultDeferrable.new
        addr.even? ? d.succeed : d.fail
        d
      end

      BatchPing.ping!(targets)

      targets.each do |t|
        expect(t.reachable?).to(
          eq(t.address.even?),
          "Expected #{t.address.even?} for Target #{t.address}, got #{t.reachable?}")
      end
    end
  end
end
