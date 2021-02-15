create table admin(
    admin_no        number(2),
    admin_id        varchar2(20) not null unique,
    pwd             varchar2(20) not null,
    primary key(admin_no)
);
insert into admin values(1, 'abc', '123');
insert into admin values(2, 'xyz', '123');
insert into admin values(3, 'nokcha', '123');
commit;

select *
from admin

create table board(
    b_no            number                                -- 글 번호 (고유번호로서 행과 행을 구별하는 역할)
    ,subject        varchar2(50)       not null           -- 글 제목
    ,writer         varchar2(30)       not null           -- 글쓴이
    ,reg_date       date               default sysdate    -- 등록일
    ,readcount      number(5)          default 0          -- 조회수
    ----------------------------------------------------------------------------
    ,content        varchar2(2000)     not null           -- 글 내용
    ,pwd            varchar2(12)       not null           -- 암호
    ,email          varchar2(30)                          -- 이메일
    ----------------------------------------------------------------------------
    ,group_no       number(5)          not null           -- 입력 글의 소속 그룹번호 (게시판 글을 정렬하는 첫 번째 기준)
    ,print_no       number(5)          not null           -- 같은 그룹 내의 출력 순서 번호 (같은 그룹 내에서 글을 정렬하는 기준으로 게시판 글을 정렬하는 두 번째 기준)
    ,print_level    number(5)          not null           -- 같은 그룹 내의 댓글 레벨
)