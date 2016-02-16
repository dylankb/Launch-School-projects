require 'pry'

def url_parser(url) 
  protocol, host_and_path_and_params = url.split('//')
  
  host = host_and_path_and_params.scan(/[\w]+\.[\w]+/)
  path_and_params = host_and_path_and_params.gsub!(host.join, "")
  path, params = host_and_path_and_params.split('?')
  #binding.pry
  params = params.split('&').each_with_object({}) do |param, hsh|
    key, value = param.split('=')
    hsh[key] = value
  end
  [host, path, params]
end

host, path, params = url_parser("https://amazon.com/Double-Stainless-Commercial-Refrigerator/B60HON32?ie=UF8&qid=142952676&sr=93&keywords=commercial+fridge")

p host 
p path 
p params