  namespace :admin_user do
    desc "Create admin user"
    task :create => :environment do
      user = User.create(:login => "admin", :password => "admin", :password_confirmation => "admin", :enable => true, :role => "admin")
      user.save!
    end
  end
