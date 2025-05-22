CREATE ROLE Admin;
GRANT ALL PRIVILEGES TO Admin;

CREATE ROLE Accountant;
GRANT SELECT ON Движение_продукции TO Accountant;
GRANT SELECT ON Партии TO Accountant;

CREATE ROLE Worker;
GRANT SELECT ON Производственные_нормы TO Worker;