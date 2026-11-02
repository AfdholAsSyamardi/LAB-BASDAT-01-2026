CREATE TABLE anggota (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_anggota VARCHAR(50) NOT NULL,
	kota_domisili VARCHAR (20) NOT NULL
);


CREATE TABLE buku(
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	judul_buku VARCHAR(100) NOT NULL,
	genre VARCHAR (20) NOT NULL,
	stok INTEGER DEFAULT 1
);

CREATE TABLE peminjaman (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	id_anggota INTEGER REFERENCES anggota (id),
	id_buku INTEGER REFERENCES buku(id),
	tanggal_pinjam DATE NOT NULL,
	tanggal_kembali DATE NULL,
	denda INTEGER DEFAULT 0
);

CREATE INDEX idx_buku_genre ON buku(genre);
CREATE INDEX idx_kota_domisili ON anggota(kota_domisili);