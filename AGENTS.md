# AGENTS.md — Bimbel Gemilang Web & Portal Admin

Dokumen aturan proyek ini dibaca oleh AI coding agent (Antigravity) di setiap sesi kerja.

## 1. Gambaran Proyek & Tech Stack (Opsi B Terkunci)

- **Proyek:** Migrasi Web Profile **Bimbel Gemilang** dari WordPress lokal (LocalWP) ke aplikasi web modern dengan **Portal Admin Simpel** (`/admin`).
- **Framework:** Next.js (App Router) + React 19 + TypeScript (`strict: true`).
- **Styling:** Tailwind CSS v4 (`@theme` tokens — tanpa magic values).
- **Database & ORM:** SQLite/LibSQL atau PostgreSQL + Drizzle ORM.
- **Auth & Validasi:** Session cookie terenkripsi untuk `/admin` + Zod validation di seluruh Server Actions / API Routes.
- **Desain UI:** `design/bimbel-gemilang.figcraft` (dikelola via FigCraft MCP).
- **Spesifikasi Komponen & Token Visual:** Wajib merujuk [docs/UI_COMPONENT_SPEC.md](file:///Users/rifqiziyadimtinan/Documents/Work/Bimbel%20Gemilang/bimbel-gemilang-web/docs/UI_COMPONENT_SPEC.md) + [design/tokens.css](file:///Users/rifqiziyadimtinan/Documents/Work/Bimbel%20Gemilang/bimbel-gemilang-web/design/tokens.css) untuk daftar section, warna/gradien, ukuran font, radius, dan perilaku komponen tiap halaman (Publik & `/admin`).
- **Content Parity UI (Mobile, Tablet, & Desktop):** Wajib mengikuti [docs/CONTENT_PARITY_GUIDELINES.md](file:///Users/rifqiziyadimtinan/Documents/Work/Bimbel%20Gemilang/bimbel-gemilang-web/docs/CONTENT_PARITY_GUIDELINES.md) — **100% konten Mobile, Tablet, dan Desktop harus sama persis**, hanya tata letak (stack/grid/carousel/drawer) yang beradaptasi tanpa menghilangkan informasi atau elemen di layar kecil/menengah.

## 2. Prinsip Arsitektur Portal Admin Simpel (Anti-WordPress)

- **Structured Field-Based Editing:** Admin hanya mengubah isi teks, gambar, angka, harga, status aktif/nonaktif, dan daftar item melalui form yang tervalidasi.
- **Dilarang Membangun Page Builder Bebas:** Tidak ada drag-and-drop layout builder, shortcode, atau custom CSS/HTML bebas dari sisi admin agar UI/UX dan skor Lighthouse tetap terjaga.
- **Instant Cache Update:** Setiap mutasi di `/admin` wajib memanggil `revalidatePath` / `revalidateTag` untuk memperbarui halaman publik secara instan.
- **Keamanan:** Semua route `/admin` (selain `/admin/login`) dan setiap Server Action/API admin wajib memverifikasi sesi autentikasi di server.

## 3. Alur Kerja Fase & Efisiensi Token

Ikuti urutan fase di `MIGRATION_PLAN.md`:
- **Phase 0:** Environment, Skills, & FigCraft MCP Readiness
- **Phase 1:** Audit & Ekstraksi WordPress Local (via script, jangan tempel HTML/SQL mentah ke chat)
- **Phase 2:** Penyusunan `docs/PRD.md` & skema data
- **Phase 3:** Rekonstruksi & modernisasi UI di FigCraft via MCP (Web Publik + Portal Admin)
- **Phase 4:** Implementasi Next.js + Tailwind v4 + Portal Admin
- **Phase 5:** Verifikasi build, Playwright E2E, parity visual, keamanan, & Lighthouse (>= 95)

### Aturan Hemat Token & Git Workflow
1. Jangan membaca seluruh file besar jika cukup menggunakan `grep`/`rg` + rentang baris.
2. Gunakan script Node/Python di `scripts/` untuk mengekstrak konten massal dari WordPress.
3. Simpan keputusan arsitektur di `docs/PRD.md` dan progress di `MIGRATION_PLAN.md` agar sesi baru tetap ramping.
4. Selalu verifikasi perubahan dengan `pnpm build`, typecheck, dan test yang relevan sebelum menyatakan tugas selesai.
5. **DILARANG AUTO GIT PUSH:** Jangan pernah menjalankan `git push` secara otomatis tanpa instruksi/izin eksplisit langsung dari user di pesan chat. Commit lokal atau perubahan file hanya boleh di-push saat user memerintahkan "git push" atau "/git-pushing".
