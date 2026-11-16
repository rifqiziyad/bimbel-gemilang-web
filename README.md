# Bimbel Gemilang Web & Portal Admin

Proyek migrasi Web Profile & Portal Admin Bimbel Gemilang dari WordPress lokal (LocalWP) ke Next.js (App Router) + React 19 + TypeScript + Tailwind CSS v4.

---

## Panduan Kerja & Dokumen Utama

- **[MIGRATION_PLAN.md](file:///Users/rifqiziyadimtinan/Documents/Work/Bimbel%20Gemilang/bimbel-gemilang-web/MIGRATION_PLAN.md)**: Roadmap & progress tracker seluruh fase migrasi (Phase 0 s.d. Phase 5).
- **[docs/PRD.md](file:///Users/rifqiziyadimtinan/Documents/Work/Bimbel%20Gemilang/bimbel-gemilang-web/docs/PRD.md)**: Product Requirement Document, spesifikasi fitur portal admin, dan skema data.
- **[AGENTS.md](file:///Users/rifqiziyadimtinan/Documents/Work/Bimbel%20Gemilang/bimbel-gemilang-web/AGENTS.md)**: Aturan kerja AI Coding Agent (prinsip anti-WordPress, hemat token, dan git rules).

---

## Desain UI & FigCraft Live Sync

Desain UI berada di file:
`design/bimbel-gemilang.figcraft`

### Menjalankan FigCraft dengan Live Sync Otomatis

Agar setiap perubahan desain dari Antigravity langsung tersinkronisasi secara real-time di aplikasi FigCraft tanpa perlu reload/buka ulang file, jalankan perintah ini di Terminal:

```bash
bash scripts/open-figcraft-live.sh
```

**Fungsi script:**
1. Menjalankan `FigCraft.app` pada port kontrol `47800`.
2. Mengatur pembatasan folder otomasi (`--automation-read-root` & `--automation-write-root`) ke direktori proyek.
3. Membuka file `design/bimbel-gemilang.figcraft` secara langsung.
