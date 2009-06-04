class Letter < Sequel::Model
  set_schema do
    primary_key :id
    String :token
    String :profile, :null => false
    String :message
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
end
