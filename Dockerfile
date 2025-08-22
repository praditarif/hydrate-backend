# Gunakan image resmi Node.js sebagai dasar
FROM node:18-alpine

# Atur direktori kerja di dalam kontainer
WORKDIR /usr/src/app

# Salin package.json dan package-lock.json
COPY package*.json ./

# Instal dependensi aplikasi
RUN npm install

# SALIN SKEMA PRISMA TERLEBIH DAHULU
COPY ./prisma ./prisma

# SEKARANG JALANKAN PRISMA GENERATE
RUN npx prisma generate

# Salin sisa kode sumber aplikasi
COPY . .

# Buka port agar bisa diakses dari luar kontainer
EXPOSE 3000

# Definisikan perintah untuk menjalankan aplikasi Anda
CMD [ "npm", "start" ]