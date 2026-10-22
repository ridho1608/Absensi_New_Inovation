-- 1. Tabel Users (Mahasiswa, Dosen, Admin)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nomor_induk VARCHAR(20) NOT NULL UNIQUE, -- NPM atau NIDN
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('mahasiswa', 'dosen', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabel Classes (Mata Kuliah / Sesi Kelas)
CREATE TABLE classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kode_mk VARCHAR(10) NOT NULL,
    nama_mk VARCHAR(100) NOT NULL,
    dosen_id INT NOT NULL,
    ruangan VARCHAR(20) NOT NULL,
    hari VARCHAR(10) NOT NULL,
    jam_mulai TIME NOT NULL,
    jam_selesai TIME NOT NULL,
    lat_kampus DECIMAL(10, 8) NOT NULL, -- Koordinat pusat kampus
    long_kampus DECIMAL(11, 8) NOT NULL,
    radius_meter INT DEFAULT 50, -- Toleransi radius GPS (meter)
    wifi_ssid VARCHAR(50) DEFAULT 'Kampus-WiFi',
    FOREIGN KEY (dosen_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 3. Tabel Attendances (Log Presensi Mahasiswa)
CREATE TABLE attendances (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    class_id INT NOT NULL,
    waktu_absen TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Hadir', 'Izin', 'Sakit', 'Alfa') DEFAULT 'Hadir',
    user_lat DECIMAL(10, 8),
    user_long DECIMAL(11, 8),
    user_wifi VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(id) ON DELETE CASCADE
);