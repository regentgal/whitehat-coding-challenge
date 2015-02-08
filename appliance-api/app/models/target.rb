class Target < ActiveRecord::Base

  belongs_to :appliance

  validates :appliance_id, presence:   true

  validates :hostname,     presence:   true,
                           uniqueness: true

  validates :address,      presence:   true,
                           format:     {with: Resolv::IPv4::Regex}

  
  def reachable?
    @reachable || false
  end

  def last_reachable_at=(value)
    # TODO: Would be nice to track and report based on last_reachable_time.
    @reachable = true
  end
end
