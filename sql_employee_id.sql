-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/fGEEuF
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

drop table data_titles
CREATE TABLE "data_titles" (
    "emp_no" int    NOT NULL,
    "title" varchar(50)  NOT NULL,
    "start_date" date   NOT NULL,
    "end_date" date   NOT NULL
    --CONSTRAINT "pk_data_titles" PRIMARY KEY (
        --"emp_no"
     --)
);

select * from data_titles

CREATE TABLE "data_dept_manager" (
    "dept_no" varchar(50)   NOT NULL,
    "emp_no" int   NOT NULL,
    "start_date" date   NOT NULL,
    "end_date" date   NOT NULL
);

select * from data_dept_manager

CREATE TABLE "employee_data" (
    "dept_no" varchar(50)   NOT NULL,
    "dept_name" varchar(50)   NOT NULL
);

select * from employee_data


CREATE TABLE "data_salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "start_date" date   NOT NULL,
    "end_date" date   NOT NULL
);

select * from data_salaries

CREATE TABLE "detailed_employee_data" (
    "emp_no" int  Primary Key NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "gender" varchar(50)   NOT NULL,
    "hire_date" date   NOT NULL
);

select * from detailed_employee_data

CREATE TABLE "dept_employee_data" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(50)   NOT NULL,
    "start_date" date   NOT NULL,
    "end_date" date   NOT NULL
);
select * from dept_employee_data

--ALTER TABLE "employee_data" ADD CONSTRAINT "fk_employee_data_dept_no" FOREIGN KEY("dept_no")
--REFERENCES "data_dept_manager" ("dept_no");

--ALTER TABLE "data_titles" ADD CONSTRAINT "fk_data_titles_emp_no" FOREIGN KEY("emp_no")
--REFERENCES "detailed_employee_data" ("emp_no");

--ALTER TABLE "data_salaries" ADD CONSTRAINT "fk_data_salaries_emp_no" FOREIGN KEY("emp_no")
--REFERENCES "data_titles" ("emp_no");

--ALTER TABLE "detailed_employee_data" ADD CONSTRAINT "fk_detailed_employee_data_emp_no" FOREIGN KEY("emp_no")
--REFERENCES "data_dept_manager" ("emp_no");

--ALTER TABLE "dept_employee_data" ADD CONSTRAINT "fk_dept_employee_data_emp_no" FOREIGN KEY("emp_no")
--REFERENCES "data_dept_manager" ("emp_no");



--join detailed_employee_data and data_salaries

select emp_no, first_name, last_name, gender, hire_date
from detailed_employee_data
join data_salaries
using (emp_no);

--select all employees hired in 1986
select first_name, last_name, emp_no, hire_date
from detailed_employee_data
where extract(year from hire_date) = 1986

--

--join dept_employee_data, data_dept_manager and detailed_employee_data
--how to join detailed employee data with just first, last and emp_no? subquery? update joined table 160?

select * from data_dept_manager
join employee_data using (dept_no)
join detailed_employee_data using(emp_no);

--join department info with employee info
with all_employees as (select * from dept_employee_data
join detailed_employee_data using(emp_no)
join employee_data using(dept_no)) 

select * from all_employees
