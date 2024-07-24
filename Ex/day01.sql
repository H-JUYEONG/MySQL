/* 문제1.
직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 부서명(department_name)을
조회하여 부서이름(department_name) 오름차순, 사번(employee_id) 내림차순 으로 정렬하세
요. (106건) */

select e.employee_id '사번'
	 , concat(e.first_name, e.last_name) '이름'
     , d.department_name '부서명'
from employees e
inner join departments d on e.department_id = d.department_id
order by d.department_name, e.employee_id desc
;

/* 문제2.
employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
직원들의 사번(employee_id), 이름(firt_name), 월급(salary), 부서명(department_name), 
현재업무(job_title)를 사번(employee_id) 오름차순 으로 정렬하세요.
부서가 없는 Kimberely(사번 178)은 표시하지 않습니다. (106건) */

select e.employee_id '사번'
	 , e.first_name '이름'
     , e.salary '월급'
     , d.department_name '부서명'
     , j.job_title '현재업무'
from employees e
inner join departments d on e.department_id = d.department_id
inner join jobs j on e.job_id = j.job_id
order by e.employee_id
;

/* 문제2-1.
문제2에서 부서가 없는 Kimberely(사번 178)까지 표시해 보세요. (107건)  */

select e.employee_id '사번'
	 , e.first_name '이름'
     , e.salary '월급'
     , d.department_name '부서명'
     , j.job_title '현재업무'
from employees e
left join departments d on e.department_id = d.department_id
inner join jobs j on e.job_id = j.job_id
order by e.employee_id
;

/* 문제3.
도시별로 위치한 부서들을 파악하려고 합니다.
도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순)로 정렬하여 출력하세요.
부서가 없는 도시는 표시하지 않습니다. (27건) */

select l.location_id '도시아이디'
	 , l.city '도시명'
     , d.department_name '부서명'
     , d.department_id '부서아이디'
from locations l
inner join departments d on l.location_id = d.location_id
order by l.location_id
;

/* 문제3-1.
문제3에서 부서가 없는 도시도 표시합니다. (43건) */

select l.location_id '도시아이디'
	 , l.city '도시명'
     , d.department_name '부서명'
     , d.department_id '부서아이디'
from locations l
left join departments d on l.location_id = d.location_id
order by l.location_id
;

/* 문제4.
지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 출력하
되 지역이름(오름차순), 나라이름(내림차순) 으로 정렬하세요. (25건) */

select region_name '지역이름'
	 , country_name '나라이름'
from regions r
inner join countries c on r.region_id = c.region_id
order by region_name, country_name desc
;

/* 문제5. 
자신의 매니저보다 채용일(hire_date)이 빠른 사원의 사번(employee_id), 이름(first_name)과
채용일(hire_date), 매니저이름(first_name), 매니저입사일(hire_date)을 조회하세요. (37건) */

select e.employee_id '사원사번'
	 , e.first_name '사원이름'
     , e.hire_date '채용일'
     , m.first_name '매니저이름'
     , m.hire_date '매니저입사일'
from employees e
inner join employees m on e.manager_id = m.employee_id
where e.hire_date < m.hire_date
;

/* 문제6.
나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다.
나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디를 나라명(오름차순)로 정렬하여 출력하세요. 
값이 없는 경우 표시하지 않습니다. (27건) */

select c.country_name '나라명'
	 , c.country_id'나라아이디'
     , l.city '도시명'
     , l.location_id '도시아이디'
     , d.department_name '부서명'
     , d.department_id '부서아이디'
from countries c
inner join locations l on c.country_id = l.country_id
inner join departments d on l.location_id = d.location_id
order by c.country_name
;

/* 문제7.
job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다.
과거의 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한 사원의 사번, 이름(풀네임), 업무아이디, 시작일, 종료일을 출력하세요.
이름은 first_name과 last_name을 합쳐 출력합니다. (2건) */

select j.employee_id '사번'
	 , concat(e.first_name, e.last_name) '이름'
     , j.job_id '업무아이디'
     , j.start_date '시작일'
     , j.end_date '종료일'
from job_history j
inner join employees e on j.employee_id = e.employee_id
where j.job_id in ('AC_ACCOUNT')
; 
     
/* 문제8.
각 부서(department)에 대해서 부서번호(department_id), 부서이름(department_name), 
매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 나라(countries)의 이름 (countries_name) 
그리고 지역구분(regions)의 이름(resion_name)까지 전부 출력해 보세요. (11건) */

select d.department_id '부서번호'
	 , d.department_name '부서이름'
     , e.first_name '매니저이름'
     , l.city '도시명'
     , c.country_name '나라명'
     , r.region_name '지역명'
from departments d
inner join employees e on d.manager_id = e.employee_id
inner join locations l on d.location_id = l.location_id 
inner join countries c on l.country_id = c.country_id
inner join regions r on c.region_id = r.region_id
;

/* 문제9.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 
매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
매니저가 없는 Steven도 표시합니다. (107명) */

select e.employee_id '사원사번'
	 , e.first_name '사원이름'
     , d.department_name '부서명'
     , m.first_name '매니저이름'
from employees e
left join departments d on e.department_id = d.department_id
left join employees m on e.manager_id = m.employee_id
;

/* 문제9-1.
문제9 에서 부서가 없는 직원(Kimberely)도 표시하고 매니저가 없는 Steven도 표시하지 않습니다. (106명) */

select e.employee_id '사원사번'
	 , e.first_name '사원이름'
     , d.department_name '부서명'
     , m.first_name '매니저이름'
from employees e
left join departments d on e.department_id = d.department_id
inner join employees m on e.manager_id = m.employee_id
; 

/* 문제9-2.
문제9 에서 부서가 없는 직원(Kimberely)도 표시하지 않고 매니저가 없는 Steven도 표시하지 않습니다. (105명) */

select e.employee_id '사원사번'
	 , e.first_name '사원이름'
     , d.department_name '부서명'
     , m.first_name '매니저이름'
from employees e
inner join departments d on e.department_id = d.department_id
inner join employees m on e.manager_id = m.employee_id
;