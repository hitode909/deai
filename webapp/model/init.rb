require 'sequel'

Sequel::Model.plugin(:schema)
DB = Sequel.sqlite('app.db')

require 'model/letter'
