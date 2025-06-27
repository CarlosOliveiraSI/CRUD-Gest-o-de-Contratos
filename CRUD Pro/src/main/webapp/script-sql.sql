DROP DATABASE IF EXISTS crud_manager;

CREATE DATABASE IF NOT EXISTS crud_manager;

USE crud_manager;


CREATE TABLE IF NOT EXISTS empresas (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(255) NOT NULL,
    cnpj VARCHAR(18) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS contratos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_contrato VARCHAR(50) NOT NULL UNIQUE,  
    objeto_contrato TEXT NOT NULL,                
    data_assinatura DATE NOT NULL,                
    valor_total DECIMAL(12, 2) NOT NULL,          
    status_ativo BOOLEAN DEFAULT TRUE,            
    empresa_id INT NOT NULL,
    CONSTRAINT fk_contrato_empresa
        FOREIGN KEY (empresa_id)
        REFERENCES empresas(id)
);

select * from empresas;

