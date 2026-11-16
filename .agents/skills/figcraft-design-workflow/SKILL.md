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
  ```
  Script ini otomatis menjalankan `FigCraft.app` dengan flag `--control 47800`, akses read/write ke root proyek, dan langsung memuat `design/bimbel-gemilang.figcraft`. Konfigurasi MCP di `~/.gemini/antigravity/mcp_config.json` menggunakan args `["mcp", "--attach", "47800"]`.
- **Headless Mode:** MCP membaca dan menulis langsung ke file disk proyek ini (`design/bimbel-gemilang.figcraft`) tanpa membuka jendela UI.

## 2. Struktur Canvas di `design/bimbel-gemilang.figcraft`

Pisahkan halaman/canvas menjadi area yang jelas:
1. **Tokens & Foundations:** Palet warna brand Bimbel Gemilang, skala tipografi, spacing, radius, dan shadow.
2. **Components:** Button, Badge, Card Program, Card Testimoni, Accordion FAQ, Form Input, Navbar, Footer, Admin Sidebar, Admin Form Section.
3. **Public Web — Desktop (`1440px`) & Mobile (`390px`):** Beranda, Program Bimbel, Tentang, Artikel/Blog, Kontak/Pendaftaran.
4. **Admin Portal (`1440px` & Mobile):** Login `/admin/login`, Dashboard Ringkas, Edit Section Beranda, Kelola Program/Testimoni/FAQ, Kotak Masuk Leads.

## 3. Aturan Implementasi ke Next.js + Tailwind CSS v4

1. Ekstrak seluruh variabel warna, font, dan spacing dari FigCraft ke blok `@theme` di CSS global Tailwind v4—hindari *arbitrary hex/px values* yang berulang.
2. Gunakan Auto-Layout FigCraft sebagai acuan langsung untuk `flex` / `grid`, `gap`, dan `padding`.
3. Jaga konsistensi visual antara desain FigCraft yang disetujui user dengan hasil render Playwright di Phase 5.
