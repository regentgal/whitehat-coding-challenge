require "em-synchrony"

class BatchPing
  def self.ping!(targets)
    EM.synchrony do
      concurrency = 1000 # lol. really? still better than a 1000 threads.

      EM::Synchrony::Iterator.new(targets, concurrency).each do |target, iter|
        ping = EventMachine::Protocols::TcpConnectTester.test(target.address, 3000)
        ping.timeout(1)
        ping.callback do
          target.last_reachable_at = Time.now.utc
          iter.next
        end
        ping.errback { iter.next }
      end
      EventMachine.stop
    end

    targets
  end
end
