# Rencana Migrasi Web Profile Bimbel Gemilang, Setup FigCraft MCP, & AI Agent Skills

## Progress Tracker

- [ ] **Phase 0 — Environment, AI Agent Skills & FigCraft MCP Readiness**
  - [ ] Inisialisasi Git & struktur folder proyek
  - [ ] Buat `AGENTS.md` & custom skill `.agents/skills/figcraft-design-workflow/SKILL.md`
  - [ ] Install paket AI Agent Skills via `npx skills add ... -a antigravity`
  - [ ] Install binary `figcraft` & `figcraft-cli` lalu hubungkan ke `~/.gemini/config/mcp_config.json`
- [ ] **Phase 1 — Audit & Ekstraksi WordPress Local (LocalWP)**
  - [ ] Inventarisasi URL publik, page builder, plugin aktif, form, & SEO metadata
  - [ ] Ambil screenshot baseline Desktop (`1440px`) & Mobile (`390px`)
  - [ ] Ekspor konten (WP REST API / XML / SQL) & salin `wp-content/uploads/`
- [ ] **Phase 2 — Rekonstruksi & Modernisasi UI di FigCraft via MCP**
  - [ ] Rekonstruksi wireframe/layout baseline ke `design/bimbel-gemilang.figcraft`
  - [ ] Modernisasi UI, design tokens (warna, tipografi, spacing), & komponen di FigCraft
  - [ ] Review visual live di desktop app FigCraft hingga disetujui
- [ ] **Phase 3 — Implementasi Aplikasi Web Modern**
  - [ ] Scaffold proyek (`Astro 5` atau `Next.js` + `Tailwind CSS v4` + `TypeScript`)
  - [ ] Konversi design tokens FigCraft ke `@theme` Tailwind v4 & bangun komponen UI
  - [ ] Migrasi seluruh konten, aset gambar teroptimasi, form/WhatsApp, & 301 redirects
- [ ] **Phase 4 — Verifikasi Kualitas, Parity & Performa**
  - [ ] Verifikasi `pnpm build` & typecheck tanpa error
  - [ ] Jalankan Playwright E2E, link check, & visual parity check (Desktop & Mobile)
  - [ ] Audit Lighthouse / Core Web Vitals (target >= 95 di semua metrik)

---

## Tujuan Proyek

1. **Migrasi dari WordPress lokal (aplikasi "Local" / LocalWP)** ke teknologi web modern dengan performa terbaik sambil menjaga **100% UI & functional parity**.
2. **Menghubungkan Antigravity ke FigCraft (`storytold/figcraft`) via MCP** untuk merekonstruksi dan memodernisasi UI secara visual sebelum masuk ke tahap coding.
3. **Menyiapkan AI Agent Skills & Project Rules** yang terbukti efektif sebelum eksekusi dimulai.

---

## Strategi Pemilihan Model Gemini (Hemat Token & Kuota)

Daftar model yang tersedia: **Gemini 4 Hydrogen** (`low`, `medium`, `high`, `xhigh`), **Gemini 4 Argon**, dan **Gemini 3.8 Flash** *(belum memiliki akses ke Gemini 4 Carbon)*.

### Pembagian Model per Fase

| Fase / Jenis Pekerjaan | Model yang Digunakan | Alasan & Efisiensi Token |
| :--- | :--- | :--- |
| **Phase 0 & Perencanaan Arsitektur / Debugging Rumit** | **Gemini 4 Hydrogen** (`high` atau `xhigh`) | Dipakai singkat hanya untuk mengunci arsitektur, struktur data, dan masalah kompleks agar fase coding tidak bolak-balik revisi. |
| **Phase 2 — Desain UI & Sinkronisasi FigCraft MCP** | **Gemini 4 Hydrogen** (`medium` atau `low`) / **Gemini 4 Argon** | Cukup kuat untuk memahami estetika `frontend-design` dan mengeksekusi tool MCP FigCraft tanpa memboroskan kuota reasoning `xhigh`. |
| **Phase 3 — Coding Halaman & Komponen dari Spesifikasi FigCraft** | **Gemini 4 Argon** atau **Gemini 4 Hydrogen** (`low`) | Karena layout dan design tokens sudah terkunci di `.figcraft`, implementasi komponen Astro/Next.js + Tailwind v4 berjalan cepat dan hemat token. |
| **Phase 1 & Phase 4 — Ekstraksi Massal, Konversi Konten, & QA** | **Gemini 3.8 Flash** | Paling cepat dan paling irit kuota untuk tugas bervolume tinggi/repetitif (konversi puluhan artikel/program ke Markdown/JSON, CSV redirect, test Playwright, perbaikan lint ringan). |

### Kebiasaan Wajib Hemat Token di Antigravity

1. **1 Fase = 1 Percakapan Baru (*Fresh Session*):** Simpan progres di file ini (`MIGRATION_PLAN.md`), `AGENTS.md`, dan `.figcraft`, lalu buka chat baru di tiap fase agar riwayat chat tidak membengkak.
2. **Gunakan `/compact`:** Jika percakapan mulai panjang di tengah fase, jalankan `/compact` untuk meringkas konteks.
3. **Ekstraksi WordPress Lewat Script:** Gunakan script Node/Python untuk menarik WP REST API (`/wp-json/wp/v2/...`), bukan menempelkan ribuan baris HTML/SQL Elementor ke chat.
4. **Batasi Skill & MCP yang Aktif:** Pasang hanya 6–8 skill inti, dan aktifkan MCP FigCraft hanya saat Phase 2–3.
5. **Gunakan Inline Edit (`Cmd+I`):** Untuk revisi kecil CSS/copywriting, edit langsung di baris kode daripada memicu loop agent penuh.

---

## 1. Rekomendasi AI Agent Skills (Phase 0)

Antigravity membaca skill proyek dari `.agents/skills/<nama-skill>/SKILL.md` dan aturan proyek dari `AGENTS.md`:

| Kategori | Repository & Skill (`npx skills`) | Fungsi Utama | Prioritas |
| :--- | :--- | :--- | :--- |
| **Design Craft** | `anthropics/skills` (`--skill frontend-design`) | Menetapkan arah estetika, tipografi, dan palet warna khas (anti tampilan generik). | Wajib |
| **UI/UX Intelligence** | `nextlevelbuilder/ui-ux-pro-max-skill` (`--skill ui-ux-pro-max`) | Pola sistem desain terkurasi, pairing font, dan layout tokens. | Wajib |
| **Web Guidelines & A11y** | `vercel-labs/agent-skills` (`--skill web-design-guidelines`) | Audit 100+ aturan UI, semantik HTML, fokus keyboard, ARIA, dan kontras. | Wajib |
| **Performa, SEO & CWV** | `addyosmani/web-quality-skills` (`web-quality-audit`, `core-web-vitals`, `performance`, `seo`, `accessibility`) | Standar audit Google Lighthouse untuk LCP, INP, CLS, dan struktur SEO. | Wajib |
| **Engineering & QA** | `obra/superpowers` | Disiplin perencanaan, debugging sistematis, dan verifikasi ketat. | Wajib |
| **E2E & Visual Testing** | `lackeyjb/playwright-skill` atau `testdino-hq/playwright-skill` | Otomatisasi Playwright untuk uji form, broken links, dan screenshot parity. | Wajib |
| **Tailwind CSS v4** | `wshobson/agents` / `evilmartians/agent-skills` (`tailwind-best-practices`) | Menjaga konfigurasi Tailwind v4 (`@theme`, design tokens, tanpa magic values). | Wajib |
| **Framework Stack** | **Astro:** `astrolicious/agent-skills` (`astro`)<br>**Next.js:** `vercel-labs/agent-skills` (`vercel-react-best-practices`, `vercel-composition-patterns`) | Mencegah anti-pattern sesuai framework yang dipilih. | Wajib (sesuai stack) |
| **Marketing & CRO** | `coreyhaines31/marketingskills` (`seo-audit`, `copywriting`, `schema`) | Optimasi copywriting landing page bimbel & JSON-LD `EducationalOrganization`. | Opsional |

---

## 2. Persiapan Migrasi dari WordPress "Local"

1. **Visual & URL Baseline:** Jalankan situs di app **Local**, ambil screenshot *full-page* Desktop (`1440px`) & Mobile (`390px`), dan catat seluruh URL publik (`sitemap_index.xml`).
2. **Ekstrak Konten & Media:** Salin `wp-content/uploads/` dan ekspor halaman/post/CPT via **WP REST API**, **WordPress Export XML**, atau `mysqldump`.
3. **Ekspor SEO & Redirects:** Ekspor meta title, description, OpenGraph, dan daftar slug lama untuk aturan **301 Redirect**.
4. **Pengganti Plugin WordPress:**
   - **Form Pendaftaran/Kontak:** Form HTML/React + **Resend / Formspree / Web3Forms** atau webhook WhatsApp/Google Sheets + Cloudflare Turnstile.
   - **CTA WhatsApp:** Komponen ringan (< 1 KB) dengan tracking event klik.
   - **Page Builder (Elementor/Divi/dll.):** Dikonversi ke komponen Tailwind CSS v4 bersih (tanpa bloat CSS/JS).

---

## 3. Pilihan Tech Stack Target

- **Opsi A (Direkomendasikan untuk Web Profile + Blog + Lead Form): Astro 5 + Tailwind CSS v4 + TypeScript** (Zero-JS by default, skor Lighthouse 99–100, Content Collections type-safe).
- **Opsi B (Jika butuh Portal Siswa / Login / Pembayaran): Next.js (App Router) + React 19 + Tailwind CSS v4 + TypeScript**.

---

## 4. Setup MCP FigCraft (`storytold/figcraft`)

1. Unduh release macOS universal dari `https://github.com/storytold/figcraft/releases` dan letakkan `figcraft-cli` di `/usr/local/bin/figcraft-cli`.
2. Daftarkan di `~/.gemini/config/mcp_config.json`:
   - **Attached Mode (Live UI di desktop app):** Jalankan `figcraft --control 47800`, lalu set `"args": ["mcp", "--attach", "47800"]`.
   - **Headless Mode:** Set `"args": ["mcp", "--automation-read-root", "<path-proyek>", "--automation-write-root", "<path-proyek>"]`.
