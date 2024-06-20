-- Fictionalized schema design for the University of Toronto Libraries

CREATE SCHEMA UTL;
USE UTL;

CREATE TABLE UTL.employees (
	employee_no BIGINT NOT NULL,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    department_name VARCHAR(45) NOT NULL,
    branch_name VARCHAR(45), 
    employee_type VARCHAR(45),
    SIN BIGINT NOT NULL,
    birth_date DATE,
    street_no BIGINT NOT NULL,
    street_name VARCHAR(100) NOT NULL,
    postal_code VARCHAR(6) NOT NULL,
    city VARCHAR(45) NOT NULL,
    salary DECIMAL (7,2) NOT NULL,
    email VARCHAR(70) NOT NULL,
    phone_no BIGINT NOT NULL,
    PRIMARY KEY (employee_no),
	UNIQUE (employee_no, SIN, phone_no));

INSERT INTO employees VALUES
(999888777, 'Bruce', 'Lanyon','Acquisitions','Robarts','Librarian',111222333,'1990-04-23',140,'Bloor St.','M1K4H6','Toronto', 78998.06,'ralph.lanyon@utoronto.ca',6471112222),
(999888778, 'Laurie', 'Odell','Rare Books','Robarts','Librarian',111222334,'1991-11-14',1450,'Ramona Dr.','A1J6H9','Toronto', 70905.68,'laurie.odell@utoronto.ca',6473334444),
(999888779, 'Andrew', 'Raynes','Reference Services','Robarts','Librarian',111222335,'1995-06-28',100,'Waverly Pl.','R1Y2J6','Toronto', 65546.35,'andrew.raynes@utoronto.ca',6475556666),
(999888780, 'Brittany', 'Kerr','Victoria College','EJ Pratt','Librarian',111222336,'1980-12-24',997,'St. George St.','M1U5T6','Toronto', 85119.56,'britanny.kerr@utoronto.ca',6477778888),
(999888781, 'Sarah', 'Li','Trinity College','Graham','Librarian',111222337,'1986-01-03',67,'Euclid St.','L1L4H8','Toronto', 81493.09,'sarah.li@utoronto.ca',6479990000);

CREATE TABLE UTL.department (
	department_name VARCHAR(60) NOT NULL,
    street_no BIGINT NOT NULL,
    street_name VARCHAR(100) NOT NULL,
    postal_code VARCHAR(6) NOT NULL,
    city VARCHAR(45) NOT NULL,
	associated_branch VARCHAR(60),
	department_head VARCHAR(45) NOT NULL,
    manager_id BIGINT NOT NULL,
	no_of_employees INT NOT NULL,
	PRIMARY KEY (department_name),
    UNIQUE (department_name, department_head));
    
INSERT INTO department VALUES
("Acquisitions", 130, "St. George St.", "M5S3H1", "Toronto","Robarts","Bruce Lanyon",12345,16),
("Rare Books", 130, "St. George St.", "M5S3H1", "Toronto","Robarts","Laurie Odell",12346,08),
("Reference Services", 130, "St. George St.", "M5S3H1", "Toronto","Robarts","Mary Sharp",11345,25),
("Victoria College", 71, "Queen's Park Cres. E", "M5S1K7", "Toronto","EJ Pratt","Brittany Kerr",104345,20),
("Trinity College", 3, "Devonshire Place", "M5S1H8", "Toronto","Graham","Sarah Li",543210,11);

CREATE TABLE UTL.branch (
	branch_name VARCHAR(60) NOT NULL,
    street_no BIGINT NOT NULL,
    street_name VARCHAR(100) NOT NULL,
    postal_code VARCHAR(6) NOT NULL,
    city VARCHAR(45) NOT NULL,
	banch_type VARCHAR(45),
	branch_librarian VARCHAR(45) NOT NULL,
    librarian_id BIGINT NOT NULL,
	faculty_association VARCHAR(45),
	no_of_employees INT NOT NULL,
	PRIMARY KEY (branch_name),
    UNIQUE (branch_name, branch_librarian));
    
INSERT INTO branch VALUES
("Robarts",130,"St. George St.","M5S3H1","Toronto","Central","Yves Grandier",999001,NULL,345),
("EJ Pratt",71,"Queen's Park Cres. E","M5S1K7","Toronto","Campus","Brittany Kerr",999002,NULL,20),
("Graham",3,"Devonshire Place","M5S1H8","Toronto","Campus","Sarah Li",999003,NULL,11),
("A.D. Allen Chemistry",80,"St. George St.","M5S3H6","Toronto","Campus","Pratik Parker",999004,"Chemistry",09),
("Bora Laskin Law",78,"Queen's Park.","M5S2C5","Toronto","Campus","Yolanda Steer",999005,"Law",23);

CREATE TABLE UTL.committee (
	committee_name VARCHAR(60) NOT NULL,
	committee_description VARCHAR(200),
	membership INT NOT NULL,
	leading_department VARCHAR(60) NOT NULL,
	meeting_frequency VARCHAR(45),
	PRIMARY KEY (committee_name),
    UNIQUE (committee_name, committee_description),
    FOREIGN KEY (leading_department) REFERENCES department (department_name));

INSERT INTO committee VALUES
("Library Council","A leading group for high-level librarian decisions",13,"Central Administration","Monthly"),
("Circulation Services","To discuss the future of circulation services",20,"Circulation","Bi-Monthly"),
("Web Advisory","A group to discuss how to provide web services",19,"Reference Services","Bi-Monthly"),
("E-Resource Learning","We meet monthly to talk about electronic resources at the library",09,"Acquisitions","Monthly"),
("Tri-Campus","High-level committee to discuss issues effecting all 3 U of T campuses",56,"Central Administration","Yearly");

CREATE TABLE UTL.project (
	project_name VARCHAR(60) NOT NULL,
	associated_department VARCHAR(60) NOT NULL,
	project_manager VARCHAR(60) NOT NULL,
    project_manager_id BIGINT NOT NULL,
	PRIMARY KEY (project_name),
    UNIQUE (project_name),
    FOREIGN KEY (associated_department) REFERENCES department (department_name),
    FOREIGN KEY (project_manager_id) REFERENCES employees (employee_no));

INSERT INTO project VALUES
("New Materials 2022","Acquisitions","Bruce Lanyon",999888777),
("2022 Access Initiative","Acquisitions","Bruce Lanyon",999888777),
("Rare Book Outreach 2021-2025","Rare Books","Laurie Odell",999888778),
("Canadiana Project","Rare Books","Laurie Odell",999888778),
("Trinity Revitalization","Trinity College","Sarah Li",999888781);

CREATE TABLE UTL.faculty (
	faculty_name VARCHAR(45) NOT NULL,
	liaison_librarian VARCHAR(60) NOT NULL,
    liaison_librarian_id BIGINT NOT NULL,
	street_no BIGINT NOT NULL,
    street_name VARCHAR(100) NOT NULL,
    postal_code VARCHAR(6) NOT NULL,
    city VARCHAR(45) NOT NULL,
	PRIMARY KEY (faculty_name),
    UNIQUE (faculty_name));

INSERT INTO faculty VALUES
("Information","George Groff",999007,140,"St. George St.","M5S3H1","Toronto"),
("Arts & Science","Leslie Smith",999009,100,"St. George St.","M5S3G3","Toronto"),
("Engineering","Bud Lyson",999008,35,"St. George St.","M5S1A4","Toronto"),
("Medicine","Julie Shu",999010,1,"King's College Cir","M5S1A8","Toronto"),
("Music","Erin Takoda",999011,80,"Queen's Park","M5S2C5","Toronto");

CREATE TABLE UTL.librarians (
    librarian_id BIGINT NOT NULL,
    employee_no BIGINT NOT NULL,
	branch_name VARCHAR(60) NOT NULL,
	PRIMARY KEY (librarian_id),
    UNIQUE (librarian_id, employee_no),
    FOREIGN KEY (employee_no) REFERENCES employees (employee_no),
    FOREIGN KEY (branch_name) REFERENCES branch (branch_name));

INSERT INTO librarians VALUES
(999023,999888777,"Robarts"),
(999024,999888778,"Robarts"),
(999025,999888781,"Graham"),
(999026,999888779,"Robarts"),
(999027,999888780,"EJ Pratt");

CREATE TABLE UTL.department_heads (
	manager_id BIGINT NOT NULL, 
    employee_no BIGINT NOT NULL,
    department_name VARCHAR(60) NOT NULL,
	PRIMARY KEY (manager_id),
    UNIQUE (manager_id, employee_no, department_name),
    FOREIGN KEY (employee_no) REFERENCES employees (employee_no),
    FOREIGN KEY (department_name) REFERENCES department (department_name));

INSERT INTO department_heads VALUES
(12345,999888777,"Acquisitions"),
(12346,999888778,"Rare Books"),
(11345,999888666,"Reference Services"),
(104345,999888780,"Victoria College"),
(543210,999888781,"Trinity College");

ALTER TABLE utl.employees 
ADD INDEX emp_department_name_idx (department_name ASC) VISIBLE,
ADD INDEX emp_branch_name_idx (branch_name ASC) VISIBLE;
ALTER TABLE utl.employees 
ADD CONSTRAINT emp_department_name
  FOREIGN KEY (department_name)
  REFERENCES utl.department (department_name)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT emp_branch_name
  FOREIGN KEY (branch_name)
  REFERENCES utl.branch (branch_name)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE utl.department 
ADD INDEX dept_branch_association_idx (associated_branch ASC) VISIBLE,
ADD INDEX dept_manager_id_idx (manager_id ASC) VISIBLE;
ALTER TABLE utl.department 
ADD CONSTRAINT dept_branch_association
  FOREIGN KEY (associated_branch)
  REFERENCES utl.branch (branch_name)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT dept_manager_id
  FOREIGN KEY (manager_id)
  REFERENCES utl.department_heads (manager_id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE utl.branch 
ADD INDEX branch_librarian_id_idx (librarian_id ASC) VISIBLE,
ADD INDEX branch_faculty_association_idx (faculty_association ASC) VISIBLE;
ALTER TABLE utl.branch 
ADD CONSTRAINT branch_librarian_id
  FOREIGN KEY (librarian_id)
  REFERENCES utl.librarians (librarian_id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT branch_faculty_association
  FOREIGN KEY (faculty_association)
  REFERENCES utl.faculty (faculty_name)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE utl.faculty 
ADD CONSTRAINT faculty_liaison_id
  FOREIGN KEY (liaison_librarian_id)
  REFERENCES utl.librarians (librarian_id)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;