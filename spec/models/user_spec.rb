# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                :bigint           not null, primary key
#  account_name      :string(255)
#  activated         :boolean          default(FALSE)
#  activated_at      :datetime
#  activation_digest :string(255)
#  admin             :boolean          default(FALSE)
#  email             :string(255)
#  password_digest   :string(255)
#  picture           :string(255)
#  profile           :text(65535)
#  remember_digest   :string(255)
#  reset_digest      :string(255)
#  reset_sent_at     :datetime
#  user_name         :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_account_name  (account_name) UNIQUE
#  index_users_on_email         (email) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validates' do
    let(:user) do
      User.new(
        user_name: 'test',
        account_name: 'test',
        email: 'test@example.com',
        password: 'hogehoge'
      )
    end

    let(:other_user) do
      User.new(
        user_name: 'test2',
        account_name: 'test2',
        email: 'test2@example.com',
        password: 'hogehoge'
      )
    end

    describe 'presence' do
      context 'ユーザ名、アカウント名、メールアドレス、パスワードが存在する場合' do
        example '有効になること' do
          expect(user).to be_valid
        end
      end

      context 'ユーザー名が存在しない場合' do
        example '無効になること' do
          user.update_attributes(user_name: nil)
          expect(user.errors[:user_name]).to include("を入力してください")
        end
      end

      context 'アカウント名が存在しない場合' do
        example '無効になること' do
          user.update_attributes(account_name: nil)
          expect(user.errors[:account_name]).to include("を入力してください")
        end
      end

      context 'メールアドレスが存在しない場合' do
        example '無効になること' do
          user.update_attributes(email: nil)
          expect(user.errors[:email]).to include("を入力してください")
        end
      end

      context 'パスワードが存在しない場合' do
        example '無効になること' do
          user.update_attributes(password: nil)
          expect(user.errors[:password]).to include("を入力してください")
        end
      end
    end

    describe 'length' do
      describe 'ユーザー名' do
        context '50文字の場合' do
          example '有効になること' do
            user.update_attributes(user_name: 'a' * 50)
            expect(user).to be_valid
          end
        end

        context '51文字の場合' do
          example '無効になること' do
            user.update_attributes(user_name: 'a' * 51)
            expect(user.errors[:user_name]).to include('は50文字以内で入力してください')
          end
        end
      end

      describe 'アカウント名' do
        context '14文字の場合' do
          example '有効になること' do
            user.update_attributes(account_name: 'a' * 14)
            expect(user).to be_valid
          end
        end

        context '15文字の場合' do
          example '無効になること' do
            user.update_attributes(account_name: 'a' * 255)
            expect(user.errors[:account_name]).to include('は14文字以内で入力してください')
          end
        end
      end

      describe 'メールアドレス' do
        context 'メールアドレスが255文字の場合' do
          example '有効になること' do
            user.update_attributes(email: 'a' * 243 + '@example.com')
            expect(user).to be_valid
          end
        end

        context ' メールアドレスが256文字の場合' do
          example '無効になること' do
            user.update_attributes(email: 'a' * 244 + '@example.com')
            expect(user.errors[:email]).to include('は255文字以内で入力してください')
          end
        end
      end

      describe 'パスワード' do
        context '6文字の場合' do
          example '有効になること' do
            user.update_attributes(password: 'a' * 6)
            expect(user).to be_valid
          end
        end

        context '5文字の場合' do
          example '無効になること' do
            user.update_attributes(password: 'a' * 5)
            expect(user).not_to be_valid
          end
        end
      end
    end

    describe 'uniqueness' do
      context 'アカウント名が重複した場合' do
        example '無効になること' do
          user.save
          other_user.account_name = user.account_name
          other_user.valid?
          expect(other_user.errors[:account_name]).to include('はすでに存在します')
        end
      end

      context 'メールアドレスが重複した場合' do
        example '無効になること' do
          user.save
          other_user.email = user.email
          other_user.valid?
          expect(other_user.errors[:email]).to include('はすでに存在します')
        end
      end

      context '小文字と大文字でメードアドレスが重複した場合' do
        example '無効になること' do
          user.save
          other_user.email = user.email.upcase
          other_user.valid?
          expect(other_user.errors[:email]).to include('はすでに存在します')
        end
      end
    end

    describe 'format' do
      context '有効なメールアドレスの場合' do
        example '有効になること' do
          valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
          valid_addresses.each do |valid_address|
            user.email = valid_address
            expect(user).to be_valid
          end
        end
      end

      context '無効なメールアドレスの場合' do
        example '無効になること' do
          invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
          invalid_addresses.each do |invalid_addresse|
            user.email = invalid_addresse
            expect(user).not_to be_valid
          end
        end
      end
    end
  end
end
