# Rencana Migrasi Web Profile Bimbel Gemilang, Setup FigCraft MCP, & AI Agent Skills

## Progress Tracker

- [x] **Phase 0 — Environment, AI Agent Skills & FigCraft MCP Readiness**
  - [x] Inisialisasi Git & struktur folder proyek
  - [x] Buat `AGENTS.md` & custom skill `.agents/skills/figcraft-design-workflow/SKILL.md`
  - [x] Install paket AI Agent Skills via `npx skills add ... -a antigravity` (fokus stack **Next.js / Opsi B**)
  - [x] Install binary `figcraft` & `figcraft-cli` lalu hubungkan ke `~/.gemini/config/mcp_config.json`
- [x] **Phase 1 — Audit & Ekstraksi WordPress Local (LocalWP)**
  - [x] Inventarisasi URL publik, page builder, plugin aktif, form, & SEO metadata
  - [x] Ambil screenshot baseline Desktop (`1440px`) & Mobile (`390px`)
  - [x] Ekspor konten (WP REST API / XML / SQL) & salin `wp-content/uploads/`
- [x] **Phase 2 — Penyusunan PRD, Skema Konten, & Arsitektur Portal Admin**
  - [x] Susun dokumen `docs/PRD.md` (tujuan bisnis, user persona, functional & non-functional requirements, batasan *out-of-scope*)
  - [x] Definisikan skema konten terstruktur (*field-based CMS*) untuk halaman publik & portal admin simpel (anti-WordPress bloat)
  - [x] Kunci arsitektur Auth, Database/ORM, Media Storage, & strategi cache/ISR (`revalidatePath`/`revalidateTag`)
  - [x] Petakan daftar migrasi data WordPress ke tabel database & daftar **301 Redirect**
- [x] **Phase 3 — Rekonstruksi & Modernisasi UI di FigCraft via MCP**
  - [x] Rekonstruksi & kelengkapan wireframe/layout seluruh halaman WordPress (`design/bimbel-gemilang.figcraft`: 8 Desktop 1440 + 6 Mobile 390 + 5 Admin Portal, lengkap data & aset WP + perbaikan bug template)
  - [x] Modernisasi UI, design tokens (warna, tipografi, spacing), & komponen web publik di FigCraft (+ `design/tokens.css`)
  - [x] Desain UI **Portal Admin Simpel** di FigCraft (login, dashboard ringkas, form edit per-section + fitur Draft, border indikator oranye `#F59E0B`/indigo `#2d3091`, & Preview Mode `/admin/preview`)
  - [ ] Review visual live di desktop app FigCraft hingga disetujui user (sudah lolos inspeksi visual via screenshot render headless MCP)
- [ ] **Phase 4 — Implementasi Aplikasi Web & Portal Admin (Next.js App Router — Opsi B)**
  - [ ] Scaffold proyek **Next.js (App Router) + React 19 + Tailwind CSS v4 + TypeScript**
  - [ ] Setup Database, ORM, skema konten, & seeding data hasil ekstraksi WordPress
  - [ ] Konversi design tokens FigCraft ke `@theme` Tailwind v4 & bangun komponen UI web publik
  - [ ] Implementasi **Portal Admin (`/admin`)** dengan autentikasi, editor konten berbasis form terstruktur, upload media, & on-demand revalidation
  - [ ] Migrasi seluruh konten, aset gambar teroptimasi (`next/image`), form/WhatsApp CTA, & konfigurasi `redirects` 301
- [ ] **Phase 5 — Verifikasi Kualitas, Parity, Keamanan & Performa**
  - [ ] Verifikasi `pnpm build` & typecheck (`tsc --noEmit`) tanpa error
  - [ ] Jalankan Playwright E2E (alur publik, submit form, & alur login/edit konten di `/admin`), link check, & visual parity check (Desktop & Mobile)
  - [ ] Verifikasi proteksi route `/admin`, API routes/Server Actions, & sanitasi input
  - [ ] Audit Lighthouse / Core Web Vitals halaman publik (target >= 95 di semua metrik)

---

## Tujuan Proyek

1. **Migrasi dari WordPress lokal (aplikasi "Local" / LocalWP)** ke **Next.js App Router (Opsi B)** dengan performa tinggi sambil menjaga **100% UI & functional parity**.
2. **Menyusun PRD yang solid sebelum desain & coding** agar struktur konten, fitur portal admin, dan batasan ruang lingkup terkunci sejak awal.
3. **Menghadirkan Portal Admin Simpel (Bukan seperti WordPress):** Admin cukup mengisi form terstruktur (judul, deskripsi, gambar, harga/program, status tampil) tanpa page builder/drag-and-drop yang rumit atau merusak layout.
4. **Menghubungkan Antigravity ke FigCraft (`storytold/figcraft`) via MCP** untuk merekonstruksi dan memodernisasi UI web publik maupun portal admin secara visual sebelum masuk ke tahap coding.
5. **Menyiapkan AI Agent Skills & Project Rules** yang terbukti efektif sebelum eksekusi dimulai.

---

## Strategi Pemilihan Model Gemini (Hemat Token & Kuota)

Daftar model yang tersedia: **Gemini 4 Hydrogen** (`low`, `medium`, `high`, `xhigh`), **Gemini 4 Argon**, dan **Gemini 3.8 Flash** *(belum memiliki akses ke Gemini 4 Carbon)*.

### Pembagian Model per Fase

| Fase / Jenis Pekerjaan | Model yang Digunakan | Alasan & Efisiensi Token |
| :--- | :--- | :--- |
| **Phase 0 & Phase 2 — Arsitektur, Penyusunan PRD, Skema DB/Admin** | **Gemini 4 Hydrogen** (`high` atau `xhigh`) | Dipakai khusus untuk mengunci PRD, struktur database, autentikasi admin, dan arsitektur Next.js agar fase desain & coding tidak bolak-balik revisi. |
| **Phase 3 — Desain UI & Sinkronisasi FigCraft MCP** | **Gemini 4 Hydrogen** (`medium` atau `low`) / **Gemini 4 Argon** | Cukup kuat untuk memahami estetika `frontend-design` dan mengeksekusi tool MCP FigCraft (web publik + portal admin) tanpa memboroskan kuota reasoning `xhigh`. |
| **Phase 4 — Coding Next.js, Komponen UI & Portal Admin** | **Gemini 4 Argon** atau **Gemini 4 Hydrogen** (`low`) | Karena PRD, skema DB, layout, dan design tokens sudah terkunci di `docs/PRD.md` & `.figcraft`, implementasi Next.js + Tailwind v4 berjalan cepat dan hemat token. |
| **Phase 1 & Phase 5 — Ekstraksi Massal, Seeding Data, & QA** | **Gemini 3.8 Flash** | Paling cepat dan paling irit kuota untuk tugas bervolume tinggi/repetitif (ekstraksi WP REST API, seeding konten ke DB, CSV redirect, test Playwright, perbaikan lint ringan). |

### Kebiasaan Wajib Hemat Token di Antigravity

1. **1 Fase = 1 Percakapan Baru (*Fresh Session*):** Simpan progres di file ini (`MIGRATION_PLAN.md`), `docs/PRD.md`, `AGENTS.md`, dan `.figcraft`, lalu buka chat baru di tiap fase agar riwayat chat tidak membengkak.
2. **Gunakan `/compact`:** Jika percakapan mulai panjang di tengah fase, jalankan `/compact` untuk meringkas konteks.
3. **Ekstraksi WordPress Lewat Script:** Gunakan script Node/Python untuk menarik WP REST API (`/wp-json/wp/v2/...`), bukan menempelkan ribuan baris HTML/SQL Elementor ke chat.
4. **Batasi Skill & MCP yang Aktif:** Pasang hanya 6–8 skill inti, dan aktifkan MCP FigCraft hanya saat Phase 3–4.
5. **Gunakan Inline Edit (`Cmd+I`):** Untuk revisi kecil CSS/copywriting, edit langsung di baris kode daripada memicu loop agent penuh.

---

## 1. Rekomendasi AI Agent Skills (Phase 0)

Antigravity membaca skill proyek dari `.agents/skills/<nama-skill>/SKILL.md` dan aturan proyek dari `AGENTS.md`:

| Kategori | Repository & Skill (`npx skills`) | Fungsi Utama | Prioritas |
| :--- | :--- | :--- | :--- |
| **Design Craft** | `anthropics/skills` (`--skill frontend-design`) | Menetapkan arah estetika, tipografi, dan palet warna khas (anti tampilan generik). | Wajib |
| **UI/UX Intelligence** | `nextlevelbuilder/ui-ux-pro-max-skill` (`--skill ui-ux-pro-max`) | Pola sistem desain terkurasi, pairing font, dan layout tokens (termasuk dashboard admin yang bersih). | Wajib |
| **Web Guidelines & A11y** | `vercel-labs/agent-skills` (`--skill web-design-guidelines`) | Audit 100+ aturan UI, semantik HTML, fokus keyboard, ARIA, dan kontras. | Wajib |
| **Performa, SEO & CWV** | `addyosmani/web-quality-skills` (`web-quality-audit`, `core-web-vitals`, `performance`, `seo`, `accessibility`) | Standar audit Google Lighthouse untuk LCP, INP, CLS, dan struktur SEO. | Wajib |
| **Engineering & QA** | `obra/superpowers` (`--skill systematic-debugging`, `verification-before-completion`) | Debugging sistematis berbasis akar masalah dan verifikasi ketat sebelum selesai. | Wajib |
| **Anti-Overengineering** | `DietrichGebert/ponytail` (`--skill ponytail`) | Menjaga kode tetap minimalis, mencegah library/abstraksi berlebih, selaras dengan portal admin simpel. | Wajib |
| **Security & Auditing** | `cloudflare/security-audit-skill` (`--skill security-audit`) | Review celah keamanan auth `/admin`, sanitasi input form, Server Actions, cookie session, dan proteksi upload media. | Wajib (Phase 4–5) |
| **Git Workflow** | `mhattingpete/claude-skills-marketplace` (`--skill git-pushing`) | Otomatisasi staging, commit konvensional, dan push ke remote branch secara terstandar. | Wajib |
| **E2E & Visual Testing** | `lackeyjb/playwright-skill` atau `testdino-hq/playwright-skill` | Otomatisasi Playwright untuk uji form, alur portal admin, broken links, dan screenshot parity. | Wajib |
| **Tailwind CSS v4** | `wshobson/agents` / `evilmartians/agent-skills` (`tailwind-best-practices`) | Menjaga konfigurasi Tailwind v4 (`@theme`, design tokens, tanpa magic values). | Wajib |
| **Framework Stack (Opsi B)** | `vercel-labs/agent-skills` (`--skill vercel-react-best-practices`, `--skill vercel-composition-patterns`) | Mencegah anti-pattern Next.js App Router, React 19, Server Components, & Server Actions. | Wajib |
| **Marketing & CRO** | `coreyhaines31/marketingskills` (`seo-audit`, `copywriting`, `schema`) | Optimasi copywriting landing page bimbel & JSON-LD `EducationalOrganization`. | Opsional |

---

## 2. Persiapan Migrasi dari WordPress "Local" (Phase 1)

1. **Visual & URL Baseline:** Jalankan situs di app **Local**, ambil screenshot *full-page* Desktop (`1440px`) & Mobile (`390px`), dan catat seluruh URL publik (`sitemap_index.xml`).
2. **Ekstrak Konten & Media:** Salin `wp-content/uploads/` dan ekspor halaman/post/CPT via **WP REST API**, **WordPress Export XML**, atau `mysqldump`.
3. **Ekspor SEO & Redirects:** Ekspor meta title, description, OpenGraph, dan daftar slug lama untuk aturan **301 Redirect** di `next.config.ts`.
4. **Pengganti Plugin WordPress:**
   - **Form Pendaftaran/Kontak:** Server Action / API Route Next.js + validasi Zod + simpan ke DB (tampil di Portal Admin) + notifikasi **Resend / WhatsApp webhook** + Cloudflare Turnstile.
   - **CTA WhatsApp:** Komponen ringan (< 1 KB) dengan nomor & template pesan yang bisa diubah dari Portal Admin.
   - **Page Builder (Elementor/Divi/dll.):** Dikonversi ke komponen React + Tailwind CSS v4 yang tetap terkunci desainnya, sementara teks/gambarnya dipasok dari database melalui Portal Admin.

---

## 3. Ruang Lingkup PRD (Phase 2)

Output utama Phase 2 adalah dokumen `docs/PRD.md` sebagai *single source of truth* sebelum masuk ke FigCraft dan coding. Isi minimal `docs/PRD.md`:

1. **Ringkasan & Tujuan Bisnis:** Target konversi pendaftaran siswa Bimbel Gemilang, kecepatan akses, dan kemudahan update konten mandiri oleh tim non-teknis.
2. **User Persona & Hak Akses:**
   - **Pengunjung Publik (Orang Tua / Siswa):** Melihat profil bimbel, program belajar, testimoni, FAQ, artikel, dan mendaftar / konsultasi via form atau WhatsApp.
   - **Admin Bimbel:** Login ke `/admin` untuk mengedit konten web tanpa menyentuh kode atau memecah layout.
3. **Functional Requirements — Web Publik:**
   - Halaman Beranda, Program Bimbel, Tentang Kami, Testimoni, Artikel/Blog (jika ada di baseline), Kontak/Pendaftaran, serta SEO dinamis (metadata, sitemap, OpenGraph, JSON-LD).
4. **Functional Requirements — Portal Admin Simpel (`/admin`):**
   - **Prinsip Anti-WordPress:** Tidak ada instalasi plugin, tidak ada shortcodes, tidak ada drag-and-drop layout builder, tidak ada menu teknis yang membingungkan.
   - **Modul Minimalis:**
     - **Pengaturan Umum & Kontak:** Nama bimbel, logo, nomor WhatsApp, alamat, jam operasional, link media sosial, SEO default.
     - **Edit Section Halaman:** Form terstruktur per bagian (misal *Hero*, *Keunggulan*, *CTA Banner*) dengan field jelas (`Headline`, `Subheadline`, `Teks Tombol`, `Gambar`) + tombol *Simpan & Publish*.
     - **Manajemen Program / Paket Bimbel:** Tambah, edit, ubah urutan, atau sembunyikan program (toggle *Aktif/Nonaktif*).
     - **Manajemen Testimoni & FAQ:** Input nama siswa/orang tua, asal sekolah/kelas, kutipan, foto, serta tanya-jawab FAQ.
     - **Manajemen Artikel / Pengumuman (Opsional sesuai audit Phase 1):** Editor Markdown/Rich Text bersih (judul, slug otomatis, cover image, isi, status *Draft/Published*).
     - **Kotak Masuk Pendaftar / Leads:** Tabel daftar calon siswa yang mengisi form pendaftaran dengan status tindak lanjut (*Baru / Dihubungi / Terdaftar*) & tombol buka chat WhatsApp langsung.
5. **Non-Functional Requirements & Batasan (*Out of Scope*):**
   - Perubahan dari admin langsung live di web publik dalam hitungan detik (*on-demand revalidation*).
   - Keamanan sesi admin, validasi tipe & ukuran upload gambar, serta target Lighthouse >= 95.
   - *Out of Scope* di fase ini (kecuali diminta nanti): LMS/kelas online, pembayaran otomatis payment gateway, multi-bahasa, dan page builder bebas.

---

## 4. Tech Stack Target Terpilih: Opsi B + Portal Admin Simpel

Stack yang dikunci untuk proyek ini adalah **Opsi B** dengan arsitektur *monolith* Next.js yang rapi (satu repositori, satu deployment, biaya operasional minim):

- **Framework & UI:** **Next.js (App Router)** + **React 19** + **Tailwind CSS v4** + **TypeScript** (strict mode).
- **Database & ORM:** **SQLite/LibSQL (Turso)** atau **PostgreSQL (Neon / Supabase)** dengan **Drizzle ORM** *(ringan, type-safe, migrasi skema mudah)*.
- **Autentikasi Admin:** Session cookie terenkripsi (misal **Auth.js / Better Auth** atau session JWT/HMAC ringan khusus admin tunggal/tim kecil) + proteksi `middleware.ts` & verifikasi ulang di setiap Server Action/API route.
- **Editor Konten Simpel:**
  - *Section-based forms* menggunakan **React Hook Form + Zod** untuk field terstruktur.
  - Editor teks ringan (misal **Tiptap** minimalis atau Markdown editor) hanya untuk konten panjang seperti artikel/deskripsi program.
- **Media & Gambar:** Upload gambar tervalidasi ke **Cloudflare R2 / Vercel Blob / S3** (atau storage lokal saat dev) dan dirender via `next/image` agar otomatis WebP/AVIF & responsif.
- **Cache & Performa:** Halaman publik menggunakan SSR/ISR ter-cache dengan `revalidatePath` / `revalidateTag` setiap kali admin menyimpan perubahan.

---

## 5. Setup MCP FigCraft (`storytold/figcraft`)

1. Unduh release macOS universal dari `https://github.com/storytold/figcraft/releases` dan letakkan `figcraft-cli` di `/usr/local/bin/figcraft-cli`.
2. Daftarkan di `~/.gemini/config/mcp_config.json`:
   - **Attached Mode (Live UI di desktop app):** Jalankan `figcraft --control 47800`, lalu set `"args": ["mcp", "--attach", "47800"]`.
   - **Headless Mode:** Set `"args": ["mcp", "--automation-read-root", "<path-proyek>", "--automation-write-root", "<path-proyek>"]`.
