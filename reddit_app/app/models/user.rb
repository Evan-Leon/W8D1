# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord 
    
    validates :username, :password_digest, :session_token, presence: true
    validates :username, uniqueness: true 
    validates :password, length: {minimum: 6, allow_nil: true}

    has_many :subs,
      primary_key: :id,
      foreign_key: :moderator_id,
      class_name: :Sub 

    has_many :authored_posts,
      primary_key: :id,
      foreign_key: :author_id,
      class_name: :Post 

    after_initialize :ensure_session_token
    attr_reader :password 

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        if user && user.is_password?(password)
            user 
        else  
            nil
        end
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end


    def is_password?(password)
        pass_obj = BCrypt::Password.new(self.password_digest)
        pass_obj.is_password?(password)
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    def reset_session_token!
        self.session_token = User.generate_session_token 
        self.save 
        self.session_token 
    end

end
