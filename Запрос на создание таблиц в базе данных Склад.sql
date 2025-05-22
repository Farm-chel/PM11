CREATE TABLE Категории_продукции (
    id_категории INT PRIMARY KEY IDENTITY(1,1),
    название_категории VARCHAR(50) NOT NULL,
    описание TEXT
);

CREATE TABLE Продукция (
    id_продукции INT PRIMARY KEY IDENTITY(1,1),
    наименование VARCHAR(100) NOT NULL,
    id_категории INT NOT NULL,
    описание TEXT,
    единица_измерения VARCHAR(20) NOT NULL,
    стандартная_упаковка INT NOT NULL,
    срок_годности INT,
    FOREIGN KEY (id_категории) REFERENCES Категории_продукции(id_категории)
);

CREATE TABLE Склад (
    id_склада INT PRIMARY KEY IDENTITY(1,1),
    название VARCHAR(50) NOT NULL,
    адрес TEXT NOT NULL,
    ответственный VARCHAR(100) NOT NULL,
    телефон VARCHAR(20) NOT NULL
);

CREATE TABLE Партии (
    id_партии INT PRIMARY KEY IDENTITY(1,1),
    id_продукции INT NOT NULL,
    количество DECIMAL(10,2) NOT NULL,
    дата_производства DATE NOT NULL,
    срок_годности DATE NOT NULL,
    id_склада INT NOT NULL,
    статус VARCHAR(20) NOT NULL,
    номер_партии VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_продукции) REFERENCES Продукция(id_продукции),
    FOREIGN KEY (id_склада) REFERENCES Склад(id_склада)
);

CREATE TABLE Движение_продукции (
    id_движения INT PRIMARY KEY IDENTITY(1,1),
    id_партии INT NOT NULL,
    тип_операции VARCHAR(20) NOT NULL,
    количество DECIMAL(10,2) NOT NULL,
    дата_операции DATETIME NOT NULL,
    id_склада_отправителя INT,
    id_склада_получателя INT,
    документ_основание VARCHAR(100) NOT NULL,
    ответственный VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_партии) REFERENCES Партии(id_партии),
    FOREIGN KEY (id_склада_отправителя) REFERENCES Склад(id_склада),
    FOREIGN KEY (id_склада_получателя) REFERENCES Склад(id_склада)
);

CREATE TABLE Остатки (
    id_остатка INT PRIMARY KEY IDENTITY(1,1),
    id_продукции INT NOT NULL,
    id_склада INT NOT NULL,
    количество DECIMAL(10,2) NOT NULL,
    дата_обновления DATETIME NOT NULL,
    FOREIGN KEY (id_продукции) REFERENCES Продукция(id_продукции),
    FOREIGN KEY (id_склада) REFERENCES Склад(id_склада),
    CONSTRAINT UQ_Остатки_продукция_склад UNIQUE (id_продукции, id_склада)
);
CREATE TABLE Роли (
    id_роли INT PRIMARY KEY IDENTITY(1,1),
    название_роли VARCHAR(50) NOT NULL,
    описание TEXT
);

CREATE TABLE Сотрудники (
    id_сотрудника INT PRIMARY KEY IDENTITY(1,1),
    фио VARCHAR(100) NOT NULL,
    должность VARCHAR(50) NOT NULL,
    id_роли INT NOT NULL,
    логин VARCHAR(50) NOT NULL UNIQUE,
    пароль VARCHAR(100) NOT NULL,
    дата_приема DATE NOT NULL,
    телефон VARCHAR(20),
    email VARCHAR(100),
    FOREIGN KEY (id_роли) REFERENCES Роли(id_роли)
);

CREATE TABLE История_входов (
    id_записи INT PRIMARY KEY IDENTITY(1,1),
    id_сотрудника INT NOT NULL,
    дата_входа DATETIME NOT NULL,
    ip_адрес VARCHAR(50),
    устройство VARCHAR(100),
    FOREIGN KEY (id_сотрудника) REFERENCES Сотрудники(id_сотрудника)
);

CREATE TABLE Производственные_нормы (
    id_нормы INT PRIMARY KEY IDENTITY(1,1),
    id_продукции INT NOT NULL,
    норма_в_день INT NOT NULL,
    дата_начала DATE NOT NULL,
    дата_окончания DATE,
    FOREIGN KEY (id_продукции) REFERENCES Продукция(id_продукции)
);
CREATE TABLE Материалы (
    id_материала INT PRIMARY KEY IDENTITY(1,1),
    наименование NVARCHAR(100) NOT NULL,
    единица_измерения NVARCHAR(20) NOT NULL,
    текущий_остаток DECIMAL(10,2) DEFAULT 0,
    минимальный_запас DECIMAL(10,2) DEFAULT 0
);

CREATE TABLE Продукция_Материалы (
    id_связи INT PRIMARY KEY IDENTITY(1,1),
    id_продукции INT NOT NULL,
    id_материала INT NOT NULL,
    количество_на_единицу DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_продукции) REFERENCES Продукция(id_продукции),
    FOREIGN KEY (id_материала) REFERENCES Материалы(id_материала)
);

-- Вставляем основные роли
INSERT INTO Роли (название_роли, описание) VALUES
('Администратор', 'Полный доступ ко всем функциям системы'),
('Бухгалтер', 'Доступ к финансовым отчетам и операциям'),
('Сотрудник', 'Доступ к производственным задачам и личной информации');

-- Вставляем тестовых пользователей
INSERT INTO Сотрудники (фио, должность, id_роли, логин, пароль, дата_приема) VALUES
('Иванов Иван Иванович', 'Системный администратор', 1, 'admin', 'admin123', '2020-01-15'),
('Петрова Анна Сергеевна', 'Главный бухгалтер', 2, 'accountant', 'account123', '2019-05-10'),
('Сидоров Василий Михайлович', 'Начальник производства', 3, 'worker', 'worker123', '2021-03-20');
ALTER TABLE Сотрудники
ADD исходный_пароль NVARCHAR(100) NULL;
-- Добавляем столбцы себестоимости и цены продажи
ALTER TABLE Партии
ADD себестоимость DECIMAL(10,2) DEFAULT 0 NOT NULL,
    цена_продажи DECIMAL(10,2) DEFAULT 0 NOT NULL;

-- Обновляем тестовые данные
UPDATE Партии SET
    себестоимость = CASE id_продукции
        WHEN 1 THEN 10.50  -- Спички бытовые
        WHEN 2 THEN 25.00  -- Зажигалки
        WHEN 3 THEN 5.00   -- Коробки
        WHEN 4 THEN 150.00 -- Сувенирные наборы
        WHEN 5 THEN 30.00  -- Ветроустойчивые спички
    END,
    цена_продажи = CASE id_продукции
        WHEN 1 THEN 15.00
        WHEN 2 THEN 40.00
        WHEN 3 THEN 8.00
        WHEN 4 THEN 200.00
        WHEN 5 THEN 45.00
    END;