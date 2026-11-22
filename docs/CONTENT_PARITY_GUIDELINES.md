# Panduan Kesetaraan Konten Mobile, Tablet, & Desktop (`Content Parity Guidelines`)

Dokumen ini menjadi aturan wajib bagi desainer UI dan AI coding agent (Antigravity) pada **Phase 3 (FigCraft)**, **Phase 4 (Implementasi Next.js + Tailwind v4)**, dan **Phase 5 (Verifikasi Playwright)** agar pengguna di **Mobile (`390px`)**, **Tablet (`768px`–`1023px`)**, dan **Desktop (`1440px`)** memperoleh **100% konten yang sama persis tanpa ada informasi yang dihilangkan**.

---

## 1. Prinsip Utama: Zero Content Omission

1. **Konten Desktop = Tablet = Mobile (100% Parity):** Seluruh teks, statistik, harga, daftar alumni, fitur program, foto aktivitas, profil mentor, landmark alamat, jam operasional, CTA WhatsApp, dan field form yang tampil di Desktop wajib hadir utuh di Tablet dan Mobile.
2. **Dilarang Menyembunyikan Informasi per Viewport:**
   - **Dilarang** memakai `hidden md:block`, `hidden lg:block`, `max-md:hidden`, `display: none`, atau conditional render berbasis ukuran layar untuk menghapus paragraf, poin keunggulan, rincian biaya, atau item kartu di mobile maupun tablet.
   - **Dilarang** memangkas teks penting dengan `truncate` / `line-clamp-*` yang menghilangkan makna informasi penting (harga, syarat pendaftaran, nama & prodi alumni, atau alamat lengkap).
3. **Single Source of Truth Konten:** Halaman **Desktop (`1440px`)** dan skema database di [docs/PRD.md](file:///Users/rifqiziyadimtinan/Documents/Work/Bimbel%20Gemilang/bimbel-gemilang-web/docs/PRD.md) menjadi acuan penuh isi konten. Seluruh **8 Halaman Web Publik** pada **Desktop (`1440px`)**, **Tablet (`768px`)**, dan **Mobile (`390px`)** di `design/bimbel-gemilang.figcraft` wajib memiliki 100% kelengkapan section dan konten yang setara.
4. **Pengecualian Navigasi & Akses Khusus Portal Admin:**
   - **Navigasi Publik:** Bar menu horizontal desktop (`>= 1024px`) berubah menjadi tombol **Menu (`≡`) + Drawer** pada Mobile dan Tablet (`< 1024px`) agar tidak terjadi teks bertumpuk/wrap di header, namun **100% link menu** (`Home`, `Program` beserta 5 sub-halaman, `Tentang Kami` beserta 2 sub-halaman, dan tombol CTA `Konsultasi Gratis`) tetap wajib ada dan dapat diklik di dalam drawer tersebut.
   - **Portal Admin (`/admin`) Khusus Desktop:** Sesuai kebijakan operasional, **Portal Admin hanya dapat dibuka melalui perangkat Desktop (`>= 1024px`)**. Pada viewport Mobile dan Tablet (`< 1024px`), `/admin` menampilkan kartu guard **Desktop-Only** agar editor konten, border Draft, dan Live Preview tetap presisi.

---

## 2. Pola Adaptasi Layout (Ubah Tata Letak, Bukan Konten)

Gunakan pendekatan *adaptive layout* dengan Tailwind CSS v4 (mobile-first: class dasar untuk `< 768px`, `md:` untuk Tablet `768px`–`1023px`, dan `lg:` untuk Desktop `>= 1024px`):

| Komponen / Section | Adaptasi Mobile (`390px` / `< md`) | Adaptasi Tablet (`768px–1023px` / `md:`) | Tampilan Desktop (`>= 1024px` / `lg:`) |
|---|---|---|---|
| **Navbar** | Brand title + Hamburger Drawer (`100%` sub-link & CTA utuh) | Brand title lengkap + tombol CTA pill + Hamburger Drawer (`100%` sub-link utuh) | Horizontal links + dropdown hover/click + CTA pill |
| **Hero Split** (`Beranda`, `Siapa Kami`, `PTN & TKA`) | Stack vertikal (`flex-col`), foto & seluruh 2 CTA tampil penuh | 2 kolom proporsional (`md:grid-cols-12`, copy kiri & foto kanan) atau stack lebar dengan foto penuh | 2 kolom lega (`lg:grid-cols-2`: copy kiri, visual/foto kanan) |
| **Statistik & Keunggulan** (`2005 / ±5100 / 80%`, `Mengapa Pilih Gemilang?` 6 kartu) | `grid-cols-1` vertikal; seluruh 6 kartu & deskripsi utuh | Statistik 3 kolom kompak; Keunggulan **`md:grid-cols-2`** (3 baris x 2 kartu simetris) | Grid 3 kolom (`lg:grid-cols-3`: 2 baris x 3 kartu) |
| **Program Kami** (4 kartu banner + teks penjelas) | `grid-cols-1` vertikal; ke-4 banner program + link route utuh | **`md:grid-cols-2`** (2x2 kartu sejajar lengkap) | Grid 2x2 (`lg:grid-cols-2`) dengan padding & spacing lega |
| **Carousel `Aktivitas Kami` & `Mentor Kami`** | Semua item utuh via carousel (`1` foto / `1`–`2` mentor) **auto-slide 3 detik** + dot indicator (tanpa panah/teks swipe) | **`2` foto aktivitas / `2`–`3` kartu mentor** per slide, **auto-slide 3 detik** + dot indicator | **`3` foto aktivitas / `4` kartu mentor** per slide, **auto-slide 3 detik** + dot indicator |
| **Rincian Biaya (`PTN & TKA`, `SD–SMA`, `English for Kids`)** | *Stacked pricing cards* (`1` paket per kartu), seluruh harga Cash, Angsur, & biaya daftar `Rp. 150.000` utuh | **`md:grid-cols-2`** (atau tabel lega tanpa kolom terpotong) untuk membandingkan Cash vs Angsur | Grid 3 kolom / tabel penuh Cash vs Angsur |
| **Kurikulum 5 Level (`English for Kids`)** | Accordion atau stacked cards berurutan; seluruh 5 level & silabus terbaca | **`md:grid-cols-2`** untuk 5 level kartu + card harga penuh di bawahnya | Grid multi-kolom lengkap 5 level (`Starter` s.d. `Higher`) + silabus |
| **Lokasi, 6 Landmark, & Form Kontak** | Stack vertikal utuh: 3 pill kontak Teal, foto tempat bimbel, alamat, jam operasional, 6 landmark, & form | **`md:grid-cols-2`**: info lokasi + 6 landmark & kontak di satu sisi, form `Hubungi Kami` di sisi lain (3 pill kontak `md:grid-cols-3`) | 2 kolom penuh + 3 pill kontak Teal + form |
| **Footer 3 Kolom** | `grid-cols-1 gap-6` memuat seluruh link program, alamat, kontak, & hak cipta | **`md:grid-cols-2`** atau `md:grid-cols-3` kompak agar tidak terlalu panjang | `lg:grid-cols-3` sejajar |
| **Portal Admin (`/admin`)** | **Diblokir (`< 1024px`):** Menampilkan *Desktop-Only Guard Notice* & CTA kembali ke Beranda | **Diblokir (`< 1024px`):** Menampilkan *Desktop-Only Guard Notice* & CTA kembali ke Beranda | Sidebar kiri tetap + top action bar + editor Draft & Live Preview penuh |

---

## 3. Aturan Tipografi, Spacing, & Anti-Overflow (Mobile & Tablet)

1. **Minimum Touch Target:** Seluruh tombol CTA, dot indicator carousel, accordion toggle, dan link menu di Mobile maupun Tablet (layar sentuh) minimal berukuran `44x44 px`.
2. **Minimum Ukuran Font Body:** `14px`–`16px` (`text-sm` / `text-base`) untuk teks paragraf dan rincian harga agar mudah dibaca di HP maupun Tablet.
3. **Zero Horizontal Overflow:** Pastikan pada viewport Mobile (`390px`) dan Tablet (`768px` portrait maupun `1024px` landscape), `document.documentElement.scrollWidth <= window.innerWidth` di setiap halaman. Gambar dan container panjang wajib memakai `max-w-full` / `w-full` dan teks panjang memakai `break-words`.

---

## 4. Checklist Verifikasi Wajib (Phase 4 & Phase 5)

Sebelum menyelesaikan implementasi halaman di Phase 4 dan sebelum lolos audit Phase 5 dengan Playwright:

- [ ] **Audit DOM Desktop vs Tablet vs Mobile:** Tidak ada data/section penting (harga, alumni, mentor, aktivitas, 6 landmark, kontak, CTA) yang memakai `hidden` untuk disembunyikan permanen di mobile maupun tablet.
- [ ] **Playwright Multi-Viewport Test (`1440x900` Desktop vs `768x1024` Tablet vs `390x844` Mobile):**
  - Verifikasi teks kunci pada ke-8 rute publik (`/`, `/program`, `/ptn-tka`, `/bimbel-sd-smp-sma`, `/english-for-kids`, `/program-khusus`, `/siapa-kami`, `/alamat-kontak-kami`) sama-sama visible/accessible di Desktop, Tablet, dan Mobile.
  - Verifikasi `horizontalOverflow === false` pada lebar `390px` dan `768px`.
  - Verifikasi carousel `Aktivitas Kami` dan `Mentor Kami` melakukan **auto-slide otomatis setiap 3 detik** dan dot indicator dapat diklik di Desktop, Tablet, maupun Mobile.
