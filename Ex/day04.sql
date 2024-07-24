/***********************************************
* 03일차 수업
***********************************************/

select 	first_name, 
		salary 
from employees;

-- 이름은 107개   평균 1개  표현X
select 	first_name, 
		avg(salary)
from employees;  

-- 평균 1개  표현O
select avg(salary)
from employees;

-- 그룹함수
# count()
select count(*)
from employees
;

select 	count(commission_pct), 
		count(*)
from employees
;

-- 월급이 16000 초과 되는 직원의 수는?
select 	count(*),
		count(manager_id)
from employees
where salary >= 16000
;

# sum()
-- 전체직원의 급여의 합
select 	count(*) as count,
		sum(salary) as total
from employees
;

-- 계산은 되지만 의미에 맞지 않는다
select sum(employee_id)  
from employees
;

# avg() -- null 포함여부 주의
select 	count(*),
		sum(salary),
        avg(salary),
        avg(ifnull(salary, 0))
from employees
;

# max() min()
select 	count(*),
		max(salary),
        min(salary)
from employees
;

select 	max(salary), -- 1개
		first_name   -- 여러개
from employees;

select 	department_id,
		salary
from employees
order by department_id asc
;

-- ------------------------------
# GROUP BY 절
-- ------------------------------
-- 그룹별로 월급의 합계를 구하세요
-- 그룹에 참여한 칼럼은 select절에 사용할 수 있다-->그룹의 대표값
select 	department_id,
		sum(salary),
        avg(salary)
from employees
group by department_id
order by department_id asc
;

-- 그룹을 나누는 기준1 department_id, 그안에서 서브그룹을 job_id로
-- 그룹에 참여한 칼럼은 select절에 사용할 수 있다-->그룹의 대표값
select 	department_id,
		job_id,
		sum(salary)
from employees
group by department_id, job_id
;

select 	department_id,
		job_id,
		sum(salary),
        first_name -- 그룹에 참여하지 않은 컬럼은 사용할 수 없다
from employees
group by department_id, job_id
;

-- 부서별로 부서 번호와 , 인원수, 월급합계를 출력하세요
select 	department_id,
		count(*),
		sum(salary)
from employees
group by department_id;

-- ------------------------------
# Having 절
-- ------------------------------
-- 월급(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 월급합계를 출력하세요
select 	department_id,
		count(*),
		sum(salary)
from employees
-- where sum(salary) >= 20000
group by department_id
having sum(salary) >= 20000
and department_id >= 80
-- and employee_id  >= 150   
-- having 절에는 그룹함수와 Group by 에 참여한 컬럼만 사용가능
;

select department_id, sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
and department_id >200
;

/***********************************
IF(조건문, 참일때값, 거짓일때값)
************************************/
select 	first_name,
		salary,
		commission_pct,
        ifnull(commission_pct, 0) as commission_pct2,
        if(commission_pct is null, "일반사원", "영업사원") as state2,
        if(commission_pct is null, 0, commission_pct) as state3
from employees
;

# 직원아이디, 월급, 업무아이디, 실제월급(realSalary)을 출력하세요.
# 실제월급은 job_id 가 'AC_ACCOUNT' 면 월급+월급*0.1,
#                   'SA_REP' 월급+월급*0.2,
#                   'ST_CLERK' 면 월급+월급*0.3
#                    그외에는 월급으로 
# 계산하세요
select 	employee_id,
		salary,
		job_id,
		case when job_id = 'AC_ACCOUNT' then salary + salary*0.1
			 when job_id = 'SA_REP' then salary + salary*0.2
			 when job_id = 'ST_CLERK' then salary + salary*0.3
			 else salary 
        end '이번달 월급'
from employees
;

/*
직원의 이름, 부서번호(부서아이디), 팀을 출력하세요
팀은 코드로 결정하며 부서코드가
    10~50 이면 'A-TEAM'
    60~100이면 'B-TEAM'
    110~150이면 'C-TEAM'
    나머지는 '팀없음' 으로 
출력하세요.
*/

select 	first_name,
		department_id,
        case when department_id>=10 and department_id<=50 then 'A-TEAM' 
			 when department_id>=60 and department_id<=100 then 'B-TEAM'
             when department_id>=110 and department_id<=150 then 'C-TEAM'
			 else '팀없음'
		end as team
from employees
;



select 	first_name,
		department_id,
        case when department_id between 10 and 50 then 'A-TEAM'
			 when department_id between 60 and 100 then 'B-TEAM'
             when department_id between 100 and 150 then 'C-TEAM'
			 else '팀없음'
		end as team
from employees
;
-- -----------------------------------------------
# join
-- -----------------------------------------------
-- 사원이름 월급 부서명 부서번호 <--원하는 결과 
-- employees, departments 데이터가 2개의 데이블에 나누어져 있다

select * from employees;   -- 107 직원
select * from departments;  -- 27 부서
select 107*27;  -- 107*27=2889

-- 두개의 데이블을 동시에 불러옴
-- 107*27 row값이 생김
-- 두테이블의 모든 컬럼이 한개로 합쳐진다
-- (department_id 컬럼은 양쪽데이블에 같은이름으로 있음)
select *
from employees, departments
;

-- 조건문을 써서 조건에 맞는 결과만 선택한다
select 	employee_id,
		first_name,
        salary,
        department_name,
        employees.department_id,
        departments.department_id
from employees, departments
where employees.department_id = departments.department_id
;