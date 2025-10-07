# 📱 Aplikasi Manajemen Sales dan Pemasaran

> Aplikasi mobile berbasis **Flutter (GetX)** yang terintegrasi dengan backend **Laravel**, dirancang untuk membantu perusahaan mengelola tim sales, lead, aktivitas lapangan, KPI, payroll, serta pelatihan produk secara efisien.

---

## 🌟 Deskripsi Singkat

**Aplikasi Manajemen Sales dan Pemasaran** dikembangkan oleh **PT Razen Teknologi Indonesia** sebagai solusi digital bagi perusahaan untuk menghubungkan admin perusahaan dengan tim sales lapangan (online & offline).

Aplikasi ini memungkinkan sales untuk:

- Melihat produk dan berbagi link promosi,
- Menerima & mengelola lead,
- Melakukan follow-up, absensi GPS, serta tracking KPI,
- Melihat komisi & slip gaji,
- Mengikuti pelatihan e-learning dan kuis produk.

Backend Laravel berperan sebagai **API server** yang menangani autentikasi, manajemen data, dan integrasi database MySQL untuk seluruh aktivitas yang dilakukan oleh aplikasi mobile.

---

## 💡 Fitur Utama (Mobile App - Flutter GetX)

| Modul                              | Deskripsi                                                                                                                             |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| 🔐 **Autentikasi & Registrasi**    | Sales dapat registrasi dengan data lengkap (NIK, rekening, area kerja) dan menunggu verifikasi admin perusahaan.                      |
| 🏠 **Dashboard Sales**             | Menampilkan KPI, total lead hari ini, komisi bulan berjalan, serta leaderboard performa.                                              |
| 🛍️ **Katalog Produk & Promosi**    | Menampilkan semua produk perusahaan, lengkap dengan harga, komisi, dan link promosi unik (referral link & QR code).                   |
| 👥 **Manajemen Lead**              | Menampilkan daftar lead yang masuk, update status pipeline (new → contacted → qualified → won/lost), dan membuat lead manual offline. |
| 📞 **Aktivitas Sales (Follow-up)** | Catat semua interaksi dengan calon pelanggan seperti call, meeting, visit, email, dan set reminder follow-up berikutnya.              |
| 📍 **Absensi & GPS Tracking**      | Check-in/out harian dengan validasi lokasi dan riwayat kehadiran.                                                                     |
| 📊 **KPI & Target Sales**          | Tampilkan target KPI, progress, dan history pencapaian per periode.                                                                   |
| 💰 **Payroll & Komisi**            | Lihat slip gaji digital bulanan, detail komponen gaji (gaji pokok, bonus, komisi), dan histori pembayaran.                            |
| 🎓 **E-Learning & Quiz Produk**    | Akses materi pelatihan, video, dokumen, dan ikuti kuis dengan auto-grading dan sertifikat.                                            |
| 🔔 **Notifikasi & Reminder**       | Push notification real-time untuk lead baru, jadwal follow-up, deadline KPI, dan pengumuman admin.                                    |

---

## 🗄️ Desain Database (ERD)

Struktur database terdiri dari **26 tabel** yang mengelola seluruh aktivitas utama sistem mulai dari autentikasi, manajemen perusahaan, sales, lead, transaksi, KPI, payroll, e-learning, hingga logging sistem.

```markdown
![Database](https://github.com/satrioramadhan/aplikasi_manajemen_sales_dan_pemasaran/blob/main/assets/Untitled.png?raw=true)
```

### 📋 Daftar Tabel dan Fungsinya

| No  | Nama Tabel                  | Fungsi Utama                                                                                                                  |
| --- | --------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| 1   | **users**                   | Menyimpan akun login untuk semua pengguna sistem (admin, company, sales). Menjadi sumber utama autentikasi dan kontrol akses. |
| 2   | **companies**               | Menyimpan data perusahaan klien yang menggunakan sistem, terkait dengan akun `users`.                                         |
| 3   | **sales_profiles**          | Menyimpan profil detail sales seperti NIK, area kerja, rekening, dan status verifikasi.                                       |
| 4   | **products**                | Menyimpan katalog produk per perusahaan lengkap dengan harga, komisi, status, dan deskripsi.                                  |
| 5   | **landing_pages**           | Menyimpan halaman promosi otomatis untuk tiap produk agar bisa dibagikan ke calon pelanggan.                                  |
| 6   | **leads**                   | Menyimpan data prospek/calon pembeli dari berbagai sumber (online, offline, referral, landing page, manual).                  |
| 7   | **lead_activities**         | Mencatat aktivitas follow-up sales terhadap lead (telepon, meeting, email, dll) untuk tracking progres pipeline.              |
| 8   | **orders**                  | Menyimpan transaksi penjualan hasil closing dari lead, lengkap dengan status pembayaran dan komisi sales.                     |
| 9   | **kpi_settings**            | Template pengaturan KPI yang dibuat oleh perusahaan untuk mengatur target penjualan, aktivitas, dan konversi.                 |
| 10  | **kpi_tracking**            | Tracking capaian KPI setiap sales berdasarkan periode yang ditentukan (harian, bulanan, tahunan).                             |
| 11  | **payroll_settings**        | Template pengaturan gaji dan tunjangan (base salary, allowance, potongan, bonus KPI, komisi).                                 |
| 12  | **payrolls**                | Menyimpan slip gaji digital tiap sales per bulan, lengkap dengan perhitungan komisi dan bonus otomatis.                       |
| 13  | **sales_activities**        | Mencatat aktivitas umum sales (training, meeting internal, presentasi) yang tidak terkait dengan lead.                        |
| 14  | **elearning_categories**    | Menyimpan kategori pelatihan (Product Knowledge, Sales Technique, Customer Service, dll).                                     |
| 15  | **elearning_materials**     | Menyimpan materi pelatihan berupa dokumen, video, presentasi, atau link eksternal.                                            |
| 16  | **elearning_progress**      | Mencatat progress belajar setiap sales terhadap materi pelatihan yang ada di sistem.                                          |
| 17  | **product_quizzes**         | Menyimpan data kuis untuk menguji pengetahuan produk sales.                                                                   |
| 18  | **quiz_questions**          | Menyimpan pertanyaan untuk tiap kuis dengan format pilihan ganda, benar/salah, atau esai.                                     |
| 19  | **quiz_attempts**           | Menyimpan riwayat percobaan kuis sales, skor yang didapat, dan status kelulusan.                                              |
| 20  | **notifications**           | Menyimpan notifikasi sistem untuk user, seperti lead baru, KPI reminder, training, dan payment update.                        |
| 21  | **reminders**               | Menyimpan pengingat otomatis (lead follow-up, meeting, deadline KPI) yang akan dikirim sesuai waktu.                          |
| 22  | **api_integrations**        | Menyimpan konfigurasi integrasi eksternal seperti Midtrans, Xendit, Google Analytics, atau Mailchimp.                         |
| 23  | **system_logs**             | Menyimpan catatan aktivitas penting pengguna (audit trail) untuk keamanan dan debugging.                                      |
| 24  | **attendance**              | Mencatat absensi sales menggunakan GPS (check-in/out), lokasi, dan status kehadiran.                                          |
| 25  | **lead_distribution_rules** | Menyimpan aturan otomatis distribusi lead ke sales berdasarkan area, produk, atau metode round-robin.                         |
| 26  | **commission_transactions** | Mencatat detail transaksi komisi dari setiap order untuk rekonsiliasi dan histori pembayaran.                                 |

> ⚙️ Semua tabel saling terhubung melalui **foreign key** dengan aturan **ON DELETE CASCADE** untuk menjaga konsistensi data antar modul.

---

## 🧪 Teknologi yang Digunakan

| Kategori            | Teknologi             | Deskripsi                                                                     |
| ------------------- | --------------------- | ----------------------------------------------------------------------------- |
| **Frontend Mobile** | Flutter (GetX)        | Framework cross-platform untuk iOS & Android dengan state management reaktif. |
| **Backend API**     | Laravel               | Framework PHP modern untuk REST API & integrasi database.                     |
| **Database**        | MySQL                 | Database relasional dengan 26 tabel terintegrasi.                             |
| **Autentikasi**     | Laravel Sanctum / JWT | Autentikasi API aman antar platform.                                          |
| **Notifikasi**      | Firebase / OneSignal  | Push notification real-time ke mobile sales.                                  |
| **Payment Gateway** | Midtrans / Xendit     | Integrasi transaksi dan komisi otomatis.                                      |
| **Version Control** | Git & GitHub          | Manajemen versi dan kolaborasi tim.                                           |

---

## 🦯 Alur Penggunaan (Mobile App)

1. 📲 **Sales registrasi akun** melalui mobile app.
2. 🕵️‍♂️ **Admin perusahaan verifikasi akun** sales via dashboard web.
3. 💼 Sales **melihat katalog produk**, membagikan link promosi.
4. 👥 Lead yang masuk dari landing page **otomatis terhubung ke sales terkait**.
5. 📈 Sales **melakukan follow-up, input aktivitas, dan update pipeline**.
6. 💰 Sistem **menghitung komisi, KPI, dan payroll otomatis**.
7. 🎓 Sales **mengikuti pelatihan & kuis produk langsung di aplikasi.**

---

## 🛠️ Cara Setup Proyek (Mobile Flutter)

```bash
# Clone repository
git https://github.com/satrioramadhan/aplikasi_manajemen_sales_dan_pemasaran.git

# Masuk ke folder proyek
cd your-sales-app

# Install dependencies
flutter pub get

# Jalankan aplikasi
flutter run
```

> Pastikan environment API di file `.env` atau `constants/api.dart` sudah diarahkan ke endpoint Laravel backend.

---

## 👥 Role Pengguna

| Role                    | Platform         | Deskripsi                                                         |
| ----------------------- | ---------------- | ----------------------------------------------------------------- |
| 🤑 **Super Admin**      | Web              | Mengelola semua perusahaan, verifikasi, monitoring sistem.        |
| 🏢 **Admin Perusahaan** | Web              | Mengelola produk, sales, KPI, payroll, dan laporan.               |
| 🚀 **Sales (Mobile)**   | Flutter          | Melakukan aktivitas penjualan, lead, absensi, KPI, dan pelatihan. |
| 👥 **Konsumen (Guest)** | Web Landing Page | Melihat produk & mengisi form lead tanpa login.                   |

---
