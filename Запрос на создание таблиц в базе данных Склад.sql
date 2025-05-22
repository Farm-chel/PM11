CREATE TABLE ���������_��������� (
    id_��������� INT PRIMARY KEY IDENTITY(1,1),
    ��������_��������� VARCHAR(50) NOT NULL,
    �������� TEXT
);

CREATE TABLE ��������� (
    id_��������� INT PRIMARY KEY IDENTITY(1,1),
    ������������ VARCHAR(100) NOT NULL,
    id_��������� INT NOT NULL,
    �������� TEXT,
    �������_��������� VARCHAR(20) NOT NULL,
    �����������_�������� INT NOT NULL,
    ����_�������� INT,
    FOREIGN KEY (id_���������) REFERENCES ���������_���������(id_���������)
);

CREATE TABLE ����� (
    id_������ INT PRIMARY KEY IDENTITY(1,1),
    �������� VARCHAR(50) NOT NULL,
    ����� TEXT NOT NULL,
    ������������� VARCHAR(100) NOT NULL,
    ������� VARCHAR(20) NOT NULL
);

CREATE TABLE ������ (
    id_������ INT PRIMARY KEY IDENTITY(1,1),
    id_��������� INT NOT NULL,
    ���������� DECIMAL(10,2) NOT NULL,
    ����_������������ DATE NOT NULL,
    ����_�������� DATE NOT NULL,
    id_������ INT NOT NULL,
    ������ VARCHAR(20) NOT NULL,
    �����_������ VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_���������) REFERENCES ���������(id_���������),
    FOREIGN KEY (id_������) REFERENCES �����(id_������)
);

CREATE TABLE ��������_��������� (
    id_�������� INT PRIMARY KEY IDENTITY(1,1),
    id_������ INT NOT NULL,
    ���_�������� VARCHAR(20) NOT NULL,
    ���������� DECIMAL(10,2) NOT NULL,
    ����_�������� DATETIME NOT NULL,
    id_������_����������� INT,
    id_������_���������� INT,
    ��������_��������� VARCHAR(100) NOT NULL,
    ������������� VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_������) REFERENCES ������(id_������),
    FOREIGN KEY (id_������_�����������) REFERENCES �����(id_������),
    FOREIGN KEY (id_������_����������) REFERENCES �����(id_������)
);

CREATE TABLE ������� (
    id_������� INT PRIMARY KEY IDENTITY(1,1),
    id_��������� INT NOT NULL,
    id_������ INT NOT NULL,
    ���������� DECIMAL(10,2) NOT NULL,
    ����_���������� DATETIME NOT NULL,
    FOREIGN KEY (id_���������) REFERENCES ���������(id_���������),
    FOREIGN KEY (id_������) REFERENCES �����(id_������),
    CONSTRAINT UQ_�������_���������_����� UNIQUE (id_���������, id_������)
);
CREATE TABLE ���� (
    id_���� INT PRIMARY KEY IDENTITY(1,1),
    ��������_���� VARCHAR(50) NOT NULL,
    �������� TEXT
);

CREATE TABLE ���������� (
    id_���������� INT PRIMARY KEY IDENTITY(1,1),
    ��� VARCHAR(100) NOT NULL,
    ��������� VARCHAR(50) NOT NULL,
    id_���� INT NOT NULL,
    ����� VARCHAR(50) NOT NULL UNIQUE,
    ������ VARCHAR(100) NOT NULL,
    ����_������ DATE NOT NULL,
    ������� VARCHAR(20),
    email VARCHAR(100),
    FOREIGN KEY (id_����) REFERENCES ����(id_����)
);

CREATE TABLE �������_������ (
    id_������ INT PRIMARY KEY IDENTITY(1,1),
    id_���������� INT NOT NULL,
    ����_����� DATETIME NOT NULL,
    ip_����� VARCHAR(50),
    ���������� VARCHAR(100),
    FOREIGN KEY (id_����������) REFERENCES ����������(id_����������)
);

CREATE TABLE ����������������_����� (
    id_����� INT PRIMARY KEY IDENTITY(1,1),
    id_��������� INT NOT NULL,
    �����_�_���� INT NOT NULL,
    ����_������ DATE NOT NULL,
    ����_��������� DATE,
    FOREIGN KEY (id_���������) REFERENCES ���������(id_���������)
);
CREATE TABLE ��������� (
    id_��������� INT PRIMARY KEY IDENTITY(1,1),
    ������������ NVARCHAR(100) NOT NULL,
    �������_��������� NVARCHAR(20) NOT NULL,
    �������_������� DECIMAL(10,2) DEFAULT 0,
    �����������_����� DECIMAL(10,2) DEFAULT 0
);

CREATE TABLE ���������_��������� (
    id_����� INT PRIMARY KEY IDENTITY(1,1),
    id_��������� INT NOT NULL,
    id_��������� INT NOT NULL,
    ����������_��_������� DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_���������) REFERENCES ���������(id_���������),
    FOREIGN KEY (id_���������) REFERENCES ���������(id_���������)
);

-- ��������� �������� ����
INSERT INTO ���� (��������_����, ��������) VALUES
('�������������', '������ ������ �� ���� �������� �������'),
('���������', '������ � ���������� ������� � ���������'),
('���������', '������ � ���������������� ������� � ������ ����������');

-- ��������� �������� �������������
INSERT INTO ���������� (���, ���������, id_����, �����, ������, ����_������) VALUES
('������ ���� ��������', '��������� �������������', 1, 'admin', 'admin123', '2020-01-15'),
('������� ���� ���������', '������� ���������', 2, 'accountant', 'account123', '2019-05-10'),
('������� ������� ����������', '��������� ������������', 3, 'worker', 'worker123', '2021-03-20');
ALTER TABLE ����������
ADD ��������_������ NVARCHAR(100) NULL;
-- ��������� ������� ������������� � ���� �������
ALTER TABLE ������
ADD ������������� DECIMAL(10,2) DEFAULT 0 NOT NULL,
    ����_������� DECIMAL(10,2) DEFAULT 0 NOT NULL;

-- ��������� �������� ������
UPDATE ������ SET
    ������������� = CASE id_���������
        WHEN 1 THEN 10.50  -- ������ �������
        WHEN 2 THEN 25.00  -- ���������
        WHEN 3 THEN 5.00   -- �������
        WHEN 4 THEN 150.00 -- ���������� ������
        WHEN 5 THEN 30.00  -- ��������������� ������
    END,
    ����_������� = CASE id_���������
        WHEN 1 THEN 15.00
        WHEN 2 THEN 40.00
        WHEN 3 THEN 8.00
        WHEN 4 THEN 200.00
        WHEN 5 THEN 45.00
    END;