---
name: figcraft-design-workflow
description: Alur kerja desain UI dan sinkronisasi token antara FigCraft MCP (`storytold/figcraft`) dan proyek Next.js + Tailwind CSS v4 Bimbel Gemilang. Gunakan saat Phase 3 (desain di FigCraft) dan Phase 4 (implementasi komponen dari `.figcraft`).
---

# FigCraft Design Workflow (Bimbel Gemilang)

Gunakan skill ini saat bekerja dengan file desain `design/bimbel-gemilang.figcraft` melalui FigCraft MCP (`figcraft-cli mcp`).

## 1. Mode Koneksi FigCraft MCP

- **Attached Mode (Live UI & Auto-Sync):**
  Jalankan script launcher otomatis sebelum menghubungkan Antigravity ke MCP:
  ```bash
  bash scripts/open-figcraft-live.sh
  # atau jika FigCraft sudah terbuka tanpa --control:
  bash scripts/open-figcraft-live.sh --restart
  ```
  Script ini otomatis menjalankan `FigCraft.app` dengan flag `--control 47800`, akses read/write ke root proyek, membuka `design/bimbel-gemilang.figcraft`, menunggu port `47800` siap, dan menampilkan jendela FigCraft ke depan. Konfigurasi MCP di `~/.gemini/antigravity/mcp_config.json` menggunakan args `["mcp", "--attach", "47800"]`.
- **Headless Mode:** MCP membaca dan menulis langsung ke file disk proyek ini (`design/bimbel-gemilang.figcraft`) tanpa membuka jendela UI.

### Wajib: Konfirmasi Awal (Klik "OK") & Eksekusi Otomatis
1. **Tanya User Dulu Sebelum Membuka FigCraft:** Sebelum menjalankan `bash scripts/open-figcraft-live.sh` atau memulai sesi edit desain baru di `design/bimbel-gemilang.figcraft`, agent **wajib meminta konfirmasi 1 kali ke user** menggunakan `ask_question` dengan opsi tombol:
   - `(Recommended) OK — Buka FigCraft & Eksekusi Desain`
   - `Batal`
   Sertakan ringkasan singkat halaman/bagian yang akan diubah agar user siap memantau jendela FigCraft.
2. **Auto-Eksekusi Setelah Klik "OK":** Begitu user memilih **OK**, agent langsung membuka/memfokuskan FigCraft (`bash scripts/open-figcraft-live.sh`) dan mengeksekusi **seluruh perubahan desain secara beruntun sampai selesai** (pindah page, auto-zoom, edit node/layout, dan `save_file`) **tanpa berhenti lagi untuk meminta konfirmasi di tengah jalan**.

### Wajib: Live Viewport Tracking (Auto-Page & Auto-Zoom) saat Mengedit
Agar user bisa melihat perubahan desain secara **real-time** di layar FigCraft saat agent bekerja di Attached Mode:
1. **Pindah ke Page & Node Target:** Sebelum atau saat mengedit, panggil `select` (`ids: [<targetFrameOrNodeId>]`, yang otomatis berpindah ke page node tersebut) atau `run_command` dengan `page.select` (`{"id": <pageId>}`).
2. **Auto-Zoom ke Area yang Diedit:** Segera setelah `select` (atau setelah membuat/mengubah node), panggil `run_command` dengan `{"command": "view.zoomSelection"}` agar viewport `FigCraft.app` otomatis mengarah dan melakukan zoom tepat ke elemen/frame yang sedang diubah.
3. **Verifikasi & Simpan:** Setelah selesai mengubah satu section/halaman, pastikan `select` + `view.zoomSelection` (atau `view.zoomFit` untuk melihat satu halaman penuh) tetap terfokus pada hasil akhir, lalu panggil `save_file` agar perubahan tersimpan ke disk.

## 2. Struktur Canvas di `design/bimbel-gemilang.figcraft`

Pisahkan halaman/canvas menjadi area yang jelas:
1. **Tokens & Foundations:** Palet warna brand Bimbel Gemilang, skala tipografi, spacing, radius, dan shadow.
2. **Components:** Button, Badge, Card Program, Card Testimoni, Accordion FAQ, Form Input, Navbar, Footer, Admin Sidebar, Admin Form Section.
3. **Public Web — Desktop (`1440px`), Tablet (`768px`), & Mobile (`390px`):** Beranda, Katalog Program, PTN & TKA, Bimbel SD-SMP-SMA, English for Kids, Program Khusus, Siapa Kami, Alamat & Kontak Kami (+ Mobile/Tablet Nav Drawer).
4. **Admin Portal (`1440px` Desktop Only):** Login `/admin/login`, Dashboard Ringkas, Editor Section (+ Draft Borders `#F59E0B`), Live Preview Mode `/admin/preview`, Kotak Masuk Leads, serta *Desktop-Only Guard* bagi layar `< 1024px`.

## 3. Aturan Implementasi ke Next.js + Tailwind CSS v4

1. Ekstrak seluruh variabel warna, font, dan spacing dari FigCraft ke blok `@theme` di `design/tokens.css`—hindari *arbitrary hex/px values* yang berulang.
2. Gunakan `docs/UI_COMPONENT_SPEC.md` bersama Auto-Layout FigCraft sebagai acuan inventori komponen per halaman, variasi style tiap section, `flex` / `grid`, `gap`, dan `padding`.
3. Jaga **100% Content Parity** antara Mobile (`390px`), Tablet (`768px`–`1023px`), dan Desktop (`1440px`) sesuai `docs/CONTENT_PARITY_GUIDELINES.md` (dilarang menghilangkan konten/data di viewport kecil maupun menengah).
4. Jaga konsistensi visual antara desain FigCraft yang disetujui user dengan hasil render Playwright di Phase 5.
