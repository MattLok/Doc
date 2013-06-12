# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130610184459) do

  create_table "appointments", :force => true do |t|
    t.datetime "date"
    t.integer  "doctor_id"
    t.integer  "prac_mem_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "connections", :force => true do |t|
    t.integer  "requestor_id"
    t.integer  "target_id"
    t.integer  "status_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "doctors", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "practice_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "patients", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "ssn"
  end

  create_table "practice_memberships", :force => true do |t|
    t.integer  "practice_id"
    t.integer  "patient_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "practices", :force => true do |t|
    t.string   "office_name"
    t.string   "contact_name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "referrals", :force => true do |t|
    t.integer  "doctor_id"
    t.integer  "to_doctor"
    t.integer  "patient_id"
    t.text     "notes"
    t.integer  "status_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string   "status_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
