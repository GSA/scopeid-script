
class FetchScopeidsController < ApplicationController
	http_basic_authenticate_with name: ENV["SCOPEID_CSV_USERNAME"], password: ENV["SCOPEID_CSV_PASSWORD"] if Rails.env.production?
  
  def index
    converter = build_scopeid_converter
    file = converter.build_csv_file
    send_file(file)
  end

  def build_scopeid_converter
  	ScopeidConverter.new
  end

end
