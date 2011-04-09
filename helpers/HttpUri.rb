module HttpUri
  def get_response(uri)
    Net::HTTP.get_response(URI.parse(uri))
  end
end