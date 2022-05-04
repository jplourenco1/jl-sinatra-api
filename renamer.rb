class Renamer
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    if defined?(request.params[:file][:filename])
      request.update_param(:file[:filename], 'newname.bak')
      @app.call(env)
    else
      @app.call(env)
    end
  end
end