**Estrutura do Banco de Dados: Oficina Mecânica**

**Objetivo:**
Este banco de dados tem como objetivo gerenciar as informações de uma oficina mecânica, desde veículos e clientes até serviços realizados e orçamentos.

**Tabelas e seus Atributos:**

* **vehicles:**
    * idVehicle (INT, PK): Identificador único do veículo.
    * VehicleBrand (VARCHAR): Marca do veículo.
    * VehicleModel (VARCHAR): Modelo do veículo.
    * VehiclePlate (VARCHAR, UNIQUE): Placa do veículo.
    * ClientName (VARCHAR): Nome do cliente.
    * ClientPhone (VARCHAR): Telefone do cliente.

* **services:**
    * idService (INT, PK): Identificador único do serviço.
    * ServiceName (ENUM): Tipo de serviço (Manutenção, Revisão).

* **mechanics:**
    * idMechanic (INT, PK): Identificador único do mecânico.
    * MechanicName (VARCHAR): Nome do mecânico.
    * Specialization (ENUM): Especialização do mecânico (Motor, Eletrica, Suspensao, Geral).

* **orders:**
    * idOrder (INT, PK): Identificador único do pedido.
    * idVehicle (INT, FK): Referência ao veículo.
    * idService (INT, FK): Referência ao serviço.
    * OrderDate (DATE): Data do pedido.
    * OrderStatus (ENUM): Status do pedido (AguardandoAprovacao, Aprovado, EmAndamento, Concluido, Cancelado).
    * OrderDescription (TEXT): Descrição do pedido.

* **order_mechanics:**
    * idOrder (INT, PK): Referência ao pedido.
    * idMechanic (INT, PK): Referência ao mecânico.
    * **Chave primária composta:** (idOrder, idMechanic) para relacionar um pedido a múltiplos mecânicos.

* **budgets:**
    * idBudget (INT, PK): Identificador único do orçamento.
    * idOrder (INT, FK): Referência ao pedido.
    * BudgetAmount (DECIMAL): Valor do orçamento.
    * BudgetDate (DATE): Data do orçamento.
    * BudgetStatus (ENUM): Status do orçamento (Pendente, Aprovado, Negado).

**Relações entre as Tabelas:**

* Um veículo pode ter vários pedidos.
* Um serviço pode ser associado a múltiplos pedidos.
* Um pedido pode ter múltiplos mecânicos.
* Um pedido tem um único orçamento.
* Um orçamento é relacionado a um único pedido.

**Observações:**

* **Chaves Primárias (PK):** Identificam de forma única cada registro em uma tabela.
* **Chaves Estrangeiras (FK):** Estabelecem relacionamentos entre as tabelas.
* **ENUM:** Tipo de dado que limita os valores possíveis a um conjunto predefinido.
