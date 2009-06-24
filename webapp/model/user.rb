class User < Sequel::Model
  set_schema do
    primary_key :id
    String :token
    time :created
    time :last_access
    Boolean :active, :null => false, :default => true
  end
  one_to_many :letters
  create_table unless table_exists?

  def after_create
    self.created = Time.now
    self.token = SecureRandom.hex(32)
    save
  end

  def created_to_s
    self.created.strftime('%Y-%m-%d %H:%M:%S')
  end
end
