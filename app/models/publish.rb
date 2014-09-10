require 'csv'
require 'net/ftp'

addr = 'ftp.susteq.nl'
user = 'dev@susteq.nl'
pass = '7YFVq8Yg'

Net::FTP.open(addr) do |ftp|
  ftp.login(user, pass)
end
