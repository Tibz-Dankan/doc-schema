-- CreateEnum
CREATE TYPE "Role" AS ENUM ('patient', 'doctor', 'admin');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('male', 'female');

-- CreateEnum
CREATE TYPE "AppointmentStatusEnum" AS ENUM ('pending', 'rescheduled', 'edited', 'approved', 'cancelled', 'done');

-- CreateEnum
CREATE TYPE "Weekday" AS ENUM ('sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday');

-- CreateTable
CREATE TABLE "_users" (
    "userId" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "gender" "Gender" NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'patient',
    "password" TEXT NOT NULL,
    "imageUrl" TEXT,
    "imagePath" TEXT,
    "passwordResetToken" TEXT,
    "passwordResetExpiresAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_users_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "_access_tokens" (
    "tokenId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_access_tokens_pkey" PRIMARY KEY ("tokenId")
);

-- CreateTable
CREATE TABLE "_online_statuses" (
    "onlineStatusId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_online_statuses_pkey" PRIMARY KEY ("onlineStatusId")
);

-- CreateTable
CREATE TABLE "_appointments" (
    "appointmentId" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "doctorId" TEXT NOT NULL,
    "subject" TEXT NOT NULL,
    "startsAt" TIMESTAMP(3) NOT NULL,
    "endsAt" TIMESTAMP(3) NOT NULL,
    "doctorsComment" TEXT,
    "patientsComment" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_appointments_pkey" PRIMARY KEY ("appointmentId")
);

-- CreateTable
CREATE TABLE "_appointment_statuses" (
    "appointmentStatusId" TEXT NOT NULL,
    "appointmentId" TEXT NOT NULL,
    "status" "AppointmentStatusEnum" NOT NULL DEFAULT 'pending',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_appointment_statuses_pkey" PRIMARY KEY ("appointmentStatusId")
);

-- CreateTable
CREATE TABLE "_schedules" (
    "scheduleId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "weekday" "Weekday" NOT NULL,
    "weekdayNum" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_schedules_pkey" PRIMARY KEY ("scheduleId")
);

-- CreateTable
CREATE TABLE "_schedule_times" (
    "scheduleTimeId" TEXT NOT NULL,
    "scheduleId" TEXT NOT NULL,
    "start" TEXT NOT NULL,
    "end" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_schedule_times_pkey" PRIMARY KEY ("scheduleTimeId")
);

-- CreateTable
CREATE TABLE "_medical_files" (
    "medicalFileId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_medical_files_pkey" PRIMARY KEY ("medicalFileId")
);

-- CreateTable
CREATE TABLE "_medical_records" (
    "medicalRecordId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "healthStatus" TEXT NOT NULL,
    "medication" TEXT NOT NULL,
    "illness" TEXT NOT NULL,
    "diet" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_medical_records_pkey" PRIMARY KEY ("medicalRecordId")
);

-- CreateTable
CREATE TABLE "_mental_health" (
    "mentalHealthId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "answeredQuestions" JSONB NOT NULL,
    "aiResponse" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_mental_health_pkey" PRIMARY KEY ("mentalHealthId")
);

-- CreateTable
CREATE TABLE "_chats" (
    "messageId" TEXT NOT NULL,
    "senderId" TEXT NOT NULL,
    "recipientId" TEXT NOT NULL,
    "chatRoomId" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "isDelivered" BOOLEAN NOT NULL DEFAULT false,
    "isRead" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_chats_pkey" PRIMARY KEY ("messageId")
);

-- CreateTable
CREATE TABLE "_notifications" (
    "notificationId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "link" TEXT,
    "isRead" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_notifications_pkey" PRIMARY KEY ("notificationId")
);

-- CreateTable
CREATE TABLE "_devices" (
    "deviceId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "deviceToken" TEXT NOT NULL,
    "devicePlatform" TEXT NOT NULL,
    "isDisable" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_devices_pkey" PRIMARY KEY ("deviceId")
);

-- CreateTable
CREATE TABLE "_video_conferencies" (
    "videoConferenceId" TEXT NOT NULL,
    "hostId" TEXT NOT NULL,
    "attendeeId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_video_conferencies_pkey" PRIMARY KEY ("videoConferenceId")
);

-- CreateTable
CREATE TABLE "_doctors_patients" (
    "doctorsPatientId" TEXT NOT NULL,
    "doctorId" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "_doctors_patients_pkey" PRIMARY KEY ("doctorsPatientId")
);

-- CreateIndex
CREATE UNIQUE INDEX "_users_email_key" ON "_users"("email");

-- CreateIndex
CREATE INDEX "_users_userId_idx" ON "_users"("userId");

-- CreateIndex
CREATE INDEX "_users_email_idx" ON "_users"("email");

-- CreateIndex
CREATE INDEX "_users_role_idx" ON "_users"("role");

-- CreateIndex
CREATE INDEX "_users_passwordResetToken_idx" ON "_users"("passwordResetToken");

-- CreateIndex
CREATE INDEX "_access_tokens_tokenId_idx" ON "_access_tokens"("tokenId");

-- CreateIndex
CREATE INDEX "_access_tokens_userId_idx" ON "_access_tokens"("userId");

-- CreateIndex
CREATE INDEX "_access_tokens_token_idx" ON "_access_tokens"("token");

-- CreateIndex
CREATE UNIQUE INDEX "_online_statuses_userId_key" ON "_online_statuses"("userId");

-- CreateIndex
CREATE INDEX "_online_statuses_onlineStatusId_idx" ON "_online_statuses"("onlineStatusId");

-- CreateIndex
CREATE INDEX "_online_statuses_userId_idx" ON "_online_statuses"("userId");

-- CreateIndex
CREATE INDEX "_appointments_appointmentId_idx" ON "_appointments"("appointmentId");

-- CreateIndex
CREATE INDEX "_appointments_patientId_idx" ON "_appointments"("patientId");

-- CreateIndex
CREATE INDEX "_appointments_doctorId_idx" ON "_appointments"("doctorId");

-- CreateIndex
CREATE INDEX "_appointment_statuses_appointmentStatusId_idx" ON "_appointment_statuses"("appointmentStatusId");

-- CreateIndex
CREATE INDEX "_appointment_statuses_appointmentId_idx" ON "_appointment_statuses"("appointmentId");

-- CreateIndex
CREATE INDEX "_appointment_statuses_status_idx" ON "_appointment_statuses"("status");

-- CreateIndex
CREATE INDEX "_schedules_scheduleId_idx" ON "_schedules"("scheduleId");

-- CreateIndex
CREATE INDEX "_schedules_userId_idx" ON "_schedules"("userId");

-- CreateIndex
CREATE INDEX "_schedules_weekday_idx" ON "_schedules"("weekday");

-- CreateIndex
CREATE INDEX "_schedule_times_scheduleTimeId_idx" ON "_schedule_times"("scheduleTimeId");

-- CreateIndex
CREATE INDEX "_schedule_times_scheduleId_idx" ON "_schedule_times"("scheduleId");

-- CreateIndex
CREATE INDEX "_medical_files_medicalFileId_idx" ON "_medical_files"("medicalFileId");

-- CreateIndex
CREATE INDEX "_medical_files_userId_idx" ON "_medical_files"("userId");

-- CreateIndex
CREATE INDEX "_medical_records_medicalRecordId_idx" ON "_medical_records"("medicalRecordId");

-- CreateIndex
CREATE INDEX "_medical_records_userId_idx" ON "_medical_records"("userId");

-- CreateIndex
CREATE INDEX "_mental_health_mentalHealthId_idx" ON "_mental_health"("mentalHealthId");

-- CreateIndex
CREATE INDEX "_mental_health_userId_idx" ON "_mental_health"("userId");

-- CreateIndex
CREATE INDEX "_chats_senderId_idx" ON "_chats"("senderId");

-- CreateIndex
CREATE INDEX "_chats_recipientId_idx" ON "_chats"("recipientId");

-- CreateIndex
CREATE INDEX "_chats_chatRoomId_idx" ON "_chats"("chatRoomId");

-- CreateIndex
CREATE INDEX "_notifications_notificationId_idx" ON "_notifications"("notificationId");

-- CreateIndex
CREATE INDEX "_notifications_userId_idx" ON "_notifications"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "_devices_deviceToken_key" ON "_devices"("deviceToken");

-- CreateIndex
CREATE INDEX "_devices_deviceId_idx" ON "_devices"("deviceId");

-- CreateIndex
CREATE INDEX "_devices_deviceToken_idx" ON "_devices"("deviceToken");

-- CreateIndex
CREATE INDEX "_devices_userId_idx" ON "_devices"("userId");

-- CreateIndex
CREATE INDEX "_video_conferencies_videoConferenceId_idx" ON "_video_conferencies"("videoConferenceId");

-- CreateIndex
CREATE INDEX "_video_conferencies_hostId_idx" ON "_video_conferencies"("hostId");

-- CreateIndex
CREATE INDEX "_video_conferencies_attendeeId_idx" ON "_video_conferencies"("attendeeId");

-- CreateIndex
CREATE INDEX "_doctors_patients_doctorsPatientId_idx" ON "_doctors_patients"("doctorsPatientId");

-- CreateIndex
CREATE INDEX "_doctors_patients_doctorId_idx" ON "_doctors_patients"("doctorId");

-- CreateIndex
CREATE INDEX "_doctors_patients_patientId_idx" ON "_doctors_patients"("patientId");

-- AddForeignKey
ALTER TABLE "_access_tokens" ADD CONSTRAINT "_access_tokens_userId_fkey" FOREIGN KEY ("userId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_online_statuses" ADD CONSTRAINT "_online_statuses_userId_fkey" FOREIGN KEY ("userId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_appointments" ADD CONSTRAINT "_appointments_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_appointments" ADD CONSTRAINT "_appointments_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_appointment_statuses" ADD CONSTRAINT "_appointment_statuses_appointmentId_fkey" FOREIGN KEY ("appointmentId") REFERENCES "_appointments"("appointmentId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_schedules" ADD CONSTRAINT "_schedules_userId_fkey" FOREIGN KEY ("userId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_schedule_times" ADD CONSTRAINT "_schedule_times_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "_schedules"("scheduleId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_medical_files" ADD CONSTRAINT "_medical_files_userId_fkey" FOREIGN KEY ("userId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_medical_records" ADD CONSTRAINT "_medical_records_userId_fkey" FOREIGN KEY ("userId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_mental_health" ADD CONSTRAINT "_mental_health_userId_fkey" FOREIGN KEY ("userId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_chats" ADD CONSTRAINT "_chats_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_chats" ADD CONSTRAINT "_chats_recipientId_fkey" FOREIGN KEY ("recipientId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_notifications" ADD CONSTRAINT "_notifications_userId_fkey" FOREIGN KEY ("userId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_devices" ADD CONSTRAINT "_devices_userId_fkey" FOREIGN KEY ("userId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_video_conferencies" ADD CONSTRAINT "_video_conferencies_hostId_fkey" FOREIGN KEY ("hostId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_video_conferencies" ADD CONSTRAINT "_video_conferencies_attendeeId_fkey" FOREIGN KEY ("attendeeId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_doctors_patients" ADD CONSTRAINT "_doctors_patients_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_doctors_patients" ADD CONSTRAINT "_doctors_patients_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "_users"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;
