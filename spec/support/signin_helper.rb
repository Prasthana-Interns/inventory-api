module SigninHelper
  
  def signup_admin
    post '/users', params: {  
      user:{
        name: "shiva",
        email: Faker::Internet.unique.email,
        phone_number:  9876543210,
        designation:  "Developer", 
        approved: true  
      },
      roles: ["Admin","Employee"]
    }
    user = JSON.parse(response.body)
  end

  def signup_employee
    post '/users', params: {  
      user:{
        name: "shiva",
        email: Faker::Internet.unique.email,
        phone_number:  9876543210,
        designation:  "Developer", 
        approved: true  
      },
      roles: ["Employee"]
    }
    user = JSON.parse(response.body)
  end

  def login_admin
    @user = signup_admin
    post '/users/signin', params:
    {
      user:{ emp_id:@user['emp_id'],password: "shiva123" }
    }
    @result= JSON.parse(response.body) 
  end

  def login_employee
    @user = signup_employee
    post '/users/signin', params:
    {
      user:{ emp_id:@user['emp_id'],password: "shiva123" }
    }
    @result= JSON.parse(response.body) 
  end

end

RSpec.configure do |c|
  c.include SigninHelper
end