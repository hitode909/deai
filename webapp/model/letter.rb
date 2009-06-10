class Letter < Sequel::Model
  set_schema do
    primary_key :id
    String :token
    String :name
    text :profile
    text :message, :null => false
    time :created
  end

  create_table unless table_exists?

  def after_create
    self.created = Time.now
    generate_token
    save
  end

  def generate_token
    key = self.profile + self.message + self.created.to_s
    self.token = Digest::SHA1.hexdigest(key)
  end

  def created_to_s
    self.created.strftime('%Y-%m-%d %H:%M:%S')
  end

  def publish
    { :name => self.name.to_s,
      :profile => self.profile.to_s,
      :message =>self.message.to_s,
      :created => self.created,
    }
  end
end
