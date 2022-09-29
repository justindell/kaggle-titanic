require "rubygems"
require "csv"
require "bundler/setup"
Bundler.require(:default)

data = Rover.read_csv("data/test.csv")
data["Ticket"].map!(&:to_s)
model = Eps::Model.load_pmml(File.read("model.pmml"))
CSV.open("submisssion.csv", "wb") do |csv|
  csv << %w[PassengerId Survived]
  data.each_row do |row|
    csv << [row["PassengerId"], model.predict(row)]
  end
end
