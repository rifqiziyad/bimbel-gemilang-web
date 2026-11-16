# Spesifikasi Komponen & Token Visual per Halaman (`UI Component Spec`)

Dokumen ini menjadi referensi **Token-Mapped Design-to-Code** untuk Phase 4 (Next.js App Router + Tailwind CSS v4) yang diekstrak langsung dari [design/bimbel-gemilang.figcraft](file:///Users/rifqiziyadimtinan/Documents/Work/Bimbel%20Gemilang/bimbel-gemilang-web/design/bimbel-gemilang.figcraft) dan [design/tokens.css](file:///Users/rifqiziyadimtinan/Documents/Work/Bimbel%20Gemilang/bimbel-gemilang-web/design/tokens.css).

> **Aturan Kesetaraan Konten:** Gunakan inventori komponen di bawah ini bersama [docs/CONTENT_PARITY_GUIDELINES.md](file:///Users/rifqiziyadimtinan/Documents/Work/Bimbel%20Gemilang/bimbel-gemilang-web/docs/CONTENT_PARITY_GUIDELINES.md) agar **100% konten tampil utuh di Mobile (`390px`), Tablet (`768px`–`1023px`), dan Desktop (`1440px`)**.

---

## 1. Skala Token Visual Global (`design/tokens.css`)

### A. Warna & Gradien Utama
- **Surface Alternation Publik:** `bg-cream-soft` (`#FFFBEA`), `bg-white` (`#FFFFFF`), `bg-bg` (`#F8FAFC`), `bg-teal` (`#035D61`), dan `bg-crimson` (`#BE1E2D`).
- **Gradien Baku:**
  - **Hero Beranda:** `linear-gradient(180deg, #FFFBEA 0%, #FEF4CD 100%)`
  - **Footer Publik:** `linear-gradient(180deg, #FEF4CD 0%, #E0C32B 100%)`
  - **Banner Program Khusus:** `linear-gradient(180deg, #035D61 0%, #1E1B4B 100%)` dengan border `border-gold` (`#E0C32B`)
  - **Card Form Hubungi Kami:** `linear-gradient(180deg, #2D3091 0%, #035D61 100%)`
- **Status Admin Portal:**
  - **Normal / Published:** `bg-white` (`#FFFFFF`), border `border-border-normal` (`#E2E8F0`)
  - **Draft (Ada Perubahan Belum Publish):** `bg-draft-bg` (`#FFFBEB`), border `border-draft-border` (`#F59E0B`)
  - **Active Edit / Focus:** Border tegas `border-edited-border` (`#2D3091`)

### B. Skala Tipografi (`font-display` & `font-sans`)
| Role | Font Family & Weight | Ukuran Desktop | Adaptasi Tablet / Mobile | Warna Default |
|---|---|---|---|---|
| **H1 Hero** | `Poppins` Bold (`700`) | `38px`–`48px` (Siapa Kami `52px`) | `28px`–`34px` | `text-indigo` / `text-heading` |
| **H2 Section** | `Poppins` Bold (`700`) | `28px`–`32px` (Track H2 `40px`) | `22px`–`26px` | `text-indigo` (atau `text-white` di `bg-teal`) |
| **H3 Card Title** | `Poppins` SemiBold/Bold (`600–700`) | `17px`–`20px` | `16px`–`18px` | `text-heading` / `text-indigo` |
| **Body Copy** | `Nunito Sans` Regular (`400`) | `15px`–`16px` (`leading-relaxed`) | `14px`–`15px` | `text-body` (`#364151`) |
| **Caption / Label** | `Nunito Sans` SemiBold (`600`) | `12px`–`14px` | `12px`–`13px` | `text-muted` (`#64748B`) |

### C. Radius & Container Padding
- **Container Section Padding:** Mobile `px-5 py-7` (`20px`/`28px`), Tablet `md:px-10 md:py-10`, Desktop `lg:px-20 lg:py-12` (`80px` horizontal, `48–56px` vertical), `max-w-7xl mx-auto`.
- **Border Radius:** Kartu `rounded-card` (`16px`–`20px`), Hero/Banner card `rounded-banner` (`24px`), Tombol CTA & Nav Pill `rounded-full` (`9999px`).

---

## 2. Komponen Shared Global (Dipakai Lintas Halaman)

1. **`Navbar` (`Component/Navbar`)**
   - **Style:** Background `bg-white`, bottom border `border-border-normal`, brand `Poppins` Bold `16px` `text-indigo`, link `14px` `text-body`, CTA kanan pill `rounded-full bg-indigo text-white`.
   - **Layout:** Desktop bar horizontal (`Home`, `Program ▾`, `Tentang Kami ▾`, CTA `Konsultasi Gratis →`); Mobile & Tablet (`< 1024px`) Hamburger Drawer berisi **100% link & CTA**.
2. **`Footer` (`Footer 3 Kolom`)**
   - **Style:** Background gradien emas (`#FEF4CD -> #E0C32B`), teks kolom `13px` (`text-heading` & `text-indigo` Bold).
   - **Komposisi 3 Kolom:** Col 1 (Logo + Copyright `© 2026 Bimbel Gemilang`), Col 2 (Link seluruh Program & Tentang Kami), Col 3 (Alamat Cirendeu & Jam Operasional). Stack 1 kolom di Mobile, `md:grid-cols-2`, `lg:grid-cols-3`.
3. **`CTA Banner #BimbelforGEMILANG`**
   - **Style:** Background `bg-cream-soft` (`#FFFBEA`), judul `Poppins` Bold `32px` `text-indigo`, tombol pill `rounded-full bg-indigo-soft` (`#4E5693`) `text-white`.
4. **`AktivitasCarousel` (`Aktivitas Kami Gallery`)**
   - **Style:** Section `bg-teal` (`#035D61`), judul `Poppins` Bold `30px` `text-white` sejajar (`justify-between`) dengan sepasang tombol panah **carousel `←` & `→`** (`rounded-full bg-white border-2 border-gold text-teal shadow-sm`).
   - **Foto Card:** Frame rasio seragam, `rounded-[14px]`, `border-2 border-gold`.
   - **Viewport:** `1` foto (Mobile), `2` foto (Tablet), `3` foto (Desktop).
5. **`MentorCarousel` (`Mentor Kami`)**
   - **Style:** Section `bg-bg` (`#F8FAFC`), judul `Poppins` Bold `30px` `text-indigo` sejajar dengan tombol panah **carousel `←` & `→`** (`rounded-full bg-white border border-slate-300 text-indigo shadow-sm`).
   - **Mentor Card:** Avatar bulat gradien krem lembut, badge nama `bg-teal text-white font-display font-bold`, label bidang studi `text-indigo font-sans italic`.
   - **Viewport:** `1`–`2` kartu (Mobile), `2`–`3` kartu (Tablet), `4` kartu per slide (Desktop).

---

## 3. Inventori Komponen & Style Tiap Halaman Publik (8 Rute)

### Halaman 1: `/` — Beranda (`Home`)
Urutan section dari atas ke bawah:
1. **`Navbar`** — `bg-white border-b border-border-normal`
2. **`HeroSection`** — Background gradien `#FFFBEA -> #FEF4CD`; Split 2 kolom (`flex-col md:grid-cols-2`), kiri: Headline (`20+ tahun pengalaman, 5000+ Alumni Berprestasi!`), subtitle, 2 tombol CTA (`Gabung Sekarang (WA) →` `bg-indigo`, `Lihat Program Kami` outline `border-indigo`); kanan: slider foto aktivitas berbingkai `rounded-banner border-2 border-indigo`.
3. **`StatsStrip`** — `bg-teal` (`#035D61`), 3 metrik sejajar (`2005` Tahun berdiri, `±5100` Alumni Gemilang, `80%` Alumni tembus PTN), angka `Poppins` Bold `text-white` / aksen `text-gold`, label kecil `text-cream-soft`.
4. **`MengapaPilihGemilang`** — `bg-cream-soft`, heading centered `text-indigo`, 6 kartu (`grid-cols-1 md:grid-cols-2 lg:grid-cols-3`): masing-masing `bg-white rounded-card border border-border-normal shadow-sm p-6`, judul `H3` + deskripsi `Body`.
5. **`ProgramKamiGrid`** — `bg-white`, 4 kartu program (`grid-cols-1 md:grid-cols-2 gap-6`): `PTN & TKA`, `Bimbel SD, SMP, & SMA`, `English for Kids`, `Program Khusus` (banner gradien bebas watermark `bg-teal -> bg-dark-indigo`), + sub-catatan `Kami menyesuaikan program sesuai kebutuhan mu!...` (`18px` Bold `text-heading`).
6. **`AktivitasCarousel`** — `bg-teal` + panah `←`/`→`.
7. **`MentorCarousel`** — `bg-bg` + panah `←`/`→`.
8. **`KontakAlamatSummary`** — `bg-white`, heading `text-indigo`, split 2 kolom (`md:grid-cols-2`): kiri box alamat Cirendeu + WA `0813-8523-7190`; kanan tombol CTA sosial media pill `bg-indigo text-white` (`Whatsapp`, `IG / TikTok / FB`).
9. **`CTA #BimbelforGEMILANG`** — `bg-cream-soft`.
10. **`Footer`** — Gradien `#FEF4CD -> #E0C32B`.

### Halaman 2: `/program` — Katalog Program
*(Menggantikan halaman template Astra Daycare)*
1. **`Navbar`**
2. **`CatalogHeader`** — `bg-cream-soft`, H1 `38px` `text-indigo`, subheadline `16px` `text-body`.
3. **`ProgramCardsSummary`** — `bg-white`, 4 kartu (`grid-cols-1 md:grid-cols-2`) `bg-bg border border-border-normal rounded-card`: judul program (`18px` `text-heading`), ringkasan singkat, link aksi `14px` Bold `text-indigo`.
4. **`CTA #BimbelforGEMILANG`** & **`Footer`**.

### Halaman 3: `/ptn-tka` — Program PTN & TKA
1. **`Navbar`**
2. **`HeroBannerPTN`** — `bg-cream-soft`, container banner `bg-dark-crimson` (`#881337`) `rounded-banner border-2 border-gold`, CTA pill `bg-indigo text-white`, intro copy `17px` `text-body`.
3. **`AlumniProofSplit`** — `bg-white`, split `md:grid-cols-2`: highlight stat `80%` `text-crimson` + daftar 10 nama alumni & kampus UI/UGM/ITB/Unpad/UB/UIN JKT; kanan foto kelulusan `rounded-[20px] border-2 border-gold`.
4. **`FokusKamiPTN`** — `bg-cream-soft`, heading `28px` `text-indigo`, 3 kartu (`grid-cols-1 md:grid-cols-3`) `bg-white rounded-card border-border-normal`.
5. **`FiturKamiPills`** — `bg-white`, 5 badge fitur (`84x pertemuan`, `TO Bulanan IRT`, `Konsul gratis tiap hari`, `Modul lengkap`, `Kelas kecil max 10 siswa`) dengan ikon vektor rapi (bukan emoji mentah).
6. **`AktivitasStripCrimson`** — `bg-crimson` (`#BE1E2D`), 3 foto kegiatan belajar (`1`/`2`/`3` kolom).
7. **`RincianBiayaPTN`** — `bg-bg`, heading `30px` `text-indigo`, tabel/kartu paket `bg-white rounded-[20px] border-2 border-crimson`: `1 Tahun/84x` (`Rp 8.4jt / Rp 9.4jt`), `6 Bulan/42x` (`Rp 5.4jt / Rp 6.4jt`), `3 Bulan/30x` (`Rp 4.4jt / Rp 5.4jt`), plus catatan `*Biaya pendaftaran: Rp. 150.000 • 2x sesi/minggu`. Di mobile tampil sebagai *stacked cards*.
8. **`Footer`**.

### Halaman 4: `/bimbel-sd-smp-sma` — Bimbel SD, SMP, & SMA
1. **`Navbar`**
2. **`HeroBannerSDSMPSMA`** — `bg-cream-soft`, container banner `bg-dark-indigo` (`#1E1B4B`) `rounded-banner border-2 border-gold`, CTA pill `bg-indigo`.
3. **`TrackGroupSection`** — `bg-white`, H2 `40px` `text-teal` (`GROUP: 5–10 Siswa`), deskripsi, split `md:grid-cols-2`: kiri 3 kartu Fokus Kami, kanan daftar 5 harga (`SD 4-5 Rp 300rb` s.d. `SMA 10-11 Rp 500rb/bln`).
4. **`HighlightStripTeal`** — `bg-teal` (`#035D61`), copy `20px` `text-white`: *Gratis Konsultasi Belajar setiap Hari* & *Prestasi & Nilai Setiap Siswa 100% Dipantau*.
5. **`TrackPrivateSection`** — `bg-white`, H2 `40px` `text-teal` (`PRIVATE: 1 Tutor 1 Siswa`), split 3 Fokus Kami & daftar 6 harga (`SD 1-5 Rp 900rb` s.d. `SMA 12 Rp 1.9jt/bln`).
6. **`AlumniTaglineCTA`** — `bg-cream-soft`, tagline `18px` `text-heading` + CTA pill `bg-indigo`.
7. **`Footer`**.

### Halaman 5: `/english-for-kids` — English for Kids
1. **`Navbar`**
2. **`HeroBannerEFK`** — `bg-cream-soft`, container banner `bg-efk-yellow` (`#FACC15`) `rounded-banner border-2 border-indigo`, CTA pill `bg-indigo`.
3. **`FokusKamiEFK`** — `bg-white`, 2 kartu `bg-cream border border-gold rounded-card` (*Anak PD Berbahasa Inggris* & *Mengenalkan Kosakata & Tata Bahasa*, **tanpa kartu duplikat WP**) diapit ilustrasi karakter perempuan & laki-laki di desktop (`stack` rapi di mobile/tablet).
4. **`LevelKurikulumEFK`** — `bg-bg` (`#F8FAFC`), 5 kartu level dengan warna aksen masing-masing (`rounded-card`, title `24px` Bold, bullet silabus `14px` `text-body`):
   - **Starter:** `bg-teal-tint` (`#ECFEFF`), border & judul `text-teal` (`#035D61`)
   - **Beginner:** `bg-indigo-tint` (`#EEF2FF`), border & judul `text-indigo` (`#2D3091`)
   - **Middle:** `bg-draft-bg` (`#FFFBEB`), border `border-gold` (`#E0C32B`), judul `#B45309`
   - **Upper:** `bg-crimson-tint` (`#FEF2F2`), border & judul `text-crimson` (`#BE1E2D`)
   - **Higher:** `bg-slate-tint` (`#F1F5F9`), border `#475569`, judul `text-heading` (`#0F172A`)
5. **`BiayaEFKSection`** — `bg-cream-soft`, harga `40px` Bold `text-indigo` (`Rp. 1.450.000 / level`), badge pill `bg-crimson text-white` (`24x sesi / 4 bulan`), CTA hint `16px`.
6. **`Footer`**.

### Halaman 6: `/program-khusus` — Program Khusus
1. **`Navbar`**
2. **`HeroProgramKhusus`** — `bg-cream-soft`, banner vektor bersih bebas watermark gradien `bg-teal -> bg-dark-indigo` `rounded-banner border-2 border-gold` (kicker `text-gold`, H1 `48px` `text-white`, wrap tags `Bahasa Asing • TOEFL • IELTS • Olah Data`), CTA pill `bg-indigo`, intro text `16px` `text-body`.
3. **`FokusKamiPK`** — `bg-white`, 3 kartu (`grid-cols-1 md:grid-cols-3`) `bg-teal-tint` (`#ECFEFF`) `border border-teal rounded-card`, title `17px` `text-indigo`, desc `15px` `text-body`.
4. **`Footer`**.

### Halaman 7: `/siapa-kami` — Siapa Kami
1. **`Navbar`**
2. **`SplitHeroSiapaKami`** — `bg-cream-soft`, H1 `52px` (`text-indigo`), deskripsi sejarah sejak 2005 (`5000+ murid berprestasi`) `22px` `text-indigo`, split visual.
3. **`SejarahCollageQuote`** — `bg-cream-soft`, foto kolase `siapa-kami-gallery-1.webp` + kutipan prioritas `16px` `text-body`.
4. **`PilarNilaiGemilang`** — `bg-white`, H2 `26px` `text-indigo` + 4 badge pilar nilai bersih (**tanpa pengulangan pill bug WP**).
5. **`MentorCarousel` & `AktivitasCarousel`** (mengacu ke PRD untuk kesatuan bukti sosial) + **`Footer`**.

### Halaman 8: `/alamat-kontak-kami` — Alamat & Kontak Kami
1. **`Navbar`**
2. **`KontakResmiPills`** — `bg-cream-soft`, H1 `38px` `text-indigo`, 3 pill kontak `bg-teal text-white rounded-full` (`0813-8523-7190`, `bimbelforgemilang@gmail.com`, `@bimbelforgemilang`), tata letak `grid-cols-1 md:grid-cols-3`.
3. **`AlamatStorefrontMap`** — `bg-white`, H2 `30px` `text-indigo`, split `md:grid-cols-2`: kiri foto tempat bimbel `rounded-[18px]` + Embed Google Maps interaktif; kanan alamat lengkap Cirendeu, jam operasional (Senin–Minggu), & daftar 6 landmark jarak sekitar.
4. **`FormHubungiKamiSection`** — `bg-bg`, Form Card `rounded-[20px]` gradien `#2D3091 -> #035D61`, judul `22px` `text-white`, input & textarea `bg-white rounded-[10px]` (placeholder netral tanpa `"Yusuf"`), tombol submit pill `bg-cream text-indigo font-bold`.
5. **`Footer`**.

---

## 4. Inventori & Style Portal Admin (`/admin` — Khusus Desktop)

Seluruh layar Admin memakai kanvas `bg-bg` (`#F8FAFC`), tipografi `Poppins` / `Nunito Sans`, dan **hanya dapat dioperasikan di perangkat Desktop (`>= 1024px`)**:

1. **`AdminLoginCard` (`/admin/login`)**
   - Center card `bg-white border border-border-normal rounded-[20px] p-9` di atas `bg-bg`; input email/password + tombol login `bg-indigo text-white`.
2. **`AdminAppShell` (`/admin/*`)**
   - **Desktop Only (`>= 1024px`):** Sidebar kiri tetap `bg-dark-indigo` (`#1E1B4B`), brand `text-gold` (`#E0C32B`), item menu default `#CBD5E1`, item aktif `bg-indigo text-white rounded-[10px]`, badge counter draft pill `bg-draft-border` (`#F59E0B`).
   - **Mobile & Tablet Guard (`< 1024px`):** Menampilkan **`DesktopOnlyGuardCard`** (`05 - Desktop-Only Guard Notice` di FigCraft): topbar `bg-dark-indigo text-white` + badge crimson `DESKTOP ONLY` + card pesan *"Portal Admin Khusus Perangkat Desktop (>= 1024px)"* dan tombol kembali ke Beranda.
3. **`StickyActionBar`**
   - Card atas `bg-white border border-border-normal rounded-[14px]` menampilkan judul modul, jumlah item berstatus Draft, tombol `Preview Draft` (`/admin/preview`), `Buang Draft`, `Simpan Draft`, & `Publish`.
4. **`AdminSectionCard` & Penanda Status Visual**
   - **Published / Normal:** `bg-white border border-border-normal rounded-card`
   - **Draft (Berubah / Unpublished):** `bg-draft-bg` (`#FFFBEB`) + **`border-2 border-draft-border` (`#F59E0B`)** + badge `"Draft"`
   - **Sedang Diedit (Focused/Modified Field):** `border-2 border-edited-border` (`#2D3091`)
5. **`LivePreviewShell` (`/admin/preview`)**
   - Top bar tetap `bg-dark-indigo text-white` berisi toggle highlight perubahan, tombol *Kembali ke Editor*, dan *Publish Sekarang*.
   - Bagian konten website yang berstatus draft disorot dengan overlay/border `border-2 border-draft-border bg-draft-bg/40` agar admin mudah membedakan mana bagian yang diedit sebelum dipublikasikan.
6. **`AdminLeadsList` (`/admin/leads`)**
   - Tabel pendaftar di layar Desktop dengan badge status (`Baru`, `Dihubungi`, `Terdaftar`, `Arsip`), filter status, dan tombol langsung `Chat via WhatsApp`.
