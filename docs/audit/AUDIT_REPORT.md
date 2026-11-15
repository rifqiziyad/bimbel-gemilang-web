# Laporan Audit & Ekstraksi WordPress Lokal (Bimbel Gemilang)

- **Tanggal Audit:** 15 November 2026
- **Sumber Data:** LocalWP (`http://gemilang2.local` / `/Users/rifqiziyadimtinan/Local Sites/gemilang2`)
- **Web Server:** Nginx 1.26.1 + PHP 8.2.27
- **Tema Utama:** Astra (`astra`)
- **Page Builder / Blok:** Spectra / Ultimate Addons for Gutenberg (`uagb`), Cozy Addons, SureForms, MetaSlider.

---

## 1. Inventarisasi Halaman Publik & Struktur Menu

### Menu Navigasi Utama (Header)
1. **Home** (`/`)
2. **Program** (`/program/` dropdown/sub-menu):
   - **PTN & TKA** (`/ptn-tka/`)
   - **Bimbel SD, SMP, & SMA** (`/bimbel-sd-smp-sma/`)
   - **English for Kids** (`/english-for-kids/`)
   - **Program Khusus** (`/program-khusus/`)
3. **Tentang Kami** (`/contact/` dropdown/sub-menu):
   - **Siapa Kami** (`/siapa-kami/`)
   - **Alamat & Kontak Kami** (`/alamat-kontak-kami/`)

### Daftar Halaman (Total 10 Pages)
| ID | Judul Halaman | Slug | Status Konten | Tindakan Migrasi |
| :--- | :--- | :--- | :--- | :--- |
| `3572` | **Home** | `home` (`/`) | Berisi Hero, Statistik (2005, 5100+ alumni, 80% PTN), Keunggulan, Daftar Program, Testimoni Alumni, & CTA. | Halaman Beranda Utama |
| `1395` | **Program** | `program` (`/program/`) | Landing overview katalog program. | Halaman Program Overview |
| `3483` | **PTN & TKA** | `ptn-tka` (`/ptn-tka/`) | Program intensif PTN (SNBP/SNBT/Mandiri), rincian alumni (UI, ITB, UGM, Unpad), harga/fasilitas. | Halaman Detail Program |
| `3457` | **Bimbel SD, SMP, & SMA** | `bimbel-sd-smp-sma` (`/bimbel-sd-smp-sma/`) | Kelas reguler SD/SMP/SMA, rincian biaya (SD 300rb-350rb, SMP 400rb, SMA 500rb), paket intensif. | Halaman Detail Program |
| `3458` | **English for Kids** | `english-for-kids` (`/english-for-kids/`) | Program bahasa Inggris anak: Starter, Elementary, Intermediate, Advance. | Halaman Detail Program |
| `3459` | **Program Khusus** | `program-khusus` (`/program-khusus/`) | Privat 1-on-1, TOEFL/IELTS, olah data skripsi/tesis, beasiswa. | Halaman Detail Program |
| `3467` | **Siapa Kami** | `siapa-kami` (`/siapa-kami/`) | Profil Bimbel Gemilang, visi-misi, sejarah sejak 2005, legalitas & pengajar. | Halaman Tentang Kami |
| `3468` | **Alamat & Kontak Kami** | `alamat-kontak-kami` (`/alamat-kontak-kami/`) | Lokasi lengkap Cirendeu Ciputat Timur, radius landmark sekolah sekitar, jam operasional, IG, WA. | Halaman Kontak Utama |
| `1399` | **Contact** | `contact` (`/contact/`) | Halaman kontak dummy bawaan template starter Astra (alamat default +1 123-456). | Dimerge/Redirect 301 ke `/alamat-kontak-kami` |
| `4515` | **Program PTN** | `program-ptn` (`/program-ptn/`) | Halaman kosong (draft/duplikat dari `ptn-tka`). | Redirect 301 ke `/ptn-tka` |

---

## 2. Inventarisasi Media & Formulir

- **Media Uploads:**
  - 110 item media terekstrak di `docs/audit/wp-export/media.json`.
  - Folder upload fisik telah disalin ke `public/wp-uploads/` (total 87 MB: foto alumni, foto kelas, logo, icon).
- **Formulir Kontak / Pendaftaran:**
  - Terdeteksi plugin **SureForms** dengan form `Simple Contact Form` (ID `3414`, slug `simple-contact-form`).
  - Form menampung: Nama Siswa/Orang Tua, Nomor WhatsApp/Telepon, Pilihan Kelas/Program, Pesan/Pertanyaan.
  - **Tindakan Next.js:** Digantikan dengan Server Action terintegrasi Zod yang langsung menyimpan data calon siswa ke database portal admin (`/admin/leads`) + opsi notifikasi WhatsApp otomatis.

---

## 3. Screenshot Baseline Visual (Parity Reference)

Telah disimpan 18 file screenshot *full-page* (Desktop 1440px & Mobile 390px) di `docs/audit/screenshots/`:
- `home-desktop-1440.png` & `home-mobile-390.png`
- `program-desktop-1440.png` & `program-mobile-390.png`
- `ptn-tka-desktop-1440.png` & `ptn-tka-mobile-390.png`
- `bimbel-sd-smp-sma-desktop-1440.png` & `bimbel-sd-smp-sma-mobile-390.png`
- `english-for-kids-desktop-1440.png` & `english-for-kids-mobile-390.png`
- `program-khusus-desktop-1440.png` & `program-khusus-mobile-390.png`
- `siapa-kami-desktop-1440.png` & `siapa-kami-mobile-390.png`
- `alamat-kontak-kami-desktop-1440.png` & `alamat-kontak-kami-mobile-390.png`
- `contact-desktop-1440.png` & `contact-mobile-390.png`

---

## 4. Rencana Aturan 301 Redirect (`next.config.ts`)

| URL Lama WordPress | URL Target Next.js | Alasan |
| :--- | :--- | :--- |
| `/home` | `/` | Standarisasi root homepage |
| `/contact/` | `/alamat-kontak-kami` | URL template lama diarahkan ke halaman kontak resmi bimbel |
| `/program-ptn/` | `/ptn-tka` | Halaman kosong diarahkan ke halaman resmi program PTN |
