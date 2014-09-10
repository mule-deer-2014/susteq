require 'csv'
require 'net/ftp'

ADDR = ENV['FTP_PATH']
USER = ENV['FTP_USER']
PASS = ENV['FTP_PASS']

def generateCsv
  file = "#{File.expand_path("./lib")}\/TEST.csv"
  CSV.open(file, "w") do |csv|
    csv << ["row", "of", "CSV", "data"]
  end

  return file
end

def writeFileToServer file
  puts file
  Net::FTP.open(ADDR) do |ftp|
    ftp.login(USER, PASS)
    ftp.putbinaryfile(file, 'prices.csv')
  end
end

writeFileToServer(generateCsv)
