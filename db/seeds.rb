# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


###############################
#
# DB Seeds -
#
###############################
#
# => Suppose to use the App as Cape Cod Medical Practice
#
User.destroy_all
Practice.destroy_all
PracticeMembership.destroy_all
Appointment.destroy_all
Connection.destroy_all
Patient.destroy_all
Referral.destroy_all

######Practices

ccm = Practice.create(:office_name => "Cape Cod Medical Practice",
        :contact_name => "Margery Hunt",
        :phone => "508-360-4170",
        :email => "margery@ccm.com")
bm = Practice.create(:office_name => "Boston Medical",
        :contact_name => "David Stad",
        :phone =>"978-360-3212",
        :email => "david@bm.com")
bp = Practice.create(:office_name =>"Barnstable Pediatrics",
        :contact_name => "Stan Marsh",
        :phone =>"343-465-9843",
        :email => "stan@barnstablep.com")
pch = Practice.create(:office_name => "Plymouth Community Health",
        :contact_name => "Eric Estrada",
        :phone => "454-546-0983",
        :email =>"eric@plymouthch.com")
bhs = Practice.create(:office_name => "Bourne Health Specialists",
        :contact_name =>"Sean Geary",
        :phone => "123-321-4321",
        :email => "sean@bournehs.com")
co = Practice.create(:office_name => "Cape Optometry",
        :contact_name => "Sam Fisher",
        :phone => "325-543-6543",
        :email =>"sam@capeo.com")


####Practice Doctors

  #### Cape Cod Medical Practice

  ccm.users.create(:first_name =>"Matt",
      :last_name => "Maloney",
      :email => "matt@ccm.com",
      :password =>"password").make_admin
  ccm.users.create(:first_name =>"Carl",
      :last_name =>"Banks",
      :email =>"carl@ccm.com",
      :password =>"password")
  ccm.users.create(:first_name => "Joe",
      :last_name => "McCarthy",
      :email => "joe@ccm.com",
      :password => "password")
  #### Boston Medical
  bm.users.create(:first_name =>"Jared",
      :last_name =>"Smith",
      :email =>"jared@bm.com",
      :password => "password").make_admin
  bm.users.create(:first_name =>"John",
      :last_name =>"Smit",
      :email =>"john@bm.com",
      :password => "password").make_admin
  bm.users.create(:first_name =>"Maggie",
      :last_name =>"Tao",
      :email =>"maggie@bm.com",
      :password => "password")
  bm.users.create(:first_name =>"Stephanie",
      :last_name =>"Lau",
      :email =>"Stephanie@bm.com",
      :password => "password")
  #### Barnstable Pediatrics
  bp.users.create(:first_name =>"George",
      :last_name =>"Washington",
      :email =>"george@barnstablep.com",
      :password => "password").make_admin
  bp.users.create(:first_name =>"Bob",
      :last_name =>"Loblaw",
      :email =>"loblaw@barnstablep.com",
      :password => "password")
  #### Plymouth Community Health
  pch.users.create(:first_name =>"Samson",
      :last_name => "Waters",
      :email => "samson@plymouthch.com",
      :password =>"password").make_admin
  pch.users.create(:first_name =>"Sidney",
    :last_name => "Waters",
    :email => "sidneyn@plymouthch.com",
    :password =>"password").make_admin
  pch.users.create(:first_name =>"Sheldon",
    :last_name => "Smalls",
    :email => "sheldon@plymouthch.com",
    :password =>"password")
  pch.users.create(:first_name =>"Squanto",
    :last_name => "Radkowski",
    :email => "sq@plymouthch.com",
    :password =>"password")
  #### Bourne Health Specialists
  bhs.users.create(:first_name => "Elizabeth",
    :last_name => "Duke",
    :email => "Elizabeth@bournehs.com",
    :password =>"password").make_admin
  bhs.users.create(:first_name => "Laurnce",
    :last_name => "Bellotta",
    :email => "larry@bournehs.com",
    :password =>"password")
  bhs.users.create(:first_name => "Quin",
    :last_name => "Smith",
    :email => "quin@bournehs.com",
    :password =>"password")
  #### Cape optometry
  co.users.create(:first_name =>"Garth",
    :last_name => "Garafalo",
    :email => "garth@capeo.com",
    :password => "password").make_admin
  co.users.create(:first_name => "Lance",
    :last_name =>"Armstrong",
    :email => "lance@capeo.com",
    :password =>"password")

### Connections For Cape Cod Medical CCM
  ccm.connections_as_requestor.create(
    :target_id => bm.id,
    :status_type => "Accepted")
  ccm.connections_as_requestor.create(
    :target_id => bp.id,
    :status_type =>"Accepted")
  ccm.connections_as_requestor.create(
    :target_id => pch.id,
    :status_type =>"Accepted")
  ccm.connections_as_target.create(
    :requestor_id => bhs.id)
  ccm.connections_as_target.create(
    :requestor_id => co.id,
    :status_type =>"Accepted")

### Patients And Appointments for Cape Cod Medical
  ccm.patients.create(:first_name =>"Clint", :last_name =>"Westwood", :ssn =>"1234")


  ccm.patients.create(:first_name =>"Cap",
    :last_name =>"Sands",
    :ssn =>"1234")
  ccm.patients.create(:first_name =>"Guy",
    :last_name =>"Sierra",
    :ssn =>"1554")
  ccm.patients.create(:first_name =>"Gabe",
    :last_name =>"Newell",
    :ssn =>"1224")
  ccm.patients.create(:first_name =>"Karen",
    :last_name =>"Glasto",
    :ssn =>"1089")
  3.times do
    Practice.all.each do |practice|
      drs = practice.users
      practice.patients.each do |pt|
        #if pt.practice_memberships.exi
        pm = pt.practice_memberships.find_or_create_by_practice_id(practice.id) #create(practice_id: practice.id)
        dr =  drs.sample#drs.shift()
        appt = Appointment.create(prac_mem_id: pm.id, date: Time.now + rand(30).days, user_id: dr.id)
        appt2 = Appointment.create(prac_mem_id: pm.id, date: Time.now - rand(90).days, user_id: dr.id)
        #drs.push(dr)
      end
    end
  end

### Patients for other Practices
### Generating array of possible first and last names
first_n = ['Meg','Ryan','Fallon','Erin','Danny', 'Mike', 'Chris','Judy','Paul','Tim']
last_n = ['Lee','McGuire','Fallon','McLaughlin','Radkowski','Eckhardt','Ruderman','Parker','Seara','Lile']

###Boston Medical
  7.times do
    bm.patients.create(first_name: first_n.sample,last_name: last_n.sample, ssn:rand(9999))
  end

  bm.patients.each do |pt|
    pm = pt.practice_memberships.find_or_create_by_practice_id(bm.id)
    dr = bm.users.sample
    appt = Appointment.create(prac_mem_id: pm.id, date: Time.now + rand(30).days, user_id: dr.id)
    appt2 = Appointment.create(prac_mem_id: pm.id, date: Time.now - rand(90).days, user_id: dr.id)
  end

###Barnstable Pediatrics
  6.times do
    bp.patients.create(first_name: first_n.sample,last_name: last_n.sample, ssn:rand(9999))
  end

  bp.patients.each do |pt|
    pm = pt.practice_memberships.find_or_create_by_practice_id(bp.id)
    dr = bp.users.sample
    appt = Appointment.create(prac_mem_id: pm.id, date: Time.now + rand(30).days, user_id: dr.id)
    appt2 = Appointment.create(prac_mem_id: pm.id, date: Time.now - rand(90).days, user_id: dr.id)
  end

###Plymouth Community Health
  5.times do
    pch.patients.create(first_name: first_n.sample,last_name: last_n.sample, ssn:rand(9999))
  end

  pch.patients.each do |pt|
    pm = pt.practice_memberships.find_or_create_by_practice_id(pch.id)
    dr = pch.users.sample
    appt = Appointment.create(prac_mem_id: pm.id, date: Time.now + rand(30).days, user_id: dr.id)
    appt2 = Appointment.create(prac_mem_id: pm.id, date: Time.now - rand(90).days, user_id: dr.id)
  end

###Bourne Health Specialist
 6.times do
    bhs.patients.create(first_name: first_n.sample,last_name: last_n.sample, ssn:rand(9999))
  end

  bhs.patients.each do |pt|
    pm = pt.practice_memberships.find_or_create_by_practice_id(bhs.id)
    dr = bhs.users.sample
    appt = Appointment.create(prac_mem_id: pm.id, date: Time.now + rand(30).days, user_id: dr.id)
    appt2 = Appointment.create(prac_mem_id: pm.id, date: Time.now - rand(90).days, user_id: dr.id)
  end

###Cape Optometry
  4.times do
    co.patients.create(first_name: first_n.sample,last_name: last_n.sample, ssn:rand(9999))
  end

  co.patients.each do |pt|
    pm = pt.practice_memberships.find_or_create_by_practice_id(co.id)
    dr = co.users.sample
    appt = Appointment.create(prac_mem_id: pm.id, date: Time.now + rand(30).days, user_id: dr.id)
    appt2 = Appointment.create(prac_mem_id: pm.id, date: Time.now - rand(90).days, user_id: dr.id)
  end

### Referrals for Cape Cod Medical
### get all pracs but cape Medical
ref_notes = ['Specialist Care Required','Needs attention','Lower back pain','Rash','Broken Wrist','Physical Therapy','Strained Back', 'Chronic Headaches',nil,nil,nil,nil,nil,nil]

pracs = Practice.find(:all, :conditions => ["id NOT IN (?)", [ccm.id, bhs.id]])
10.times do
  pracs.each do |practice|
    drs = practice.users
    pats = practice.patients
    drs.each do |ref|
      r = Referral.create(user_id: ref.id,to_user: ccm.users.sample.id, patient_id: pats.sample.id, notes: ref_notes.sample)
      r.update_attribute :created_at, Time.now - rand(120).days
    end
 end
end

### Send referrals from Cape Cod Medical

40.times do
  r = Referral.create(user_id: ccm.users.sample.id, to_user: pracs.sample.users.sample.id,patient_id: ccm.patients.sample.id, notes: ref_notes.sample)
  r.update_attribute :created_at, Time.now - rand(120).days
end

### Make Appointments from received Referrals

ccm.received_referrals[0..15].each do |ref|
  patient = Patient.find(ref.patient_id)
  dr = ccm.users.sample
  pm = patient.practice_memberships.find_or_create_by_practice_id(ccm.id)
  appt = Appointment.create(prac_mem_id: pm.id, date: Time.now + rand(30).days, user_id: dr.id)
end




