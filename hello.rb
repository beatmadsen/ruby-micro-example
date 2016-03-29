require 'eventmachine'
require 'sinatra/base'
require 'thin'
require 'sinatra/async'
require 'em-http-request'

# Our simple hello-world app
class HelloApp < Sinatra::Base
  register Sinatra::Async

   aget '/' do
     body "hello async"
   end

   aget '/delay/:n' do |n|
     EM.add_timer(n.to_i) { body { "delayed for #{n} seconds" } }
   end
   
   aget '/outbound' do
     EM.next_tick do 
       http = EventMachine::HttpRequest.new('http://google.com/').get :query => {'keyname' => 'value'}
       
       http.errback { p 'Uh oh' }
       http.callback do
         p http.response_header.status
         p http.response_header
         body { http.response }
       end
     end
   end
   
end