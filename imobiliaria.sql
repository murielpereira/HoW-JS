ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'admin';

create schema imobiliaria;

create table imoveis(
id_imovel int primary key auto_increment,
descricao_imovel varchar(80),
tipo_imovel varchar(20),
cidade_imovel varchar(40),
estado_imovel varchar(2)
);

insert into imoveis(descricao_imovel, tipo_imovel, cidade_imovel, estado_imovel)
values
("casa de 200m², 1 banheiro, 3 quartos", "casa", "São João Batista", "SC"),
("apartamento de 180m², 1 banheiro, 2 quartos", "apartamento", "Tijucas", "SC"),
("casa de 350m², 2 banheiros, 4 quartos", "casa", "Itapema", "SC"),
("casa de 195m², 1 banheiro, 2 quartos", "casa", "Curitiba", "PR"),
("sala comercia de 300m², 1 banheiro", "sala", "Novo Hamburgo", "RS"),
("apartamento de 90m², 1 banheiro, 1 quartos", "apartamento", "Contagem", "MG"),
("sitio de 700m², 3 banheiro, 6 quartos", "sitio", "Major Gercino", "SC"),
("apartamento de 110m², 1 banheiro, 2 quartos", "apartamento", "Itajai", "SC"),
("casa de 200m², 1 banheiro, 2 quartos", "casa", "Morro Reuter", "RS");

select * from imoveis;

create table pagamentos(
id_pagamento int primary key auto_increment,
data_pagamento date,
valor_pagamento decimal(6, 2),
fkid_imovel int,
foreign key (fkid_imovel) references imoveis(id_imovel)
);

insert into pagamentos (data_pagamento, valor_pagamento, fkid_imovel) 
values
('2023-01-01', 1000.00, 1),
('2023-02-02', 750.50, 2),
('2023-03-03', 1200.75, 3),
('2023-04-04', 850.25, 4),
('2023-05-05', 900.00, 5),
('2023-06-06', 1100.00, 6),
('2023-07-07', 950.50, 7),
('2023-08-08', 1300.25, 8),
('2023-09-09', 880.75, 9),
('2023-02-01', 1000.00, 1),
('2023-03-02', 750.50, 2),
('2023-04-03', 1200.75, 3),
('2023-05-04', 850.25, 4),
('2023-06-05', 900.00, 5),
('2023-07-06', 1100.00, 6),
('2023-08-07', 950.50, 7),
('2023-09-08', 1300.25, 8),
('2023-10-09', 880.75, 9),
('2023-03-01', 1000.00, 1),
('2023-04-02', 750.50, 2),
('2023-05-03', 1200.75, 3),
('2023-06-04', 850.25, 4),
('2023-07-05', 900.00, 5),
('2023-08-06', 1100.00, 6),
('2023-09-07', 950.50, 7),
('2023-10-08', 1300.25, 8),
('2023-11-09', 880.75, 9),
('2023-04-01', 1000.00, 1),
('2023-05-02', 750.50, 2),
('2023-06-03', 1200.75, 3),
('2023-07-04', 850.25, 4),
('2023-08-05', 900.00, 5),
('2023-09-06', 1100.00, 6),
('2023-10-07', 950.50, 7),
('2023-11-08', 1300.25, 8),
('2023-12-09', 880.75, 9),
('2023-05-01', 1000.00, 1),
('2023-06-02', 750.50, 2),
('2023-07-03', 1200.75, 3),
('2023-08-04', 850.25, 4),
('2023-09-05', 900.00, 5);

select * from pagamentos;

select * from pagamentos order by fkid_imovel, data_pagamento;

select * from pagamentos inner join imoveis on pagamentos.fkid_imovel = imoveis.id_imovel;

select * from pagamentos inner join imoveis on pagamentos.fkid_imovel = imoveis.id_imovel order by data_pagamento;

select * from pagamentos inner join imoveis on pagamentos.fkid_imovel = imoveis.id_imovel order by tipo_imovel;

select * from pagamentos inner join imoveis on pagamentos.fkid_imovel = imoveis.id_imovel order by id_pagamento;

select tipo_imovel, COUNT(*) AS total_vendas from pagamentos inner join imoveis on pagamentos.fkid_imovel = imoveis.id_imovel GROUP BY tipo_imovel;

SELECT COUNT(*) AS total_pagamentos
FROM imobiliaria.pagamentos;
