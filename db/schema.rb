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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140616230134) do

  create_table "academic_degrees", force: true do |t|
    t.string "name"
  end

  create_table "academic_informations", force: true do |t|
    t.datetime "b_date"
    t.datetime "e_date"
    t.text     "description"
    t.float    "grade"
    t.integer  "academic_degree_id"
    t.integer  "course_id"
    t.integer  "institution_id"
    t.integer  "teacher_id"
  end

  add_index "academic_informations", ["academic_degree_id"], name: "index_academic_informations_on_academic_degree_id"
  add_index "academic_informations", ["course_id"], name: "index_academic_informations_on_course_id"
  add_index "academic_informations", ["institution_id"], name: "index_academic_informations_on_institution_id"
  add_index "academic_informations", ["teacher_id"], name: "index_academic_informations_on_teacher_id"

  create_table "activities", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "b_date"
    t.datetime "e_date"
    t.text     "description"
    t.integer  "teacher_id"
    t.integer  "activity_type_id"
  end

  add_index "activities", ["activity_type_id"], name: "index_activities_on_activity_type_id"
  add_index "activities", ["teacher_id"], name: "index_activities_on_teacher_id"

  create_table "activity_types", force: true do |t|
    t.string "name"
  end

  create_table "authors", force: true do |t|
    t.string  "name"
    t.integer "publication_id"
  end

  add_index "authors", ["publication_id"], name: "index_authors_on_publication_id"

  create_table "cosupervisors", force: true do |t|
    t.string  "name"
    t.string  "institution"
    t.integer "teacher_id"
    t.integer "thesis_supervision_id"
  end

  add_index "cosupervisors", ["teacher_id"], name: "index_cosupervisors_on_teacher_id"
  add_index "cosupervisors", ["thesis_supervision_id"], name: "index_cosupervisors_on_thesis_supervision_id"

  create_table "courses", force: true do |t|
    t.string  "name"
    t.integer "institution_id"
  end

  add_index "courses", ["institution_id"], name: "index_courses_on_institution_id"

  create_table "deliverables", force: true do |t|
    t.string  "url"
    t.integer "publication_id"
  end

  add_index "deliverables", ["publication_id"], name: "index_deliverables_on_publication_id"

  create_table "editors", force: true do |t|
    t.string  "name"
    t.integer "publication_id"
  end

  add_index "editors", ["publication_id"], name: "index_editors_on_publication_id"

  create_table "entities", force: true do |t|
    t.string "name"
  end

  create_table "file_tags", force: true do |t|
    t.integer "file_id"
    t.integer "tag_id"
  end

  add_index "file_tags", ["file_id"], name: "index_file_tags_on_file_id"
  add_index "file_tags", ["tag_id"], name: "index_file_tags_on_tag_id"

  create_table "files", force: true do |t|
    t.string  "name"
    t.integer "folder_id"
    t.integer "subject_id"
  end

  add_index "files", ["folder_id"], name: "index_files_on_folder_id"
  add_index "files", ["subject_id"], name: "index_files_on_subject_id"

  create_table "folders", force: true do |t|
    t.string  "name"
    t.integer "folder_id"
    t.integer "subject_id"
  end

  add_index "folders", ["folder_id"], name: "index_folders_on_folder_id"
  add_index "folders", ["subject_id"], name: "index_folders_on_subject_id"

  create_table "hobbies", force: true do |t|
    t.string   "activity"
    t.datetime "b_date"
    t.datetime "e_date"
    t.text     "description"
    t.integer  "teacher_id"
  end

  add_index "hobbies", ["teacher_id"], name: "index_hobbies_on_teacher_id"

  create_table "institutions", force: true do |t|
    t.string "name"
  end

  create_table "managements", force: true do |t|
    t.datetime "b_date"
    t.datetime "e_date"
    t.text     "description"
    t.integer  "teacher_id"
    t.integer  "role_id"
    t.integer  "entity_id"
  end

  add_index "managements", ["entity_id"], name: "index_managements_on_entity_id"
  add_index "managements", ["role_id"], name: "index_managements_on_role_id"
  add_index "managements", ["teacher_id"], name: "index_managements_on_teacher_id"

  create_table "oai_pmh_requests", force: true do |t|
    t.string   "verb"
    t.string   "resumption_code"
    t.integer  "cursor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publication_types", force: true do |t|
    t.string "name"
  end

  create_table "publications", force: true do |t|
    t.string   "title"
    t.string   "chapter"
    t.string   "pages"
    t.string   "publisher"
    t.string   "doi"
    t.string   "volume"
    t.string   "isbn"
    t.string   "issn"
    t.datetime "date"
    t.string   "booktitle"
    t.string   "address"
    t.string   "uri"
    t.string   "journal"
    t.string   "number"
    t.string   "howpublished"
    t.string   "school"
    t.integer  "publication_type_id"
    t.integer  "teacher_id"
    t.integer  "research_project_id"
  end

  add_index "publications", ["publication_type_id"], name: "index_publications_on_publication_type_id"
  add_index "publications", ["research_project_id"], name: "index_publications_on_research_project_id"
  add_index "publications", ["teacher_id"], name: "index_publications_on_teacher_id"

  create_table "research_projects", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "b_date"
    t.datetime "e_date"
    t.text     "description"
    t.integer  "teacher_id"
  end

  add_index "research_projects", ["teacher_id"], name: "index_research_projects_on_teacher_id"

  create_table "roles", force: true do |t|
    t.string "name"
  end

  create_table "subjects", force: true do |t|
    t.string  "name"
    t.integer "students"
    t.string  "academic_year"
    t.text    "description"
    t.integer "course_id"
    t.integer "teacher_id"
  end

  add_index "subjects", ["course_id"], name: "index_subjects_on_course_id"
  add_index "subjects", ["teacher_id"], name: "index_subjects_on_teacher_id"

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "teachers", force: true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "status"
    t.string   "phone"
    t.datetime "birthday"
    t.string   "url"
    t.text     "bio"
    t.boolean  "registed"
    t.integer  "institution_id"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "teachers", ["email"], name: "index_teachers_on_email", unique: true
  add_index "teachers", ["institution_id"], name: "index_teachers_on_institution_id"
  add_index "teachers", ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true

  create_table "theses", force: true do |t|
    t.string  "title"
    t.string  "url"
    t.string  "student"
    t.integer "academic_degree_id"
    t.integer "institution_id"
  end

  add_index "theses", ["academic_degree_id"], name: "index_theses_on_academic_degree_id"
  add_index "theses", ["institution_id"], name: "index_theses_on_institution_id"

  create_table "thesis_examinations", force: true do |t|
    t.datetime "date"
    t.text     "description"
    t.integer  "thesis_id"
    t.integer  "teacher_id"
  end

  add_index "thesis_examinations", ["teacher_id"], name: "index_thesis_examinations_on_teacher_id"
  add_index "thesis_examinations", ["thesis_id"], name: "index_thesis_examinations_on_thesis_id"

  create_table "thesis_supervisions", force: true do |t|
    t.datetime "b_date"
    t.datetime "e_date"
    t.text     "description"
    t.integer  "teacher_id"
    t.integer  "thesis_id"
  end

  add_index "thesis_supervisions", ["teacher_id"], name: "index_thesis_supervisions_on_teacher_id"
  add_index "thesis_supervisions", ["thesis_id"], name: "index_thesis_supervisions_on_thesis_id"

  create_table "trigrams", force: true do |t|
    t.string  "trigram",     limit: 3
    t.integer "score",       limit: 2
    t.integer "owner_id"
    t.string  "owner_type"
    t.string  "fuzzy_field"
  end

  add_index "trigrams", ["owner_id", "owner_type", "fuzzy_field", "trigram", "score"], name: "index_for_match"
  add_index "trigrams", ["owner_id", "owner_type"], name: "index_by_owner"

end
