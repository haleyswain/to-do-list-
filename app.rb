require('sinatra')
require('sinatra/reloader')
require('./lib/word_count')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "to_do"})

get('/') do
  erb(:index)
end
