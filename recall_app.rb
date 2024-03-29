require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra'
require 'shotgun'
require 'data_mapper'
require 'dm-sqlite-adapter'

# Home Page
get '/' do;
  @notes = Note.all :order => :id.desc
  @title = 'All Notes'
  erb :home
end

post '/' do;
  n = Note.new
  n.content = params[:content]
  n.created_at = Time.now
  n.updated_at = Time.now
  n.save
  @note = n
  erb :note, :layout => false
end

# Single Notes Pages
get '/:id' do
  @note = Note.get params[:id]
  @title = "Edit note ##{params[:id]}"
  erb :edit
end

post '/:id' do
  n = Note.get params[:id]
  n.content = params[:content]
  n.complete = params[:complete]? 1 : 0
  n.updated_at = Time.now
  n.save
  redirect '/'
end

# Delete
get '/:id/delete' do
  @note = Note.get params[:id]
  @title = "Confirm deletion of note ##{params[:id]}"
  erb :delete
end

post '/:id/delete' do
  n = Note.get params[:id]
  n.destroy
  redirect '/'
end

# Complete
get '/:id/complete' do
  n = Note.get params[:id]
  n.complete = n.complete ? 0 : 1
  n.updated_at = Time.now
  n.save
  redirect '/'
end

# Database
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recall.db")

class Note
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, :required => true
  property :complete, Boolean, :required => true, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!