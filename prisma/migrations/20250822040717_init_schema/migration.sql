-- CreateTable
CREATE TABLE "public"."pengguna" (
    "id" TEXT NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "berat_badan_kg" DECIMAL(5,2),
    "tanggal_lahir" DATE,
    "data_profil_tambahan" JSONB,
    "waktu_dibuat" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "waktu_diperbarui" TIMESTAMP(3),
    "waktu_dihapus" TIMESTAMP(3),

    CONSTRAINT "pengguna_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."perangkat_pengguna" (
    "id" SERIAL NOT NULL,
    "uuid" UUID NOT NULL,
    "id_pengguna" TEXT NOT NULL,
    "nama_perangkat" VARCHAR(100),
    "token_fcm" TEXT NOT NULL,
    "waktu_login_terakhir" TIMESTAMP(3),
    "waktu_dibuat" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "perangkat_pengguna_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."log_konsumsi" (
    "id" SERIAL NOT NULL,
    "uuid" UUID NOT NULL,
    "id_pengguna" TEXT NOT NULL,
    "waktu_pencatatan" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "jumlah_ml" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "log_konsumsi_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."log_aktivitas_ringan" (
    "id" SERIAL NOT NULL,
    "uuid" UUID NOT NULL,
    "id_pengguna" TEXT NOT NULL,
    "waktu_mulai" TIMESTAMP(3) NOT NULL,
    "jumlah_langkah" INTEGER NOT NULL,
    "koefisien_lingkungan" DECIMAL(3,2) NOT NULL,
    "tambahan_hidrasi_ml" DECIMAL(10,2) NOT NULL,
    "waktu_dibuat" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "log_aktivitas_ringan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ref_jenis_aktivitas" (
    "id" SERIAL NOT NULL,
    "nama_aktivitas" VARCHAR(100) NOT NULL,
    "koefisien_intensitas" DECIMAL(4,2) NOT NULL,

    CONSTRAINT "ref_jenis_aktivitas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."sesi_aktivitas_berat" (
    "id" SERIAL NOT NULL,
    "uuid" UUID NOT NULL,
    "id_pengguna" TEXT NOT NULL,
    "id_jenis_aktivitas" INTEGER NOT NULL,
    "waktu_mulai" TIMESTAMP(3) NOT NULL,
    "durasi_menit" INTEGER NOT NULL,
    "koefisien_intensitas" DECIMAL(4,2) NOT NULL,
    "koefisien_lingkungan" DECIMAL(3,2) NOT NULL,
    "tambahan_hidrasi_ml" DECIMAL(10,2) NOT NULL,
    "waktu_dibuat" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "waktu_diperbarui" TIMESTAMP(3),
    "waktu_dihapus" TIMESTAMP(3),

    CONSTRAINT "sesi_aktivitas_berat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ringkasan_harian" (
    "id" SERIAL NOT NULL,
    "uuid" UUID NOT NULL,
    "id_pengguna" TEXT NOT NULL,
    "tanggal" DATE NOT NULL,
    "hidrasi_basal_ml" DECIMAL(10,2),
    "total_tambahan_ringan_ml" DECIMAL(10,2),
    "total_tambahan_berat_ml" DECIMAL(10,2),
    "target_total_ml" DECIMAL(10,2),
    "konsumsi_total_ml" DECIMAL(10,2),

    CONSTRAINT "ringkasan_harian_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ringkasan_bulanan" (
    "id" SERIAL NOT NULL,
    "uuid" UUID NOT NULL,
    "id_pengguna" TEXT NOT NULL,
    "bulan_mulai" DATE NOT NULL,
    "rata_rata_target_harian_ml" DECIMAL(10,2),
    "rata_rata_konsumsi_harian_ml" DECIMAL(10,2),
    "tingkat_kepatuhan_persen" DECIMAL(5,2),

    CONSTRAINT "ringkasan_bulanan_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "pengguna_email_key" ON "public"."pengguna"("email");

-- CreateIndex
CREATE UNIQUE INDEX "perangkat_pengguna_uuid_key" ON "public"."perangkat_pengguna"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "perangkat_pengguna_token_fcm_key" ON "public"."perangkat_pengguna"("token_fcm");

-- CreateIndex
CREATE UNIQUE INDEX "log_konsumsi_uuid_key" ON "public"."log_konsumsi"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "log_aktivitas_ringan_uuid_key" ON "public"."log_aktivitas_ringan"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "ref_jenis_aktivitas_nama_aktivitas_key" ON "public"."ref_jenis_aktivitas"("nama_aktivitas");

-- CreateIndex
CREATE UNIQUE INDEX "sesi_aktivitas_berat_uuid_key" ON "public"."sesi_aktivitas_berat"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "ringkasan_harian_uuid_key" ON "public"."ringkasan_harian"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "ringkasan_harian_id_pengguna_tanggal_key" ON "public"."ringkasan_harian"("id_pengguna", "tanggal");

-- CreateIndex
CREATE UNIQUE INDEX "ringkasan_bulanan_uuid_key" ON "public"."ringkasan_bulanan"("uuid");

-- CreateIndex
CREATE UNIQUE INDEX "ringkasan_bulanan_id_pengguna_bulan_mulai_key" ON "public"."ringkasan_bulanan"("id_pengguna", "bulan_mulai");

-- AddForeignKey
ALTER TABLE "public"."perangkat_pengguna" ADD CONSTRAINT "perangkat_pengguna_id_pengguna_fkey" FOREIGN KEY ("id_pengguna") REFERENCES "public"."pengguna"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."log_konsumsi" ADD CONSTRAINT "log_konsumsi_id_pengguna_fkey" FOREIGN KEY ("id_pengguna") REFERENCES "public"."pengguna"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."log_aktivitas_ringan" ADD CONSTRAINT "log_aktivitas_ringan_id_pengguna_fkey" FOREIGN KEY ("id_pengguna") REFERENCES "public"."pengguna"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."sesi_aktivitas_berat" ADD CONSTRAINT "sesi_aktivitas_berat_id_pengguna_fkey" FOREIGN KEY ("id_pengguna") REFERENCES "public"."pengguna"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."sesi_aktivitas_berat" ADD CONSTRAINT "sesi_aktivitas_berat_id_jenis_aktivitas_fkey" FOREIGN KEY ("id_jenis_aktivitas") REFERENCES "public"."ref_jenis_aktivitas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ringkasan_harian" ADD CONSTRAINT "ringkasan_harian_id_pengguna_fkey" FOREIGN KEY ("id_pengguna") REFERENCES "public"."pengguna"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."ringkasan_bulanan" ADD CONSTRAINT "ringkasan_bulanan_id_pengguna_fkey" FOREIGN KEY ("id_pengguna") REFERENCES "public"."pengguna"("id") ON DELETE CASCADE ON UPDATE CASCADE;
