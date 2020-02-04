require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def trader_de_lobscure   
  page1 = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))    
  a = []
  i=0
  while i<200
   crypto = Hash.new
   price = page1.css('div table tbody').css('tr')[i].css('td')[4].css('a').text
   symbol = page1.css('div table tbody').css('tr')[i].css('td')[2].text
   crypto[symbol] = price 
   a << crypto
   i+=1
  end
  return a
end

=begin
def route_de_la_mairie
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/")) 

  page.xpath('//div/table/tbody/tr//a').each do |link|
    #binding.pry
    puts link['href']
    puts link.text
  end
end
=end
def route_de_la_mairie
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html")) 
  puts "nata"
  #page.xpath('/html/body/table/tbody/tr[3]/td/table/tbody/tr/td[2]/p[2]/object/table/tbody/tr[2]/td/table/tbody/tr/td[2]/p/a').each do |link|
  page.css('html body table tbody tr td table tbody tr td p object#voyance-par-telephone table tbody tr td table.Style20 tbody tr td p a.lientxt').each do |link|
  #page.css('html body table tbody').css('tr')[2].css('td table tbody tr').css('td')[1].css('p')[1].css('object table tbody').css('tr')[1].css('td table tbody tr').css('td')[2].css('p a').each do |link|  
    puts link['href']
    puts link.text
  end
end
route_de_la_mairie
