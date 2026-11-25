
-- База данных "Туризм"
DROP DATABASE IF EXISTS tourism;
CREATE DATABASE tourism
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE tourism;


-- Клиенты
CREATE TABLE clients (
    client_id     INT AUTO_INCREMENT PRIMARY KEY,
    last_name     VARCHAR(50)  NOT NULL,
    first_name    VARCHAR(50)  NOT NULL,
    passport      VARCHAR(20)  NOT NULL UNIQUE,
    phone         VARCHAR(20),
    email         VARCHAR(100),
    birth_date    DATE
) ENGINE=InnoDB;


-- Туры (направления)

CREATE TABLE tours (
    tour_id       INT AUTO_INCREMENT PRIMARY KEY,
    tour_name     VARCHAR(100) NOT NULL,
    country       VARCHAR(60)  NOT NULL,
    city          VARCHAR(60),
    duration_days INT          NOT NULL CHECK (duration_days > 0),
    base_price    DECIMAL(10,2) NOT NULL CHECK (base_price >= 0)
) ENGINE=InnoDB;


-- Дополнительные услуги

CREATE TABLE services (
    service_id    INT AUTO_INCREMENT PRIMARY KEY,
    service_name  VARCHAR(100) NOT NULL,
    price         DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    description   VARCHAR(255)
) ENGINE=InnoDB;


-- Сотрудники (менеджеры)

CREATE TABLE employees (
    employee_id   INT AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    position      VARCHAR(50)  NOT NULL,
    phone         VARCHAR(20),
    hire_date     DATE
) ENGINE=InnoDB;


-- Заказы

CREATE TABLE orders (
    order_id      INT AUTO_INCREMENT PRIMARY KEY,
    order_date    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    client_id     INT          NOT NULL,
    tour_id       INT          NOT NULL,
    service_id    INT,                 -- услуга необязательна
    employee_id   INT          NOT NULL,
    persons_count INT          NOT NULL DEFAULT 1 CHECK (persons_count > 0),
    total_price   DECIMAL(10,2) NOT NULL CHECK (total_price >= 0),
    status        ENUM('new','paid','cancelled','completed')
                  NOT NULL DEFAULT 'new',

    CONSTRAINT fk_orders_client
        FOREIGN KEY (client_id)   REFERENCES clients(client_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_orders_tour
        FOREIGN KEY (tour_id)     REFERENCES tours(tour_id)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_orders_service
        FOREIGN KEY (service_id)  REFERENCES services(service_id)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_orders_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Проверочные данные

INSERT INTO clients (last_name, first_name, passport, phone, email, birth_date) VALUES
('Иванов','Пётр','4501 123456','+7 900 111-11-11','ivanov@mail.ru','1990-05-12'),
('Сидорова','Анна','4502 654321','+7 900 222-22-22','sidorova@mail.ru','1985-11-03'),
('Кузнецов','Олег','4503 777888','+7 900 333-33-33','kuznetsov@mail.ru','1998-02-20');

INSERT INTO tours (tour_name, country, city, duration_days, base_price) VALUES
('Пляжный рай','Турция','Анталья',7, 45000.00),
('Римские каникулы','Италия','Рим',5, 62000.00),
('Сафари','Кения','Найроби',10, 120000.00);

INSERT INTO services (service_name, price, description) VALUES
('Медицинская страховка', 2500.00, 'Покрытие до 1 млн руб.'),
('Трансфер аэропорт-отель', 1500.00, 'Индивидуальный трансфер'),
('Экскурсия "Старый город"', 3000.00, 'Гид на русском');

INSERT INTO employees (full_name, position, phone, hire_date) VALUES
('Смирнова Елена','Менеджер по продажам','+7 495 100-00-01','2019-03-01'),
('Петров Дмитрий','Старший менеджер','+7 495 100-00-02','2017-09-15');

INSERT INTO orders (client_id, tour_id, service_id, employee_id, persons_count, total_price, status) VALUES
(1, 1, 1, 1, 2, 92500.00, 'paid'),
(2, 2, NULL, 2, 1, 62000.00, 'new'),
(3, 3, 3, 1, 4, 483000.00, 'paid');
