class AppController < Sinatra::Base

  # @api: Format the json response
  def json_response(code: 200, data:nil)
    status = code == 200 ? "SUCCESS" : "FAILURE"
    headers["Content-Type"] = "application/json"
    if data
      [ code, { data: data, message: status }.to_json ]
    end
  end

  # @api: Format all common JSON error responses
  def error_response(code, e)
    json_response(code: code, data: { error: e.message })
  end

  # @views: Format the erb responses
  def erb_responses(file)
    headers['Content-Type'] = 'text/html'
    erb file
  end
  
end
