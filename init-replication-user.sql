-- init-replication-user.sql

-- 1. Buat database 'inventory' terlebih dahulu.
CREATE DATABASE inventory;

-- 2. Koneksi ke database 'inventory'.
\connect inventory;

-- 3. Buat tabel produk di dalam database 'inventory' (public schema).
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    quantity INT,
    price NUMERIC(10,2)
);

-- 4. Masukkan data awal.
INSERT INTO products (name, quantity, price) VALUES
    ('Apple', 100, 0.50),
    ('Banana', 150, 0.30),
    ('Orange', 120, 0.40);

-- 5. Buat user Debezium (replication_user)
CREATE USER replication_user WITH PASSWORD 'replication_pass';
ALTER USER replication_user WITH REPLICATION; -- Penting untuk Debezium CDC

-- 6. Berikan izin akses pada user 'replication_user'.
GRANT CONNECT ON DATABASE inventory TO replication_user;
GRANT USAGE ON SCHEMA public TO replication_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO replication_user;

-- (Opsional) Tetapkan izin default untuk tabel yang akan dibuat di masa mendatang
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO replication_user;
GRANT CREATE ON DATABASE inventory TO replication_user;
ALTER ROLE replication_user WITH SUPERUSER;
