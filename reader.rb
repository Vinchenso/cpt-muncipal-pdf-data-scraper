require 'pdf/reader'
require 'rubygems'

file = File.open('./pdf_examples/fake_example.pdf', "rb")

PDF::Reader.open(file) do |reader| 
  reader.pages.each do |page|
    puts page.text
  end
end
                 
