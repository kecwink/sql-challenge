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

--create a table with department manager, department number, department name, the manager's employee number, last name, first name, 
--and start and end employment dates.

select detailed_employee_data.emp_no, detailed_employee_data.first_name, detailed_employee_data.last_name, data_dept_manager.dept_no , data_dept_manager.start_date, data_dept_manager.end_date ,employee_data.dept_name
from data_dept_manager
join employee_data using (dept_no)
join detailed_employee_data using(emp_no);

--create a table with employee number, full name and department
 
create view  all_employees as
select dept_employee_data.emp_no,  detailed_employee_data.first_name , detailed_employee_data.last_name, employee_data.dept_name
from dept_employee_data
join detailed_employee_data on dept_employee_data.emp_no = detailed_employee_data.emp_no
join employee_data on employee_data.dept_no= dept_employee_data.dept_no;


--List all employees whose first name is "Hercules" and last names begin with "B.
select * from all_employees
where first_name = 'Hercules' and last_name like 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
select * from all_employees
where dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
select * from all_employees
where dept_name = 'Sales' or dept_name = 'Development';


--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
create view employee_last_name  as
select last_name 
from all_employees
group by(last_name) ;
count(last_names) as "last_name_count"
where last_names like '%'
order by 'last_name_count' desc;






