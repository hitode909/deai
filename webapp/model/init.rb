require 'sequel'
require 'securerandom'

Sequel::Model.plugin(:schema)
DB = Sequel.sqlite('app.db')

require 'model/letter'
require 'model/trade'
