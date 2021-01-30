DROP TABLE IF EXISTS Professor;
DROP TABLE IF EXISTS Dept;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Graduate;
DROP TABLE IF EXISTS work_in;
DROP TABLE IF EXISTS work_dept;
DROP TABLE IF EXISTS work_proj;
DROP TABLE IF EXISTS Place;
DROP TABLE IF EXISTS Telephone;
DROP TABLE IF EXISTS Lives;
DROP TABLE IF EXISTS Musicians;
DROP TABLE IF EXISTS Plays;
DROP TABLE IF EXISTS Instrument;
DROP TABLE IF EXISTS Perform;
DROP TABLE IF EXISTS Songs;
DROP TABLE IF EXISTS Album;


CREATE TABLE Professor (snn CHAR(11), Name text, age INTEGER, rank INTEGER, specialty text,
	PRIMARY KEY(ssn)
	);
CREATE TABLE Dept (dno CHAR(11), dname text, office text, ssn CHAR(11),
	PRIMARY KEY(dno),
	FOREIGN KEY (ssn) REFERENCES Professor(ssn) ON DELETE SET DEFAULT "School Board"
	);
CREATE TABLE Project (pno CHAR(11), sponsor text, start_date text, end_date text, budget float, prof_superviser CHAR(11),
 	PRIMARY KEY(pno),
	FOREIGN KEY (ssn) REFERENCES Professor(ssn) ON DELETE CASCADE,
	FOREIGN KEY (prof_superviser) REFERENCES Professor(SSN) ON DELETE CASCADE 
	);
CREATE TABLE Graduate (SSN CHAR(11), advisor CHAR(11), name text, age INTEGER, deg_pg text, prof_superviser CHAR(11),
	PRIMARY KEY(SSN),
	FOREIGN KEY (dno) REFERENCES Dept(dno) ON DELETE SET DEFAULT "lost student",
	FOREIGN KEY (advisor) REFERENCES Graduate(SSN) ON DELETE SET DEFAULT "next student",
	FOREIGN KEY (prof_superviser) REFERENCES Professor(SSN) ON DELETE SET DEFAULT "New superviser"
	);
CREATE TABLE work_in(ssn CHAR(11), pno CHAR(11),
	PRIMARY KEY(ssn,pno),
	FOREIGN KEY (ssn) REFERENCES Professor(ssn),
	FOREIGN KEY (pno) REFERENCES Project(pno)
	);
CREATE TABLE work_dept(snn CHAR(11), dno CHAR(11), time_pc float,
	PRIMARY KEY(ssn,dno),
	FOREIGN KEY (ssn) REFERENCES Professor(ssn),
	FOREIGN KEY (dno) REFERENCES Dept(dno)
	);
CREATE TABLE work_proj(pno CHAR(11), SSN CHAR(11), since float,
	PRIMARY KEY(pno, SSN),
	FOREIGN KEY (pno) REFERENCES Project(pno),
	FOREIGN KEY (SSN) REFERENCES Graduate(SSN)
	);

-If a projessor is deleted the project they was managing is deleted
-If a professor is deleted the department they was running is set to "school board" who takes over
-If a professor is deleted the project they was supervising is deleted
-If a professor is deleted the student they was superiving is set to "new superviser"
-If a graduate is deleted the student they were advising is set to "next student"

- manditory "one or more relations" must be defined elsewhere(in code). You can take it 
-as "many" instead, with "one or more" enforced elsewhere. 
-affected work_in, work_dept, advise, major, supervise.

CREATE TABLE Musicians(ssn CHAR(11), name text,
	PRIMARY KEY(ssn),
	);
CREATE TABLE Album(albumIdentifier CHAR(11), copyrightDate text, speed float, title text, ssn CHAR(11),
	PRIMARY KEY(albumIdentifier),
	FOREIGN KEY (ssn) REFERENCES Musicians(ssn) ON DELETE NO ACTION
	);
CREATE TABLE Songs(songId CHAR(11), title text, author text, albumIdentifier CHAR(11),
	PRIMARY KEY(songId),
	FOREIGN KEY (albumIdentifier) REFERENCES Album(albumIdentifier) ON DELETE CASCADE
	);
CREATE TABLE Instrument(instrId CHAR(11), dname text, key text,
	PRIMARY KEY(instrId),
	);
CREATE TABLE Place(address text,
	PRIMARY KEY(address),
	);
CREATE TABLE Telephone(phone_no text, address text,
	PRIMARY KEY(address),
	FOREIGN KEY (address) REFERENCES Place(address) ON DELETE CASCADE,
	);
CREATE TABLE Plays(instrId CHAR(11), ssn CHAR(11),
	PRIMARY KEY(instId, ssn),
	FOREIGN KEY (instId) REFERENCES Instrument(instId),
	FOREIGN KEY (ssn) REFERENCES Musicians(ssn)
	);
CREATE TABLE Perform(ssn CHAR(11),songId CHAR(11),
	PRIMARY KEY(ssn, songId),
	FOREIGN KEY (ssn) REFERENCES Musicians(ssn),
	FOREIGN KEY (songId) REFERENCES Songs(songId)
	);
Create Table Lives(ssn CHAR(11), address text,
	PRIMARY KEY(ssn address);
	FOREIGN KEY (ssn) REFERENCES Musicians(ssn),
	FOREIGN KEY (text) REFERENCES Place(text)
	);


-If an album is deleted all the songs that were in it are deleted.
-If a can't be deleted from the database without first removing the albums that they produced.
-If a place is deleted we also delete the telephone number associated with that place.