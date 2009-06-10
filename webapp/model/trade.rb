require 'pp'
class Trade < Sequel::Model
  set_schema do
    primary_key :id
    boolean :active, :null => false, :default => false
    foreign_key :letter_id, :table => :letters, :unique => true
    foreign_key :pair_id, :table => :trades
    time :created
  end
  many_to_one :letter, :class=>Letter
  many_to_one :pair, :class=>Trade

  create_table unless table_exists?

  def after_create
    self.created = Time.now
    save
  end

  def get_pair
    self.active!
    30.times do
      refresh
      break if self.pair
      single = Trade.filter('id != ?', self.id).filter(:active => true).filter(:pair_id => nil).first
      if single and not self.pair
        self.pair_with single
        single.pair_with self
        break
      end
      sleep 1
    end
    self.disactive!
  end

  def pair_with(single)
    return if self.pair
    self.disactive!
    self.pair = single
    save
  end

  def active!
    self.active = true unless self.pair
    save
  end

  def disactive!
    self.active = false
    save
  end
end
