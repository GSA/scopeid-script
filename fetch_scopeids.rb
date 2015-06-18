require "net/http"
require "uri"
require "open-uri"
require "nokogiri"
require "pp"
require "csv"

top_terms_url = "http://govt-urls.usa.gov/tematres/vocab/services.php?task=fetchTopTerms"
nested_terms_url = "http://govt-urls.usa.gov/tematres/vocab/services.php?task=fetchDown&arg=%d"

xml_doc = Nokogiri::XML(open(top_terms_url))

taxonomy_hashes = xml_doc.xpath('//term').map do |term|
	if !term.xpath('./code').text.start_with?('z ')
		{ :id => term.xpath('./term_id').text,
	  		:name => term.xpath('./string').text }
	else
		nil
	end
end.compact

csv_rows = []

taxonomy_hashes.each do |hash|
	nested_terms_doc = Nokogiri::XML(open(nested_terms_url % hash[:id].to_i))
	hash[:terms] = nested_terms_doc.xpath('//term').map{ |term| "http://" + term.xpath('./string').text }
	if hash[:name] != "usagovFEDgov"
		hash[:name] = "usagov"
	end
	hash[:terms].each do |term|
		csv_rows << [term, hash[:name]]
	end
end

csv_rows.uniq!
csv_rows.sort_by!{ |row| row[0].downcase }
file = Date.today.strftime("%m_%Y") + "_scope_ids.csv"

CSV.open(file, "w") do |csv|
	csv_rows.each do |row|
		csv << row
	end
end