class Letter < Sequel::Model
  set_schema do
    primary_key :id
    String :token
    Integer :user_id
    text :profile
    text :message, :null => false
    time :created
  end
  many_to_one :user
  create_table unless table_exists?

  def after_create
    self.created = Time.now
    self.token = SecureRandom.hex(32)
    save
  end

  def created_to_s
    self.created.strftime('%Y-%m-%d %H:%M:%S')
  end

  def publish
    { :message =>self.message.to_s,
      :created => self.created,
    }
  end
end
