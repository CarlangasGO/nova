class AddAttributesToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :token, :string, null: false, default: ""
    add_column :members, :first_name, :string, null: false, default: ""
    add_column :members, :last_name, :string, null: false, default: ""
    add_column :members, :phone_number, :string, null: false, default: ""
    add_column :members, :birth_date, :date
    add_column :members, :gender, :integer, default: 0
    add_column :members, :nick_name, :string, null: false, default: ""
    add_column :members, :avatar, :string, null: false, default: ""
    add_column :members, :about, :text, null: false, default: ""
    add_column :members, :country, :string, null: false, default: ""
    add_column :members, :website, :string, null: false, default: ""
    add_column :members, :accept_terms, :boolean, default: false
    add_column :members, :register_at, :date
  end
end
