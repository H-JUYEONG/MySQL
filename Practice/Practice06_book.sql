/*-----------------------------
root 계정에서 할일
-------------------------------*/

-- book 계정 만들기
 create user 'book'@'%' identified by 'book';
 
-- book_db 만들기
create database book_db
default character set utf8mb4
collate utf8mb4_general_ci
default encryption='n'
;

 -- book 권한부여
 grant all privileges on book_db.* to 'book'@'%';
 
 -- 계정을 생성하거나 권한을 수정한 후, 변경된 권한을 즉시 적용
 flush privileges;
 
 -- use mysql;
 -- select user, host from user;
-- drop user 'book'@'%';
-- drop database book_db;
 
 /*-----------------------------
book 계정에서 할일
-------------------------------*/

-- DB 사용
use book_db;

-- 작가 테이블 만들기
create table author(
    author_id integer primary key auto_increment,
    author_name varchar(50),
    author_desc varchar(50)
); 

-- 책 테이블 만들기
create table book (
	book_id integer primary key auto_increment,
    title varchar(50),
    pubs varchar(50),
    pub_date date,
    author_id integer,
    constraint book_fk foreign key (author_id) references author(author_id)
);

-- 작가 등록(6개)
insert into author values (null, '이문열', '경북 영양');
insert into author values (null, '박경리', '경상남도 통영');
insert into author values (null, '유시민', '17대 국회의원');
insert into author values (null, '기안84', '기안동에서 산 84년생');
insert into author values (null, '강풀', '온라인 만화가 1세대');
insert into author values (null, '김영하', '알쓸신잡');

-- select * from author;

-- 책등록(8개)
insert into book values (null, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);
insert into book values (null, '삼국지', '민음사', '2002-03-01', 1 );
insert into book values (null, '토지', '마로니에북스', '2012-08-15', 2 );
insert into book values (null, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3 );
insert into book values (null, '패션왕', '중앙북스(books)', '2012-02-22', 4 );
insert into book values (null, '순정만화', '재미주의', '2011-08-03', 5 );
insert into book values (null, '오직두사람', '문학동네', '2017-05-04', 6 );
insert into book values (null, '26년', '재미주의', '2012-02-04', 5 );

-- select * from book;

-- 책+작가 리스트 출력
select b.book_id '책번호'
	 , b.title '제목'
     , b.pubs '출판사'
     , b.pub_date '출판일'
     , a.author_id '작가번호'
     , a.author_name '작가이름'
     , a.author_desc '작가정보'
from book b
left join author a
on  b.author_id = a.author_id
;

-- 강풀정보 변경
update author
set author_desc = '서울특별시'
where author_id = 5
;

-- 책+작가 리스트 출력
select b.book_id '책번호'
	 , b.title '제목'
     , b.pubs '출판사'
     , b.pub_date '출판일'
     , a.author_id '작가번호'
     , a.author_name '작가이름'
     , a.author_desc '작가정보'
from book b
left join author a
on  b.author_id = a.author_id
;

-- 기안84 작가 삭제
-- -->오류발생 이유 생각해보기

delete from author
where author_id = 4
; -- 외래 키 제약 조건 때문에 해당 작가가 참조된 레코드를 먼저 삭제해야 함(book 테이블에 author_id로 연결된 데이터가 있기 때문에 불가능)

-- 나머지 배운 명령어 해보기
-- set sql_safe_updates=0;
delete from book
where title = '패션왕' 
;

delete from author
where author_id = 4
;