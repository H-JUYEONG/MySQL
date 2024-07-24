/***************************************
* 복습
****************************************/
-- 기본구조 select문 =  select절, from절
select * 
from employees;

-- 특수한경우
select now() from dual; -- 가상의 테이블 dual
select now();  -- mysql에서만 가능

-- 4칙연산
-- 사친연산 가능, as생략가능
select 	first_name 'f-name', 
		salary as 월급,
		salary*12 '연 봉'  
from employees;

-- 컬럼 합치기
select  first_name 이름,
		last_name 성,
		concat(first_name, " ", last_name) 성명    
from employees;

-- where 절
select 	first_name,
		salary
from employees
where salary >= 17000;

-- 비교연산자, 조건이여러개일때, between, in
-- --------------------------------------
/***************************************
* 2일차
****************************************/
select 	first_name,
		salary
from employees
where first_name = 'Lex';

select 	first_name
		salary
from employees
where first_name like 'L___';

select 	first_name
		salary
from employees
where first_name like '%L';

select 	first_name
		salary
from employees
where first_name like '%L%';

#이름에 am 을 포함한 사원의 이름과 월급을 출력하세요
select 	first_name,
		salary
from employees
where first_name like '%am%';

#이름의 두번째 글자가 a 인 사원의 이름과 월급을 출력하세요
select 	first_name,
		salary
from employees
where first_name like '_a%';

#이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select *
from employees
where first_name like '___a%';

#이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 
#이름을 출력하세요
select 	first_name
from employees
where first_name like '__a_';

-- null
select *
from employees
where salary >= 13000
and salary <= 15000
; 

-- null 은 계산되지 않는다(계속 null)
-- 수당을 계산계하세요(between 13000 and 15000)
select 	first_name,
		salary,
        commission_pct,
        salary * commission_pct + 200  수당  
from employees
where salary between 13000 and 15000; 

select 	first_name,
		salary,
		commission_pct,
        salary * commission_pct 수당
from employees
where commission_pct is not null  -- 주의: commission_pct != null 
and salary >= 13000
and salary <= 15000;

#커미션비율이 있는 사원의 이름과 월급 커미션비율을 출력하세요
select 	first_name,
		salary,
		commission_pct
from employees
where commission_pct is not null;

#담당매니저가 없고 커미션비율이 없는 직원의 이름과 매니저아이디 커미션 비율을 출력하세요
select 	first_name,
		manager_id,
        commission_pct
from employees
where manager_id is null
and commission_pct is null;

#부서가 없는 직원의 이름과 월급을 출력하세요
select 	first_name,
		salary,
		department_id
from employees
where department_id is null;

-- order by 절
#직원의 이름과 월급을 월급이 많은 직원부터 출력하세요
select 	first_name,
		salary
from employees
order by salary asc; -- asc:오름차순, desc:내림차순

#월급이 9000이상(where절)인 직원의 이름과 월급(select절)을 월급이 많은 직원(order by절)부터 출력하세요
select 	first_name,
		salary
from employees
where salary >= 9000
order by salary desc
;

-- 정렬조건 1.월급높은 사람부터 desc, 2.동률일때 이름의 내림차순(Z->A) desc
select 	first_name,
		salary
from employees
where salary >= 9000
order by salary desc, first_name desc 
;


#부서번호를 오름차순으로 정렬하고 부서번호, 월급, 이름을 출력하세요
select *
from employees;

#월급이 10000 이상인 직원의 이름 월급을 월급이 큰직원부터 출력하세요
select 	first_name,
		salary
from employees
where salary >= 10000
order by salary desc;

select * from employees;


#부서번호를 오름차순으로 정렬하고 부서번호가 같으면 월급이 높은 사람부터 
#부서번호 월급 이름을 출력하세요  
select 	department_id,
		salary,
        first_name
from employees
order by department_id asc, salary desc
;


#직원의 이름, 급여, 입사일을 이름의 알파벳 올림차순으로 출력하세요
select 	first_name,
		salary,
        hire_date
from employees
order by first_name asc;

#직원의 이름, 급여, 입사일을 입사일이 빠른 사람 부터 출력하세요
select 	first_name,
		salary,
        hire_date
from employees
order by hire_date asc; 

-- 실행순서 공부
select 	first_name n,
		salary s
from employees
where salary >= 10000
order by s desc;     -- 가능

-- 실행 안되는 이유 공부
select 	first_name n,
		salary s
from employees
where s >= 10000    -- 불가능
order by salary desc;     

/***************************************
* 단일행 함수
****************************************/
-- 단일행함수 > 숫자함수

-- round() : 반올림
select 	round(123.123, 2),   -- 123.12 2째자리까지표현
		round(123.126, 2),    -- 123.13 3째자리에서반올림
        round(234.567, 0),     -- 235
        round(123.456, 0),     -- 123
        round(123.456),        -- 123
        round(123.126, -1),    -- 120
        round(125.126, -1),     -- 130
        round(125.126, -2)     -- 100
from dual;

-- ceil() : 올림
select 	ceil(123.456),
		ceil(123.789),
        ceil(123.7892313),
        ceil(987.1234)
from dual;

-- floor() : 내림
select 	floor(123.456),
		floor(123.789),
        floor(123.7892313),
        floor(987.1234)
from dual;

-- truncate(): 자리수 버림
select 	truncate(1234.34567, 2),		
		truncate(1234.34567, 3),
        truncate(1234.34567, 0),
        truncate(1235.34567, -2)
from dual;

-- POWER(숫자, n),  POW(숫자, n): 숫자의 n승   
select 	pow(12, 2),    -- 144
		power(12, 2)   -- 144
from dual;

-- SQRT(숫자): 숫자의 제곱근  
select sqrt(144)     -- 12
from dual;

-- SIGN(숫자): 숫자가 음수이면 -1, 0이면 0, 양수이면 1  
select 	sign(123),    -- 1
		sign(0),      -- 0
        sign(-123)    -- -1
from dual;

-- ABS(숫자): 절대값  
select 	abs(123),   -- 123
		abs(0),     -- 0    
        abs(-123)   -- 123
from dual;

-- GREATEST(x, y, z, ...): 괄호안의 값중 가장 큰값
select greatest(2, 0 , -2),      -- 2
       greatest(4, 3.2, 5.25),    -- 5.25
       greatest('B', 'A', 'C', 'c')   -- c
from dual;

-- LEAST(x, y, z, ...): 괄호안의 값중 가장 작은값  
select least(2, 0 , -2),      -- -2
       least(4, 3.2, 5.25),    -- 3.2
       least('B', 'A', 'C', 'c')   -- A
from dual;

-- 단일행 함수 > 문자함수
select concat('안녕', '하세요');
select concat('안녕', '-', '하세요');
select concat(first_name, " " ,last_name) 
from employees;

-- CONCAT_WS(s, str1, str2, ..., strn): str1, str2, ..., strn을 연결할때 사이에 s 로 연결
-- *with seperator
select concat_ws('-', 'abc', '123', '가다나');
select concat_ws('-', first_name, last_name, phone_number)
from employees;

-- LCASE(str) 또는 LOWER(str): str의 모든 대문자를 소문자로 변환
select 	first_name,
		lcase(first_name),
		lower(first_name),
		lower('ABCabc!#$%'),
		lower('가나다')
from employees;

-- UCASE(str) 또는 UPPER(str): str의 모든 소문자를 대문자로 변환
select 	first_name,	
		ucase(first_name),
		upper(first_name),
		upper('ABCabc!#$%'),
		upper('가나다')
from employees;

-- 문자갯수
select 	first_name,
		length(first_name),   -- 바이트수
		char_length(first_name),  -- 글자수
        character_length(first_name)  -- 글자수
from employees;

select 	length('유재석'),          -- 바이트수  *조심
		char_length('유재석'),     -- 글자수
        character_length('유재석') -- 글자수
from dual;

-- SUBSTRING(str, pos, len) 또는 SUBSTR(str, pos, len):
select 	first_name,
		substr(first_name, 1, 3),   -- Ste
        substr(first_name, 2, 3),    -- 2번째글자부터 3글자
        substr(first_name, -3, 2)    -- 끝에서 3번째부터 2글자
from employees;

select 	 substr('901112-1234567', 8, 1)     -- 성별  
		,substr('901112-1234567', -7, 1)   -- 성별
        ,substr('901112-1234567', 3, 2)   -- 월
        ,substr('901112-1234567', 5, 2)   -- 일
from dual;

-- LPAD(str, len, padstr):  RPAD(str, len, padstr)
select 	first_name,
		lpad(first_name, 10, '*'),
        rpad(first_name, 10, '*')
from employees;

 -- TRIM(str)
select concat('|', '        안녕하세요        ', '|'),
       concat('|', trim('        안녕하세요        '), '|'),
       concat('|', ltrim('        안녕하세요        '), '|'),
       concat('|', rtrim('        안녕하세요        '), '|'),
       trim(concat('|', '        안녕하세요        ', '|'))
from dual;

-- REPLACE(str, from_str, to_str): str에서 from_str을 to_str로 변경
select 	first_name,
		replace(first_name, 'a', '*'),
		substr(first_name, 2, 3),
        replace(first_name, substr(first_name, 2, 3), '***')
from employees;


-- 단일행 함수 > 날짜함수 
select curdate() from dual;
select curtime() from dual;
select current_timestamp(), now() from dual;

select 	adddate('2021-06-20 00:00:00', interval 1 year),
		adddate('2021-06-20 00:00:00', INTERVAL 1 MONTH),  
		adddate('2021-06-20 00:00:00', INTERVAL 1 WEEK),  
		adddate('2021-06-20 00:00:00', INTERVAL 1 DAY),  
		adddate('2021-06-20 00:00:00', INTERVAL 1 HOUR),  
		adddate('2021-06-20 00:00:00', INTERVAL 1 MINUTE),  
		adddate('2021-06-20 00:00:00', INTERVAL 1 SECOND)
from dual;

select 	subdate('2021-06-20 00:00:00', interval 1 year),
		subdate('2021-06-20 00:00:00', INTERVAL 1 MONTH),  
		subdate('2021-06-20 00:00:00', INTERVAL 1 WEEK),  
		subdate('2021-06-20 00:00:00', INTERVAL 1 DAY),  
		subdate('2021-06-20 00:00:00', INTERVAL 1 HOUR),  
		subdate('2021-06-20 00:00:00', INTERVAL 1 MINUTE),  
		subdate('2021-06-20 00:00:00', INTERVAL 1 SECOND)
from dual;

-- DATEDIFF(): TIMEDIFF(): 
select 	datediff('2021-06-21 01:05:05', '2021-06-20 01:00:00'),
		timediff('2021-06-21 01:05:05', '2021-06-20 01:00:00')
from dual;


select 	first_name,
		hire_date,
        floor(datediff(now(), hire_date)/365) workyear
from employees
order by workyear desc;

-- 변환함수
-- 날짜(숫자) --> 문자열
select  now(),
		date_format(now(), '%Y-%m-%d %H:%i:%s'),
        date_format(now(), '%Y.%m.%d(%a) %H:%i:%s'),
        date_format(now(), '%Y-%m-%d (%p)%h:%i:%s')
from dual;


-- FORMAT(숫자, p): 숫자에 콤마(,) 를 추가, 소수점 p자리까지 출력
select 	format(1234567.89, 2),
		format(1234567.89, 0),
        format(1234567.89, -5)
from dual;

select 	first_name,
		salary,
        format(salary, 0)
from employees;

-- * IFNULL(컬럼명, null일때값): 컬럼의 값이 null일때 정해진값을 출력
select 	first_name,
		salary,
		commission_pct,
        salary * ifnull(commission_pct, 0) + 500 보너스, -- 월급*커미션퍼센트+500
        ifnull(commission_pct, "없음")
from employees;