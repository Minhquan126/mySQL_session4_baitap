create database session3_thuchanh1;
use session3_thuchanh1;
CREATE TABLE Class
(
    ClassID   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ClassName VARCHAR(60) NOT NULL,
    StartDate DATETIME    default now(),
    Status    BIT
);
CREATE TABLE Student
(
    StudentId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(30) NOT NULL,
    Address     VARCHAR(50),
    Phone       VARCHAR(20),
    Status      BIT,
    ClassId     INT         NOT NULL,
    FOREIGN KEY (ClassId) REFERENCES Class (ClassID)
);
CREATE TABLE Subject
(
    SubId   INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubName VARCHAR(30) NOT NULL,
    Credit  TINYINT     NOT NULL DEFAULT 1 CHECK ( Credit >= 1 ),
    Status  BIT                  DEFAULT 1
);

CREATE TABLE Mark
(
    MarkId    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    SubId     INT NOT NULL,
    StudentId INT NOT NULL,
    Mark      FLOAT   DEFAULT 0 CHECK ( Mark BETWEEN 0 AND 100),
    ExamTimes TINYINT DEFAULT 1,
    UNIQUE (SubId, StudentId),
    FOREIGN KEY (SubId) REFERENCES Subject (SubId),
    FOREIGN KEY (StudentId) REFERENCES Student (StudentId)
);
insert into Class(ClassName,StartDate,Status) values
("A1","2022-11-11",1),
("A2","2023-10-11",1);
insert into Class(ClassName,Status) values
("B2",0);
insert into Student(StudentName,Address,phone,status,ClassId) values
("phuong","Ha Noi","092231231",1,2),
("hung","Ha Noi","0923123123",1,2);

insert into Subject(SubName,Credit) values
("HTML",5),
("CSS",5),
("JavaScript",10),
("PHP",10);
insert into Mark(SubId,StudentId,Mark,ExamTimes) values
(4,1,9,1),
(4,2,6,1),
(4,3,7,1),
(4,4,5,1),
(4,5,8,1);
select * from Student;
select * from Student where Status = true;
select * from Subject where Credit < 10;
select * from Student where ClassId = 1;
select Mark from Mark where SubId = 1;
select * from Student where StudentName like "h%";
select * from Class where month(StartDate) = 10;
select * from Subject where Credit > 3 and Credit <= 5;
update Student set ClassId = 2 where StudentName = "hung";
select StudentName,SubName,Mark from Subject join (Student join Mark on Student.StudentId = Mark.StudentId)
on Subject.SubId = Mark.SubId order by Mark desc, StudentName asc;
select * from Subject where Credit =  (select max(Credit) from Subject);
select Subject.* from Mark join Subject on Mark.SubId = Subject.SubId where Mark.Mark = (select max(Mark) from Mark);
select * from Mark;
select Student.*, avg(Mark) from Student join Mark on Student.StudentId = Mark.StudentId group by (StudentId) order by avg(Mark) desc;
