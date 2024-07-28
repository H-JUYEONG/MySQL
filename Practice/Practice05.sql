/* 문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.(45건) */

SELECT first_name AS '이름'
	 , manager_id AS '매니저아이디'
	 , commission_pct AS '커미션비율'
	 , salary AS '월급'
FROM employees
WHERE manager_id IS NOT NULL
AND commission_pct IS NULL
AND salary > 3000
;

/* 문제2. 
각 부서별로 최고의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name), 월급(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요.
-조건절비교 방법으로 작성하세요
-월급의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.(11건) */

SELECT employee_id AS '직원번호'
	 , first_name AS '이름'
     , salary AS '월급'
     , CONCAT(date_format(hire_date, '%Y-%m-%d '), 
       CASE DAYOFWEEK(hire_date)
			WHEN 1 THEN '일요일'
			WHEN 2 THEN '월요일'
			WHEN 3 THEN '화요일'
			WHEN 4 THEN '수요일'
			WHEN 5 THEN '목요일'
			WHEN 6 THEN '금요일'
			WHEN 7 THEN '토요일'
	   END) AS '입사일'
     , REPLACE(phone_number, '.', '-') AS '전화번호'
     , department_id AS '부서번호'
FROM employees
WHERE (department_id, salary) IN (SELECT department_id
										 , Max(salary)
								  FROM employees
								  GROUP BY department_id)
ORDER BY salary DESC
;

/* 문제3.
매니저별 담당직원들의 평균월급 최소월급 최대월급을 알아보려고 한다.
-통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
-매니저별 평균월급이 5000이상만 출력합니다.
-매니저별 평균월급의 내림차순으로 출력합니다.
-매니저별 평균월급은 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균월급, 매니저별최소월급, 매니저별최대월급 입니다.(9건) */

SELECT m.manager_id AS '매니저아이디'
	 , m.first_name AS '매니저이름'
	 , ROUND(AVG(e.salary)) AS '매니저평균월급'
	 , MIN(e.salary) AS '매니저별최소월급'
	 , MAX(e.salary) AS '매니저별최대월급'
FROM employees m -- 매니저 정보
INNER JOIN employees e -- 직원 정보(매니저별 담당직원들의 월급)
ON m.employee_id = e.manager_id -- 매니저의 직원아이디와 직원의 매니저아이디를 비교
WHERE m.hire_date >= '2005-01-01'
AND m.salary >= 5000
GROUP BY m.manager_id, m.first_name
ORDER BY ROUND(AVG(e.salary)) DESC
;

-- 서브쿼리 사용
SELECT m.manager_id AS '매니저아이디'
	 , m.first_name AS '매니저이름'
     , round(e.avgSalary) AS '매니저평균월급'
     , e.minSalary AS '매니저별최소월급'
     , e.maxSalary AS '매니저별최대월급'
FROM employees m, 
	(SELECT manager_id
		  , AVG(salary) AS avgSalary
          , MIN(salary) AS minSalary
          , MAX(salary) AS maxSalary 
	 FROM employees 
	 GROUP BY manager_id
     ) e
WHERE m.employee_id = e.manager_id
AND m.hire_date >= '2005-01-01'
AND m.salary >= 5000
ORDER BY round(e.avgSalary) DESC
;

/* 문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)은 표시 합니다.
매니저가 없는 직원(Steven) 은 출력하지 않습니다. (106명) */

SELECT e.employee_id AS '사번'
	 , e.first_name AS '사원이름'
     , d.department_name AS '부서명'
     , m.first_name AS '매니저이름'
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
INNER JOIN (SELECT first_name, employee_id 
			FROM employees
            ) m
ON e.manager_id = m.employee_id
;

/* 문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의
사번, 이름, 부서명, 월급, 입사일을 입사일 순서로 출력하세요. */

SELECT e.employee_id AS '사번'
	 , e.first_name AS '이름'
     , d.department_name AS '부서명' 
     , e.salary AS '월급'
     , e.hire_date AS '입사일'
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
WHERE e.hire_date >= '05/01/01'
ORDER BY e.hire_date
LIMIT 10, 10
;

/* 문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 월급(salary)과 근무하는 부서 이름(department_name)은? */

SELECT CONCAT(e.first_name, ' ', e.last_name) AS '이름'
	 , e.salary AS '월급'
     , d.department_name AS '부서명'
     , m.maxDate AS '입사일'
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN (SELECT MAX(hire_date) AS maxDate 
			FROM employees
            ) m
ON e.hire_date = m.maxDate
;

/* 문제7.
평균월급(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(first_name), 성(last_name)과 업무(job_title), 월급(salary)을 조회하시오. */

SELECT e.employee_id AS '사번'
	 , e.first_name AS '성'
     , e.last_name AS '이름'
     , j.job_title AS '업무명'
     , e.salary AS '월급'
     , a.avgSalary AS '부서평균월급'
     , e.department_id AS '부서아이디'
FROM employees e
INNER JOIN jobs j
ON e.job_id = j.job_id
INNER JOIN (SELECT department_id
				 , avg(salary) AS avgSalary 
			FROM employees 
            GROUP BY department_id
            ) a
ON e.department_id = a.department_id
WHERE e.department_id = (SELECT department_id
					     FROM employees
                         GROUP BY department_id 
                         HAVING AVG(salary) >= (SELECT MAX(avgS.avgSalary)
											   FROM (SELECT AVG(salary) AS avgSalary
													 FROM employees
													 GROUP BY department_id) avgS))
;

-- limit 사용
SELECT e.employee_id AS '사번'
	 , e.first_name AS '성'
     , e.last_name AS '이름'
     , j.job_title AS '업무명'
     , e.salary AS '월급'
     , a.avgSalary AS '부서평균월급'
     , e.department_id AS '부서아이디'
FROM employees e
INNER JOIN jobs j 
ON e.job_id = j.job_id
INNER JOIN (SELECT department_id
				 , avg(salary) AS avgSalary
			FROM employees 
            GROUP BY department_id
            ) a
ON e.department_id = a.department_id
WHERE e.department_id = (SELECT department_id
						 FROM employees
						 GROUP BY department_id
						 ORDER BY AVG(salary) DESC
						 LIMIT 1)
;

/* 문제8.
평균 월급(salary)이 가장 높은 부서명과 월급은? (limt사용하지 말고 그룹함수 사용할 것) */

SELECT d.department_name AS '부서명'
	 , a.avgSalary '평균월급'
FROM departments d
INNER JOIN (SELECT department_id
				 , AVG(salary) AS avgSalary 
			FROM employees 
            GROUP BY department_id) a
ON d.department_id = a. department_id
WHERE a.avgSalary = (SELECT MAX(avgS.avgSalary)
					 FROM (SELECT AVG(salary) AS avgSalary
						   FROM employees
						   GROUP BY department_id) avgS)
;

-- limit 사용
SELECT d.department_name AS '부서명'
	 , a.avgSalary '평균월급'
FROM departments d
INNER JOIN (SELECT department_id
				 , AVG(salary) AS avgSalary
			FROM employees
            GROUP BY department_id
            ORDER BY AVG(salary) DESC
            LIMIT 1) a
ON d.department_id = a.department_id
;

/* 문제9.
평균 월급(salary)이 가장 높은 지역과 평균월급은?( limt사용하지 말고 그룹함수 사용할 것) */

SELECT r.region_name AS '지역명'
	 , b.avgSalary AS '평균월급'
FROM regions r
INNER JOIN (SELECT a.region_id
				 , AVG(a.salary) AS avgSalary -- 평균월급
			FROM (SELECT r.region_id
					   , e.salary
				  FROM regions r
				  INNER JOIN countries c 
				  ON r.region_id = c.region_id
				  INNER JOIN locations l 
				  ON c.country_id = l.country_id
				  INNER JOIN departments d 
				  ON l.location_id = d.location_id
				  INNER JOIN employees e 
				  ON d.department_id = e.department_id
                  ) a
			GROUP BY a.region_id
			) b
ON r.region_id = b.region_id
WHERE b.avgSalary = (SELECT MAX(d.avgSalary) AS avgSalary -- 평균월급의 최대값이랑 같은 값 찾기
					 FROM (SELECT c.region_id
								, AVG(c.salary) AS avgSalary
						   FROM (SELECT r.region_id
									  , c.country_id
									  , l.location_id
									  , d.department_id
									  , e.salary
								FROM regions r
								INNER JOIN countries c
								ON r.region_id = c.region_id
								INNER JOIN locations l 
								ON c.country_id = l.country_id
								INNER JOIN departments d
								ON l.location_id = d.location_id
								INNER JOIN employees e
								ON d.department_id = e.department_id
                                ) c
						  GROUP BY c.region_id
                          ) d
					)
;

-- limit 사용

SELECT r.region_name AS '지역명'
	 , b.avgSalary AS '평균월급'
FROM regions r
INNER JOIN (SELECT a.region_id
				  , AVG(a.salary) AS avgSalary
			FROM (SELECT r.region_id
					   , c.country_id
					   , l.location_id
					   , d.department_id
					   , e.salary
				  FROM regions r
				 INNER JOIN countries c
				 ON r.region_id = c.region_id
				 INNER JOIN locations l 
				 ON c.country_id = l.country_id
				 INNER JOIN departments d
				 ON l.location_id = d.location_id
				 INNER JOIN employees e
				 ON d.department_id = e.department_id
                 ) a
			GROUP BY a.region_id
			ORDER BY AVG(a.salary) DESC
			LIMIT 1
            ) b
ON r.region_id = b.region_id
;

/* 문제10.
평균 월급(salary)이 가장 높은 업무와 평균월급은? (limt사용하지 말고 그룹함수 사용할 것) */

SELECT j.job_title AS '업무명'
	 , a.avgSalary AS '평균월급'
FROM jobs j
INNER JOIN (SELECT job_id
				 , AVG(salary) AS avgSalary
			FROM employees
            GROUP BY job_id) a
ON j.job_id = a. job_id
WHERE a.avgSalary = (SELECT MAX(avgS.avgSalary)
					 FROM (SELECT job_id
								 , AVG(salary) AS avgSalary
						   FROM employees
                           GROUP BY job_id) avgS)
;

-- limit 사용

SELECT j.job_title AS '업무명'
	 , a.avgSalary AS '평균월급'
FROM jobs j
INNER JOIN (SELECT job_id
				 , AVG(salary) AS avgSalary
			FROM employees
            GROUP BY job_id
            ORDER BY AVG(salary) DESC
            LIMIT 1) a
ON j.job_id = a. job_id
;
