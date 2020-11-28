class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
         #⏫上記から :validatableを削除、これによりpasswordをカスタマイズできる
  validates :name, :profile, :occupation, :position, :email, presence: true
  validates :password, presence: true, length: { minimum: 6 } #パスワードを6文字以上に制限
  has_many :prototypes
  has_many :comments
end