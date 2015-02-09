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
    # Someday it would be nice to track and report based on last_reachable_time.
    # Let someone else decided how long before its unreachable.
    @reachable = true
  end

  def as_json(opts = {})
    super(methods: :reachable?, 
      only: [:hostname, :address],
      include: { 
        appliance: { 
          only: [:customer, :name]
      }})

  end

end
