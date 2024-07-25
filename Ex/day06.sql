/***********************************************
* 06일차 수업
***********************************************/
-- ------------------------------------------------
# limit
-- ------------------------------------------------
select 	employee_id,
		first_name,
        salary
from employees
order by employee_id asc
limit 0, 5   -- 1번부터 5개(O) 
             -- 0번부터 5번까지(X)
;

select 	employee_id,
		first_name,
        salary
from employees
order by employee_id asc
limit 5 offset 0   -- 1번부터 5개(O) 
                   -- 5번부터 0번까지(X)
;

select 	employee_id,
		first_name,
        salary
from employees
order by employee_id asc
limit 7    -- 처음부터 7개
-- limit 0, 7
;

-- 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은?
select 	first_name,
		salary,
        hire_date
from employees
where hire_date >= '2007-01-01'
and hire_date < '2008-01-01'
order by salary desc
limit 2, 5
; 

-- where and
select 	first_name,
		salary,
        hire_date
from employees
where hire_date >= '2007-01-01'
and hire_date < '2008-01-01'
; 

select 	first_name,
		salary,
        hire_date
from employees
where hire_date between '2007-01-01' and '2007-12-31'
; 

select 	first_name,
		salary,
        hire_date
from employees
where date_format(hire_date, '%y') = '07'
; 
-- 2007-05-01  --> 07 = 07

select 	year(hire_date),
		month(hire_date),
        day(hire_date)
from employees;


select 	first_name,
		salary,
        hire_date,
        date_format(hire_date, '%Y')
from employees
where substr(date_format(hire_date, '%Y'), 1, 4) = '2007'
; 