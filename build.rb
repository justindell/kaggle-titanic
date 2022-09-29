require "rubygems"
require "csv"
require "bundler/setup"
Bundler.require(:default)

data = Rover.read_csv("data/train.csv")
data["Ticket"].map!(&:to_s)
data["Survived"].map!(&:to_s)
model = Eps::Model.new(data, target: "Survived")
puts model.summary
File.write("model.pmml", model.to_pmml)
