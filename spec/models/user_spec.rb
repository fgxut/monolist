require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#validates" do
    let(:user) { User.new(
      user_name: "test", 
      account_name: "test",
      email: "test@example.com",
      password: "hogehoge"
      ) }

    describe "presence" do
      context "ユーザ名、アカウント名、メールアドレス、パスワードが存在する場合" do
        example "有効になること" do
          expect(user).to be_valid
        end
      end

      context "ユーザー名が存在しない場合" do
        example "無効になること" do
          user.update_attributes(user_name: nil)
          user.valid?
          expect(user.errors[:user_name]).to include("can't be blank")
        end
      end

      context "アカウント名が存在しない場合" do
        example "無効になること" do
          user.update_attributes(account_name: nil)
          user.valid?
          expect(user.errors[:account_name]).to include("can't be blank")
        end
      end

      context "メールアドレスが存在しない場合" do
        example "無効になること" do
          user.update_attributes(email: nil)
          user.valid?
          expect(user.errors[:email]).to include("can't be blank")
        end
      end

      context "パスワードが存在しない場合" do
        example "無効になること" do
          user.update_attributes(password: nil)
          user.valid?
          expect(user.errors[:password]).to include("can't be blank")
        end
       end
    end
    
    describe "length" do
      context "ユーザー名が50文字の場合" do
        example "有効になること" do
          user.update_attributes(user_name: "a" * 50)
          user.valid?
          expect(user).to be_valid
        end
      end

      context "ユーザー名が51文字の場合" do
        example "無効になること" do
          user.update_attributes(user_name: "a" * 51)
          user.valid?
          expect(user.errors[:user_name]).to include("is too long (maximum is 50 characters)")
        end
      end

      context "アカウント名が14文字の場合" do
        example "有効になること" do
          user.update_attributes(account_name: "a" * 14)
          user.valid?
          expect(user).to be_valid
        end
      end

      context "アカウント名が15文字の場合" do
        example "無効になること" do
          user.update_attributes(account_name: "a" * 255)
          user.valid?
          expect(user.errors[:account_name]).to include("is too long (maximum is 14 characters)")
        end
      end

      context "メールアドレスが255文字の場合" do
        example "有効になること" do
          user.update_attributes(email: "a" * 243 + "@example.com")
          user.valid?
          expect(user).to be_valid
        end
      end

      context " メールアドレスが256文字の場合" do
        example "無効になること" do
          user.update_attributes(email: "a" * 244 + "@example.com")
          user.valid?
          expect(user).not_to be_valid
        end
      end
    end

    describe "uniqueness" do
      context "アカウント名が重複した場合" do
        example "無効になること" do
          user.save
          user = User.new(
            user_name: "test2",
            account_name: "test",
            email: "test2@example.com",
            password: "hogehoge2"
          )
          user.valid?
          expect(user.errors[:account_name]).to include("has already been taken")
        end
      end

      context "メールアドレスが重複した場合" do
        example "無効になること" do
          user.save
          user = User.new(
            user_name: "test2",
            account_name: "test2",
            email: "test@example.com",
            password: "hogehoge2"
          )
          user.valid?
          expect(user.errors[:email]).to include("has already been taken")
        end
      end
    end
  end
end

