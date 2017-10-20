# Demonstrates how carefully crafting URLs and their parameters
# to maintain state from one request to another
require 'socket'

def url_parser(request_line)
  http_method, path_and_param, http = request_line.split(' ')
  path, params = path_and_param.split('?')
  params = ( params || "").split('&').each_with_object({}) do |pair, hash|
    key, value = pair.split("=")
    hash[key] = value
  end
  [http_method, path, params]
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  puts request_line

  next unless request_line

  http_method, path, params = url_parser(request_line)

  client.puts "HTTP/1.0 200 OK"
  client.puts "ContentType: text/html"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"
  client.puts http_method
  client.puts path
  client.puts params
  client.puts "</pre>"

  client.puts "<h1>Counter</h1>"
  number = params["number"].to_i
  client.puts "The current number is: #{number}."

  client.puts "<a href='?number=#{number + 1}'>Add one</a>"
  client.puts "<a href='?number=#{number - 1}'>Minus one</a>"

  client.puts "</body>"
  client.puts "</html>"

  client.close
end
