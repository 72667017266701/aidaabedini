create database faradars
use faradars

 create table kala (kod int not null,nam char(20),mojodi int,primary key(kod))
 insert into kala values(100,'S1',19)
 insert into kala values(101,'S2',8)
 insert into kala values(102,'S3',28)
 select *from kala

 create table moshtari (kod int not null,nam char(20),primary key(kod))
 insert into moshtari values(1000,'C1')
 insert into moshtari values(1001,'C2')
 insert into moshtari values(1002,'C3')
 insert into moshtari values(1003,'C4')
 select *from moshtari

 create table forosh (kodk int not null,kodm int not null, tedad int,
 primary key(kodk,kodm),foreign key(kodk) references kala(kod),foreign key (kodm) references moshtari(kod))

 select * from forosh

 insert into forosh values(100,1000,9)

 create trigger [triigger_name] on [table_name] [after | instead of] [insert | delete | update]
 AS
 begin
 [STMT]
 end

 create trigger kala_forosh on forosh after insert
 as
 begin
    update kala set mojodi=mojodi-(select tedad from inserted) where kod in(select kodk from inserted)
 end


 insert into forosh values(101,1001,3)

  create trigger kala_marjoei on forosh after delete
 as
 begin
    update kala set mojodi=mojodi+(select tedad from deleted) where kod in(select kodk from deleted)
 end

 select *from kala
 select *from forosh

 delete from forosh where kodk=100

create trigger kala_update on forosh after update
 as
 begin
    update kala set mojodi=mojodi+(select tedad from deleted) where kod in(select kodk from deleted)
	update kala set mojodi=mojodi-(select tedad from inserted) where kod in(select kodk from inserted)
 end 

 update forosh set tedad=2 where kodk=101

 create trigger moshtari_ins on moshtari after insert
 as begin
    delete from moshtari where nam='C5'
	print 'The customer with name of C5 can not be insereted in moshtari table'
 end

 insert into moshtari values(1004,'C6')
 select *from moshtari

 disable trigger moshtari_ins on moshtari
 drop trigger moshtari_ins

 insert into forosh values (100,1000,6),(100,1001,3)