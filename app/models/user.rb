class User < ApplicationRecord
  devise :database_authenticatable, :recoverable
end
