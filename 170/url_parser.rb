def url_parser(url) 
  protocol, host_and_path_and_params = url.split('//')
  
  host = host_and_path_and_params.scan(/[\w]+\.[\w]+/)
  path_and_params = host_and_path_and_params.gsub!(host.join, "")
  path, params = host_and_path_and_params.split('?')
  params = params.split('&').each_with_object({}) do |param, hsh|
    key, value = param.split('=')
    hsh[key] = value
  end
  [host, path, params]
end
def add_port(url)
  
end


add_port("http://amazon.com/products/B60HON32?qid=142952676&sr=93")