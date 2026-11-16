# Product Requirements Document (PRD) — Bimbel Gemilang Web & Portal Admin

- **Versi:** 1.0 (Locked for Phase 3 & Phase 4)
- **Tanggal:** 15 November 2026
- **Tech Stack (Opsi B):** Next.js (App Router) + React 19 + Tailwind CSS v4 (`@theme`) + TypeScript (`strict: true`) + Drizzle ORM + LibSQL/SQLite
- **Referensi Audit:** [AUDIT_REPORT.md](file:///Users/rifqiziyadimtinan/Documents/Work/Bimbel%20Gemilang/bimbel-gemilang-web/docs/audit/AUDIT_REPORT.md)

---

## 1. Ringkasan Eksekutif & Tujuan Produk

Bimbel Gemilang (*Lembaga Pendidikan Gemilang Bimbingan Belajar — Private & Study Club, sejak 2005*) memigrasikan situs WordPress lokal (`gemilang2.local`) menuju aplikasi web modern berbasis Next.js yang cepat, aman, SEO-friendly, dan dilengkapi **Portal Admin Simpel (`/admin`)**.

### Tujuan Utama
1. **Performa & Kualitas Web Modern:** Menghilangkan bloat plugin Astra/Spectra/Cozy/SureForms/MetaSlider, menargetkan skor Lighthouse >= 95 di semua metrik, dan memperbaiki masalah render dari situs WordPress lama:
   - Memperbaiki 3 kartu program di Beranda yang sempat gagal tampil (*broken lazy-load/srcset*).
   - Memperbaiki slider *Aktifitas Kami* & galeri di halaman program yang terpotong/kosong.
   - Mengganti halaman dummy starter template Astra Day Care (`/program` dan `/contact`) dengan konten resmi Bimbel Gemilang dan redirect yang tepat.
   - Menghubungkan seluruh tombol CTA (`Gabung Sekarang`, `Konsultasi Gratis`) yang sebelumnya `href="#"` menuju link WhatsApp terarah + form pendaftaran.
   - Merapikan typo konten awal (*"Bimbel Gemilag"* -> *"Bimbel Gemilang"*, *"Tanggerang Selatan"* -> *"Tangerang Selatan"*, kartu duplikat *Mengenalkan Tata Bahasa* di `english-for-kids`, dan placeholder *"Yusuf"* pada field `Nomor HP/Email`).
2. **Portal Admin Simpel (Anti-WordPress):** Memungkinkan pengelola Bimbel Gemilang mengubah teks, harga program, jadwal, daftar mentor, foto kegiatan, dan membaca data calon siswa pendaftar (*leads*) melalui form terstruktur yang **tidak mungkin merusak desain atau tata letak halaman**.

---

## 2. User Persona & Hak Akses

| Persona | Deskripsi & Kebutuhan | Akses |
| :--- | :--- | :--- |
| **Calon Siswa / Orang Tua** | Mencari informasi program belajar (PTN & TKA, SD/SMP/SMA, English for Kids, Program Khusus), membandingkan biaya Cash/Angsur/Group/Private, melihat kredibilitas mentor & alumni, serta mendaftar atau berkonsultasi via WhatsApp/Form. | Seluruh halaman publik (`/*`) |
| **Admin Bimbel** | Staf/pengelola non-teknis yang perlu memperbarui biaya program, menambah/menonaktifkan mentor atau foto aktivitas, mengganti nomor WhatsApp/jam operasional, dan menindaklanjuti pendaftar masuk. | `/admin/login` dan seluruh rute terproteksi `/admin/*` |

---

## 3. Arsitektur Sitemap Publik & Aturan 301 Redirect

### 3.1 Rute Halaman Publik (7 Rute Resmi)
1. `/` — **Beranda (`Home`)**: Hero + CTA WA, Statistik (2005, ±5100 Alumni, 80% PTN), 6 Keunggulan (*Mengapa Pilih Gemilang?*), Katalog 4 Program, Slider *Aktivitas Kami*, Carousel *Mentor Kami*, *Kontak & Alamat Kami* (Embed Google Maps + tombol sosial media), CTA Banner `#BimbelforGEMILANG`.
2. `/program` — **Katalog Program**: Menggantikan halaman dummy Day Care lama; menampilkan ringkasan seluruh 4 program Bimbel Gemilang lengkap dengan perbandingan singkat & link ke halaman detail.
3. `/ptn-tka` — **Program PTN & TKA**: Banner & CTA, Highlight 80% Alumni Tembus PTN + daftar nama alumni & kampus (UI, ITB, UGM, Unpad, UB, UIN JKT), *Fokus Kami* (3 poin), *Fitur Kami* (5 badge fitur), Galeri aktivitas, Tabel *Rincian Biaya* (1 Tahun/84x, 6 Bulan/42x, 3 Bulan/30x — Cash & Angsur + biaya pendaftaran Rp 150.000), CTA Konsultasi.
4. `/bimbel-sd-smp-sma` — **Bimbel SD, SMP, & SMA**: Kategori **Group** (5–10 siswa: Fokus Kami + Rincian Biaya SD 4-5 s.d. SMA 10-11), Highlight strip (*Gratis Konsultasi Belajar setiap Hari*, *Prestasi & Nilai Setiap Siswa 100% Dipantau*), Kategori **Private** (1-on-1: Fokus Kami + Rincian Biaya SD 1-5 s.d. SMA 12), Galeri aktivitas, CTA Konsultasi.
5. `/english-for-kids` — **English for Kids**: Banner *Fun & Interactive Class*, *Fokus Kami* (tanpa duplikasi kartu), 5 Kartu *Level* (`Starter`, `Beginner`, `Middle`, `Upper`, `Higher` dengan warna aksen masing-masing & bullet poin), Galeri aktivitas, Harga `Rp 1.450.000 / level` (`24x sesi / 4 bulan`), CTA Jadwal Kelas.
6. `/program-khusus` — **Program Khusus**: Banner (modernisasi bebas watermark), deskripsi program (TOEFL/IELTS, bahasa asing, olah data skripsi/tesis, beasiswa), *Fokus Kami* (3 poin), Galeri aktivitas, CTA Konsultasi.
7. `/siapa-kami` — **Siapa Kami**: Profil sejak 2005 (5000+ murid berprestasi), foto kolase sejarah, kutipan prioritas lembaga, diagram nilai inti (*Pendekatan Personal* & *Dedikasi pada Hasil*), Carousel *Mentor Kami*, Slider *Aktivitas Kami*, CTA Banner.
8. `/alamat-kontak-kami` — **Alamat & Kontak Kami**: Kartu Kontak (WA `0813-8523-7190`, Email `bimbelforgemilang@gmail.com`, Sosial `@bimbelforgemilang`), Foto lokasi depan ruko + Embed Google Maps interaktif, Alamat lengkap & Jam Operasional, Daftar 6 landmark jarak sekolah/RS sekitar, Form **Hubungi Kami** (Nama, Nomor HP/Email, Pilihan Program opsional, Pertanyaan/Pesan -> tersimpan ke DB + pesan sukses/opsi lanjut ke WhatsApp).

*(Total 8 rute publik yang bersih dan fungsional).*

### 3.2 Aturan 301 Redirect (`next.config.ts`)
| URL Lama WordPress | Target Next.js | Status | Alasan |
| :--- | :--- | :--- | :--- |
| `/home` | `/` | `301` | Kanonisasi URL beranda |
| `/contact` | `/alamat-kontak-kami` | `301` | Mengganti halaman kontak dummy starter Astra |
| `/program-ptn` | `/ptn-tka` | `301` | Mengarahkan slug lama yang kosong ke halaman resmi PTN & TKA |

---

## 4. Brand & Design Tokens (Acuan Phase 3 FigCraft & Tailwind v4 `@theme`)

Hasil ekstraksi langsung dari tema Astra & aset visual WordPress:
- **Font Display / Heading:** `Poppins` (`600`, `700`, `800`)
- **Font Body:** `Nunito Sans` (`400`, `600`, `700`)
- **Warna Inti Brand:**
  - `--color-brand-indigo`: `#2d3091` (Primary brand, heading utama, ikon, tombol utama)
  - `--color-brand-indigo-soft`: `#4e5693` (Pill CTA button *Gabung Sekarang / Konsultasi Gratis*)
  - `--color-brand-gold`: `#e0c32b` (Aksen gradasi emas kartu, banner, & footer)
  - `--color-brand-cream`: `#fef4cd` (Background surface utama seluruh halaman)
  - `--color-brand-teal`: `#035d61` (Strip statistik, badge mentor, kartu kontak, aksen program khusus)
  - `--color-brand-crimson`: `#be1e2d` (Aksen `#BimbelforGEMILANG`, badge fitur PTN & TKA)
  - `--color-ink-heading`: `#0F172A`
  - `--color-ink-body`: `#364151`
  - `--color-surface-white`: `#fefefe`

---

## 5. Functional Requirements — Web Publik

1. **Navigasi & Header Responsif:**
   - Logo Bimbel Gemilang + tag *"Lembaga Pendidikan Gemilang Bimbingan Belajar — Private & Study Club - Sejak 2005"*.
   - Menu desktop & drawer mobile: `Home`, `Program` (dropdown ke `/program`, `/ptn-tka`, `/bimbel-sd-smp-sma`, `/english-for-kids`, `/program-khusus`), `Tentang Kami` (dropdown ke `/siapa-kami`, `/alamat-kontak-kami`).
2. **Dynamic WhatsApp CTA Engine:**
   - Seluruh tombol `Gabung Sekarang` dan `Konsultasi Gratis` membangun link `https://wa.me/<whatsapp_number>?text=<encoded_template>` secara dinamis dari `site_settings` dan template per-program.
3. **Interactive Carousels & Galleries:**
   - Carousel *Mentor Kami* (mendukung swipe/panah kiri-kanan, dot indicator, responsif 1 kartu di mobile, 3 kartu di desktop).
   - Galeri *Aktivitas Kami* (menampilkan foto kegiatan belajar dengan lightbox opsional & rasio aspek seragam agar tidak terpotong).
4. **Form Hubungi Kami / Pendaftaran (`/alamat-kontak-kami`):**
   - Field: `Nama*` (min 2 karakter), `Nomor HP / Email*`, `Program Diminati` (dropdown opsional), `Pertanyaan / Pesan*`.
   - Validasi client + server via Zod, anti-spam *honeypot* tersembunyi + rate limiting, menyimpan record ke tabel `leads`, menampilkan konfirmasi sukses beserta tombol instan *"Lanjutkan ke WhatsApp"* bila user ingin respon cepat.
5. **SEO & Metadata Dinamis:**
   - Meta title, description, OpenGraph per halaman (bisa diedit dari Portal Admin).
   - `sitemap.xml` & `robots.txt` otomatis (mengecualikan `/admin/*` dari indexing mesin pencari!).
   - JSON-LD `EducationalOrganization` di layout publik berisi nama, alamat Cirendeu, telepon, jam operasional, dan koordinat peta.

---

## 6. Functional Requirements — Portal Admin Simpel (`/admin`)

### Prinsip Desain Portal Admin (Anti-WordPress)
- **Desktop-Only Access (`>= 1024px`):** Portal Admin (`/admin/*`) dirancang **khusus untuk perangkat Desktop** (laptop/PC). Pada layar Mobile maupun Tablet (`< 1024px`), akses `/admin` menampilkan kartu pemberitahuan *Desktop-Only Guard* beserta tautan kembali ke web publik agar presisi editor konten, border Draft, dan Live Preview tetap terjaga.
- **Structured Field-Based Editing:** Admin hanya melihat form field yang jelas labelnya (teks pendek, textarea, angka/harga, upload gambar, toggle `Aktif/Nonaktif`, tombol urutan naik/turun).
- **Zero Layout Risk:** Admin **tidak bisa** menambah custom CSS, HTML bebas, shortcodes, atau menggeser posisi kolom/grid. Struktur visual tetap dikunci oleh komponen React + Tailwind v4.
- **Alur Draft, Preview, & Publish:** Setiap perubahan dapat disimpan sebagai **Draft** terlebih dahulu tanpa langsung mengubah tampilan web publik. Admin dapat membuka **Preview** untuk melihat hasil tampilan asli sebelum menekan **Publish** (atau **Buang Draft** untuk membatalkan).
- **Penanda Visual Konten Diedit (Border Berbeda):**
  - Pada mode edit di `/admin`, setiap field, section, atau kartu item yang sedang diubah (unsaved) maupun yang memiliki perubahan berstatus **Draft** wajib menampilkan **border yang berbeda secara visual** (misal border amber/emas putus-putus atau indigo tegas + badge status `"Draft"` / `"Diedit"`) dibandingkan item yang tidak berubah (border netral).
  - Pada **Mode Preview**, tersedia *highlight border* penanda area yang berubah beserta banner kontrol atas (*"Mode Preview Draft"* + tombol *Kembali ke Editor* & *Publish Sekarang*).
- **Instant Live Sync:** Menekan tombol **Publish** memindahkan perubahan draft ke status live dan otomatis membersihkan cache halaman terkait sehingga perubahan langsung tampil di situs publik.

### Modul Portal Admin (7 Menu / Rute Utama)

| Rute Admin | Modul | Fitur & Field yang Dikelola |
| :--- | :--- | :--- |
| `/admin/login` | **Autentikasi** | Form email & password admin dengan pesan error aman, redirect ke `/admin` bila sukses. |
| `/admin` | **Dashboard Ringkas** | Ringkasan jumlah program aktif, total mentor, jumlah foto aktivitas, jumlah item berstatus **Draft**, jumlah *leads* berstatus `Baru`, dan shortcut cepat ke halaman edit populer + tombol **Preview Website**. |
| `/admin/settings` | **Pengaturan Situs & Kontak** | Nama lembaga, tagline, logo, nomor WhatsApp + template pesan default, email, alamat lengkap, jam operasional (`Senin-Jumat`, `Sabtu`, `Minggu`), daftar landmark jarak sekitar, link sosial media (`Instagram`, `TikTok`, `Facebook`, `X`), URL embed Google Maps, foto lokasi, teks copyright, SEO default. Mendukung *Simpan Draft*, *Preview*, & *Publish*. |
| `/admin/sections` | **Konten Beranda & Siapa Kami** | Form terbagi per tab/section:<br>1. **Hero Beranda:** Headline, Subheadline, Label tombol CTA, Gambar Hero.<br>2. **Statistik Beranda:** 3 kartu angka + label (`2005`, `±5100`, `80%`).<br>3. **Mengapa Pilih Gemilang (6 item):** Judul, deskripsi, ikon.<br>4. **Siapa Kami:** Headline, subheadline sejarah, kutipan prioritas, foto kolase, nilai inti.<br>Setiap card/field yang diedit atau berstatus draft ditandai border khusus. |
| `/admin/programs` | **Program & Biaya** | Daftar 4 program (`PTN & TKA`, `Bimbel SD, SMP, & SMA`, `English for Kids`, `Program Khusus`) dengan toggle `Aktif`, badge status `Published / Ada Draft`, edit urutan, dan halaman edit detail per program: Banner image, ringkasan hero, CTA label & pesan WA, daftar *Fokus Kami*, daftar *Fitur*, daftar *Level* (untuk English for Kids), daftar *Rincian Biaya* (Group/Private atau Cash/Angsur), catatan biaya pendaftaran, serta highlight alumni PTN. Mendukung *Simpan Draft*, *Preview*, & *Publish*. |
| `/admin/mentors` | **Mentor & Aktivitas** | Dua tab sederhana:<br>1. **Mentor Kami:** Tambah/edit/hapus mentor (Nama, Mata Pelajaran, Foto, Status Aktif, Urutan).<br>2. **Galeri Aktivitas:** Tambah/edit/hapus foto kegiatan (Judul/Alt, Kategori Program opsional, Gambar, Status Aktif, Urutan).<br>Mendukung status `Draft`/`Published` dengan penanda border berbeda pada item yang diedit. |
| `/admin/preview` | **Live Preview Draft** | Merender halaman publik target (`/` atau `/ptn-tka`, `/siapa-kami`, dll.) menggunakan data `draft ?? published` dalam iframe/halaman preview terproteksi sesi admin, lengkap dengan banner kontrol (*Tandai Perubahan*, *Kembali ke Editor*, *Publish Sekarang*). |
| `/admin/leads` | **Kotak Masuk Pendaftar** | Tabel pendaftar dari form *Hubungi Kami* (Tanggal, Nama, Kontak HP/Email, Program Diminati, Pesan), filter status (`Baru`, `Dihubungi`, `Terdaftar`, `Arsip`), catatan internal admin, dan tombol **Chat via WhatsApp** (otomatis membersihkan format nomor HP ke `628...`). |

*(Catatan: Modul **Testimoni & FAQ** disiapkan skemanya di database untuk pengembangan lanjutan atau toggle opsional di halaman program agar tetap menjaga kesederhanaan v1).*

---

## 7. Skema Database & Konten Terstruktur (Drizzle ORM + LibSQL/SQLite)

Menggunakan `@libsql/client` (kompatibel lokal `file:./data/gemilang.db` untuk dev/VPS dan Turso LibSQL untuk deployment serverless/cloud) dengan Drizzle ORM.

```text
admin_users
├── id (INTEGER PK AUTOINCREMENT)
├── email (TEXT UNIQUE NOT NULL)
├── name (TEXT NOT NULL)
├── password_hash (TEXT NOT NULL)      -- scrypt salt:hash
└── created_at (TEXT NOT NULL)

site_settings (singleton id = 1)
├── id (INTEGER PK DEFAULT 1)
├── brand_name (TEXT NOT NULL)
├── brand_tagline (TEXT NOT NULL)
├── logo_url (TEXT NOT NULL)
├── whatsapp_number (TEXT NOT NULL)    -- format 6281385237190
├── whatsapp_display (TEXT NOT NULL)   -- format 0813-8523-7190
├── whatsapp_default_msg (TEXT NOT NULL)
├── email (TEXT NOT NULL)
├── address (TEXT NOT NULL)
├── location_photo_url (TEXT NOT NULL)
├── maps_embed_url (TEXT NOT NULL)
├── maps_link_url (TEXT NOT NULL)
├── operating_hours_json (TEXT NOT NULL) -- JSON array: [{ days, hours }]
├── landmarks_json (TEXT NOT NULL)       -- JSON array: string[]
├── social_links_json (TEXT NOT NULL)    -- JSON: { instagram, tiktok, facebook, x }
├── hashtag_text (TEXT NOT NULL)
├── copyright_text (TEXT NOT NULL)
├── seo_title (TEXT NOT NULL)
├── seo_description (TEXT NOT NULL)
├── draft_json (TEXT)                  -- NULL jika tidak ada draft; berisi JSON perubahan yang belum di-publish
├── draft_updated_at (TEXT)
└── updated_at (TEXT NOT NULL)

site_sections
├── key (TEXT PK)                      -- 'home_hero' | 'home_stats' | 'home_why_us' | 'home_program_intro' | 'about_hero' | 'cta_banner'
├── title (TEXT NOT NULL)
├── data_json (TEXT NOT NULL)          -- versi published, divalidasi ketat dengan Zod schema per key
├── draft_json (TEXT)                  -- NULL jika tidak ada draft; berisi JSON perubahan sebelum di-publish
├── draft_updated_at (TEXT)
└── updated_at (TEXT NOT NULL)

programs
├── id (INTEGER PK AUTOINCREMENT)
├── slug (TEXT UNIQUE NOT NULL)        -- 'ptn-tka' | 'bimbel-sd-smp-sma' | 'english-for-kids' | 'program-khusus'
├── title (TEXT NOT NULL)
├── subtitle (TEXT NOT NULL)
├── short_description (TEXT NOT NULL)
├── banner_image_url (TEXT NOT NULL)
├── accent_theme (TEXT NOT NULL)       -- 'crimson' | 'indigo' | 'gold' | 'teal'
├── cta_label (TEXT NOT NULL)
├── cta_whatsapp_text (TEXT NOT NULL)
├── details_json (TEXT NOT NULL)       -- Zod-validated JSON: focusItems, features, levels, pricingGroups, pricingNote, alumniHighlight
├── is_active (INTEGER NOT NULL DEFAULT 1)
├── sort_order (INTEGER NOT NULL DEFAULT 0)
├── seo_title (TEXT NOT NULL)
├── seo_description (TEXT NOT NULL)
├── draft_json (TEXT)                  -- NULL jika tidak ada draft; berisi snapshot perubahan program sebelum publish
├── draft_updated_at (TEXT)
└── updated_at (TEXT NOT NULL)

mentors
├── id (INTEGER PK AUTOINCREMENT)
├── name (TEXT NOT NULL)
├── subjects (TEXT NOT NULL)
├── photo_url (TEXT NOT NULL)
├── is_active (INTEGER NOT NULL DEFAULT 1)
├── status (TEXT NOT NULL DEFAULT 'published') -- 'draft' | 'published'
├── draft_json (TEXT)                  -- perubahan sementara sebelum publish
├── sort_order (INTEGER NOT NULL DEFAULT 0)
└── updated_at (TEXT NOT NULL)

activities
├── id (INTEGER PK AUTOINCREMENT)
├── caption (TEXT NOT NULL)
├── image_url (TEXT NOT NULL)
├── program_slug (TEXT)                -- NULL = tampil global di Beranda & Siapa Kami; isi slug untuk filter halaman program
├── is_active (INTEGER NOT NULL DEFAULT 1)
├── status (TEXT NOT NULL DEFAULT 'published') -- 'draft' | 'published'
├── draft_json (TEXT)                  -- perubahan sementara sebelum publish
├── sort_order (INTEGER NOT NULL DEFAULT 0)
└── updated_at (TEXT NOT NULL)

leads
├── id (INTEGER PK AUTOINCREMENT)
├── name (TEXT NOT NULL)
├── contact_info (TEXT NOT NULL)
├── program_interest (TEXT)
├── message (TEXT NOT NULL)
├── source_page (TEXT NOT NULL)
├── status (TEXT NOT NULL DEFAULT 'new') -- 'new' | 'contacted' | 'enrolled' | 'archived'
├── admin_notes (TEXT)
├── created_at (TEXT NOT NULL)
└── updated_at (TEXT NOT NULL)
```

*(Opsional Fase Lanjutan: tabel `testimonials` dan `faqs` dapat ditambahkan dengan pola identik `programs` tanpa mengubah struktur inti).*

---

## 8. Arsitektur Keamanan, Autentikasi, Media, & Cache

### 8.1 Autentikasi & Otorisasi Portal Admin
1. **Password Hashing:** `crypto.scryptSync` dengan random salt 16-byte per user dan verifikasi `crypto.timingSafeEqual`.
2. **Session Cookie:** Token bertanda tangan HMAC-SHA256 (atau JWT HS256 via `jose`) menggunakan `ADMIN_SESSION_SECRET` dari `.env` (minimal 32 karakter), disimpan dalam cookie `gemilang_admin_session` dengan flag `httpOnly: true`, `sameSite: 'lax'`, `path: '/'`, dan `secure: true` di production. Masa berlaku 7 hari (rolling atau fixed expiry).
3. **Defense-in-Depth (3 Lapis Proteksi):**
   - Lapis 1 (`middleware.ts` / `proxy.ts`): Redirect pengunjung tanpa cookie valid yang mengakses `/admin/*` (kecuali `/admin/login`) menuju `/admin/login`.
   - Lapis 2 (Server Layout `/admin/layout.tsx`): Memverifikasi ulang validitas & signature token sesi di server.
   - Lapis 3 (Semua Server Actions & API Routes `/api/admin/*`): Wajib memanggil `await requireAdminSession()` di baris pertama sebelum membaca/mengubah database.
4. **Rate Limiting Login & Form Publik:** Pembatasan percobaan gagal login `/admin/login` serta perlindungan *honeypot* + rate limit sederhana pada submit form publik `Hubungi Kami`.

### 8.2 Manajemen Media & Pembersihan Aset WordPress
- Folder `public/wp-uploads/` saat ini berukuran 87 MB karena berisi ratusan file bawaan tema starter Astra Day Care & thumbnail berulang (`-150x150`, `-300x300`, dll.).
- Pada **Phase 4**, hanya aset yang benar-benar digunakan Bimbel Gemilang (hero, banner program, 12 foto mentor, foto kegiatan, foto lokasi, logo) yang dipindahkan ke `public/images/seed/` dan dioptimasi via `next/image` (otomatis konversi WebP/AVIF & responsive `srcset`).
- **Upload Baru via Portal Admin:**
  - Endpoint terproteksi `POST /api/admin/upload` memvalidasi sesi admin, memeriksa ekstensi & *magic bytes* file (`JPEG`, `PNG`, `WebP` saja — tolak SVG/HTML upload dari form untuk mencegah XSS!), membatasi ukuran maksimal **2 MB**, dan menyimpan dengan nama acak aman (`crypto.randomUUID()`) di direktori upload yang dikonfigurasi (lokal `public/uploads/` untuk VPS/Node, atau adapter Object Storage S3/R2/Vercel Blob via env var untuk serverless).

### 8.3 Strategi Cache, Draft Preview, & Instant Revalidation
- Seluruh query pembacaan halaman publik hanya mengambil data **published** dan dibungkus `unstable_cache` dengan cache tags semantik:
  - `site-settings`
  - `site-sections`
  - `programs` (plus tag spesifik `program:<slug>`)
  - `mentors`
  - `activities`
- **Simpan Draft:** Mutasi *Simpan Draft* hanya menulis ke `draft_json` / `status = 'draft'` dan **tidak** memanggil `revalidateTag` publik, sehingga pengunjung umum tidak terdampak.
- **Mode Preview (`/admin/preview`):** Wajib lolos `requireAdminSession()`, melewati cache (`noStore`), dan menggabungkan `draft_json ?? published` agar admin bisa meninjau tampilan asli sebelum publish.
- **Publish:** Memindahkan `draft_json` ke data utama, menghapus `draft_json = NULL` (atau mengubah `status = 'published'`), lalu memanggil `revalidateTag(...)` dan `revalidatePath('/', 'layout')` agar perubahan langsung live tanpa rebuild.

---

## 9. Non-Functional Requirements & Batasan (*Out of Scope*)

### Non-Functional Requirements
- **Performa & Core Web Vitals:** Skor Lighthouse >= 95 untuk *Performance*, *Accessibility*, *Best Practices*, dan *SEO* pada desktop & mobile.
- **Aksesibilitas (WCAG 2.2 AA):** Kontras teks memadai di atas permukaan krem/emas/indigo, seluruh tombol & dropdown navigasi bisa diakses keyboard, label form terhubung eksplisit, `alt` text wajib pada gambar konten.
- **Responsif & Visual Parity:** Tidak ada horizontal overflow pada viewport `390px` (Mobile) dan `1440px` (Desktop).
- **Kualitas Kode & Type Safety:** TypeScript `strict: true`, validasi Zod di seluruh batas input eksternal (`form`, `Server Actions`, `JSON DB payloads`).

### Batasan (*Out of Scope* v1)
1. **Tidak ada Page Builder / Drag-and-Drop Editor** (seperti Elementor/Gutenberg) atau input custom CSS/HTML/shortcode oleh admin.
2. **Tidak ada Blog / Artikel Berita** pada rilis v1 (audit WP menunjukkan `0` post; dapat ditambahkan di v1.1 bila dibutuhkan).
3. **Tidak ada Portal Siswa / LMS / Pembayaran Online** (pendaftaran diarahkan ke form *leads* + konsultasi WhatsApp).
4. **Tidak ada Multi-Bahasa / Multi-Cabang** (fokus 1 lokasi Cirendeu, Ciputat Timur).

---

## 10. Rencana Pemetaan Migrasi Data (`scripts/seed.ts`)

Data hasil ekstraksi `docs/audit/wp-export/pages.json` akan dipetakan secara terprogram oleh script seeding `scripts/seed.ts` (idempoten, aman dijalankan ulang):
1. **`site_settings`**: Mengisi `"Bimbel Gemilang"`, WA `0813-8523-7190` (`6281385237190`), email `bimbelforgemilang@gmail.com`, alamat Jl. Kertamukti No.1/F Cirendeu Tangerang Selatan, jam operasional, 6 landmark sekitar, dan social links `@bimbelforgemilang`.
2. **`site_sections`**: Mengisi konten awal `home_hero`, `home_stats`, `home_why_us` (6 kartu keunggulan), `home_program_intro`, `about_hero`, `cta_banner`.
3. **`programs`**: Mengisi 4 entri (`ptn-tka`, `bimbel-sd-smp-sma`, `english-for-kids`, `program-khusus`) lengkap dengan tabel biaya Cash/Angsur/Group/Private dan daftar level dari halaman WP asli (tanpa kartu duplikat di `english-for-kids`).
4. **`mentors`**: Mengisi 12 entri mentor beserta aset gambar dari `wp-uploads/2025/10/` (dirapikan ke `public/images/mentors/`).
5. **`activities`**: Mengisi foto dokumentasi kelas & alumni dari `wp-uploads/2025/10/` dan `2025/11/` (dirapikan ke `public/images/activities/`).
6. **`admin_users`**: Membuat 1 akun admin awal dari environment variable (`ADMIN_INITIAL_EMAIL` & `ADMIN_INITIAL_PASSWORD`) saat seeding pertama.
