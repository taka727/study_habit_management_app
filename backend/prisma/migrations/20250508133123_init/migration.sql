/*
  Warnings:

  - You are about to drop the column `title` on the `task` table. All the data in the column will be lost.
  - Added the required column `taskDescription` to the `Task` table without a default value. This is not possible if the table is not empty.
  - Added the required column `taskEndTime` to the `Task` table without a default value. This is not possible if the table is not empty.
  - Added the required column `taskStartTime` to the `Task` table without a default value. This is not possible if the table is not empty.
  - Added the required column `taskStatusId` to the `Task` table without a default value. This is not possible if the table is not empty.
  - Added the required column `taskTitle` to the `Task` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Task` table without a default value. This is not possible if the table is not empty.
  - Added the required column `isDeleted` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userAnswer` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userQuestionId` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `task` DROP COLUMN `title`,
    ADD COLUMN `taskDescription` VARCHAR(191) NOT NULL,
    ADD COLUMN `taskEndTime` DATETIME(3) NOT NULL,
    ADD COLUMN `taskStartTime` DATETIME(3) NOT NULL,
    ADD COLUMN `taskStatusId` INTEGER NOT NULL,
    ADD COLUMN `taskTitle` VARCHAR(191) NOT NULL,
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL;

-- AlterTable
ALTER TABLE `user` ADD COLUMN `isDeleted` BOOLEAN NOT NULL,
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL,
    ADD COLUMN `userAnswer` VARCHAR(191) NOT NULL,
    ADD COLUMN `userQuestionId` INTEGER NOT NULL;

-- CreateTable
CREATE TABLE `SecurityQuestion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `content` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Status` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `status_name` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SubTask` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `parentTaskId` INTEGER NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Goal` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `userId` INTEGER NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `goalStartDate` DATETIME(3) NOT NULL,
    `goalEndDate` DATETIME(3) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL,
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_userQuestionId_fkey` FOREIGN KEY (`userQuestionId`) REFERENCES `SecurityQuestion`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Task` ADD CONSTRAINT `Task_taskStatusId_fkey` FOREIGN KEY (`taskStatusId`) REFERENCES `Status`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SubTask` ADD CONSTRAINT `SubTask_parentTaskId_fkey` FOREIGN KEY (`parentTaskId`) REFERENCES `Task`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Goal` ADD CONSTRAINT `Goal_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
