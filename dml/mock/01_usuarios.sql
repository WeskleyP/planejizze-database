insert into usuario (id, email, username, nome, sobrenome, senha, active, email_verified)
values( 1, 'weskleypedro@gmail.com', 'weskley.oliveira', 'Weskley', 'Pedro',
        '$2y$12$RluCwvkzkPZ.mm4uE/eUEu0/lBHWudVBdg3iRDhXxbFhBmTarj87C', true, true); -- senha = 123456
insert into usuario_role (role_id , usuario_id) values(1, 1);
insert into usuario_role (role_id , usuario_id) values(2, 1);
insert into usuario_role (role_id , usuario_id) values(3, 1);