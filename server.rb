# server
require "sinatra"
require "sinatra/namespace"
require "mongoid"

# DB setup
Mongoid.load! "mongoid.config"

# Models
class Book
  include Mongoid::Document

  field :title, type: String
  field :author, type: String
  field :isbn, type: String

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true

  index({ title: "text" })
  index({ isbn: 1 }, { unique: true, name: "isbn_index" })
end

# Endpoints
get "/" do
  "Welcome to Books"
end

namespace "/api/v1" do
  before do
    content_type "applicaton/json"
  end
  get "/books" do
    Book.all.to_json
  end
end
