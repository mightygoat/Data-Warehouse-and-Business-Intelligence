/*
Created: 10/5/2016
Modified: 10/19/2016
Model: Microsoft SQL Server 2016
Database: MS SQL Server 2016
*/


-- Create schemas section -------------------------------------------------

CREATE SCHEMA [Student]
go

CREATE SCHEMA [Department]
go

CREATE SCHEMA [Course]
go

CREATE SCHEMA [Section]
go

CREATE SCHEMA [Grade]
go

-- Create tables section -------------------------------------------------

-- Table Student.Student_Address

CREATE TABLE [Student].[Student_Address]
(
 [AddressID] Int NOT NULL,
 [City] Varchar(100) NULL,
 [Zip] Char(5) NOT NULL,
 [AddressType] Int NOT NULL,
 [State] Varchar(50) NOT NULL,
 [SocialSecurityNumber] Int NOT NULL
)
ON [Primary]
go

-- Add keys for table Student.Student_Address

ALTER TABLE [Student].[Student_Address] ADD CONSTRAINT [Key11] PRIMARY KEY NONCLUSTERED ([AddressID],[SocialSecurityNumber])
go

ALTER TABLE [Student].[Student_Address] ADD CONSTRAINT [AddressID] UNIQUE ([AddressID])
go

-- Table Student.Student_Contact

CREATE TABLE [Student].[Student_Contact]
(
 [PhoneNumber] Int NOT NULL,
 [PhoneNumberType] Varchar(15) NULL,
 [StudentNumber] Int NOT NULL
)
ON [Primary]
go
EXEC sp_addextendedproperty 'MS_Description', 'Permanent Phone number and Current Phone number ', 'SCHEMA', 'Student', 'TABLE', 'Student_Contact', 'COLUMN', 'PhoneNumberType'
go

-- Add keys for table Student.Student_Contact

ALTER TABLE [Student].[Student_Contact] ADD CONSTRAINT [Key20] PRIMARY KEY NONCLUSTERED ([StudentNumber])
go

ALTER TABLE [Student].[Student_Contact] ADD CONSTRAINT [PhoneNumber] UNIQUE ([PhoneNumber])
go

ALTER TABLE [Student].[Student_Contact] ADD CONSTRAINT [StudentNumber1] UNIQUE ([StudentNumber])
go

-- Table Student.Student_Personal_Details

CREATE TABLE [Student].[Student_Personal_Details]
(
 [StudentName] Varchar(50) NOT NULL,
 [SocialSecurityNumber] Int NOT NULL,
 [birthdate] Date NULL,
 [Gender] Char(1) NULL,
 [StudentNumber] Int NOT NULL
)
ON [Primary]
go
EXEC sp_addextendedproperty 'MS_Description', '''F'' or ''M''', 'SCHEMA', 'Student', 'TABLE', 'Student_Personal_Details', 'COLUMN', 'Gender'
go

-- Add keys for table Student.Student_Personal_Details

ALTER TABLE [Student].[Student_Personal_Details] ADD CONSTRAINT [Key21] PRIMARY KEY ([SocialSecurityNumber])
go

ALTER TABLE [Student].[Student_Personal_Details] ADD CONSTRAINT [SocialSecurityNumber] UNIQUE ([SocialSecurityNumber])
go

ALTER TABLE [Student].[Student_Personal_Details] ADD CONSTRAINT [StudentNumber] UNIQUE ([StudentNumber])
go

-- Table Student.Student_Details

CREATE TABLE [Student].[Student_Details]
(
 [StudentNumber] Int NOT NULL,
 [Class] Char(20) NOT NULL,
 [MajorDepartment] Char(50) NOT NULL,
 [MinorDepartment] Char(50) NULL,
 [DegreeProgram] Char(50) NOT NULL,
 [SocialSecurityNumber] Int NOT NULL
)
ON [Primary]
go
EXEC sp_addextendedproperty 'MS_Description', 'class (freshman, sophomore, ..., graduate)', 'SCHEMA', 'Student', 'TABLE', 'Student_Details', 'COLUMN', 'Class'
go

-- Add keys for table Student.Student_Details

ALTER TABLE [Student].[Student_Details] ADD CONSTRAINT [Key22] PRIMARY KEY NONCLUSTERED ([StudentNumber])
go

ALTER TABLE [Student].[Student_Details] ADD CONSTRAINT [SocialSecurityNumber1] UNIQUE ([SocialSecurityNumber])
go

ALTER TABLE [Student].[Student_Details] ADD CONSTRAINT [StudentNumber2] UNIQUE ([StudentNumber])
go

-- Table Department.Department_Details

CREATE TABLE [Department].[Department_Details]
(
 [DepartmentName] Char(50) NULL,
 [DepartmentCode] Int NOT NULL,
 [College] Char(50) NOT NULL,
 [Offering] Char(50) NOT NULL,
 [StudentNumber] Int NOT NULL
)
ON [Primary]
go

-- Add keys for table Department.Department_Details

ALTER TABLE [Department].[Department_Details] ADD CONSTRAINT [Key23] PRIMARY KEY NONCLUSTERED ([DepartmentCode],[StudentNumber])
go

ALTER TABLE [Department].[Department_Details] ADD CONSTRAINT [DepartmentCode1] UNIQUE ([DepartmentCode])
go

-- Table Department.Department_Contact

CREATE TABLE [Department].[Department_Contact]
(
 [OfficeNumber] Nchar(20) NULL,
 [OfficePhone] Nchar(10) NULL,
 [DepartmentCode] Int NOT NULL
)
ON [Primary]
go

-- Add keys for table Department.Department_Contact

ALTER TABLE [Department].[Department_Contact] ADD CONSTRAINT [Key24] PRIMARY KEY NONCLUSTERED ([DepartmentCode])
go

ALTER TABLE [Department].[Department_Contact] ADD CONSTRAINT [DepartmentCode] UNIQUE ([DepartmentCode])
go

-- Table Course.Course

CREATE TABLE [Course].[Course]
(
 [CourseName] Char(20) NOT NULL,
 [Description] Char(50) NULL,
 [CourseNumber] Int NOT NULL,
 [Offering] Char(20) NOT NULL,
 [DepartmentCode] Int NOT NULL,
 [StudentNumber] Int NOT NULL
)
ON [Primary]
go

-- Add keys for table Course.Course

ALTER TABLE [Course].[Course] ADD CONSTRAINT [Key25] PRIMARY KEY NONCLUSTERED ([CourseNumber],[DepartmentCode],[StudentNumber])
go

ALTER TABLE [Course].[Course] ADD CONSTRAINT [CourseNumber1] UNIQUE ([CourseNumber])
 ON [Primary]
go

-- Table Grade.Grade_Report

CREATE TABLE [Grade].[Grade_Report]
(
 [StudentNumber] Int NOT NULL,
 [SectionNumber] Int NOT NULL,
 [LetterGrade] Varchar(2) NOT NULL,
 [NumericGrade] Char(2) NOT NULL
)
ON [Primary]
go

-- Add keys for table Grade.Grade_Report

ALTER TABLE [Grade].[Grade_Report] ADD CONSTRAINT [Key26] PRIMARY KEY NONCLUSTERED ([StudentNumber],[SectionNumber])
go

ALTER TABLE [Grade].[Grade_Report] ADD CONSTRAINT [CourseNumber] UNIQUE ([StudentNumber])
go

ALTER TABLE [Grade].[Grade_Report] ADD CONSTRAINT [SectionNumber] UNIQUE ([SectionNumber])
go

-- Table Section.Section_Details

CREATE TABLE [Section].[Section_Details]
(
 [Semester] Nchar(2) NOT NULL,
 [year] Nchar(2) NOT NULL,
 [CourseNumber] Int NOT NULL,
 [SectionNumber] Int NOT NULL
)
ON [Primary]
go

-- Add keys for table Section.Section_Details

ALTER TABLE [Section].[Section_Details] ADD CONSTRAINT [Key27] PRIMARY KEY NONCLUSTERED ([SectionNumber],[CourseNumber])
go

ALTER TABLE [Section].[Section_Details] ADD CONSTRAINT [CourseNumber] UNIQUE ([CourseNumber])
go

ALTER TABLE [Section].[Section_Details] ADD CONSTRAINT [SectionNumber] UNIQUE ([SectionNumber])
go

-- Table Course.Course_Credit

CREATE TABLE [Course].[Course_Credit]
(
 [NumberSemHours] Nchar(2) NOT NULL,
 [CourseNumber] Int NOT NULL
)
ON [Primary]
go

-- Add keys for table Course.Course_Credit

ALTER TABLE [Course].[Course_Credit] ADD CONSTRAINT [Key28] PRIMARY KEY ([CourseNumber])
go

ALTER TABLE [Course].[Course_Credit] ADD CONSTRAINT [CourseNumber] UNIQUE ([CourseNumber])
go

-- Table Section.Section_Faculty

CREATE TABLE [Section].[Section_Faculty]
(
 [Instructor] Varchar(20) NOT NULL,
 [SectionNumber] Int NOT NULL
)
ON [Primary]
go

-- Add keys for table Section.Section_Faculty

ALTER TABLE [Section].[Section_Faculty] ADD CONSTRAINT [Key29] PRIMARY KEY NONCLUSTERED ([SectionNumber])
go

ALTER TABLE [Section].[Section_Faculty] ADD CONSTRAINT [SectionNumber1] UNIQUE ([SectionNumber])
go

-- Create relationships section ------------------------------------------------- 

ALTER TABLE [Student].[Student_Personal_Details] ADD CONSTRAINT [FK_Student_Personal_Details_Student_Details] FOREIGN KEY ([SocialSecurityNumber]) REFERENCES [Student].[Student_Details] ([SocialSecurityNumber]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Student].[Student_Address] ADD CONSTRAINT [FK_Student_Address_Student_Personal_Details] FOREIGN KEY ([SocialSecurityNumber]) REFERENCES [Student].[Student_Personal_Details] ([SocialSecurityNumber]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Student].[Student_Contact] ADD CONSTRAINT [FK_Student_Contact_Student_Personal_Details] FOREIGN KEY ([StudentNumber]) REFERENCES [Student].[Student_Personal_Details] ([StudentNumber]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Department].[Department_Details] ADD CONSTRAINT [FK_Department_Details_Student_Details] FOREIGN KEY ([StudentNumber]) REFERENCES [Student].[Student_Details] ([StudentNumber]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Department].[Department_Contact] ADD CONSTRAINT [FK_Department_Contact_Department_Details] FOREIGN KEY ([DepartmentCode]) REFERENCES [Department].[Department_Details] ([DepartmentCode]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Course].[Course] ADD CONSTRAINT [FK_Course_Depart_Details] FOREIGN KEY ([DepartmentCode], [StudentNumber]) REFERENCES [Department].[Department_Details] ([DepartmentCode], [StudentNumber]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Course].[Course_Credit] ADD CONSTRAINT [FK_Course_Credits_Course] FOREIGN KEY ([CourseNumber]) REFERENCES [Course].[Course] ([CourseNumber]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Section].[Section_Details] ADD CONSTRAINT [FK_Section_Details_Course] FOREIGN KEY ([CourseNumber]) REFERENCES [Course].[Course] ([CourseNumber]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Section].[Section_Faculty] ADD CONSTRAINT [FK_Section_Faculty_Section_Details] FOREIGN KEY ([SectionNumber]) REFERENCES [Section].[Section_Details] ([SectionNumber]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Grade].[Grade_Report] ADD CONSTRAINT [FK_Grade_Report_Section_Details] FOREIGN KEY ([SectionNumber]) REFERENCES [Section].[Section_Details] ([SectionNumber]) ON UPDATE NO ACTION ON DELETE NO ACTION
go

ALTER TABLE [Grade].[Grade_Report] ADD CONSTRAINT [FK_Student_Details_Grade_Report] FOREIGN KEY ([StudentNumber]) REFERENCES [Student].[Student_Details] ([StudentNumber]) ON UPDATE NO ACTION ON DELETE NO ACTION
go



