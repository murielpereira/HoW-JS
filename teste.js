const express = require('express');//npm install express
const mysql = require('mysql');//npm install mysql

const app = express();
app.listen(3000);//initialize web server

//initialize mysql connection
const MYSQL_IP="localhost";
const MYSQL_LOGIN="root";
const MYSQL_PASSWORD="admin";

let con = mysql.createConnection({
  host:  MYSQL_IP,
  user: MYSQL_LOGIN,
  password: MYSQL_PASSWORD,
  database: "imobiliaria"
});

con.connect(function(err) {
  if (err){
    console.log(err);
    throw err;
  }
  console.log("Conectado ao DB");
});

/*

// Inicio consulta teste

con.query('select * from pagamentos inner join imoveis on pagamentos.fkid_imovel = imoveis.id_imovel order by id_pagamento;', (err, results) => {
  if (err) {
    console.error('Erro na consulta:', err);
    return;
  }
  console.log('Resultados da consulta:', results);
  console.log('-------------------------------------------------------------------------------');
});
// Fim consulta teste

console.log('chegou aqui 1');

*/

// Inicio consulta soma

con.query('select id_imovel, valor_pagamento from pagamentos inner join imoveis on pagamentos.fkid_imovel = imoveis.id_imovel order by id_imovel;', (err, results1) => {
  if (err) {
    console.error('Erro na consulta:', err);
    return;
  }else{
    let totalPorImovel = new Map();
    
    results1.forEach ( record => {
      
      if(totalPorImovel.get(record['id_imovel']) === undefined){
        totalPorImovel.set(record['id_imovel'], {
          soma: record['valor_pagamento'], 
          imovel: record['id_imovel']
        });
      }else{
        totalPorImovel.get(record['id_imovel']).soma += record['valor_pagamento'];
      }
   });
  console.log('Total por imovel: ',totalPorImovel);
  console.log('-------------------------------------------------------------------------------');
}
})

// Fim consulta soma

// Inicio consulta soma por mes

con.query('select id_imovel,valor_pagamento, year(data_pagamento) as ano, month(data_pagamento) as mes from pagamentos inner join imoveis on pagamentos.fkid_imovel = imoveis.id_imovel', (err, results2) => {
  if (err) {
    console.error('Erro na consulta:', err);
    return;
  }else{
    let totalPorMes = new Map()
    
    results2.forEach ( record => {

      let periodKey = record['ano']+"_"+ record['mes'];
      if(totalPorMes.get(periodKey) === undefined){
        totalPorMes.set(periodKey , {
          valor: record['valor_pagamento'], 
          ano : record['ano'],
          mes: record['mes']
        });
      }else{
        totalPorMes.get(periodKey).valor += record['valor_pagamento'];
      }
   });
  
   let arrayTotalPorMes = Array.from(totalPorMes.values());
   arrayTotalPorMes = arrayTotalPorMes.sort((a, b) => b.valor - a.valor);
   
    console.log('Total por mes: ',arrayTotalPorMes);
    console.log('-------------------------------------------------------------------------------');
  }
})

// Fim consulta soma mes

// Inicio consulta porcentagem de venda por tipo de imovel

  // Consulta o total de pagamentos
  con.query('SELECT COUNT(*) AS total_pagamentos FROM pagamentos;', (err, results4) => {
    if (err) {
      console.error('Erro na consulta:', err);
      return con.end();
    }

    // Obtemos o total de pagamentos
    const totalPagamentos = results4[0].total_pagamentos;

    // Consulta a quantidade de vendas por tipo de imóvel
    con.query('SELECT tipo_imovel, COUNT(*) AS total_vendas FROM pagamentos INNER JOIN imoveis ON pagamentos.fkid_imovel = imoveis.id_imovel GROUP BY tipo_imovel;', (err, results3) => {
      if (err) {
        console.error('Erro na consulta:', err);
        return con.end();
      }

      // Calcula o percentual de vendas de cada tipo de imóvel
      const vendasPorTipoImovel = results3.map((record) => {
        return {
          tipoImovel: record.tipo_imovel,
          percentual: (record.total_vendas / totalPagamentos) * 100
        };
      });

      vendasPorTipoImovel.sort((a, b) => b.percentual - a.percentual);

      console.log('Porcentagem de vendas por tipo de imóvel:', vendasPorTipoImovel);
      con.end();
    });
  });

  // Fim consulta porcentagem de venda por tipo de imovel