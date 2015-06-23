
class FetchScopeidsController < ApplicationController

  def index
    converter = ScopeidConverter.new
    file = converter.build_csv_file
    send_file(file)
  end

end
