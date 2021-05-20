create table `client` (
  cnp varchar(13) not null primary key,
  first_name varchar(100) not null,
  last_name varchar(100) not null,
  birthday date not null,
  age int not null,
);

create table `employee` (
  cnp varchar(13) not null primary key,
  first_name varchar(100) not null,
  last_name varchar(100) not null,
  started_at date not null,
  salary int not null,
  is_active boolean
);

create table `working_schedule` (
  cnp varchar(13) not null ,
  start_at date,
  end_at date,

  foreign key(cnp) references employee(cnp)
);

create table `doctor` (
  cnp varchar(13) not null,
  specialization varchar(100) not null,

  foreign key(cnp) references employee(cnp)
);

create table `guardian` (
  cnp varchar(13) not null,
  has_qualification boolean

  foreign key(cnp) references employee(cnp)
);

create table `receptionist` (
  cnp varchar(13) not null,
  knows_foreign_languages boolean,

  foreign key(cnp) references employee(cnp)
);

create table `section` (
  name varchar(100) not null primary key,
  nr_rooms int not null
);

create table `room` (
  section_name varchar(100) not null,
  room_number int not null,
  nr_beds int not null,

  foreign key(section_name) references section(name)
);

-- Junction table
create table `doctor_room` (
  cnp varchar(13) not null,
  section_name varchar(100) not null,
  room_number int not null,
  start_at date,
  end_at date,

  foreign key(cnp) references person(cnp),
  foreign key(section_name) references room(section_name),
  foreign key(room_number) references room(room_number),
);

create table `medication` (
  id int not null primary key,
  name varchar(100) not null unique,
  provider_name varchar(100) not null unique,
  weight int not null,
);

create table `prescription` (
  id int not null primary key,
  doctor_id varchar(13) not null,
  client_id varchar(13) not null,
  title varchar(100) not null,

  foreign key(doctor_id) references doctor(cnp),
  foreign key(client_id) references client(cnp),
);

-- Junction table
create table `prescription_medication` (
  prescription_id int not null,
  medication_id int not null,

  foreign key(prescription_id) references prescription(id),
  foreign key(medication_id) references medication(id)
);

create table `diagnosis` (
  doctor_id varchar(13) not null,
  client_id varchar(13) not null,
  title varchar(100) not null,
  description varchar(100) not null,

  foreign key(doctor_id) references doctor(id),
  foreign key(client_id) references client(cnp)
);

-- Junction table
create table `appointment` (
  doctor_id varchar(13) not null,
  client_id varchar(13) not null,
  section_name varchar(100) not null,
  room_number int not null,
  start_at date,
  end_at date,

  foreign key(doctor_id) references doctor(cnp),
  foreign key(client_id) references client(cnp),
  foreign key(section_name) references room(section_name),
  foreign key(room_number) references room(room_number)
);