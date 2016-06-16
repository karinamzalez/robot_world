require 'models/robot_manager'

class RobotWorldApp < Sinatra::Base
  set :method_override, true
  set :root, File.expand_path("..", __dir__)

  get '/' do
    erb :dashboard
  end

  get '/robots' do
    @robots = robot_manager.all
    erb :index
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    # require "pry"; binding.pry
    robot_manager.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id/edit' do |id|
    @robot = robot_manager.find(id.to_i)
    erb :edit
  end

  get '/robots/:id' do |id|
    @robot = robot_manager.find(id.to_i)
    erb :show
  end

  put '/robots/:id' do |id|
    robot_manager.update(id.to_i, params[:robot])
    redirect "/robots/#{id}"
  end

  delete '/robots/:id' do |id|
    robot_manager.destroy(id.to_i)
    redirect '/robots'
  end

  def robot_manager
    database = YAML::Store.new('db/robot_manager')
    @robot_manager ||= RobotManager.new(database)
  end
end
