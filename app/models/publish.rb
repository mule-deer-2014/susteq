require 'csv'
require 'net/ftp'

ADDR = ENV['FTP_PATH']
USER = ENV['FTP_USER']
PASS = ENV['FTP_PASS']

class WorkerScript
  def convertToCsv data
    file = "#{File.expand_path("./lib")}\/TEST.csv"
    CSV.open(file, "w") do |csv|
      csv << data
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

  def exportData
    data = ["row", "of", "CSV", "data"]
    writeFileToServer(convertToCsv(data))
  end
end
