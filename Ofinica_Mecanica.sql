DROP DATABASE IF EXISTS oficina_mecanica;
CREATE DATABASE oficina_mecanica;
USE oficina_mecanica;

-- Tabelas
CREATE TABLE services (
    idService INT AUTO_INCREMENT PRIMARY KEY,
    ServiceName ENUM('Manutencao', 'Revisao')
);

CREATE TABLE vehicles (
    idVehicle INT AUTO_INCREMENT PRIMARY KEY,
    VehicleBrand VARCHAR(50),
    VehicleModel VARCHAR(50),
    VehiclePlate VARCHAR(20) UNIQUE,
    ClientName VARCHAR(100),
    ClientPhone VARCHAR(15)
);

CREATE TABLE mechanics (
    idMechanic INT AUTO_INCREMENT PRIMARY KEY,
    MechanicName VARCHAR(100),
    Specialization ENUM('Motor', 'Eletrica', 'Suspensao', 'Geral')
);

CREATE TABLE orders (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idVehicle INT,
    idService INT,
    OrderDate DATE,
    OrderStatus ENUM('AguardandoAprovacao', 'Aprovado', 'EmAndamento', 'Concluido', 'Cancelado'),
    OrderDescription TEXT,
    FOREIGN KEY (idVehicle) REFERENCES vehicles(idVehicle),
    FOREIGN KEY (idService) REFERENCES services(idService)
);

CREATE TABLE order_mechanics (
    idOrder INT,
    idMechanic INT,
    PRIMARY KEY (idOrder, idMechanic),
    FOREIGN KEY (idOrder) REFERENCES orders(idOrder),
    FOREIGN KEY (idMechanic) REFERENCES mechanics(idMechanic)
);

CREATE TABLE budgets (
    idBudget INT AUTO_INCREMENT PRIMARY KEY,
    idOrder INT,
    BudgetAmount DECIMAL(10,2),
    BudgetDate DATE,
    BudgetStatus ENUM('Pendente', 'Aprovado', 'Negado'),
    FOREIGN KEY (idOrder) REFERENCES orders(idOrder)
);

-- Inserindo dados
INSERT INTO services (ServiceName)
VALUES
    ('Manutenção'),
    ('Revisão');

INSERT INTO vehicles (VehicleBrand, VehicleModel, VehiclePlate, ClientName, ClientPhone)
VALUES
    ('Honda', 'Civic', 'ABC1234', 'João Silva', '11987654321'),
    ('Fiat', 'Uno', 'DEF5678', 'Maria Oliveira', '11987654322'),
    ('Volkswagen', 'Gol', 'GHI9012', 'Pedro Santos', '11987654323');

INSERT INTO mechanics (MechanicName, Specialization)
VALUES
    ('José da Silva', 'Motor'),
    ('Ana Maria', 'Eletrica'),
    ('Carlos Pereira', 'Suspensão');

INSERT INTO orders (idVehicle, idService, OrderDate, OrderStatus, OrderDescription)
VALUES
    (1, 1, '2024-04-01', 'Concluido', 'Troca de óleo e filtro'),
    (2, 2, '2024-04-15', 'EmAndamento', 'Revisão completa'),
    (3, 1, '2024-05-01', 'AguardandoAprovacao', 'Troca de pastilhas de freio');

INSERT INTO order_mechanics (idOrder, idMechanic)
VALUES
    (1, 1),
    (2, 2),
    (3, 3);

INSERT INTO budgets (idOrder, BudgetAmount, BudgetDate, BudgetStatus)
VALUES
    (1, 250.00, '2024-03-25', 'Aprovado'),
    (2, 500.00, '2024-04-10', 'Aprovado'),
    (3, 150.00, '2024-04-28', 'Pendente');
    
    
-- Listar todos os veículos de um cliente específico. 

SELECT * 
FROM vehicles
WHERE ClientName = 'João Silva';

-- Listar todos os serviços realizados em um veículo específico, incluindo o mecânico responsável e a data do serviço.

SELECT o.idOrder, o.OrderDate, s.ServiceName, m.MechanicName
FROM orders o
INNER JOIN services s ON o.idService = s.idService
INNER JOIN order_mechanics om ON o.idOrder = om.idOrder
INNER JOIN mechanics m ON om.idMechanic = m.idMechanic
WHERE o.idVehicle = 1; 

--  Calculae a receita total gerada por cada tipo de serviço.

SELECT s.ServiceName, SUM(b.BudgetAmount) AS TotalRevenue
FROM services s
INNER JOIN orders o ON s.idService = o.idService
INNER JOIN budgets b ON o.idOrder = b.idOrder
WHERE b.BudgetStatus = 'Aprovado'
GROUP BY s.ServiceName;

