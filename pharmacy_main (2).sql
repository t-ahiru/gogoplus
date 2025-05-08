-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2025 at 11:34 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pharmacy_main`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `data_requests`
--

CREATE TABLE `data_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `pharmacy_id` bigint(20) UNSIGNED NOT NULL,
  `request_type` varchar(255) NOT NULL,
  `details` text DEFAULT NULL,
  `status` enum('pending','approved','rejected','failed','completed') NOT NULL DEFAULT 'pending',
  `response_data` text DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_requests`
--

INSERT INTO `data_requests` (`id`, `pharmacy_id`, `request_type`, `details`, `status`, `response_data`, `file_path`, `created_at`, `updated_at`) VALUES
(1, 2, 'Sales', 'Test', 'approved', '{\"status\":\"success\",\"message\":\"Sales data retrieved successfully\",\"data\":{\"request_type\":\"Sales\",\"pdf_url\":\"https:\\/\\/pharmacy2-api.free.beeceptor.com\\/sales-april-2025.pdf\"}}', NULL, '2025-04-29 02:17:18', '2025-04-29 02:17:21');

-- --------------------------------------------------------

--
-- Table structure for table `data_request_shares`
--

CREATE TABLE `data_request_shares` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `data_request_id` bigint(20) UNSIGNED NOT NULL,
  `shared_by` bigint(20) UNSIGNED NOT NULL,
  `shared_with` bigint(20) UNSIGNED NOT NULL,
  `shared_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0000_12_31_000000_create_roles_table', 1),
(2, '0001_01_01_000000_create_users_table', 1),
(3, '0001_01_01_000001_create_cache_table', 1),
(4, '0001_01_01_000002_create_jobs_table', 1),
(5, '2025_04_03_014118_create_roles_table', 2),
(6, '2025_04_03_034523_add_fields_to_users_table', 2),
(7, ' 2025_04_12_163639_add_description_to_roles_table', 3),
(8, ' 2025_04_12_163639_add_description_to_roles_table', 4),
(9, '2025_04_10_171629_create_pharmacies_table', 5),
(10, '2025_04_12_163639_add_description_to_roles_table', 5),
(11, '2025_04_12_171543_update_pharmacies_table', 6),
(12, '2025_04_13_005918_create_activity_logs_table', 7),
(13, '2025_04_20_232551_update_pharmacies_table_for_api_functionality', 8),
(14, '2025_04_20_234341_create_data_requests_table', 8),
(15, '2025_04_23_001638_create_data_request_shares_table', 8),
(16, '2025_04_23_235306_drop_queue_tables', 8),
(17, '2025_04_24_004803_create_notifications_table', 8),
(18, '2025_04_29_023916_add_file_path_to_data_requests_table', 9),
(19, '2025_04_29_024104_update_status_column_in_data_requests_table', 10);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pharmacies`
--

CREATE TABLE `pharmacies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `license_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `contact_phone` varchar(255) NOT NULL,
  `contact_email` varchar(255) NOT NULL,
  `database_connection` varchar(255) DEFAULT NULL,
  `api_endpoint` varchar(255) DEFAULT NULL,
  `api_key` varchar(255) DEFAULT NULL,
  `api_status` varchar(255) NOT NULL DEFAULT 'unknown',
  `last_api_request_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pharmacies`
--

INSERT INTO `pharmacies` (`id`, `name`, `license_number`, `address`, `location`, `contact_phone`, `contact_email`, `database_connection`, `api_endpoint`, `api_key`, `api_status`, `last_api_request_at`, `created_at`, `updated_at`) VALUES
(1, 'Pharmacy 1', 'LIC001', '123 Main St, City A', 'City A', '123-456-7890', 'pharmacy1@example.com', 'pharmacy1', 'https://pharmacy1-api.free.beeceptor.com/data', 'test-key-1', 'unknown', NULL, '2025-04-12 17:21:19', '2025-04-29 02:16:29'),
(2, 'Pharmacy 2', 'LIC002', '456 Oak St, City B', 'City B', '234-567-8901', 'pharmacy2@example.com', 'pharmacy2', 'https://pharmacy2-api.free.beeceptor.com/data', 'test-key-2', 'active', '2025-04-29 02:17:21', '2025-04-12 17:21:19', '2025-04-29 02:17:21'),
(3, 'Pharmacy 3', 'LIC003', '789 Pine St, City C', 'City C', '345-678-9012', 'pharmacy3@example.com', 'pharmacy3', NULL, NULL, 'unknown', NULL, '2025-04-12 17:21:19', '2025-04-12 17:21:19'),
(4, 'Pharmacy 4', 'LIC004', '101 Maple St, City D', 'City D', '456-789-0123', 'pharmacy4@example.com', 'pharmacy4', 'https://pharmacy4-api.free.beeceptor.com/data', 'test-key-4', 'unknown', NULL, '2025-04-12 17:21:19', '2025-04-29 02:16:29'),
(5, 'Pharmacy 5', 'LIC005', '202 Birch St, City E', 'City E', '567-890-1234', 'pharmacy5@example.com', 'pharmacy5', 'https://pharmacy5-api.free.beeceptor.com/data', 'test-key-5', 'unknown', NULL, '2025-04-12 17:21:19', '2025-04-29 02:16:29');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Admin', NULL, '2025-04-09 02:51:18', '2025-04-09 02:51:18'),
(2, 'User', NULL, '2025-04-09 02:51:22', '2025-04-09 02:51:22'),
(5, 'council_admin', NULL, '2025-04-12 16:27:46', '2025-04-12 16:27:46');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('5ri658QqdOXrgSGlidF5hFyQJxHG04ihPxcGWKZQ', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTWtueWVxWVZGVlBISTN6Z0F1OU94aUtHTjgxTUY5d3RjVGQzWmJFWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hdWRpdC10cmFpbCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1746523111),
('klH64eJT28oTOuRk9nusmzZtHd3BNgxj4a8I8tjI', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiQkdVemZwbVdhdnIySndUUlQ5NlRVUWpTTXVCRllzMUZNdzZHYjVUYSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjU0OiJodHRwOi8vMTI3LjAuMC4xOjgwMDEvZHJ1Z3MvdHJhY2stZXhwaXJ5P3F1ZXJ5PWdlYmVkb2wiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MTk6ImRydWdfc2VhcmNoX2hpc3RvcnkiO2E6Nzp7aTowO3M6MTE6InBhcmFjZXRhbW9sIjtpOjE7czo3OiJnZWJlZG9sIjtpOjI7czozOiJ0cmEiO2k6MztzOjQ6ImdlYmUiO2k6NDtzOjEwOiJDZXRpcml6aW5lIjtpOjU7czozOiJnYXMiO2k6NjtzOjQ6InBhcmEiO319', 1746142325),
('mwff3km8kjxWAWP6YYuRhpnb8KaP4grx8o8tutb3', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicGZLa3R6bDdGMTF0REo5OTRSQUh5bzRhaXFZTlFJUjVhS1hRTGtFNCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozOToiaHR0cDovLzEyNy4wLjAuMTo4MDAwL2RydWdzL3NhbGVzLXRyZW5kIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1746448968),
('uow7E1W3GeNinD3MLQWWCz8fkm8JhpNDtF8ns7jp', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiRlFMM2ExYTJ5SHpOMkloeDFZcElueGpTaXNVUXUxS2tKakNOR2VjSCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM5OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvZHJ1Z3Mvc2FsZXMtdHJlbmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1746321341),
('vXdTbBVTdjlOLx4084SK7ynMdfoibHEMDSc0MTvj', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiSW5NZ3liWVpMRnN2WkNGMzVoS2YyYUxMUkFQT0wwYnRYRk9uT0lDeCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjU4OiJodHRwOi8vMTI3LjAuMC4xOjgwMDEvZHJ1Z3MvdHJhY2stZXhwaXJ5P3F1ZXJ5PXBhcmFjZXRhbW9sIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE5OiJkcnVnX3NlYXJjaF9oaXN0b3J5IjthOjY6e2k6MDtzOjExOiJwYXJhY2V0YW1vbCI7aToxO3M6NDoiZ2ViZSI7aToyO3M6MTM6Imdhc3RyaWMgdWxjZXIiO2k6MztzOjU6InRyYW1hIjtpOjQ7czo4OiJ0cmFtYWRvbCI7aTo1O3M6NDoicGFyYSI7fX0=', 1746126603),
('WHB95fat8VtFLJqRrZ1bRsVBcJVQuyxstoONJVTh', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiZ3RvRkFWUEN6c3J6MHJwV09paHNTcFB4Zk5pWWVsanhkWTVrYXJQNCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9kcnVncy9zYWxlcy10cmVuZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxOToiZHJ1Z19zZWFyY2hfaGlzdG9yeSI7YTo0OntpOjA7czoxMToicGFyYWNldGFtb2wiO2k6MTtzOjE2OiJEWU1PTCBESUNMT0ZFTkFDIjtpOjI7czo0OiJhbnRpIjtpOjM7czo0OiJwYXJhIjt9fQ==', 1746198413);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `pharmacy_id` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `mfa_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `mfa_secret` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `phone`, `role_id`, `pharmacy_id`, `is_active`, `mfa_enabled`, `mfa_secret`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin User', 'admin@example.com', '$2y$12$3i9oQxMaIvFO6t2m9McotuDsJ4L.e1Y9pvSR4J9J6IgWo80KsPQsy', '1234567890', 1, NULL, 1, 0, NULL, 'XNTgiRhngsb4pmbq6tD7bmodo6jFjvD386qJJSlDVNYcBnvfgUA5fbU2iwU9', '2025-04-09 02:51:55', '2025-04-09 02:51:55'),
(2, 'Obed Ninson', 'ninsonobed5630@gmail.com', '$2y$12$BYA8XFnYNNvn1ufEi5A0MeZ/fxzIMEmw2/O5Bqd8PrFr5Mo5mYFMy', '0256422216', 5, NULL, 1, 0, NULL, NULL, '2025-04-12 16:55:53', '2025-04-12 16:55:53'),
(8, 'ama', 'ama@gmail.com', '$2y$12$TdpV3O4cJyl1/CxnIDcclOGMFgN/gUJjD5ObNPHWPaaVd7HPDaYRm', NULL, 2, NULL, 1, 0, NULL, NULL, '2025-04-14 09:34:01', '2025-04-14 09:34:01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activity_logs_user_id_foreign` (`user_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `data_requests`
--
ALTER TABLE `data_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `data_requests_pharmacy_id_foreign` (`pharmacy_id`);

--
-- Indexes for table `data_request_shares`
--
ALTER TABLE `data_request_shares`
  ADD PRIMARY KEY (`id`),
  ADD KEY `data_request_shares_data_request_id_foreign` (`data_request_id`),
  ADD KEY `data_request_shares_shared_by_foreign` (`shared_by`),
  ADD KEY `data_request_shares_shared_with_foreign` (`shared_with`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `pharmacies`
--
ALTER TABLE `pharmacies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pharmacies_license_number_unique` (`license_number`),
  ADD UNIQUE KEY `pharmacies_database_connection_unique` (`database_connection`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_idx` (`user_id`),
  ADD KEY `sessions_last_activity_idx` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_requests`
--
ALTER TABLE `data_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `data_request_shares`
--
ALTER TABLE `data_request_shares`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `pharmacies`
--
ALTER TABLE `pharmacies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `data_requests`
--
ALTER TABLE `data_requests`
  ADD CONSTRAINT `data_requests_pharmacy_id_foreign` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmacies` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `data_request_shares`
--
ALTER TABLE `data_request_shares`
  ADD CONSTRAINT `data_request_shares_data_request_id_foreign` FOREIGN KEY (`data_request_id`) REFERENCES `data_requests` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `data_request_shares_shared_by_foreign` FOREIGN KEY (`shared_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `data_request_shares_shared_with_foreign` FOREIGN KEY (`shared_with`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
