class WhiteboardController < ApplicationController
  protect_from_forgery except: :auth

  def index
    # Pusher['test_channel'].trigger('my_event', message: 'Foo foo')
  end

  def auth
    response = Pusher[params[:channel_name]].authenticate(params[:socket_id], {
      user_id: 1,
      user_info: {
        name: "Gabe",
        email: "gjaldon@quipper.com"
      }
    })
    render json: response
  end
end
