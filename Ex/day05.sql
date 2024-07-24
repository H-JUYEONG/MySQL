/***********************************************
* 05일차 수업
***********************************************/
-- ------------------------------------------------
# SubQuery
-- ------------------------------------------------
-- 'Den' 보다 월급을 많은 사람의 이름과 월급은?

-- Den의 월급 -->11000
select 	salary
from employees
where first_name = 'Den'
;  

-- 11000 보다 많은사람 리스트
select *
from employees
where salary >= 11000;


-- 두개를 합쳐서 1개의 질문으로 만든다
select 	first_name,
		salary
from employees
where salary >= (select	salary
				 from employees
				 where first_name = 'Den')
and salary <= 12000
order by salary desc;


-- 월급을 가장 적게 받는 사람의 이름, 월급, 사원번호는?
-- 2100;
-- 가장 적은 월급 ,  그룹함수라서 이름하고 같이 출력할수없다
-- 1)가장적은 월급 --> 2100
select 	min(salary)
from employees;

-- 2)2100보다 많이받는 사람 리스트
select 	first_name,
		salary
from employees
where salary = (2100);

-- 3)두 질문 합치기
select 	first_name,
		salary,
        employee_id,
        phone_number
from employees
where salary = (select 	min(salary)
				from employees);


-- 평균 월급보다 적게 받는 사람의 이름, 월급을 출력하세요?

-- 1)평균 월급 구하기 6461.831776
select avg(salary) 
from employees;

-- 2)6461.831776보다 적게 받는사람들 구하기
select 	first_name,
		salary
from employees
where salary <= 6461.831776;


-- 3)질문 합치기
select 	first_name,
		salary
from employees
where salary <= (select avg(salary) 
				 from employees);


-- 부서번호가 110인 직원의 월급와 같은 월급을 받는 
-- 모든 직원의 사번, 이름, 월급를 출력하세요

-- 1) 부서번호가 110인 직원의 월급 --> 12008.00, 8300.00
select salary 
from employees
where department_id = 110;

-- 2-1) 12008.00, 8300.00 인 사람들 구하기 where절로 구하기
select 	first_name,
		salary
from employees
where salary = 12008.00
or salary = 8300.00
;

-- 2-2) 12008.00, 8300.00 인 사람들 구하기 in()
select 	first_name,
		salary
from employees
where salary in( 8300.00, 12008.00 )
;

-- 3) 질문 합치기 2-2)사용
select 	first_name,
		salary
from employees
where salary in (select salary 
				 from employees
				 where department_id = 110)
;


-- 각 부서별로 최고급여를 받는 사원의 이름과 월급을 출력하세요
/*
Jennifer 10 4400.00
Michael  20 13000.00
Den      30 11000.00
Susan    40 6500.00
Adam	 50	8200.00     
--> 8200은 50번부서는 최고급액이지만 
    다른부서(100번부서)에도 8200받는사람(100번부서에서는 최고금액 아님)이 있다
...   
*/

select * from employees;

-- 각 부서별(부서번호 최고월급),   누구??X
select 	department_id, 
		max(salary)
from employees
group by department_id
;

select *
from employees
where (department_id = 50 and salary = 8200)
or (department_id = 10  and salary = 4400)
or (department_id = 30  and salary = 11000)

;

select 	first_name,
		salary,
        department_id
from employees
where (department_id, salary) in (select  department_id,  
										  max(salary)
								  from employees
								  group by department_id)
;


select 	first_name,
		salary,
        department_id
from employees
where (department_id, salary) in ((10, 4000) , (20, 13000), (30,11000))
;

-- where (salary) in (4000, 13000, 11000)

/*
부서번호가 110인 직원의 월급 중 
가장 작은 월급 보다 월급이 많은 모든 직원의 
이름, 급여를 출력하세요.(or연산--> 8300보다 큰)
*/

select salary
from employees
where department_id = 110
;  -- 8300, 12008

/*
any (or)
all (and)
*/

-- 30개
select 	first_name,
		salary
from employees
where salary >any (select salary
				   from employees
				   where department_id = 110); -- 8300, 12008


-- 6개
select 	first_name,
		salary
from employees
where salary >all (select salary
				   from employees
				   where department_id = 110); -- 8300, 12008




-- ------------------------------------------------
# SubQuery   where절 vs 테이블
-- ------------------------------------------------
-- 각 부서별로 최고월급을 받는 사원의 부서번호, 직원번호, 이름, 월급을 출력하세요
-- where절로 풀이

-- 1) 각부서별 최고월급액
select  department_id,
		max(salary)
from employees
group by department_id;
/*결과일부
(10, 4400)
(20, 13000)
(30, 11000)
...
*/

-- 2) 직원별로 (10, 4400), (20, 13000), (30, 11000)... 받는 직원을 찾는다
-- where절로 표현
select *
from employees
where department_id = 10 and salary = 4000
or department_id = 20 and salary = 13000
or department_id = 30 and salary = 11000
;

-- in으로 표현
select *
from employees
where ( department_id, salary) in((10, 4400),(20, 13000), (30, 11000))
;

-- 서브쿼리로 표현
select 	employee_id,
		first_name,
        salary
from employees
where ( department_id, salary) in(select  department_id,
										  max(salary)
								  from employees
								  group by department_id)
;


-- 각 부서별로 최고월급을 받는 사원의 부서번호, 직원번호, 이름, 월급을 출력하세요
-- table로 풀이

-- 1) 각 그룹별로 최고월급 데이터가 있는 테이블이 있으면 구할수 있다
--    이부분은 생각해 내야함
select 	e.department_id, 
		max(salary) msalary
from employees e
group by e.department_id
;
-- 2) 전체구조
select 	e.first_name,
		e.salary,
        m.msalary,
        m.department_id
from employees e, ((1)로만든 테이블사용) m     
where e.department_id = m.department_id
and e.salary = m.msalary
;


-- 3) 합치기
select 	e.first_name,
		e.salary,
        m.msalary,
        m.department_id
from employees e, (select e.department_id, 
						  max(salary) msalary
				   from employees e
				   group by e.department_id) m
where e.department_id = m.department_id
and e.salary = m.msalary
;