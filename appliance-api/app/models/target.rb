require 'net/ping'

class Target < ActiveRecord::Base
  belongs_to :appliance

  validates :appliance_id, presence:   true

  validates :hostname,     presence:   true,
                           uniqueness: true

  validates :address,      presence:   true,
                           format:     {with: Resolv::IPv4::Regex}

  # TODO: reachable?, ping?, ping! This is yucky...
  def reachable?
    @reachable ||= false
  end           

  def ping?
    # TODO: port configurable so we only use 3000 in dev.
    p1 = Net::Ping::TCP.new(address, '3000', 1)
    p1.ping?
  end

  def ping!
    @reachable = ping?
  end

end
