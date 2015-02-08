require "em-synchrony"

class BatchPing

  def self.ping!(targets)

    EM.synchrony do
      concurrency = 1000 # TODO: lol. really?

      # iterator will execute async blocks until completion, .each, .inject also work!
      EM::Synchrony::Iterator.new(targets, concurrency).each do |target, iter|

        # fire async requests, on completion advance the iterator
        ping = EventMachine::Protocols::TcpConnectTester.test(target.address, 3000)
        ping.timeout(1)
        ping.callback do 
          target.last_reachable_at = Time.now
          iter.next 
        end
        ping.errback { iter.next }
      
      end
      EventMachine.stop
    end

    targets
  end
end