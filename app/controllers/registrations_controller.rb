class RegistrationsController < Devise::RegistrationsController
  protected

# from https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-on-successful-sign-up-%28registration%29
  def after_sign_up_path_for(resource)
    new_project_path
  end
end