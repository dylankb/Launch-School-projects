require 'socket'

def url_parser(request_line)  #/?rolls=2&sides=6
  http_method, path_and_param, http = request_line.split(' ')
  path, params = path_and_param.split('?')
  binding.pry
  params = params.split('&').each_with_object({}) do |pair, hash|
    key, value = pair.split("=")
    hash[key] = value
  end
  [http_method, path, params]
end

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

  client.puts "<h3>Rolls!</h3>"
  rolls = params["rolls"].to_i
  sides = params["sides"].to_i

  rolls.times do
    roll = rand(sides) + 1
    client.puts "<p>", roll, "</p>"
  end

  client.puts "</body>"
  client.puts "</html>"

  client.close
end