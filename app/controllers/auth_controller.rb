class AuthController < ApplicationController

  def init_client
    key = "77lzzopzu8r8jm"
    secret = "FLzlwwEL5VeN86UP"
    linkedin_configuration = { :site => 'https://api.linkedin.com',
        :authorize_path => '/uas/oauth/authenticate',
        :request_token_path =>'/uas/oauth/requestToken?scope=r_basicprofile+r_fullprofile+r_emailaddress+r_network+r_contactinfo',
        :access_token_path => '/uas/oauth/accessToken' }
    @linkedin_client = LinkedIn::Client.new(key, secret,linkedin_configuration )
  end

  def auth
    init_client
    request_token = @linkedin_client.request_token(:oauth_callback => "http://#{request.host_with_port}/linkedin/callback")
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret
    redirect_to @linkedin_client.request_token.authorize_url
  end

  def callback
    init_client
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret =  @linkedin_client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
    else
      @linkedin_client.authorize_from_access(session[:atoken], session[:asecret])
    end

    c = @linkedin_client

    publications = c.profile(:fields=>["publications"]).to_hash
    publications["publications"]["all"].each do |p|
      publication = {}
      publication["title"] = p["title"]
      publication["date"] = Time.parse("#{p["date"]["day"]}-#{p["date"]["month"]}-#{p["date"]["year"]}")
      #publication[:url] = p["url"] if p["url"]
      #publication[:publisher] = p["publisher"] if p["publisher"]
      publication[:publication_type_id] = PublicationType.where(name: "article").first.id
      publication[:teacher_id] = current_teacher.id
      Publication.where(publication).first_or_create!
    end

    session[:atoken] = nil
    session[:asecret] = nil
    redirect_to :home
    #redirect_to root_path(:imported_from_linkedin=>"success")
  end

end
