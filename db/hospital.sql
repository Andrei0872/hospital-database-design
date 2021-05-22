use hospital;

-- CREATING TABLES

create table `client` (
  cnp varchar(13) not null primary key,
  first_name varchar(100) not null,
  last_name varchar(100) not null,
  birthday date not null,
  age int not null
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
  start_at time,
  end_at time,

  foreign key(cnp) references employee(cnp)
);

create table `doctor` (
  cnp varchar(13) not null,
  specialization varchar(100) not null,

  foreign key(cnp) references employee(cnp)
);

create table `guardian` (
  cnp varchar(13) not null,
  has_qualification boolean,

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
  room_number int not null references room(room_number),
  start_at time,
  end_at time,

  foreign key(cnp) references doctor(cnp),
  foreign key(section_name) references section(name)
);

create table `medication` (
  id int not null primary key auto_increment,
  name varchar(100) not null unique,
  provider_name varchar(100) not null,
  weight int not null
);

create table `prescription` (
  id int not null primary key auto_increment,
  doctor_id varchar(13) not null,
  client_id varchar(13) not null,
  title varchar(100) not null,

  foreign key(doctor_id) references doctor(cnp),
  foreign key(client_id) references client(cnp)
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

  foreign key(doctor_id) references doctor(cnp),
  foreign key(client_id) references client(cnp)
);

-- Junction table
create table `appointment` (
  doctor_id varchar(13) not null,
  client_id varchar(13) not null,
  occurred_at date,
  start_at time,
  end_at time,

  foreign key(doctor_id) references doctor(cnp),
  foreign key(client_id) references client(cnp)
);

-- INSERTING DATA

insert into client(cnp, first_name, last_name, birthday, age)
values('CC111', 'FirstName1', 'LastName1', date_sub(CURRENT_DATE, interval 20 year), 20),
      ('CC222', 'FirstName2', 'LastName2', date_sub(CURRENT_DATE, interval 15 year), 15),
      ('CC333', 'FirstName3', 'LastName3', date_sub(CURRENT_DATE, interval 23 year), 23),
      ('CC444', 'FirstName4', 'LastName4', date_sub(CURRENT_DATE, interval 37 year), 37),
      ('CC555', 'FirstName5', 'LastName5', date_sub(CURRENT_DATE, interval 42 year), 42);

insert into employee(cnp, first_name, last_name, started_at, salary, is_active)
values('EE111', 'EmployeeFirstName1', 'EmployeeLastName1', date_sub(CURRENT_DATE, interval 4 year), 5400, 1),
      ('EE222', 'EmployeeFirstName2', 'EmployeeLastName2', date_sub(CURRENT_DATE, interval 10 year), 7000, 1),
      ('EE333', 'EmployeeFirstName3', 'EmployeeLastName3', date_sub(CURRENT_DATE, interval 3 month), 4000, 1),
      ('EE444', 'EmployeeFirstName4', 'EmployeeLastName4', date_sub(CURRENT_DATE, interval 6 year), 5500, 1),
      ('EE555', 'EmployeeFirstName5', 'EmployeeLastName5', date_sub(CURRENT_DATE, interval 5 year), 3000, 1),
      ('EE666', 'EmployeeFirstName6', 'EmployeeLastName6', date_sub(CURRENT_DATE, interval 10 month), 3000, 1), -- Guardian
      ('EE777', 'EmployeeFirstName7', 'EmployeeLastName7', date_sub(CURRENT_DATE, interval 2 year), 3200, 1), -- Receptionist
      ('EE888', 'EmployeeFirstName8', 'EmployeeLastName8', date_sub(CURRENT_DATE, interval 1 year), 5000, 1),
      ('EE999', 'EmployeeFirstName9', 'EmployeeLastName9', date_sub(CURRENT_DATE, interval 3 year), 4000, 1); -- Guardian

insert into working_schedule(cnp, start_at, end_at)
values('EE111', '09:00', '17:00'),
      ('EE222', '09:00', '19:00'),
      ('EE333', '10:00', '18:00'),
      ('EE444', '10:00', '18:00'),
      ('EE555', '12:00', '20:00'),
      ('EE666', '08:00', '20:00'),
      ('EE777', '09:00', '17:00'),
      ('EE888', '09:00', '17:00'),
      ('EE999', '20:00', '08:00');

insert into doctor(cnp, specialization)
values('EE111', 'cardiology'),
      ('EE222', 'neurosurgery'),
      ('EE333', 'ophthalmology'),
      ('EE444', 'hematology'),
      ('EE555', 'pulmonology'),
      ('EE888', 'hematology');

insert into guardian(cnp, has_qualification)
values('EE666', 1),
      ('EE999', 1);

insert into receptionist(cnp, knows_foreign_languages)
values('EE777', 1);

insert into section(name, nr_rooms)
values('cardiology', 4),
      ('neurosurgery', 2),
      ('ophthalmology', 2),
      ('pulmonology', 3),
      ('hematology', 5);

insert into room
values('cardiology', 1, 3),
      ('cardiology', 2, 2),
      ('cardiology', 3, 4),
      ('cardiology', 4, 2),
    
      ('neurosurgery', 1, 2),
      ('neurosurgery', 2, 2),

      ('ophthalmology', 1, 3),
      ('ophthalmology', 2, 2),

      ('pulmonology', 1, 2),
      ('pulmonology', 2, 3),
      ('pulmonology', 3, 3),

      ('hematology', 1, 2),
      ('hematology', 2, 2),
      ('hematology', 3, 3),
      ('hematology', 4, 4),
      ('hematology', 5, 3);

insert into doctor_room
values('EE111', 'cardiology', 1, '09:00', '17:00'),
      ('EE222', 'neurosurgery', 1, '09:00', '19:00'),
      ('EE333', 'ophthalmology', 2, '10:00', '18:00'),
      ('EE444', 'hematology', 3, '10:00', '14:00'),
      ('EE555', 'pulmonology', 1, '12:00', '20:00'),
      ('EE888', 'hematology', 3, '14:00', '17:00');

insert into medication(name, provider_name, weight)
values('med-1', 'provider-X', 50),
      ('med-2', 'provider-Y', 10),
      ('med-3', 'provider-X', 5),
      ('med-4', 'provider-X', 12),
      ('med-5', 'provider-Y', 7),
      ('med-6', 'provider-W', 20),
      ('med-7', 'provider-B', 50),
      ('med-8', 'provider-W', 30),
      ('med-9', 'provider-B', 27),
      ('med-10', 'provider-A', 100),
      ('med-11', 'provider-A', 30);

insert into prescription(doctor_id, client_id, title)
values('EE111', 'CC333', 'Prescription for ABC'),
      ('EE222', 'CC333', 'Prescription for XYZ'),
      ('EE333', 'CC222', 'Prescription for ABCD'),
      ('EE444', 'CC111', 'Prescription for X'),
      ('EE555', 'CC444', 'Prescription for Y'),
      ('EE888', 'CC555', 'Prescription for Z'),
      ('EE888', 'CC555', 'Prescription for ZX');

insert into prescription_medication(prescription_id, medication_id)
values(3, 1),
      (3, 2),
      (1, 1),
      (2, 5),
      (2, 6),
      (2, 7),
      (3, 6),
      (3, 8),
      (3, 9),
      (4, 1),
      (4, 10),
      (4, 11),
      (5, 9),
      (5, 10),
      (6, 3),
      (6, 4),
      (6, 5),
      (6, 6),
      (6, 7),
      (7, 1),
      (7, 8),
      (7, 9),
      (7, 11);

insert into diagnosis(doctor_id, client_id, title, description)
values('EE111', 'CC333', 'Diagnosis title A', 'Some description here...'),
      ('EE222', 'CC333', 'Diagnosis title B', 'Some description here...'),
      ('EE333', 'CC222', 'Diagnosis title C', 'Some description here...'),
      ('EE444', 'CC111', 'Diagnosis title D', 'Some description here...'),
      ('EE555', 'CC444', 'Diagnosis title E', 'Some description here...'),
      ('EE888', 'CC555', 'Diagnosis title F', 'Some description here...'),
      ('EE888', 'CC555', 'Diagnosis title G', 'Some description here...');

insert into appointment(doctor_id, client_id, occurred_at, start_at, end_at)
values('EE111', 'CC333', date_sub(CURRENT_DATE, interval 5 month), '10:30', '11:20'),
      ('EE222', 'CC333', date_sub(CURRENT_DATE, interval 10 month), '14:00', '15:00'),
      ('EE333', 'CC222', date_sub(CURRENT_DATE, interval 3 month), '14:30', '15:00'),
      ('EE444', 'CC111', date_sub(CURRENT_DATE, interval 3 month), '16:00', '17:00'),
      ('EE555', 'CC444', date_sub(CURRENT_DATE, interval 7 month), '10:45', '11:45'),
      ('EE888', 'CC555', date_sub(CURRENT_DATE, interval 11 month) ,'9:50', '11:20');