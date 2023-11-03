class CreateMuchoAmigos < ActiveRecord::Migration[7.0]
  def change
    ## Basic account information
    create_table :mucho_amigos do |t|
      t.string :full_name, limit: 128
      t.string :user_name, limit: 64
      t.string :email, limit: 255
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      # The jti (JSON Web Token ID) is a claim that provides
      # a unique identifier for a JWT (JSON Web Token). Devise
      # can use this claim to identify and invalidate JWTs,
      # especially useful when implementing a blacklisting
      # strategy for tokens.
      t.string :jti, null: false # for JTIMatcher revocation
      t.datetime :jwt_expiration, null: false # if you wish to manage custom expiration time

      ## Profile information
      t.string :phone, limit: 20
      t.string :address, limit: 255
      t.string :street_number, limit: 16
      t.string :street_name, limit: 64
      t.string :street_suffix, limit: 16
      t.string :city, limit: 64
      t.string :state_abbreviation, limit: 2
      t.string :postal_code, limit: 5
      t.string :country_code, limit: 4
      t.decimal :latitude, precision: 9, scale: 6
      t.decimal :longitude, precision: 9, scale: 6
      t.boolean :party_animal
      t.text :personal_bio

      t.timestamps null: false

    end

    add_index :mucho_amigos, :user_name,            unique: true
    add_index :mucho_amigos, :email,                unique: true
    add_index :mucho_amigos, :reset_password_token, unique: true
    add_index :mucho_amigos, :confirmation_token,   unique: true
    add_index :mucho_amigos, :unlock_token,         unique: true
    add_index :mucho_amigos, :jti,                  unique: true
  end
end
