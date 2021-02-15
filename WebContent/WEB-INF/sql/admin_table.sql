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
    b_no            number                                -- �� ��ȣ (������ȣ�μ� ��� ���� �����ϴ� ����)
    ,subject        varchar2(50)       not null           -- �� ����
    ,writer         varchar2(30)       not null           -- �۾���
    ,reg_date       date               default sysdate    -- �����
    ,readcount      number(5)          default 0          -- ��ȸ��
    ----------------------------------------------------------------------------
    ,content        varchar2(2000)     not null           -- �� ����
    ,pwd            varchar2(12)       not null           -- ��ȣ
    ,email          varchar2(30)                          -- �̸���
    ----------------------------------------------------------------------------
    ,group_no       number(5)          not null           -- �Է� ���� �Ҽ� �׷��ȣ (�Խ��� ���� �����ϴ� ù ��° ����)
    ,print_no       number(5)          not null           -- ���� �׷� ���� ��� ���� ��ȣ (���� �׷� ������ ���� �����ϴ� �������� �Խ��� ���� �����ϴ� �� ��° ����)
    ,print_level    number(5)          not null           -- ���� �׷� ���� ��� ����
)