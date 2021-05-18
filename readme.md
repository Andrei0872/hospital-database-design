# Hospital Database Design

## Testing out

* docker-compose installed
* add how to run docker-compose & what comes after

## Tasks

### 1

> Descrierea modelului real, a utilității acestuia și a regulilor de funcționare.

Acest proiect urmareste realizarea design-ului unei baze de date a unui spital oarecare. Utilitatea acestui design este aceea ca se poate tine cu usurinta evidenta angajatilor(doctori, gardieni, receptionisti) din spital, dar si a altor obiecte: medicamente, sectiuni si cabinetele lor, prescriptii, diagnostice.

In ceea ce priveste organizarea, spitalul este impartit in sectiuni, iar fiecare sectiune exista un numar de cabinete in care doctorii isi desfasoara activitatea. In afara de doctori, in spital exista si gardieni si receptionisti. Doctorii pot face prescriptii si pot emite diagnostice pentru clientii spitalului.

### 2

> Prezentarea constrângerilor (restricții, reguli) impuse asupra modelului.

Fiecare prescriptie trebuie sa contina cel putin un medicament si este creata de catre un singur medic si destinata unui singur pacient.

Fiecare diagnostic este emis de un singur medic pentru un singur pacient.

Pentru o programare trebuie sa se cunoasca ID-ul doctorului si ID-ul pacientului.

Pentru fiecare angajat al spitalului se cunoaste programul sau de lucru.

### 3

> Descrierea entităților, incluzând precizarea cheii primare.

EMPLOYEE(id) - un angajat al spitalului, iar acesta poate fi de 3 tipuri: doctor, gardian, receptionist; pentru fiecare tip mentionat anterior exista un tabel

WORKING_SCHEDULE(employee_id) - programul de lucru al angajatilor; este un 'weak entity' intrucat depinde de entitatea 'EMPLOYEE'

CLIENT(cliend_id) - un client al spitalului

SECTION(name) - o sectie a spitalului; s-a ales numele sectiei drept cheie primara

ROOM(section_id, room_number) - un cabinet al unei sectii; este o cheie primara compusa, 'room_number' avand valori de la 1 la 'N', unde 'N' este numarul de cabinete dintr-o sectie; 'section_id' este cheia primara din tabelul 'SECTION'

MEDICATION(id) - un medicament; medicamentele apar in prescriptiile emise de medici

PRESCRIPTION(doctor_id, client_id, date) - o prescriptie; este facuta de catre un medic pentru un pacient; cheia primara este compusa deoarece o prescriptie este strans legata de medicul care a emis-o; cheia partiala este asadar 'date'(data la care s-a facut prescriptia), pentru a asigura unicitatea

DIAGNOSIS(doctor_id, client_id, date) - diagnosticul data de un doctor pentru un pacient, dar pentru ca acelasi medic poate da mai multe diagnostice aceluiasi pacient, este nevoie de o cheie partiala, 'date', pentru a asigura uncitatea

### 4

> Descrierea relațiilor, incluzând precizarea cardinalității acestora.

Intre tabelul 'EMPLOYEE' si tabelele 'DOCTOR', 'GUARDIAN' si 'RECEPTIONIST' exista cate o relatie de tipul 'ISA'.

Un **client** se poate programa la mai multi **medici** si un **medic** poate avea in grija mai multi **pacienti**('M-N').

Un **doctor** poate lucra intr-un singur **cabinet**, dar un **cabinet** poate avea mai multi **doctori**('1-N').

Un **cabinet** apartine unei **singure sectii**, dar o **sectie** poate contine mai multe **cabinete**('1-N').

Un **doctor** poate emite un numar nelimitat de **prescriptii**, dar o **prescriptie** poate fi emisa doar de un singur **doctor**('1-N').
Un **doctor** poate emite **prescriptii mai multor pacienti**, iar un **pacient** poate primi **prescriptii de la mai multi medici**('M-N').

Un **medicament** poate apartine mai multor **prescriptii**, iar o **prescriptie** poate contine mai multe **medicamente**('M-N').

Un **doctor** poate emite mai multe **diagnostice**, dar un **diagnostic** este emis doar de un singur **medic**('1-M').
Un **doctor** poate emite **diagnostice mai multor pacienti**, iar un **pacient** poate primi **diagnostice de la mai multi medici**('M-N').

### 5

> Descrierea atributelor, incluzând tipul de date și eventualele constrângeri, valori implicite, valori posibile ale atributelor.

* SECTION.NAME
* appointment.section_name


### 6

> Realizarea diagramei entitate-relație corespunzătoare descrierii de la punctele 3-5.

<div style="text-align: center;">
  <img src="./img/erd.jpg">
</div>

### 7
### 8
### 9
### 10
### 11
### 12
### 13
### 14