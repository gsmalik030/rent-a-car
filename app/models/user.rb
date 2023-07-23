class User < ApplicationRecord
    has_secure_password

    validates :email, presence:true, uniqueness:true
    validates :user_name, presence:true, uniqueness:true
    validates :password, presence:true

    def admin?
        role == "admin"
    end
end
