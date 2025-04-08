-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 08, 2025 at 09:26 AM
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
-- Database: `intern`
--
CREATE DATABASE IF NOT EXISTS `intern` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `intern`;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_no` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `initial_balance` double DEFAULT NULL,
  `total_balance` double NOT NULL,
  `note` text DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'Bank Account',
  `parent_account_id` int(11) DEFAULT NULL,
  `is_payment` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `account_no`, `name`, `initial_balance`, `total_balance`, `note`, `is_default`, `is_active`, `created_at`, `updated_at`, `code`, `type`, `parent_account_id`, `is_payment`) VALUES
(1, '019912229', 'Sales Account', 0, 0, 'This is the default account.', 1, 1, '2023-02-05 07:12:15', '2023-02-05 07:12:15', NULL, 'Bank Account', NULL, 1),
(2, '0147852', 'idi', 10000, 10000, NULL, NULL, 1, '2025-03-26 07:58:20', '2025-03-26 07:58:20', NULL, 'Bank Account', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `action_logs`
--

CREATE TABLE `action_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `action_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `route` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `synced_at` timestamp NULL DEFAULT NULL,
  `pharmacy_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `adjustments`
--

CREATE TABLE `adjustments` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `total_qty` double NOT NULL,
  `item` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `employee_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `checkin` varchar(255) NOT NULL,
  `checkout` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `barcodes`
--

CREATE TABLE `barcodes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `width` double(22,4) DEFAULT NULL,
  `height` double(22,4) DEFAULT NULL,
  `paper_width` double(22,4) DEFAULT NULL,
  `paper_height` double(22,4) DEFAULT NULL,
  `top_margin` double(22,4) DEFAULT NULL,
  `left_margin` double(22,4) DEFAULT NULL,
  `row_distance` double(22,4) DEFAULT NULL,
  `col_distance` double(22,4) DEFAULT NULL,
  `stickers_in_one_row` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_continuous` tinyint(1) NOT NULL DEFAULT 0,
  `stickers_in_one_sheet` int(11) DEFAULT NULL,
  `is_custom` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barcodes`
--

INSERT INTO `barcodes` (`id`, `name`, `description`, `width`, `height`, `paper_width`, `paper_height`, `top_margin`, `left_margin`, `row_distance`, `col_distance`, `stickers_in_one_row`, `is_default`, `is_continuous`, `stickers_in_one_sheet`, `is_custom`, `created_at`, `updated_at`) VALUES
(1, '20 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 4\" x 1\", Labels per sheet: 20', 4.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.1250, 0.0000, 0.1875, 2, 0, 0, 20, NULL, NULL, NULL),
(2, '30 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2.625\" x 1\", Labels per sheet: 30', 2.6250, 1.0000, 8.5000, 11.0000, 0.5000, 0.1880, 0.0000, 0.1250, 3, 0, 0, 30, NULL, NULL, NULL),
(3, '32 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1.25\", Labels per sheet: 32', 2.0000, 1.2500, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 32, NULL, NULL, NULL),
(4, '40 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1\", Labels per sheet: 40', 2.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 40, NULL, NULL, NULL),
(5, '50 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 1.5\" x 1\", Labels per sheet: 50', 1.5000, 1.0000, 8.5000, 11.0000, 0.5000, 0.5000, 0.0000, 0.0000, 5, 0, 0, 50, NULL, NULL, NULL),
(6, 'Continuous Rolls - 31.75mm x 25.4mm', 'Label Size: 31.75mm x 25.4mm, Gap: 3.18mm', 1.2500, 1.0000, 1.2500, 0.0000, 0.1250, 0.0000, 0.1250, 0.0000, 1, 0, 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `billers`
--

CREATE TABLE `billers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) NOT NULL,
  `vat_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `billers`
--

INSERT INTO `billers` (`id`, `name`, `image`, `company_name`, `vat_number`, `email`, `phone_number`, `address`, `city`, `state`, `postal_code`, `country`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Biller', NULL, 'Test Company', NULL, 'test@gmail.com', '12312', 'Test address', 'Test City', NULL, NULL, NULL, 1, '2023-05-28 06:53:51', '2023-05-28 06:53:51');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `title`, `image`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Brand', NULL, 1, '2023-05-28 06:51:38', '2023-05-28 06:51:38'),
(2, 'GB Pharma Limited', NULL, 1, '2025-03-25 17:44:43', '2025-03-25 17:44:43'),
(3, 'letap', NULL, 1, '2025-03-25 18:18:26', '2025-03-25 18:18:26');

-- --------------------------------------------------------

--
-- Table structure for table `cash_registers`
--

CREATE TABLE `cash_registers` (
  `id` int(10) UNSIGNED NOT NULL,
  `cash_in_hand` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cash_registers`
--

INSERT INTO `cash_registers` (`id`, `cash_in_hand`, `user_id`, `warehouse_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 0, 1, 1, 1, '2025-03-24 21:08:52', '2025-03-24 21:08:52'),
(2, 100, 2, 1, 1, '2025-03-25 17:31:46', '2025-03-25 17:31:46'),
(3, 12, 3, 1, 1, '2025-03-26 01:01:11', '2025-03-26 01:01:11');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image`, `parent_id`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Category', NULL, NULL, 1, '2023-05-28 06:51:00', '2023-05-28 06:51:00'),
(2, 'pain killer', NULL, NULL, 1, '2025-03-25 17:51:01', '2025-03-25 17:51:01'),
(3, 'ulcer', NULL, NULL, 1, '2025-03-25 18:18:50', '2025-03-25 18:18:50');

-- --------------------------------------------------------

--
-- Table structure for table `challans`
--

CREATE TABLE `challans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `courier_id` int(11) NOT NULL,
  `packing_slip_list` longtext NOT NULL,
  `amount_list` longtext NOT NULL,
  `cash_list` longtext DEFAULT NULL,
  `online_payment_list` longtext DEFAULT NULL,
  `cheque_list` longtext DEFAULT NULL,
  `delivery_charge_list` longtext DEFAULT NULL,
  `status_list` longtext DEFAULT NULL,
  `closing_date` date DEFAULT NULL,
  `created_by_id` int(11) NOT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `minimum_amount` double DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `used` int(11) NOT NULL,
  `expired_date` date NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `couriers`
--

CREATE TABLE `couriers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `couriers`
--

INSERT INTO `couriers` (`id`, `name`, `phone_number`, `address`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'obed', '0550936582', 'dome', 1, '2025-03-25 18:56:49', '2025-03-25 18:56:49'),
(2, 'kofi', '0550934168', 'lapaz', 1, '2025-03-25 18:57:41', '2025-03-25 18:57:41');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `exchange_rate` double NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `code`, `exchange_rate`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'US Dollar', 'USD', 0.06517, 1, '2020-11-01 00:22:58', '2025-02-04 17:17:08'),
(2, 'GHANA CEDI', 'GHS', 1, 1, '2025-02-04 17:17:29', '2025-02-04 17:17:29');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `tax_no` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `points` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deposit` double DEFAULT NULL,
  `expense` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customer_group_id`, `user_id`, `name`, `company_name`, `email`, `phone_number`, `tax_no`, `address`, `city`, `state`, `postal_code`, `country`, `points`, `is_active`, `created_at`, `updated_at`, `deposit`, `expense`) VALUES
(1, 1, NULL, 'John Doe', 'Test Company', 'john@gmail.com', '231312', NULL, 'Test address', 'Test City', NULL, NULL, NULL, NULL, 1, '2023-05-28 06:53:04', '2023-05-28 06:53:04', NULL, NULL),
(2, 1, NULL, 'tahiru', NULL, 'tahiru@gmail.com', '0550936771', NULL, 'anyaa', 'accra', NULL, NULL, NULL, NULL, 1, '2025-03-25 16:59:54', '2025-03-25 16:59:54', NULL, NULL),
(3, 1, NULL, 'obed', NULL, 'oninson45@gmail.com', '0256422216', NULL, NULL, 'Amasaman', NULL, NULL, NULL, NULL, 1, '2025-03-26 01:30:48', '2025-03-26 01:30:48', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_groups`
--

CREATE TABLE `customer_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `percentage` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_groups`
--

INSERT INTO `customer_groups` (`id`, `name`, `percentage`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'General', '0', 1, '2023-05-28 06:51:29', '2023-05-28 06:51:29');

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

CREATE TABLE `custom_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `belongs_to` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `default_value` text DEFAULT NULL,
  `option_value` text DEFAULT NULL,
  `grid_value` int(11) NOT NULL,
  `is_table` tinyint(1) NOT NULL,
  `is_invoice` tinyint(1) NOT NULL,
  `is_required` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_disable` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `packing_slip_ids` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `courier_id` int(11) DEFAULT NULL,
  `address` text NOT NULL,
  `delivered_by` varchar(255) DEFAULT NULL,
  `recieved_by` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`id`, `reference_no`, `sale_id`, `packing_slip_ids`, `user_id`, `courier_id`, `address`, `delivered_by`, `recieved_by`, `file`, `note`, `status`, `created_at`, `updated_at`) VALUES
(1, 'dr-20250325-065125', 2, NULL, 2, 1, 'anyaa accra', NULL, NULL, NULL, NULL, '3', '2025-03-25 18:51:45', '2025-03-25 18:58:26');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` int(10) UNSIGNED NOT NULL,
  `amount` double NOT NULL,
  `customer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `applicable_for` varchar(255) NOT NULL,
  `product_list` longtext DEFAULT NULL,
  `valid_from` date NOT NULL,
  `valid_till` date NOT NULL,
  `type` varchar(255) NOT NULL,
  `value` double NOT NULL,
  `minimum_qty` double NOT NULL,
  `maximum_qty` double NOT NULL,
  `days` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plans`
--

CREATE TABLE `discount_plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plan_customers`
--

CREATE TABLE `discount_plan_customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `discount_plan_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plan_discounts`
--

CREATE TABLE `discount_plan_discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `discount_id` int(11) NOT NULL,
  `discount_plan_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dso_alerts`
--

CREATE TABLE `dso_alerts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_info` longtext NOT NULL,
  `number_of_products` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `department_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `staff_id` varchar(191) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `expense_category_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `reference_no`, `expense_category_id`, `warehouse_id`, `account_id`, `user_id`, `cash_register_id`, `amount`, `note`, `created_at`, `updated_at`) VALUES
(1, 'er-20250325-063857', 1, 1, 1, 2, 2, 100, NULL, '2025-03-25 00:00:00', '2025-03-25 18:38:57');

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `code`, `name`, `is_active`, `created_at`, `updated_at`) VALUES
(1, '74965071', 'transportation', 1, '2025-03-25 18:38:22', '2025-03-25 18:38:22');

-- --------------------------------------------------------

--
-- Table structure for table `external_services`
--

CREATE TABLE `external_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `details` longtext NOT NULL,
  `module_status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`module_status`)),
  `active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `external_services`
--

INSERT INTO `external_services` (`id`, `name`, `type`, `details`, `module_status`, `active`, `created_at`, `updated_at`) VALUES
(1, 'PayPal', 'payment', 'Client ID,Client Secret;abcd1234,wxyz5678', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(2, 'Stripe', 'payment', 'Public Key,Private Key;efgh1234,stuv5678', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(3, 'Razorpay', 'payment', 'Key,Secret;rzp_test_Y4MCcpHfZNU6rR,3Hr7SDqaZ0G5waN0jsLgsiLx', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(4, 'Paystack', 'payment', 'public_Key,Secret_Key;pk_test_e8d220b7463d64569f0053e78534f38e6b10cf4a,sk_test_6d62cb976e1e0ab43f1e48b2934b0dfc7f32a1fe', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(5, 'Mollie', 'payment', 'api_key;test_dHar4XY7LxsDOtmnkVtjNVWXLSlXsM', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(6, 'Xendit', 'payment', 'secret_key,callback_token;xnd_development_aKJVKYbc4lHkEjcCLzWLrBsKs6jF6nbM6WaCMfnJerP3JW57CLis553XNRdDU,YPZxND92Mt8tdXntTYIEkRX802onZ5OcdKBUzycebuqYvN4n', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(7, 'bkash', 'payment', 'Mode,app_key,app_secret,username,password;sandbox,0vWQuCRGiUX7EPVjQDr0EUAYtc,jcUNPBgbcqEDedNKdvE4G1cAK7D3hCjmJccNPZZBq96QIxxwAMEx,01770618567,D7DaC<*E*eG', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(8, 'sslcommerz', 'payment', 'appkey,appsecret;12341234,asdfa23423', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(9, 'Mpesa', 'payment', 'consumer_Key,consumer_Secret;fhfgkj,dtrddhd', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(10, 'Pesapal', 'payment', 'Mode,Consumer Key,Consumer Secret;sandbox,qkio1BGGYAXTu2JOfm7XSXNruoZsrqEW,osGQ364R49cXKeOYSpaOnT++rHs=', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `site_title` varchar(255) NOT NULL,
  `site_logo` varchar(255) DEFAULT NULL,
  `is_rtl` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `currency` varchar(255) NOT NULL,
  `package_id` int(11) DEFAULT NULL,
  `subscription_type` varchar(255) DEFAULT NULL,
  `staff_access` varchar(255) NOT NULL,
  `without_stock` varchar(255) NOT NULL DEFAULT 'no',
  `date_format` varchar(255) NOT NULL,
  `developed_by` varchar(255) DEFAULT NULL,
  `invoice_format` varchar(255) DEFAULT NULL,
  `decimal` int(11) DEFAULT 2,
  `state` int(11) DEFAULT NULL,
  `theme` varchar(255) NOT NULL,
  `modules` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `currency_position` varchar(255) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `expiry_type` varchar(255) NOT NULL DEFAULT 'days',
  `expiry_value` varchar(255) NOT NULL DEFAULT '0',
  `is_zatca` tinyint(1) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `vat_registration_number` varchar(255) DEFAULT NULL,
  `is_packing_slip` tinyint(1) NOT NULL DEFAULT 0,
  `sms_credit` bigint(20) UNSIGNED DEFAULT NULL,
  `pharmacy_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `site_title`, `site_logo`, `is_rtl`, `created_at`, `updated_at`, `currency`, `package_id`, `subscription_type`, `staff_access`, `without_stock`, `date_format`, `developed_by`, `invoice_format`, `decimal`, `state`, `theme`, `modules`, `currency_position`, `expiry_date`, `expiry_type`, `expiry_value`, `is_zatca`, `company_name`, `vat_registration_number`, `is_packing_slip`, `sms_credit`, `pharmacy_id`) VALUES
(1, 'GogoPlus POS', '20250202043823.png', 0, '2018-07-06 06:13:11', '2025-03-24 20:23:33', '1', 3, 'monthly', 'own', 'no', 'd/m/Y', 'GogoPlus Ltd.', 'standard', 2, 1, 'default.css', '', 'prefix', '2025-05-03', 'days', '0', NULL, NULL, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `gift_cards`
--

CREATE TABLE `gift_cards` (
  `id` int(10) UNSIGNED NOT NULL,
  `card_no` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `expense` double NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gift_card_recharges`
--

CREATE TABLE `gift_card_recharges` (
  `id` int(10) UNSIGNED NOT NULL,
  `gift_card_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `note` text DEFAULT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hrm_settings`
--

CREATE TABLE `hrm_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `checkin` varchar(255) NOT NULL,
  `checkout` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `incomes`
--

CREATE TABLE `incomes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `income_category_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `income_categories`
--

CREATE TABLE `income_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `insurance_provider`
--

CREATE TABLE `insurance_provider` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mail_settings`
--

CREATE TABLE `mail_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `driver` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `port` varchar(255) NOT NULL,
  `from_address` varchar(255) NOT NULL,
  `from_name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `encryption` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_02_17_060412_create_categories_table', 1),
(4, '2018_02_20_035727_create_brands_table', 1),
(5, '2018_02_25_100635_create_suppliers_table', 1),
(6, '2018_02_27_101619_create_warehouse_table', 1),
(7, '2018_03_03_040448_create_units_table', 1),
(8, '2018_03_04_041317_create_taxes_table', 1),
(9, '2018_03_10_061915_create_customer_groups_table', 1),
(10, '2018_03_10_090534_create_customers_table', 1),
(11, '2018_03_11_095547_create_billers_table', 1),
(12, '2018_04_05_054401_create_products_table', 1),
(13, '2018_04_06_133606_create_purchases_table', 1),
(14, '2018_04_06_154600_create_product_purchases_table', 1),
(15, '2018_04_06_154915_create_product_warhouse_table', 1),
(16, '2018_04_10_085927_create_sales_table', 1),
(17, '2018_04_10_090133_create_product_sales_table', 1),
(18, '2018_04_10_090254_create_payments_table', 1),
(19, '2018_04_10_090341_create_payment_with_cheque_table', 1),
(20, '2018_04_10_090509_create_payment_with_credit_card_table', 1),
(21, '2018_04_13_121436_create_quotation_table', 1),
(22, '2018_04_13_122324_create_product_quotation_table', 1),
(23, '2018_04_14_121802_create_transfers_table', 1),
(24, '2018_04_14_121913_create_product_transfer_table', 1),
(25, '2018_05_13_082847_add_payment_id_and_change_sale_id_to_payments_table', 1),
(26, '2018_05_13_090906_change_customer_id_to_payment_with_credit_card_table', 1),
(27, '2018_05_20_054532_create_adjustments_table', 1),
(28, '2018_05_20_054859_create_product_adjustments_table', 1),
(29, '2018_05_21_163419_create_returns_table', 1),
(30, '2018_05_21_163443_create_product_returns_table', 1),
(31, '2018_06_02_050905_create_roles_table', 1),
(32, '2018_06_02_073430_add_columns_to_users_table', 1),
(33, '2018_06_03_053738_create_permission_tables', 1),
(34, '2018_06_21_063736_create_pos_setting_table', 1),
(35, '2018_06_21_094155_add_user_id_to_sales_table', 1),
(36, '2018_06_21_101529_add_user_id_to_purchases_table', 1),
(37, '2018_06_21_103512_add_user_id_to_transfers_table', 1),
(38, '2018_06_23_061058_add_user_id_to_quotations_table', 1),
(39, '2018_06_23_082427_add_is_deleted_to_users_table', 1),
(40, '2018_06_25_043308_change_email_to_users_table', 1),
(41, '2018_07_06_115449_create_general_settings_table', 1),
(42, '2018_07_08_043944_create_languages_table', 1),
(43, '2018_07_11_102144_add_user_id_to_returns_table', 1),
(44, '2018_07_11_102334_add_user_id_to_payments_table', 1),
(45, '2018_07_22_130541_add_digital_to_products_table', 1),
(46, '2018_07_24_154250_create_deliveries_table', 1),
(47, '2018_08_16_053336_create_expense_categories_table', 1),
(48, '2018_08_17_115415_create_expenses_table', 1),
(49, '2018_08_18_050418_create_gift_cards_table', 1),
(50, '2018_08_19_063119_create_payment_with_gift_card_table', 1),
(51, '2018_08_25_042333_create_gift_card_recharges_table', 1),
(52, '2018_08_25_101354_add_deposit_expense_to_customers_table', 1),
(53, '2018_08_26_043801_create_deposits_table', 1),
(54, '2018_09_02_044042_add_keybord_active_to_pos_setting_table', 1),
(55, '2018_09_09_092713_create_payment_with_paypal_table', 1),
(56, '2018_09_10_051254_add_currency_to_general_settings_table', 1),
(57, '2018_10_22_084118_add_biller_and_store_id_to_users_table', 1),
(58, '2018_10_26_034927_create_coupons_table', 1),
(59, '2018_10_27_090857_add_coupon_to_sales_table', 1),
(60, '2018_11_07_070155_add_currency_position_to_general_settings_table', 1),
(61, '2018_11_19_094650_add_combo_to_products_table', 1),
(62, '2018_12_09_043712_create_accounts_table', 1),
(63, '2018_12_17_112253_add_is_default_to_accounts_table', 1),
(64, '2018_12_19_103941_add_account_id_to_payments_table', 1),
(65, '2018_12_20_065900_add_account_id_to_expenses_table', 1),
(66, '2018_12_20_082753_add_account_id_to_returns_table', 1),
(67, '2018_12_26_064330_create_return_purchases_table', 1),
(68, '2018_12_26_144708_create_purchase_product_return_table', 1),
(69, '2018_12_27_110018_create_departments_table', 1),
(70, '2018_12_30_054844_create_employees_table', 1),
(71, '2018_12_31_125210_create_payrolls_table', 1),
(72, '2018_12_31_150446_add_department_id_to_employees_table', 1),
(73, '2019_01_01_062708_add_user_id_to_expenses_table', 1),
(74, '2019_01_02_075644_create_hrm_settings_table', 1),
(75, '2019_01_02_090334_create_attendances_table', 1),
(76, '2019_01_27_160956_add_three_columns_to_general_settings_table', 1),
(77, '2019_02_15_183303_create_stock_counts_table', 1),
(78, '2019_02_17_101604_add_is_adjusted_to_stock_counts_table', 1),
(79, '2019_04_13_101707_add_tax_no_to_customers_table', 1),
(80, '2019_08_19_000000_create_failed_jobs_table', 1),
(81, '2019_10_14_111455_create_holidays_table', 1),
(82, '2019_11_13_145619_add_is_variant_to_products_table', 1),
(83, '2019_11_13_150206_create_product_variants_table', 1),
(84, '2019_11_13_153828_create_variants_table', 1),
(85, '2019_11_25_134041_add_qty_to_product_variants_table', 1),
(86, '2019_11_25_134922_add_variant_id_to_product_purchases_table', 1),
(87, '2019_11_25_145341_add_variant_id_to_product_warehouse_table', 1),
(88, '2019_11_29_182201_add_variant_id_to_product_sales_table', 1),
(89, '2019_12_04_121311_add_variant_id_to_product_quotation_table', 1),
(90, '2019_12_05_123802_add_variant_id_to_product_transfer_table', 1),
(91, '2019_12_08_114954_add_variant_id_to_product_returns_table', 1),
(92, '2019_12_08_203146_add_variant_id_to_purchase_product_return_table', 1),
(93, '2020_02_28_103340_create_money_transfers_table', 1),
(94, '2020_07_01_193151_add_image_to_categories_table', 1),
(95, '2020_09_26_130426_add_user_id_to_deliveries_table', 1),
(96, '2020_10_11_125457_create_cash_registers_table', 1),
(97, '2020_10_13_155019_add_cash_register_id_to_sales_table', 1),
(98, '2020_10_13_172624_add_cash_register_id_to_returns_table', 1),
(99, '2020_10_17_212338_add_cash_register_id_to_payments_table', 1),
(100, '2020_10_18_124200_add_cash_register_id_to_expenses_table', 1),
(101, '2020_10_21_121632_add_developed_by_to_general_settings_table', 1),
(102, '2020_10_30_135557_create_notifications_table', 1),
(103, '2020_11_01_044954_create_currencies_table', 1),
(104, '2020_11_01_140736_add_price_to_product_warehouse_table', 1),
(105, '2020_11_02_050633_add_is_diff_price_to_products_table', 1),
(106, '2020_11_09_055222_add_user_id_to_customers_table', 1),
(107, '2020_11_17_054806_add_invoice_format_to_general_settings_table', 1),
(108, '2021_02_10_074859_add_variant_id_to_product_adjustments_table', 1),
(109, '2021_03_07_093606_create_product_batches_table', 1),
(110, '2021_03_07_093759_add_product_batch_id_to_product_warehouse_table', 1),
(111, '2021_03_07_093900_add_product_batch_id_to_product_purchases_table', 1),
(112, '2021_03_11_132603_add_product_batch_id_to_product_sales_table', 1),
(113, '2021_03_25_125421_add_is_batch_to_products_table', 1),
(114, '2021_05_19_120127_add_product_batch_id_to_product_returns_table', 1),
(115, '2021_05_22_105611_add_product_batch_id_to_purchase_product_return_table', 1),
(116, '2021_05_23_124848_add_product_batch_id_to_product_transfer_table', 1),
(117, '2021_05_26_153106_add_product_batch_id_to_product_quotation_table', 1),
(118, '2021_06_08_213007_create_reward_point_settings_table', 1),
(119, '2021_06_16_104155_add_points_to_customers_table', 1),
(120, '2021_06_17_101057_add_used_points_to_payments_table', 1),
(121, '2021_07_06_132716_add_variant_list_to_products_table', 1),
(122, '2021_09_27_161141_add_is_imei_to_products_table', 1),
(123, '2021_09_28_170052_add_imei_number_to_product_warehouse_table', 1),
(124, '2021_09_28_170126_add_imei_number_to_product_purchases_table', 1),
(125, '2021_10_03_170652_add_imei_number_to_product_sales_table', 1),
(126, '2021_10_10_145214_add_imei_number_to_product_returns_table', 1),
(127, '2021_10_11_104504_add_imei_number_to_product_transfer_table', 1),
(128, '2021_10_12_160107_add_imei_number_to_purchase_product_return_table', 1),
(129, '2021_10_12_205146_add_is_rtl_to_general_settings_table', 1),
(130, '2022_01_13_191242_create_discount_plans_table', 1),
(131, '2022_01_14_174318_create_discount_plan_customers_table', 1),
(132, '2022_01_14_202439_create_discounts_table', 1),
(133, '2022_01_16_153506_create_discount_plan_discounts_table', 1),
(134, '2022_02_05_174210_add_order_discount_type_and_value_to_sales_table', 1),
(135, '2022_05_26_195506_add_daily_sale_objective_to_products_table', 1),
(136, '2022_05_28_104209_create_dso_alerts_table', 1),
(137, '2022_06_01_112100_add_is_embeded_to_products_table', 1),
(138, '2022_06_14_130505_add_sale_id_to_returns_table', 1),
(139, '2022_07_19_115504_add_variant_data_to_products_table', 1),
(140, '2022_07_25_194300_add_additional_cost_to_product_variants_table', 1),
(141, '2022_09_04_195610_add_purchase_id_to_return_purchases_table', 1),
(142, '2023_01_18_125040_alter_table_general_settings', 1),
(143, '2023_01_18_133701_alter_table_pos_setting', 1),
(144, '2023_01_25_145309_add_expiry_date_to_general_settings_table', 1),
(145, '2023_02_05_132001_add_change_to_payments_table', 1),
(146, '2023_02_23_125656_alter_table_sales', 1),
(147, '2023_02_26_124100_add_package_id_to_general_settings_table', 1),
(148, '2023_03_04_120325_create_custom_fields_table', 1),
(149, '2023_03_14_174658_add_subscription_type_to_general_setting_table', 1),
(150, '2023_03_22_174352_add_currency_id_and_exchange_rate_to_returns_table', 1),
(151, '2023_03_27_114320_add_currency_id_and_exchange_rate_to_purchases_table', 1),
(152, '2023_03_27_132747_add_currency_id_and_exchange_rate_to_return_purchases_table', 1),
(153, '2023_04_25_150236_create_mail_settings_table', 1),
(154, '2023_05_13_125424_add_zatca_to_general_settings_table', 1),
(155, '2023_05_28_155540_create_tables_table', 1),
(156, '2023_05_29_115039_add_is_table_to_pos_setting_table', 1),
(157, '2023_05_29_115301_add_table_id_to_sales_table', 1),
(158, '2023_05_31_165049_add_queue_no_to_sales_table', 1),
(159, '2023_07_23_160254_create_couriers_table', 1),
(160, '2023_07_23_174343_add_courier_id_to_deliveries_table', 1),
(161, '2023_08_12_124016_add_staff_id_to_employees_table', 1),
(162, '2023_08_14_142608_add_is_active_to_currencies_table', 1),
(163, '2023_08_24_130203_change_columns_to_attendances_table', 1),
(164, '2023_09_10_134503_add_without_stock_to_general_settings_table', 1),
(165, '2023_09_26_211542_add_modules_to_general_settings_table', 1),
(166, '2023_10_15_124306_add_return_qty_to_product_sales_table', 1),
(167, '2023_12_03_235606_crete_external_services_table', 1),
(168, '2024_02_04_131826_add_unit_cost_to_product_adjustments_table', 1),
(169, '2024_02_13_173126_change_modules_to_general_settings_table', 1),
(170, '2024_05_02_114215_add_payment_receiver_to_payments', 1),
(171, '2024_05_06_132553_create_sms_templates_table', 1),
(172, '2024_05_07_102225_add_send_sms_to_pos_setting_table', 1),
(173, '2024_05_07_132625_add_is_default_to_sms_templates_table', 1),
(174, '2024_05_08_112211_change_address_and_city_field_to_nullable_in_customers_table', 1),
(175, '2024_05_08_151050_add_is_default_ecommerce_columne_to_sms_templates_table', 1),
(176, '2024_05_20_182757_add_wholesale_price_to_products_table', 1),
(177, '2024_05_21_170500_add_is_sent_to_transfers_table', 1),
(178, '2024_06_04_225113_create_income_categories_table', 1),
(179, '2024_06_04_225128_create_incomes_table', 1),
(180, '2024_06_29_131917_add_is_packing_slip_to_general_settings_table', 1),
(181, '2024_07_05_192531_create_packing_slips_table', 1),
(182, '2024_07_05_193002_create_packing_slip_products_table', 1),
(183, '2024_07_05_194501_add_is_packing_and_delivered_to_product_sales_table', 1),
(184, '2024_07_14_122245_add_delivery_id_to_packing_slips_table', 1),
(185, '2024_07_14_122415_add_variant_id_to_packing_slip_products_table', 1),
(186, '2024_07_14_122519_add_packing_slip_ids_to_deliveries_table', 1),
(187, '2024_07_16_125908_create_challans_table', 1),
(188, '2024_08_12_112830_add_thermal_invoice_size_to_pos_setting', 1),
(189, '2024_08_14_133351_add_expiry_type_value_to_general_settings', 1),
(190, '2024_09_11_151744_add_return_qty_to_product_purchases_table', 1),
(191, '2024_09_12_162309_create_barcodes_table', 1),
(192, '2024_10_10_121312_add_data_to_payment_with_credit_card_table', 1),
(193, '2024_10_10_212501_alter_attendances_table', 1),
(194, '2024_10_10_213757_alter_attendances_table', 1),
(195, '2024_10_14_144917_change_column_to_nullable_to_payment_with_credit_card_table', 1),
(196, '2024_11_10_121521_add_code_and_type_to_accounts_table', 1),
(197, '2024_11_24_100926_add_module_status_to_external_services_table', 1),
(198, '2025_03_09_000000_create_insurance_provider_table', 1),
(199, '2025_03_09_000001_create_payment_with_insurance_table', 1),
(200, '2025_03_09_000002_create_refills_table', 1),
(201, '2025_03_09_000003_create_refill_items_table', 1),
(202, '2025_03_09_000004_add_columns_to_products_table', 1),
(203, '2025_03_09_000005_add_dosage_to_product_sales_table', 1),
(204, '2025_03_09_000006_create_shelves_table', 1),
(205, '2025_03_12_000007_update_products_table_with_markups_and_units', 1),
(206, '2025_03_24_000000_create_payment_with_mobile_money_table', 1),
(207, '2025_03_24_000001_create_sent_sms_table', 1),
(208, '2025_03_24_000002_add_next_refill_date_to_refill_items_table', 1),
(209, '2025_03_24_000003_add_sms_credit_to_general_settings_table', 1),
(210, '2025_03_24_000004_add_customer_name_and_expiry_to_payment_with_insurance_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `money_transfers`
--

CREATE TABLE `money_transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `from_account_id` int(11) NOT NULL,
  `to_account_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `packing_slips`
--

CREATE TABLE `packing_slips` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `delivery_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `packing_slip_products`
--

CREATE TABLE `packing_slip_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `packing_slip_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `payment_receiver` varchar(255) DEFAULT NULL,
  `payment_reference` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `used_points` double DEFAULT NULL,
  `change` double DEFAULT NULL,
  `paying_method` varchar(255) NOT NULL,
  `payment_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `purchase_id`, `sale_id`, `cash_register_id`, `account_id`, `payment_receiver`, `payment_reference`, `user_id`, `amount`, `used_points`, `change`, `paying_method`, `payment_note`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 2, 1, 'iddrisu', 'spr-20250325-064247', 2, 3.26, NULL, 1.74, 'Cash', NULL, '2025-03-25 18:42:47', '2025-03-25 18:42:47'),
(2, NULL, 2, 2, 1, 'iddrisu', 'spr-20250325-065012', 2, 0, NULL, 2, 'Cash', NULL, '2025-03-25 18:50:12', '2025-03-25 18:50:12'),
(3, NULL, 5, 3, 1, NULL, 'spr-20250326-085920', 3, 8, NULL, 21, 'Cash', NULL, '2025-03-26 08:59:20', '2025-03-26 08:59:20'),
(4, NULL, 6, 1, 1, 'intern', 'spr-20250326-092257', 1, 1.3, NULL, 0, 'Mobile Money', NULL, '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_cheque`
--

CREATE TABLE `payment_with_cheque` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `cheque_no` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_credit_card`
--

CREATE TABLE `payment_with_credit_card` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_stripe_id` varchar(255) DEFAULT NULL,
  `charge_id` varchar(255) NOT NULL,
  `data` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_gift_card`
--

CREATE TABLE `payment_with_gift_card` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `gift_card_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_insurance`
--

CREATE TABLE `payment_with_insurance` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_insurance_id` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  `insurer` varchar(255) NOT NULL,
  `insurance_policy_id` varchar(255) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `approved_amount` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_mobile_money`
--

CREATE TABLE `payment_with_mobile_money` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `network` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_with_mobile_money`
--

INSERT INTO `payment_with_mobile_money` (`id`, `payment_id`, `customer_id`, `phone_number`, `reference`, `network`, `created_at`, `updated_at`) VALUES
(1, 4, 1, '0247118423', '48907553128655', 'MTN', '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_paypal`
--

CREATE TABLE `payment_with_paypal` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payrolls`
--

CREATE TABLE `payrolls` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `paying_method` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(4, 'products-edit', 'web', '2018-06-03 01:00:09', '2018-06-03 01:00:09'),
(5, 'products-delete', 'web', '2018-06-03 22:54:22', '2018-06-03 22:54:22'),
(6, 'products-add', 'web', '2018-06-04 00:34:14', '2018-06-04 00:34:14'),
(7, 'products-index', 'web', '2018-06-04 03:34:27', '2018-06-04 03:34:27'),
(8, 'purchases-index', 'web', '2018-06-04 08:03:19', '2018-06-04 08:03:19'),
(9, 'purchases-add', 'web', '2018-06-04 08:12:25', '2018-06-04 08:12:25'),
(10, 'purchases-edit', 'web', '2018-06-04 09:47:36', '2018-06-04 09:47:36'),
(11, 'purchases-delete', 'web', '2018-06-04 09:47:36', '2018-06-04 09:47:36'),
(12, 'sales-index', 'web', '2018-06-04 10:49:08', '2018-06-04 10:49:08'),
(13, 'sales-add', 'web', '2018-06-04 10:49:52', '2018-06-04 10:49:52'),
(14, 'sales-edit', 'web', '2018-06-04 10:49:52', '2018-06-04 10:49:52'),
(15, 'sales-delete', 'web', '2018-06-04 10:49:53', '2018-06-04 10:49:53'),
(16, 'quotes-index', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(17, 'quotes-add', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(18, 'quotes-edit', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(19, 'quotes-delete', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(20, 'transfers-index', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(21, 'transfers-add', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(22, 'transfers-edit', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(23, 'transfers-delete', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(24, 'returns-index', 'web', '2018-06-04 22:50:24', '2018-06-04 22:50:24'),
(25, 'returns-add', 'web', '2018-06-04 22:50:24', '2018-06-04 22:50:24'),
(26, 'returns-edit', 'web', '2018-06-04 22:50:25', '2018-06-04 22:50:25'),
(27, 'returns-delete', 'web', '2018-06-04 22:50:25', '2018-06-04 22:50:25'),
(28, 'customers-index', 'web', '2018-06-04 23:15:54', '2018-06-04 23:15:54'),
(29, 'customers-add', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(30, 'customers-edit', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(31, 'customers-delete', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(32, 'suppliers-index', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(33, 'suppliers-add', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(34, 'suppliers-edit', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(35, 'suppliers-delete', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(36, 'product-report', 'web', '2018-06-24 23:05:33', '2018-06-24 23:05:33'),
(37, 'purchase-report', 'web', '2018-06-24 23:24:56', '2018-06-24 23:24:56'),
(38, 'sale-report', 'web', '2018-06-24 23:33:13', '2018-06-24 23:33:13'),
(39, 'customer-report', 'web', '2018-06-24 23:36:51', '2018-06-24 23:36:51'),
(40, 'due-report', 'web', '2018-06-24 23:39:52', '2018-06-24 23:39:52'),
(41, 'users-index', 'web', '2018-06-25 00:00:10', '2018-06-25 00:00:10'),
(42, 'users-add', 'web', '2018-06-25 00:00:10', '2018-06-25 00:00:10'),
(43, 'users-edit', 'web', '2018-06-25 00:01:30', '2018-06-25 00:01:30'),
(44, 'users-delete', 'web', '2018-06-25 00:01:30', '2018-06-25 00:01:30'),
(45, 'profit-loss', 'web', '2018-07-14 21:50:05', '2018-07-14 21:50:05'),
(46, 'best-seller', 'web', '2018-07-14 22:01:38', '2018-07-14 22:01:38'),
(47, 'daily-sale', 'web', '2018-07-14 22:24:21', '2018-07-14 22:24:21'),
(48, 'monthly-sale', 'web', '2018-07-14 22:30:41', '2018-07-14 22:30:41'),
(49, 'daily-purchase', 'web', '2018-07-14 22:36:46', '2018-07-14 22:36:46'),
(50, 'monthly-purchase', 'web', '2018-07-14 22:48:17', '2018-07-14 22:48:17'),
(51, 'payment-report', 'web', '2018-07-14 23:10:41', '2018-07-14 23:10:41'),
(52, 'warehouse-stock-report', 'web', '2018-07-14 23:16:55', '2018-07-14 23:16:55'),
(53, 'product-qty-alert', 'web', '2018-07-14 23:33:21', '2018-07-14 23:33:21'),
(54, 'supplier-report', 'web', '2018-07-30 03:00:01', '2018-07-30 03:00:01'),
(55, 'expenses-index', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(56, 'expenses-add', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(57, 'expenses-edit', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(58, 'expenses-delete', 'web', '2018-09-05 01:07:11', '2018-09-05 01:07:11'),
(59, 'general_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(60, 'mail_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(61, 'pos_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(62, 'hrm_setting', 'web', '2019-01-02 10:30:23', '2019-01-02 10:30:23'),
(63, 'purchase-return-index', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(64, 'purchase-return-add', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(65, 'purchase-return-edit', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(66, 'purchase-return-delete', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(67, 'account-index', 'web', '2019-01-02 22:06:13', '2019-01-02 22:06:13'),
(68, 'balance-sheet', 'web', '2019-01-02 22:06:14', '2019-01-02 22:06:14'),
(69, 'account-statement', 'web', '2019-01-02 22:06:14', '2019-01-02 22:06:14'),
(70, 'department', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(71, 'attendance', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(72, 'payroll', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(73, 'employees-index', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(74, 'employees-add', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(75, 'employees-edit', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(76, 'employees-delete', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(77, 'user-report', 'web', '2019-01-16 06:48:18', '2019-01-16 06:48:18'),
(78, 'stock_count', 'web', '2019-02-17 10:32:01', '2019-02-17 10:32:01'),
(79, 'adjustment', 'web', '2019-02-17 10:32:02', '2019-02-17 10:32:02'),
(80, 'sms_setting', 'web', '2019-02-22 05:18:03', '2019-02-22 05:18:03'),
(81, 'create_sms', 'web', '2019-02-22 05:18:03', '2019-02-22 05:18:03'),
(82, 'print_barcode', 'web', '2019-03-07 05:02:19', '2019-03-07 05:02:19'),
(83, 'empty_database', 'web', '2019-03-07 05:02:19', '2019-03-07 05:02:19'),
(84, 'customer_group', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(85, 'unit', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(86, 'tax', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(87, 'gift_card', 'web', '2019-03-07 06:29:38', '2019-03-07 06:29:38'),
(88, 'coupon', 'web', '2019-03-07 06:29:38', '2019-03-07 06:29:38'),
(89, 'holiday', 'web', '2019-10-19 08:57:15', '2019-10-19 08:57:15'),
(90, 'warehouse-report', 'web', '2019-10-22 06:00:23', '2019-10-22 06:00:23'),
(91, 'warehouse', 'web', '2020-02-26 06:47:32', '2020-02-26 06:47:32'),
(92, 'brand', 'web', '2020-02-26 06:59:59', '2020-02-26 06:59:59'),
(93, 'billers-index', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(94, 'billers-add', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(95, 'billers-edit', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(96, 'billers-delete', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(97, 'money-transfer', 'web', '2020-03-02 05:41:48', '2020-03-02 05:41:48'),
(98, 'category', 'web', '2020-07-13 12:13:16', '2020-07-13 12:13:16'),
(99, 'delivery', 'web', '2020-07-13 12:13:16', '2020-07-13 12:13:16'),
(100, 'send_notification', 'web', '2020-10-31 06:21:31', '2020-10-31 06:21:31'),
(101, 'today_sale', 'web', '2020-10-31 06:57:04', '2020-10-31 06:57:04'),
(102, 'today_profit', 'web', '2020-10-31 06:57:04', '2020-10-31 06:57:04'),
(103, 'currency', 'web', '2020-11-09 00:23:11', '2020-11-09 00:23:11'),
(104, 'backup_database', 'web', '2020-11-15 00:16:55', '2020-11-15 00:16:55'),
(105, 'reward_point_setting', 'web', '2021-06-27 04:34:42', '2021-06-27 04:34:42'),
(106, 'revenue_profit_summary', 'web', '2022-02-08 13:57:21', '2022-02-08 13:57:21'),
(107, 'cash_flow', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(108, 'monthly_summary', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(109, 'yearly_report', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(110, 'discount_plan', 'web', '2022-02-16 09:12:26', '2022-02-16 09:12:26'),
(111, 'discount', 'web', '2022-02-16 09:12:38', '2022-02-16 09:12:38'),
(112, 'product-expiry-report', 'web', '2022-03-30 05:39:20', '2022-03-30 05:39:20'),
(113, 'purchase-payment-index', 'web', '2022-06-05 14:12:27', '2022-06-05 14:12:27'),
(114, 'purchase-payment-add', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(115, 'purchase-payment-edit', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(116, 'purchase-payment-delete', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(117, 'sale-payment-index', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(118, 'sale-payment-add', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(119, 'sale-payment-edit', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(120, 'sale-payment-delete', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(121, 'all_notification', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(122, 'sale-report-chart', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(123, 'dso-report', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(124, 'product_history', 'web', '2022-08-25 14:04:05', '2022-08-25 14:04:05'),
(125, 'supplier-due-report', 'web', '2022-08-31 09:46:33', '2022-08-31 09:46:33'),
(126, 'custom_field', 'web', '2023-11-13 06:23:34', '2023-11-13 06:23:34'),
(127, 'incomes-index', 'web', '2024-07-11 13:16:43', '2024-07-11 13:16:43'),
(128, 'incomes-add', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(129, 'incomes-edit', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(130, 'incomes-delete', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(131, 'packing_slip_challan', 'web', '2024-07-22 14:16:17', '2024-07-22 14:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `pos_setting`
--

CREATE TABLE `pos_setting` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `product_number` int(11) NOT NULL,
  `keybord_active` tinyint(1) NOT NULL,
  `is_table` tinyint(1) NOT NULL DEFAULT 0,
  `send_sms` tinyint(1) NOT NULL DEFAULT 0,
  `stripe_public_key` varchar(255) DEFAULT NULL,
  `stripe_secret_key` varchar(255) DEFAULT NULL,
  `paypal_live_api_username` varchar(255) DEFAULT NULL,
  `paypal_live_api_password` varchar(255) DEFAULT NULL,
  `paypal_live_api_secret` varchar(255) DEFAULT NULL,
  `payment_options` text DEFAULT NULL,
  `invoice_option` varchar(10) DEFAULT NULL,
  `thermal_invoice_size` varchar(255) NOT NULL DEFAULT '80',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pos_setting`
--

INSERT INTO `pos_setting` (`id`, `customer_id`, `warehouse_id`, `biller_id`, `product_number`, `keybord_active`, `is_table`, `send_sms`, `stripe_public_key`, `stripe_secret_key`, `paypal_live_api_username`, `paypal_live_api_password`, `paypal_live_api_secret`, `payment_options`, `invoice_option`, `thermal_invoice_size`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 2, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 'cash,card,cheque,gift_card,deposit,mobile_money,credit,insurance', 'thermal', '80', '2023-05-28 06:57:03', '2025-03-24 23:17:23');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `shelf` varchar(50) DEFAULT NULL,
  `max_product` int(11) NOT NULL DEFAULT 50,
  `shelf_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `barcode_symbology` varchar(255) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `retail_units_per_wholesale` double DEFAULT NULL COMMENT 'Number of retail units in one wholesale unit, e.g., 15 bottles per box',
  `cost` double NOT NULL,
  `wholesale_markup` double DEFAULT NULL COMMENT 'Markup percentage for wholesale price',
  `wholesale_price` double DEFAULT NULL COMMENT 'Price per wholesale unit (e.g., box)',
  `retail_markup` double DEFAULT NULL COMMENT 'Markup percentage for retail price',
  `price` double DEFAULT NULL COMMENT 'Price per retail unit (e.g., bottle)',
  `qty` double DEFAULT NULL,
  `alert_quantity` double DEFAULT NULL,
  `daily_sale_objective` double DEFAULT NULL,
  `promotion` tinyint(4) DEFAULT NULL,
  `promotion_price` varchar(255) DEFAULT NULL,
  `starting_date` date DEFAULT NULL,
  `last_date` date DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `tax_method` int(11) DEFAULT NULL,
  `image` longtext DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `is_embeded` tinyint(1) DEFAULT NULL,
  `is_variant` tinyint(1) DEFAULT NULL,
  `is_batch` tinyint(1) DEFAULT NULL,
  `is_diffPrice` tinyint(1) DEFAULT NULL,
  `is_imei` tinyint(1) DEFAULT NULL,
  `featured` tinyint(4) DEFAULT NULL,
  `product_list` varchar(255) DEFAULT NULL,
  `variant_list` varchar(255) DEFAULT NULL,
  `qty_list` varchar(255) DEFAULT NULL,
  `price_list` varchar(255) DEFAULT NULL,
  `product_details` text DEFAULT NULL,
  `variant_option` text DEFAULT NULL,
  `variant_value` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `shelf`, `max_product`, `shelf_id`, `name`, `code`, `type`, `barcode_symbology`, `brand_id`, `category_id`, `unit_id`, `purchase_unit_id`, `sale_unit_id`, `retail_units_per_wholesale`, `cost`, `wholesale_markup`, `wholesale_price`, `retail_markup`, `price`, `qty`, `alert_quantity`, `daily_sale_objective`, `promotion`, `promotion_price`, `starting_date`, `last_date`, `tax_id`, `tax_method`, `image`, `file`, `is_embeded`, `is_variant`, `is_batch`, `is_diffPrice`, `is_imei`, `featured`, `product_list`, `variant_list`, `qty_list`, `price_list`, `product_details`, `variant_option`, `variant_value`, `is_active`, `created_at`, `updated_at`) VALUES
(13, NULL, 50, 1, 'gebedol', '11021', 'standard', 'C128', 2, 2, 9, 9, 21, 12, 100, 10, 9.17, 20, 10, 120, 5, 10, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, 1, NULL, 1, 0, NULL, 1, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-25 17:56:52', '2025-03-25 18:32:06'),
(14, NULL, 50, NULL, 'Gastric Ulcer', '06342634', 'standard', 'C39', 3, 3, 9, 9, 7, 12, 200, 20, 20, 50, 25, 120, 150, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, 0, NULL, 1, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-25 18:21:13', '2025-03-26 09:28:56'),
(15, NULL, 50, NULL, 'Paracetamol', '79813673', 'standard', 'C128', 1, 2, 9, 9, 0, 1, 5, 0.01, 5, -0.01, 5, 56, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-26 08:42:36', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `product_adjustments`
--

CREATE TABLE `product_adjustments` (
  `id` int(10) UNSIGNED NOT NULL,
  `adjustment_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `unit_cost` double DEFAULT NULL,
  `qty` double NOT NULL,
  `action` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_batches`
--

CREATE TABLE `product_batches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `batch_no` varchar(255) NOT NULL,
  `expired_date` date NOT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_batches`
--

INSERT INTO `product_batches` (`id`, `product_id`, `batch_no`, `expired_date`, `qty`, `created_at`, `updated_at`) VALUES
(1, 14, '25-03-2025', '2026-03-25', 108, '2025-03-25 18:32:06', '2025-03-26 09:28:56'),
(2, 13, '25-03-2025', '2027-03-25', 120, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(3, 15, '7890', '2026-10-21', 56, '2025-03-26 08:49:20', '2025-03-26 09:22:57'),
(4, 14, '8097', '2025-03-28', 12, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_purchases`
--

CREATE TABLE `product_purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `recieved` double NOT NULL,
  `return_qty` double NOT NULL DEFAULT 0,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_purchases`
--

INSERT INTO `product_purchases` (`id`, `purchase_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `recieved`, `return_qty`, `purchase_unit_id`, `net_unit_cost`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL, NULL, 10, 10, 0, 1, 10, 0, 10, 10, 110, '2023-05-28 06:59:29', '2023-05-28 06:59:29'),
(2, 2, 14, 1, NULL, NULL, 10, 10, 0, 9, 200, 0, 0, 0, 2000, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(3, 2, 13, 2, NULL, NULL, 10, 10, 0, 9, 100, 0, 0, 0, 1000, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(4, 3, 15, 3, NULL, NULL, 60, 60, 0, 9, 5, 0, 10, 30, 330, '2025-03-26 08:49:20', '2025-03-26 08:49:20'),
(5, 4, 14, 4, NULL, NULL, 1, 1, 0, 9, 200, 0, 0, 0, 200, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_quotation`
--

CREATE TABLE `product_quotation` (
  `id` int(10) UNSIGNED NOT NULL,
  `quotation_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_returns`
--

CREATE TABLE `product_returns` (
  `id` int(10) UNSIGNED NOT NULL,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_returns`
--

INSERT INTO `product_returns` (`id`, `return_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `sale_unit_id`, `net_unit_price`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 14, 1, NULL, NULL, 1, 9, 1.63, 0, 0, 0, 1.63, '2025-03-26 09:28:56', '2025-03-26 09:28:56');

-- --------------------------------------------------------

--
-- Table structure for table `product_sales`
--

CREATE TABLE `product_sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `dosage` text NOT NULL,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `return_qty` double NOT NULL DEFAULT 0,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_delivered` tinyint(1) DEFAULT NULL,
  `is_packing` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_sales`
--

INSERT INTO `product_sales` (`id`, `dosage`, `sale_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `return_qty`, `sale_unit_id`, `net_unit_price`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`, `is_delivered`, `is_packing`) VALUES
(1, '', 1, 14, 1, NULL, 'null', 2, 1, 9, 1.63, 0, 0, 0, 3.26, '2025-03-25 18:42:47', '2025-03-26 09:28:56', NULL, NULL),
(2, '', 2, 14, 1, NULL, 'null', 1, 0, 9, 1.63, 0, 0, 0, 1.63, '2025-03-25 18:48:59', '2025-03-25 18:51:03', NULL, NULL),
(3, '', 3, 14, 1, NULL, 'null', 3, 0, 9, 1.63, 0, 0, 0, 4.89, '2025-03-26 02:29:39', '2025-03-26 02:29:39', NULL, NULL),
(4, '', 4, 14, 1, NULL, 'null', 80, 0, 9, 25, 0, 0, 0, 2000, '2025-03-26 08:51:58', '2025-03-26 08:51:58', NULL, NULL),
(5, '', 5, 14, 1, NULL, 'null', 10, 0, 9, 1.63, 0, 0, 0, 16.29, '2025-03-26 08:59:20', '2025-03-26 08:59:20', NULL, NULL),
(6, 'once daily', 6, 15, 3, NULL, 'null,null', 4, 0, 9, 0.33, 0, 0, 0, 1.3, '2025-03-26 09:22:57', '2025-03-26 09:22:57', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_transfer`
--

CREATE TABLE `product_transfer` (
  `id` int(10) UNSIGNED NOT NULL,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `item_code` varchar(255) NOT NULL,
  `additional_cost` double DEFAULT NULL,
  `additional_price` double DEFAULT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_warehouse`
--

CREATE TABLE `product_warehouse` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `qty` double NOT NULL,
  `price` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_warehouse`
--

INSERT INTO `product_warehouse` (`id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `warehouse_id`, `qty`, `price`, `created_at`, `updated_at`) VALUES
(1, '1', NULL, NULL, NULL, 1, 10, 20, '2023-05-28 06:59:29', '2023-05-28 07:00:57'),
(2, '14', 1, NULL, NULL, 1, 108, NULL, '2025-03-25 18:32:06', '2025-03-26 09:28:56'),
(3, '13', 2, NULL, NULL, 1, 120, NULL, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(4, '15', 3, NULL, NULL, 1, 56, NULL, '2025-03-26 08:49:20', '2025-03-26 09:22:57'),
(5, '14', 4, NULL, NULL, 1, 12, NULL, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` int(11) NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `paid_amount` double NOT NULL,
  `status` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `reference_no`, `user_id`, `warehouse_id`, `supplier_id`, `currency_id`, `exchange_rate`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_cost`, `order_tax_rate`, `order_tax`, `order_discount`, `shipping_cost`, `grand_total`, `paid_amount`, `status`, `payment_status`, `document`, `note`, `created_at`, `updated_at`) VALUES
(1, 'pr-20230528-125929', 1, 1, NULL, 1, 1, 1, 10, 0, 10, 110, 0, 0, 0, 0, 110, 0, 1, 1, NULL, NULL, '2023-05-28 06:59:29', '2023-05-28 06:59:29'),
(2, '1234', 2, 1, 1, 1, 0.06517, 2, 20, 0, 0, 3000, 10, 300, 0, 0, 3300, 0, 1, 1, NULL, NULL, '2025-03-25 00:00:00', '2025-03-25 18:32:06'),
(3, '56789', 3, 1, 1, 2, 100, 1, 60, 0, 30, 330, 10, 33, 0, 0, 363, 0, 1, 1, NULL, NULL, '2025-03-29 00:00:00', '2025-03-26 08:49:20'),
(4, '8789t9037', 1, 1, 1, 2, 1, 1, 1, 0, 0, 200, 0, 0, 0, 0, 200, 0, 1, 1, NULL, NULL, '2025-03-26 00:00:00', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_product_return`
--

CREATE TABLE `purchase_product_return` (
  `id` int(10) UNSIGNED NOT NULL,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

CREATE TABLE `quotations` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `quotation_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `refills`
--

CREATE TABLE `refills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `refill_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `warehouse_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refills`
--

INSERT INTO `refills` (`id`, `customer_id`, `created_at`, `refill_note`, `staff_note`, `updated_at`, `warehouse_id`) VALUES
(1, 3, '2025-03-26 01:37:34', NULL, NULL, '2025-03-26 01:37:34', 1);

-- --------------------------------------------------------

--
-- Table structure for table `refill_items`
--

CREATE TABLE `refill_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `refill_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `refill_interval` int(11) NOT NULL,
  `refill_unit` enum('days','weeks','months') NOT NULL,
  `refill_until` date NOT NULL,
  `next_refill_date` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refill_items`
--

INSERT INTO `refill_items` (`id`, `refill_id`, `product_id`, `quantity`, `refill_interval`, `refill_unit`, `refill_until`, `next_refill_date`, `created_at`, `updated_at`) VALUES
(1, 1, 14, 1, 2, 'months', '2025-04-06', NULL, '2025-03-26 01:37:34', '2025-03-26 01:37:34');

-- --------------------------------------------------------

--
-- Table structure for table `returns`
--

CREATE TABLE `returns` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `return_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `returns`
--

INSERT INTO `returns` (`id`, `reference_no`, `user_id`, `sale_id`, `cash_register_id`, `customer_id`, `warehouse_id`, `biller_id`, `account_id`, `currency_id`, `exchange_rate`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_price`, `order_tax_rate`, `order_tax`, `grand_total`, `document`, `return_note`, `staff_note`, `created_at`, `updated_at`) VALUES
(1, 'rr-20250326-092856', 1, 1, 1, 2, 1, 1, 1, 1, 0.06517, 1, 1, 0, 0, 1.63, 0, 0, 1.63, NULL, NULL, NULL, '2025-03-26 09:28:56', '2025-03-26 09:28:56');

-- --------------------------------------------------------

--
-- Table structure for table `return_purchases`
--

CREATE TABLE `return_purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `return_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reward_point_settings`
--

CREATE TABLE `reward_point_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `per_point_amount` double NOT NULL,
  `minimum_amount` double NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `guard_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `is_active`, `created_at`, `updated_at`, `guard_name`) VALUES
(1, 'Admin', 'Pharmacy administrator', 1, '2018-06-01 23:46:44', '2025-02-18 10:13:19', 'web'),
(2, 'Super Admin', 'GogoPlus Technical Support', 1, '2018-10-22 02:38:13', '2025-02-18 10:49:13', 'web'),
(5, 'Staff', 'Pharmacy Staff', 0, '2020-11-05 06:43:16', '2025-02-18 10:50:13', 'web'),
(7, 'Pharmacist', 'Pharnacist', 1, '2025-02-18 12:00:10', '2025-02-18 12:00:10', 'web');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(4, 1),
(4, 2),
(4, 5),
(4, 7),
(5, 1),
(5, 2),
(5, 5),
(5, 7),
(6, 1),
(6, 2),
(6, 5),
(6, 7),
(7, 1),
(7, 2),
(7, 5),
(7, 7),
(8, 1),
(8, 2),
(8, 5),
(8, 7),
(9, 1),
(9, 2),
(9, 5),
(9, 7),
(10, 1),
(10, 2),
(10, 5),
(10, 7),
(11, 1),
(11, 2),
(12, 1),
(12, 2),
(12, 5),
(12, 7),
(13, 1),
(13, 2),
(13, 5),
(13, 7),
(14, 1),
(14, 2),
(14, 5),
(15, 1),
(15, 2),
(16, 1),
(16, 2),
(16, 5),
(16, 7),
(17, 1),
(17, 2),
(17, 5),
(17, 7),
(18, 1),
(18, 2),
(18, 5),
(18, 7),
(19, 1),
(19, 2),
(20, 1),
(20, 2),
(20, 5),
(20, 7),
(21, 1),
(21, 2),
(21, 5),
(21, 7),
(22, 1),
(22, 2),
(22, 5),
(22, 7),
(23, 1),
(23, 2),
(24, 1),
(24, 2),
(24, 5),
(24, 7),
(25, 1),
(25, 2),
(25, 5),
(25, 7),
(26, 1),
(26, 2),
(26, 5),
(26, 7),
(27, 1),
(27, 2),
(28, 1),
(28, 2),
(28, 5),
(28, 7),
(29, 1),
(29, 2),
(29, 5),
(29, 7),
(30, 1),
(30, 2),
(30, 5),
(30, 7),
(31, 1),
(31, 2),
(32, 1),
(32, 2),
(32, 5),
(33, 1),
(33, 2),
(33, 5),
(34, 1),
(34, 2),
(34, 5),
(35, 1),
(35, 2),
(35, 5),
(36, 1),
(36, 2),
(36, 5),
(36, 7),
(37, 1),
(37, 2),
(37, 5),
(37, 7),
(38, 1),
(38, 2),
(38, 5),
(38, 7),
(39, 1),
(39, 2),
(39, 5),
(39, 7),
(40, 1),
(40, 2),
(40, 5),
(40, 7),
(41, 1),
(41, 2),
(41, 5),
(41, 7),
(42, 1),
(42, 2),
(42, 7),
(43, 1),
(43, 2),
(43, 7),
(44, 1),
(44, 2),
(45, 1),
(45, 2),
(45, 5),
(45, 7),
(46, 1),
(46, 2),
(46, 5),
(46, 7),
(47, 1),
(47, 2),
(47, 5),
(47, 7),
(48, 1),
(48, 2),
(48, 5),
(48, 7),
(49, 1),
(49, 2),
(49, 5),
(49, 7),
(50, 1),
(50, 2),
(50, 5),
(50, 7),
(51, 1),
(51, 2),
(51, 5),
(51, 7),
(52, 1),
(52, 2),
(52, 5),
(52, 7),
(53, 1),
(53, 2),
(53, 5),
(53, 7),
(54, 1),
(54, 2),
(54, 5),
(55, 1),
(55, 2),
(55, 5),
(55, 7),
(56, 1),
(56, 2),
(56, 5),
(56, 7),
(57, 1),
(57, 2),
(57, 5),
(57, 7),
(58, 1),
(58, 2),
(59, 2),
(59, 5),
(60, 2),
(61, 2),
(62, 1),
(62, 2),
(63, 1),
(63, 2),
(63, 5),
(63, 7),
(64, 1),
(64, 2),
(64, 5),
(64, 7),
(65, 1),
(65, 2),
(65, 5),
(65, 7),
(66, 1),
(66, 2),
(67, 1),
(67, 2),
(67, 5),
(68, 1),
(68, 2),
(69, 1),
(69, 2),
(69, 5),
(70, 1),
(70, 2),
(71, 1),
(71, 2),
(72, 1),
(72, 2),
(73, 1),
(73, 2),
(73, 5),
(74, 1),
(74, 2),
(75, 1),
(75, 2),
(76, 1),
(76, 2),
(77, 1),
(77, 2),
(77, 7),
(78, 1),
(78, 2),
(78, 5),
(78, 7),
(79, 1),
(79, 2),
(79, 5),
(79, 7),
(80, 2),
(81, 1),
(81, 2),
(81, 5),
(81, 7),
(82, 1),
(82, 2),
(83, 2),
(84, 1),
(84, 2),
(84, 5),
(84, 7),
(85, 1),
(85, 2),
(85, 5),
(85, 7),
(86, 1),
(86, 2),
(86, 5),
(87, 1),
(87, 2),
(87, 5),
(87, 7),
(88, 1),
(88, 2),
(88, 5),
(88, 7),
(89, 1),
(89, 2),
(90, 1),
(90, 2),
(90, 5),
(90, 7),
(91, 1),
(91, 2),
(92, 1),
(92, 2),
(92, 5),
(92, 7),
(93, 1),
(93, 2),
(93, 5),
(94, 1),
(94, 2),
(95, 1),
(95, 2),
(96, 1),
(96, 2),
(97, 1),
(97, 2),
(98, 1),
(98, 2),
(98, 5),
(98, 7),
(99, 1),
(99, 2),
(99, 5),
(99, 7),
(100, 1),
(100, 2),
(100, 5),
(100, 7),
(101, 1),
(101, 2),
(101, 5),
(101, 7),
(102, 1),
(102, 2),
(102, 5),
(102, 7),
(103, 1),
(103, 2),
(103, 5),
(103, 7),
(104, 2),
(105, 1),
(105, 2),
(105, 7),
(106, 1),
(106, 2),
(106, 5),
(106, 7),
(107, 1),
(107, 2),
(107, 5),
(107, 7),
(108, 1),
(108, 2),
(108, 5),
(108, 7),
(109, 1),
(109, 2),
(109, 5),
(109, 7),
(110, 1),
(110, 2),
(110, 5),
(110, 7),
(111, 1),
(111, 2),
(111, 5),
(111, 7),
(112, 1),
(112, 2),
(112, 5),
(112, 7),
(113, 1),
(113, 2),
(113, 5),
(113, 7),
(114, 1),
(114, 2),
(114, 5),
(114, 7),
(115, 1),
(115, 2),
(115, 5),
(115, 7),
(116, 1),
(116, 2),
(117, 1),
(117, 2),
(117, 5),
(117, 7),
(118, 1),
(118, 2),
(118, 5),
(118, 7),
(119, 1),
(119, 2),
(119, 5),
(120, 1),
(120, 2),
(121, 1),
(121, 2),
(121, 5),
(121, 7),
(122, 1),
(122, 2),
(122, 5),
(122, 7),
(123, 1),
(123, 2),
(123, 5),
(123, 7),
(124, 1),
(124, 2),
(124, 5),
(124, 7),
(125, 1),
(125, 2),
(125, 5),
(126, 2),
(126, 7),
(127, 1),
(127, 2),
(127, 5),
(128, 1),
(128, 2),
(128, 5),
(129, 1),
(129, 2),
(129, 5),
(130, 1),
(130, 2),
(131, 2),
(132, 1),
(132, 2),
(132, 5);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `queue` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `grand_total` double NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount_type` varchar(255) DEFAULT NULL,
  `order_discount_value` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `coupon_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `sale_status` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `sale_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `reference_no`, `user_id`, `cash_register_id`, `table_id`, `queue`, `customer_id`, `warehouse_id`, `biller_id`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_price`, `grand_total`, `currency_id`, `exchange_rate`, `order_tax_rate`, `order_tax`, `order_discount_type`, `order_discount_value`, `order_discount`, `coupon_id`, `coupon_discount`, `shipping_cost`, `sale_status`, `payment_status`, `document`, `paid_amount`, `sale_note`, `staff_note`, `created_at`, `updated_at`) VALUES
(1, 'posr-20250325-064247', 2, 2, NULL, NULL, 2, 1, 1, 1, 2, 0, 0, 3.26, 3.26, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 4, 4, NULL, 3.26, NULL, NULL, '2025-03-25 18:42:47', '2025-03-26 09:28:56'),
(2, '1234', 2, 2, NULL, NULL, 2, 1, 1, 1, 1, 0, 0, 1.63, 1.63, 1, 0.06517, 0, 0, 'Flat', 0, 0, NULL, NULL, 0, 1, 2, NULL, 0, NULL, NULL, '2025-03-25 18:51:03', '2025-03-25 18:51:03'),
(3, 'posr-20250326-022939', 3, 3, NULL, NULL, 1, 1, 1, 1, 3, 0, 0, 4.89, 4.89, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 3, 2, NULL, 0, NULL, NULL, '2025-03-26 02:29:39', '2025-03-26 02:29:39'),
(4, '67879', 3, 3, NULL, NULL, 3, 1, 1, 1, 80, 0, 0, 2000, 2000, 2, 100, 0, 0, 'Flat', NULL, 0, NULL, NULL, 0, 2, 1, NULL, 0, NULL, NULL, '2025-04-02 08:51:58', '2025-03-26 08:51:58'),
(5, '89089', 3, 3, NULL, NULL, 3, 1, 1, 1, 10, 0, 0, 16.29, 16.29, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, NULL, 0, 1, 3, NULL, 8, NULL, NULL, '2025-04-02 08:59:20', '2025-03-26 08:59:20'),
(6, 'posr-20250326-092257', 1, 1, NULL, NULL, 1, 1, 1, 1, 4, 0, 0, 1.3, 1.3, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 1, 4, NULL, 1.3, NULL, NULL, '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `sent_sms`
--

CREATE TABLE `sent_sms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'sent',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shelves`
--

CREATE TABLE `shelves` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shelves`
--

INSERT INTO `shelves` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'general', '2025-03-25 17:59:32', '2025-03-25 17:59:32'),
(3, 'stomach', '2025-03-25 18:21:57', '2025-03-25 18:21:57');

-- --------------------------------------------------------

--
-- Table structure for table `sms_templates`
--

CREATE TABLE `sms_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_default_ecommerce` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_counts`
--

CREATE TABLE `stock_counts` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `category_id` varchar(255) DEFAULT NULL,
  `brand_id` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `initial_file` varchar(255) DEFAULT NULL,
  `final_file` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_adjusted` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) NOT NULL,
  `vat_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `image`, `company_name`, `vat_number`, `email`, `phone_number`, `address`, `city`, `state`, `postal_code`, `country`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'John Doe', NULL, 'Test Company', NULL, 'john@gmail.com', '231312', 'Test address', 'Test City', NULL, NULL, NULL, 1, '2023-05-28 06:53:04', '2023-05-28 06:53:04');

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `number_of_person` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `name`, `rate`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'VAT 10%', 10, 1, '2023-05-28 06:52:08', '2023-05-28 06:52:08');

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `from_warehouse_id` int(11) NOT NULL,
  `to_warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_sent` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(10) UNSIGNED NOT NULL,
  `unit_code` varchar(255) NOT NULL,
  `unit_name` varchar(255) NOT NULL,
  `base_unit` int(11) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `operation_value` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_code`, `unit_name`, `base_unit`, `operator`, `operation_value`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'PIECE', 'PIECE', NULL, '*', 1, 1, '2023-05-28 06:51:50', '2025-02-04 17:06:26'),
(2, 'AMPOULE', 'AMPOULE', NULL, '*', 1, 1, '2025-02-04 17:07:04', '2025-02-04 17:07:04'),
(3, 'SACHET', 'SACHET', NULL, '*', 1, 1, '2025-02-04 17:07:20', '2025-02-04 17:07:20'),
(4, 'TAB', 'TAB', NULL, '*', 1, 1, '2025-02-04 17:07:31', '2025-02-04 17:07:31'),
(5, 'TUBE', 'TUBE', NULL, '*', 1, 1, '2025-02-04 17:07:42', '2025-02-04 17:07:42'),
(6, 'VIAL', 'VIAL', NULL, '*', 1, 1, '2025-02-04 17:07:56', '2025-02-04 17:07:56'),
(7, 'BOTTLE', 'BOTTLE', NULL, '*', 1, 1, '2025-02-04 17:08:09', '2025-02-04 17:08:09'),
(8, 'CAP', 'CAP', NULL, '*', 1, 1, '2025-02-04 17:08:24', '2025-02-04 17:08:24'),
(9, 'BOX', 'BOX', NULL, '*', 1, 1, '2025-02-04 17:08:35', '2025-02-04 17:08:35'),
(10, 'JAR', 'JAR', NULL, '*', 1, 1, '2025-02-04 17:08:46', '2025-02-04 17:08:46'),
(11, 'DROP', 'DROP', NULL, '*', 1, 1, '2025-02-04 17:08:57', '2025-02-04 17:08:57'),
(12, 'SINGLE', 'SINGLE', NULL, '*', 1, 1, '2025-02-04 17:09:10', '2025-02-04 17:09:10'),
(13, 'CAN', 'CAN', NULL, '*', 1, 1, '2025-02-04 17:09:21', '2025-02-04 17:09:21'),
(14, 'SUPP', 'SUPP', NULL, '*', 1, 1, '2025-02-04 17:09:35', '2025-02-04 17:09:35'),
(15, 'STRIP', 'STRIP', NULL, '*', 1, 1, '2025-02-04 17:09:52', '2025-02-04 17:09:52'),
(16, 'PESS', 'PESS', NULL, '*', 1, 1, '2025-02-04 17:10:04', '2025-02-04 17:10:04'),
(17, 'LOZENGES', 'LOZENGES', NULL, '*', 1, 1, '2025-02-04 17:10:24', '2025-02-04 17:10:24'),
(18, 'POUCH', 'POUCH', NULL, '*', 1, 1, '2025-02-04 17:10:39', '2025-02-04 17:10:39'),
(19, 'BAG', 'BAG', NULL, '*', 1, 1, '2025-02-04 17:10:49', '2025-02-04 17:10:49'),
(20, 'No Unit', 'No Unit', NULL, '*', 1, 1, '2025-02-04 17:11:30', '2025-02-04 17:11:30'),
(21, 'PACK', 'PACK', NULL, '*', 1, 1, '2025-02-04 17:15:31', '2025-02-04 17:15:31');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `phone`, `company_name`, `role_id`, `biller_id`, `warehouse_id`, `is_active`, `is_deleted`) VALUES
(1, 'intern', 'giftybuah@gmail.com', '$2y$10$gtlKmhPKO0iLrXVyhcTaQ.DlEgDX66LqhS0slYrNBpsqIOV6ZwATC', 'pEN60GwtkCZFKVT6tvmmCiYvHqvDX4znpKTdgDca9wxdfVmtbxRixIxH0RzJ', '2018-06-02 03:24:15', '2025-03-24 23:20:25', '0247118423', 'Intern Pharmacy', 2, NULL, NULL, 1, 0),
(2, 'iddrisu', 'iddrisu442g@gmail.com', '$2y$10$WwNSDcjyJzDoEFFC1s2MTuGx5UrmgBhj7iwNceFJqOTA6IgAB7QUe', NULL, '2025-03-24 20:36:04', '2025-03-24 23:15:12', '0550936771', 'Intern Pharmacy', 1, NULL, NULL, 1, 0),
(3, 'obed', 'ninsonobed5630@gmail.com', '$2y$10$vPfQAb2/onfHCkKOJzzbtOU1TtzRKEjldvuEzdgZPsGQZEPavXfGC', NULL, '2025-03-24 20:39:36', '2025-03-24 23:16:16', '0256422216', 'Intern Pharmacy', 1, NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `variants`
--

CREATE TABLE `variants` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `name`, `phone`, `email`, `address`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Shop', '9991111', NULL, 'Test address', 1, '2023-05-28 06:51:19', '2023-05-28 06:51:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `action_logs`
--
ALTER TABLE `action_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `action_id` (`action_id`);

--
-- Indexes for table `adjustments`
--
ALTER TABLE `adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `barcodes`
--
ALTER TABLE `barcodes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billers`
--
ALTER TABLE `billers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cash_registers`
--
ALTER TABLE `cash_registers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `challans`
--
ALTER TABLE `challans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `couriers`
--
ALTER TABLE `couriers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_groups`
--
ALTER TABLE `customer_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_fields`
--
ALTER TABLE `custom_fields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plans`
--
ALTER TABLE `discount_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plan_customers`
--
ALTER TABLE `discount_plan_customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plan_discounts`
--
ALTER TABLE `discount_plan_discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dso_alerts`
--
ALTER TABLE `dso_alerts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `external_services`
--
ALTER TABLE `external_services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gift_cards`
--
ALTER TABLE `gift_cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gift_card_recharges`
--
ALTER TABLE `gift_card_recharges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hrm_settings`
--
ALTER TABLE `hrm_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `incomes`
--
ALTER TABLE `incomes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `income_categories`
--
ALTER TABLE `income_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `insurance_provider`
--
ALTER TABLE `insurance_provider`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mail_settings`
--
ALTER TABLE `mail_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `money_transfers`
--
ALTER TABLE `money_transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `packing_slips`
--
ALTER TABLE `packing_slips`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packing_slip_products`
--
ALTER TABLE `packing_slip_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_cheque`
--
ALTER TABLE `payment_with_cheque`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_credit_card`
--
ALTER TABLE `payment_with_credit_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_gift_card`
--
ALTER TABLE `payment_with_gift_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_insurance`
--
ALTER TABLE `payment_with_insurance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_mobile_money`
--
ALTER TABLE `payment_with_mobile_money`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_paypal`
--
ALTER TABLE `payment_with_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payrolls`
--
ALTER TABLE `payrolls`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pos_setting`
--
ALTER TABLE `pos_setting`
  ADD UNIQUE KEY `pos_setting_id_unique` (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_batches`
--
ALTER TABLE `product_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_purchases`
--
ALTER TABLE `product_purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_quotation`
--
ALTER TABLE `product_quotation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_returns`
--
ALTER TABLE `product_returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_sales`
--
ALTER TABLE `product_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_transfer`
--
ALTER TABLE `product_transfer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_product_return`
--
ALTER TABLE `purchase_product_return`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quotations`
--
ALTER TABLE `quotations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refills`
--
ALTER TABLE `refills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refill_items`
--
ALTER TABLE `refill_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `refill_items_next_refill_date_index` (`next_refill_date`);

--
-- Indexes for table `returns`
--
ALTER TABLE `returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `return_purchases`
--
ALTER TABLE `return_purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reward_point_settings`
--
ALTER TABLE `reward_point_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sent_sms`
--
ALTER TABLE `sent_sms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sent_sms_customer_id_index` (`customer_id`),
  ADD KEY `sent_sms_phone_number_index` (`phone_number`);

--
-- Indexes for table `shelves`
--
ALTER TABLE `shelves`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shelves_name_index` (`name`);

--
-- Indexes for table `sms_templates`
--
ALTER TABLE `sms_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_counts`
--
ALTER TABLE `stock_counts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `variants`
--
ALTER TABLE `variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `action_logs`
--
ALTER TABLE `action_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `adjustments`
--
ALTER TABLE `adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `barcodes`
--
ALTER TABLE `barcodes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `billers`
--
ALTER TABLE `billers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cash_registers`
--
ALTER TABLE `cash_registers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `challans`
--
ALTER TABLE `challans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `couriers`
--
ALTER TABLE `couriers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customer_groups`
--
ALTER TABLE `customer_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `custom_fields`
--
ALTER TABLE `custom_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plans`
--
ALTER TABLE `discount_plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plan_customers`
--
ALTER TABLE `discount_plan_customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plan_discounts`
--
ALTER TABLE `discount_plan_discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dso_alerts`
--
ALTER TABLE `dso_alerts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `external_services`
--
ALTER TABLE `external_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `gift_cards`
--
ALTER TABLE `gift_cards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gift_card_recharges`
--
ALTER TABLE `gift_card_recharges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hrm_settings`
--
ALTER TABLE `hrm_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `incomes`
--
ALTER TABLE `incomes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `income_categories`
--
ALTER TABLE `income_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `insurance_provider`
--
ALTER TABLE `insurance_provider`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mail_settings`
--
ALTER TABLE `mail_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;

--
-- AUTO_INCREMENT for table `money_transfers`
--
ALTER TABLE `money_transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packing_slips`
--
ALTER TABLE `packing_slips`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packing_slip_products`
--
ALTER TABLE `packing_slip_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_with_cheque`
--
ALTER TABLE `payment_with_cheque`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_credit_card`
--
ALTER TABLE `payment_with_credit_card`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_gift_card`
--
ALTER TABLE `payment_with_gift_card`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_insurance`
--
ALTER TABLE `payment_with_insurance`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_mobile_money`
--
ALTER TABLE `payment_with_mobile_money`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payment_with_paypal`
--
ALTER TABLE `payment_with_paypal`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payrolls`
--
ALTER TABLE `payrolls`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_batches`
--
ALTER TABLE `product_batches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_purchases`
--
ALTER TABLE `product_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_quotation`
--
ALTER TABLE `product_quotation`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_returns`
--
ALTER TABLE `product_returns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_sales`
--
ALTER TABLE `product_sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product_transfer`
--
ALTER TABLE `product_transfer`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `purchase_product_return`
--
ALTER TABLE `purchase_product_return`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotations`
--
ALTER TABLE `quotations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `refills`
--
ALTER TABLE `refills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `refill_items`
--
ALTER TABLE `refill_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `returns`
--
ALTER TABLE `returns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `return_purchases`
--
ALTER TABLE `return_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reward_point_settings`
--
ALTER TABLE `reward_point_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sent_sms`
--
ALTER TABLE `sent_sms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shelves`
--
ALTER TABLE `shelves`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sms_templates`
--
ALTER TABLE `sms_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_counts`
--
ALTER TABLE `stock_counts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `variants`
--
ALTER TABLE `variants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
--
-- Database: `pharmacy1`
--
CREATE DATABASE IF NOT EXISTS `pharmacy1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `pharmacy1`;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_no` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `initial_balance` double DEFAULT NULL,
  `total_balance` double NOT NULL,
  `note` text DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'Bank Account',
  `parent_account_id` int(11) DEFAULT NULL,
  `is_payment` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `account_no`, `name`, `initial_balance`, `total_balance`, `note`, `is_default`, `is_active`, `created_at`, `updated_at`, `code`, `type`, `parent_account_id`, `is_payment`) VALUES
(1, '019912229', 'Sales Account', 0, 0, 'This is the default account.', 1, 1, '2023-02-05 07:12:15', '2023-02-05 07:12:15', NULL, 'Bank Account', NULL, 1),
(2, '0147852', 'idi', 10000, 10000, NULL, NULL, 1, '2025-03-26 07:58:20', '2025-03-26 07:58:20', NULL, 'Bank Account', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `action_logs`
--

CREATE TABLE `action_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `action_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `route` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `synced_at` timestamp NULL DEFAULT NULL,
  `pharmacy_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `adjustments`
--

CREATE TABLE `adjustments` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `total_qty` double NOT NULL,
  `item` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `employee_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `checkin` varchar(255) NOT NULL,
  `checkout` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `barcodes`
--

CREATE TABLE `barcodes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `width` double(22,4) DEFAULT NULL,
  `height` double(22,4) DEFAULT NULL,
  `paper_width` double(22,4) DEFAULT NULL,
  `paper_height` double(22,4) DEFAULT NULL,
  `top_margin` double(22,4) DEFAULT NULL,
  `left_margin` double(22,4) DEFAULT NULL,
  `row_distance` double(22,4) DEFAULT NULL,
  `col_distance` double(22,4) DEFAULT NULL,
  `stickers_in_one_row` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_continuous` tinyint(1) NOT NULL DEFAULT 0,
  `stickers_in_one_sheet` int(11) DEFAULT NULL,
  `is_custom` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barcodes`
--

INSERT INTO `barcodes` (`id`, `name`, `description`, `width`, `height`, `paper_width`, `paper_height`, `top_margin`, `left_margin`, `row_distance`, `col_distance`, `stickers_in_one_row`, `is_default`, `is_continuous`, `stickers_in_one_sheet`, `is_custom`, `created_at`, `updated_at`) VALUES
(1, '20 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 4\" x 1\", Labels per sheet: 20', 4.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.1250, 0.0000, 0.1875, 2, 0, 0, 20, NULL, NULL, NULL),
(2, '30 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2.625\" x 1\", Labels per sheet: 30', 2.6250, 1.0000, 8.5000, 11.0000, 0.5000, 0.1880, 0.0000, 0.1250, 3, 0, 0, 30, NULL, NULL, NULL),
(3, '32 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1.25\", Labels per sheet: 32', 2.0000, 1.2500, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 32, NULL, NULL, NULL),
(4, '40 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1\", Labels per sheet: 40', 2.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 40, NULL, NULL, NULL),
(5, '50 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 1.5\" x 1\", Labels per sheet: 50', 1.5000, 1.0000, 8.5000, 11.0000, 0.5000, 0.5000, 0.0000, 0.0000, 5, 0, 0, 50, NULL, NULL, NULL),
(6, 'Continuous Rolls - 31.75mm x 25.4mm', 'Label Size: 31.75mm x 25.4mm, Gap: 3.18mm', 1.2500, 1.0000, 1.2500, 0.0000, 0.1250, 0.0000, 0.1250, 0.0000, 1, 0, 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `billers`
--

CREATE TABLE `billers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) NOT NULL,
  `vat_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `billers`
--

INSERT INTO `billers` (`id`, `name`, `image`, `company_name`, `vat_number`, `email`, `phone_number`, `address`, `city`, `state`, `postal_code`, `country`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Biller', NULL, 'Test Company', NULL, 'test@gmail.com', '12312', 'Test address', 'Test City', NULL, NULL, NULL, 1, '2023-05-28 06:53:51', '2023-05-28 06:53:51');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `title`, `image`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Brand', NULL, 1, '2023-05-28 06:51:38', '2023-05-28 06:51:38'),
(2, 'GB Pharma Limited', NULL, 1, '2025-03-25 17:44:43', '2025-03-25 17:44:43'),
(3, 'letap', NULL, 1, '2025-03-25 18:18:26', '2025-03-25 18:18:26');

-- --------------------------------------------------------

--
-- Table structure for table `cash_registers`
--

CREATE TABLE `cash_registers` (
  `id` int(10) UNSIGNED NOT NULL,
  `cash_in_hand` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cash_registers`
--

INSERT INTO `cash_registers` (`id`, `cash_in_hand`, `user_id`, `warehouse_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 0, 1, 1, 1, '2025-03-24 21:08:52', '2025-03-24 21:08:52'),
(2, 100, 2, 1, 1, '2025-03-25 17:31:46', '2025-03-25 17:31:46'),
(3, 12, 3, 1, 1, '2025-03-26 01:01:11', '2025-03-26 01:01:11');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image`, `parent_id`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Category', NULL, NULL, 1, '2023-05-28 06:51:00', '2023-05-28 06:51:00'),
(2, 'pain killer', NULL, NULL, 1, '2025-03-25 17:51:01', '2025-03-25 17:51:01'),
(3, 'ulcer', NULL, NULL, 1, '2025-03-25 18:18:50', '2025-03-25 18:18:50');

-- --------------------------------------------------------

--
-- Table structure for table `challans`
--

CREATE TABLE `challans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `courier_id` int(11) NOT NULL,
  `packing_slip_list` longtext NOT NULL,
  `amount_list` longtext NOT NULL,
  `cash_list` longtext DEFAULT NULL,
  `online_payment_list` longtext DEFAULT NULL,
  `cheque_list` longtext DEFAULT NULL,
  `delivery_charge_list` longtext DEFAULT NULL,
  `status_list` longtext DEFAULT NULL,
  `closing_date` date DEFAULT NULL,
  `created_by_id` int(11) NOT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `minimum_amount` double DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `used` int(11) NOT NULL,
  `expired_date` date NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `couriers`
--

CREATE TABLE `couriers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `couriers`
--

INSERT INTO `couriers` (`id`, `name`, `phone_number`, `address`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'obed', '0550936582', 'dome', 1, '2025-03-25 18:56:49', '2025-03-25 18:56:49'),
(2, 'kofi', '0550934168', 'lapaz', 1, '2025-03-25 18:57:41', '2025-03-25 18:57:41');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `exchange_rate` double NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `code`, `exchange_rate`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'US Dollar', 'USD', 0.06517, 1, '2020-11-01 00:22:58', '2025-02-04 17:17:08'),
(2, 'GHANA CEDI', 'GHS', 1, 1, '2025-02-04 17:17:29', '2025-02-04 17:17:29');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `tax_no` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `points` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deposit` double DEFAULT NULL,
  `expense` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customer_group_id`, `user_id`, `name`, `company_name`, `email`, `phone_number`, `tax_no`, `address`, `city`, `state`, `postal_code`, `country`, `points`, `is_active`, `created_at`, `updated_at`, `deposit`, `expense`) VALUES
(1, 1, NULL, 'John Doe', 'Test Company', 'john@gmail.com', '231312', NULL, 'Test address', 'Test City', NULL, NULL, NULL, NULL, 1, '2023-05-28 06:53:04', '2023-05-28 06:53:04', NULL, NULL),
(2, 1, NULL, 'tahiru', NULL, 'tahiru@gmail.com', '0550936771', NULL, 'anyaa', 'accra', NULL, NULL, NULL, NULL, 1, '2025-03-25 16:59:54', '2025-03-25 16:59:54', NULL, NULL),
(3, 1, NULL, 'obed', NULL, 'oninson45@gmail.com', '0256422216', NULL, NULL, 'Amasaman', NULL, NULL, NULL, NULL, 1, '2025-03-26 01:30:48', '2025-03-26 01:30:48', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_groups`
--

CREATE TABLE `customer_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `percentage` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_groups`
--

INSERT INTO `customer_groups` (`id`, `name`, `percentage`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'General', '0', 1, '2023-05-28 06:51:29', '2023-05-28 06:51:29');

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

CREATE TABLE `custom_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `belongs_to` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `default_value` text DEFAULT NULL,
  `option_value` text DEFAULT NULL,
  `grid_value` int(11) NOT NULL,
  `is_table` tinyint(1) NOT NULL,
  `is_invoice` tinyint(1) NOT NULL,
  `is_required` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_disable` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `packing_slip_ids` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `courier_id` int(11) DEFAULT NULL,
  `address` text NOT NULL,
  `delivered_by` varchar(255) DEFAULT NULL,
  `recieved_by` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`id`, `reference_no`, `sale_id`, `packing_slip_ids`, `user_id`, `courier_id`, `address`, `delivered_by`, `recieved_by`, `file`, `note`, `status`, `created_at`, `updated_at`) VALUES
(1, 'dr-20250325-065125', 2, NULL, 2, 1, 'anyaa accra', NULL, NULL, NULL, NULL, '3', '2025-03-25 18:51:45', '2025-03-25 18:58:26');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` int(10) UNSIGNED NOT NULL,
  `amount` double NOT NULL,
  `customer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `applicable_for` varchar(255) NOT NULL,
  `product_list` longtext DEFAULT NULL,
  `valid_from` date NOT NULL,
  `valid_till` date NOT NULL,
  `type` varchar(255) NOT NULL,
  `value` double NOT NULL,
  `minimum_qty` double NOT NULL,
  `maximum_qty` double NOT NULL,
  `days` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plans`
--

CREATE TABLE `discount_plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plan_customers`
--

CREATE TABLE `discount_plan_customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `discount_plan_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plan_discounts`
--

CREATE TABLE `discount_plan_discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `discount_id` int(11) NOT NULL,
  `discount_plan_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dso_alerts`
--

CREATE TABLE `dso_alerts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_info` longtext NOT NULL,
  `number_of_products` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `department_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `staff_id` varchar(191) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `expense_category_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `reference_no`, `expense_category_id`, `warehouse_id`, `account_id`, `user_id`, `cash_register_id`, `amount`, `note`, `created_at`, `updated_at`) VALUES
(1, 'er-20250325-063857', 1, 1, 1, 2, 2, 100, NULL, '2025-03-25 00:00:00', '2025-03-25 18:38:57');

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `code`, `name`, `is_active`, `created_at`, `updated_at`) VALUES
(1, '74965071', 'transportation', 1, '2025-03-25 18:38:22', '2025-03-25 18:38:22');

-- --------------------------------------------------------

--
-- Table structure for table `external_services`
--

CREATE TABLE `external_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `details` longtext NOT NULL,
  `module_status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`module_status`)),
  `active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `external_services`
--

INSERT INTO `external_services` (`id`, `name`, `type`, `details`, `module_status`, `active`, `created_at`, `updated_at`) VALUES
(1, 'PayPal', 'payment', 'Client ID,Client Secret;abcd1234,wxyz5678', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(2, 'Stripe', 'payment', 'Public Key,Private Key;efgh1234,stuv5678', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(3, 'Razorpay', 'payment', 'Key,Secret;rzp_test_Y4MCcpHfZNU6rR,3Hr7SDqaZ0G5waN0jsLgsiLx', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(4, 'Paystack', 'payment', 'public_Key,Secret_Key;pk_test_e8d220b7463d64569f0053e78534f38e6b10cf4a,sk_test_6d62cb976e1e0ab43f1e48b2934b0dfc7f32a1fe', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(5, 'Mollie', 'payment', 'api_key;test_dHar4XY7LxsDOtmnkVtjNVWXLSlXsM', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(6, 'Xendit', 'payment', 'secret_key,callback_token;xnd_development_aKJVKYbc4lHkEjcCLzWLrBsKs6jF6nbM6WaCMfnJerP3JW57CLis553XNRdDU,YPZxND92Mt8tdXntTYIEkRX802onZ5OcdKBUzycebuqYvN4n', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(7, 'bkash', 'payment', 'Mode,app_key,app_secret,username,password;sandbox,0vWQuCRGiUX7EPVjQDr0EUAYtc,jcUNPBgbcqEDedNKdvE4G1cAK7D3hCjmJccNPZZBq96QIxxwAMEx,01770618567,D7DaC<*E*eG', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(8, 'sslcommerz', 'payment', 'appkey,appsecret;12341234,asdfa23423', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(9, 'Mpesa', 'payment', 'consumer_Key,consumer_Secret;fhfgkj,dtrddhd', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(10, 'Pesapal', 'payment', 'Mode,Consumer Key,Consumer Secret;sandbox,qkio1BGGYAXTu2JOfm7XSXNruoZsrqEW,osGQ364R49cXKeOYSpaOnT++rHs=', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `site_title` varchar(255) NOT NULL,
  `site_logo` varchar(255) DEFAULT NULL,
  `is_rtl` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `currency` varchar(255) NOT NULL,
  `package_id` int(11) DEFAULT NULL,
  `subscription_type` varchar(255) DEFAULT NULL,
  `staff_access` varchar(255) NOT NULL,
  `without_stock` varchar(255) NOT NULL DEFAULT 'no',
  `date_format` varchar(255) NOT NULL,
  `developed_by` varchar(255) DEFAULT NULL,
  `invoice_format` varchar(255) DEFAULT NULL,
  `decimal` int(11) DEFAULT 2,
  `state` int(11) DEFAULT NULL,
  `theme` varchar(255) NOT NULL,
  `modules` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `currency_position` varchar(255) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `expiry_type` varchar(255) NOT NULL DEFAULT 'days',
  `expiry_value` varchar(255) NOT NULL DEFAULT '0',
  `is_zatca` tinyint(1) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `vat_registration_number` varchar(255) DEFAULT NULL,
  `is_packing_slip` tinyint(1) NOT NULL DEFAULT 0,
  `sms_credit` bigint(20) UNSIGNED DEFAULT NULL,
  `pharmacy_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `site_title`, `site_logo`, `is_rtl`, `created_at`, `updated_at`, `currency`, `package_id`, `subscription_type`, `staff_access`, `without_stock`, `date_format`, `developed_by`, `invoice_format`, `decimal`, `state`, `theme`, `modules`, `currency_position`, `expiry_date`, `expiry_type`, `expiry_value`, `is_zatca`, `company_name`, `vat_registration_number`, `is_packing_slip`, `sms_credit`, `pharmacy_id`) VALUES
(1, 'GogoPlus POS', '20250202043823.png', 0, '2018-07-06 06:13:11', '2025-03-24 20:23:33', '1', 3, 'monthly', 'own', 'no', 'd/m/Y', 'GogoPlus Ltd.', 'standard', 2, 1, 'default.css', '', 'prefix', '2025-05-03', 'days', '0', NULL, NULL, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `gift_cards`
--

CREATE TABLE `gift_cards` (
  `id` int(10) UNSIGNED NOT NULL,
  `card_no` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `expense` double NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gift_card_recharges`
--

CREATE TABLE `gift_card_recharges` (
  `id` int(10) UNSIGNED NOT NULL,
  `gift_card_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `note` text DEFAULT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hrm_settings`
--

CREATE TABLE `hrm_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `checkin` varchar(255) NOT NULL,
  `checkout` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `incomes`
--

CREATE TABLE `incomes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `income_category_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `income_categories`
--

CREATE TABLE `income_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `insurance_provider`
--

CREATE TABLE `insurance_provider` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mail_settings`
--

CREATE TABLE `mail_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `driver` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `port` varchar(255) NOT NULL,
  `from_address` varchar(255) NOT NULL,
  `from_name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `encryption` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_02_17_060412_create_categories_table', 1),
(4, '2018_02_20_035727_create_brands_table', 1),
(5, '2018_02_25_100635_create_suppliers_table', 1),
(6, '2018_02_27_101619_create_warehouse_table', 1),
(7, '2018_03_03_040448_create_units_table', 1),
(8, '2018_03_04_041317_create_taxes_table', 1),
(9, '2018_03_10_061915_create_customer_groups_table', 1),
(10, '2018_03_10_090534_create_customers_table', 1),
(11, '2018_03_11_095547_create_billers_table', 1),
(12, '2018_04_05_054401_create_products_table', 1),
(13, '2018_04_06_133606_create_purchases_table', 1),
(14, '2018_04_06_154600_create_product_purchases_table', 1),
(15, '2018_04_06_154915_create_product_warhouse_table', 1),
(16, '2018_04_10_085927_create_sales_table', 1),
(17, '2018_04_10_090133_create_product_sales_table', 1),
(18, '2018_04_10_090254_create_payments_table', 1),
(19, '2018_04_10_090341_create_payment_with_cheque_table', 1),
(20, '2018_04_10_090509_create_payment_with_credit_card_table', 1),
(21, '2018_04_13_121436_create_quotation_table', 1),
(22, '2018_04_13_122324_create_product_quotation_table', 1),
(23, '2018_04_14_121802_create_transfers_table', 1),
(24, '2018_04_14_121913_create_product_transfer_table', 1),
(25, '2018_05_13_082847_add_payment_id_and_change_sale_id_to_payments_table', 1),
(26, '2018_05_13_090906_change_customer_id_to_payment_with_credit_card_table', 1),
(27, '2018_05_20_054532_create_adjustments_table', 1),
(28, '2018_05_20_054859_create_product_adjustments_table', 1),
(29, '2018_05_21_163419_create_returns_table', 1),
(30, '2018_05_21_163443_create_product_returns_table', 1),
(31, '2018_06_02_050905_create_roles_table', 1),
(32, '2018_06_02_073430_add_columns_to_users_table', 1),
(33, '2018_06_03_053738_create_permission_tables', 1),
(34, '2018_06_21_063736_create_pos_setting_table', 1),
(35, '2018_06_21_094155_add_user_id_to_sales_table', 1),
(36, '2018_06_21_101529_add_user_id_to_purchases_table', 1),
(37, '2018_06_21_103512_add_user_id_to_transfers_table', 1),
(38, '2018_06_23_061058_add_user_id_to_quotations_table', 1),
(39, '2018_06_23_082427_add_is_deleted_to_users_table', 1),
(40, '2018_06_25_043308_change_email_to_users_table', 1),
(41, '2018_07_06_115449_create_general_settings_table', 1),
(42, '2018_07_08_043944_create_languages_table', 1),
(43, '2018_07_11_102144_add_user_id_to_returns_table', 1),
(44, '2018_07_11_102334_add_user_id_to_payments_table', 1),
(45, '2018_07_22_130541_add_digital_to_products_table', 1),
(46, '2018_07_24_154250_create_deliveries_table', 1),
(47, '2018_08_16_053336_create_expense_categories_table', 1),
(48, '2018_08_17_115415_create_expenses_table', 1),
(49, '2018_08_18_050418_create_gift_cards_table', 1),
(50, '2018_08_19_063119_create_payment_with_gift_card_table', 1),
(51, '2018_08_25_042333_create_gift_card_recharges_table', 1),
(52, '2018_08_25_101354_add_deposit_expense_to_customers_table', 1),
(53, '2018_08_26_043801_create_deposits_table', 1),
(54, '2018_09_02_044042_add_keybord_active_to_pos_setting_table', 1),
(55, '2018_09_09_092713_create_payment_with_paypal_table', 1),
(56, '2018_09_10_051254_add_currency_to_general_settings_table', 1),
(57, '2018_10_22_084118_add_biller_and_store_id_to_users_table', 1),
(58, '2018_10_26_034927_create_coupons_table', 1),
(59, '2018_10_27_090857_add_coupon_to_sales_table', 1),
(60, '2018_11_07_070155_add_currency_position_to_general_settings_table', 1),
(61, '2018_11_19_094650_add_combo_to_products_table', 1),
(62, '2018_12_09_043712_create_accounts_table', 1),
(63, '2018_12_17_112253_add_is_default_to_accounts_table', 1),
(64, '2018_12_19_103941_add_account_id_to_payments_table', 1),
(65, '2018_12_20_065900_add_account_id_to_expenses_table', 1),
(66, '2018_12_20_082753_add_account_id_to_returns_table', 1),
(67, '2018_12_26_064330_create_return_purchases_table', 1),
(68, '2018_12_26_144708_create_purchase_product_return_table', 1),
(69, '2018_12_27_110018_create_departments_table', 1),
(70, '2018_12_30_054844_create_employees_table', 1),
(71, '2018_12_31_125210_create_payrolls_table', 1),
(72, '2018_12_31_150446_add_department_id_to_employees_table', 1),
(73, '2019_01_01_062708_add_user_id_to_expenses_table', 1),
(74, '2019_01_02_075644_create_hrm_settings_table', 1),
(75, '2019_01_02_090334_create_attendances_table', 1),
(76, '2019_01_27_160956_add_three_columns_to_general_settings_table', 1),
(77, '2019_02_15_183303_create_stock_counts_table', 1),
(78, '2019_02_17_101604_add_is_adjusted_to_stock_counts_table', 1),
(79, '2019_04_13_101707_add_tax_no_to_customers_table', 1),
(80, '2019_08_19_000000_create_failed_jobs_table', 1),
(81, '2019_10_14_111455_create_holidays_table', 1),
(82, '2019_11_13_145619_add_is_variant_to_products_table', 1),
(83, '2019_11_13_150206_create_product_variants_table', 1),
(84, '2019_11_13_153828_create_variants_table', 1),
(85, '2019_11_25_134041_add_qty_to_product_variants_table', 1),
(86, '2019_11_25_134922_add_variant_id_to_product_purchases_table', 1),
(87, '2019_11_25_145341_add_variant_id_to_product_warehouse_table', 1),
(88, '2019_11_29_182201_add_variant_id_to_product_sales_table', 1),
(89, '2019_12_04_121311_add_variant_id_to_product_quotation_table', 1),
(90, '2019_12_05_123802_add_variant_id_to_product_transfer_table', 1),
(91, '2019_12_08_114954_add_variant_id_to_product_returns_table', 1),
(92, '2019_12_08_203146_add_variant_id_to_purchase_product_return_table', 1),
(93, '2020_02_28_103340_create_money_transfers_table', 1),
(94, '2020_07_01_193151_add_image_to_categories_table', 1),
(95, '2020_09_26_130426_add_user_id_to_deliveries_table', 1),
(96, '2020_10_11_125457_create_cash_registers_table', 1),
(97, '2020_10_13_155019_add_cash_register_id_to_sales_table', 1),
(98, '2020_10_13_172624_add_cash_register_id_to_returns_table', 1),
(99, '2020_10_17_212338_add_cash_register_id_to_payments_table', 1),
(100, '2020_10_18_124200_add_cash_register_id_to_expenses_table', 1),
(101, '2020_10_21_121632_add_developed_by_to_general_settings_table', 1),
(102, '2020_10_30_135557_create_notifications_table', 1),
(103, '2020_11_01_044954_create_currencies_table', 1),
(104, '2020_11_01_140736_add_price_to_product_warehouse_table', 1),
(105, '2020_11_02_050633_add_is_diff_price_to_products_table', 1),
(106, '2020_11_09_055222_add_user_id_to_customers_table', 1),
(107, '2020_11_17_054806_add_invoice_format_to_general_settings_table', 1),
(108, '2021_02_10_074859_add_variant_id_to_product_adjustments_table', 1),
(109, '2021_03_07_093606_create_product_batches_table', 1),
(110, '2021_03_07_093759_add_product_batch_id_to_product_warehouse_table', 1),
(111, '2021_03_07_093900_add_product_batch_id_to_product_purchases_table', 1),
(112, '2021_03_11_132603_add_product_batch_id_to_product_sales_table', 1),
(113, '2021_03_25_125421_add_is_batch_to_products_table', 1),
(114, '2021_05_19_120127_add_product_batch_id_to_product_returns_table', 1),
(115, '2021_05_22_105611_add_product_batch_id_to_purchase_product_return_table', 1),
(116, '2021_05_23_124848_add_product_batch_id_to_product_transfer_table', 1),
(117, '2021_05_26_153106_add_product_batch_id_to_product_quotation_table', 1),
(118, '2021_06_08_213007_create_reward_point_settings_table', 1),
(119, '2021_06_16_104155_add_points_to_customers_table', 1),
(120, '2021_06_17_101057_add_used_points_to_payments_table', 1),
(121, '2021_07_06_132716_add_variant_list_to_products_table', 1),
(122, '2021_09_27_161141_add_is_imei_to_products_table', 1),
(123, '2021_09_28_170052_add_imei_number_to_product_warehouse_table', 1),
(124, '2021_09_28_170126_add_imei_number_to_product_purchases_table', 1),
(125, '2021_10_03_170652_add_imei_number_to_product_sales_table', 1),
(126, '2021_10_10_145214_add_imei_number_to_product_returns_table', 1),
(127, '2021_10_11_104504_add_imei_number_to_product_transfer_table', 1),
(128, '2021_10_12_160107_add_imei_number_to_purchase_product_return_table', 1),
(129, '2021_10_12_205146_add_is_rtl_to_general_settings_table', 1),
(130, '2022_01_13_191242_create_discount_plans_table', 1),
(131, '2022_01_14_174318_create_discount_plan_customers_table', 1),
(132, '2022_01_14_202439_create_discounts_table', 1),
(133, '2022_01_16_153506_create_discount_plan_discounts_table', 1),
(134, '2022_02_05_174210_add_order_discount_type_and_value_to_sales_table', 1),
(135, '2022_05_26_195506_add_daily_sale_objective_to_products_table', 1),
(136, '2022_05_28_104209_create_dso_alerts_table', 1),
(137, '2022_06_01_112100_add_is_embeded_to_products_table', 1),
(138, '2022_06_14_130505_add_sale_id_to_returns_table', 1),
(139, '2022_07_19_115504_add_variant_data_to_products_table', 1),
(140, '2022_07_25_194300_add_additional_cost_to_product_variants_table', 1),
(141, '2022_09_04_195610_add_purchase_id_to_return_purchases_table', 1),
(142, '2023_01_18_125040_alter_table_general_settings', 1),
(143, '2023_01_18_133701_alter_table_pos_setting', 1),
(144, '2023_01_25_145309_add_expiry_date_to_general_settings_table', 1),
(145, '2023_02_05_132001_add_change_to_payments_table', 1),
(146, '2023_02_23_125656_alter_table_sales', 1),
(147, '2023_02_26_124100_add_package_id_to_general_settings_table', 1),
(148, '2023_03_04_120325_create_custom_fields_table', 1),
(149, '2023_03_14_174658_add_subscription_type_to_general_setting_table', 1),
(150, '2023_03_22_174352_add_currency_id_and_exchange_rate_to_returns_table', 1),
(151, '2023_03_27_114320_add_currency_id_and_exchange_rate_to_purchases_table', 1),
(152, '2023_03_27_132747_add_currency_id_and_exchange_rate_to_return_purchases_table', 1),
(153, '2023_04_25_150236_create_mail_settings_table', 1),
(154, '2023_05_13_125424_add_zatca_to_general_settings_table', 1),
(155, '2023_05_28_155540_create_tables_table', 1),
(156, '2023_05_29_115039_add_is_table_to_pos_setting_table', 1),
(157, '2023_05_29_115301_add_table_id_to_sales_table', 1),
(158, '2023_05_31_165049_add_queue_no_to_sales_table', 1),
(159, '2023_07_23_160254_create_couriers_table', 1),
(160, '2023_07_23_174343_add_courier_id_to_deliveries_table', 1),
(161, '2023_08_12_124016_add_staff_id_to_employees_table', 1),
(162, '2023_08_14_142608_add_is_active_to_currencies_table', 1),
(163, '2023_08_24_130203_change_columns_to_attendances_table', 1),
(164, '2023_09_10_134503_add_without_stock_to_general_settings_table', 1),
(165, '2023_09_26_211542_add_modules_to_general_settings_table', 1),
(166, '2023_10_15_124306_add_return_qty_to_product_sales_table', 1),
(167, '2023_12_03_235606_crete_external_services_table', 1),
(168, '2024_02_04_131826_add_unit_cost_to_product_adjustments_table', 1),
(169, '2024_02_13_173126_change_modules_to_general_settings_table', 1),
(170, '2024_05_02_114215_add_payment_receiver_to_payments', 1),
(171, '2024_05_06_132553_create_sms_templates_table', 1),
(172, '2024_05_07_102225_add_send_sms_to_pos_setting_table', 1),
(173, '2024_05_07_132625_add_is_default_to_sms_templates_table', 1),
(174, '2024_05_08_112211_change_address_and_city_field_to_nullable_in_customers_table', 1),
(175, '2024_05_08_151050_add_is_default_ecommerce_columne_to_sms_templates_table', 1),
(176, '2024_05_20_182757_add_wholesale_price_to_products_table', 1),
(177, '2024_05_21_170500_add_is_sent_to_transfers_table', 1),
(178, '2024_06_04_225113_create_income_categories_table', 1),
(179, '2024_06_04_225128_create_incomes_table', 1),
(180, '2024_06_29_131917_add_is_packing_slip_to_general_settings_table', 1),
(181, '2024_07_05_192531_create_packing_slips_table', 1),
(182, '2024_07_05_193002_create_packing_slip_products_table', 1),
(183, '2024_07_05_194501_add_is_packing_and_delivered_to_product_sales_table', 1),
(184, '2024_07_14_122245_add_delivery_id_to_packing_slips_table', 1),
(185, '2024_07_14_122415_add_variant_id_to_packing_slip_products_table', 1),
(186, '2024_07_14_122519_add_packing_slip_ids_to_deliveries_table', 1),
(187, '2024_07_16_125908_create_challans_table', 1),
(188, '2024_08_12_112830_add_thermal_invoice_size_to_pos_setting', 1),
(189, '2024_08_14_133351_add_expiry_type_value_to_general_settings', 1),
(190, '2024_09_11_151744_add_return_qty_to_product_purchases_table', 1),
(191, '2024_09_12_162309_create_barcodes_table', 1),
(192, '2024_10_10_121312_add_data_to_payment_with_credit_card_table', 1),
(193, '2024_10_10_212501_alter_attendances_table', 1),
(194, '2024_10_10_213757_alter_attendances_table', 1),
(195, '2024_10_14_144917_change_column_to_nullable_to_payment_with_credit_card_table', 1),
(196, '2024_11_10_121521_add_code_and_type_to_accounts_table', 1),
(197, '2024_11_24_100926_add_module_status_to_external_services_table', 1),
(198, '2025_03_09_000000_create_insurance_provider_table', 1),
(199, '2025_03_09_000001_create_payment_with_insurance_table', 1),
(200, '2025_03_09_000002_create_refills_table', 1),
(201, '2025_03_09_000003_create_refill_items_table', 1),
(202, '2025_03_09_000004_add_columns_to_products_table', 1),
(203, '2025_03_09_000005_add_dosage_to_product_sales_table', 1),
(204, '2025_03_09_000006_create_shelves_table', 1),
(205, '2025_03_12_000007_update_products_table_with_markups_and_units', 1),
(206, '2025_03_24_000000_create_payment_with_mobile_money_table', 1),
(207, '2025_03_24_000001_create_sent_sms_table', 1),
(208, '2025_03_24_000002_add_next_refill_date_to_refill_items_table', 1),
(209, '2025_03_24_000003_add_sms_credit_to_general_settings_table', 1),
(210, '2025_03_24_000004_add_customer_name_and_expiry_to_payment_with_insurance_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `money_transfers`
--

CREATE TABLE `money_transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `from_account_id` int(11) NOT NULL,
  `to_account_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `packing_slips`
--

CREATE TABLE `packing_slips` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `delivery_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `packing_slip_products`
--

CREATE TABLE `packing_slip_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `packing_slip_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `payment_receiver` varchar(255) DEFAULT NULL,
  `payment_reference` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `used_points` double DEFAULT NULL,
  `change` double DEFAULT NULL,
  `paying_method` varchar(255) NOT NULL,
  `payment_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `purchase_id`, `sale_id`, `cash_register_id`, `account_id`, `payment_receiver`, `payment_reference`, `user_id`, `amount`, `used_points`, `change`, `paying_method`, `payment_note`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 2, 1, 'iddrisu', 'spr-20250325-064247', 2, 3.26, NULL, 1.74, 'Cash', NULL, '2025-03-25 18:42:47', '2025-03-25 18:42:47'),
(2, NULL, 2, 2, 1, 'iddrisu', 'spr-20250325-065012', 2, 0, NULL, 2, 'Cash', NULL, '2025-03-25 18:50:12', '2025-03-25 18:50:12'),
(3, NULL, 5, 3, 1, NULL, 'spr-20250326-085920', 3, 8, NULL, 21, 'Cash', NULL, '2025-03-26 08:59:20', '2025-03-26 08:59:20'),
(4, NULL, 6, 1, 1, 'intern', 'spr-20250326-092257', 1, 1.3, NULL, 0, 'Mobile Money', NULL, '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_cheque`
--

CREATE TABLE `payment_with_cheque` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `cheque_no` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_credit_card`
--

CREATE TABLE `payment_with_credit_card` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_stripe_id` varchar(255) DEFAULT NULL,
  `charge_id` varchar(255) NOT NULL,
  `data` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_gift_card`
--

CREATE TABLE `payment_with_gift_card` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `gift_card_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_insurance`
--

CREATE TABLE `payment_with_insurance` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_insurance_id` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  `insurer` varchar(255) NOT NULL,
  `insurance_policy_id` varchar(255) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `approved_amount` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_mobile_money`
--

CREATE TABLE `payment_with_mobile_money` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `network` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_with_mobile_money`
--

INSERT INTO `payment_with_mobile_money` (`id`, `payment_id`, `customer_id`, `phone_number`, `reference`, `network`, `created_at`, `updated_at`) VALUES
(1, 4, 1, '0247118423', '48907553128655', 'MTN', '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_paypal`
--

CREATE TABLE `payment_with_paypal` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payrolls`
--

CREATE TABLE `payrolls` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `paying_method` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(4, 'products-edit', 'web', '2018-06-03 01:00:09', '2018-06-03 01:00:09'),
(5, 'products-delete', 'web', '2018-06-03 22:54:22', '2018-06-03 22:54:22'),
(6, 'products-add', 'web', '2018-06-04 00:34:14', '2018-06-04 00:34:14'),
(7, 'products-index', 'web', '2018-06-04 03:34:27', '2018-06-04 03:34:27'),
(8, 'purchases-index', 'web', '2018-06-04 08:03:19', '2018-06-04 08:03:19'),
(9, 'purchases-add', 'web', '2018-06-04 08:12:25', '2018-06-04 08:12:25'),
(10, 'purchases-edit', 'web', '2018-06-04 09:47:36', '2018-06-04 09:47:36'),
(11, 'purchases-delete', 'web', '2018-06-04 09:47:36', '2018-06-04 09:47:36'),
(12, 'sales-index', 'web', '2018-06-04 10:49:08', '2018-06-04 10:49:08'),
(13, 'sales-add', 'web', '2018-06-04 10:49:52', '2018-06-04 10:49:52'),
(14, 'sales-edit', 'web', '2018-06-04 10:49:52', '2018-06-04 10:49:52'),
(15, 'sales-delete', 'web', '2018-06-04 10:49:53', '2018-06-04 10:49:53'),
(16, 'quotes-index', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(17, 'quotes-add', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(18, 'quotes-edit', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(19, 'quotes-delete', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(20, 'transfers-index', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(21, 'transfers-add', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(22, 'transfers-edit', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(23, 'transfers-delete', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(24, 'returns-index', 'web', '2018-06-04 22:50:24', '2018-06-04 22:50:24'),
(25, 'returns-add', 'web', '2018-06-04 22:50:24', '2018-06-04 22:50:24'),
(26, 'returns-edit', 'web', '2018-06-04 22:50:25', '2018-06-04 22:50:25'),
(27, 'returns-delete', 'web', '2018-06-04 22:50:25', '2018-06-04 22:50:25'),
(28, 'customers-index', 'web', '2018-06-04 23:15:54', '2018-06-04 23:15:54'),
(29, 'customers-add', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(30, 'customers-edit', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(31, 'customers-delete', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(32, 'suppliers-index', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(33, 'suppliers-add', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(34, 'suppliers-edit', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(35, 'suppliers-delete', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(36, 'product-report', 'web', '2018-06-24 23:05:33', '2018-06-24 23:05:33'),
(37, 'purchase-report', 'web', '2018-06-24 23:24:56', '2018-06-24 23:24:56'),
(38, 'sale-report', 'web', '2018-06-24 23:33:13', '2018-06-24 23:33:13'),
(39, 'customer-report', 'web', '2018-06-24 23:36:51', '2018-06-24 23:36:51'),
(40, 'due-report', 'web', '2018-06-24 23:39:52', '2018-06-24 23:39:52'),
(41, 'users-index', 'web', '2018-06-25 00:00:10', '2018-06-25 00:00:10'),
(42, 'users-add', 'web', '2018-06-25 00:00:10', '2018-06-25 00:00:10'),
(43, 'users-edit', 'web', '2018-06-25 00:01:30', '2018-06-25 00:01:30'),
(44, 'users-delete', 'web', '2018-06-25 00:01:30', '2018-06-25 00:01:30'),
(45, 'profit-loss', 'web', '2018-07-14 21:50:05', '2018-07-14 21:50:05'),
(46, 'best-seller', 'web', '2018-07-14 22:01:38', '2018-07-14 22:01:38'),
(47, 'daily-sale', 'web', '2018-07-14 22:24:21', '2018-07-14 22:24:21'),
(48, 'monthly-sale', 'web', '2018-07-14 22:30:41', '2018-07-14 22:30:41'),
(49, 'daily-purchase', 'web', '2018-07-14 22:36:46', '2018-07-14 22:36:46'),
(50, 'monthly-purchase', 'web', '2018-07-14 22:48:17', '2018-07-14 22:48:17'),
(51, 'payment-report', 'web', '2018-07-14 23:10:41', '2018-07-14 23:10:41'),
(52, 'warehouse-stock-report', 'web', '2018-07-14 23:16:55', '2018-07-14 23:16:55'),
(53, 'product-qty-alert', 'web', '2018-07-14 23:33:21', '2018-07-14 23:33:21'),
(54, 'supplier-report', 'web', '2018-07-30 03:00:01', '2018-07-30 03:00:01'),
(55, 'expenses-index', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(56, 'expenses-add', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(57, 'expenses-edit', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(58, 'expenses-delete', 'web', '2018-09-05 01:07:11', '2018-09-05 01:07:11'),
(59, 'general_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(60, 'mail_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(61, 'pos_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(62, 'hrm_setting', 'web', '2019-01-02 10:30:23', '2019-01-02 10:30:23'),
(63, 'purchase-return-index', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(64, 'purchase-return-add', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(65, 'purchase-return-edit', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(66, 'purchase-return-delete', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(67, 'account-index', 'web', '2019-01-02 22:06:13', '2019-01-02 22:06:13'),
(68, 'balance-sheet', 'web', '2019-01-02 22:06:14', '2019-01-02 22:06:14'),
(69, 'account-statement', 'web', '2019-01-02 22:06:14', '2019-01-02 22:06:14'),
(70, 'department', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(71, 'attendance', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(72, 'payroll', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(73, 'employees-index', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(74, 'employees-add', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(75, 'employees-edit', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(76, 'employees-delete', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(77, 'user-report', 'web', '2019-01-16 06:48:18', '2019-01-16 06:48:18'),
(78, 'stock_count', 'web', '2019-02-17 10:32:01', '2019-02-17 10:32:01'),
(79, 'adjustment', 'web', '2019-02-17 10:32:02', '2019-02-17 10:32:02'),
(80, 'sms_setting', 'web', '2019-02-22 05:18:03', '2019-02-22 05:18:03'),
(81, 'create_sms', 'web', '2019-02-22 05:18:03', '2019-02-22 05:18:03'),
(82, 'print_barcode', 'web', '2019-03-07 05:02:19', '2019-03-07 05:02:19'),
(83, 'empty_database', 'web', '2019-03-07 05:02:19', '2019-03-07 05:02:19'),
(84, 'customer_group', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(85, 'unit', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(86, 'tax', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(87, 'gift_card', 'web', '2019-03-07 06:29:38', '2019-03-07 06:29:38'),
(88, 'coupon', 'web', '2019-03-07 06:29:38', '2019-03-07 06:29:38'),
(89, 'holiday', 'web', '2019-10-19 08:57:15', '2019-10-19 08:57:15'),
(90, 'warehouse-report', 'web', '2019-10-22 06:00:23', '2019-10-22 06:00:23'),
(91, 'warehouse', 'web', '2020-02-26 06:47:32', '2020-02-26 06:47:32'),
(92, 'brand', 'web', '2020-02-26 06:59:59', '2020-02-26 06:59:59'),
(93, 'billers-index', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(94, 'billers-add', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(95, 'billers-edit', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(96, 'billers-delete', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(97, 'money-transfer', 'web', '2020-03-02 05:41:48', '2020-03-02 05:41:48'),
(98, 'category', 'web', '2020-07-13 12:13:16', '2020-07-13 12:13:16'),
(99, 'delivery', 'web', '2020-07-13 12:13:16', '2020-07-13 12:13:16'),
(100, 'send_notification', 'web', '2020-10-31 06:21:31', '2020-10-31 06:21:31'),
(101, 'today_sale', 'web', '2020-10-31 06:57:04', '2020-10-31 06:57:04'),
(102, 'today_profit', 'web', '2020-10-31 06:57:04', '2020-10-31 06:57:04'),
(103, 'currency', 'web', '2020-11-09 00:23:11', '2020-11-09 00:23:11'),
(104, 'backup_database', 'web', '2020-11-15 00:16:55', '2020-11-15 00:16:55'),
(105, 'reward_point_setting', 'web', '2021-06-27 04:34:42', '2021-06-27 04:34:42'),
(106, 'revenue_profit_summary', 'web', '2022-02-08 13:57:21', '2022-02-08 13:57:21'),
(107, 'cash_flow', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(108, 'monthly_summary', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(109, 'yearly_report', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(110, 'discount_plan', 'web', '2022-02-16 09:12:26', '2022-02-16 09:12:26'),
(111, 'discount', 'web', '2022-02-16 09:12:38', '2022-02-16 09:12:38'),
(112, 'product-expiry-report', 'web', '2022-03-30 05:39:20', '2022-03-30 05:39:20'),
(113, 'purchase-payment-index', 'web', '2022-06-05 14:12:27', '2022-06-05 14:12:27'),
(114, 'purchase-payment-add', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(115, 'purchase-payment-edit', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(116, 'purchase-payment-delete', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(117, 'sale-payment-index', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(118, 'sale-payment-add', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(119, 'sale-payment-edit', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(120, 'sale-payment-delete', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(121, 'all_notification', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(122, 'sale-report-chart', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(123, 'dso-report', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(124, 'product_history', 'web', '2022-08-25 14:04:05', '2022-08-25 14:04:05'),
(125, 'supplier-due-report', 'web', '2022-08-31 09:46:33', '2022-08-31 09:46:33'),
(126, 'custom_field', 'web', '2023-11-13 06:23:34', '2023-11-13 06:23:34'),
(127, 'incomes-index', 'web', '2024-07-11 13:16:43', '2024-07-11 13:16:43'),
(128, 'incomes-add', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(129, 'incomes-edit', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(130, 'incomes-delete', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(131, 'packing_slip_challan', 'web', '2024-07-22 14:16:17', '2024-07-22 14:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `pos_setting`
--

CREATE TABLE `pos_setting` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `product_number` int(11) NOT NULL,
  `keybord_active` tinyint(1) NOT NULL,
  `is_table` tinyint(1) NOT NULL DEFAULT 0,
  `send_sms` tinyint(1) NOT NULL DEFAULT 0,
  `stripe_public_key` varchar(255) DEFAULT NULL,
  `stripe_secret_key` varchar(255) DEFAULT NULL,
  `paypal_live_api_username` varchar(255) DEFAULT NULL,
  `paypal_live_api_password` varchar(255) DEFAULT NULL,
  `paypal_live_api_secret` varchar(255) DEFAULT NULL,
  `payment_options` text DEFAULT NULL,
  `invoice_option` varchar(10) DEFAULT NULL,
  `thermal_invoice_size` varchar(255) NOT NULL DEFAULT '80',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pos_setting`
--

INSERT INTO `pos_setting` (`id`, `customer_id`, `warehouse_id`, `biller_id`, `product_number`, `keybord_active`, `is_table`, `send_sms`, `stripe_public_key`, `stripe_secret_key`, `paypal_live_api_username`, `paypal_live_api_password`, `paypal_live_api_secret`, `payment_options`, `invoice_option`, `thermal_invoice_size`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 2, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 'cash,card,cheque,gift_card,deposit,mobile_money,credit,insurance', 'thermal', '80', '2023-05-28 06:57:03', '2025-03-24 23:17:23');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `shelf` varchar(50) DEFAULT NULL,
  `max_product` int(11) NOT NULL DEFAULT 50,
  `shelf_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `barcode_symbology` varchar(255) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `retail_units_per_wholesale` double DEFAULT NULL COMMENT 'Number of retail units in one wholesale unit, e.g., 15 bottles per box',
  `cost` double NOT NULL,
  `wholesale_markup` double DEFAULT NULL COMMENT 'Markup percentage for wholesale price',
  `wholesale_price` double DEFAULT NULL COMMENT 'Price per wholesale unit (e.g., box)',
  `retail_markup` double DEFAULT NULL COMMENT 'Markup percentage for retail price',
  `price` double DEFAULT NULL COMMENT 'Price per retail unit (e.g., bottle)',
  `qty` double DEFAULT NULL,
  `alert_quantity` double DEFAULT NULL,
  `daily_sale_objective` double DEFAULT NULL,
  `promotion` tinyint(4) DEFAULT NULL,
  `promotion_price` varchar(255) DEFAULT NULL,
  `starting_date` date DEFAULT NULL,
  `last_date` date DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `tax_method` int(11) DEFAULT NULL,
  `image` longtext DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `is_embeded` tinyint(1) DEFAULT NULL,
  `is_variant` tinyint(1) DEFAULT NULL,
  `is_batch` tinyint(1) DEFAULT NULL,
  `is_diffPrice` tinyint(1) DEFAULT NULL,
  `is_imei` tinyint(1) DEFAULT NULL,
  `featured` tinyint(4) DEFAULT NULL,
  `product_list` varchar(255) DEFAULT NULL,
  `variant_list` varchar(255) DEFAULT NULL,
  `qty_list` varchar(255) DEFAULT NULL,
  `price_list` varchar(255) DEFAULT NULL,
  `product_details` text DEFAULT NULL,
  `variant_option` text DEFAULT NULL,
  `variant_value` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `shelf`, `max_product`, `shelf_id`, `name`, `code`, `type`, `barcode_symbology`, `brand_id`, `category_id`, `unit_id`, `purchase_unit_id`, `sale_unit_id`, `retail_units_per_wholesale`, `cost`, `wholesale_markup`, `wholesale_price`, `retail_markup`, `price`, `qty`, `alert_quantity`, `daily_sale_objective`, `promotion`, `promotion_price`, `starting_date`, `last_date`, `tax_id`, `tax_method`, `image`, `file`, `is_embeded`, `is_variant`, `is_batch`, `is_diffPrice`, `is_imei`, `featured`, `product_list`, `variant_list`, `qty_list`, `price_list`, `product_details`, `variant_option`, `variant_value`, `is_active`, `created_at`, `updated_at`) VALUES
(13, NULL, 50, 1, 'gebedol', '11021', 'standard', 'C128', 2, 2, 9, 9, 21, 12, 100, 10, 9.17, 20, 10, 120, 5, 10, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, 1, NULL, 1, 0, NULL, 1, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-25 17:56:52', '2025-03-25 18:32:06'),
(14, NULL, 50, NULL, 'Gastric Ulcer', '06342634', 'standard', 'C39', 3, 3, 9, 9, 7, 12, 200, 20, 20, 50, 25, 120, 150, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, 0, NULL, 1, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-25 18:21:13', '2025-03-26 09:28:56'),
(15, NULL, 50, NULL, 'Paracetamol', '79813673', 'standard', 'C128', 1, 2, 9, 9, 0, 1, 5, 0.01, 5, -0.01, 5, 56, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-26 08:42:36', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `product_adjustments`
--

CREATE TABLE `product_adjustments` (
  `id` int(10) UNSIGNED NOT NULL,
  `adjustment_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `unit_cost` double DEFAULT NULL,
  `qty` double NOT NULL,
  `action` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_batches`
--

CREATE TABLE `product_batches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `batch_no` varchar(255) NOT NULL,
  `expired_date` date NOT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_batches`
--

INSERT INTO `product_batches` (`id`, `product_id`, `batch_no`, `expired_date`, `qty`, `created_at`, `updated_at`) VALUES
(1, 14, '25-03-2025', '2026-03-25', 108, '2025-03-25 18:32:06', '2025-03-26 09:28:56'),
(2, 13, '25-03-2025', '2027-03-25', 120, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(3, 15, '7890', '2026-10-21', 56, '2025-03-26 08:49:20', '2025-03-26 09:22:57'),
(4, 14, '8097', '2025-03-28', 12, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_purchases`
--

CREATE TABLE `product_purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `recieved` double NOT NULL,
  `return_qty` double NOT NULL DEFAULT 0,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_purchases`
--

INSERT INTO `product_purchases` (`id`, `purchase_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `recieved`, `return_qty`, `purchase_unit_id`, `net_unit_cost`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL, NULL, 10, 10, 0, 1, 10, 0, 10, 10, 110, '2023-05-28 06:59:29', '2023-05-28 06:59:29'),
(2, 2, 14, 1, NULL, NULL, 10, 10, 0, 9, 200, 0, 0, 0, 2000, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(3, 2, 13, 2, NULL, NULL, 10, 10, 0, 9, 100, 0, 0, 0, 1000, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(4, 3, 15, 3, NULL, NULL, 60, 60, 0, 9, 5, 0, 10, 30, 330, '2025-03-26 08:49:20', '2025-03-26 08:49:20'),
(5, 4, 14, 4, NULL, NULL, 1, 1, 0, 9, 200, 0, 0, 0, 200, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_quotation`
--

CREATE TABLE `product_quotation` (
  `id` int(10) UNSIGNED NOT NULL,
  `quotation_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_returns`
--

CREATE TABLE `product_returns` (
  `id` int(10) UNSIGNED NOT NULL,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_returns`
--

INSERT INTO `product_returns` (`id`, `return_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `sale_unit_id`, `net_unit_price`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 14, 1, NULL, NULL, 1, 9, 1.63, 0, 0, 0, 1.63, '2025-03-26 09:28:56', '2025-03-26 09:28:56');

-- --------------------------------------------------------

--
-- Table structure for table `product_sales`
--

CREATE TABLE `product_sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `dosage` text NOT NULL,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `return_qty` double NOT NULL DEFAULT 0,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_delivered` tinyint(1) DEFAULT NULL,
  `is_packing` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_sales`
--

INSERT INTO `product_sales` (`id`, `dosage`, `sale_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `return_qty`, `sale_unit_id`, `net_unit_price`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`, `is_delivered`, `is_packing`) VALUES
(1, '', 1, 14, 1, NULL, 'null', 2, 1, 9, 1.63, 0, 0, 0, 3.26, '2025-03-25 18:42:47', '2025-03-26 09:28:56', NULL, NULL),
(2, '', 2, 14, 1, NULL, 'null', 1, 0, 9, 1.63, 0, 0, 0, 1.63, '2025-03-25 18:48:59', '2025-03-25 18:51:03', NULL, NULL),
(3, '', 3, 14, 1, NULL, 'null', 3, 0, 9, 1.63, 0, 0, 0, 4.89, '2025-03-26 02:29:39', '2025-03-26 02:29:39', NULL, NULL),
(4, '', 4, 14, 1, NULL, 'null', 80, 0, 9, 25, 0, 0, 0, 2000, '2025-03-26 08:51:58', '2025-03-26 08:51:58', NULL, NULL),
(5, '', 5, 14, 1, NULL, 'null', 10, 0, 9, 1.63, 0, 0, 0, 16.29, '2025-03-26 08:59:20', '2025-03-26 08:59:20', NULL, NULL),
(6, 'once daily', 6, 15, 3, NULL, 'null,null', 4, 0, 9, 0.33, 0, 0, 0, 1.3, '2025-03-26 09:22:57', '2025-03-26 09:22:57', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_transfer`
--

CREATE TABLE `product_transfer` (
  `id` int(10) UNSIGNED NOT NULL,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `item_code` varchar(255) NOT NULL,
  `additional_cost` double DEFAULT NULL,
  `additional_price` double DEFAULT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_warehouse`
--

CREATE TABLE `product_warehouse` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `qty` double NOT NULL,
  `price` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_warehouse`
--

INSERT INTO `product_warehouse` (`id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `warehouse_id`, `qty`, `price`, `created_at`, `updated_at`) VALUES
(1, '1', NULL, NULL, NULL, 1, 10, 20, '2023-05-28 06:59:29', '2023-05-28 07:00:57'),
(2, '14', 1, NULL, NULL, 1, 108, NULL, '2025-03-25 18:32:06', '2025-03-26 09:28:56'),
(3, '13', 2, NULL, NULL, 1, 120, NULL, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(4, '15', 3, NULL, NULL, 1, 56, NULL, '2025-03-26 08:49:20', '2025-03-26 09:22:57'),
(5, '14', 4, NULL, NULL, 1, 12, NULL, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` int(11) NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `paid_amount` double NOT NULL,
  `status` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `reference_no`, `user_id`, `warehouse_id`, `supplier_id`, `currency_id`, `exchange_rate`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_cost`, `order_tax_rate`, `order_tax`, `order_discount`, `shipping_cost`, `grand_total`, `paid_amount`, `status`, `payment_status`, `document`, `note`, `created_at`, `updated_at`) VALUES
(1, 'pr-20230528-125929', 1, 1, NULL, 1, 1, 1, 10, 0, 10, 110, 0, 0, 0, 0, 110, 0, 1, 1, NULL, NULL, '2023-05-28 06:59:29', '2023-05-28 06:59:29'),
(2, '1234', 2, 1, 1, 1, 0.06517, 2, 20, 0, 0, 3000, 10, 300, 0, 0, 3300, 0, 1, 1, NULL, NULL, '2025-03-25 00:00:00', '2025-03-25 18:32:06'),
(3, '56789', 3, 1, 1, 2, 100, 1, 60, 0, 30, 330, 10, 33, 0, 0, 363, 0, 1, 1, NULL, NULL, '2025-03-29 00:00:00', '2025-03-26 08:49:20'),
(4, '8789t9037', 1, 1, 1, 2, 1, 1, 1, 0, 0, 200, 0, 0, 0, 0, 200, 0, 1, 1, NULL, NULL, '2025-03-26 00:00:00', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_product_return`
--

CREATE TABLE `purchase_product_return` (
  `id` int(10) UNSIGNED NOT NULL,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

CREATE TABLE `quotations` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `quotation_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `refills`
--

CREATE TABLE `refills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `refill_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `warehouse_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refills`
--

INSERT INTO `refills` (`id`, `customer_id`, `created_at`, `refill_note`, `staff_note`, `updated_at`, `warehouse_id`) VALUES
(1, 3, '2025-03-26 01:37:34', NULL, NULL, '2025-03-26 01:37:34', 1);

-- --------------------------------------------------------

--
-- Table structure for table `refill_items`
--

CREATE TABLE `refill_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `refill_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `refill_interval` int(11) NOT NULL,
  `refill_unit` enum('days','weeks','months') NOT NULL,
  `refill_until` date NOT NULL,
  `next_refill_date` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refill_items`
--

INSERT INTO `refill_items` (`id`, `refill_id`, `product_id`, `quantity`, `refill_interval`, `refill_unit`, `refill_until`, `next_refill_date`, `created_at`, `updated_at`) VALUES
(1, 1, 14, 1, 2, 'months', '2025-04-06', NULL, '2025-03-26 01:37:34', '2025-03-26 01:37:34');

-- --------------------------------------------------------

--
-- Table structure for table `returns`
--

CREATE TABLE `returns` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `return_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `returns`
--

INSERT INTO `returns` (`id`, `reference_no`, `user_id`, `sale_id`, `cash_register_id`, `customer_id`, `warehouse_id`, `biller_id`, `account_id`, `currency_id`, `exchange_rate`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_price`, `order_tax_rate`, `order_tax`, `grand_total`, `document`, `return_note`, `staff_note`, `created_at`, `updated_at`) VALUES
(1, 'rr-20250326-092856', 1, 1, 1, 2, 1, 1, 1, 1, 0.06517, 1, 1, 0, 0, 1.63, 0, 0, 1.63, NULL, NULL, NULL, '2025-03-26 09:28:56', '2025-03-26 09:28:56');

-- --------------------------------------------------------

--
-- Table structure for table `return_purchases`
--

CREATE TABLE `return_purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `return_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reward_point_settings`
--

CREATE TABLE `reward_point_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `per_point_amount` double NOT NULL,
  `minimum_amount` double NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `guard_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `is_active`, `created_at`, `updated_at`, `guard_name`) VALUES
(1, 'Admin', 'Pharmacy administrator', 1, '2018-06-01 23:46:44', '2025-02-18 10:13:19', 'web'),
(2, 'Super Admin', 'GogoPlus Technical Support', 1, '2018-10-22 02:38:13', '2025-02-18 10:49:13', 'web'),
(5, 'Staff', 'Pharmacy Staff', 0, '2020-11-05 06:43:16', '2025-02-18 10:50:13', 'web'),
(7, 'Pharmacist', 'Pharnacist', 1, '2025-02-18 12:00:10', '2025-02-18 12:00:10', 'web');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(4, 1),
(4, 2),
(4, 5),
(4, 7),
(5, 1),
(5, 2),
(5, 5),
(5, 7),
(6, 1),
(6, 2),
(6, 5),
(6, 7),
(7, 1),
(7, 2),
(7, 5),
(7, 7),
(8, 1),
(8, 2),
(8, 5),
(8, 7),
(9, 1),
(9, 2),
(9, 5),
(9, 7),
(10, 1),
(10, 2),
(10, 5),
(10, 7),
(11, 1),
(11, 2),
(12, 1),
(12, 2),
(12, 5),
(12, 7),
(13, 1),
(13, 2),
(13, 5),
(13, 7),
(14, 1),
(14, 2),
(14, 5),
(15, 1),
(15, 2),
(16, 1),
(16, 2),
(16, 5),
(16, 7),
(17, 1),
(17, 2),
(17, 5),
(17, 7),
(18, 1),
(18, 2),
(18, 5),
(18, 7),
(19, 1),
(19, 2),
(20, 1),
(20, 2),
(20, 5),
(20, 7),
(21, 1),
(21, 2),
(21, 5),
(21, 7),
(22, 1),
(22, 2),
(22, 5),
(22, 7),
(23, 1),
(23, 2),
(24, 1),
(24, 2),
(24, 5),
(24, 7),
(25, 1),
(25, 2),
(25, 5),
(25, 7),
(26, 1),
(26, 2),
(26, 5),
(26, 7),
(27, 1),
(27, 2),
(28, 1),
(28, 2),
(28, 5),
(28, 7),
(29, 1),
(29, 2),
(29, 5),
(29, 7),
(30, 1),
(30, 2),
(30, 5),
(30, 7),
(31, 1),
(31, 2),
(32, 1),
(32, 2),
(32, 5),
(33, 1),
(33, 2),
(33, 5),
(34, 1),
(34, 2),
(34, 5),
(35, 1),
(35, 2),
(35, 5),
(36, 1),
(36, 2),
(36, 5),
(36, 7),
(37, 1),
(37, 2),
(37, 5),
(37, 7),
(38, 1),
(38, 2),
(38, 5),
(38, 7),
(39, 1),
(39, 2),
(39, 5),
(39, 7),
(40, 1),
(40, 2),
(40, 5),
(40, 7),
(41, 1),
(41, 2),
(41, 5),
(41, 7),
(42, 1),
(42, 2),
(42, 7),
(43, 1),
(43, 2),
(43, 7),
(44, 1),
(44, 2),
(45, 1),
(45, 2),
(45, 5),
(45, 7),
(46, 1),
(46, 2),
(46, 5),
(46, 7),
(47, 1),
(47, 2),
(47, 5),
(47, 7),
(48, 1),
(48, 2),
(48, 5),
(48, 7),
(49, 1),
(49, 2),
(49, 5),
(49, 7),
(50, 1),
(50, 2),
(50, 5),
(50, 7),
(51, 1),
(51, 2),
(51, 5),
(51, 7),
(52, 1),
(52, 2),
(52, 5),
(52, 7),
(53, 1),
(53, 2),
(53, 5),
(53, 7),
(54, 1),
(54, 2),
(54, 5),
(55, 1),
(55, 2),
(55, 5),
(55, 7),
(56, 1),
(56, 2),
(56, 5),
(56, 7),
(57, 1),
(57, 2),
(57, 5),
(57, 7),
(58, 1),
(58, 2),
(59, 2),
(59, 5),
(60, 2),
(61, 2),
(62, 1),
(62, 2),
(63, 1),
(63, 2),
(63, 5),
(63, 7),
(64, 1),
(64, 2),
(64, 5),
(64, 7),
(65, 1),
(65, 2),
(65, 5),
(65, 7),
(66, 1),
(66, 2),
(67, 1),
(67, 2),
(67, 5),
(68, 1),
(68, 2),
(69, 1),
(69, 2),
(69, 5),
(70, 1),
(70, 2),
(71, 1),
(71, 2),
(72, 1),
(72, 2),
(73, 1),
(73, 2),
(73, 5),
(74, 1),
(74, 2),
(75, 1),
(75, 2),
(76, 1),
(76, 2),
(77, 1),
(77, 2),
(77, 7),
(78, 1),
(78, 2),
(78, 5),
(78, 7),
(79, 1),
(79, 2),
(79, 5),
(79, 7),
(80, 2),
(81, 1),
(81, 2),
(81, 5),
(81, 7),
(82, 1),
(82, 2),
(83, 2),
(84, 1),
(84, 2),
(84, 5),
(84, 7),
(85, 1),
(85, 2),
(85, 5),
(85, 7),
(86, 1),
(86, 2),
(86, 5),
(87, 1),
(87, 2),
(87, 5),
(87, 7),
(88, 1),
(88, 2),
(88, 5),
(88, 7),
(89, 1),
(89, 2),
(90, 1),
(90, 2),
(90, 5),
(90, 7),
(91, 1),
(91, 2),
(92, 1),
(92, 2),
(92, 5),
(92, 7),
(93, 1),
(93, 2),
(93, 5),
(94, 1),
(94, 2),
(95, 1),
(95, 2),
(96, 1),
(96, 2),
(97, 1),
(97, 2),
(98, 1),
(98, 2),
(98, 5),
(98, 7),
(99, 1),
(99, 2),
(99, 5),
(99, 7),
(100, 1),
(100, 2),
(100, 5),
(100, 7),
(101, 1),
(101, 2),
(101, 5),
(101, 7),
(102, 1),
(102, 2),
(102, 5),
(102, 7),
(103, 1),
(103, 2),
(103, 5),
(103, 7),
(104, 2),
(105, 1),
(105, 2),
(105, 7),
(106, 1),
(106, 2),
(106, 5),
(106, 7),
(107, 1),
(107, 2),
(107, 5),
(107, 7),
(108, 1),
(108, 2),
(108, 5),
(108, 7),
(109, 1),
(109, 2),
(109, 5),
(109, 7),
(110, 1),
(110, 2),
(110, 5),
(110, 7),
(111, 1),
(111, 2),
(111, 5),
(111, 7),
(112, 1),
(112, 2),
(112, 5),
(112, 7),
(113, 1),
(113, 2),
(113, 5),
(113, 7),
(114, 1),
(114, 2),
(114, 5),
(114, 7),
(115, 1),
(115, 2),
(115, 5),
(115, 7),
(116, 1),
(116, 2),
(117, 1),
(117, 2),
(117, 5),
(117, 7),
(118, 1),
(118, 2),
(118, 5),
(118, 7),
(119, 1),
(119, 2),
(119, 5),
(120, 1),
(120, 2),
(121, 1),
(121, 2),
(121, 5),
(121, 7),
(122, 1),
(122, 2),
(122, 5),
(122, 7),
(123, 1),
(123, 2),
(123, 5),
(123, 7),
(124, 1),
(124, 2),
(124, 5),
(124, 7),
(125, 1),
(125, 2),
(125, 5),
(126, 2),
(126, 7),
(127, 1),
(127, 2),
(127, 5),
(128, 1),
(128, 2),
(128, 5),
(129, 1),
(129, 2),
(129, 5),
(130, 1),
(130, 2),
(131, 2),
(132, 1),
(132, 2),
(132, 5);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `queue` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `grand_total` double NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount_type` varchar(255) DEFAULT NULL,
  `order_discount_value` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `coupon_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `sale_status` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `sale_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `reference_no`, `user_id`, `cash_register_id`, `table_id`, `queue`, `customer_id`, `warehouse_id`, `biller_id`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_price`, `grand_total`, `currency_id`, `exchange_rate`, `order_tax_rate`, `order_tax`, `order_discount_type`, `order_discount_value`, `order_discount`, `coupon_id`, `coupon_discount`, `shipping_cost`, `sale_status`, `payment_status`, `document`, `paid_amount`, `sale_note`, `staff_note`, `created_at`, `updated_at`) VALUES
(1, 'posr-20250325-064247', 2, 2, NULL, NULL, 2, 1, 1, 1, 2, 0, 0, 3.26, 3.26, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 4, 4, NULL, 3.26, NULL, NULL, '2025-03-25 18:42:47', '2025-03-26 09:28:56'),
(2, '1234', 2, 2, NULL, NULL, 2, 1, 1, 1, 1, 0, 0, 1.63, 1.63, 1, 0.06517, 0, 0, 'Flat', 0, 0, NULL, NULL, 0, 1, 2, NULL, 0, NULL, NULL, '2025-03-25 18:51:03', '2025-03-25 18:51:03'),
(3, 'posr-20250326-022939', 3, 3, NULL, NULL, 1, 1, 1, 1, 3, 0, 0, 4.89, 4.89, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 3, 2, NULL, 0, NULL, NULL, '2025-03-26 02:29:39', '2025-03-26 02:29:39'),
(4, '67879', 3, 3, NULL, NULL, 3, 1, 1, 1, 80, 0, 0, 2000, 2000, 2, 100, 0, 0, 'Flat', NULL, 0, NULL, NULL, 0, 2, 1, NULL, 0, NULL, NULL, '2025-04-02 08:51:58', '2025-03-26 08:51:58'),
(5, '89089', 3, 3, NULL, NULL, 3, 1, 1, 1, 10, 0, 0, 16.29, 16.29, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, NULL, 0, 1, 3, NULL, 8, NULL, NULL, '2025-04-02 08:59:20', '2025-03-26 08:59:20'),
(6, 'posr-20250326-092257', 1, 1, NULL, NULL, 1, 1, 1, 1, 4, 0, 0, 1.3, 1.3, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 1, 4, NULL, 1.3, NULL, NULL, '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `sent_sms`
--

CREATE TABLE `sent_sms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'sent',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shelves`
--

CREATE TABLE `shelves` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shelves`
--

INSERT INTO `shelves` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'general', '2025-03-25 17:59:32', '2025-03-25 17:59:32'),
(3, 'stomach', '2025-03-25 18:21:57', '2025-03-25 18:21:57');

-- --------------------------------------------------------

--
-- Table structure for table `sms_templates`
--

CREATE TABLE `sms_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_default_ecommerce` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_counts`
--

CREATE TABLE `stock_counts` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `category_id` varchar(255) DEFAULT NULL,
  `brand_id` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `initial_file` varchar(255) DEFAULT NULL,
  `final_file` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_adjusted` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) NOT NULL,
  `vat_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `image`, `company_name`, `vat_number`, `email`, `phone_number`, `address`, `city`, `state`, `postal_code`, `country`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'John Doe', NULL, 'Test Company', NULL, 'john@gmail.com', '231312', 'Test address', 'Test City', NULL, NULL, NULL, 1, '2023-05-28 06:53:04', '2023-05-28 06:53:04');

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `number_of_person` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `name`, `rate`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'VAT 10%', 10, 1, '2023-05-28 06:52:08', '2023-05-28 06:52:08');

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `from_warehouse_id` int(11) NOT NULL,
  `to_warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_sent` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(10) UNSIGNED NOT NULL,
  `unit_code` varchar(255) NOT NULL,
  `unit_name` varchar(255) NOT NULL,
  `base_unit` int(11) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `operation_value` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_code`, `unit_name`, `base_unit`, `operator`, `operation_value`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'PIECE', 'PIECE', NULL, '*', 1, 1, '2023-05-28 06:51:50', '2025-02-04 17:06:26'),
(2, 'AMPOULE', 'AMPOULE', NULL, '*', 1, 1, '2025-02-04 17:07:04', '2025-02-04 17:07:04'),
(3, 'SACHET', 'SACHET', NULL, '*', 1, 1, '2025-02-04 17:07:20', '2025-02-04 17:07:20'),
(4, 'TAB', 'TAB', NULL, '*', 1, 1, '2025-02-04 17:07:31', '2025-02-04 17:07:31'),
(5, 'TUBE', 'TUBE', NULL, '*', 1, 1, '2025-02-04 17:07:42', '2025-02-04 17:07:42'),
(6, 'VIAL', 'VIAL', NULL, '*', 1, 1, '2025-02-04 17:07:56', '2025-02-04 17:07:56'),
(7, 'BOTTLE', 'BOTTLE', NULL, '*', 1, 1, '2025-02-04 17:08:09', '2025-02-04 17:08:09'),
(8, 'CAP', 'CAP', NULL, '*', 1, 1, '2025-02-04 17:08:24', '2025-02-04 17:08:24'),
(9, 'BOX', 'BOX', NULL, '*', 1, 1, '2025-02-04 17:08:35', '2025-02-04 17:08:35'),
(10, 'JAR', 'JAR', NULL, '*', 1, 1, '2025-02-04 17:08:46', '2025-02-04 17:08:46'),
(11, 'DROP', 'DROP', NULL, '*', 1, 1, '2025-02-04 17:08:57', '2025-02-04 17:08:57'),
(12, 'SINGLE', 'SINGLE', NULL, '*', 1, 1, '2025-02-04 17:09:10', '2025-02-04 17:09:10'),
(13, 'CAN', 'CAN', NULL, '*', 1, 1, '2025-02-04 17:09:21', '2025-02-04 17:09:21'),
(14, 'SUPP', 'SUPP', NULL, '*', 1, 1, '2025-02-04 17:09:35', '2025-02-04 17:09:35'),
(15, 'STRIP', 'STRIP', NULL, '*', 1, 1, '2025-02-04 17:09:52', '2025-02-04 17:09:52'),
(16, 'PESS', 'PESS', NULL, '*', 1, 1, '2025-02-04 17:10:04', '2025-02-04 17:10:04'),
(17, 'LOZENGES', 'LOZENGES', NULL, '*', 1, 1, '2025-02-04 17:10:24', '2025-02-04 17:10:24'),
(18, 'POUCH', 'POUCH', NULL, '*', 1, 1, '2025-02-04 17:10:39', '2025-02-04 17:10:39'),
(19, 'BAG', 'BAG', NULL, '*', 1, 1, '2025-02-04 17:10:49', '2025-02-04 17:10:49'),
(20, 'No Unit', 'No Unit', NULL, '*', 1, 1, '2025-02-04 17:11:30', '2025-02-04 17:11:30'),
(21, 'PACK', 'PACK', NULL, '*', 1, 1, '2025-02-04 17:15:31', '2025-02-04 17:15:31');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `phone`, `company_name`, `role_id`, `biller_id`, `warehouse_id`, `is_active`, `is_deleted`) VALUES
(1, 'intern', 'giftybuah@gmail.com', '$2y$10$gtlKmhPKO0iLrXVyhcTaQ.DlEgDX66LqhS0slYrNBpsqIOV6ZwATC', 'pEN60GwtkCZFKVT6tvmmCiYvHqvDX4znpKTdgDca9wxdfVmtbxRixIxH0RzJ', '2018-06-02 03:24:15', '2025-03-24 23:20:25', '0247118423', 'Intern Pharmacy', 2, NULL, NULL, 1, 0),
(2, 'iddrisu', 'iddrisu442g@gmail.com', '$2y$10$WwNSDcjyJzDoEFFC1s2MTuGx5UrmgBhj7iwNceFJqOTA6IgAB7QUe', NULL, '2025-03-24 20:36:04', '2025-03-24 23:15:12', '0550936771', 'Intern Pharmacy', 1, NULL, NULL, 1, 0),
(3, 'obed', 'ninsonobed5630@gmail.com', '$2y$10$vPfQAb2/onfHCkKOJzzbtOU1TtzRKEjldvuEzdgZPsGQZEPavXfGC', NULL, '2025-03-24 20:39:36', '2025-03-24 23:16:16', '0256422216', 'Intern Pharmacy', 1, NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `variants`
--

CREATE TABLE `variants` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `name`, `phone`, `email`, `address`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Shop', '9991111', NULL, 'Test address', 1, '2023-05-28 06:51:19', '2023-05-28 06:51:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `action_logs`
--
ALTER TABLE `action_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `action_id` (`action_id`);

--
-- Indexes for table `adjustments`
--
ALTER TABLE `adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `barcodes`
--
ALTER TABLE `barcodes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billers`
--
ALTER TABLE `billers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cash_registers`
--
ALTER TABLE `cash_registers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `challans`
--
ALTER TABLE `challans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `couriers`
--
ALTER TABLE `couriers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_groups`
--
ALTER TABLE `customer_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_fields`
--
ALTER TABLE `custom_fields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plans`
--
ALTER TABLE `discount_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plan_customers`
--
ALTER TABLE `discount_plan_customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plan_discounts`
--
ALTER TABLE `discount_plan_discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dso_alerts`
--
ALTER TABLE `dso_alerts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `external_services`
--
ALTER TABLE `external_services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gift_cards`
--
ALTER TABLE `gift_cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gift_card_recharges`
--
ALTER TABLE `gift_card_recharges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hrm_settings`
--
ALTER TABLE `hrm_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `incomes`
--
ALTER TABLE `incomes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `income_categories`
--
ALTER TABLE `income_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `insurance_provider`
--
ALTER TABLE `insurance_provider`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mail_settings`
--
ALTER TABLE `mail_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `money_transfers`
--
ALTER TABLE `money_transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `packing_slips`
--
ALTER TABLE `packing_slips`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packing_slip_products`
--
ALTER TABLE `packing_slip_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_cheque`
--
ALTER TABLE `payment_with_cheque`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_credit_card`
--
ALTER TABLE `payment_with_credit_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_gift_card`
--
ALTER TABLE `payment_with_gift_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_insurance`
--
ALTER TABLE `payment_with_insurance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_mobile_money`
--
ALTER TABLE `payment_with_mobile_money`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_paypal`
--
ALTER TABLE `payment_with_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payrolls`
--
ALTER TABLE `payrolls`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pos_setting`
--
ALTER TABLE `pos_setting`
  ADD UNIQUE KEY `pos_setting_id_unique` (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_batches`
--
ALTER TABLE `product_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_purchases`
--
ALTER TABLE `product_purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_quotation`
--
ALTER TABLE `product_quotation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_returns`
--
ALTER TABLE `product_returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_sales`
--
ALTER TABLE `product_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_transfer`
--
ALTER TABLE `product_transfer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_product_return`
--
ALTER TABLE `purchase_product_return`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quotations`
--
ALTER TABLE `quotations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refills`
--
ALTER TABLE `refills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refill_items`
--
ALTER TABLE `refill_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `refill_items_next_refill_date_index` (`next_refill_date`);

--
-- Indexes for table `returns`
--
ALTER TABLE `returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `return_purchases`
--
ALTER TABLE `return_purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reward_point_settings`
--
ALTER TABLE `reward_point_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sent_sms`
--
ALTER TABLE `sent_sms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sent_sms_customer_id_index` (`customer_id`),
  ADD KEY `sent_sms_phone_number_index` (`phone_number`);

--
-- Indexes for table `shelves`
--
ALTER TABLE `shelves`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shelves_name_index` (`name`);

--
-- Indexes for table `sms_templates`
--
ALTER TABLE `sms_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_counts`
--
ALTER TABLE `stock_counts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `variants`
--
ALTER TABLE `variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `action_logs`
--
ALTER TABLE `action_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `adjustments`
--
ALTER TABLE `adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `barcodes`
--
ALTER TABLE `barcodes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `billers`
--
ALTER TABLE `billers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cash_registers`
--
ALTER TABLE `cash_registers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `challans`
--
ALTER TABLE `challans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `couriers`
--
ALTER TABLE `couriers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customer_groups`
--
ALTER TABLE `customer_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `custom_fields`
--
ALTER TABLE `custom_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plans`
--
ALTER TABLE `discount_plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plan_customers`
--
ALTER TABLE `discount_plan_customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plan_discounts`
--
ALTER TABLE `discount_plan_discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dso_alerts`
--
ALTER TABLE `dso_alerts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `external_services`
--
ALTER TABLE `external_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `gift_cards`
--
ALTER TABLE `gift_cards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gift_card_recharges`
--
ALTER TABLE `gift_card_recharges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hrm_settings`
--
ALTER TABLE `hrm_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `incomes`
--
ALTER TABLE `incomes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `income_categories`
--
ALTER TABLE `income_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `insurance_provider`
--
ALTER TABLE `insurance_provider`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mail_settings`
--
ALTER TABLE `mail_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;

--
-- AUTO_INCREMENT for table `money_transfers`
--
ALTER TABLE `money_transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packing_slips`
--
ALTER TABLE `packing_slips`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packing_slip_products`
--
ALTER TABLE `packing_slip_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_with_cheque`
--
ALTER TABLE `payment_with_cheque`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_credit_card`
--
ALTER TABLE `payment_with_credit_card`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_gift_card`
--
ALTER TABLE `payment_with_gift_card`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_insurance`
--
ALTER TABLE `payment_with_insurance`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_mobile_money`
--
ALTER TABLE `payment_with_mobile_money`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payment_with_paypal`
--
ALTER TABLE `payment_with_paypal`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payrolls`
--
ALTER TABLE `payrolls`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_batches`
--
ALTER TABLE `product_batches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_purchases`
--
ALTER TABLE `product_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_quotation`
--
ALTER TABLE `product_quotation`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_returns`
--
ALTER TABLE `product_returns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_sales`
--
ALTER TABLE `product_sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product_transfer`
--
ALTER TABLE `product_transfer`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `purchase_product_return`
--
ALTER TABLE `purchase_product_return`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotations`
--
ALTER TABLE `quotations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `refills`
--
ALTER TABLE `refills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `refill_items`
--
ALTER TABLE `refill_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `returns`
--
ALTER TABLE `returns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `return_purchases`
--
ALTER TABLE `return_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reward_point_settings`
--
ALTER TABLE `reward_point_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sent_sms`
--
ALTER TABLE `sent_sms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shelves`
--
ALTER TABLE `shelves`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sms_templates`
--
ALTER TABLE `sms_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_counts`
--
ALTER TABLE `stock_counts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `variants`
--
ALTER TABLE `variants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Database: `pharmacy2`
--
CREATE DATABASE IF NOT EXISTS `pharmacy2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pharmacy2`;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_no` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `initial_balance` double DEFAULT NULL,
  `total_balance` double NOT NULL,
  `note` text DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'Bank Account',
  `parent_account_id` int(11) DEFAULT NULL,
  `is_payment` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `account_no`, `name`, `initial_balance`, `total_balance`, `note`, `is_default`, `is_active`, `created_at`, `updated_at`, `code`, `type`, `parent_account_id`, `is_payment`) VALUES
(1, '019912229', 'Sales Account', 0, 0, 'This is the default account.', 1, 1, '2023-02-05 07:12:15', '2023-02-05 07:12:15', NULL, 'Bank Account', NULL, 1),
(2, '0147852', 'idi', 10000, 10000, NULL, NULL, 1, '2025-03-26 07:58:20', '2025-03-26 07:58:20', NULL, 'Bank Account', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `action_logs`
--

CREATE TABLE `action_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `action_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `route` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `synced_at` timestamp NULL DEFAULT NULL,
  `pharmacy_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `adjustments`
--

CREATE TABLE `adjustments` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `total_qty` double NOT NULL,
  `item` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `employee_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `checkin` varchar(255) NOT NULL,
  `checkout` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `barcodes`
--

CREATE TABLE `barcodes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `width` double(22,4) DEFAULT NULL,
  `height` double(22,4) DEFAULT NULL,
  `paper_width` double(22,4) DEFAULT NULL,
  `paper_height` double(22,4) DEFAULT NULL,
  `top_margin` double(22,4) DEFAULT NULL,
  `left_margin` double(22,4) DEFAULT NULL,
  `row_distance` double(22,4) DEFAULT NULL,
  `col_distance` double(22,4) DEFAULT NULL,
  `stickers_in_one_row` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_continuous` tinyint(1) NOT NULL DEFAULT 0,
  `stickers_in_one_sheet` int(11) DEFAULT NULL,
  `is_custom` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barcodes`
--

INSERT INTO `barcodes` (`id`, `name`, `description`, `width`, `height`, `paper_width`, `paper_height`, `top_margin`, `left_margin`, `row_distance`, `col_distance`, `stickers_in_one_row`, `is_default`, `is_continuous`, `stickers_in_one_sheet`, `is_custom`, `created_at`, `updated_at`) VALUES
(1, '20 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 4\" x 1\", Labels per sheet: 20', 4.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.1250, 0.0000, 0.1875, 2, 0, 0, 20, NULL, NULL, NULL),
(2, '30 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2.625\" x 1\", Labels per sheet: 30', 2.6250, 1.0000, 8.5000, 11.0000, 0.5000, 0.1880, 0.0000, 0.1250, 3, 0, 0, 30, NULL, NULL, NULL),
(3, '32 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1.25\", Labels per sheet: 32', 2.0000, 1.2500, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 32, NULL, NULL, NULL),
(4, '40 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1\", Labels per sheet: 40', 2.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 40, NULL, NULL, NULL),
(5, '50 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 1.5\" x 1\", Labels per sheet: 50', 1.5000, 1.0000, 8.5000, 11.0000, 0.5000, 0.5000, 0.0000, 0.0000, 5, 0, 0, 50, NULL, NULL, NULL),
(6, 'Continuous Rolls - 31.75mm x 25.4mm', 'Label Size: 31.75mm x 25.4mm, Gap: 3.18mm', 1.2500, 1.0000, 1.2500, 0.0000, 0.1250, 0.0000, 0.1250, 0.0000, 1, 0, 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `billers`
--

CREATE TABLE `billers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) NOT NULL,
  `vat_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `billers`
--

INSERT INTO `billers` (`id`, `name`, `image`, `company_name`, `vat_number`, `email`, `phone_number`, `address`, `city`, `state`, `postal_code`, `country`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Biller', NULL, 'Test Company', NULL, 'test@gmail.com', '12312', 'Test address', 'Test City', NULL, NULL, NULL, 1, '2023-05-28 06:53:51', '2023-05-28 06:53:51');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `title`, `image`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Brand', NULL, 1, '2023-05-28 06:51:38', '2023-05-28 06:51:38'),
(2, 'GB Pharma Limited', NULL, 1, '2025-03-25 17:44:43', '2025-03-25 17:44:43'),
(3, 'letap', NULL, 1, '2025-03-25 18:18:26', '2025-03-25 18:18:26');

-- --------------------------------------------------------

--
-- Table structure for table `cash_registers`
--

CREATE TABLE `cash_registers` (
  `id` int(10) UNSIGNED NOT NULL,
  `cash_in_hand` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cash_registers`
--

INSERT INTO `cash_registers` (`id`, `cash_in_hand`, `user_id`, `warehouse_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 0, 1, 1, 1, '2025-03-24 21:08:52', '2025-03-24 21:08:52'),
(2, 100, 2, 1, 1, '2025-03-25 17:31:46', '2025-03-25 17:31:46'),
(3, 12, 3, 1, 1, '2025-03-26 01:01:11', '2025-03-26 01:01:11');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image`, `parent_id`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Category', NULL, NULL, 1, '2023-05-28 06:51:00', '2023-05-28 06:51:00'),
(2, 'pain killer', NULL, NULL, 1, '2025-03-25 17:51:01', '2025-03-25 17:51:01'),
(3, 'ulcer', NULL, NULL, 1, '2025-03-25 18:18:50', '2025-03-25 18:18:50');

-- --------------------------------------------------------

--
-- Table structure for table `challans`
--

CREATE TABLE `challans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `courier_id` int(11) NOT NULL,
  `packing_slip_list` longtext NOT NULL,
  `amount_list` longtext NOT NULL,
  `cash_list` longtext DEFAULT NULL,
  `online_payment_list` longtext DEFAULT NULL,
  `cheque_list` longtext DEFAULT NULL,
  `delivery_charge_list` longtext DEFAULT NULL,
  `status_list` longtext DEFAULT NULL,
  `closing_date` date DEFAULT NULL,
  `created_by_id` int(11) NOT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `minimum_amount` double DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `used` int(11) NOT NULL,
  `expired_date` date NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `couriers`
--

CREATE TABLE `couriers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `couriers`
--

INSERT INTO `couriers` (`id`, `name`, `phone_number`, `address`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'obed', '0550936582', 'dome', 1, '2025-03-25 18:56:49', '2025-03-25 18:56:49'),
(2, 'kofi', '0550934168', 'lapaz', 1, '2025-03-25 18:57:41', '2025-03-25 18:57:41');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `exchange_rate` double NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `code`, `exchange_rate`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'US Dollar', 'USD', 0.06517, 1, '2020-11-01 00:22:58', '2025-02-04 17:17:08'),
(2, 'GHANA CEDI', 'GHS', 1, 1, '2025-02-04 17:17:29', '2025-02-04 17:17:29');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `tax_no` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `points` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deposit` double DEFAULT NULL,
  `expense` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customer_group_id`, `user_id`, `name`, `company_name`, `email`, `phone_number`, `tax_no`, `address`, `city`, `state`, `postal_code`, `country`, `points`, `is_active`, `created_at`, `updated_at`, `deposit`, `expense`) VALUES
(1, 1, NULL, 'John Doe', 'Test Company', 'john@gmail.com', '231312', NULL, 'Test address', 'Test City', NULL, NULL, NULL, NULL, 1, '2023-05-28 06:53:04', '2023-05-28 06:53:04', NULL, NULL),
(2, 1, NULL, 'tahiru', NULL, 'tahiru@gmail.com', '0550936771', NULL, 'anyaa', 'accra', NULL, NULL, NULL, NULL, 1, '2025-03-25 16:59:54', '2025-03-25 16:59:54', NULL, NULL),
(3, 1, NULL, 'obed', NULL, 'oninson45@gmail.com', '0256422216', NULL, NULL, 'Amasaman', NULL, NULL, NULL, NULL, 1, '2025-03-26 01:30:48', '2025-03-26 01:30:48', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_groups`
--

CREATE TABLE `customer_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `percentage` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_groups`
--

INSERT INTO `customer_groups` (`id`, `name`, `percentage`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'General', '0', 1, '2023-05-28 06:51:29', '2023-05-28 06:51:29');

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

CREATE TABLE `custom_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `belongs_to` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `default_value` text DEFAULT NULL,
  `option_value` text DEFAULT NULL,
  `grid_value` int(11) NOT NULL,
  `is_table` tinyint(1) NOT NULL,
  `is_invoice` tinyint(1) NOT NULL,
  `is_required` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_disable` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `packing_slip_ids` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `courier_id` int(11) DEFAULT NULL,
  `address` text NOT NULL,
  `delivered_by` varchar(255) DEFAULT NULL,
  `recieved_by` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`id`, `reference_no`, `sale_id`, `packing_slip_ids`, `user_id`, `courier_id`, `address`, `delivered_by`, `recieved_by`, `file`, `note`, `status`, `created_at`, `updated_at`) VALUES
(1, 'dr-20250325-065125', 2, NULL, 2, 1, 'anyaa accra', NULL, NULL, NULL, NULL, '3', '2025-03-25 18:51:45', '2025-03-25 18:58:26');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` int(10) UNSIGNED NOT NULL,
  `amount` double NOT NULL,
  `customer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `applicable_for` varchar(255) NOT NULL,
  `product_list` longtext DEFAULT NULL,
  `valid_from` date NOT NULL,
  `valid_till` date NOT NULL,
  `type` varchar(255) NOT NULL,
  `value` double NOT NULL,
  `minimum_qty` double NOT NULL,
  `maximum_qty` double NOT NULL,
  `days` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plans`
--

CREATE TABLE `discount_plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plan_customers`
--

CREATE TABLE `discount_plan_customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `discount_plan_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plan_discounts`
--

CREATE TABLE `discount_plan_discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `discount_id` int(11) NOT NULL,
  `discount_plan_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dso_alerts`
--

CREATE TABLE `dso_alerts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_info` longtext NOT NULL,
  `number_of_products` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `department_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `staff_id` varchar(191) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `expense_category_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `reference_no`, `expense_category_id`, `warehouse_id`, `account_id`, `user_id`, `cash_register_id`, `amount`, `note`, `created_at`, `updated_at`) VALUES
(1, 'er-20250325-063857', 1, 1, 1, 2, 2, 100, NULL, '2025-03-25 00:00:00', '2025-03-25 18:38:57');

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `code`, `name`, `is_active`, `created_at`, `updated_at`) VALUES
(1, '74965071', 'transportation', 1, '2025-03-25 18:38:22', '2025-03-25 18:38:22');

-- --------------------------------------------------------

--
-- Table structure for table `external_services`
--

CREATE TABLE `external_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `details` longtext NOT NULL,
  `module_status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`module_status`)),
  `active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `external_services`
--

INSERT INTO `external_services` (`id`, `name`, `type`, `details`, `module_status`, `active`, `created_at`, `updated_at`) VALUES
(1, 'PayPal', 'payment', 'Client ID,Client Secret;abcd1234,wxyz5678', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(2, 'Stripe', 'payment', 'Public Key,Private Key;efgh1234,stuv5678', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(3, 'Razorpay', 'payment', 'Key,Secret;rzp_test_Y4MCcpHfZNU6rR,3Hr7SDqaZ0G5waN0jsLgsiLx', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(4, 'Paystack', 'payment', 'public_Key,Secret_Key;pk_test_e8d220b7463d64569f0053e78534f38e6b10cf4a,sk_test_6d62cb976e1e0ab43f1e48b2934b0dfc7f32a1fe', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(5, 'Mollie', 'payment', 'api_key;test_dHar4XY7LxsDOtmnkVtjNVWXLSlXsM', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(6, 'Xendit', 'payment', 'secret_key,callback_token;xnd_development_aKJVKYbc4lHkEjcCLzWLrBsKs6jF6nbM6WaCMfnJerP3JW57CLis553XNRdDU,YPZxND92Mt8tdXntTYIEkRX802onZ5OcdKBUzycebuqYvN4n', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(7, 'bkash', 'payment', 'Mode,app_key,app_secret,username,password;sandbox,0vWQuCRGiUX7EPVjQDr0EUAYtc,jcUNPBgbcqEDedNKdvE4G1cAK7D3hCjmJccNPZZBq96QIxxwAMEx,01770618567,D7DaC<*E*eG', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(8, 'sslcommerz', 'payment', 'appkey,appsecret;12341234,asdfa23423', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(9, 'Mpesa', 'payment', 'consumer_Key,consumer_Secret;fhfgkj,dtrddhd', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(10, 'Pesapal', 'payment', 'Mode,Consumer Key,Consumer Secret;sandbox,qkio1BGGYAXTu2JOfm7XSXNruoZsrqEW,osGQ364R49cXKeOYSpaOnT++rHs=', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `site_title` varchar(255) NOT NULL,
  `site_logo` varchar(255) DEFAULT NULL,
  `is_rtl` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `currency` varchar(255) NOT NULL,
  `package_id` int(11) DEFAULT NULL,
  `subscription_type` varchar(255) DEFAULT NULL,
  `staff_access` varchar(255) NOT NULL,
  `without_stock` varchar(255) NOT NULL DEFAULT 'no',
  `date_format` varchar(255) NOT NULL,
  `developed_by` varchar(255) DEFAULT NULL,
  `invoice_format` varchar(255) DEFAULT NULL,
  `decimal` int(11) DEFAULT 2,
  `state` int(11) DEFAULT NULL,
  `theme` varchar(255) NOT NULL,
  `modules` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `currency_position` varchar(255) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `expiry_type` varchar(255) NOT NULL DEFAULT 'days',
  `expiry_value` varchar(255) NOT NULL DEFAULT '0',
  `is_zatca` tinyint(1) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `vat_registration_number` varchar(255) DEFAULT NULL,
  `is_packing_slip` tinyint(1) NOT NULL DEFAULT 0,
  `sms_credit` bigint(20) UNSIGNED DEFAULT NULL,
  `pharmacy_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `site_title`, `site_logo`, `is_rtl`, `created_at`, `updated_at`, `currency`, `package_id`, `subscription_type`, `staff_access`, `without_stock`, `date_format`, `developed_by`, `invoice_format`, `decimal`, `state`, `theme`, `modules`, `currency_position`, `expiry_date`, `expiry_type`, `expiry_value`, `is_zatca`, `company_name`, `vat_registration_number`, `is_packing_slip`, `sms_credit`, `pharmacy_id`) VALUES
(1, 'GogoPlus POS', '20250202043823.png', 0, '2018-07-06 06:13:11', '2025-03-24 20:23:33', '1', 3, 'monthly', 'own', 'no', 'd/m/Y', 'GogoPlus Ltd.', 'standard', 2, 1, 'default.css', '', 'prefix', '2025-05-03', 'days', '0', NULL, NULL, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `gift_cards`
--

CREATE TABLE `gift_cards` (
  `id` int(10) UNSIGNED NOT NULL,
  `card_no` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `expense` double NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gift_card_recharges`
--

CREATE TABLE `gift_card_recharges` (
  `id` int(10) UNSIGNED NOT NULL,
  `gift_card_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `note` text DEFAULT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hrm_settings`
--

CREATE TABLE `hrm_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `checkin` varchar(255) NOT NULL,
  `checkout` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `incomes`
--

CREATE TABLE `incomes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `income_category_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `income_categories`
--

CREATE TABLE `income_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `insurance_provider`
--

CREATE TABLE `insurance_provider` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mail_settings`
--

CREATE TABLE `mail_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `driver` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `port` varchar(255) NOT NULL,
  `from_address` varchar(255) NOT NULL,
  `from_name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `encryption` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_02_17_060412_create_categories_table', 1),
(4, '2018_02_20_035727_create_brands_table', 1),
(5, '2018_02_25_100635_create_suppliers_table', 1),
(6, '2018_02_27_101619_create_warehouse_table', 1),
(7, '2018_03_03_040448_create_units_table', 1),
(8, '2018_03_04_041317_create_taxes_table', 1),
(9, '2018_03_10_061915_create_customer_groups_table', 1),
(10, '2018_03_10_090534_create_customers_table', 1),
(11, '2018_03_11_095547_create_billers_table', 1),
(12, '2018_04_05_054401_create_products_table', 1),
(13, '2018_04_06_133606_create_purchases_table', 1),
(14, '2018_04_06_154600_create_product_purchases_table', 1),
(15, '2018_04_06_154915_create_product_warhouse_table', 1),
(16, '2018_04_10_085927_create_sales_table', 1),
(17, '2018_04_10_090133_create_product_sales_table', 1),
(18, '2018_04_10_090254_create_payments_table', 1),
(19, '2018_04_10_090341_create_payment_with_cheque_table', 1),
(20, '2018_04_10_090509_create_payment_with_credit_card_table', 1),
(21, '2018_04_13_121436_create_quotation_table', 1),
(22, '2018_04_13_122324_create_product_quotation_table', 1),
(23, '2018_04_14_121802_create_transfers_table', 1),
(24, '2018_04_14_121913_create_product_transfer_table', 1),
(25, '2018_05_13_082847_add_payment_id_and_change_sale_id_to_payments_table', 1),
(26, '2018_05_13_090906_change_customer_id_to_payment_with_credit_card_table', 1),
(27, '2018_05_20_054532_create_adjustments_table', 1),
(28, '2018_05_20_054859_create_product_adjustments_table', 1),
(29, '2018_05_21_163419_create_returns_table', 1),
(30, '2018_05_21_163443_create_product_returns_table', 1),
(31, '2018_06_02_050905_create_roles_table', 1),
(32, '2018_06_02_073430_add_columns_to_users_table', 1),
(33, '2018_06_03_053738_create_permission_tables', 1),
(34, '2018_06_21_063736_create_pos_setting_table', 1),
(35, '2018_06_21_094155_add_user_id_to_sales_table', 1),
(36, '2018_06_21_101529_add_user_id_to_purchases_table', 1),
(37, '2018_06_21_103512_add_user_id_to_transfers_table', 1),
(38, '2018_06_23_061058_add_user_id_to_quotations_table', 1),
(39, '2018_06_23_082427_add_is_deleted_to_users_table', 1),
(40, '2018_06_25_043308_change_email_to_users_table', 1),
(41, '2018_07_06_115449_create_general_settings_table', 1),
(42, '2018_07_08_043944_create_languages_table', 1),
(43, '2018_07_11_102144_add_user_id_to_returns_table', 1),
(44, '2018_07_11_102334_add_user_id_to_payments_table', 1),
(45, '2018_07_22_130541_add_digital_to_products_table', 1),
(46, '2018_07_24_154250_create_deliveries_table', 1),
(47, '2018_08_16_053336_create_expense_categories_table', 1),
(48, '2018_08_17_115415_create_expenses_table', 1),
(49, '2018_08_18_050418_create_gift_cards_table', 1),
(50, '2018_08_19_063119_create_payment_with_gift_card_table', 1),
(51, '2018_08_25_042333_create_gift_card_recharges_table', 1),
(52, '2018_08_25_101354_add_deposit_expense_to_customers_table', 1),
(53, '2018_08_26_043801_create_deposits_table', 1),
(54, '2018_09_02_044042_add_keybord_active_to_pos_setting_table', 1),
(55, '2018_09_09_092713_create_payment_with_paypal_table', 1),
(56, '2018_09_10_051254_add_currency_to_general_settings_table', 1),
(57, '2018_10_22_084118_add_biller_and_store_id_to_users_table', 1),
(58, '2018_10_26_034927_create_coupons_table', 1),
(59, '2018_10_27_090857_add_coupon_to_sales_table', 1),
(60, '2018_11_07_070155_add_currency_position_to_general_settings_table', 1),
(61, '2018_11_19_094650_add_combo_to_products_table', 1),
(62, '2018_12_09_043712_create_accounts_table', 1),
(63, '2018_12_17_112253_add_is_default_to_accounts_table', 1),
(64, '2018_12_19_103941_add_account_id_to_payments_table', 1),
(65, '2018_12_20_065900_add_account_id_to_expenses_table', 1),
(66, '2018_12_20_082753_add_account_id_to_returns_table', 1),
(67, '2018_12_26_064330_create_return_purchases_table', 1),
(68, '2018_12_26_144708_create_purchase_product_return_table', 1),
(69, '2018_12_27_110018_create_departments_table', 1),
(70, '2018_12_30_054844_create_employees_table', 1),
(71, '2018_12_31_125210_create_payrolls_table', 1),
(72, '2018_12_31_150446_add_department_id_to_employees_table', 1),
(73, '2019_01_01_062708_add_user_id_to_expenses_table', 1),
(74, '2019_01_02_075644_create_hrm_settings_table', 1),
(75, '2019_01_02_090334_create_attendances_table', 1),
(76, '2019_01_27_160956_add_three_columns_to_general_settings_table', 1),
(77, '2019_02_15_183303_create_stock_counts_table', 1),
(78, '2019_02_17_101604_add_is_adjusted_to_stock_counts_table', 1),
(79, '2019_04_13_101707_add_tax_no_to_customers_table', 1),
(80, '2019_08_19_000000_create_failed_jobs_table', 1),
(81, '2019_10_14_111455_create_holidays_table', 1),
(82, '2019_11_13_145619_add_is_variant_to_products_table', 1),
(83, '2019_11_13_150206_create_product_variants_table', 1),
(84, '2019_11_13_153828_create_variants_table', 1),
(85, '2019_11_25_134041_add_qty_to_product_variants_table', 1),
(86, '2019_11_25_134922_add_variant_id_to_product_purchases_table', 1),
(87, '2019_11_25_145341_add_variant_id_to_product_warehouse_table', 1),
(88, '2019_11_29_182201_add_variant_id_to_product_sales_table', 1),
(89, '2019_12_04_121311_add_variant_id_to_product_quotation_table', 1),
(90, '2019_12_05_123802_add_variant_id_to_product_transfer_table', 1),
(91, '2019_12_08_114954_add_variant_id_to_product_returns_table', 1),
(92, '2019_12_08_203146_add_variant_id_to_purchase_product_return_table', 1),
(93, '2020_02_28_103340_create_money_transfers_table', 1),
(94, '2020_07_01_193151_add_image_to_categories_table', 1),
(95, '2020_09_26_130426_add_user_id_to_deliveries_table', 1),
(96, '2020_10_11_125457_create_cash_registers_table', 1),
(97, '2020_10_13_155019_add_cash_register_id_to_sales_table', 1),
(98, '2020_10_13_172624_add_cash_register_id_to_returns_table', 1),
(99, '2020_10_17_212338_add_cash_register_id_to_payments_table', 1),
(100, '2020_10_18_124200_add_cash_register_id_to_expenses_table', 1),
(101, '2020_10_21_121632_add_developed_by_to_general_settings_table', 1),
(102, '2020_10_30_135557_create_notifications_table', 1),
(103, '2020_11_01_044954_create_currencies_table', 1),
(104, '2020_11_01_140736_add_price_to_product_warehouse_table', 1),
(105, '2020_11_02_050633_add_is_diff_price_to_products_table', 1),
(106, '2020_11_09_055222_add_user_id_to_customers_table', 1),
(107, '2020_11_17_054806_add_invoice_format_to_general_settings_table', 1),
(108, '2021_02_10_074859_add_variant_id_to_product_adjustments_table', 1),
(109, '2021_03_07_093606_create_product_batches_table', 1),
(110, '2021_03_07_093759_add_product_batch_id_to_product_warehouse_table', 1),
(111, '2021_03_07_093900_add_product_batch_id_to_product_purchases_table', 1),
(112, '2021_03_11_132603_add_product_batch_id_to_product_sales_table', 1),
(113, '2021_03_25_125421_add_is_batch_to_products_table', 1),
(114, '2021_05_19_120127_add_product_batch_id_to_product_returns_table', 1),
(115, '2021_05_22_105611_add_product_batch_id_to_purchase_product_return_table', 1),
(116, '2021_05_23_124848_add_product_batch_id_to_product_transfer_table', 1),
(117, '2021_05_26_153106_add_product_batch_id_to_product_quotation_table', 1),
(118, '2021_06_08_213007_create_reward_point_settings_table', 1),
(119, '2021_06_16_104155_add_points_to_customers_table', 1),
(120, '2021_06_17_101057_add_used_points_to_payments_table', 1),
(121, '2021_07_06_132716_add_variant_list_to_products_table', 1),
(122, '2021_09_27_161141_add_is_imei_to_products_table', 1),
(123, '2021_09_28_170052_add_imei_number_to_product_warehouse_table', 1),
(124, '2021_09_28_170126_add_imei_number_to_product_purchases_table', 1),
(125, '2021_10_03_170652_add_imei_number_to_product_sales_table', 1),
(126, '2021_10_10_145214_add_imei_number_to_product_returns_table', 1),
(127, '2021_10_11_104504_add_imei_number_to_product_transfer_table', 1),
(128, '2021_10_12_160107_add_imei_number_to_purchase_product_return_table', 1),
(129, '2021_10_12_205146_add_is_rtl_to_general_settings_table', 1),
(130, '2022_01_13_191242_create_discount_plans_table', 1),
(131, '2022_01_14_174318_create_discount_plan_customers_table', 1),
(132, '2022_01_14_202439_create_discounts_table', 1),
(133, '2022_01_16_153506_create_discount_plan_discounts_table', 1),
(134, '2022_02_05_174210_add_order_discount_type_and_value_to_sales_table', 1),
(135, '2022_05_26_195506_add_daily_sale_objective_to_products_table', 1),
(136, '2022_05_28_104209_create_dso_alerts_table', 1),
(137, '2022_06_01_112100_add_is_embeded_to_products_table', 1),
(138, '2022_06_14_130505_add_sale_id_to_returns_table', 1),
(139, '2022_07_19_115504_add_variant_data_to_products_table', 1),
(140, '2022_07_25_194300_add_additional_cost_to_product_variants_table', 1),
(141, '2022_09_04_195610_add_purchase_id_to_return_purchases_table', 1),
(142, '2023_01_18_125040_alter_table_general_settings', 1),
(143, '2023_01_18_133701_alter_table_pos_setting', 1),
(144, '2023_01_25_145309_add_expiry_date_to_general_settings_table', 1),
(145, '2023_02_05_132001_add_change_to_payments_table', 1),
(146, '2023_02_23_125656_alter_table_sales', 1),
(147, '2023_02_26_124100_add_package_id_to_general_settings_table', 1),
(148, '2023_03_04_120325_create_custom_fields_table', 1),
(149, '2023_03_14_174658_add_subscription_type_to_general_setting_table', 1),
(150, '2023_03_22_174352_add_currency_id_and_exchange_rate_to_returns_table', 1),
(151, '2023_03_27_114320_add_currency_id_and_exchange_rate_to_purchases_table', 1),
(152, '2023_03_27_132747_add_currency_id_and_exchange_rate_to_return_purchases_table', 1),
(153, '2023_04_25_150236_create_mail_settings_table', 1),
(154, '2023_05_13_125424_add_zatca_to_general_settings_table', 1),
(155, '2023_05_28_155540_create_tables_table', 1),
(156, '2023_05_29_115039_add_is_table_to_pos_setting_table', 1),
(157, '2023_05_29_115301_add_table_id_to_sales_table', 1),
(158, '2023_05_31_165049_add_queue_no_to_sales_table', 1),
(159, '2023_07_23_160254_create_couriers_table', 1),
(160, '2023_07_23_174343_add_courier_id_to_deliveries_table', 1),
(161, '2023_08_12_124016_add_staff_id_to_employees_table', 1),
(162, '2023_08_14_142608_add_is_active_to_currencies_table', 1),
(163, '2023_08_24_130203_change_columns_to_attendances_table', 1),
(164, '2023_09_10_134503_add_without_stock_to_general_settings_table', 1),
(165, '2023_09_26_211542_add_modules_to_general_settings_table', 1),
(166, '2023_10_15_124306_add_return_qty_to_product_sales_table', 1),
(167, '2023_12_03_235606_crete_external_services_table', 1),
(168, '2024_02_04_131826_add_unit_cost_to_product_adjustments_table', 1),
(169, '2024_02_13_173126_change_modules_to_general_settings_table', 1),
(170, '2024_05_02_114215_add_payment_receiver_to_payments', 1),
(171, '2024_05_06_132553_create_sms_templates_table', 1),
(172, '2024_05_07_102225_add_send_sms_to_pos_setting_table', 1),
(173, '2024_05_07_132625_add_is_default_to_sms_templates_table', 1),
(174, '2024_05_08_112211_change_address_and_city_field_to_nullable_in_customers_table', 1),
(175, '2024_05_08_151050_add_is_default_ecommerce_columne_to_sms_templates_table', 1),
(176, '2024_05_20_182757_add_wholesale_price_to_products_table', 1),
(177, '2024_05_21_170500_add_is_sent_to_transfers_table', 1),
(178, '2024_06_04_225113_create_income_categories_table', 1),
(179, '2024_06_04_225128_create_incomes_table', 1),
(180, '2024_06_29_131917_add_is_packing_slip_to_general_settings_table', 1),
(181, '2024_07_05_192531_create_packing_slips_table', 1),
(182, '2024_07_05_193002_create_packing_slip_products_table', 1),
(183, '2024_07_05_194501_add_is_packing_and_delivered_to_product_sales_table', 1),
(184, '2024_07_14_122245_add_delivery_id_to_packing_slips_table', 1),
(185, '2024_07_14_122415_add_variant_id_to_packing_slip_products_table', 1),
(186, '2024_07_14_122519_add_packing_slip_ids_to_deliveries_table', 1),
(187, '2024_07_16_125908_create_challans_table', 1),
(188, '2024_08_12_112830_add_thermal_invoice_size_to_pos_setting', 1),
(189, '2024_08_14_133351_add_expiry_type_value_to_general_settings', 1),
(190, '2024_09_11_151744_add_return_qty_to_product_purchases_table', 1),
(191, '2024_09_12_162309_create_barcodes_table', 1),
(192, '2024_10_10_121312_add_data_to_payment_with_credit_card_table', 1),
(193, '2024_10_10_212501_alter_attendances_table', 1),
(194, '2024_10_10_213757_alter_attendances_table', 1),
(195, '2024_10_14_144917_change_column_to_nullable_to_payment_with_credit_card_table', 1),
(196, '2024_11_10_121521_add_code_and_type_to_accounts_table', 1),
(197, '2024_11_24_100926_add_module_status_to_external_services_table', 1),
(198, '2025_03_09_000000_create_insurance_provider_table', 1),
(199, '2025_03_09_000001_create_payment_with_insurance_table', 1),
(200, '2025_03_09_000002_create_refills_table', 1),
(201, '2025_03_09_000003_create_refill_items_table', 1),
(202, '2025_03_09_000004_add_columns_to_products_table', 1),
(203, '2025_03_09_000005_add_dosage_to_product_sales_table', 1),
(204, '2025_03_09_000006_create_shelves_table', 1),
(205, '2025_03_12_000007_update_products_table_with_markups_and_units', 1),
(206, '2025_03_24_000000_create_payment_with_mobile_money_table', 1),
(207, '2025_03_24_000001_create_sent_sms_table', 1),
(208, '2025_03_24_000002_add_next_refill_date_to_refill_items_table', 1),
(209, '2025_03_24_000003_add_sms_credit_to_general_settings_table', 1),
(210, '2025_03_24_000004_add_customer_name_and_expiry_to_payment_with_insurance_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `money_transfers`
--

CREATE TABLE `money_transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `from_account_id` int(11) NOT NULL,
  `to_account_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `packing_slips`
--

CREATE TABLE `packing_slips` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `delivery_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `packing_slip_products`
--

CREATE TABLE `packing_slip_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `packing_slip_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `payment_receiver` varchar(255) DEFAULT NULL,
  `payment_reference` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `used_points` double DEFAULT NULL,
  `change` double DEFAULT NULL,
  `paying_method` varchar(255) NOT NULL,
  `payment_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `purchase_id`, `sale_id`, `cash_register_id`, `account_id`, `payment_receiver`, `payment_reference`, `user_id`, `amount`, `used_points`, `change`, `paying_method`, `payment_note`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 2, 1, 'iddrisu', 'spr-20250325-064247', 2, 3.26, NULL, 1.74, 'Cash', NULL, '2025-03-25 18:42:47', '2025-03-25 18:42:47'),
(2, NULL, 2, 2, 1, 'iddrisu', 'spr-20250325-065012', 2, 0, NULL, 2, 'Cash', NULL, '2025-03-25 18:50:12', '2025-03-25 18:50:12'),
(3, NULL, 5, 3, 1, NULL, 'spr-20250326-085920', 3, 8, NULL, 21, 'Cash', NULL, '2025-03-26 08:59:20', '2025-03-26 08:59:20'),
(4, NULL, 6, 1, 1, 'intern', 'spr-20250326-092257', 1, 1.3, NULL, 0, 'Mobile Money', NULL, '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_cheque`
--

CREATE TABLE `payment_with_cheque` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `cheque_no` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_credit_card`
--

CREATE TABLE `payment_with_credit_card` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_stripe_id` varchar(255) DEFAULT NULL,
  `charge_id` varchar(255) NOT NULL,
  `data` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_gift_card`
--

CREATE TABLE `payment_with_gift_card` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `gift_card_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_insurance`
--

CREATE TABLE `payment_with_insurance` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_insurance_id` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  `insurer` varchar(255) NOT NULL,
  `insurance_policy_id` varchar(255) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `approved_amount` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_mobile_money`
--

CREATE TABLE `payment_with_mobile_money` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `network` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_with_mobile_money`
--

INSERT INTO `payment_with_mobile_money` (`id`, `payment_id`, `customer_id`, `phone_number`, `reference`, `network`, `created_at`, `updated_at`) VALUES
(1, 4, 1, '0247118423', '48907553128655', 'MTN', '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_paypal`
--

CREATE TABLE `payment_with_paypal` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payrolls`
--

CREATE TABLE `payrolls` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `paying_method` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(4, 'products-edit', 'web', '2018-06-03 01:00:09', '2018-06-03 01:00:09'),
(5, 'products-delete', 'web', '2018-06-03 22:54:22', '2018-06-03 22:54:22'),
(6, 'products-add', 'web', '2018-06-04 00:34:14', '2018-06-04 00:34:14'),
(7, 'products-index', 'web', '2018-06-04 03:34:27', '2018-06-04 03:34:27'),
(8, 'purchases-index', 'web', '2018-06-04 08:03:19', '2018-06-04 08:03:19'),
(9, 'purchases-add', 'web', '2018-06-04 08:12:25', '2018-06-04 08:12:25'),
(10, 'purchases-edit', 'web', '2018-06-04 09:47:36', '2018-06-04 09:47:36'),
(11, 'purchases-delete', 'web', '2018-06-04 09:47:36', '2018-06-04 09:47:36'),
(12, 'sales-index', 'web', '2018-06-04 10:49:08', '2018-06-04 10:49:08'),
(13, 'sales-add', 'web', '2018-06-04 10:49:52', '2018-06-04 10:49:52'),
(14, 'sales-edit', 'web', '2018-06-04 10:49:52', '2018-06-04 10:49:52'),
(15, 'sales-delete', 'web', '2018-06-04 10:49:53', '2018-06-04 10:49:53'),
(16, 'quotes-index', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(17, 'quotes-add', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(18, 'quotes-edit', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(19, 'quotes-delete', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(20, 'transfers-index', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(21, 'transfers-add', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(22, 'transfers-edit', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(23, 'transfers-delete', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(24, 'returns-index', 'web', '2018-06-04 22:50:24', '2018-06-04 22:50:24'),
(25, 'returns-add', 'web', '2018-06-04 22:50:24', '2018-06-04 22:50:24'),
(26, 'returns-edit', 'web', '2018-06-04 22:50:25', '2018-06-04 22:50:25'),
(27, 'returns-delete', 'web', '2018-06-04 22:50:25', '2018-06-04 22:50:25'),
(28, 'customers-index', 'web', '2018-06-04 23:15:54', '2018-06-04 23:15:54'),
(29, 'customers-add', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(30, 'customers-edit', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(31, 'customers-delete', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(32, 'suppliers-index', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(33, 'suppliers-add', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(34, 'suppliers-edit', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(35, 'suppliers-delete', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(36, 'product-report', 'web', '2018-06-24 23:05:33', '2018-06-24 23:05:33'),
(37, 'purchase-report', 'web', '2018-06-24 23:24:56', '2018-06-24 23:24:56'),
(38, 'sale-report', 'web', '2018-06-24 23:33:13', '2018-06-24 23:33:13'),
(39, 'customer-report', 'web', '2018-06-24 23:36:51', '2018-06-24 23:36:51'),
(40, 'due-report', 'web', '2018-06-24 23:39:52', '2018-06-24 23:39:52'),
(41, 'users-index', 'web', '2018-06-25 00:00:10', '2018-06-25 00:00:10'),
(42, 'users-add', 'web', '2018-06-25 00:00:10', '2018-06-25 00:00:10'),
(43, 'users-edit', 'web', '2018-06-25 00:01:30', '2018-06-25 00:01:30'),
(44, 'users-delete', 'web', '2018-06-25 00:01:30', '2018-06-25 00:01:30'),
(45, 'profit-loss', 'web', '2018-07-14 21:50:05', '2018-07-14 21:50:05'),
(46, 'best-seller', 'web', '2018-07-14 22:01:38', '2018-07-14 22:01:38'),
(47, 'daily-sale', 'web', '2018-07-14 22:24:21', '2018-07-14 22:24:21'),
(48, 'monthly-sale', 'web', '2018-07-14 22:30:41', '2018-07-14 22:30:41'),
(49, 'daily-purchase', 'web', '2018-07-14 22:36:46', '2018-07-14 22:36:46'),
(50, 'monthly-purchase', 'web', '2018-07-14 22:48:17', '2018-07-14 22:48:17'),
(51, 'payment-report', 'web', '2018-07-14 23:10:41', '2018-07-14 23:10:41'),
(52, 'warehouse-stock-report', 'web', '2018-07-14 23:16:55', '2018-07-14 23:16:55'),
(53, 'product-qty-alert', 'web', '2018-07-14 23:33:21', '2018-07-14 23:33:21'),
(54, 'supplier-report', 'web', '2018-07-30 03:00:01', '2018-07-30 03:00:01'),
(55, 'expenses-index', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(56, 'expenses-add', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(57, 'expenses-edit', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(58, 'expenses-delete', 'web', '2018-09-05 01:07:11', '2018-09-05 01:07:11'),
(59, 'general_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(60, 'mail_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(61, 'pos_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(62, 'hrm_setting', 'web', '2019-01-02 10:30:23', '2019-01-02 10:30:23'),
(63, 'purchase-return-index', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(64, 'purchase-return-add', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(65, 'purchase-return-edit', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(66, 'purchase-return-delete', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(67, 'account-index', 'web', '2019-01-02 22:06:13', '2019-01-02 22:06:13'),
(68, 'balance-sheet', 'web', '2019-01-02 22:06:14', '2019-01-02 22:06:14'),
(69, 'account-statement', 'web', '2019-01-02 22:06:14', '2019-01-02 22:06:14'),
(70, 'department', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(71, 'attendance', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(72, 'payroll', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(73, 'employees-index', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(74, 'employees-add', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(75, 'employees-edit', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(76, 'employees-delete', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(77, 'user-report', 'web', '2019-01-16 06:48:18', '2019-01-16 06:48:18'),
(78, 'stock_count', 'web', '2019-02-17 10:32:01', '2019-02-17 10:32:01'),
(79, 'adjustment', 'web', '2019-02-17 10:32:02', '2019-02-17 10:32:02'),
(80, 'sms_setting', 'web', '2019-02-22 05:18:03', '2019-02-22 05:18:03'),
(81, 'create_sms', 'web', '2019-02-22 05:18:03', '2019-02-22 05:18:03'),
(82, 'print_barcode', 'web', '2019-03-07 05:02:19', '2019-03-07 05:02:19'),
(83, 'empty_database', 'web', '2019-03-07 05:02:19', '2019-03-07 05:02:19'),
(84, 'customer_group', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(85, 'unit', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(86, 'tax', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(87, 'gift_card', 'web', '2019-03-07 06:29:38', '2019-03-07 06:29:38'),
(88, 'coupon', 'web', '2019-03-07 06:29:38', '2019-03-07 06:29:38'),
(89, 'holiday', 'web', '2019-10-19 08:57:15', '2019-10-19 08:57:15'),
(90, 'warehouse-report', 'web', '2019-10-22 06:00:23', '2019-10-22 06:00:23'),
(91, 'warehouse', 'web', '2020-02-26 06:47:32', '2020-02-26 06:47:32'),
(92, 'brand', 'web', '2020-02-26 06:59:59', '2020-02-26 06:59:59'),
(93, 'billers-index', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(94, 'billers-add', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(95, 'billers-edit', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(96, 'billers-delete', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(97, 'money-transfer', 'web', '2020-03-02 05:41:48', '2020-03-02 05:41:48'),
(98, 'category', 'web', '2020-07-13 12:13:16', '2020-07-13 12:13:16'),
(99, 'delivery', 'web', '2020-07-13 12:13:16', '2020-07-13 12:13:16'),
(100, 'send_notification', 'web', '2020-10-31 06:21:31', '2020-10-31 06:21:31'),
(101, 'today_sale', 'web', '2020-10-31 06:57:04', '2020-10-31 06:57:04'),
(102, 'today_profit', 'web', '2020-10-31 06:57:04', '2020-10-31 06:57:04'),
(103, 'currency', 'web', '2020-11-09 00:23:11', '2020-11-09 00:23:11'),
(104, 'backup_database', 'web', '2020-11-15 00:16:55', '2020-11-15 00:16:55'),
(105, 'reward_point_setting', 'web', '2021-06-27 04:34:42', '2021-06-27 04:34:42'),
(106, 'revenue_profit_summary', 'web', '2022-02-08 13:57:21', '2022-02-08 13:57:21'),
(107, 'cash_flow', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(108, 'monthly_summary', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(109, 'yearly_report', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(110, 'discount_plan', 'web', '2022-02-16 09:12:26', '2022-02-16 09:12:26'),
(111, 'discount', 'web', '2022-02-16 09:12:38', '2022-02-16 09:12:38'),
(112, 'product-expiry-report', 'web', '2022-03-30 05:39:20', '2022-03-30 05:39:20'),
(113, 'purchase-payment-index', 'web', '2022-06-05 14:12:27', '2022-06-05 14:12:27'),
(114, 'purchase-payment-add', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(115, 'purchase-payment-edit', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(116, 'purchase-payment-delete', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(117, 'sale-payment-index', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(118, 'sale-payment-add', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(119, 'sale-payment-edit', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(120, 'sale-payment-delete', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(121, 'all_notification', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(122, 'sale-report-chart', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(123, 'dso-report', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(124, 'product_history', 'web', '2022-08-25 14:04:05', '2022-08-25 14:04:05'),
(125, 'supplier-due-report', 'web', '2022-08-31 09:46:33', '2022-08-31 09:46:33'),
(126, 'custom_field', 'web', '2023-11-13 06:23:34', '2023-11-13 06:23:34'),
(127, 'incomes-index', 'web', '2024-07-11 13:16:43', '2024-07-11 13:16:43'),
(128, 'incomes-add', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(129, 'incomes-edit', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(130, 'incomes-delete', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(131, 'packing_slip_challan', 'web', '2024-07-22 14:16:17', '2024-07-22 14:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `pos_setting`
--

CREATE TABLE `pos_setting` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `product_number` int(11) NOT NULL,
  `keybord_active` tinyint(1) NOT NULL,
  `is_table` tinyint(1) NOT NULL DEFAULT 0,
  `send_sms` tinyint(1) NOT NULL DEFAULT 0,
  `stripe_public_key` varchar(255) DEFAULT NULL,
  `stripe_secret_key` varchar(255) DEFAULT NULL,
  `paypal_live_api_username` varchar(255) DEFAULT NULL,
  `paypal_live_api_password` varchar(255) DEFAULT NULL,
  `paypal_live_api_secret` varchar(255) DEFAULT NULL,
  `payment_options` text DEFAULT NULL,
  `invoice_option` varchar(10) DEFAULT NULL,
  `thermal_invoice_size` varchar(255) NOT NULL DEFAULT '80',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pos_setting`
--

INSERT INTO `pos_setting` (`id`, `customer_id`, `warehouse_id`, `biller_id`, `product_number`, `keybord_active`, `is_table`, `send_sms`, `stripe_public_key`, `stripe_secret_key`, `paypal_live_api_username`, `paypal_live_api_password`, `paypal_live_api_secret`, `payment_options`, `invoice_option`, `thermal_invoice_size`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 2, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 'cash,card,cheque,gift_card,deposit,mobile_money,credit,insurance', 'thermal', '80', '2023-05-28 06:57:03', '2025-03-24 23:17:23');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `shelf` varchar(50) DEFAULT NULL,
  `max_product` int(11) NOT NULL DEFAULT 50,
  `shelf_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `barcode_symbology` varchar(255) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `retail_units_per_wholesale` double DEFAULT NULL COMMENT 'Number of retail units in one wholesale unit, e.g., 15 bottles per box',
  `cost` double NOT NULL,
  `wholesale_markup` double DEFAULT NULL COMMENT 'Markup percentage for wholesale price',
  `wholesale_price` double DEFAULT NULL COMMENT 'Price per wholesale unit (e.g., box)',
  `retail_markup` double DEFAULT NULL COMMENT 'Markup percentage for retail price',
  `price` double DEFAULT NULL COMMENT 'Price per retail unit (e.g., bottle)',
  `qty` double DEFAULT NULL,
  `alert_quantity` double DEFAULT NULL,
  `daily_sale_objective` double DEFAULT NULL,
  `promotion` tinyint(4) DEFAULT NULL,
  `promotion_price` varchar(255) DEFAULT NULL,
  `starting_date` date DEFAULT NULL,
  `last_date` date DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `tax_method` int(11) DEFAULT NULL,
  `image` longtext DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `is_embeded` tinyint(1) DEFAULT NULL,
  `is_variant` tinyint(1) DEFAULT NULL,
  `is_batch` tinyint(1) DEFAULT NULL,
  `is_diffPrice` tinyint(1) DEFAULT NULL,
  `is_imei` tinyint(1) DEFAULT NULL,
  `featured` tinyint(4) DEFAULT NULL,
  `product_list` varchar(255) DEFAULT NULL,
  `variant_list` varchar(255) DEFAULT NULL,
  `qty_list` varchar(255) DEFAULT NULL,
  `price_list` varchar(255) DEFAULT NULL,
  `product_details` text DEFAULT NULL,
  `variant_option` text DEFAULT NULL,
  `variant_value` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `shelf`, `max_product`, `shelf_id`, `name`, `code`, `type`, `barcode_symbology`, `brand_id`, `category_id`, `unit_id`, `purchase_unit_id`, `sale_unit_id`, `retail_units_per_wholesale`, `cost`, `wholesale_markup`, `wholesale_price`, `retail_markup`, `price`, `qty`, `alert_quantity`, `daily_sale_objective`, `promotion`, `promotion_price`, `starting_date`, `last_date`, `tax_id`, `tax_method`, `image`, `file`, `is_embeded`, `is_variant`, `is_batch`, `is_diffPrice`, `is_imei`, `featured`, `product_list`, `variant_list`, `qty_list`, `price_list`, `product_details`, `variant_option`, `variant_value`, `is_active`, `created_at`, `updated_at`) VALUES
(13, NULL, 50, 1, 'gebedol', '11021', 'standard', 'C128', 2, 2, 9, 9, 21, 12, 100, 10, 9.17, 20, 10, 120, 5, 10, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, 1, NULL, 1, 0, NULL, 1, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-25 17:56:52', '2025-03-25 18:32:06'),
(14, NULL, 50, NULL, 'Gastric Ulcer', '06342634', 'standard', 'C39', 3, 3, 9, 9, 7, 12, 200, 20, 20, 50, 25, 120, 150, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, 0, NULL, 1, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-25 18:21:13', '2025-03-26 09:28:56'),
(15, NULL, 50, NULL, 'Paracetamol', '79813673', 'standard', 'C128', 1, 2, 9, 9, 0, 1, 5, 0.01, 5, -0.01, 5, 56, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-26 08:42:36', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `product_adjustments`
--

CREATE TABLE `product_adjustments` (
  `id` int(10) UNSIGNED NOT NULL,
  `adjustment_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `unit_cost` double DEFAULT NULL,
  `qty` double NOT NULL,
  `action` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_batches`
--

CREATE TABLE `product_batches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `batch_no` varchar(255) NOT NULL,
  `expired_date` date NOT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_batches`
--

INSERT INTO `product_batches` (`id`, `product_id`, `batch_no`, `expired_date`, `qty`, `created_at`, `updated_at`) VALUES
(1, 14, '25-03-2025', '2026-03-25', 108, '2025-03-25 18:32:06', '2025-03-26 09:28:56'),
(2, 13, '25-03-2025', '2027-03-25', 120, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(3, 15, '7890', '2026-10-21', 56, '2025-03-26 08:49:20', '2025-03-26 09:22:57'),
(4, 14, '8097', '2025-03-28', 12, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_purchases`
--

CREATE TABLE `product_purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `recieved` double NOT NULL,
  `return_qty` double NOT NULL DEFAULT 0,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_purchases`
--

INSERT INTO `product_purchases` (`id`, `purchase_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `recieved`, `return_qty`, `purchase_unit_id`, `net_unit_cost`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL, NULL, 10, 10, 0, 1, 10, 0, 10, 10, 110, '2023-05-28 06:59:29', '2023-05-28 06:59:29'),
(2, 2, 14, 1, NULL, NULL, 10, 10, 0, 9, 200, 0, 0, 0, 2000, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(3, 2, 13, 2, NULL, NULL, 10, 10, 0, 9, 100, 0, 0, 0, 1000, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(4, 3, 15, 3, NULL, NULL, 60, 60, 0, 9, 5, 0, 10, 30, 330, '2025-03-26 08:49:20', '2025-03-26 08:49:20'),
(5, 4, 14, 4, NULL, NULL, 1, 1, 0, 9, 200, 0, 0, 0, 200, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_quotation`
--

CREATE TABLE `product_quotation` (
  `id` int(10) UNSIGNED NOT NULL,
  `quotation_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_returns`
--

CREATE TABLE `product_returns` (
  `id` int(10) UNSIGNED NOT NULL,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_returns`
--

INSERT INTO `product_returns` (`id`, `return_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `sale_unit_id`, `net_unit_price`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 14, 1, NULL, NULL, 1, 9, 1.63, 0, 0, 0, 1.63, '2025-03-26 09:28:56', '2025-03-26 09:28:56');

-- --------------------------------------------------------

--
-- Table structure for table `product_sales`
--

CREATE TABLE `product_sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `dosage` text NOT NULL,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `return_qty` double NOT NULL DEFAULT 0,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_delivered` tinyint(1) DEFAULT NULL,
  `is_packing` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_sales`
--

INSERT INTO `product_sales` (`id`, `dosage`, `sale_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `return_qty`, `sale_unit_id`, `net_unit_price`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`, `is_delivered`, `is_packing`) VALUES
(1, '', 1, 14, 1, NULL, 'null', 2, 1, 9, 1.63, 0, 0, 0, 3.26, '2025-03-25 18:42:47', '2025-03-26 09:28:56', NULL, NULL),
(2, '', 2, 14, 1, NULL, 'null', 1, 0, 9, 1.63, 0, 0, 0, 1.63, '2025-03-25 18:48:59', '2025-03-25 18:51:03', NULL, NULL),
(3, '', 3, 14, 1, NULL, 'null', 3, 0, 9, 1.63, 0, 0, 0, 4.89, '2025-03-26 02:29:39', '2025-03-26 02:29:39', NULL, NULL),
(4, '', 4, 14, 1, NULL, 'null', 80, 0, 9, 25, 0, 0, 0, 2000, '2025-03-26 08:51:58', '2025-03-26 08:51:58', NULL, NULL),
(5, '', 5, 14, 1, NULL, 'null', 10, 0, 9, 1.63, 0, 0, 0, 16.29, '2025-03-26 08:59:20', '2025-03-26 08:59:20', NULL, NULL),
(6, 'once daily', 6, 15, 3, NULL, 'null,null', 4, 0, 9, 0.33, 0, 0, 0, 1.3, '2025-03-26 09:22:57', '2025-03-26 09:22:57', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_transfer`
--

CREATE TABLE `product_transfer` (
  `id` int(10) UNSIGNED NOT NULL,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `item_code` varchar(255) NOT NULL,
  `additional_cost` double DEFAULT NULL,
  `additional_price` double DEFAULT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_warehouse`
--

CREATE TABLE `product_warehouse` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `qty` double NOT NULL,
  `price` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_warehouse`
--

INSERT INTO `product_warehouse` (`id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `warehouse_id`, `qty`, `price`, `created_at`, `updated_at`) VALUES
(1, '1', NULL, NULL, NULL, 1, 10, 20, '2023-05-28 06:59:29', '2023-05-28 07:00:57'),
(2, '14', 1, NULL, NULL, 1, 108, NULL, '2025-03-25 18:32:06', '2025-03-26 09:28:56'),
(3, '13', 2, NULL, NULL, 1, 120, NULL, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(4, '15', 3, NULL, NULL, 1, 56, NULL, '2025-03-26 08:49:20', '2025-03-26 09:22:57'),
(5, '14', 4, NULL, NULL, 1, 12, NULL, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` int(11) NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `paid_amount` double NOT NULL,
  `status` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `reference_no`, `user_id`, `warehouse_id`, `supplier_id`, `currency_id`, `exchange_rate`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_cost`, `order_tax_rate`, `order_tax`, `order_discount`, `shipping_cost`, `grand_total`, `paid_amount`, `status`, `payment_status`, `document`, `note`, `created_at`, `updated_at`) VALUES
(1, 'pr-20230528-125929', 1, 1, NULL, 1, 1, 1, 10, 0, 10, 110, 0, 0, 0, 0, 110, 0, 1, 1, NULL, NULL, '2023-05-28 06:59:29', '2023-05-28 06:59:29'),
(2, '1234', 2, 1, 1, 1, 0.06517, 2, 20, 0, 0, 3000, 10, 300, 0, 0, 3300, 0, 1, 1, NULL, NULL, '2025-03-25 00:00:00', '2025-03-25 18:32:06'),
(3, '56789', 3, 1, 1, 2, 100, 1, 60, 0, 30, 330, 10, 33, 0, 0, 363, 0, 1, 1, NULL, NULL, '2025-03-29 00:00:00', '2025-03-26 08:49:20'),
(4, '8789t9037', 1, 1, 1, 2, 1, 1, 1, 0, 0, 200, 0, 0, 0, 0, 200, 0, 1, 1, NULL, NULL, '2025-03-26 00:00:00', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_product_return`
--

CREATE TABLE `purchase_product_return` (
  `id` int(10) UNSIGNED NOT NULL,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

CREATE TABLE `quotations` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `quotation_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `refills`
--

CREATE TABLE `refills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `refill_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `warehouse_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refills`
--

INSERT INTO `refills` (`id`, `customer_id`, `created_at`, `refill_note`, `staff_note`, `updated_at`, `warehouse_id`) VALUES
(1, 3, '2025-03-26 01:37:34', NULL, NULL, '2025-03-26 01:37:34', 1);

-- --------------------------------------------------------

--
-- Table structure for table `refill_items`
--

CREATE TABLE `refill_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `refill_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `refill_interval` int(11) NOT NULL,
  `refill_unit` enum('days','weeks','months') NOT NULL,
  `refill_until` date NOT NULL,
  `next_refill_date` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refill_items`
--

INSERT INTO `refill_items` (`id`, `refill_id`, `product_id`, `quantity`, `refill_interval`, `refill_unit`, `refill_until`, `next_refill_date`, `created_at`, `updated_at`) VALUES
(1, 1, 14, 1, 2, 'months', '2025-04-06', NULL, '2025-03-26 01:37:34', '2025-03-26 01:37:34');

-- --------------------------------------------------------

--
-- Table structure for table `returns`
--

CREATE TABLE `returns` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `return_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `returns`
--

INSERT INTO `returns` (`id`, `reference_no`, `user_id`, `sale_id`, `cash_register_id`, `customer_id`, `warehouse_id`, `biller_id`, `account_id`, `currency_id`, `exchange_rate`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_price`, `order_tax_rate`, `order_tax`, `grand_total`, `document`, `return_note`, `staff_note`, `created_at`, `updated_at`) VALUES
(1, 'rr-20250326-092856', 1, 1, 1, 2, 1, 1, 1, 1, 0.06517, 1, 1, 0, 0, 1.63, 0, 0, 1.63, NULL, NULL, NULL, '2025-03-26 09:28:56', '2025-03-26 09:28:56');

-- --------------------------------------------------------

--
-- Table structure for table `return_purchases`
--

CREATE TABLE `return_purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `return_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reward_point_settings`
--

CREATE TABLE `reward_point_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `per_point_amount` double NOT NULL,
  `minimum_amount` double NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `guard_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `is_active`, `created_at`, `updated_at`, `guard_name`) VALUES
(1, 'Admin', 'Pharmacy administrator', 1, '2018-06-01 23:46:44', '2025-02-18 10:13:19', 'web'),
(2, 'Super Admin', 'GogoPlus Technical Support', 1, '2018-10-22 02:38:13', '2025-02-18 10:49:13', 'web'),
(5, 'Staff', 'Pharmacy Staff', 0, '2020-11-05 06:43:16', '2025-02-18 10:50:13', 'web'),
(7, 'Pharmacist', 'Pharnacist', 1, '2025-02-18 12:00:10', '2025-02-18 12:00:10', 'web');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(4, 1),
(4, 2),
(4, 5),
(4, 7),
(5, 1),
(5, 2),
(5, 5),
(5, 7),
(6, 1),
(6, 2),
(6, 5),
(6, 7),
(7, 1),
(7, 2),
(7, 5),
(7, 7),
(8, 1),
(8, 2),
(8, 5),
(8, 7),
(9, 1),
(9, 2),
(9, 5),
(9, 7),
(10, 1),
(10, 2),
(10, 5),
(10, 7),
(11, 1),
(11, 2),
(12, 1),
(12, 2),
(12, 5),
(12, 7),
(13, 1),
(13, 2),
(13, 5),
(13, 7),
(14, 1),
(14, 2),
(14, 5),
(15, 1),
(15, 2),
(16, 1),
(16, 2),
(16, 5),
(16, 7),
(17, 1),
(17, 2),
(17, 5),
(17, 7),
(18, 1),
(18, 2),
(18, 5),
(18, 7),
(19, 1),
(19, 2),
(20, 1),
(20, 2),
(20, 5),
(20, 7),
(21, 1),
(21, 2),
(21, 5),
(21, 7),
(22, 1),
(22, 2),
(22, 5),
(22, 7),
(23, 1),
(23, 2),
(24, 1),
(24, 2),
(24, 5),
(24, 7),
(25, 1),
(25, 2),
(25, 5),
(25, 7),
(26, 1),
(26, 2),
(26, 5),
(26, 7),
(27, 1),
(27, 2),
(28, 1),
(28, 2),
(28, 5),
(28, 7),
(29, 1),
(29, 2),
(29, 5),
(29, 7),
(30, 1),
(30, 2),
(30, 5),
(30, 7),
(31, 1),
(31, 2),
(32, 1),
(32, 2),
(32, 5),
(33, 1),
(33, 2),
(33, 5),
(34, 1),
(34, 2),
(34, 5),
(35, 1),
(35, 2),
(35, 5),
(36, 1),
(36, 2),
(36, 5),
(36, 7),
(37, 1),
(37, 2),
(37, 5),
(37, 7),
(38, 1),
(38, 2),
(38, 5),
(38, 7),
(39, 1),
(39, 2),
(39, 5),
(39, 7),
(40, 1),
(40, 2),
(40, 5),
(40, 7),
(41, 1),
(41, 2),
(41, 5),
(41, 7),
(42, 1),
(42, 2),
(42, 7),
(43, 1),
(43, 2),
(43, 7),
(44, 1),
(44, 2),
(45, 1),
(45, 2),
(45, 5),
(45, 7),
(46, 1),
(46, 2),
(46, 5),
(46, 7),
(47, 1),
(47, 2),
(47, 5),
(47, 7),
(48, 1),
(48, 2),
(48, 5),
(48, 7),
(49, 1),
(49, 2),
(49, 5),
(49, 7),
(50, 1),
(50, 2),
(50, 5),
(50, 7),
(51, 1),
(51, 2),
(51, 5),
(51, 7),
(52, 1),
(52, 2),
(52, 5),
(52, 7),
(53, 1),
(53, 2),
(53, 5),
(53, 7),
(54, 1),
(54, 2),
(54, 5),
(55, 1),
(55, 2),
(55, 5),
(55, 7),
(56, 1),
(56, 2),
(56, 5),
(56, 7),
(57, 1),
(57, 2),
(57, 5),
(57, 7),
(58, 1),
(58, 2),
(59, 2),
(59, 5),
(60, 2),
(61, 2),
(62, 1),
(62, 2),
(63, 1),
(63, 2),
(63, 5),
(63, 7),
(64, 1),
(64, 2),
(64, 5),
(64, 7),
(65, 1),
(65, 2),
(65, 5),
(65, 7),
(66, 1),
(66, 2),
(67, 1),
(67, 2),
(67, 5),
(68, 1),
(68, 2),
(69, 1),
(69, 2),
(69, 5),
(70, 1),
(70, 2),
(71, 1),
(71, 2),
(72, 1),
(72, 2),
(73, 1),
(73, 2),
(73, 5),
(74, 1),
(74, 2),
(75, 1),
(75, 2),
(76, 1),
(76, 2),
(77, 1),
(77, 2),
(77, 7),
(78, 1),
(78, 2),
(78, 5),
(78, 7),
(79, 1),
(79, 2),
(79, 5),
(79, 7),
(80, 2),
(81, 1),
(81, 2),
(81, 5),
(81, 7),
(82, 1),
(82, 2),
(83, 2),
(84, 1),
(84, 2),
(84, 5),
(84, 7),
(85, 1),
(85, 2),
(85, 5),
(85, 7),
(86, 1),
(86, 2),
(86, 5),
(87, 1),
(87, 2),
(87, 5),
(87, 7),
(88, 1),
(88, 2),
(88, 5),
(88, 7),
(89, 1),
(89, 2),
(90, 1),
(90, 2),
(90, 5),
(90, 7),
(91, 1),
(91, 2),
(92, 1),
(92, 2),
(92, 5),
(92, 7),
(93, 1),
(93, 2),
(93, 5),
(94, 1),
(94, 2),
(95, 1),
(95, 2),
(96, 1),
(96, 2),
(97, 1),
(97, 2),
(98, 1),
(98, 2),
(98, 5),
(98, 7),
(99, 1),
(99, 2),
(99, 5),
(99, 7),
(100, 1),
(100, 2),
(100, 5),
(100, 7),
(101, 1),
(101, 2),
(101, 5),
(101, 7),
(102, 1),
(102, 2),
(102, 5),
(102, 7),
(103, 1),
(103, 2),
(103, 5),
(103, 7),
(104, 2),
(105, 1),
(105, 2),
(105, 7),
(106, 1),
(106, 2),
(106, 5),
(106, 7),
(107, 1),
(107, 2),
(107, 5),
(107, 7),
(108, 1),
(108, 2),
(108, 5),
(108, 7),
(109, 1),
(109, 2),
(109, 5),
(109, 7),
(110, 1),
(110, 2),
(110, 5),
(110, 7),
(111, 1),
(111, 2),
(111, 5),
(111, 7),
(112, 1),
(112, 2),
(112, 5),
(112, 7),
(113, 1),
(113, 2),
(113, 5),
(113, 7),
(114, 1),
(114, 2),
(114, 5),
(114, 7),
(115, 1),
(115, 2),
(115, 5),
(115, 7),
(116, 1),
(116, 2),
(117, 1),
(117, 2),
(117, 5),
(117, 7),
(118, 1),
(118, 2),
(118, 5),
(118, 7),
(119, 1),
(119, 2),
(119, 5),
(120, 1),
(120, 2),
(121, 1),
(121, 2),
(121, 5),
(121, 7),
(122, 1),
(122, 2),
(122, 5),
(122, 7),
(123, 1),
(123, 2),
(123, 5),
(123, 7),
(124, 1),
(124, 2),
(124, 5),
(124, 7),
(125, 1),
(125, 2),
(125, 5),
(126, 2),
(126, 7),
(127, 1),
(127, 2),
(127, 5),
(128, 1),
(128, 2),
(128, 5),
(129, 1),
(129, 2),
(129, 5),
(130, 1),
(130, 2),
(131, 2),
(132, 1),
(132, 2),
(132, 5);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `queue` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `grand_total` double NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount_type` varchar(255) DEFAULT NULL,
  `order_discount_value` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `coupon_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `sale_status` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `sale_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `reference_no`, `user_id`, `cash_register_id`, `table_id`, `queue`, `customer_id`, `warehouse_id`, `biller_id`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_price`, `grand_total`, `currency_id`, `exchange_rate`, `order_tax_rate`, `order_tax`, `order_discount_type`, `order_discount_value`, `order_discount`, `coupon_id`, `coupon_discount`, `shipping_cost`, `sale_status`, `payment_status`, `document`, `paid_amount`, `sale_note`, `staff_note`, `created_at`, `updated_at`) VALUES
(1, 'posr-20250325-064247', 2, 2, NULL, NULL, 2, 1, 1, 1, 2, 0, 0, 3.26, 3.26, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 4, 4, NULL, 3.26, NULL, NULL, '2025-03-25 18:42:47', '2025-03-26 09:28:56'),
(2, '1234', 2, 2, NULL, NULL, 2, 1, 1, 1, 1, 0, 0, 1.63, 1.63, 1, 0.06517, 0, 0, 'Flat', 0, 0, NULL, NULL, 0, 1, 2, NULL, 0, NULL, NULL, '2025-03-25 18:51:03', '2025-03-25 18:51:03'),
(3, 'posr-20250326-022939', 3, 3, NULL, NULL, 1, 1, 1, 1, 3, 0, 0, 4.89, 4.89, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 3, 2, NULL, 0, NULL, NULL, '2025-03-26 02:29:39', '2025-03-26 02:29:39'),
(4, '67879', 3, 3, NULL, NULL, 3, 1, 1, 1, 80, 0, 0, 2000, 2000, 2, 100, 0, 0, 'Flat', NULL, 0, NULL, NULL, 0, 2, 1, NULL, 0, NULL, NULL, '2025-04-02 08:51:58', '2025-03-26 08:51:58'),
(5, '89089', 3, 3, NULL, NULL, 3, 1, 1, 1, 10, 0, 0, 16.29, 16.29, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, NULL, 0, 1, 3, NULL, 8, NULL, NULL, '2025-04-02 08:59:20', '2025-03-26 08:59:20'),
(6, 'posr-20250326-092257', 1, 1, NULL, NULL, 1, 1, 1, 1, 4, 0, 0, 1.3, 1.3, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 1, 4, NULL, 1.3, NULL, NULL, '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `sent_sms`
--

CREATE TABLE `sent_sms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'sent',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shelves`
--

CREATE TABLE `shelves` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shelves`
--

INSERT INTO `shelves` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'general', '2025-03-25 17:59:32', '2025-03-25 17:59:32'),
(3, 'stomach', '2025-03-25 18:21:57', '2025-03-25 18:21:57');

-- --------------------------------------------------------

--
-- Table structure for table `sms_templates`
--

CREATE TABLE `sms_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_default_ecommerce` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_counts`
--

CREATE TABLE `stock_counts` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `category_id` varchar(255) DEFAULT NULL,
  `brand_id` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `initial_file` varchar(255) DEFAULT NULL,
  `final_file` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_adjusted` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) NOT NULL,
  `vat_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `image`, `company_name`, `vat_number`, `email`, `phone_number`, `address`, `city`, `state`, `postal_code`, `country`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'John Doe', NULL, 'Test Company', NULL, 'john@gmail.com', '231312', 'Test address', 'Test City', NULL, NULL, NULL, 1, '2023-05-28 06:53:04', '2023-05-28 06:53:04');

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `number_of_person` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `name`, `rate`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'VAT 10%', 10, 1, '2023-05-28 06:52:08', '2023-05-28 06:52:08');

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `from_warehouse_id` int(11) NOT NULL,
  `to_warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_sent` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(10) UNSIGNED NOT NULL,
  `unit_code` varchar(255) NOT NULL,
  `unit_name` varchar(255) NOT NULL,
  `base_unit` int(11) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `operation_value` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_code`, `unit_name`, `base_unit`, `operator`, `operation_value`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'PIECE', 'PIECE', NULL, '*', 1, 1, '2023-05-28 06:51:50', '2025-02-04 17:06:26'),
(2, 'AMPOULE', 'AMPOULE', NULL, '*', 1, 1, '2025-02-04 17:07:04', '2025-02-04 17:07:04'),
(3, 'SACHET', 'SACHET', NULL, '*', 1, 1, '2025-02-04 17:07:20', '2025-02-04 17:07:20'),
(4, 'TAB', 'TAB', NULL, '*', 1, 1, '2025-02-04 17:07:31', '2025-02-04 17:07:31'),
(5, 'TUBE', 'TUBE', NULL, '*', 1, 1, '2025-02-04 17:07:42', '2025-02-04 17:07:42'),
(6, 'VIAL', 'VIAL', NULL, '*', 1, 1, '2025-02-04 17:07:56', '2025-02-04 17:07:56'),
(7, 'BOTTLE', 'BOTTLE', NULL, '*', 1, 1, '2025-02-04 17:08:09', '2025-02-04 17:08:09'),
(8, 'CAP', 'CAP', NULL, '*', 1, 1, '2025-02-04 17:08:24', '2025-02-04 17:08:24'),
(9, 'BOX', 'BOX', NULL, '*', 1, 1, '2025-02-04 17:08:35', '2025-02-04 17:08:35'),
(10, 'JAR', 'JAR', NULL, '*', 1, 1, '2025-02-04 17:08:46', '2025-02-04 17:08:46'),
(11, 'DROP', 'DROP', NULL, '*', 1, 1, '2025-02-04 17:08:57', '2025-02-04 17:08:57'),
(12, 'SINGLE', 'SINGLE', NULL, '*', 1, 1, '2025-02-04 17:09:10', '2025-02-04 17:09:10'),
(13, 'CAN', 'CAN', NULL, '*', 1, 1, '2025-02-04 17:09:21', '2025-02-04 17:09:21'),
(14, 'SUPP', 'SUPP', NULL, '*', 1, 1, '2025-02-04 17:09:35', '2025-02-04 17:09:35'),
(15, 'STRIP', 'STRIP', NULL, '*', 1, 1, '2025-02-04 17:09:52', '2025-02-04 17:09:52'),
(16, 'PESS', 'PESS', NULL, '*', 1, 1, '2025-02-04 17:10:04', '2025-02-04 17:10:04'),
(17, 'LOZENGES', 'LOZENGES', NULL, '*', 1, 1, '2025-02-04 17:10:24', '2025-02-04 17:10:24'),
(18, 'POUCH', 'POUCH', NULL, '*', 1, 1, '2025-02-04 17:10:39', '2025-02-04 17:10:39'),
(19, 'BAG', 'BAG', NULL, '*', 1, 1, '2025-02-04 17:10:49', '2025-02-04 17:10:49'),
(20, 'No Unit', 'No Unit', NULL, '*', 1, 1, '2025-02-04 17:11:30', '2025-02-04 17:11:30'),
(21, 'PACK', 'PACK', NULL, '*', 1, 1, '2025-02-04 17:15:31', '2025-02-04 17:15:31');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `phone`, `company_name`, `role_id`, `biller_id`, `warehouse_id`, `is_active`, `is_deleted`) VALUES
(1, 'intern', 'giftybuah@gmail.com', '$2y$10$gtlKmhPKO0iLrXVyhcTaQ.DlEgDX66LqhS0slYrNBpsqIOV6ZwATC', 'pEN60GwtkCZFKVT6tvmmCiYvHqvDX4znpKTdgDca9wxdfVmtbxRixIxH0RzJ', '2018-06-02 03:24:15', '2025-03-24 23:20:25', '0247118423', 'Intern Pharmacy', 2, NULL, NULL, 1, 0),
(2, 'iddrisu', 'iddrisu442g@gmail.com', '$2y$10$WwNSDcjyJzDoEFFC1s2MTuGx5UrmgBhj7iwNceFJqOTA6IgAB7QUe', NULL, '2025-03-24 20:36:04', '2025-03-24 23:15:12', '0550936771', 'Intern Pharmacy', 1, NULL, NULL, 1, 0),
(3, 'obed', 'ninsonobed5630@gmail.com', '$2y$10$vPfQAb2/onfHCkKOJzzbtOU1TtzRKEjldvuEzdgZPsGQZEPavXfGC', NULL, '2025-03-24 20:39:36', '2025-03-24 23:16:16', '0256422216', 'Intern Pharmacy', 1, NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `variants`
--

CREATE TABLE `variants` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `name`, `phone`, `email`, `address`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Shop', '9991111', NULL, 'Test address', 1, '2023-05-28 06:51:19', '2023-05-28 06:51:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `action_logs`
--
ALTER TABLE `action_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `action_id` (`action_id`);

--
-- Indexes for table `adjustments`
--
ALTER TABLE `adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `barcodes`
--
ALTER TABLE `barcodes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billers`
--
ALTER TABLE `billers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cash_registers`
--
ALTER TABLE `cash_registers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `challans`
--
ALTER TABLE `challans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `couriers`
--
ALTER TABLE `couriers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_groups`
--
ALTER TABLE `customer_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_fields`
--
ALTER TABLE `custom_fields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plans`
--
ALTER TABLE `discount_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plan_customers`
--
ALTER TABLE `discount_plan_customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plan_discounts`
--
ALTER TABLE `discount_plan_discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dso_alerts`
--
ALTER TABLE `dso_alerts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `external_services`
--
ALTER TABLE `external_services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gift_cards`
--
ALTER TABLE `gift_cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gift_card_recharges`
--
ALTER TABLE `gift_card_recharges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hrm_settings`
--
ALTER TABLE `hrm_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `incomes`
--
ALTER TABLE `incomes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `income_categories`
--
ALTER TABLE `income_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `insurance_provider`
--
ALTER TABLE `insurance_provider`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mail_settings`
--
ALTER TABLE `mail_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `money_transfers`
--
ALTER TABLE `money_transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `packing_slips`
--
ALTER TABLE `packing_slips`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packing_slip_products`
--
ALTER TABLE `packing_slip_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_cheque`
--
ALTER TABLE `payment_with_cheque`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_credit_card`
--
ALTER TABLE `payment_with_credit_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_gift_card`
--
ALTER TABLE `payment_with_gift_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_insurance`
--
ALTER TABLE `payment_with_insurance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_mobile_money`
--
ALTER TABLE `payment_with_mobile_money`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_paypal`
--
ALTER TABLE `payment_with_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payrolls`
--
ALTER TABLE `payrolls`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pos_setting`
--
ALTER TABLE `pos_setting`
  ADD UNIQUE KEY `pos_setting_id_unique` (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_batches`
--
ALTER TABLE `product_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_purchases`
--
ALTER TABLE `product_purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_quotation`
--
ALTER TABLE `product_quotation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_returns`
--
ALTER TABLE `product_returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_sales`
--
ALTER TABLE `product_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_transfer`
--
ALTER TABLE `product_transfer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_product_return`
--
ALTER TABLE `purchase_product_return`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quotations`
--
ALTER TABLE `quotations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refills`
--
ALTER TABLE `refills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refill_items`
--
ALTER TABLE `refill_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `refill_items_next_refill_date_index` (`next_refill_date`);

--
-- Indexes for table `returns`
--
ALTER TABLE `returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `return_purchases`
--
ALTER TABLE `return_purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reward_point_settings`
--
ALTER TABLE `reward_point_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sent_sms`
--
ALTER TABLE `sent_sms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sent_sms_customer_id_index` (`customer_id`),
  ADD KEY `sent_sms_phone_number_index` (`phone_number`);

--
-- Indexes for table `shelves`
--
ALTER TABLE `shelves`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shelves_name_index` (`name`);

--
-- Indexes for table `sms_templates`
--
ALTER TABLE `sms_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_counts`
--
ALTER TABLE `stock_counts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `variants`
--
ALTER TABLE `variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `action_logs`
--
ALTER TABLE `action_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `adjustments`
--
ALTER TABLE `adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `barcodes`
--
ALTER TABLE `barcodes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `billers`
--
ALTER TABLE `billers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cash_registers`
--
ALTER TABLE `cash_registers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `challans`
--
ALTER TABLE `challans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `couriers`
--
ALTER TABLE `couriers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customer_groups`
--
ALTER TABLE `customer_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `custom_fields`
--
ALTER TABLE `custom_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plans`
--
ALTER TABLE `discount_plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plan_customers`
--
ALTER TABLE `discount_plan_customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plan_discounts`
--
ALTER TABLE `discount_plan_discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dso_alerts`
--
ALTER TABLE `dso_alerts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `external_services`
--
ALTER TABLE `external_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `gift_cards`
--
ALTER TABLE `gift_cards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gift_card_recharges`
--
ALTER TABLE `gift_card_recharges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hrm_settings`
--
ALTER TABLE `hrm_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `incomes`
--
ALTER TABLE `incomes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `income_categories`
--
ALTER TABLE `income_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `insurance_provider`
--
ALTER TABLE `insurance_provider`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mail_settings`
--
ALTER TABLE `mail_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;

--
-- AUTO_INCREMENT for table `money_transfers`
--
ALTER TABLE `money_transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packing_slips`
--
ALTER TABLE `packing_slips`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packing_slip_products`
--
ALTER TABLE `packing_slip_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_with_cheque`
--
ALTER TABLE `payment_with_cheque`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_credit_card`
--
ALTER TABLE `payment_with_credit_card`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_gift_card`
--
ALTER TABLE `payment_with_gift_card`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_insurance`
--
ALTER TABLE `payment_with_insurance`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_mobile_money`
--
ALTER TABLE `payment_with_mobile_money`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payment_with_paypal`
--
ALTER TABLE `payment_with_paypal`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payrolls`
--
ALTER TABLE `payrolls`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_batches`
--
ALTER TABLE `product_batches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_purchases`
--
ALTER TABLE `product_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_quotation`
--
ALTER TABLE `product_quotation`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_returns`
--
ALTER TABLE `product_returns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_sales`
--
ALTER TABLE `product_sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product_transfer`
--
ALTER TABLE `product_transfer`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `purchase_product_return`
--
ALTER TABLE `purchase_product_return`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotations`
--
ALTER TABLE `quotations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `refills`
--
ALTER TABLE `refills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `refill_items`
--
ALTER TABLE `refill_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `returns`
--
ALTER TABLE `returns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `return_purchases`
--
ALTER TABLE `return_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reward_point_settings`
--
ALTER TABLE `reward_point_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sent_sms`
--
ALTER TABLE `sent_sms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shelves`
--
ALTER TABLE `shelves`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sms_templates`
--
ALTER TABLE `sms_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_counts`
--
ALTER TABLE `stock_counts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `variants`
--
ALTER TABLE `variants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Database: `pharmacy3`
--
CREATE DATABASE IF NOT EXISTS `pharmacy3` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pharmacy3`;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_no` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `initial_balance` double DEFAULT NULL,
  `total_balance` double NOT NULL,
  `note` text DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'Bank Account',
  `parent_account_id` int(11) DEFAULT NULL,
  `is_payment` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `account_no`, `name`, `initial_balance`, `total_balance`, `note`, `is_default`, `is_active`, `created_at`, `updated_at`, `code`, `type`, `parent_account_id`, `is_payment`) VALUES
(1, '019912229', 'Sales Account', 0, 0, 'This is the default account.', 1, 1, '2023-02-05 07:12:15', '2023-02-05 07:12:15', NULL, 'Bank Account', NULL, 1),
(2, '0147852', 'idi', 10000, 10000, NULL, NULL, 1, '2025-03-26 07:58:20', '2025-03-26 07:58:20', NULL, 'Bank Account', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `action_logs`
--

CREATE TABLE `action_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `action_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `route` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `synced_at` timestamp NULL DEFAULT NULL,
  `pharmacy_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `adjustments`
--

CREATE TABLE `adjustments` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `total_qty` double NOT NULL,
  `item` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `employee_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `checkin` varchar(255) NOT NULL,
  `checkout` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `barcodes`
--

CREATE TABLE `barcodes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `width` double(22,4) DEFAULT NULL,
  `height` double(22,4) DEFAULT NULL,
  `paper_width` double(22,4) DEFAULT NULL,
  `paper_height` double(22,4) DEFAULT NULL,
  `top_margin` double(22,4) DEFAULT NULL,
  `left_margin` double(22,4) DEFAULT NULL,
  `row_distance` double(22,4) DEFAULT NULL,
  `col_distance` double(22,4) DEFAULT NULL,
  `stickers_in_one_row` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_continuous` tinyint(1) NOT NULL DEFAULT 0,
  `stickers_in_one_sheet` int(11) DEFAULT NULL,
  `is_custom` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barcodes`
--

INSERT INTO `barcodes` (`id`, `name`, `description`, `width`, `height`, `paper_width`, `paper_height`, `top_margin`, `left_margin`, `row_distance`, `col_distance`, `stickers_in_one_row`, `is_default`, `is_continuous`, `stickers_in_one_sheet`, `is_custom`, `created_at`, `updated_at`) VALUES
(1, '20 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 4\" x 1\", Labels per sheet: 20', 4.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.1250, 0.0000, 0.1875, 2, 0, 0, 20, NULL, NULL, NULL),
(2, '30 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2.625\" x 1\", Labels per sheet: 30', 2.6250, 1.0000, 8.5000, 11.0000, 0.5000, 0.1880, 0.0000, 0.1250, 3, 0, 0, 30, NULL, NULL, NULL),
(3, '32 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1.25\", Labels per sheet: 32', 2.0000, 1.2500, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 32, NULL, NULL, NULL),
(4, '40 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1\", Labels per sheet: 40', 2.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 40, NULL, NULL, NULL),
(5, '50 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 1.5\" x 1\", Labels per sheet: 50', 1.5000, 1.0000, 8.5000, 11.0000, 0.5000, 0.5000, 0.0000, 0.0000, 5, 0, 0, 50, NULL, NULL, NULL),
(6, 'Continuous Rolls - 31.75mm x 25.4mm', 'Label Size: 31.75mm x 25.4mm, Gap: 3.18mm', 1.2500, 1.0000, 1.2500, 0.0000, 0.1250, 0.0000, 0.1250, 0.0000, 1, 0, 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `billers`
--

CREATE TABLE `billers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) NOT NULL,
  `vat_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `billers`
--

INSERT INTO `billers` (`id`, `name`, `image`, `company_name`, `vat_number`, `email`, `phone_number`, `address`, `city`, `state`, `postal_code`, `country`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Biller', NULL, 'Test Company', NULL, 'test@gmail.com', '12312', 'Test address', 'Test City', NULL, NULL, NULL, 1, '2023-05-28 06:53:51', '2023-05-28 06:53:51');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `title`, `image`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Brand', NULL, 1, '2023-05-28 06:51:38', '2023-05-28 06:51:38'),
(2, 'GB Pharma Limited', NULL, 1, '2025-03-25 17:44:43', '2025-03-25 17:44:43'),
(3, 'letap', NULL, 1, '2025-03-25 18:18:26', '2025-03-25 18:18:26');

-- --------------------------------------------------------

--
-- Table structure for table `cash_registers`
--

CREATE TABLE `cash_registers` (
  `id` int(10) UNSIGNED NOT NULL,
  `cash_in_hand` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cash_registers`
--

INSERT INTO `cash_registers` (`id`, `cash_in_hand`, `user_id`, `warehouse_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 0, 1, 1, 1, '2025-03-24 21:08:52', '2025-03-24 21:08:52'),
(2, 100, 2, 1, 1, '2025-03-25 17:31:46', '2025-03-25 17:31:46'),
(3, 12, 3, 1, 1, '2025-03-26 01:01:11', '2025-03-26 01:01:11');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image`, `parent_id`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Category', NULL, NULL, 1, '2023-05-28 06:51:00', '2023-05-28 06:51:00'),
(2, 'pain killer', NULL, NULL, 1, '2025-03-25 17:51:01', '2025-03-25 17:51:01'),
(3, 'ulcer', NULL, NULL, 1, '2025-03-25 18:18:50', '2025-03-25 18:18:50');

-- --------------------------------------------------------

--
-- Table structure for table `challans`
--

CREATE TABLE `challans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `courier_id` int(11) NOT NULL,
  `packing_slip_list` longtext NOT NULL,
  `amount_list` longtext NOT NULL,
  `cash_list` longtext DEFAULT NULL,
  `online_payment_list` longtext DEFAULT NULL,
  `cheque_list` longtext DEFAULT NULL,
  `delivery_charge_list` longtext DEFAULT NULL,
  `status_list` longtext DEFAULT NULL,
  `closing_date` date DEFAULT NULL,
  `created_by_id` int(11) NOT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `minimum_amount` double DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `used` int(11) NOT NULL,
  `expired_date` date NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `couriers`
--

CREATE TABLE `couriers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `couriers`
--

INSERT INTO `couriers` (`id`, `name`, `phone_number`, `address`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'obed', '0550936582', 'dome', 1, '2025-03-25 18:56:49', '2025-03-25 18:56:49'),
(2, 'kofi', '0550934168', 'lapaz', 1, '2025-03-25 18:57:41', '2025-03-25 18:57:41');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `exchange_rate` double NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `code`, `exchange_rate`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'US Dollar', 'USD', 0.06517, 1, '2020-11-01 00:22:58', '2025-02-04 17:17:08'),
(2, 'GHANA CEDI', 'GHS', 1, 1, '2025-02-04 17:17:29', '2025-02-04 17:17:29');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `tax_no` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `points` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deposit` double DEFAULT NULL,
  `expense` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customer_group_id`, `user_id`, `name`, `company_name`, `email`, `phone_number`, `tax_no`, `address`, `city`, `state`, `postal_code`, `country`, `points`, `is_active`, `created_at`, `updated_at`, `deposit`, `expense`) VALUES
(1, 1, NULL, 'John Doe', 'Test Company', 'john@gmail.com', '231312', NULL, 'Test address', 'Test City', NULL, NULL, NULL, NULL, 1, '2023-05-28 06:53:04', '2023-05-28 06:53:04', NULL, NULL),
(2, 1, NULL, 'tahiru', NULL, 'tahiru@gmail.com', '0550936771', NULL, 'anyaa', 'accra', NULL, NULL, NULL, NULL, 1, '2025-03-25 16:59:54', '2025-03-25 16:59:54', NULL, NULL),
(3, 1, NULL, 'obed', NULL, 'oninson45@gmail.com', '0256422216', NULL, NULL, 'Amasaman', NULL, NULL, NULL, NULL, 1, '2025-03-26 01:30:48', '2025-03-26 01:30:48', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_groups`
--

CREATE TABLE `customer_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `percentage` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_groups`
--

INSERT INTO `customer_groups` (`id`, `name`, `percentage`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'General', '0', 1, '2023-05-28 06:51:29', '2023-05-28 06:51:29');

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

CREATE TABLE `custom_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `belongs_to` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `default_value` text DEFAULT NULL,
  `option_value` text DEFAULT NULL,
  `grid_value` int(11) NOT NULL,
  `is_table` tinyint(1) NOT NULL,
  `is_invoice` tinyint(1) NOT NULL,
  `is_required` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_disable` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `packing_slip_ids` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `courier_id` int(11) DEFAULT NULL,
  `address` text NOT NULL,
  `delivered_by` varchar(255) DEFAULT NULL,
  `recieved_by` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`id`, `reference_no`, `sale_id`, `packing_slip_ids`, `user_id`, `courier_id`, `address`, `delivered_by`, `recieved_by`, `file`, `note`, `status`, `created_at`, `updated_at`) VALUES
(1, 'dr-20250325-065125', 2, NULL, 2, 1, 'anyaa accra', NULL, NULL, NULL, NULL, '3', '2025-03-25 18:51:45', '2025-03-25 18:58:26');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` int(10) UNSIGNED NOT NULL,
  `amount` double NOT NULL,
  `customer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `applicable_for` varchar(255) NOT NULL,
  `product_list` longtext DEFAULT NULL,
  `valid_from` date NOT NULL,
  `valid_till` date NOT NULL,
  `type` varchar(255) NOT NULL,
  `value` double NOT NULL,
  `minimum_qty` double NOT NULL,
  `maximum_qty` double NOT NULL,
  `days` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plans`
--

CREATE TABLE `discount_plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plan_customers`
--

CREATE TABLE `discount_plan_customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `discount_plan_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plan_discounts`
--

CREATE TABLE `discount_plan_discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `discount_id` int(11) NOT NULL,
  `discount_plan_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dso_alerts`
--

CREATE TABLE `dso_alerts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_info` longtext NOT NULL,
  `number_of_products` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `department_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `staff_id` varchar(191) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `expense_category_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `reference_no`, `expense_category_id`, `warehouse_id`, `account_id`, `user_id`, `cash_register_id`, `amount`, `note`, `created_at`, `updated_at`) VALUES
(1, 'er-20250325-063857', 1, 1, 1, 2, 2, 100, NULL, '2025-03-25 00:00:00', '2025-03-25 18:38:57');

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `code`, `name`, `is_active`, `created_at`, `updated_at`) VALUES
(1, '74965071', 'transportation', 1, '2025-03-25 18:38:22', '2025-03-25 18:38:22');

-- --------------------------------------------------------

--
-- Table structure for table `external_services`
--

CREATE TABLE `external_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `details` longtext NOT NULL,
  `module_status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`module_status`)),
  `active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `external_services`
--

INSERT INTO `external_services` (`id`, `name`, `type`, `details`, `module_status`, `active`, `created_at`, `updated_at`) VALUES
(1, 'PayPal', 'payment', 'Client ID,Client Secret;abcd1234,wxyz5678', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(2, 'Stripe', 'payment', 'Public Key,Private Key;efgh1234,stuv5678', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(3, 'Razorpay', 'payment', 'Key,Secret;rzp_test_Y4MCcpHfZNU6rR,3Hr7SDqaZ0G5waN0jsLgsiLx', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(4, 'Paystack', 'payment', 'public_Key,Secret_Key;pk_test_e8d220b7463d64569f0053e78534f38e6b10cf4a,sk_test_6d62cb976e1e0ab43f1e48b2934b0dfc7f32a1fe', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(5, 'Mollie', 'payment', 'api_key;test_dHar4XY7LxsDOtmnkVtjNVWXLSlXsM', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(6, 'Xendit', 'payment', 'secret_key,callback_token;xnd_development_aKJVKYbc4lHkEjcCLzWLrBsKs6jF6nbM6WaCMfnJerP3JW57CLis553XNRdDU,YPZxND92Mt8tdXntTYIEkRX802onZ5OcdKBUzycebuqYvN4n', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(7, 'bkash', 'payment', 'Mode,app_key,app_secret,username,password;sandbox,0vWQuCRGiUX7EPVjQDr0EUAYtc,jcUNPBgbcqEDedNKdvE4G1cAK7D3hCjmJccNPZZBq96QIxxwAMEx,01770618567,D7DaC<*E*eG', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(8, 'sslcommerz', 'payment', 'appkey,appsecret;12341234,asdfa23423', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(9, 'Mpesa', 'payment', 'consumer_Key,consumer_Secret;fhfgkj,dtrddhd', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(10, 'Pesapal', 'payment', 'Mode,Consumer Key,Consumer Secret;sandbox,qkio1BGGYAXTu2JOfm7XSXNruoZsrqEW,osGQ364R49cXKeOYSpaOnT++rHs=', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `site_title` varchar(255) NOT NULL,
  `site_logo` varchar(255) DEFAULT NULL,
  `is_rtl` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `currency` varchar(255) NOT NULL,
  `package_id` int(11) DEFAULT NULL,
  `subscription_type` varchar(255) DEFAULT NULL,
  `staff_access` varchar(255) NOT NULL,
  `without_stock` varchar(255) NOT NULL DEFAULT 'no',
  `date_format` varchar(255) NOT NULL,
  `developed_by` varchar(255) DEFAULT NULL,
  `invoice_format` varchar(255) DEFAULT NULL,
  `decimal` int(11) DEFAULT 2,
  `state` int(11) DEFAULT NULL,
  `theme` varchar(255) NOT NULL,
  `modules` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `currency_position` varchar(255) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `expiry_type` varchar(255) NOT NULL DEFAULT 'days',
  `expiry_value` varchar(255) NOT NULL DEFAULT '0',
  `is_zatca` tinyint(1) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `vat_registration_number` varchar(255) DEFAULT NULL,
  `is_packing_slip` tinyint(1) NOT NULL DEFAULT 0,
  `sms_credit` bigint(20) UNSIGNED DEFAULT NULL,
  `pharmacy_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `site_title`, `site_logo`, `is_rtl`, `created_at`, `updated_at`, `currency`, `package_id`, `subscription_type`, `staff_access`, `without_stock`, `date_format`, `developed_by`, `invoice_format`, `decimal`, `state`, `theme`, `modules`, `currency_position`, `expiry_date`, `expiry_type`, `expiry_value`, `is_zatca`, `company_name`, `vat_registration_number`, `is_packing_slip`, `sms_credit`, `pharmacy_id`) VALUES
(1, 'GogoPlus POS', '20250202043823.png', 0, '2018-07-06 06:13:11', '2025-03-24 20:23:33', '1', 3, 'monthly', 'own', 'no', 'd/m/Y', 'GogoPlus Ltd.', 'standard', 2, 1, 'default.css', '', 'prefix', '2025-05-03', 'days', '0', NULL, NULL, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `gift_cards`
--

CREATE TABLE `gift_cards` (
  `id` int(10) UNSIGNED NOT NULL,
  `card_no` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `expense` double NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gift_card_recharges`
--

CREATE TABLE `gift_card_recharges` (
  `id` int(10) UNSIGNED NOT NULL,
  `gift_card_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `note` text DEFAULT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hrm_settings`
--

CREATE TABLE `hrm_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `checkin` varchar(255) NOT NULL,
  `checkout` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `incomes`
--

CREATE TABLE `incomes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `income_category_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `income_categories`
--

CREATE TABLE `income_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `insurance_provider`
--

CREATE TABLE `insurance_provider` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mail_settings`
--

CREATE TABLE `mail_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `driver` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `port` varchar(255) NOT NULL,
  `from_address` varchar(255) NOT NULL,
  `from_name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `encryption` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_02_17_060412_create_categories_table', 1),
(4, '2018_02_20_035727_create_brands_table', 1),
(5, '2018_02_25_100635_create_suppliers_table', 1),
(6, '2018_02_27_101619_create_warehouse_table', 1),
(7, '2018_03_03_040448_create_units_table', 1),
(8, '2018_03_04_041317_create_taxes_table', 1),
(9, '2018_03_10_061915_create_customer_groups_table', 1),
(10, '2018_03_10_090534_create_customers_table', 1),
(11, '2018_03_11_095547_create_billers_table', 1),
(12, '2018_04_05_054401_create_products_table', 1),
(13, '2018_04_06_133606_create_purchases_table', 1),
(14, '2018_04_06_154600_create_product_purchases_table', 1),
(15, '2018_04_06_154915_create_product_warhouse_table', 1),
(16, '2018_04_10_085927_create_sales_table', 1),
(17, '2018_04_10_090133_create_product_sales_table', 1),
(18, '2018_04_10_090254_create_payments_table', 1),
(19, '2018_04_10_090341_create_payment_with_cheque_table', 1),
(20, '2018_04_10_090509_create_payment_with_credit_card_table', 1),
(21, '2018_04_13_121436_create_quotation_table', 1),
(22, '2018_04_13_122324_create_product_quotation_table', 1),
(23, '2018_04_14_121802_create_transfers_table', 1),
(24, '2018_04_14_121913_create_product_transfer_table', 1),
(25, '2018_05_13_082847_add_payment_id_and_change_sale_id_to_payments_table', 1),
(26, '2018_05_13_090906_change_customer_id_to_payment_with_credit_card_table', 1),
(27, '2018_05_20_054532_create_adjustments_table', 1),
(28, '2018_05_20_054859_create_product_adjustments_table', 1),
(29, '2018_05_21_163419_create_returns_table', 1),
(30, '2018_05_21_163443_create_product_returns_table', 1),
(31, '2018_06_02_050905_create_roles_table', 1),
(32, '2018_06_02_073430_add_columns_to_users_table', 1),
(33, '2018_06_03_053738_create_permission_tables', 1),
(34, '2018_06_21_063736_create_pos_setting_table', 1),
(35, '2018_06_21_094155_add_user_id_to_sales_table', 1),
(36, '2018_06_21_101529_add_user_id_to_purchases_table', 1),
(37, '2018_06_21_103512_add_user_id_to_transfers_table', 1),
(38, '2018_06_23_061058_add_user_id_to_quotations_table', 1),
(39, '2018_06_23_082427_add_is_deleted_to_users_table', 1),
(40, '2018_06_25_043308_change_email_to_users_table', 1),
(41, '2018_07_06_115449_create_general_settings_table', 1),
(42, '2018_07_08_043944_create_languages_table', 1),
(43, '2018_07_11_102144_add_user_id_to_returns_table', 1),
(44, '2018_07_11_102334_add_user_id_to_payments_table', 1),
(45, '2018_07_22_130541_add_digital_to_products_table', 1),
(46, '2018_07_24_154250_create_deliveries_table', 1),
(47, '2018_08_16_053336_create_expense_categories_table', 1),
(48, '2018_08_17_115415_create_expenses_table', 1),
(49, '2018_08_18_050418_create_gift_cards_table', 1),
(50, '2018_08_19_063119_create_payment_with_gift_card_table', 1),
(51, '2018_08_25_042333_create_gift_card_recharges_table', 1),
(52, '2018_08_25_101354_add_deposit_expense_to_customers_table', 1),
(53, '2018_08_26_043801_create_deposits_table', 1),
(54, '2018_09_02_044042_add_keybord_active_to_pos_setting_table', 1),
(55, '2018_09_09_092713_create_payment_with_paypal_table', 1),
(56, '2018_09_10_051254_add_currency_to_general_settings_table', 1),
(57, '2018_10_22_084118_add_biller_and_store_id_to_users_table', 1),
(58, '2018_10_26_034927_create_coupons_table', 1),
(59, '2018_10_27_090857_add_coupon_to_sales_table', 1),
(60, '2018_11_07_070155_add_currency_position_to_general_settings_table', 1),
(61, '2018_11_19_094650_add_combo_to_products_table', 1),
(62, '2018_12_09_043712_create_accounts_table', 1),
(63, '2018_12_17_112253_add_is_default_to_accounts_table', 1),
(64, '2018_12_19_103941_add_account_id_to_payments_table', 1),
(65, '2018_12_20_065900_add_account_id_to_expenses_table', 1),
(66, '2018_12_20_082753_add_account_id_to_returns_table', 1),
(67, '2018_12_26_064330_create_return_purchases_table', 1),
(68, '2018_12_26_144708_create_purchase_product_return_table', 1),
(69, '2018_12_27_110018_create_departments_table', 1),
(70, '2018_12_30_054844_create_employees_table', 1),
(71, '2018_12_31_125210_create_payrolls_table', 1),
(72, '2018_12_31_150446_add_department_id_to_employees_table', 1),
(73, '2019_01_01_062708_add_user_id_to_expenses_table', 1),
(74, '2019_01_02_075644_create_hrm_settings_table', 1),
(75, '2019_01_02_090334_create_attendances_table', 1),
(76, '2019_01_27_160956_add_three_columns_to_general_settings_table', 1),
(77, '2019_02_15_183303_create_stock_counts_table', 1),
(78, '2019_02_17_101604_add_is_adjusted_to_stock_counts_table', 1),
(79, '2019_04_13_101707_add_tax_no_to_customers_table', 1),
(80, '2019_08_19_000000_create_failed_jobs_table', 1),
(81, '2019_10_14_111455_create_holidays_table', 1),
(82, '2019_11_13_145619_add_is_variant_to_products_table', 1),
(83, '2019_11_13_150206_create_product_variants_table', 1),
(84, '2019_11_13_153828_create_variants_table', 1),
(85, '2019_11_25_134041_add_qty_to_product_variants_table', 1),
(86, '2019_11_25_134922_add_variant_id_to_product_purchases_table', 1),
(87, '2019_11_25_145341_add_variant_id_to_product_warehouse_table', 1),
(88, '2019_11_29_182201_add_variant_id_to_product_sales_table', 1),
(89, '2019_12_04_121311_add_variant_id_to_product_quotation_table', 1),
(90, '2019_12_05_123802_add_variant_id_to_product_transfer_table', 1),
(91, '2019_12_08_114954_add_variant_id_to_product_returns_table', 1),
(92, '2019_12_08_203146_add_variant_id_to_purchase_product_return_table', 1),
(93, '2020_02_28_103340_create_money_transfers_table', 1),
(94, '2020_07_01_193151_add_image_to_categories_table', 1),
(95, '2020_09_26_130426_add_user_id_to_deliveries_table', 1),
(96, '2020_10_11_125457_create_cash_registers_table', 1),
(97, '2020_10_13_155019_add_cash_register_id_to_sales_table', 1),
(98, '2020_10_13_172624_add_cash_register_id_to_returns_table', 1),
(99, '2020_10_17_212338_add_cash_register_id_to_payments_table', 1),
(100, '2020_10_18_124200_add_cash_register_id_to_expenses_table', 1),
(101, '2020_10_21_121632_add_developed_by_to_general_settings_table', 1),
(102, '2020_10_30_135557_create_notifications_table', 1),
(103, '2020_11_01_044954_create_currencies_table', 1),
(104, '2020_11_01_140736_add_price_to_product_warehouse_table', 1),
(105, '2020_11_02_050633_add_is_diff_price_to_products_table', 1),
(106, '2020_11_09_055222_add_user_id_to_customers_table', 1),
(107, '2020_11_17_054806_add_invoice_format_to_general_settings_table', 1),
(108, '2021_02_10_074859_add_variant_id_to_product_adjustments_table', 1),
(109, '2021_03_07_093606_create_product_batches_table', 1),
(110, '2021_03_07_093759_add_product_batch_id_to_product_warehouse_table', 1),
(111, '2021_03_07_093900_add_product_batch_id_to_product_purchases_table', 1),
(112, '2021_03_11_132603_add_product_batch_id_to_product_sales_table', 1),
(113, '2021_03_25_125421_add_is_batch_to_products_table', 1),
(114, '2021_05_19_120127_add_product_batch_id_to_product_returns_table', 1),
(115, '2021_05_22_105611_add_product_batch_id_to_purchase_product_return_table', 1),
(116, '2021_05_23_124848_add_product_batch_id_to_product_transfer_table', 1),
(117, '2021_05_26_153106_add_product_batch_id_to_product_quotation_table', 1),
(118, '2021_06_08_213007_create_reward_point_settings_table', 1),
(119, '2021_06_16_104155_add_points_to_customers_table', 1),
(120, '2021_06_17_101057_add_used_points_to_payments_table', 1),
(121, '2021_07_06_132716_add_variant_list_to_products_table', 1),
(122, '2021_09_27_161141_add_is_imei_to_products_table', 1),
(123, '2021_09_28_170052_add_imei_number_to_product_warehouse_table', 1),
(124, '2021_09_28_170126_add_imei_number_to_product_purchases_table', 1),
(125, '2021_10_03_170652_add_imei_number_to_product_sales_table', 1),
(126, '2021_10_10_145214_add_imei_number_to_product_returns_table', 1),
(127, '2021_10_11_104504_add_imei_number_to_product_transfer_table', 1),
(128, '2021_10_12_160107_add_imei_number_to_purchase_product_return_table', 1),
(129, '2021_10_12_205146_add_is_rtl_to_general_settings_table', 1),
(130, '2022_01_13_191242_create_discount_plans_table', 1),
(131, '2022_01_14_174318_create_discount_plan_customers_table', 1),
(132, '2022_01_14_202439_create_discounts_table', 1),
(133, '2022_01_16_153506_create_discount_plan_discounts_table', 1),
(134, '2022_02_05_174210_add_order_discount_type_and_value_to_sales_table', 1),
(135, '2022_05_26_195506_add_daily_sale_objective_to_products_table', 1),
(136, '2022_05_28_104209_create_dso_alerts_table', 1),
(137, '2022_06_01_112100_add_is_embeded_to_products_table', 1),
(138, '2022_06_14_130505_add_sale_id_to_returns_table', 1),
(139, '2022_07_19_115504_add_variant_data_to_products_table', 1),
(140, '2022_07_25_194300_add_additional_cost_to_product_variants_table', 1),
(141, '2022_09_04_195610_add_purchase_id_to_return_purchases_table', 1),
(142, '2023_01_18_125040_alter_table_general_settings', 1),
(143, '2023_01_18_133701_alter_table_pos_setting', 1),
(144, '2023_01_25_145309_add_expiry_date_to_general_settings_table', 1),
(145, '2023_02_05_132001_add_change_to_payments_table', 1),
(146, '2023_02_23_125656_alter_table_sales', 1),
(147, '2023_02_26_124100_add_package_id_to_general_settings_table', 1),
(148, '2023_03_04_120325_create_custom_fields_table', 1),
(149, '2023_03_14_174658_add_subscription_type_to_general_setting_table', 1),
(150, '2023_03_22_174352_add_currency_id_and_exchange_rate_to_returns_table', 1),
(151, '2023_03_27_114320_add_currency_id_and_exchange_rate_to_purchases_table', 1),
(152, '2023_03_27_132747_add_currency_id_and_exchange_rate_to_return_purchases_table', 1),
(153, '2023_04_25_150236_create_mail_settings_table', 1),
(154, '2023_05_13_125424_add_zatca_to_general_settings_table', 1),
(155, '2023_05_28_155540_create_tables_table', 1),
(156, '2023_05_29_115039_add_is_table_to_pos_setting_table', 1),
(157, '2023_05_29_115301_add_table_id_to_sales_table', 1),
(158, '2023_05_31_165049_add_queue_no_to_sales_table', 1),
(159, '2023_07_23_160254_create_couriers_table', 1),
(160, '2023_07_23_174343_add_courier_id_to_deliveries_table', 1),
(161, '2023_08_12_124016_add_staff_id_to_employees_table', 1),
(162, '2023_08_14_142608_add_is_active_to_currencies_table', 1),
(163, '2023_08_24_130203_change_columns_to_attendances_table', 1),
(164, '2023_09_10_134503_add_without_stock_to_general_settings_table', 1),
(165, '2023_09_26_211542_add_modules_to_general_settings_table', 1),
(166, '2023_10_15_124306_add_return_qty_to_product_sales_table', 1),
(167, '2023_12_03_235606_crete_external_services_table', 1),
(168, '2024_02_04_131826_add_unit_cost_to_product_adjustments_table', 1),
(169, '2024_02_13_173126_change_modules_to_general_settings_table', 1),
(170, '2024_05_02_114215_add_payment_receiver_to_payments', 1),
(171, '2024_05_06_132553_create_sms_templates_table', 1),
(172, '2024_05_07_102225_add_send_sms_to_pos_setting_table', 1),
(173, '2024_05_07_132625_add_is_default_to_sms_templates_table', 1),
(174, '2024_05_08_112211_change_address_and_city_field_to_nullable_in_customers_table', 1),
(175, '2024_05_08_151050_add_is_default_ecommerce_columne_to_sms_templates_table', 1),
(176, '2024_05_20_182757_add_wholesale_price_to_products_table', 1),
(177, '2024_05_21_170500_add_is_sent_to_transfers_table', 1),
(178, '2024_06_04_225113_create_income_categories_table', 1),
(179, '2024_06_04_225128_create_incomes_table', 1),
(180, '2024_06_29_131917_add_is_packing_slip_to_general_settings_table', 1),
(181, '2024_07_05_192531_create_packing_slips_table', 1),
(182, '2024_07_05_193002_create_packing_slip_products_table', 1),
(183, '2024_07_05_194501_add_is_packing_and_delivered_to_product_sales_table', 1),
(184, '2024_07_14_122245_add_delivery_id_to_packing_slips_table', 1),
(185, '2024_07_14_122415_add_variant_id_to_packing_slip_products_table', 1),
(186, '2024_07_14_122519_add_packing_slip_ids_to_deliveries_table', 1),
(187, '2024_07_16_125908_create_challans_table', 1),
(188, '2024_08_12_112830_add_thermal_invoice_size_to_pos_setting', 1),
(189, '2024_08_14_133351_add_expiry_type_value_to_general_settings', 1),
(190, '2024_09_11_151744_add_return_qty_to_product_purchases_table', 1),
(191, '2024_09_12_162309_create_barcodes_table', 1),
(192, '2024_10_10_121312_add_data_to_payment_with_credit_card_table', 1),
(193, '2024_10_10_212501_alter_attendances_table', 1),
(194, '2024_10_10_213757_alter_attendances_table', 1),
(195, '2024_10_14_144917_change_column_to_nullable_to_payment_with_credit_card_table', 1),
(196, '2024_11_10_121521_add_code_and_type_to_accounts_table', 1),
(197, '2024_11_24_100926_add_module_status_to_external_services_table', 1),
(198, '2025_03_09_000000_create_insurance_provider_table', 1),
(199, '2025_03_09_000001_create_payment_with_insurance_table', 1),
(200, '2025_03_09_000002_create_refills_table', 1),
(201, '2025_03_09_000003_create_refill_items_table', 1),
(202, '2025_03_09_000004_add_columns_to_products_table', 1),
(203, '2025_03_09_000005_add_dosage_to_product_sales_table', 1),
(204, '2025_03_09_000006_create_shelves_table', 1),
(205, '2025_03_12_000007_update_products_table_with_markups_and_units', 1),
(206, '2025_03_24_000000_create_payment_with_mobile_money_table', 1),
(207, '2025_03_24_000001_create_sent_sms_table', 1),
(208, '2025_03_24_000002_add_next_refill_date_to_refill_items_table', 1),
(209, '2025_03_24_000003_add_sms_credit_to_general_settings_table', 1),
(210, '2025_03_24_000004_add_customer_name_and_expiry_to_payment_with_insurance_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `money_transfers`
--

CREATE TABLE `money_transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `from_account_id` int(11) NOT NULL,
  `to_account_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `packing_slips`
--

CREATE TABLE `packing_slips` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `delivery_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `packing_slip_products`
--

CREATE TABLE `packing_slip_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `packing_slip_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `payment_receiver` varchar(255) DEFAULT NULL,
  `payment_reference` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `used_points` double DEFAULT NULL,
  `change` double DEFAULT NULL,
  `paying_method` varchar(255) NOT NULL,
  `payment_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `purchase_id`, `sale_id`, `cash_register_id`, `account_id`, `payment_receiver`, `payment_reference`, `user_id`, `amount`, `used_points`, `change`, `paying_method`, `payment_note`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 2, 1, 'iddrisu', 'spr-20250325-064247', 2, 3.26, NULL, 1.74, 'Cash', NULL, '2025-03-25 18:42:47', '2025-03-25 18:42:47'),
(2, NULL, 2, 2, 1, 'iddrisu', 'spr-20250325-065012', 2, 0, NULL, 2, 'Cash', NULL, '2025-03-25 18:50:12', '2025-03-25 18:50:12'),
(3, NULL, 5, 3, 1, NULL, 'spr-20250326-085920', 3, 8, NULL, 21, 'Cash', NULL, '2025-03-26 08:59:20', '2025-03-26 08:59:20'),
(4, NULL, 6, 1, 1, 'intern', 'spr-20250326-092257', 1, 1.3, NULL, 0, 'Mobile Money', NULL, '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_cheque`
--

CREATE TABLE `payment_with_cheque` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `cheque_no` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_credit_card`
--

CREATE TABLE `payment_with_credit_card` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_stripe_id` varchar(255) DEFAULT NULL,
  `charge_id` varchar(255) NOT NULL,
  `data` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_gift_card`
--

CREATE TABLE `payment_with_gift_card` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `gift_card_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_insurance`
--

CREATE TABLE `payment_with_insurance` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_insurance_id` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  `insurer` varchar(255) NOT NULL,
  `insurance_policy_id` varchar(255) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `approved_amount` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_mobile_money`
--

CREATE TABLE `payment_with_mobile_money` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `network` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_with_mobile_money`
--

INSERT INTO `payment_with_mobile_money` (`id`, `payment_id`, `customer_id`, `phone_number`, `reference`, `network`, `created_at`, `updated_at`) VALUES
(1, 4, 1, '0247118423', '48907553128655', 'MTN', '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_paypal`
--

CREATE TABLE `payment_with_paypal` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payrolls`
--

CREATE TABLE `payrolls` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `paying_method` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(4, 'products-edit', 'web', '2018-06-03 01:00:09', '2018-06-03 01:00:09'),
(5, 'products-delete', 'web', '2018-06-03 22:54:22', '2018-06-03 22:54:22'),
(6, 'products-add', 'web', '2018-06-04 00:34:14', '2018-06-04 00:34:14'),
(7, 'products-index', 'web', '2018-06-04 03:34:27', '2018-06-04 03:34:27'),
(8, 'purchases-index', 'web', '2018-06-04 08:03:19', '2018-06-04 08:03:19'),
(9, 'purchases-add', 'web', '2018-06-04 08:12:25', '2018-06-04 08:12:25'),
(10, 'purchases-edit', 'web', '2018-06-04 09:47:36', '2018-06-04 09:47:36'),
(11, 'purchases-delete', 'web', '2018-06-04 09:47:36', '2018-06-04 09:47:36'),
(12, 'sales-index', 'web', '2018-06-04 10:49:08', '2018-06-04 10:49:08'),
(13, 'sales-add', 'web', '2018-06-04 10:49:52', '2018-06-04 10:49:52'),
(14, 'sales-edit', 'web', '2018-06-04 10:49:52', '2018-06-04 10:49:52'),
(15, 'sales-delete', 'web', '2018-06-04 10:49:53', '2018-06-04 10:49:53'),
(16, 'quotes-index', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(17, 'quotes-add', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(18, 'quotes-edit', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(19, 'quotes-delete', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(20, 'transfers-index', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(21, 'transfers-add', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(22, 'transfers-edit', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(23, 'transfers-delete', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(24, 'returns-index', 'web', '2018-06-04 22:50:24', '2018-06-04 22:50:24'),
(25, 'returns-add', 'web', '2018-06-04 22:50:24', '2018-06-04 22:50:24'),
(26, 'returns-edit', 'web', '2018-06-04 22:50:25', '2018-06-04 22:50:25'),
(27, 'returns-delete', 'web', '2018-06-04 22:50:25', '2018-06-04 22:50:25'),
(28, 'customers-index', 'web', '2018-06-04 23:15:54', '2018-06-04 23:15:54'),
(29, 'customers-add', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(30, 'customers-edit', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(31, 'customers-delete', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(32, 'suppliers-index', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(33, 'suppliers-add', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(34, 'suppliers-edit', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(35, 'suppliers-delete', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(36, 'product-report', 'web', '2018-06-24 23:05:33', '2018-06-24 23:05:33'),
(37, 'purchase-report', 'web', '2018-06-24 23:24:56', '2018-06-24 23:24:56'),
(38, 'sale-report', 'web', '2018-06-24 23:33:13', '2018-06-24 23:33:13'),
(39, 'customer-report', 'web', '2018-06-24 23:36:51', '2018-06-24 23:36:51'),
(40, 'due-report', 'web', '2018-06-24 23:39:52', '2018-06-24 23:39:52'),
(41, 'users-index', 'web', '2018-06-25 00:00:10', '2018-06-25 00:00:10'),
(42, 'users-add', 'web', '2018-06-25 00:00:10', '2018-06-25 00:00:10'),
(43, 'users-edit', 'web', '2018-06-25 00:01:30', '2018-06-25 00:01:30'),
(44, 'users-delete', 'web', '2018-06-25 00:01:30', '2018-06-25 00:01:30'),
(45, 'profit-loss', 'web', '2018-07-14 21:50:05', '2018-07-14 21:50:05'),
(46, 'best-seller', 'web', '2018-07-14 22:01:38', '2018-07-14 22:01:38'),
(47, 'daily-sale', 'web', '2018-07-14 22:24:21', '2018-07-14 22:24:21'),
(48, 'monthly-sale', 'web', '2018-07-14 22:30:41', '2018-07-14 22:30:41'),
(49, 'daily-purchase', 'web', '2018-07-14 22:36:46', '2018-07-14 22:36:46'),
(50, 'monthly-purchase', 'web', '2018-07-14 22:48:17', '2018-07-14 22:48:17'),
(51, 'payment-report', 'web', '2018-07-14 23:10:41', '2018-07-14 23:10:41'),
(52, 'warehouse-stock-report', 'web', '2018-07-14 23:16:55', '2018-07-14 23:16:55'),
(53, 'product-qty-alert', 'web', '2018-07-14 23:33:21', '2018-07-14 23:33:21'),
(54, 'supplier-report', 'web', '2018-07-30 03:00:01', '2018-07-30 03:00:01'),
(55, 'expenses-index', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(56, 'expenses-add', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(57, 'expenses-edit', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(58, 'expenses-delete', 'web', '2018-09-05 01:07:11', '2018-09-05 01:07:11'),
(59, 'general_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(60, 'mail_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(61, 'pos_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(62, 'hrm_setting', 'web', '2019-01-02 10:30:23', '2019-01-02 10:30:23'),
(63, 'purchase-return-index', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(64, 'purchase-return-add', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(65, 'purchase-return-edit', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(66, 'purchase-return-delete', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(67, 'account-index', 'web', '2019-01-02 22:06:13', '2019-01-02 22:06:13'),
(68, 'balance-sheet', 'web', '2019-01-02 22:06:14', '2019-01-02 22:06:14'),
(69, 'account-statement', 'web', '2019-01-02 22:06:14', '2019-01-02 22:06:14'),
(70, 'department', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(71, 'attendance', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(72, 'payroll', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(73, 'employees-index', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(74, 'employees-add', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(75, 'employees-edit', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(76, 'employees-delete', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(77, 'user-report', 'web', '2019-01-16 06:48:18', '2019-01-16 06:48:18'),
(78, 'stock_count', 'web', '2019-02-17 10:32:01', '2019-02-17 10:32:01'),
(79, 'adjustment', 'web', '2019-02-17 10:32:02', '2019-02-17 10:32:02'),
(80, 'sms_setting', 'web', '2019-02-22 05:18:03', '2019-02-22 05:18:03'),
(81, 'create_sms', 'web', '2019-02-22 05:18:03', '2019-02-22 05:18:03'),
(82, 'print_barcode', 'web', '2019-03-07 05:02:19', '2019-03-07 05:02:19'),
(83, 'empty_database', 'web', '2019-03-07 05:02:19', '2019-03-07 05:02:19'),
(84, 'customer_group', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(85, 'unit', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(86, 'tax', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(87, 'gift_card', 'web', '2019-03-07 06:29:38', '2019-03-07 06:29:38'),
(88, 'coupon', 'web', '2019-03-07 06:29:38', '2019-03-07 06:29:38'),
(89, 'holiday', 'web', '2019-10-19 08:57:15', '2019-10-19 08:57:15'),
(90, 'warehouse-report', 'web', '2019-10-22 06:00:23', '2019-10-22 06:00:23'),
(91, 'warehouse', 'web', '2020-02-26 06:47:32', '2020-02-26 06:47:32'),
(92, 'brand', 'web', '2020-02-26 06:59:59', '2020-02-26 06:59:59'),
(93, 'billers-index', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(94, 'billers-add', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(95, 'billers-edit', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(96, 'billers-delete', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(97, 'money-transfer', 'web', '2020-03-02 05:41:48', '2020-03-02 05:41:48'),
(98, 'category', 'web', '2020-07-13 12:13:16', '2020-07-13 12:13:16'),
(99, 'delivery', 'web', '2020-07-13 12:13:16', '2020-07-13 12:13:16'),
(100, 'send_notification', 'web', '2020-10-31 06:21:31', '2020-10-31 06:21:31'),
(101, 'today_sale', 'web', '2020-10-31 06:57:04', '2020-10-31 06:57:04'),
(102, 'today_profit', 'web', '2020-10-31 06:57:04', '2020-10-31 06:57:04'),
(103, 'currency', 'web', '2020-11-09 00:23:11', '2020-11-09 00:23:11'),
(104, 'backup_database', 'web', '2020-11-15 00:16:55', '2020-11-15 00:16:55'),
(105, 'reward_point_setting', 'web', '2021-06-27 04:34:42', '2021-06-27 04:34:42'),
(106, 'revenue_profit_summary', 'web', '2022-02-08 13:57:21', '2022-02-08 13:57:21'),
(107, 'cash_flow', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(108, 'monthly_summary', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(109, 'yearly_report', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(110, 'discount_plan', 'web', '2022-02-16 09:12:26', '2022-02-16 09:12:26'),
(111, 'discount', 'web', '2022-02-16 09:12:38', '2022-02-16 09:12:38'),
(112, 'product-expiry-report', 'web', '2022-03-30 05:39:20', '2022-03-30 05:39:20'),
(113, 'purchase-payment-index', 'web', '2022-06-05 14:12:27', '2022-06-05 14:12:27'),
(114, 'purchase-payment-add', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(115, 'purchase-payment-edit', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(116, 'purchase-payment-delete', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(117, 'sale-payment-index', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(118, 'sale-payment-add', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(119, 'sale-payment-edit', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(120, 'sale-payment-delete', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(121, 'all_notification', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(122, 'sale-report-chart', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(123, 'dso-report', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(124, 'product_history', 'web', '2022-08-25 14:04:05', '2022-08-25 14:04:05'),
(125, 'supplier-due-report', 'web', '2022-08-31 09:46:33', '2022-08-31 09:46:33'),
(126, 'custom_field', 'web', '2023-11-13 06:23:34', '2023-11-13 06:23:34'),
(127, 'incomes-index', 'web', '2024-07-11 13:16:43', '2024-07-11 13:16:43'),
(128, 'incomes-add', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(129, 'incomes-edit', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(130, 'incomes-delete', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(131, 'packing_slip_challan', 'web', '2024-07-22 14:16:17', '2024-07-22 14:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `pos_setting`
--

CREATE TABLE `pos_setting` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `product_number` int(11) NOT NULL,
  `keybord_active` tinyint(1) NOT NULL,
  `is_table` tinyint(1) NOT NULL DEFAULT 0,
  `send_sms` tinyint(1) NOT NULL DEFAULT 0,
  `stripe_public_key` varchar(255) DEFAULT NULL,
  `stripe_secret_key` varchar(255) DEFAULT NULL,
  `paypal_live_api_username` varchar(255) DEFAULT NULL,
  `paypal_live_api_password` varchar(255) DEFAULT NULL,
  `paypal_live_api_secret` varchar(255) DEFAULT NULL,
  `payment_options` text DEFAULT NULL,
  `invoice_option` varchar(10) DEFAULT NULL,
  `thermal_invoice_size` varchar(255) NOT NULL DEFAULT '80',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pos_setting`
--

INSERT INTO `pos_setting` (`id`, `customer_id`, `warehouse_id`, `biller_id`, `product_number`, `keybord_active`, `is_table`, `send_sms`, `stripe_public_key`, `stripe_secret_key`, `paypal_live_api_username`, `paypal_live_api_password`, `paypal_live_api_secret`, `payment_options`, `invoice_option`, `thermal_invoice_size`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 2, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 'cash,card,cheque,gift_card,deposit,mobile_money,credit,insurance', 'thermal', '80', '2023-05-28 06:57:03', '2025-03-24 23:17:23');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `shelf` varchar(50) DEFAULT NULL,
  `max_product` int(11) NOT NULL DEFAULT 50,
  `shelf_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `barcode_symbology` varchar(255) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `retail_units_per_wholesale` double DEFAULT NULL COMMENT 'Number of retail units in one wholesale unit, e.g., 15 bottles per box',
  `cost` double NOT NULL,
  `wholesale_markup` double DEFAULT NULL COMMENT 'Markup percentage for wholesale price',
  `wholesale_price` double DEFAULT NULL COMMENT 'Price per wholesale unit (e.g., box)',
  `retail_markup` double DEFAULT NULL COMMENT 'Markup percentage for retail price',
  `price` double DEFAULT NULL COMMENT 'Price per retail unit (e.g., bottle)',
  `qty` double DEFAULT NULL,
  `alert_quantity` double DEFAULT NULL,
  `daily_sale_objective` double DEFAULT NULL,
  `promotion` tinyint(4) DEFAULT NULL,
  `promotion_price` varchar(255) DEFAULT NULL,
  `starting_date` date DEFAULT NULL,
  `last_date` date DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `tax_method` int(11) DEFAULT NULL,
  `image` longtext DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `is_embeded` tinyint(1) DEFAULT NULL,
  `is_variant` tinyint(1) DEFAULT NULL,
  `is_batch` tinyint(1) DEFAULT NULL,
  `is_diffPrice` tinyint(1) DEFAULT NULL,
  `is_imei` tinyint(1) DEFAULT NULL,
  `featured` tinyint(4) DEFAULT NULL,
  `product_list` varchar(255) DEFAULT NULL,
  `variant_list` varchar(255) DEFAULT NULL,
  `qty_list` varchar(255) DEFAULT NULL,
  `price_list` varchar(255) DEFAULT NULL,
  `product_details` text DEFAULT NULL,
  `variant_option` text DEFAULT NULL,
  `variant_value` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `shelf`, `max_product`, `shelf_id`, `name`, `code`, `type`, `barcode_symbology`, `brand_id`, `category_id`, `unit_id`, `purchase_unit_id`, `sale_unit_id`, `retail_units_per_wholesale`, `cost`, `wholesale_markup`, `wholesale_price`, `retail_markup`, `price`, `qty`, `alert_quantity`, `daily_sale_objective`, `promotion`, `promotion_price`, `starting_date`, `last_date`, `tax_id`, `tax_method`, `image`, `file`, `is_embeded`, `is_variant`, `is_batch`, `is_diffPrice`, `is_imei`, `featured`, `product_list`, `variant_list`, `qty_list`, `price_list`, `product_details`, `variant_option`, `variant_value`, `is_active`, `created_at`, `updated_at`) VALUES
(13, NULL, 50, 1, 'gebedol', '11021', 'standard', 'C128', 2, 2, 9, 9, 21, 12, 100, 10, 9.17, 20, 10, 120, 5, 10, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, 1, NULL, 1, 0, NULL, 1, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-25 17:56:52', '2025-03-25 18:32:06'),
(14, NULL, 50, NULL, 'Gastric Ulcer', '06342634', 'standard', 'C39', 3, 3, 9, 9, 7, 12, 200, 20, 20, 50, 25, 120, 150, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, 0, NULL, 1, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-25 18:21:13', '2025-03-26 09:28:56'),
(15, NULL, 50, NULL, 'Paracetamol', '79813673', 'standard', 'C128', 1, 2, 9, 9, 0, 1, 5, 0.01, 5, -0.01, 5, 56, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-26 08:42:36', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `product_adjustments`
--

CREATE TABLE `product_adjustments` (
  `id` int(10) UNSIGNED NOT NULL,
  `adjustment_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `unit_cost` double DEFAULT NULL,
  `qty` double NOT NULL,
  `action` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_batches`
--

CREATE TABLE `product_batches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `batch_no` varchar(255) NOT NULL,
  `expired_date` date NOT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_batches`
--

INSERT INTO `product_batches` (`id`, `product_id`, `batch_no`, `expired_date`, `qty`, `created_at`, `updated_at`) VALUES
(1, 14, '25-03-2025', '2026-03-25', 108, '2025-03-25 18:32:06', '2025-03-26 09:28:56'),
(2, 13, '25-03-2025', '2027-03-25', 120, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(3, 15, '7890', '2026-10-21', 56, '2025-03-26 08:49:20', '2025-03-26 09:22:57'),
(4, 14, '8097', '2025-03-28', 12, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_purchases`
--

CREATE TABLE `product_purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `recieved` double NOT NULL,
  `return_qty` double NOT NULL DEFAULT 0,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_purchases`
--

INSERT INTO `product_purchases` (`id`, `purchase_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `recieved`, `return_qty`, `purchase_unit_id`, `net_unit_cost`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL, NULL, 10, 10, 0, 1, 10, 0, 10, 10, 110, '2023-05-28 06:59:29', '2023-05-28 06:59:29'),
(2, 2, 14, 1, NULL, NULL, 10, 10, 0, 9, 200, 0, 0, 0, 2000, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(3, 2, 13, 2, NULL, NULL, 10, 10, 0, 9, 100, 0, 0, 0, 1000, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(4, 3, 15, 3, NULL, NULL, 60, 60, 0, 9, 5, 0, 10, 30, 330, '2025-03-26 08:49:20', '2025-03-26 08:49:20'),
(5, 4, 14, 4, NULL, NULL, 1, 1, 0, 9, 200, 0, 0, 0, 200, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_quotation`
--

CREATE TABLE `product_quotation` (
  `id` int(10) UNSIGNED NOT NULL,
  `quotation_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_returns`
--

CREATE TABLE `product_returns` (
  `id` int(10) UNSIGNED NOT NULL,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_returns`
--

INSERT INTO `product_returns` (`id`, `return_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `sale_unit_id`, `net_unit_price`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 14, 1, NULL, NULL, 1, 9, 1.63, 0, 0, 0, 1.63, '2025-03-26 09:28:56', '2025-03-26 09:28:56');

-- --------------------------------------------------------

--
-- Table structure for table `product_sales`
--

CREATE TABLE `product_sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `dosage` text NOT NULL,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `return_qty` double NOT NULL DEFAULT 0,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_delivered` tinyint(1) DEFAULT NULL,
  `is_packing` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_sales`
--

INSERT INTO `product_sales` (`id`, `dosage`, `sale_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `return_qty`, `sale_unit_id`, `net_unit_price`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`, `is_delivered`, `is_packing`) VALUES
(1, '', 1, 14, 1, NULL, 'null', 2, 1, 9, 1.63, 0, 0, 0, 3.26, '2025-03-25 18:42:47', '2025-03-26 09:28:56', NULL, NULL),
(2, '', 2, 14, 1, NULL, 'null', 1, 0, 9, 1.63, 0, 0, 0, 1.63, '2025-03-25 18:48:59', '2025-03-25 18:51:03', NULL, NULL),
(3, '', 3, 14, 1, NULL, 'null', 3, 0, 9, 1.63, 0, 0, 0, 4.89, '2025-03-26 02:29:39', '2025-03-26 02:29:39', NULL, NULL),
(4, '', 4, 14, 1, NULL, 'null', 80, 0, 9, 25, 0, 0, 0, 2000, '2025-03-26 08:51:58', '2025-03-26 08:51:58', NULL, NULL),
(5, '', 5, 14, 1, NULL, 'null', 10, 0, 9, 1.63, 0, 0, 0, 16.29, '2025-03-26 08:59:20', '2025-03-26 08:59:20', NULL, NULL),
(6, 'once daily', 6, 15, 3, NULL, 'null,null', 4, 0, 9, 0.33, 0, 0, 0, 1.3, '2025-03-26 09:22:57', '2025-03-26 09:22:57', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_transfer`
--

CREATE TABLE `product_transfer` (
  `id` int(10) UNSIGNED NOT NULL,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `item_code` varchar(255) NOT NULL,
  `additional_cost` double DEFAULT NULL,
  `additional_price` double DEFAULT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_warehouse`
--

CREATE TABLE `product_warehouse` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `qty` double NOT NULL,
  `price` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_warehouse`
--

INSERT INTO `product_warehouse` (`id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `warehouse_id`, `qty`, `price`, `created_at`, `updated_at`) VALUES
(1, '1', NULL, NULL, NULL, 1, 10, 20, '2023-05-28 06:59:29', '2023-05-28 07:00:57'),
(2, '14', 1, NULL, NULL, 1, 108, NULL, '2025-03-25 18:32:06', '2025-03-26 09:28:56'),
(3, '13', 2, NULL, NULL, 1, 120, NULL, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(4, '15', 3, NULL, NULL, 1, 56, NULL, '2025-03-26 08:49:20', '2025-03-26 09:22:57'),
(5, '14', 4, NULL, NULL, 1, 12, NULL, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` int(11) NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `paid_amount` double NOT NULL,
  `status` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `reference_no`, `user_id`, `warehouse_id`, `supplier_id`, `currency_id`, `exchange_rate`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_cost`, `order_tax_rate`, `order_tax`, `order_discount`, `shipping_cost`, `grand_total`, `paid_amount`, `status`, `payment_status`, `document`, `note`, `created_at`, `updated_at`) VALUES
(1, 'pr-20230528-125929', 1, 1, NULL, 1, 1, 1, 10, 0, 10, 110, 0, 0, 0, 0, 110, 0, 1, 1, NULL, NULL, '2023-05-28 06:59:29', '2023-05-28 06:59:29'),
(2, '1234', 2, 1, 1, 1, 0.06517, 2, 20, 0, 0, 3000, 10, 300, 0, 0, 3300, 0, 1, 1, NULL, NULL, '2025-03-25 00:00:00', '2025-03-25 18:32:06'),
(3, '56789', 3, 1, 1, 2, 100, 1, 60, 0, 30, 330, 10, 33, 0, 0, 363, 0, 1, 1, NULL, NULL, '2025-03-29 00:00:00', '2025-03-26 08:49:20'),
(4, '8789t9037', 1, 1, 1, 2, 1, 1, 1, 0, 0, 200, 0, 0, 0, 0, 200, 0, 1, 1, NULL, NULL, '2025-03-26 00:00:00', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_product_return`
--

CREATE TABLE `purchase_product_return` (
  `id` int(10) UNSIGNED NOT NULL,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

CREATE TABLE `quotations` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `quotation_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `refills`
--

CREATE TABLE `refills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `refill_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `warehouse_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refills`
--

INSERT INTO `refills` (`id`, `customer_id`, `created_at`, `refill_note`, `staff_note`, `updated_at`, `warehouse_id`) VALUES
(1, 3, '2025-03-26 01:37:34', NULL, NULL, '2025-03-26 01:37:34', 1);

-- --------------------------------------------------------

--
-- Table structure for table `refill_items`
--

CREATE TABLE `refill_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `refill_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `refill_interval` int(11) NOT NULL,
  `refill_unit` enum('days','weeks','months') NOT NULL,
  `refill_until` date NOT NULL,
  `next_refill_date` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refill_items`
--

INSERT INTO `refill_items` (`id`, `refill_id`, `product_id`, `quantity`, `refill_interval`, `refill_unit`, `refill_until`, `next_refill_date`, `created_at`, `updated_at`) VALUES
(1, 1, 14, 1, 2, 'months', '2025-04-06', NULL, '2025-03-26 01:37:34', '2025-03-26 01:37:34');

-- --------------------------------------------------------

--
-- Table structure for table `returns`
--

CREATE TABLE `returns` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `return_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `returns`
--

INSERT INTO `returns` (`id`, `reference_no`, `user_id`, `sale_id`, `cash_register_id`, `customer_id`, `warehouse_id`, `biller_id`, `account_id`, `currency_id`, `exchange_rate`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_price`, `order_tax_rate`, `order_tax`, `grand_total`, `document`, `return_note`, `staff_note`, `created_at`, `updated_at`) VALUES
(1, 'rr-20250326-092856', 1, 1, 1, 2, 1, 1, 1, 1, 0.06517, 1, 1, 0, 0, 1.63, 0, 0, 1.63, NULL, NULL, NULL, '2025-03-26 09:28:56', '2025-03-26 09:28:56');

-- --------------------------------------------------------

--
-- Table structure for table `return_purchases`
--

CREATE TABLE `return_purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `return_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reward_point_settings`
--

CREATE TABLE `reward_point_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `per_point_amount` double NOT NULL,
  `minimum_amount` double NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `guard_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `is_active`, `created_at`, `updated_at`, `guard_name`) VALUES
(1, 'Admin', 'Pharmacy administrator', 1, '2018-06-01 23:46:44', '2025-02-18 10:13:19', 'web'),
(2, 'Super Admin', 'GogoPlus Technical Support', 1, '2018-10-22 02:38:13', '2025-02-18 10:49:13', 'web'),
(5, 'Staff', 'Pharmacy Staff', 0, '2020-11-05 06:43:16', '2025-02-18 10:50:13', 'web'),
(7, 'Pharmacist', 'Pharnacist', 1, '2025-02-18 12:00:10', '2025-02-18 12:00:10', 'web');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(4, 1),
(4, 2),
(4, 5),
(4, 7),
(5, 1),
(5, 2),
(5, 5),
(5, 7),
(6, 1),
(6, 2),
(6, 5),
(6, 7),
(7, 1),
(7, 2),
(7, 5),
(7, 7),
(8, 1),
(8, 2),
(8, 5),
(8, 7),
(9, 1),
(9, 2),
(9, 5),
(9, 7),
(10, 1),
(10, 2),
(10, 5),
(10, 7),
(11, 1),
(11, 2),
(12, 1),
(12, 2),
(12, 5),
(12, 7),
(13, 1),
(13, 2),
(13, 5),
(13, 7),
(14, 1),
(14, 2),
(14, 5),
(15, 1),
(15, 2),
(16, 1),
(16, 2),
(16, 5),
(16, 7),
(17, 1),
(17, 2),
(17, 5),
(17, 7),
(18, 1),
(18, 2),
(18, 5),
(18, 7),
(19, 1),
(19, 2),
(20, 1),
(20, 2),
(20, 5),
(20, 7),
(21, 1),
(21, 2),
(21, 5),
(21, 7),
(22, 1),
(22, 2),
(22, 5),
(22, 7),
(23, 1),
(23, 2),
(24, 1),
(24, 2),
(24, 5),
(24, 7),
(25, 1),
(25, 2),
(25, 5),
(25, 7),
(26, 1),
(26, 2),
(26, 5),
(26, 7),
(27, 1),
(27, 2),
(28, 1),
(28, 2),
(28, 5),
(28, 7),
(29, 1),
(29, 2),
(29, 5),
(29, 7),
(30, 1),
(30, 2),
(30, 5),
(30, 7),
(31, 1),
(31, 2),
(32, 1),
(32, 2),
(32, 5),
(33, 1),
(33, 2),
(33, 5),
(34, 1),
(34, 2),
(34, 5),
(35, 1),
(35, 2),
(35, 5),
(36, 1),
(36, 2),
(36, 5),
(36, 7),
(37, 1),
(37, 2),
(37, 5),
(37, 7),
(38, 1),
(38, 2),
(38, 5),
(38, 7),
(39, 1),
(39, 2),
(39, 5),
(39, 7),
(40, 1),
(40, 2),
(40, 5),
(40, 7),
(41, 1),
(41, 2),
(41, 5),
(41, 7),
(42, 1),
(42, 2),
(42, 7),
(43, 1),
(43, 2),
(43, 7),
(44, 1),
(44, 2),
(45, 1),
(45, 2),
(45, 5),
(45, 7),
(46, 1),
(46, 2),
(46, 5),
(46, 7),
(47, 1),
(47, 2),
(47, 5),
(47, 7),
(48, 1),
(48, 2),
(48, 5),
(48, 7),
(49, 1),
(49, 2),
(49, 5),
(49, 7),
(50, 1),
(50, 2),
(50, 5),
(50, 7),
(51, 1),
(51, 2),
(51, 5),
(51, 7),
(52, 1),
(52, 2),
(52, 5),
(52, 7),
(53, 1),
(53, 2),
(53, 5),
(53, 7),
(54, 1),
(54, 2),
(54, 5),
(55, 1),
(55, 2),
(55, 5),
(55, 7),
(56, 1),
(56, 2),
(56, 5),
(56, 7),
(57, 1),
(57, 2),
(57, 5),
(57, 7),
(58, 1),
(58, 2),
(59, 2),
(59, 5),
(60, 2),
(61, 2),
(62, 1),
(62, 2),
(63, 1),
(63, 2),
(63, 5),
(63, 7),
(64, 1),
(64, 2),
(64, 5),
(64, 7),
(65, 1),
(65, 2),
(65, 5),
(65, 7),
(66, 1),
(66, 2),
(67, 1),
(67, 2),
(67, 5),
(68, 1),
(68, 2),
(69, 1),
(69, 2),
(69, 5),
(70, 1),
(70, 2),
(71, 1),
(71, 2),
(72, 1),
(72, 2),
(73, 1),
(73, 2),
(73, 5),
(74, 1),
(74, 2),
(75, 1),
(75, 2),
(76, 1),
(76, 2),
(77, 1),
(77, 2),
(77, 7),
(78, 1),
(78, 2),
(78, 5),
(78, 7),
(79, 1),
(79, 2),
(79, 5),
(79, 7),
(80, 2),
(81, 1),
(81, 2),
(81, 5),
(81, 7),
(82, 1),
(82, 2),
(83, 2),
(84, 1),
(84, 2),
(84, 5),
(84, 7),
(85, 1),
(85, 2),
(85, 5),
(85, 7),
(86, 1),
(86, 2),
(86, 5),
(87, 1),
(87, 2),
(87, 5),
(87, 7),
(88, 1),
(88, 2),
(88, 5),
(88, 7),
(89, 1),
(89, 2),
(90, 1),
(90, 2),
(90, 5),
(90, 7),
(91, 1),
(91, 2),
(92, 1),
(92, 2),
(92, 5),
(92, 7),
(93, 1),
(93, 2),
(93, 5),
(94, 1),
(94, 2),
(95, 1),
(95, 2),
(96, 1),
(96, 2),
(97, 1),
(97, 2),
(98, 1),
(98, 2),
(98, 5),
(98, 7),
(99, 1),
(99, 2),
(99, 5),
(99, 7),
(100, 1),
(100, 2),
(100, 5),
(100, 7),
(101, 1),
(101, 2),
(101, 5),
(101, 7),
(102, 1),
(102, 2),
(102, 5),
(102, 7),
(103, 1),
(103, 2),
(103, 5),
(103, 7),
(104, 2),
(105, 1),
(105, 2),
(105, 7),
(106, 1),
(106, 2),
(106, 5),
(106, 7),
(107, 1),
(107, 2),
(107, 5),
(107, 7),
(108, 1),
(108, 2),
(108, 5),
(108, 7),
(109, 1),
(109, 2),
(109, 5),
(109, 7),
(110, 1),
(110, 2),
(110, 5),
(110, 7),
(111, 1),
(111, 2),
(111, 5),
(111, 7),
(112, 1),
(112, 2),
(112, 5),
(112, 7),
(113, 1),
(113, 2),
(113, 5),
(113, 7),
(114, 1),
(114, 2),
(114, 5),
(114, 7),
(115, 1),
(115, 2),
(115, 5),
(115, 7),
(116, 1),
(116, 2),
(117, 1),
(117, 2),
(117, 5),
(117, 7),
(118, 1),
(118, 2),
(118, 5),
(118, 7),
(119, 1),
(119, 2),
(119, 5),
(120, 1),
(120, 2),
(121, 1),
(121, 2),
(121, 5),
(121, 7),
(122, 1),
(122, 2),
(122, 5),
(122, 7),
(123, 1),
(123, 2),
(123, 5),
(123, 7),
(124, 1),
(124, 2),
(124, 5),
(124, 7),
(125, 1),
(125, 2),
(125, 5),
(126, 2),
(126, 7),
(127, 1),
(127, 2),
(127, 5),
(128, 1),
(128, 2),
(128, 5),
(129, 1),
(129, 2),
(129, 5),
(130, 1),
(130, 2),
(131, 2),
(132, 1),
(132, 2),
(132, 5);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `queue` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `grand_total` double NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount_type` varchar(255) DEFAULT NULL,
  `order_discount_value` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `coupon_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `sale_status` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `sale_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `reference_no`, `user_id`, `cash_register_id`, `table_id`, `queue`, `customer_id`, `warehouse_id`, `biller_id`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_price`, `grand_total`, `currency_id`, `exchange_rate`, `order_tax_rate`, `order_tax`, `order_discount_type`, `order_discount_value`, `order_discount`, `coupon_id`, `coupon_discount`, `shipping_cost`, `sale_status`, `payment_status`, `document`, `paid_amount`, `sale_note`, `staff_note`, `created_at`, `updated_at`) VALUES
(1, 'posr-20250325-064247', 2, 2, NULL, NULL, 2, 1, 1, 1, 2, 0, 0, 3.26, 3.26, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 4, 4, NULL, 3.26, NULL, NULL, '2025-03-25 18:42:47', '2025-03-26 09:28:56'),
(2, '1234', 2, 2, NULL, NULL, 2, 1, 1, 1, 1, 0, 0, 1.63, 1.63, 1, 0.06517, 0, 0, 'Flat', 0, 0, NULL, NULL, 0, 1, 2, NULL, 0, NULL, NULL, '2025-03-25 18:51:03', '2025-03-25 18:51:03'),
(3, 'posr-20250326-022939', 3, 3, NULL, NULL, 1, 1, 1, 1, 3, 0, 0, 4.89, 4.89, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 3, 2, NULL, 0, NULL, NULL, '2025-03-26 02:29:39', '2025-03-26 02:29:39'),
(4, '67879', 3, 3, NULL, NULL, 3, 1, 1, 1, 80, 0, 0, 2000, 2000, 2, 100, 0, 0, 'Flat', NULL, 0, NULL, NULL, 0, 2, 1, NULL, 0, NULL, NULL, '2025-04-02 08:51:58', '2025-03-26 08:51:58'),
(5, '89089', 3, 3, NULL, NULL, 3, 1, 1, 1, 10, 0, 0, 16.29, 16.29, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, NULL, 0, 1, 3, NULL, 8, NULL, NULL, '2025-04-02 08:59:20', '2025-03-26 08:59:20'),
(6, 'posr-20250326-092257', 1, 1, NULL, NULL, 1, 1, 1, 1, 4, 0, 0, 1.3, 1.3, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 1, 4, NULL, 1.3, NULL, NULL, '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `sent_sms`
--

CREATE TABLE `sent_sms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'sent',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shelves`
--

CREATE TABLE `shelves` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shelves`
--

INSERT INTO `shelves` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'general', '2025-03-25 17:59:32', '2025-03-25 17:59:32'),
(3, 'stomach', '2025-03-25 18:21:57', '2025-03-25 18:21:57');

-- --------------------------------------------------------

--
-- Table structure for table `sms_templates`
--

CREATE TABLE `sms_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_default_ecommerce` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_counts`
--

CREATE TABLE `stock_counts` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `category_id` varchar(255) DEFAULT NULL,
  `brand_id` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `initial_file` varchar(255) DEFAULT NULL,
  `final_file` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_adjusted` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) NOT NULL,
  `vat_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `image`, `company_name`, `vat_number`, `email`, `phone_number`, `address`, `city`, `state`, `postal_code`, `country`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'John Doe', NULL, 'Test Company', NULL, 'john@gmail.com', '231312', 'Test address', 'Test City', NULL, NULL, NULL, 1, '2023-05-28 06:53:04', '2023-05-28 06:53:04');

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `number_of_person` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `name`, `rate`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'VAT 10%', 10, 1, '2023-05-28 06:52:08', '2023-05-28 06:52:08');

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `from_warehouse_id` int(11) NOT NULL,
  `to_warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_sent` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(10) UNSIGNED NOT NULL,
  `unit_code` varchar(255) NOT NULL,
  `unit_name` varchar(255) NOT NULL,
  `base_unit` int(11) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `operation_value` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_code`, `unit_name`, `base_unit`, `operator`, `operation_value`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'PIECE', 'PIECE', NULL, '*', 1, 1, '2023-05-28 06:51:50', '2025-02-04 17:06:26'),
(2, 'AMPOULE', 'AMPOULE', NULL, '*', 1, 1, '2025-02-04 17:07:04', '2025-02-04 17:07:04'),
(3, 'SACHET', 'SACHET', NULL, '*', 1, 1, '2025-02-04 17:07:20', '2025-02-04 17:07:20'),
(4, 'TAB', 'TAB', NULL, '*', 1, 1, '2025-02-04 17:07:31', '2025-02-04 17:07:31'),
(5, 'TUBE', 'TUBE', NULL, '*', 1, 1, '2025-02-04 17:07:42', '2025-02-04 17:07:42'),
(6, 'VIAL', 'VIAL', NULL, '*', 1, 1, '2025-02-04 17:07:56', '2025-02-04 17:07:56'),
(7, 'BOTTLE', 'BOTTLE', NULL, '*', 1, 1, '2025-02-04 17:08:09', '2025-02-04 17:08:09'),
(8, 'CAP', 'CAP', NULL, '*', 1, 1, '2025-02-04 17:08:24', '2025-02-04 17:08:24'),
(9, 'BOX', 'BOX', NULL, '*', 1, 1, '2025-02-04 17:08:35', '2025-02-04 17:08:35'),
(10, 'JAR', 'JAR', NULL, '*', 1, 1, '2025-02-04 17:08:46', '2025-02-04 17:08:46'),
(11, 'DROP', 'DROP', NULL, '*', 1, 1, '2025-02-04 17:08:57', '2025-02-04 17:08:57'),
(12, 'SINGLE', 'SINGLE', NULL, '*', 1, 1, '2025-02-04 17:09:10', '2025-02-04 17:09:10'),
(13, 'CAN', 'CAN', NULL, '*', 1, 1, '2025-02-04 17:09:21', '2025-02-04 17:09:21'),
(14, 'SUPP', 'SUPP', NULL, '*', 1, 1, '2025-02-04 17:09:35', '2025-02-04 17:09:35'),
(15, 'STRIP', 'STRIP', NULL, '*', 1, 1, '2025-02-04 17:09:52', '2025-02-04 17:09:52'),
(16, 'PESS', 'PESS', NULL, '*', 1, 1, '2025-02-04 17:10:04', '2025-02-04 17:10:04'),
(17, 'LOZENGES', 'LOZENGES', NULL, '*', 1, 1, '2025-02-04 17:10:24', '2025-02-04 17:10:24'),
(18, 'POUCH', 'POUCH', NULL, '*', 1, 1, '2025-02-04 17:10:39', '2025-02-04 17:10:39'),
(19, 'BAG', 'BAG', NULL, '*', 1, 1, '2025-02-04 17:10:49', '2025-02-04 17:10:49'),
(20, 'No Unit', 'No Unit', NULL, '*', 1, 1, '2025-02-04 17:11:30', '2025-02-04 17:11:30'),
(21, 'PACK', 'PACK', NULL, '*', 1, 1, '2025-02-04 17:15:31', '2025-02-04 17:15:31');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `phone`, `company_name`, `role_id`, `biller_id`, `warehouse_id`, `is_active`, `is_deleted`) VALUES
(1, 'intern', 'giftybuah@gmail.com', '$2y$10$gtlKmhPKO0iLrXVyhcTaQ.DlEgDX66LqhS0slYrNBpsqIOV6ZwATC', 'pEN60GwtkCZFKVT6tvmmCiYvHqvDX4znpKTdgDca9wxdfVmtbxRixIxH0RzJ', '2018-06-02 03:24:15', '2025-03-24 23:20:25', '0247118423', 'Intern Pharmacy', 2, NULL, NULL, 1, 0),
(2, 'iddrisu', 'iddrisu442g@gmail.com', '$2y$10$WwNSDcjyJzDoEFFC1s2MTuGx5UrmgBhj7iwNceFJqOTA6IgAB7QUe', NULL, '2025-03-24 20:36:04', '2025-03-24 23:15:12', '0550936771', 'Intern Pharmacy', 1, NULL, NULL, 1, 0),
(3, 'obed', 'ninsonobed5630@gmail.com', '$2y$10$vPfQAb2/onfHCkKOJzzbtOU1TtzRKEjldvuEzdgZPsGQZEPavXfGC', NULL, '2025-03-24 20:39:36', '2025-03-24 23:16:16', '0256422216', 'Intern Pharmacy', 1, NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `variants`
--

CREATE TABLE `variants` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `name`, `phone`, `email`, `address`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Shop', '9991111', NULL, 'Test address', 1, '2023-05-28 06:51:19', '2023-05-28 06:51:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `action_logs`
--
ALTER TABLE `action_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `action_id` (`action_id`);

--
-- Indexes for table `adjustments`
--
ALTER TABLE `adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `barcodes`
--
ALTER TABLE `barcodes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billers`
--
ALTER TABLE `billers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cash_registers`
--
ALTER TABLE `cash_registers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `challans`
--
ALTER TABLE `challans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `couriers`
--
ALTER TABLE `couriers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_groups`
--
ALTER TABLE `customer_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_fields`
--
ALTER TABLE `custom_fields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plans`
--
ALTER TABLE `discount_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plan_customers`
--
ALTER TABLE `discount_plan_customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plan_discounts`
--
ALTER TABLE `discount_plan_discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dso_alerts`
--
ALTER TABLE `dso_alerts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `external_services`
--
ALTER TABLE `external_services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gift_cards`
--
ALTER TABLE `gift_cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gift_card_recharges`
--
ALTER TABLE `gift_card_recharges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hrm_settings`
--
ALTER TABLE `hrm_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `incomes`
--
ALTER TABLE `incomes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `income_categories`
--
ALTER TABLE `income_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `insurance_provider`
--
ALTER TABLE `insurance_provider`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mail_settings`
--
ALTER TABLE `mail_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `money_transfers`
--
ALTER TABLE `money_transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `packing_slips`
--
ALTER TABLE `packing_slips`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packing_slip_products`
--
ALTER TABLE `packing_slip_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_cheque`
--
ALTER TABLE `payment_with_cheque`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_credit_card`
--
ALTER TABLE `payment_with_credit_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_gift_card`
--
ALTER TABLE `payment_with_gift_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_insurance`
--
ALTER TABLE `payment_with_insurance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_mobile_money`
--
ALTER TABLE `payment_with_mobile_money`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_paypal`
--
ALTER TABLE `payment_with_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payrolls`
--
ALTER TABLE `payrolls`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pos_setting`
--
ALTER TABLE `pos_setting`
  ADD UNIQUE KEY `pos_setting_id_unique` (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_batches`
--
ALTER TABLE `product_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_purchases`
--
ALTER TABLE `product_purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_quotation`
--
ALTER TABLE `product_quotation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_returns`
--
ALTER TABLE `product_returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_sales`
--
ALTER TABLE `product_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_transfer`
--
ALTER TABLE `product_transfer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_product_return`
--
ALTER TABLE `purchase_product_return`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quotations`
--
ALTER TABLE `quotations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refills`
--
ALTER TABLE `refills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refill_items`
--
ALTER TABLE `refill_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `refill_items_next_refill_date_index` (`next_refill_date`);

--
-- Indexes for table `returns`
--
ALTER TABLE `returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `return_purchases`
--
ALTER TABLE `return_purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reward_point_settings`
--
ALTER TABLE `reward_point_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sent_sms`
--
ALTER TABLE `sent_sms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sent_sms_customer_id_index` (`customer_id`),
  ADD KEY `sent_sms_phone_number_index` (`phone_number`);

--
-- Indexes for table `shelves`
--
ALTER TABLE `shelves`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shelves_name_index` (`name`);

--
-- Indexes for table `sms_templates`
--
ALTER TABLE `sms_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_counts`
--
ALTER TABLE `stock_counts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `variants`
--
ALTER TABLE `variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `action_logs`
--
ALTER TABLE `action_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `adjustments`
--
ALTER TABLE `adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `barcodes`
--
ALTER TABLE `barcodes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `billers`
--
ALTER TABLE `billers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cash_registers`
--
ALTER TABLE `cash_registers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `challans`
--
ALTER TABLE `challans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `couriers`
--
ALTER TABLE `couriers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customer_groups`
--
ALTER TABLE `customer_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `custom_fields`
--
ALTER TABLE `custom_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plans`
--
ALTER TABLE `discount_plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plan_customers`
--
ALTER TABLE `discount_plan_customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plan_discounts`
--
ALTER TABLE `discount_plan_discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dso_alerts`
--
ALTER TABLE `dso_alerts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `external_services`
--
ALTER TABLE `external_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `gift_cards`
--
ALTER TABLE `gift_cards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gift_card_recharges`
--
ALTER TABLE `gift_card_recharges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hrm_settings`
--
ALTER TABLE `hrm_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `incomes`
--
ALTER TABLE `incomes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `income_categories`
--
ALTER TABLE `income_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `insurance_provider`
--
ALTER TABLE `insurance_provider`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mail_settings`
--
ALTER TABLE `mail_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;

--
-- AUTO_INCREMENT for table `money_transfers`
--
ALTER TABLE `money_transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packing_slips`
--
ALTER TABLE `packing_slips`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packing_slip_products`
--
ALTER TABLE `packing_slip_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_with_cheque`
--
ALTER TABLE `payment_with_cheque`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_credit_card`
--
ALTER TABLE `payment_with_credit_card`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_gift_card`
--
ALTER TABLE `payment_with_gift_card`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_insurance`
--
ALTER TABLE `payment_with_insurance`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_mobile_money`
--
ALTER TABLE `payment_with_mobile_money`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payment_with_paypal`
--
ALTER TABLE `payment_with_paypal`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payrolls`
--
ALTER TABLE `payrolls`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_batches`
--
ALTER TABLE `product_batches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_purchases`
--
ALTER TABLE `product_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_quotation`
--
ALTER TABLE `product_quotation`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_returns`
--
ALTER TABLE `product_returns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_sales`
--
ALTER TABLE `product_sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product_transfer`
--
ALTER TABLE `product_transfer`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `purchase_product_return`
--
ALTER TABLE `purchase_product_return`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotations`
--
ALTER TABLE `quotations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `refills`
--
ALTER TABLE `refills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `refill_items`
--
ALTER TABLE `refill_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `returns`
--
ALTER TABLE `returns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `return_purchases`
--
ALTER TABLE `return_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reward_point_settings`
--
ALTER TABLE `reward_point_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sent_sms`
--
ALTER TABLE `sent_sms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shelves`
--
ALTER TABLE `shelves`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sms_templates`
--
ALTER TABLE `sms_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_counts`
--
ALTER TABLE `stock_counts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `variants`
--
ALTER TABLE `variants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Database: `pharmacy4`
--
CREATE DATABASE IF NOT EXISTS `pharmacy4` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pharmacy4`;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_no` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `initial_balance` double DEFAULT NULL,
  `total_balance` double NOT NULL,
  `note` text DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'Bank Account',
  `parent_account_id` int(11) DEFAULT NULL,
  `is_payment` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `account_no`, `name`, `initial_balance`, `total_balance`, `note`, `is_default`, `is_active`, `created_at`, `updated_at`, `code`, `type`, `parent_account_id`, `is_payment`) VALUES
(1, '019912229', 'Sales Account', 0, 0, 'This is the default account.', 1, 1, '2023-02-05 07:12:15', '2023-02-05 07:12:15', NULL, 'Bank Account', NULL, 1),
(2, '0147852', 'idi', 10000, 10000, NULL, NULL, 1, '2025-03-26 07:58:20', '2025-03-26 07:58:20', NULL, 'Bank Account', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `action_logs`
--

CREATE TABLE `action_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `action_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `route` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `synced_at` timestamp NULL DEFAULT NULL,
  `pharmacy_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `adjustments`
--

CREATE TABLE `adjustments` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `total_qty` double NOT NULL,
  `item` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `employee_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `checkin` varchar(255) NOT NULL,
  `checkout` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `barcodes`
--

CREATE TABLE `barcodes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `width` double(22,4) DEFAULT NULL,
  `height` double(22,4) DEFAULT NULL,
  `paper_width` double(22,4) DEFAULT NULL,
  `paper_height` double(22,4) DEFAULT NULL,
  `top_margin` double(22,4) DEFAULT NULL,
  `left_margin` double(22,4) DEFAULT NULL,
  `row_distance` double(22,4) DEFAULT NULL,
  `col_distance` double(22,4) DEFAULT NULL,
  `stickers_in_one_row` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_continuous` tinyint(1) NOT NULL DEFAULT 0,
  `stickers_in_one_sheet` int(11) DEFAULT NULL,
  `is_custom` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barcodes`
--

INSERT INTO `barcodes` (`id`, `name`, `description`, `width`, `height`, `paper_width`, `paper_height`, `top_margin`, `left_margin`, `row_distance`, `col_distance`, `stickers_in_one_row`, `is_default`, `is_continuous`, `stickers_in_one_sheet`, `is_custom`, `created_at`, `updated_at`) VALUES
(1, '20 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 4\" x 1\", Labels per sheet: 20', 4.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.1250, 0.0000, 0.1875, 2, 0, 0, 20, NULL, NULL, NULL),
(2, '30 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2.625\" x 1\", Labels per sheet: 30', 2.6250, 1.0000, 8.5000, 11.0000, 0.5000, 0.1880, 0.0000, 0.1250, 3, 0, 0, 30, NULL, NULL, NULL),
(3, '32 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1.25\", Labels per sheet: 32', 2.0000, 1.2500, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 32, NULL, NULL, NULL),
(4, '40 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1\", Labels per sheet: 40', 2.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 40, NULL, NULL, NULL),
(5, '50 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 1.5\" x 1\", Labels per sheet: 50', 1.5000, 1.0000, 8.5000, 11.0000, 0.5000, 0.5000, 0.0000, 0.0000, 5, 0, 0, 50, NULL, NULL, NULL),
(6, 'Continuous Rolls - 31.75mm x 25.4mm', 'Label Size: 31.75mm x 25.4mm, Gap: 3.18mm', 1.2500, 1.0000, 1.2500, 0.0000, 0.1250, 0.0000, 0.1250, 0.0000, 1, 0, 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `billers`
--

CREATE TABLE `billers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) NOT NULL,
  `vat_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `billers`
--

INSERT INTO `billers` (`id`, `name`, `image`, `company_name`, `vat_number`, `email`, `phone_number`, `address`, `city`, `state`, `postal_code`, `country`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Biller', NULL, 'Test Company', NULL, 'test@gmail.com', '12312', 'Test address', 'Test City', NULL, NULL, NULL, 1, '2023-05-28 06:53:51', '2023-05-28 06:53:51');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `title`, `image`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Brand', NULL, 1, '2023-05-28 06:51:38', '2023-05-28 06:51:38'),
(2, 'GB Pharma Limited', NULL, 1, '2025-03-25 17:44:43', '2025-03-25 17:44:43'),
(3, 'letap', NULL, 1, '2025-03-25 18:18:26', '2025-03-25 18:18:26');

-- --------------------------------------------------------

--
-- Table structure for table `cash_registers`
--

CREATE TABLE `cash_registers` (
  `id` int(10) UNSIGNED NOT NULL,
  `cash_in_hand` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cash_registers`
--

INSERT INTO `cash_registers` (`id`, `cash_in_hand`, `user_id`, `warehouse_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 0, 1, 1, 1, '2025-03-24 21:08:52', '2025-03-24 21:08:52'),
(2, 100, 2, 1, 1, '2025-03-25 17:31:46', '2025-03-25 17:31:46'),
(3, 12, 3, 1, 1, '2025-03-26 01:01:11', '2025-03-26 01:01:11');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image`, `parent_id`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Category', NULL, NULL, 1, '2023-05-28 06:51:00', '2023-05-28 06:51:00'),
(2, 'pain killer', NULL, NULL, 1, '2025-03-25 17:51:01', '2025-03-25 17:51:01'),
(3, 'ulcer', NULL, NULL, 1, '2025-03-25 18:18:50', '2025-03-25 18:18:50');

-- --------------------------------------------------------

--
-- Table structure for table `challans`
--

CREATE TABLE `challans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `courier_id` int(11) NOT NULL,
  `packing_slip_list` longtext NOT NULL,
  `amount_list` longtext NOT NULL,
  `cash_list` longtext DEFAULT NULL,
  `online_payment_list` longtext DEFAULT NULL,
  `cheque_list` longtext DEFAULT NULL,
  `delivery_charge_list` longtext DEFAULT NULL,
  `status_list` longtext DEFAULT NULL,
  `closing_date` date DEFAULT NULL,
  `created_by_id` int(11) NOT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `minimum_amount` double DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `used` int(11) NOT NULL,
  `expired_date` date NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `couriers`
--

CREATE TABLE `couriers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `couriers`
--

INSERT INTO `couriers` (`id`, `name`, `phone_number`, `address`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'obed', '0550936582', 'dome', 1, '2025-03-25 18:56:49', '2025-03-25 18:56:49'),
(2, 'kofi', '0550934168', 'lapaz', 1, '2025-03-25 18:57:41', '2025-03-25 18:57:41');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `exchange_rate` double NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `code`, `exchange_rate`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'US Dollar', 'USD', 0.06517, 1, '2020-11-01 00:22:58', '2025-02-04 17:17:08'),
(2, 'GHANA CEDI', 'GHS', 1, 1, '2025-02-04 17:17:29', '2025-02-04 17:17:29');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `tax_no` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `points` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deposit` double DEFAULT NULL,
  `expense` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customer_group_id`, `user_id`, `name`, `company_name`, `email`, `phone_number`, `tax_no`, `address`, `city`, `state`, `postal_code`, `country`, `points`, `is_active`, `created_at`, `updated_at`, `deposit`, `expense`) VALUES
(1, 1, NULL, 'John Doe', 'Test Company', 'john@gmail.com', '231312', NULL, 'Test address', 'Test City', NULL, NULL, NULL, NULL, 1, '2023-05-28 06:53:04', '2023-05-28 06:53:04', NULL, NULL),
(2, 1, NULL, 'tahiru', NULL, 'tahiru@gmail.com', '0550936771', NULL, 'anyaa', 'accra', NULL, NULL, NULL, NULL, 1, '2025-03-25 16:59:54', '2025-03-25 16:59:54', NULL, NULL),
(3, 1, NULL, 'obed', NULL, 'oninson45@gmail.com', '0256422216', NULL, NULL, 'Amasaman', NULL, NULL, NULL, NULL, 1, '2025-03-26 01:30:48', '2025-03-26 01:30:48', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_groups`
--

CREATE TABLE `customer_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `percentage` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_groups`
--

INSERT INTO `customer_groups` (`id`, `name`, `percentage`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'General', '0', 1, '2023-05-28 06:51:29', '2023-05-28 06:51:29');

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

CREATE TABLE `custom_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `belongs_to` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `default_value` text DEFAULT NULL,
  `option_value` text DEFAULT NULL,
  `grid_value` int(11) NOT NULL,
  `is_table` tinyint(1) NOT NULL,
  `is_invoice` tinyint(1) NOT NULL,
  `is_required` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_disable` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `packing_slip_ids` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `courier_id` int(11) DEFAULT NULL,
  `address` text NOT NULL,
  `delivered_by` varchar(255) DEFAULT NULL,
  `recieved_by` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`id`, `reference_no`, `sale_id`, `packing_slip_ids`, `user_id`, `courier_id`, `address`, `delivered_by`, `recieved_by`, `file`, `note`, `status`, `created_at`, `updated_at`) VALUES
(1, 'dr-20250325-065125', 2, NULL, 2, 1, 'anyaa accra', NULL, NULL, NULL, NULL, '3', '2025-03-25 18:51:45', '2025-03-25 18:58:26');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` int(10) UNSIGNED NOT NULL,
  `amount` double NOT NULL,
  `customer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `applicable_for` varchar(255) NOT NULL,
  `product_list` longtext DEFAULT NULL,
  `valid_from` date NOT NULL,
  `valid_till` date NOT NULL,
  `type` varchar(255) NOT NULL,
  `value` double NOT NULL,
  `minimum_qty` double NOT NULL,
  `maximum_qty` double NOT NULL,
  `days` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plans`
--

CREATE TABLE `discount_plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plan_customers`
--

CREATE TABLE `discount_plan_customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `discount_plan_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plan_discounts`
--

CREATE TABLE `discount_plan_discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `discount_id` int(11) NOT NULL,
  `discount_plan_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dso_alerts`
--

CREATE TABLE `dso_alerts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_info` longtext NOT NULL,
  `number_of_products` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `department_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `staff_id` varchar(191) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `expense_category_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `reference_no`, `expense_category_id`, `warehouse_id`, `account_id`, `user_id`, `cash_register_id`, `amount`, `note`, `created_at`, `updated_at`) VALUES
(1, 'er-20250325-063857', 1, 1, 1, 2, 2, 100, NULL, '2025-03-25 00:00:00', '2025-03-25 18:38:57');

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `code`, `name`, `is_active`, `created_at`, `updated_at`) VALUES
(1, '74965071', 'transportation', 1, '2025-03-25 18:38:22', '2025-03-25 18:38:22');

-- --------------------------------------------------------

--
-- Table structure for table `external_services`
--

CREATE TABLE `external_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `details` longtext NOT NULL,
  `module_status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`module_status`)),
  `active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `external_services`
--

INSERT INTO `external_services` (`id`, `name`, `type`, `details`, `module_status`, `active`, `created_at`, `updated_at`) VALUES
(1, 'PayPal', 'payment', 'Client ID,Client Secret;abcd1234,wxyz5678', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(2, 'Stripe', 'payment', 'Public Key,Private Key;efgh1234,stuv5678', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(3, 'Razorpay', 'payment', 'Key,Secret;rzp_test_Y4MCcpHfZNU6rR,3Hr7SDqaZ0G5waN0jsLgsiLx', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(4, 'Paystack', 'payment', 'public_Key,Secret_Key;pk_test_e8d220b7463d64569f0053e78534f38e6b10cf4a,sk_test_6d62cb976e1e0ab43f1e48b2934b0dfc7f32a1fe', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(5, 'Mollie', 'payment', 'api_key;test_dHar4XY7LxsDOtmnkVtjNVWXLSlXsM', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(6, 'Xendit', 'payment', 'secret_key,callback_token;xnd_development_aKJVKYbc4lHkEjcCLzWLrBsKs6jF6nbM6WaCMfnJerP3JW57CLis553XNRdDU,YPZxND92Mt8tdXntTYIEkRX802onZ5OcdKBUzycebuqYvN4n', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(7, 'bkash', 'payment', 'Mode,app_key,app_secret,username,password;sandbox,0vWQuCRGiUX7EPVjQDr0EUAYtc,jcUNPBgbcqEDedNKdvE4G1cAK7D3hCjmJccNPZZBq96QIxxwAMEx,01770618567,D7DaC<*E*eG', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(8, 'sslcommerz', 'payment', 'appkey,appsecret;12341234,asdfa23423', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(9, 'Mpesa', 'payment', 'consumer_Key,consumer_Secret;fhfgkj,dtrddhd', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(10, 'Pesapal', 'payment', 'Mode,Consumer Key,Consumer Secret;sandbox,qkio1BGGYAXTu2JOfm7XSXNruoZsrqEW,osGQ364R49cXKeOYSpaOnT++rHs=', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `site_title` varchar(255) NOT NULL,
  `site_logo` varchar(255) DEFAULT NULL,
  `is_rtl` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `currency` varchar(255) NOT NULL,
  `package_id` int(11) DEFAULT NULL,
  `subscription_type` varchar(255) DEFAULT NULL,
  `staff_access` varchar(255) NOT NULL,
  `without_stock` varchar(255) NOT NULL DEFAULT 'no',
  `date_format` varchar(255) NOT NULL,
  `developed_by` varchar(255) DEFAULT NULL,
  `invoice_format` varchar(255) DEFAULT NULL,
  `decimal` int(11) DEFAULT 2,
  `state` int(11) DEFAULT NULL,
  `theme` varchar(255) NOT NULL,
  `modules` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `currency_position` varchar(255) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `expiry_type` varchar(255) NOT NULL DEFAULT 'days',
  `expiry_value` varchar(255) NOT NULL DEFAULT '0',
  `is_zatca` tinyint(1) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `vat_registration_number` varchar(255) DEFAULT NULL,
  `is_packing_slip` tinyint(1) NOT NULL DEFAULT 0,
  `sms_credit` bigint(20) UNSIGNED DEFAULT NULL,
  `pharmacy_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `site_title`, `site_logo`, `is_rtl`, `created_at`, `updated_at`, `currency`, `package_id`, `subscription_type`, `staff_access`, `without_stock`, `date_format`, `developed_by`, `invoice_format`, `decimal`, `state`, `theme`, `modules`, `currency_position`, `expiry_date`, `expiry_type`, `expiry_value`, `is_zatca`, `company_name`, `vat_registration_number`, `is_packing_slip`, `sms_credit`, `pharmacy_id`) VALUES
(1, 'GogoPlus POS', '20250202043823.png', 0, '2018-07-06 06:13:11', '2025-03-24 20:23:33', '1', 3, 'monthly', 'own', 'no', 'd/m/Y', 'GogoPlus Ltd.', 'standard', 2, 1, 'default.css', '', 'prefix', '2025-05-03', 'days', '0', NULL, NULL, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `gift_cards`
--

CREATE TABLE `gift_cards` (
  `id` int(10) UNSIGNED NOT NULL,
  `card_no` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `expense` double NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gift_card_recharges`
--

CREATE TABLE `gift_card_recharges` (
  `id` int(10) UNSIGNED NOT NULL,
  `gift_card_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `note` text DEFAULT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hrm_settings`
--

CREATE TABLE `hrm_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `checkin` varchar(255) NOT NULL,
  `checkout` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `incomes`
--

CREATE TABLE `incomes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `income_category_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `income_categories`
--

CREATE TABLE `income_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `insurance_provider`
--

CREATE TABLE `insurance_provider` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mail_settings`
--

CREATE TABLE `mail_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `driver` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `port` varchar(255) NOT NULL,
  `from_address` varchar(255) NOT NULL,
  `from_name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `encryption` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_02_17_060412_create_categories_table', 1),
(4, '2018_02_20_035727_create_brands_table', 1),
(5, '2018_02_25_100635_create_suppliers_table', 1),
(6, '2018_02_27_101619_create_warehouse_table', 1),
(7, '2018_03_03_040448_create_units_table', 1),
(8, '2018_03_04_041317_create_taxes_table', 1),
(9, '2018_03_10_061915_create_customer_groups_table', 1),
(10, '2018_03_10_090534_create_customers_table', 1),
(11, '2018_03_11_095547_create_billers_table', 1),
(12, '2018_04_05_054401_create_products_table', 1),
(13, '2018_04_06_133606_create_purchases_table', 1),
(14, '2018_04_06_154600_create_product_purchases_table', 1),
(15, '2018_04_06_154915_create_product_warhouse_table', 1),
(16, '2018_04_10_085927_create_sales_table', 1),
(17, '2018_04_10_090133_create_product_sales_table', 1),
(18, '2018_04_10_090254_create_payments_table', 1),
(19, '2018_04_10_090341_create_payment_with_cheque_table', 1),
(20, '2018_04_10_090509_create_payment_with_credit_card_table', 1),
(21, '2018_04_13_121436_create_quotation_table', 1),
(22, '2018_04_13_122324_create_product_quotation_table', 1),
(23, '2018_04_14_121802_create_transfers_table', 1),
(24, '2018_04_14_121913_create_product_transfer_table', 1),
(25, '2018_05_13_082847_add_payment_id_and_change_sale_id_to_payments_table', 1),
(26, '2018_05_13_090906_change_customer_id_to_payment_with_credit_card_table', 1),
(27, '2018_05_20_054532_create_adjustments_table', 1),
(28, '2018_05_20_054859_create_product_adjustments_table', 1),
(29, '2018_05_21_163419_create_returns_table', 1),
(30, '2018_05_21_163443_create_product_returns_table', 1),
(31, '2018_06_02_050905_create_roles_table', 1),
(32, '2018_06_02_073430_add_columns_to_users_table', 1),
(33, '2018_06_03_053738_create_permission_tables', 1),
(34, '2018_06_21_063736_create_pos_setting_table', 1),
(35, '2018_06_21_094155_add_user_id_to_sales_table', 1),
(36, '2018_06_21_101529_add_user_id_to_purchases_table', 1),
(37, '2018_06_21_103512_add_user_id_to_transfers_table', 1),
(38, '2018_06_23_061058_add_user_id_to_quotations_table', 1),
(39, '2018_06_23_082427_add_is_deleted_to_users_table', 1),
(40, '2018_06_25_043308_change_email_to_users_table', 1),
(41, '2018_07_06_115449_create_general_settings_table', 1),
(42, '2018_07_08_043944_create_languages_table', 1),
(43, '2018_07_11_102144_add_user_id_to_returns_table', 1),
(44, '2018_07_11_102334_add_user_id_to_payments_table', 1),
(45, '2018_07_22_130541_add_digital_to_products_table', 1),
(46, '2018_07_24_154250_create_deliveries_table', 1),
(47, '2018_08_16_053336_create_expense_categories_table', 1),
(48, '2018_08_17_115415_create_expenses_table', 1),
(49, '2018_08_18_050418_create_gift_cards_table', 1),
(50, '2018_08_19_063119_create_payment_with_gift_card_table', 1),
(51, '2018_08_25_042333_create_gift_card_recharges_table', 1),
(52, '2018_08_25_101354_add_deposit_expense_to_customers_table', 1),
(53, '2018_08_26_043801_create_deposits_table', 1),
(54, '2018_09_02_044042_add_keybord_active_to_pos_setting_table', 1),
(55, '2018_09_09_092713_create_payment_with_paypal_table', 1),
(56, '2018_09_10_051254_add_currency_to_general_settings_table', 1),
(57, '2018_10_22_084118_add_biller_and_store_id_to_users_table', 1),
(58, '2018_10_26_034927_create_coupons_table', 1),
(59, '2018_10_27_090857_add_coupon_to_sales_table', 1),
(60, '2018_11_07_070155_add_currency_position_to_general_settings_table', 1),
(61, '2018_11_19_094650_add_combo_to_products_table', 1),
(62, '2018_12_09_043712_create_accounts_table', 1),
(63, '2018_12_17_112253_add_is_default_to_accounts_table', 1),
(64, '2018_12_19_103941_add_account_id_to_payments_table', 1),
(65, '2018_12_20_065900_add_account_id_to_expenses_table', 1),
(66, '2018_12_20_082753_add_account_id_to_returns_table', 1),
(67, '2018_12_26_064330_create_return_purchases_table', 1),
(68, '2018_12_26_144708_create_purchase_product_return_table', 1),
(69, '2018_12_27_110018_create_departments_table', 1),
(70, '2018_12_30_054844_create_employees_table', 1),
(71, '2018_12_31_125210_create_payrolls_table', 1),
(72, '2018_12_31_150446_add_department_id_to_employees_table', 1),
(73, '2019_01_01_062708_add_user_id_to_expenses_table', 1),
(74, '2019_01_02_075644_create_hrm_settings_table', 1),
(75, '2019_01_02_090334_create_attendances_table', 1),
(76, '2019_01_27_160956_add_three_columns_to_general_settings_table', 1),
(77, '2019_02_15_183303_create_stock_counts_table', 1),
(78, '2019_02_17_101604_add_is_adjusted_to_stock_counts_table', 1),
(79, '2019_04_13_101707_add_tax_no_to_customers_table', 1),
(80, '2019_08_19_000000_create_failed_jobs_table', 1),
(81, '2019_10_14_111455_create_holidays_table', 1),
(82, '2019_11_13_145619_add_is_variant_to_products_table', 1),
(83, '2019_11_13_150206_create_product_variants_table', 1),
(84, '2019_11_13_153828_create_variants_table', 1),
(85, '2019_11_25_134041_add_qty_to_product_variants_table', 1),
(86, '2019_11_25_134922_add_variant_id_to_product_purchases_table', 1),
(87, '2019_11_25_145341_add_variant_id_to_product_warehouse_table', 1),
(88, '2019_11_29_182201_add_variant_id_to_product_sales_table', 1),
(89, '2019_12_04_121311_add_variant_id_to_product_quotation_table', 1),
(90, '2019_12_05_123802_add_variant_id_to_product_transfer_table', 1),
(91, '2019_12_08_114954_add_variant_id_to_product_returns_table', 1),
(92, '2019_12_08_203146_add_variant_id_to_purchase_product_return_table', 1),
(93, '2020_02_28_103340_create_money_transfers_table', 1),
(94, '2020_07_01_193151_add_image_to_categories_table', 1),
(95, '2020_09_26_130426_add_user_id_to_deliveries_table', 1),
(96, '2020_10_11_125457_create_cash_registers_table', 1),
(97, '2020_10_13_155019_add_cash_register_id_to_sales_table', 1),
(98, '2020_10_13_172624_add_cash_register_id_to_returns_table', 1),
(99, '2020_10_17_212338_add_cash_register_id_to_payments_table', 1),
(100, '2020_10_18_124200_add_cash_register_id_to_expenses_table', 1),
(101, '2020_10_21_121632_add_developed_by_to_general_settings_table', 1),
(102, '2020_10_30_135557_create_notifications_table', 1),
(103, '2020_11_01_044954_create_currencies_table', 1),
(104, '2020_11_01_140736_add_price_to_product_warehouse_table', 1),
(105, '2020_11_02_050633_add_is_diff_price_to_products_table', 1),
(106, '2020_11_09_055222_add_user_id_to_customers_table', 1),
(107, '2020_11_17_054806_add_invoice_format_to_general_settings_table', 1),
(108, '2021_02_10_074859_add_variant_id_to_product_adjustments_table', 1),
(109, '2021_03_07_093606_create_product_batches_table', 1),
(110, '2021_03_07_093759_add_product_batch_id_to_product_warehouse_table', 1),
(111, '2021_03_07_093900_add_product_batch_id_to_product_purchases_table', 1),
(112, '2021_03_11_132603_add_product_batch_id_to_product_sales_table', 1),
(113, '2021_03_25_125421_add_is_batch_to_products_table', 1),
(114, '2021_05_19_120127_add_product_batch_id_to_product_returns_table', 1),
(115, '2021_05_22_105611_add_product_batch_id_to_purchase_product_return_table', 1),
(116, '2021_05_23_124848_add_product_batch_id_to_product_transfer_table', 1),
(117, '2021_05_26_153106_add_product_batch_id_to_product_quotation_table', 1),
(118, '2021_06_08_213007_create_reward_point_settings_table', 1),
(119, '2021_06_16_104155_add_points_to_customers_table', 1),
(120, '2021_06_17_101057_add_used_points_to_payments_table', 1),
(121, '2021_07_06_132716_add_variant_list_to_products_table', 1),
(122, '2021_09_27_161141_add_is_imei_to_products_table', 1),
(123, '2021_09_28_170052_add_imei_number_to_product_warehouse_table', 1),
(124, '2021_09_28_170126_add_imei_number_to_product_purchases_table', 1),
(125, '2021_10_03_170652_add_imei_number_to_product_sales_table', 1),
(126, '2021_10_10_145214_add_imei_number_to_product_returns_table', 1),
(127, '2021_10_11_104504_add_imei_number_to_product_transfer_table', 1),
(128, '2021_10_12_160107_add_imei_number_to_purchase_product_return_table', 1),
(129, '2021_10_12_205146_add_is_rtl_to_general_settings_table', 1),
(130, '2022_01_13_191242_create_discount_plans_table', 1),
(131, '2022_01_14_174318_create_discount_plan_customers_table', 1),
(132, '2022_01_14_202439_create_discounts_table', 1),
(133, '2022_01_16_153506_create_discount_plan_discounts_table', 1),
(134, '2022_02_05_174210_add_order_discount_type_and_value_to_sales_table', 1),
(135, '2022_05_26_195506_add_daily_sale_objective_to_products_table', 1),
(136, '2022_05_28_104209_create_dso_alerts_table', 1),
(137, '2022_06_01_112100_add_is_embeded_to_products_table', 1),
(138, '2022_06_14_130505_add_sale_id_to_returns_table', 1),
(139, '2022_07_19_115504_add_variant_data_to_products_table', 1),
(140, '2022_07_25_194300_add_additional_cost_to_product_variants_table', 1),
(141, '2022_09_04_195610_add_purchase_id_to_return_purchases_table', 1),
(142, '2023_01_18_125040_alter_table_general_settings', 1),
(143, '2023_01_18_133701_alter_table_pos_setting', 1),
(144, '2023_01_25_145309_add_expiry_date_to_general_settings_table', 1),
(145, '2023_02_05_132001_add_change_to_payments_table', 1),
(146, '2023_02_23_125656_alter_table_sales', 1),
(147, '2023_02_26_124100_add_package_id_to_general_settings_table', 1),
(148, '2023_03_04_120325_create_custom_fields_table', 1),
(149, '2023_03_14_174658_add_subscription_type_to_general_setting_table', 1),
(150, '2023_03_22_174352_add_currency_id_and_exchange_rate_to_returns_table', 1),
(151, '2023_03_27_114320_add_currency_id_and_exchange_rate_to_purchases_table', 1),
(152, '2023_03_27_132747_add_currency_id_and_exchange_rate_to_return_purchases_table', 1),
(153, '2023_04_25_150236_create_mail_settings_table', 1),
(154, '2023_05_13_125424_add_zatca_to_general_settings_table', 1),
(155, '2023_05_28_155540_create_tables_table', 1),
(156, '2023_05_29_115039_add_is_table_to_pos_setting_table', 1),
(157, '2023_05_29_115301_add_table_id_to_sales_table', 1),
(158, '2023_05_31_165049_add_queue_no_to_sales_table', 1),
(159, '2023_07_23_160254_create_couriers_table', 1),
(160, '2023_07_23_174343_add_courier_id_to_deliveries_table', 1),
(161, '2023_08_12_124016_add_staff_id_to_employees_table', 1),
(162, '2023_08_14_142608_add_is_active_to_currencies_table', 1),
(163, '2023_08_24_130203_change_columns_to_attendances_table', 1),
(164, '2023_09_10_134503_add_without_stock_to_general_settings_table', 1),
(165, '2023_09_26_211542_add_modules_to_general_settings_table', 1),
(166, '2023_10_15_124306_add_return_qty_to_product_sales_table', 1),
(167, '2023_12_03_235606_crete_external_services_table', 1),
(168, '2024_02_04_131826_add_unit_cost_to_product_adjustments_table', 1),
(169, '2024_02_13_173126_change_modules_to_general_settings_table', 1),
(170, '2024_05_02_114215_add_payment_receiver_to_payments', 1),
(171, '2024_05_06_132553_create_sms_templates_table', 1),
(172, '2024_05_07_102225_add_send_sms_to_pos_setting_table', 1),
(173, '2024_05_07_132625_add_is_default_to_sms_templates_table', 1),
(174, '2024_05_08_112211_change_address_and_city_field_to_nullable_in_customers_table', 1),
(175, '2024_05_08_151050_add_is_default_ecommerce_columne_to_sms_templates_table', 1),
(176, '2024_05_20_182757_add_wholesale_price_to_products_table', 1),
(177, '2024_05_21_170500_add_is_sent_to_transfers_table', 1),
(178, '2024_06_04_225113_create_income_categories_table', 1),
(179, '2024_06_04_225128_create_incomes_table', 1),
(180, '2024_06_29_131917_add_is_packing_slip_to_general_settings_table', 1),
(181, '2024_07_05_192531_create_packing_slips_table', 1),
(182, '2024_07_05_193002_create_packing_slip_products_table', 1),
(183, '2024_07_05_194501_add_is_packing_and_delivered_to_product_sales_table', 1),
(184, '2024_07_14_122245_add_delivery_id_to_packing_slips_table', 1),
(185, '2024_07_14_122415_add_variant_id_to_packing_slip_products_table', 1),
(186, '2024_07_14_122519_add_packing_slip_ids_to_deliveries_table', 1),
(187, '2024_07_16_125908_create_challans_table', 1),
(188, '2024_08_12_112830_add_thermal_invoice_size_to_pos_setting', 1),
(189, '2024_08_14_133351_add_expiry_type_value_to_general_settings', 1),
(190, '2024_09_11_151744_add_return_qty_to_product_purchases_table', 1),
(191, '2024_09_12_162309_create_barcodes_table', 1),
(192, '2024_10_10_121312_add_data_to_payment_with_credit_card_table', 1),
(193, '2024_10_10_212501_alter_attendances_table', 1),
(194, '2024_10_10_213757_alter_attendances_table', 1),
(195, '2024_10_14_144917_change_column_to_nullable_to_payment_with_credit_card_table', 1),
(196, '2024_11_10_121521_add_code_and_type_to_accounts_table', 1),
(197, '2024_11_24_100926_add_module_status_to_external_services_table', 1),
(198, '2025_03_09_000000_create_insurance_provider_table', 1),
(199, '2025_03_09_000001_create_payment_with_insurance_table', 1),
(200, '2025_03_09_000002_create_refills_table', 1),
(201, '2025_03_09_000003_create_refill_items_table', 1),
(202, '2025_03_09_000004_add_columns_to_products_table', 1),
(203, '2025_03_09_000005_add_dosage_to_product_sales_table', 1),
(204, '2025_03_09_000006_create_shelves_table', 1),
(205, '2025_03_12_000007_update_products_table_with_markups_and_units', 1),
(206, '2025_03_24_000000_create_payment_with_mobile_money_table', 1),
(207, '2025_03_24_000001_create_sent_sms_table', 1),
(208, '2025_03_24_000002_add_next_refill_date_to_refill_items_table', 1),
(209, '2025_03_24_000003_add_sms_credit_to_general_settings_table', 1),
(210, '2025_03_24_000004_add_customer_name_and_expiry_to_payment_with_insurance_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `money_transfers`
--

CREATE TABLE `money_transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `from_account_id` int(11) NOT NULL,
  `to_account_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `packing_slips`
--

CREATE TABLE `packing_slips` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `delivery_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `packing_slip_products`
--

CREATE TABLE `packing_slip_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `packing_slip_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `payment_receiver` varchar(255) DEFAULT NULL,
  `payment_reference` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `used_points` double DEFAULT NULL,
  `change` double DEFAULT NULL,
  `paying_method` varchar(255) NOT NULL,
  `payment_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `purchase_id`, `sale_id`, `cash_register_id`, `account_id`, `payment_receiver`, `payment_reference`, `user_id`, `amount`, `used_points`, `change`, `paying_method`, `payment_note`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 2, 1, 'iddrisu', 'spr-20250325-064247', 2, 3.26, NULL, 1.74, 'Cash', NULL, '2025-03-25 18:42:47', '2025-03-25 18:42:47'),
(2, NULL, 2, 2, 1, 'iddrisu', 'spr-20250325-065012', 2, 0, NULL, 2, 'Cash', NULL, '2025-03-25 18:50:12', '2025-03-25 18:50:12'),
(3, NULL, 5, 3, 1, NULL, 'spr-20250326-085920', 3, 8, NULL, 21, 'Cash', NULL, '2025-03-26 08:59:20', '2025-03-26 08:59:20'),
(4, NULL, 6, 1, 1, 'intern', 'spr-20250326-092257', 1, 1.3, NULL, 0, 'Mobile Money', NULL, '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_cheque`
--

CREATE TABLE `payment_with_cheque` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `cheque_no` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_credit_card`
--

CREATE TABLE `payment_with_credit_card` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_stripe_id` varchar(255) DEFAULT NULL,
  `charge_id` varchar(255) NOT NULL,
  `data` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_gift_card`
--

CREATE TABLE `payment_with_gift_card` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `gift_card_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_insurance`
--

CREATE TABLE `payment_with_insurance` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_insurance_id` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  `insurer` varchar(255) NOT NULL,
  `insurance_policy_id` varchar(255) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `approved_amount` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_mobile_money`
--

CREATE TABLE `payment_with_mobile_money` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `network` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_with_mobile_money`
--

INSERT INTO `payment_with_mobile_money` (`id`, `payment_id`, `customer_id`, `phone_number`, `reference`, `network`, `created_at`, `updated_at`) VALUES
(1, 4, 1, '0247118423', '48907553128655', 'MTN', '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_paypal`
--

CREATE TABLE `payment_with_paypal` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payrolls`
--

CREATE TABLE `payrolls` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `paying_method` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(4, 'products-edit', 'web', '2018-06-03 01:00:09', '2018-06-03 01:00:09'),
(5, 'products-delete', 'web', '2018-06-03 22:54:22', '2018-06-03 22:54:22'),
(6, 'products-add', 'web', '2018-06-04 00:34:14', '2018-06-04 00:34:14'),
(7, 'products-index', 'web', '2018-06-04 03:34:27', '2018-06-04 03:34:27'),
(8, 'purchases-index', 'web', '2018-06-04 08:03:19', '2018-06-04 08:03:19'),
(9, 'purchases-add', 'web', '2018-06-04 08:12:25', '2018-06-04 08:12:25'),
(10, 'purchases-edit', 'web', '2018-06-04 09:47:36', '2018-06-04 09:47:36'),
(11, 'purchases-delete', 'web', '2018-06-04 09:47:36', '2018-06-04 09:47:36'),
(12, 'sales-index', 'web', '2018-06-04 10:49:08', '2018-06-04 10:49:08'),
(13, 'sales-add', 'web', '2018-06-04 10:49:52', '2018-06-04 10:49:52'),
(14, 'sales-edit', 'web', '2018-06-04 10:49:52', '2018-06-04 10:49:52'),
(15, 'sales-delete', 'web', '2018-06-04 10:49:53', '2018-06-04 10:49:53'),
(16, 'quotes-index', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(17, 'quotes-add', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(18, 'quotes-edit', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(19, 'quotes-delete', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(20, 'transfers-index', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(21, 'transfers-add', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(22, 'transfers-edit', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(23, 'transfers-delete', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(24, 'returns-index', 'web', '2018-06-04 22:50:24', '2018-06-04 22:50:24'),
(25, 'returns-add', 'web', '2018-06-04 22:50:24', '2018-06-04 22:50:24'),
(26, 'returns-edit', 'web', '2018-06-04 22:50:25', '2018-06-04 22:50:25'),
(27, 'returns-delete', 'web', '2018-06-04 22:50:25', '2018-06-04 22:50:25'),
(28, 'customers-index', 'web', '2018-06-04 23:15:54', '2018-06-04 23:15:54'),
(29, 'customers-add', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(30, 'customers-edit', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(31, 'customers-delete', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(32, 'suppliers-index', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(33, 'suppliers-add', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(34, 'suppliers-edit', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(35, 'suppliers-delete', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(36, 'product-report', 'web', '2018-06-24 23:05:33', '2018-06-24 23:05:33'),
(37, 'purchase-report', 'web', '2018-06-24 23:24:56', '2018-06-24 23:24:56'),
(38, 'sale-report', 'web', '2018-06-24 23:33:13', '2018-06-24 23:33:13'),
(39, 'customer-report', 'web', '2018-06-24 23:36:51', '2018-06-24 23:36:51'),
(40, 'due-report', 'web', '2018-06-24 23:39:52', '2018-06-24 23:39:52'),
(41, 'users-index', 'web', '2018-06-25 00:00:10', '2018-06-25 00:00:10'),
(42, 'users-add', 'web', '2018-06-25 00:00:10', '2018-06-25 00:00:10'),
(43, 'users-edit', 'web', '2018-06-25 00:01:30', '2018-06-25 00:01:30'),
(44, 'users-delete', 'web', '2018-06-25 00:01:30', '2018-06-25 00:01:30'),
(45, 'profit-loss', 'web', '2018-07-14 21:50:05', '2018-07-14 21:50:05'),
(46, 'best-seller', 'web', '2018-07-14 22:01:38', '2018-07-14 22:01:38'),
(47, 'daily-sale', 'web', '2018-07-14 22:24:21', '2018-07-14 22:24:21'),
(48, 'monthly-sale', 'web', '2018-07-14 22:30:41', '2018-07-14 22:30:41'),
(49, 'daily-purchase', 'web', '2018-07-14 22:36:46', '2018-07-14 22:36:46'),
(50, 'monthly-purchase', 'web', '2018-07-14 22:48:17', '2018-07-14 22:48:17'),
(51, 'payment-report', 'web', '2018-07-14 23:10:41', '2018-07-14 23:10:41'),
(52, 'warehouse-stock-report', 'web', '2018-07-14 23:16:55', '2018-07-14 23:16:55'),
(53, 'product-qty-alert', 'web', '2018-07-14 23:33:21', '2018-07-14 23:33:21'),
(54, 'supplier-report', 'web', '2018-07-30 03:00:01', '2018-07-30 03:00:01'),
(55, 'expenses-index', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(56, 'expenses-add', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(57, 'expenses-edit', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(58, 'expenses-delete', 'web', '2018-09-05 01:07:11', '2018-09-05 01:07:11'),
(59, 'general_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(60, 'mail_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(61, 'pos_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(62, 'hrm_setting', 'web', '2019-01-02 10:30:23', '2019-01-02 10:30:23'),
(63, 'purchase-return-index', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(64, 'purchase-return-add', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(65, 'purchase-return-edit', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(66, 'purchase-return-delete', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(67, 'account-index', 'web', '2019-01-02 22:06:13', '2019-01-02 22:06:13'),
(68, 'balance-sheet', 'web', '2019-01-02 22:06:14', '2019-01-02 22:06:14'),
(69, 'account-statement', 'web', '2019-01-02 22:06:14', '2019-01-02 22:06:14'),
(70, 'department', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(71, 'attendance', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(72, 'payroll', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(73, 'employees-index', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(74, 'employees-add', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(75, 'employees-edit', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(76, 'employees-delete', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(77, 'user-report', 'web', '2019-01-16 06:48:18', '2019-01-16 06:48:18'),
(78, 'stock_count', 'web', '2019-02-17 10:32:01', '2019-02-17 10:32:01'),
(79, 'adjustment', 'web', '2019-02-17 10:32:02', '2019-02-17 10:32:02'),
(80, 'sms_setting', 'web', '2019-02-22 05:18:03', '2019-02-22 05:18:03'),
(81, 'create_sms', 'web', '2019-02-22 05:18:03', '2019-02-22 05:18:03'),
(82, 'print_barcode', 'web', '2019-03-07 05:02:19', '2019-03-07 05:02:19'),
(83, 'empty_database', 'web', '2019-03-07 05:02:19', '2019-03-07 05:02:19'),
(84, 'customer_group', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(85, 'unit', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(86, 'tax', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(87, 'gift_card', 'web', '2019-03-07 06:29:38', '2019-03-07 06:29:38'),
(88, 'coupon', 'web', '2019-03-07 06:29:38', '2019-03-07 06:29:38'),
(89, 'holiday', 'web', '2019-10-19 08:57:15', '2019-10-19 08:57:15'),
(90, 'warehouse-report', 'web', '2019-10-22 06:00:23', '2019-10-22 06:00:23'),
(91, 'warehouse', 'web', '2020-02-26 06:47:32', '2020-02-26 06:47:32'),
(92, 'brand', 'web', '2020-02-26 06:59:59', '2020-02-26 06:59:59'),
(93, 'billers-index', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(94, 'billers-add', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(95, 'billers-edit', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(96, 'billers-delete', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(97, 'money-transfer', 'web', '2020-03-02 05:41:48', '2020-03-02 05:41:48'),
(98, 'category', 'web', '2020-07-13 12:13:16', '2020-07-13 12:13:16'),
(99, 'delivery', 'web', '2020-07-13 12:13:16', '2020-07-13 12:13:16'),
(100, 'send_notification', 'web', '2020-10-31 06:21:31', '2020-10-31 06:21:31'),
(101, 'today_sale', 'web', '2020-10-31 06:57:04', '2020-10-31 06:57:04'),
(102, 'today_profit', 'web', '2020-10-31 06:57:04', '2020-10-31 06:57:04'),
(103, 'currency', 'web', '2020-11-09 00:23:11', '2020-11-09 00:23:11'),
(104, 'backup_database', 'web', '2020-11-15 00:16:55', '2020-11-15 00:16:55'),
(105, 'reward_point_setting', 'web', '2021-06-27 04:34:42', '2021-06-27 04:34:42'),
(106, 'revenue_profit_summary', 'web', '2022-02-08 13:57:21', '2022-02-08 13:57:21'),
(107, 'cash_flow', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(108, 'monthly_summary', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(109, 'yearly_report', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(110, 'discount_plan', 'web', '2022-02-16 09:12:26', '2022-02-16 09:12:26'),
(111, 'discount', 'web', '2022-02-16 09:12:38', '2022-02-16 09:12:38'),
(112, 'product-expiry-report', 'web', '2022-03-30 05:39:20', '2022-03-30 05:39:20'),
(113, 'purchase-payment-index', 'web', '2022-06-05 14:12:27', '2022-06-05 14:12:27'),
(114, 'purchase-payment-add', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(115, 'purchase-payment-edit', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(116, 'purchase-payment-delete', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(117, 'sale-payment-index', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(118, 'sale-payment-add', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(119, 'sale-payment-edit', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(120, 'sale-payment-delete', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(121, 'all_notification', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(122, 'sale-report-chart', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(123, 'dso-report', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(124, 'product_history', 'web', '2022-08-25 14:04:05', '2022-08-25 14:04:05'),
(125, 'supplier-due-report', 'web', '2022-08-31 09:46:33', '2022-08-31 09:46:33'),
(126, 'custom_field', 'web', '2023-11-13 06:23:34', '2023-11-13 06:23:34'),
(127, 'incomes-index', 'web', '2024-07-11 13:16:43', '2024-07-11 13:16:43'),
(128, 'incomes-add', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(129, 'incomes-edit', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(130, 'incomes-delete', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(131, 'packing_slip_challan', 'web', '2024-07-22 14:16:17', '2024-07-22 14:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `pos_setting`
--

CREATE TABLE `pos_setting` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `product_number` int(11) NOT NULL,
  `keybord_active` tinyint(1) NOT NULL,
  `is_table` tinyint(1) NOT NULL DEFAULT 0,
  `send_sms` tinyint(1) NOT NULL DEFAULT 0,
  `stripe_public_key` varchar(255) DEFAULT NULL,
  `stripe_secret_key` varchar(255) DEFAULT NULL,
  `paypal_live_api_username` varchar(255) DEFAULT NULL,
  `paypal_live_api_password` varchar(255) DEFAULT NULL,
  `paypal_live_api_secret` varchar(255) DEFAULT NULL,
  `payment_options` text DEFAULT NULL,
  `invoice_option` varchar(10) DEFAULT NULL,
  `thermal_invoice_size` varchar(255) NOT NULL DEFAULT '80',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pos_setting`
--

INSERT INTO `pos_setting` (`id`, `customer_id`, `warehouse_id`, `biller_id`, `product_number`, `keybord_active`, `is_table`, `send_sms`, `stripe_public_key`, `stripe_secret_key`, `paypal_live_api_username`, `paypal_live_api_password`, `paypal_live_api_secret`, `payment_options`, `invoice_option`, `thermal_invoice_size`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 2, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 'cash,card,cheque,gift_card,deposit,mobile_money,credit,insurance', 'thermal', '80', '2023-05-28 06:57:03', '2025-03-24 23:17:23');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `shelf` varchar(50) DEFAULT NULL,
  `max_product` int(11) NOT NULL DEFAULT 50,
  `shelf_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `barcode_symbology` varchar(255) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `retail_units_per_wholesale` double DEFAULT NULL COMMENT 'Number of retail units in one wholesale unit, e.g., 15 bottles per box',
  `cost` double NOT NULL,
  `wholesale_markup` double DEFAULT NULL COMMENT 'Markup percentage for wholesale price',
  `wholesale_price` double DEFAULT NULL COMMENT 'Price per wholesale unit (e.g., box)',
  `retail_markup` double DEFAULT NULL COMMENT 'Markup percentage for retail price',
  `price` double DEFAULT NULL COMMENT 'Price per retail unit (e.g., bottle)',
  `qty` double DEFAULT NULL,
  `alert_quantity` double DEFAULT NULL,
  `daily_sale_objective` double DEFAULT NULL,
  `promotion` tinyint(4) DEFAULT NULL,
  `promotion_price` varchar(255) DEFAULT NULL,
  `starting_date` date DEFAULT NULL,
  `last_date` date DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `tax_method` int(11) DEFAULT NULL,
  `image` longtext DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `is_embeded` tinyint(1) DEFAULT NULL,
  `is_variant` tinyint(1) DEFAULT NULL,
  `is_batch` tinyint(1) DEFAULT NULL,
  `is_diffPrice` tinyint(1) DEFAULT NULL,
  `is_imei` tinyint(1) DEFAULT NULL,
  `featured` tinyint(4) DEFAULT NULL,
  `product_list` varchar(255) DEFAULT NULL,
  `variant_list` varchar(255) DEFAULT NULL,
  `qty_list` varchar(255) DEFAULT NULL,
  `price_list` varchar(255) DEFAULT NULL,
  `product_details` text DEFAULT NULL,
  `variant_option` text DEFAULT NULL,
  `variant_value` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `shelf`, `max_product`, `shelf_id`, `name`, `code`, `type`, `barcode_symbology`, `brand_id`, `category_id`, `unit_id`, `purchase_unit_id`, `sale_unit_id`, `retail_units_per_wholesale`, `cost`, `wholesale_markup`, `wholesale_price`, `retail_markup`, `price`, `qty`, `alert_quantity`, `daily_sale_objective`, `promotion`, `promotion_price`, `starting_date`, `last_date`, `tax_id`, `tax_method`, `image`, `file`, `is_embeded`, `is_variant`, `is_batch`, `is_diffPrice`, `is_imei`, `featured`, `product_list`, `variant_list`, `qty_list`, `price_list`, `product_details`, `variant_option`, `variant_value`, `is_active`, `created_at`, `updated_at`) VALUES
(13, NULL, 50, 1, 'gebedol', '11021', 'standard', 'C128', 2, 2, 9, 9, 21, 12, 100, 10, 9.17, 20, 10, 120, 5, 10, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, 1, NULL, 1, 0, NULL, 1, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-25 17:56:52', '2025-03-25 18:32:06'),
(14, NULL, 50, NULL, 'Gastric Ulcer', '06342634', 'standard', 'C39', 3, 3, 9, 9, 7, 12, 200, 20, 20, 50, 25, 120, 150, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, 0, NULL, 1, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-25 18:21:13', '2025-03-26 09:28:56'),
(15, NULL, 50, NULL, 'Paracetamol', '79813673', 'standard', 'C128', 1, 2, 9, 9, 0, 1, 5, 0.01, 5, -0.01, 5, 56, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-26 08:42:36', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `product_adjustments`
--

CREATE TABLE `product_adjustments` (
  `id` int(10) UNSIGNED NOT NULL,
  `adjustment_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `unit_cost` double DEFAULT NULL,
  `qty` double NOT NULL,
  `action` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_batches`
--

CREATE TABLE `product_batches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `batch_no` varchar(255) NOT NULL,
  `expired_date` date NOT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_batches`
--

INSERT INTO `product_batches` (`id`, `product_id`, `batch_no`, `expired_date`, `qty`, `created_at`, `updated_at`) VALUES
(1, 14, '25-03-2025', '2026-03-25', 108, '2025-03-25 18:32:06', '2025-03-26 09:28:56'),
(2, 13, '25-03-2025', '2027-03-25', 120, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(3, 15, '7890', '2026-10-21', 56, '2025-03-26 08:49:20', '2025-03-26 09:22:57'),
(4, 14, '8097', '2025-03-28', 12, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_purchases`
--

CREATE TABLE `product_purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `recieved` double NOT NULL,
  `return_qty` double NOT NULL DEFAULT 0,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_purchases`
--

INSERT INTO `product_purchases` (`id`, `purchase_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `recieved`, `return_qty`, `purchase_unit_id`, `net_unit_cost`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL, NULL, 10, 10, 0, 1, 10, 0, 10, 10, 110, '2023-05-28 06:59:29', '2023-05-28 06:59:29'),
(2, 2, 14, 1, NULL, NULL, 10, 10, 0, 9, 200, 0, 0, 0, 2000, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(3, 2, 13, 2, NULL, NULL, 10, 10, 0, 9, 100, 0, 0, 0, 1000, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(4, 3, 15, 3, NULL, NULL, 60, 60, 0, 9, 5, 0, 10, 30, 330, '2025-03-26 08:49:20', '2025-03-26 08:49:20'),
(5, 4, 14, 4, NULL, NULL, 1, 1, 0, 9, 200, 0, 0, 0, 200, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_quotation`
--

CREATE TABLE `product_quotation` (
  `id` int(10) UNSIGNED NOT NULL,
  `quotation_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_returns`
--

CREATE TABLE `product_returns` (
  `id` int(10) UNSIGNED NOT NULL,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_returns`
--

INSERT INTO `product_returns` (`id`, `return_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `sale_unit_id`, `net_unit_price`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 14, 1, NULL, NULL, 1, 9, 1.63, 0, 0, 0, 1.63, '2025-03-26 09:28:56', '2025-03-26 09:28:56');

-- --------------------------------------------------------

--
-- Table structure for table `product_sales`
--

CREATE TABLE `product_sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `dosage` text NOT NULL,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `return_qty` double NOT NULL DEFAULT 0,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_delivered` tinyint(1) DEFAULT NULL,
  `is_packing` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_sales`
--

INSERT INTO `product_sales` (`id`, `dosage`, `sale_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `return_qty`, `sale_unit_id`, `net_unit_price`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`, `is_delivered`, `is_packing`) VALUES
(1, '', 1, 14, 1, NULL, 'null', 2, 1, 9, 1.63, 0, 0, 0, 3.26, '2025-03-25 18:42:47', '2025-03-26 09:28:56', NULL, NULL),
(2, '', 2, 14, 1, NULL, 'null', 1, 0, 9, 1.63, 0, 0, 0, 1.63, '2025-03-25 18:48:59', '2025-03-25 18:51:03', NULL, NULL),
(3, '', 3, 14, 1, NULL, 'null', 3, 0, 9, 1.63, 0, 0, 0, 4.89, '2025-03-26 02:29:39', '2025-03-26 02:29:39', NULL, NULL),
(4, '', 4, 14, 1, NULL, 'null', 80, 0, 9, 25, 0, 0, 0, 2000, '2025-03-26 08:51:58', '2025-03-26 08:51:58', NULL, NULL),
(5, '', 5, 14, 1, NULL, 'null', 10, 0, 9, 1.63, 0, 0, 0, 16.29, '2025-03-26 08:59:20', '2025-03-26 08:59:20', NULL, NULL),
(6, 'once daily', 6, 15, 3, NULL, 'null,null', 4, 0, 9, 0.33, 0, 0, 0, 1.3, '2025-03-26 09:22:57', '2025-03-26 09:22:57', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_transfer`
--

CREATE TABLE `product_transfer` (
  `id` int(10) UNSIGNED NOT NULL,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `item_code` varchar(255) NOT NULL,
  `additional_cost` double DEFAULT NULL,
  `additional_price` double DEFAULT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_warehouse`
--

CREATE TABLE `product_warehouse` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `qty` double NOT NULL,
  `price` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_warehouse`
--

INSERT INTO `product_warehouse` (`id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `warehouse_id`, `qty`, `price`, `created_at`, `updated_at`) VALUES
(1, '1', NULL, NULL, NULL, 1, 10, 20, '2023-05-28 06:59:29', '2023-05-28 07:00:57'),
(2, '14', 1, NULL, NULL, 1, 108, NULL, '2025-03-25 18:32:06', '2025-03-26 09:28:56'),
(3, '13', 2, NULL, NULL, 1, 120, NULL, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(4, '15', 3, NULL, NULL, 1, 56, NULL, '2025-03-26 08:49:20', '2025-03-26 09:22:57'),
(5, '14', 4, NULL, NULL, 1, 12, NULL, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` int(11) NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `paid_amount` double NOT NULL,
  `status` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `reference_no`, `user_id`, `warehouse_id`, `supplier_id`, `currency_id`, `exchange_rate`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_cost`, `order_tax_rate`, `order_tax`, `order_discount`, `shipping_cost`, `grand_total`, `paid_amount`, `status`, `payment_status`, `document`, `note`, `created_at`, `updated_at`) VALUES
(1, 'pr-20230528-125929', 1, 1, NULL, 1, 1, 1, 10, 0, 10, 110, 0, 0, 0, 0, 110, 0, 1, 1, NULL, NULL, '2023-05-28 06:59:29', '2023-05-28 06:59:29'),
(2, '1234', 2, 1, 1, 1, 0.06517, 2, 20, 0, 0, 3000, 10, 300, 0, 0, 3300, 0, 1, 1, NULL, NULL, '2025-03-25 00:00:00', '2025-03-25 18:32:06'),
(3, '56789', 3, 1, 1, 2, 100, 1, 60, 0, 30, 330, 10, 33, 0, 0, 363, 0, 1, 1, NULL, NULL, '2025-03-29 00:00:00', '2025-03-26 08:49:20'),
(4, '8789t9037', 1, 1, 1, 2, 1, 1, 1, 0, 0, 200, 0, 0, 0, 0, 200, 0, 1, 1, NULL, NULL, '2025-03-26 00:00:00', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_product_return`
--

CREATE TABLE `purchase_product_return` (
  `id` int(10) UNSIGNED NOT NULL,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

CREATE TABLE `quotations` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `quotation_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `refills`
--

CREATE TABLE `refills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `refill_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `warehouse_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refills`
--

INSERT INTO `refills` (`id`, `customer_id`, `created_at`, `refill_note`, `staff_note`, `updated_at`, `warehouse_id`) VALUES
(1, 3, '2025-03-26 01:37:34', NULL, NULL, '2025-03-26 01:37:34', 1);

-- --------------------------------------------------------

--
-- Table structure for table `refill_items`
--

CREATE TABLE `refill_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `refill_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `refill_interval` int(11) NOT NULL,
  `refill_unit` enum('days','weeks','months') NOT NULL,
  `refill_until` date NOT NULL,
  `next_refill_date` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refill_items`
--

INSERT INTO `refill_items` (`id`, `refill_id`, `product_id`, `quantity`, `refill_interval`, `refill_unit`, `refill_until`, `next_refill_date`, `created_at`, `updated_at`) VALUES
(1, 1, 14, 1, 2, 'months', '2025-04-06', NULL, '2025-03-26 01:37:34', '2025-03-26 01:37:34');

-- --------------------------------------------------------

--
-- Table structure for table `returns`
--

CREATE TABLE `returns` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `return_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `returns`
--

INSERT INTO `returns` (`id`, `reference_no`, `user_id`, `sale_id`, `cash_register_id`, `customer_id`, `warehouse_id`, `biller_id`, `account_id`, `currency_id`, `exchange_rate`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_price`, `order_tax_rate`, `order_tax`, `grand_total`, `document`, `return_note`, `staff_note`, `created_at`, `updated_at`) VALUES
(1, 'rr-20250326-092856', 1, 1, 1, 2, 1, 1, 1, 1, 0.06517, 1, 1, 0, 0, 1.63, 0, 0, 1.63, NULL, NULL, NULL, '2025-03-26 09:28:56', '2025-03-26 09:28:56');

-- --------------------------------------------------------

--
-- Table structure for table `return_purchases`
--

CREATE TABLE `return_purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `return_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reward_point_settings`
--

CREATE TABLE `reward_point_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `per_point_amount` double NOT NULL,
  `minimum_amount` double NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `guard_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `is_active`, `created_at`, `updated_at`, `guard_name`) VALUES
(1, 'Admin', 'Pharmacy administrator', 1, '2018-06-01 23:46:44', '2025-02-18 10:13:19', 'web'),
(2, 'Super Admin', 'GogoPlus Technical Support', 1, '2018-10-22 02:38:13', '2025-02-18 10:49:13', 'web'),
(5, 'Staff', 'Pharmacy Staff', 0, '2020-11-05 06:43:16', '2025-02-18 10:50:13', 'web'),
(7, 'Pharmacist', 'Pharnacist', 1, '2025-02-18 12:00:10', '2025-02-18 12:00:10', 'web');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(4, 1),
(4, 2),
(4, 5),
(4, 7),
(5, 1),
(5, 2),
(5, 5),
(5, 7),
(6, 1),
(6, 2),
(6, 5),
(6, 7),
(7, 1),
(7, 2),
(7, 5),
(7, 7),
(8, 1),
(8, 2),
(8, 5),
(8, 7),
(9, 1),
(9, 2),
(9, 5),
(9, 7),
(10, 1),
(10, 2),
(10, 5),
(10, 7),
(11, 1),
(11, 2),
(12, 1),
(12, 2),
(12, 5),
(12, 7),
(13, 1),
(13, 2),
(13, 5),
(13, 7),
(14, 1),
(14, 2),
(14, 5),
(15, 1),
(15, 2),
(16, 1),
(16, 2),
(16, 5),
(16, 7),
(17, 1),
(17, 2),
(17, 5),
(17, 7),
(18, 1),
(18, 2),
(18, 5),
(18, 7),
(19, 1),
(19, 2),
(20, 1),
(20, 2),
(20, 5),
(20, 7),
(21, 1),
(21, 2),
(21, 5),
(21, 7),
(22, 1),
(22, 2),
(22, 5),
(22, 7),
(23, 1),
(23, 2),
(24, 1),
(24, 2),
(24, 5),
(24, 7),
(25, 1),
(25, 2),
(25, 5),
(25, 7),
(26, 1),
(26, 2),
(26, 5),
(26, 7),
(27, 1),
(27, 2),
(28, 1),
(28, 2),
(28, 5),
(28, 7),
(29, 1),
(29, 2),
(29, 5),
(29, 7),
(30, 1),
(30, 2),
(30, 5),
(30, 7),
(31, 1),
(31, 2),
(32, 1),
(32, 2),
(32, 5),
(33, 1),
(33, 2),
(33, 5),
(34, 1),
(34, 2),
(34, 5),
(35, 1),
(35, 2),
(35, 5),
(36, 1),
(36, 2),
(36, 5),
(36, 7),
(37, 1),
(37, 2),
(37, 5),
(37, 7),
(38, 1),
(38, 2),
(38, 5),
(38, 7),
(39, 1),
(39, 2),
(39, 5),
(39, 7),
(40, 1),
(40, 2),
(40, 5),
(40, 7),
(41, 1),
(41, 2),
(41, 5),
(41, 7),
(42, 1),
(42, 2),
(42, 7),
(43, 1),
(43, 2),
(43, 7),
(44, 1),
(44, 2),
(45, 1),
(45, 2),
(45, 5),
(45, 7),
(46, 1),
(46, 2),
(46, 5),
(46, 7),
(47, 1),
(47, 2),
(47, 5),
(47, 7),
(48, 1),
(48, 2),
(48, 5),
(48, 7),
(49, 1),
(49, 2),
(49, 5),
(49, 7),
(50, 1),
(50, 2),
(50, 5),
(50, 7),
(51, 1),
(51, 2),
(51, 5),
(51, 7),
(52, 1),
(52, 2),
(52, 5),
(52, 7),
(53, 1),
(53, 2),
(53, 5),
(53, 7),
(54, 1),
(54, 2),
(54, 5),
(55, 1),
(55, 2),
(55, 5),
(55, 7),
(56, 1),
(56, 2),
(56, 5),
(56, 7),
(57, 1),
(57, 2),
(57, 5),
(57, 7),
(58, 1),
(58, 2),
(59, 2),
(59, 5),
(60, 2),
(61, 2),
(62, 1),
(62, 2),
(63, 1),
(63, 2),
(63, 5),
(63, 7),
(64, 1),
(64, 2),
(64, 5),
(64, 7),
(65, 1),
(65, 2),
(65, 5),
(65, 7),
(66, 1),
(66, 2),
(67, 1),
(67, 2),
(67, 5),
(68, 1),
(68, 2),
(69, 1),
(69, 2),
(69, 5),
(70, 1),
(70, 2),
(71, 1),
(71, 2),
(72, 1),
(72, 2),
(73, 1),
(73, 2),
(73, 5),
(74, 1),
(74, 2),
(75, 1),
(75, 2),
(76, 1),
(76, 2),
(77, 1),
(77, 2),
(77, 7),
(78, 1),
(78, 2),
(78, 5),
(78, 7),
(79, 1),
(79, 2),
(79, 5),
(79, 7),
(80, 2),
(81, 1),
(81, 2),
(81, 5),
(81, 7),
(82, 1),
(82, 2),
(83, 2),
(84, 1),
(84, 2),
(84, 5),
(84, 7),
(85, 1),
(85, 2),
(85, 5),
(85, 7),
(86, 1),
(86, 2),
(86, 5),
(87, 1),
(87, 2),
(87, 5),
(87, 7),
(88, 1),
(88, 2),
(88, 5),
(88, 7),
(89, 1),
(89, 2),
(90, 1),
(90, 2),
(90, 5),
(90, 7),
(91, 1),
(91, 2),
(92, 1),
(92, 2),
(92, 5),
(92, 7),
(93, 1),
(93, 2),
(93, 5),
(94, 1),
(94, 2),
(95, 1),
(95, 2),
(96, 1),
(96, 2),
(97, 1),
(97, 2),
(98, 1),
(98, 2),
(98, 5),
(98, 7),
(99, 1),
(99, 2),
(99, 5),
(99, 7),
(100, 1),
(100, 2),
(100, 5),
(100, 7),
(101, 1),
(101, 2),
(101, 5),
(101, 7),
(102, 1),
(102, 2),
(102, 5),
(102, 7),
(103, 1),
(103, 2),
(103, 5),
(103, 7),
(104, 2),
(105, 1),
(105, 2),
(105, 7),
(106, 1),
(106, 2),
(106, 5),
(106, 7),
(107, 1),
(107, 2),
(107, 5),
(107, 7),
(108, 1),
(108, 2),
(108, 5),
(108, 7),
(109, 1),
(109, 2),
(109, 5),
(109, 7),
(110, 1),
(110, 2),
(110, 5),
(110, 7),
(111, 1),
(111, 2),
(111, 5),
(111, 7),
(112, 1),
(112, 2),
(112, 5),
(112, 7),
(113, 1),
(113, 2),
(113, 5),
(113, 7),
(114, 1),
(114, 2),
(114, 5),
(114, 7),
(115, 1),
(115, 2),
(115, 5),
(115, 7),
(116, 1),
(116, 2),
(117, 1),
(117, 2),
(117, 5),
(117, 7),
(118, 1),
(118, 2),
(118, 5),
(118, 7),
(119, 1),
(119, 2),
(119, 5),
(120, 1),
(120, 2),
(121, 1),
(121, 2),
(121, 5),
(121, 7),
(122, 1),
(122, 2),
(122, 5),
(122, 7),
(123, 1),
(123, 2),
(123, 5),
(123, 7),
(124, 1),
(124, 2),
(124, 5),
(124, 7),
(125, 1),
(125, 2),
(125, 5),
(126, 2),
(126, 7),
(127, 1),
(127, 2),
(127, 5),
(128, 1),
(128, 2),
(128, 5),
(129, 1),
(129, 2),
(129, 5),
(130, 1),
(130, 2),
(131, 2),
(132, 1),
(132, 2),
(132, 5);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `queue` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `grand_total` double NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount_type` varchar(255) DEFAULT NULL,
  `order_discount_value` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `coupon_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `sale_status` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `sale_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `reference_no`, `user_id`, `cash_register_id`, `table_id`, `queue`, `customer_id`, `warehouse_id`, `biller_id`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_price`, `grand_total`, `currency_id`, `exchange_rate`, `order_tax_rate`, `order_tax`, `order_discount_type`, `order_discount_value`, `order_discount`, `coupon_id`, `coupon_discount`, `shipping_cost`, `sale_status`, `payment_status`, `document`, `paid_amount`, `sale_note`, `staff_note`, `created_at`, `updated_at`) VALUES
(1, 'posr-20250325-064247', 2, 2, NULL, NULL, 2, 1, 1, 1, 2, 0, 0, 3.26, 3.26, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 4, 4, NULL, 3.26, NULL, NULL, '2025-03-25 18:42:47', '2025-03-26 09:28:56'),
(2, '1234', 2, 2, NULL, NULL, 2, 1, 1, 1, 1, 0, 0, 1.63, 1.63, 1, 0.06517, 0, 0, 'Flat', 0, 0, NULL, NULL, 0, 1, 2, NULL, 0, NULL, NULL, '2025-03-25 18:51:03', '2025-03-25 18:51:03'),
(3, 'posr-20250326-022939', 3, 3, NULL, NULL, 1, 1, 1, 1, 3, 0, 0, 4.89, 4.89, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 3, 2, NULL, 0, NULL, NULL, '2025-03-26 02:29:39', '2025-03-26 02:29:39'),
(4, '67879', 3, 3, NULL, NULL, 3, 1, 1, 1, 80, 0, 0, 2000, 2000, 2, 100, 0, 0, 'Flat', NULL, 0, NULL, NULL, 0, 2, 1, NULL, 0, NULL, NULL, '2025-04-02 08:51:58', '2025-03-26 08:51:58'),
(5, '89089', 3, 3, NULL, NULL, 3, 1, 1, 1, 10, 0, 0, 16.29, 16.29, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, NULL, 0, 1, 3, NULL, 8, NULL, NULL, '2025-04-02 08:59:20', '2025-03-26 08:59:20'),
(6, 'posr-20250326-092257', 1, 1, NULL, NULL, 1, 1, 1, 1, 4, 0, 0, 1.3, 1.3, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 1, 4, NULL, 1.3, NULL, NULL, '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `sent_sms`
--

CREATE TABLE `sent_sms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'sent',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shelves`
--

CREATE TABLE `shelves` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shelves`
--

INSERT INTO `shelves` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'general', '2025-03-25 17:59:32', '2025-03-25 17:59:32'),
(3, 'stomach', '2025-03-25 18:21:57', '2025-03-25 18:21:57');

-- --------------------------------------------------------

--
-- Table structure for table `sms_templates`
--

CREATE TABLE `sms_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_default_ecommerce` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_counts`
--

CREATE TABLE `stock_counts` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `category_id` varchar(255) DEFAULT NULL,
  `brand_id` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `initial_file` varchar(255) DEFAULT NULL,
  `final_file` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_adjusted` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) NOT NULL,
  `vat_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `image`, `company_name`, `vat_number`, `email`, `phone_number`, `address`, `city`, `state`, `postal_code`, `country`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'John Doe', NULL, 'Test Company', NULL, 'john@gmail.com', '231312', 'Test address', 'Test City', NULL, NULL, NULL, 1, '2023-05-28 06:53:04', '2023-05-28 06:53:04');

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `number_of_person` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `name`, `rate`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'VAT 10%', 10, 1, '2023-05-28 06:52:08', '2023-05-28 06:52:08');

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `from_warehouse_id` int(11) NOT NULL,
  `to_warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_sent` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(10) UNSIGNED NOT NULL,
  `unit_code` varchar(255) NOT NULL,
  `unit_name` varchar(255) NOT NULL,
  `base_unit` int(11) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `operation_value` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_code`, `unit_name`, `base_unit`, `operator`, `operation_value`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'PIECE', 'PIECE', NULL, '*', 1, 1, '2023-05-28 06:51:50', '2025-02-04 17:06:26'),
(2, 'AMPOULE', 'AMPOULE', NULL, '*', 1, 1, '2025-02-04 17:07:04', '2025-02-04 17:07:04'),
(3, 'SACHET', 'SACHET', NULL, '*', 1, 1, '2025-02-04 17:07:20', '2025-02-04 17:07:20'),
(4, 'TAB', 'TAB', NULL, '*', 1, 1, '2025-02-04 17:07:31', '2025-02-04 17:07:31'),
(5, 'TUBE', 'TUBE', NULL, '*', 1, 1, '2025-02-04 17:07:42', '2025-02-04 17:07:42'),
(6, 'VIAL', 'VIAL', NULL, '*', 1, 1, '2025-02-04 17:07:56', '2025-02-04 17:07:56'),
(7, 'BOTTLE', 'BOTTLE', NULL, '*', 1, 1, '2025-02-04 17:08:09', '2025-02-04 17:08:09'),
(8, 'CAP', 'CAP', NULL, '*', 1, 1, '2025-02-04 17:08:24', '2025-02-04 17:08:24'),
(9, 'BOX', 'BOX', NULL, '*', 1, 1, '2025-02-04 17:08:35', '2025-02-04 17:08:35'),
(10, 'JAR', 'JAR', NULL, '*', 1, 1, '2025-02-04 17:08:46', '2025-02-04 17:08:46'),
(11, 'DROP', 'DROP', NULL, '*', 1, 1, '2025-02-04 17:08:57', '2025-02-04 17:08:57'),
(12, 'SINGLE', 'SINGLE', NULL, '*', 1, 1, '2025-02-04 17:09:10', '2025-02-04 17:09:10'),
(13, 'CAN', 'CAN', NULL, '*', 1, 1, '2025-02-04 17:09:21', '2025-02-04 17:09:21'),
(14, 'SUPP', 'SUPP', NULL, '*', 1, 1, '2025-02-04 17:09:35', '2025-02-04 17:09:35'),
(15, 'STRIP', 'STRIP', NULL, '*', 1, 1, '2025-02-04 17:09:52', '2025-02-04 17:09:52'),
(16, 'PESS', 'PESS', NULL, '*', 1, 1, '2025-02-04 17:10:04', '2025-02-04 17:10:04'),
(17, 'LOZENGES', 'LOZENGES', NULL, '*', 1, 1, '2025-02-04 17:10:24', '2025-02-04 17:10:24'),
(18, 'POUCH', 'POUCH', NULL, '*', 1, 1, '2025-02-04 17:10:39', '2025-02-04 17:10:39'),
(19, 'BAG', 'BAG', NULL, '*', 1, 1, '2025-02-04 17:10:49', '2025-02-04 17:10:49'),
(20, 'No Unit', 'No Unit', NULL, '*', 1, 1, '2025-02-04 17:11:30', '2025-02-04 17:11:30'),
(21, 'PACK', 'PACK', NULL, '*', 1, 1, '2025-02-04 17:15:31', '2025-02-04 17:15:31');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `phone`, `company_name`, `role_id`, `biller_id`, `warehouse_id`, `is_active`, `is_deleted`) VALUES
(1, 'intern', 'giftybuah@gmail.com', '$2y$10$gtlKmhPKO0iLrXVyhcTaQ.DlEgDX66LqhS0slYrNBpsqIOV6ZwATC', 'pEN60GwtkCZFKVT6tvmmCiYvHqvDX4znpKTdgDca9wxdfVmtbxRixIxH0RzJ', '2018-06-02 03:24:15', '2025-03-24 23:20:25', '0247118423', 'Intern Pharmacy', 2, NULL, NULL, 1, 0),
(2, 'iddrisu', 'iddrisu442g@gmail.com', '$2y$10$WwNSDcjyJzDoEFFC1s2MTuGx5UrmgBhj7iwNceFJqOTA6IgAB7QUe', NULL, '2025-03-24 20:36:04', '2025-03-24 23:15:12', '0550936771', 'Intern Pharmacy', 1, NULL, NULL, 1, 0),
(3, 'obed', 'ninsonobed5630@gmail.com', '$2y$10$vPfQAb2/onfHCkKOJzzbtOU1TtzRKEjldvuEzdgZPsGQZEPavXfGC', NULL, '2025-03-24 20:39:36', '2025-03-24 23:16:16', '0256422216', 'Intern Pharmacy', 1, NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `variants`
--

CREATE TABLE `variants` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `name`, `phone`, `email`, `address`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Shop', '9991111', NULL, 'Test address', 1, '2023-05-28 06:51:19', '2023-05-28 06:51:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `action_logs`
--
ALTER TABLE `action_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `action_id` (`action_id`);

--
-- Indexes for table `adjustments`
--
ALTER TABLE `adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `barcodes`
--
ALTER TABLE `barcodes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billers`
--
ALTER TABLE `billers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cash_registers`
--
ALTER TABLE `cash_registers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `challans`
--
ALTER TABLE `challans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `couriers`
--
ALTER TABLE `couriers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_groups`
--
ALTER TABLE `customer_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_fields`
--
ALTER TABLE `custom_fields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plans`
--
ALTER TABLE `discount_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plan_customers`
--
ALTER TABLE `discount_plan_customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plan_discounts`
--
ALTER TABLE `discount_plan_discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dso_alerts`
--
ALTER TABLE `dso_alerts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `external_services`
--
ALTER TABLE `external_services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gift_cards`
--
ALTER TABLE `gift_cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gift_card_recharges`
--
ALTER TABLE `gift_card_recharges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hrm_settings`
--
ALTER TABLE `hrm_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `incomes`
--
ALTER TABLE `incomes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `income_categories`
--
ALTER TABLE `income_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `insurance_provider`
--
ALTER TABLE `insurance_provider`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mail_settings`
--
ALTER TABLE `mail_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `money_transfers`
--
ALTER TABLE `money_transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `packing_slips`
--
ALTER TABLE `packing_slips`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packing_slip_products`
--
ALTER TABLE `packing_slip_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_cheque`
--
ALTER TABLE `payment_with_cheque`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_credit_card`
--
ALTER TABLE `payment_with_credit_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_gift_card`
--
ALTER TABLE `payment_with_gift_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_insurance`
--
ALTER TABLE `payment_with_insurance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_mobile_money`
--
ALTER TABLE `payment_with_mobile_money`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_paypal`
--
ALTER TABLE `payment_with_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payrolls`
--
ALTER TABLE `payrolls`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pos_setting`
--
ALTER TABLE `pos_setting`
  ADD UNIQUE KEY `pos_setting_id_unique` (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_batches`
--
ALTER TABLE `product_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_purchases`
--
ALTER TABLE `product_purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_quotation`
--
ALTER TABLE `product_quotation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_returns`
--
ALTER TABLE `product_returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_sales`
--
ALTER TABLE `product_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_transfer`
--
ALTER TABLE `product_transfer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_product_return`
--
ALTER TABLE `purchase_product_return`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quotations`
--
ALTER TABLE `quotations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refills`
--
ALTER TABLE `refills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refill_items`
--
ALTER TABLE `refill_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `refill_items_next_refill_date_index` (`next_refill_date`);

--
-- Indexes for table `returns`
--
ALTER TABLE `returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `return_purchases`
--
ALTER TABLE `return_purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reward_point_settings`
--
ALTER TABLE `reward_point_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sent_sms`
--
ALTER TABLE `sent_sms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sent_sms_customer_id_index` (`customer_id`),
  ADD KEY `sent_sms_phone_number_index` (`phone_number`);

--
-- Indexes for table `shelves`
--
ALTER TABLE `shelves`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shelves_name_index` (`name`);

--
-- Indexes for table `sms_templates`
--
ALTER TABLE `sms_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_counts`
--
ALTER TABLE `stock_counts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `variants`
--
ALTER TABLE `variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `action_logs`
--
ALTER TABLE `action_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `adjustments`
--
ALTER TABLE `adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `barcodes`
--
ALTER TABLE `barcodes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `billers`
--
ALTER TABLE `billers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cash_registers`
--
ALTER TABLE `cash_registers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `challans`
--
ALTER TABLE `challans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `couriers`
--
ALTER TABLE `couriers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customer_groups`
--
ALTER TABLE `customer_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `custom_fields`
--
ALTER TABLE `custom_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plans`
--
ALTER TABLE `discount_plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plan_customers`
--
ALTER TABLE `discount_plan_customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plan_discounts`
--
ALTER TABLE `discount_plan_discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dso_alerts`
--
ALTER TABLE `dso_alerts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `external_services`
--
ALTER TABLE `external_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `gift_cards`
--
ALTER TABLE `gift_cards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gift_card_recharges`
--
ALTER TABLE `gift_card_recharges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hrm_settings`
--
ALTER TABLE `hrm_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `incomes`
--
ALTER TABLE `incomes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `income_categories`
--
ALTER TABLE `income_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `insurance_provider`
--
ALTER TABLE `insurance_provider`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mail_settings`
--
ALTER TABLE `mail_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;

--
-- AUTO_INCREMENT for table `money_transfers`
--
ALTER TABLE `money_transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packing_slips`
--
ALTER TABLE `packing_slips`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packing_slip_products`
--
ALTER TABLE `packing_slip_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_with_cheque`
--
ALTER TABLE `payment_with_cheque`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_credit_card`
--
ALTER TABLE `payment_with_credit_card`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_gift_card`
--
ALTER TABLE `payment_with_gift_card`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_insurance`
--
ALTER TABLE `payment_with_insurance`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_mobile_money`
--
ALTER TABLE `payment_with_mobile_money`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payment_with_paypal`
--
ALTER TABLE `payment_with_paypal`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payrolls`
--
ALTER TABLE `payrolls`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_batches`
--
ALTER TABLE `product_batches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_purchases`
--
ALTER TABLE `product_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_quotation`
--
ALTER TABLE `product_quotation`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_returns`
--
ALTER TABLE `product_returns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_sales`
--
ALTER TABLE `product_sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product_transfer`
--
ALTER TABLE `product_transfer`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `purchase_product_return`
--
ALTER TABLE `purchase_product_return`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotations`
--
ALTER TABLE `quotations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `refills`
--
ALTER TABLE `refills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `refill_items`
--
ALTER TABLE `refill_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `returns`
--
ALTER TABLE `returns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `return_purchases`
--
ALTER TABLE `return_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reward_point_settings`
--
ALTER TABLE `reward_point_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sent_sms`
--
ALTER TABLE `sent_sms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shelves`
--
ALTER TABLE `shelves`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sms_templates`
--
ALTER TABLE `sms_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_counts`
--
ALTER TABLE `stock_counts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `variants`
--
ALTER TABLE `variants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
--
-- Database: `pharmacy5`
--
CREATE DATABASE IF NOT EXISTS `pharmacy5` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pharmacy5`;

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_no` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `initial_balance` double DEFAULT NULL,
  `total_balance` double NOT NULL,
  `note` text DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'Bank Account',
  `parent_account_id` int(11) DEFAULT NULL,
  `is_payment` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `account_no`, `name`, `initial_balance`, `total_balance`, `note`, `is_default`, `is_active`, `created_at`, `updated_at`, `code`, `type`, `parent_account_id`, `is_payment`) VALUES
(1, '019912229', 'Sales Account', 0, 0, 'This is the default account.', 1, 1, '2023-02-05 07:12:15', '2023-02-05 07:12:15', NULL, 'Bank Account', NULL, 1),
(2, '0147852', 'idi', 10000, 10000, NULL, NULL, 1, '2025-03-26 07:58:20', '2025-03-26 07:58:20', NULL, 'Bank Account', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `action_logs`
--

CREATE TABLE `action_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `action_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `entity_id` bigint(20) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `route` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `synced_at` timestamp NULL DEFAULT NULL,
  `pharmacy_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `adjustments`
--

CREATE TABLE `adjustments` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `total_qty` double NOT NULL,
  `item` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `employee_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `checkin` varchar(255) NOT NULL,
  `checkout` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `barcodes`
--

CREATE TABLE `barcodes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `width` double(22,4) DEFAULT NULL,
  `height` double(22,4) DEFAULT NULL,
  `paper_width` double(22,4) DEFAULT NULL,
  `paper_height` double(22,4) DEFAULT NULL,
  `top_margin` double(22,4) DEFAULT NULL,
  `left_margin` double(22,4) DEFAULT NULL,
  `row_distance` double(22,4) DEFAULT NULL,
  `col_distance` double(22,4) DEFAULT NULL,
  `stickers_in_one_row` int(11) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_continuous` tinyint(1) NOT NULL DEFAULT 0,
  `stickers_in_one_sheet` int(11) DEFAULT NULL,
  `is_custom` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barcodes`
--

INSERT INTO `barcodes` (`id`, `name`, `description`, `width`, `height`, `paper_width`, `paper_height`, `top_margin`, `left_margin`, `row_distance`, `col_distance`, `stickers_in_one_row`, `is_default`, `is_continuous`, `stickers_in_one_sheet`, `is_custom`, `created_at`, `updated_at`) VALUES
(1, '20 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 4\" x 1\", Labels per sheet: 20', 4.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.1250, 0.0000, 0.1875, 2, 0, 0, 20, NULL, NULL, NULL),
(2, '30 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2.625\" x 1\", Labels per sheet: 30', 2.6250, 1.0000, 8.5000, 11.0000, 0.5000, 0.1880, 0.0000, 0.1250, 3, 0, 0, 30, NULL, NULL, NULL),
(3, '32 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1.25\", Labels per sheet: 32', 2.0000, 1.2500, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 32, NULL, NULL, NULL),
(4, '40 Labels per sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 2\" x 1\", Labels per sheet: 40', 2.0000, 1.0000, 8.5000, 11.0000, 0.5000, 0.2500, 0.0000, 0.0000, 4, 0, 0, 40, NULL, NULL, NULL),
(5, '50 Labels per Sheet', 'Sheet Size: 8.5\" x 11\", Label Size: 1.5\" x 1\", Labels per sheet: 50', 1.5000, 1.0000, 8.5000, 11.0000, 0.5000, 0.5000, 0.0000, 0.0000, 5, 0, 0, 50, NULL, NULL, NULL),
(6, 'Continuous Rolls - 31.75mm x 25.4mm', 'Label Size: 31.75mm x 25.4mm, Gap: 3.18mm', 1.2500, 1.0000, 1.2500, 0.0000, 0.1250, 0.0000, 0.1250, 0.0000, 1, 0, 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `billers`
--

CREATE TABLE `billers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) NOT NULL,
  `vat_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `billers`
--

INSERT INTO `billers` (`id`, `name`, `image`, `company_name`, `vat_number`, `email`, `phone_number`, `address`, `city`, `state`, `postal_code`, `country`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Biller', NULL, 'Test Company', NULL, 'test@gmail.com', '12312', 'Test address', 'Test City', NULL, NULL, NULL, 1, '2023-05-28 06:53:51', '2023-05-28 06:53:51');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `title`, `image`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Brand', NULL, 1, '2023-05-28 06:51:38', '2023-05-28 06:51:38'),
(2, 'GB Pharma Limited', NULL, 1, '2025-03-25 17:44:43', '2025-03-25 17:44:43'),
(3, 'letap', NULL, 1, '2025-03-25 18:18:26', '2025-03-25 18:18:26');

-- --------------------------------------------------------

--
-- Table structure for table `cash_registers`
--

CREATE TABLE `cash_registers` (
  `id` int(10) UNSIGNED NOT NULL,
  `cash_in_hand` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cash_registers`
--

INSERT INTO `cash_registers` (`id`, `cash_in_hand`, `user_id`, `warehouse_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 0, 1, 1, 1, '2025-03-24 21:08:52', '2025-03-24 21:08:52'),
(2, 100, 2, 1, 1, '2025-03-25 17:31:46', '2025-03-25 17:31:46'),
(3, 12, 3, 1, 1, '2025-03-26 01:01:11', '2025-03-26 01:01:11');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image`, `parent_id`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Category', NULL, NULL, 1, '2023-05-28 06:51:00', '2023-05-28 06:51:00'),
(2, 'pain killer', NULL, NULL, 1, '2025-03-25 17:51:01', '2025-03-25 17:51:01'),
(3, 'ulcer', NULL, NULL, 1, '2025-03-25 18:18:50', '2025-03-25 18:18:50');

-- --------------------------------------------------------

--
-- Table structure for table `challans`
--

CREATE TABLE `challans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `courier_id` int(11) NOT NULL,
  `packing_slip_list` longtext NOT NULL,
  `amount_list` longtext NOT NULL,
  `cash_list` longtext DEFAULT NULL,
  `online_payment_list` longtext DEFAULT NULL,
  `cheque_list` longtext DEFAULT NULL,
  `delivery_charge_list` longtext DEFAULT NULL,
  `status_list` longtext DEFAULT NULL,
  `closing_date` date DEFAULT NULL,
  `created_by_id` int(11) NOT NULL,
  `closed_by_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `minimum_amount` double DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `used` int(11) NOT NULL,
  `expired_date` date NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `couriers`
--

CREATE TABLE `couriers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `couriers`
--

INSERT INTO `couriers` (`id`, `name`, `phone_number`, `address`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'obed', '0550936582', 'dome', 1, '2025-03-25 18:56:49', '2025-03-25 18:56:49'),
(2, 'kofi', '0550934168', 'lapaz', 1, '2025-03-25 18:57:41', '2025-03-25 18:57:41');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `exchange_rate` double NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `code`, `exchange_rate`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'US Dollar', 'USD', 0.06517, 1, '2020-11-01 00:22:58', '2025-02-04 17:17:08'),
(2, 'GHANA CEDI', 'GHS', 1, 1, '2025-02-04 17:17:29', '2025-02-04 17:17:29');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_group_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `tax_no` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `points` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deposit` double DEFAULT NULL,
  `expense` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customer_group_id`, `user_id`, `name`, `company_name`, `email`, `phone_number`, `tax_no`, `address`, `city`, `state`, `postal_code`, `country`, `points`, `is_active`, `created_at`, `updated_at`, `deposit`, `expense`) VALUES
(1, 1, NULL, 'John Doe', 'Test Company', 'john@gmail.com', '231312', NULL, 'Test address', 'Test City', NULL, NULL, NULL, NULL, 1, '2023-05-28 06:53:04', '2023-05-28 06:53:04', NULL, NULL),
(2, 1, NULL, 'tahiru', NULL, 'tahiru@gmail.com', '0550936771', NULL, 'anyaa', 'accra', NULL, NULL, NULL, NULL, 1, '2025-03-25 16:59:54', '2025-03-25 16:59:54', NULL, NULL),
(3, 1, NULL, 'obed', NULL, 'oninson45@gmail.com', '0256422216', NULL, NULL, 'Amasaman', NULL, NULL, NULL, NULL, 1, '2025-03-26 01:30:48', '2025-03-26 01:30:48', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customer_groups`
--

CREATE TABLE `customer_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `percentage` varchar(255) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_groups`
--

INSERT INTO `customer_groups` (`id`, `name`, `percentage`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'General', '0', 1, '2023-05-28 06:51:29', '2023-05-28 06:51:29');

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

CREATE TABLE `custom_fields` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `belongs_to` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `default_value` text DEFAULT NULL,
  `option_value` text DEFAULT NULL,
  `grid_value` int(11) NOT NULL,
  `is_table` tinyint(1) NOT NULL,
  `is_invoice` tinyint(1) NOT NULL,
  `is_required` tinyint(1) NOT NULL,
  `is_admin` tinyint(1) NOT NULL,
  `is_disable` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `packing_slip_ids` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `courier_id` int(11) DEFAULT NULL,
  `address` text NOT NULL,
  `delivered_by` varchar(255) DEFAULT NULL,
  `recieved_by` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`id`, `reference_no`, `sale_id`, `packing_slip_ids`, `user_id`, `courier_id`, `address`, `delivered_by`, `recieved_by`, `file`, `note`, `status`, `created_at`, `updated_at`) VALUES
(1, 'dr-20250325-065125', 2, NULL, 2, 1, 'anyaa accra', NULL, NULL, NULL, NULL, '3', '2025-03-25 18:51:45', '2025-03-25 18:58:26');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` int(10) UNSIGNED NOT NULL,
  `amount` double NOT NULL,
  `customer_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `applicable_for` varchar(255) NOT NULL,
  `product_list` longtext DEFAULT NULL,
  `valid_from` date NOT NULL,
  `valid_till` date NOT NULL,
  `type` varchar(255) NOT NULL,
  `value` double NOT NULL,
  `minimum_qty` double NOT NULL,
  `maximum_qty` double NOT NULL,
  `days` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plans`
--

CREATE TABLE `discount_plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plan_customers`
--

CREATE TABLE `discount_plan_customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `discount_plan_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discount_plan_discounts`
--

CREATE TABLE `discount_plan_discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `discount_id` int(11) NOT NULL,
  `discount_plan_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dso_alerts`
--

CREATE TABLE `dso_alerts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_info` longtext NOT NULL,
  `number_of_products` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `department_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `staff_id` varchar(191) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `expense_category_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `reference_no`, `expense_category_id`, `warehouse_id`, `account_id`, `user_id`, `cash_register_id`, `amount`, `note`, `created_at`, `updated_at`) VALUES
(1, 'er-20250325-063857', 1, 1, 1, 2, 2, 100, NULL, '2025-03-25 00:00:00', '2025-03-25 18:38:57');

-- --------------------------------------------------------

--
-- Table structure for table `expense_categories`
--

CREATE TABLE `expense_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expense_categories`
--

INSERT INTO `expense_categories` (`id`, `code`, `name`, `is_active`, `created_at`, `updated_at`) VALUES
(1, '74965071', 'transportation', 1, '2025-03-25 18:38:22', '2025-03-25 18:38:22');

-- --------------------------------------------------------

--
-- Table structure for table `external_services`
--

CREATE TABLE `external_services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `details` longtext NOT NULL,
  `module_status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`module_status`)),
  `active` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `external_services`
--

INSERT INTO `external_services` (`id`, `name`, `type`, `details`, `module_status`, `active`, `created_at`, `updated_at`) VALUES
(1, 'PayPal', 'payment', 'Client ID,Client Secret;abcd1234,wxyz5678', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(2, 'Stripe', 'payment', 'Public Key,Private Key;efgh1234,stuv5678', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(3, 'Razorpay', 'payment', 'Key,Secret;rzp_test_Y4MCcpHfZNU6rR,3Hr7SDqaZ0G5waN0jsLgsiLx', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(4, 'Paystack', 'payment', 'public_Key,Secret_Key;pk_test_e8d220b7463d64569f0053e78534f38e6b10cf4a,sk_test_6d62cb976e1e0ab43f1e48b2934b0dfc7f32a1fe', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(5, 'Mollie', 'payment', 'api_key;test_dHar4XY7LxsDOtmnkVtjNVWXLSlXsM', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(6, 'Xendit', 'payment', 'secret_key,callback_token;xnd_development_aKJVKYbc4lHkEjcCLzWLrBsKs6jF6nbM6WaCMfnJerP3JW57CLis553XNRdDU,YPZxND92Mt8tdXntTYIEkRX802onZ5OcdKBUzycebuqYvN4n', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(7, 'bkash', 'payment', 'Mode,app_key,app_secret,username,password;sandbox,0vWQuCRGiUX7EPVjQDr0EUAYtc,jcUNPBgbcqEDedNKdvE4G1cAK7D3hCjmJccNPZZBq96QIxxwAMEx,01770618567,D7DaC<*E*eG', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(8, 'sslcommerz', 'payment', 'appkey,appsecret;12341234,asdfa23423', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(9, 'Mpesa', 'payment', 'consumer_Key,consumer_Secret;fhfgkj,dtrddhd', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43'),
(10, 'Pesapal', 'payment', 'Mode,Consumer Key,Consumer Secret;sandbox,qkio1BGGYAXTu2JOfm7XSXNruoZsrqEW,osGQ364R49cXKeOYSpaOnT++rHs=', '{\"salepro\": true, \"ecommerce\": true}', 1, '2024-11-29 19:15:43', '2024-11-29 19:15:43');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `site_title` varchar(255) NOT NULL,
  `site_logo` varchar(255) DEFAULT NULL,
  `is_rtl` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `currency` varchar(255) NOT NULL,
  `package_id` int(11) DEFAULT NULL,
  `subscription_type` varchar(255) DEFAULT NULL,
  `staff_access` varchar(255) NOT NULL,
  `without_stock` varchar(255) NOT NULL DEFAULT 'no',
  `date_format` varchar(255) NOT NULL,
  `developed_by` varchar(255) DEFAULT NULL,
  `invoice_format` varchar(255) DEFAULT NULL,
  `decimal` int(11) DEFAULT 2,
  `state` int(11) DEFAULT NULL,
  `theme` varchar(255) NOT NULL,
  `modules` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `currency_position` varchar(255) NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `expiry_type` varchar(255) NOT NULL DEFAULT 'days',
  `expiry_value` varchar(255) NOT NULL DEFAULT '0',
  `is_zatca` tinyint(1) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `vat_registration_number` varchar(255) DEFAULT NULL,
  `is_packing_slip` tinyint(1) NOT NULL DEFAULT 0,
  `sms_credit` bigint(20) UNSIGNED DEFAULT NULL,
  `pharmacy_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `site_title`, `site_logo`, `is_rtl`, `created_at`, `updated_at`, `currency`, `package_id`, `subscription_type`, `staff_access`, `without_stock`, `date_format`, `developed_by`, `invoice_format`, `decimal`, `state`, `theme`, `modules`, `currency_position`, `expiry_date`, `expiry_type`, `expiry_value`, `is_zatca`, `company_name`, `vat_registration_number`, `is_packing_slip`, `sms_credit`, `pharmacy_id`) VALUES
(1, 'GogoPlus POS', '20250202043823.png', 0, '2018-07-06 06:13:11', '2025-03-24 20:23:33', '1', 3, 'monthly', 'own', 'no', 'd/m/Y', 'GogoPlus Ltd.', 'standard', 2, 1, 'default.css', '', 'prefix', '2025-05-03', 'days', '0', NULL, NULL, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `gift_cards`
--

CREATE TABLE `gift_cards` (
  `id` int(10) UNSIGNED NOT NULL,
  `card_no` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `expense` double NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `gift_card_recharges`
--

CREATE TABLE `gift_card_recharges` (
  `id` int(10) UNSIGNED NOT NULL,
  `gift_card_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `note` text DEFAULT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hrm_settings`
--

CREATE TABLE `hrm_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `checkin` varchar(255) NOT NULL,
  `checkout` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `incomes`
--

CREATE TABLE `incomes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `income_category_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `income_categories`
--

CREATE TABLE `income_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `insurance_provider`
--

CREATE TABLE `insurance_provider` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mail_settings`
--

CREATE TABLE `mail_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `driver` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `port` varchar(255) NOT NULL,
  `from_address` varchar(255) NOT NULL,
  `from_name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `encryption` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
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
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_02_17_060412_create_categories_table', 1),
(4, '2018_02_20_035727_create_brands_table', 1),
(5, '2018_02_25_100635_create_suppliers_table', 1),
(6, '2018_02_27_101619_create_warehouse_table', 1),
(7, '2018_03_03_040448_create_units_table', 1),
(8, '2018_03_04_041317_create_taxes_table', 1),
(9, '2018_03_10_061915_create_customer_groups_table', 1),
(10, '2018_03_10_090534_create_customers_table', 1),
(11, '2018_03_11_095547_create_billers_table', 1),
(12, '2018_04_05_054401_create_products_table', 1),
(13, '2018_04_06_133606_create_purchases_table', 1),
(14, '2018_04_06_154600_create_product_purchases_table', 1),
(15, '2018_04_06_154915_create_product_warhouse_table', 1),
(16, '2018_04_10_085927_create_sales_table', 1),
(17, '2018_04_10_090133_create_product_sales_table', 1),
(18, '2018_04_10_090254_create_payments_table', 1),
(19, '2018_04_10_090341_create_payment_with_cheque_table', 1),
(20, '2018_04_10_090509_create_payment_with_credit_card_table', 1),
(21, '2018_04_13_121436_create_quotation_table', 1),
(22, '2018_04_13_122324_create_product_quotation_table', 1),
(23, '2018_04_14_121802_create_transfers_table', 1),
(24, '2018_04_14_121913_create_product_transfer_table', 1),
(25, '2018_05_13_082847_add_payment_id_and_change_sale_id_to_payments_table', 1),
(26, '2018_05_13_090906_change_customer_id_to_payment_with_credit_card_table', 1),
(27, '2018_05_20_054532_create_adjustments_table', 1),
(28, '2018_05_20_054859_create_product_adjustments_table', 1),
(29, '2018_05_21_163419_create_returns_table', 1),
(30, '2018_05_21_163443_create_product_returns_table', 1),
(31, '2018_06_02_050905_create_roles_table', 1),
(32, '2018_06_02_073430_add_columns_to_users_table', 1),
(33, '2018_06_03_053738_create_permission_tables', 1),
(34, '2018_06_21_063736_create_pos_setting_table', 1),
(35, '2018_06_21_094155_add_user_id_to_sales_table', 1),
(36, '2018_06_21_101529_add_user_id_to_purchases_table', 1),
(37, '2018_06_21_103512_add_user_id_to_transfers_table', 1),
(38, '2018_06_23_061058_add_user_id_to_quotations_table', 1),
(39, '2018_06_23_082427_add_is_deleted_to_users_table', 1),
(40, '2018_06_25_043308_change_email_to_users_table', 1),
(41, '2018_07_06_115449_create_general_settings_table', 1),
(42, '2018_07_08_043944_create_languages_table', 1),
(43, '2018_07_11_102144_add_user_id_to_returns_table', 1),
(44, '2018_07_11_102334_add_user_id_to_payments_table', 1),
(45, '2018_07_22_130541_add_digital_to_products_table', 1),
(46, '2018_07_24_154250_create_deliveries_table', 1),
(47, '2018_08_16_053336_create_expense_categories_table', 1),
(48, '2018_08_17_115415_create_expenses_table', 1),
(49, '2018_08_18_050418_create_gift_cards_table', 1),
(50, '2018_08_19_063119_create_payment_with_gift_card_table', 1),
(51, '2018_08_25_042333_create_gift_card_recharges_table', 1),
(52, '2018_08_25_101354_add_deposit_expense_to_customers_table', 1),
(53, '2018_08_26_043801_create_deposits_table', 1),
(54, '2018_09_02_044042_add_keybord_active_to_pos_setting_table', 1),
(55, '2018_09_09_092713_create_payment_with_paypal_table', 1),
(56, '2018_09_10_051254_add_currency_to_general_settings_table', 1),
(57, '2018_10_22_084118_add_biller_and_store_id_to_users_table', 1),
(58, '2018_10_26_034927_create_coupons_table', 1),
(59, '2018_10_27_090857_add_coupon_to_sales_table', 1),
(60, '2018_11_07_070155_add_currency_position_to_general_settings_table', 1),
(61, '2018_11_19_094650_add_combo_to_products_table', 1),
(62, '2018_12_09_043712_create_accounts_table', 1),
(63, '2018_12_17_112253_add_is_default_to_accounts_table', 1),
(64, '2018_12_19_103941_add_account_id_to_payments_table', 1),
(65, '2018_12_20_065900_add_account_id_to_expenses_table', 1),
(66, '2018_12_20_082753_add_account_id_to_returns_table', 1),
(67, '2018_12_26_064330_create_return_purchases_table', 1),
(68, '2018_12_26_144708_create_purchase_product_return_table', 1),
(69, '2018_12_27_110018_create_departments_table', 1),
(70, '2018_12_30_054844_create_employees_table', 1),
(71, '2018_12_31_125210_create_payrolls_table', 1),
(72, '2018_12_31_150446_add_department_id_to_employees_table', 1),
(73, '2019_01_01_062708_add_user_id_to_expenses_table', 1),
(74, '2019_01_02_075644_create_hrm_settings_table', 1),
(75, '2019_01_02_090334_create_attendances_table', 1),
(76, '2019_01_27_160956_add_three_columns_to_general_settings_table', 1),
(77, '2019_02_15_183303_create_stock_counts_table', 1),
(78, '2019_02_17_101604_add_is_adjusted_to_stock_counts_table', 1),
(79, '2019_04_13_101707_add_tax_no_to_customers_table', 1),
(80, '2019_08_19_000000_create_failed_jobs_table', 1),
(81, '2019_10_14_111455_create_holidays_table', 1),
(82, '2019_11_13_145619_add_is_variant_to_products_table', 1),
(83, '2019_11_13_150206_create_product_variants_table', 1),
(84, '2019_11_13_153828_create_variants_table', 1),
(85, '2019_11_25_134041_add_qty_to_product_variants_table', 1),
(86, '2019_11_25_134922_add_variant_id_to_product_purchases_table', 1),
(87, '2019_11_25_145341_add_variant_id_to_product_warehouse_table', 1),
(88, '2019_11_29_182201_add_variant_id_to_product_sales_table', 1),
(89, '2019_12_04_121311_add_variant_id_to_product_quotation_table', 1),
(90, '2019_12_05_123802_add_variant_id_to_product_transfer_table', 1),
(91, '2019_12_08_114954_add_variant_id_to_product_returns_table', 1),
(92, '2019_12_08_203146_add_variant_id_to_purchase_product_return_table', 1),
(93, '2020_02_28_103340_create_money_transfers_table', 1),
(94, '2020_07_01_193151_add_image_to_categories_table', 1),
(95, '2020_09_26_130426_add_user_id_to_deliveries_table', 1),
(96, '2020_10_11_125457_create_cash_registers_table', 1),
(97, '2020_10_13_155019_add_cash_register_id_to_sales_table', 1),
(98, '2020_10_13_172624_add_cash_register_id_to_returns_table', 1),
(99, '2020_10_17_212338_add_cash_register_id_to_payments_table', 1),
(100, '2020_10_18_124200_add_cash_register_id_to_expenses_table', 1),
(101, '2020_10_21_121632_add_developed_by_to_general_settings_table', 1),
(102, '2020_10_30_135557_create_notifications_table', 1),
(103, '2020_11_01_044954_create_currencies_table', 1),
(104, '2020_11_01_140736_add_price_to_product_warehouse_table', 1),
(105, '2020_11_02_050633_add_is_diff_price_to_products_table', 1),
(106, '2020_11_09_055222_add_user_id_to_customers_table', 1),
(107, '2020_11_17_054806_add_invoice_format_to_general_settings_table', 1),
(108, '2021_02_10_074859_add_variant_id_to_product_adjustments_table', 1),
(109, '2021_03_07_093606_create_product_batches_table', 1),
(110, '2021_03_07_093759_add_product_batch_id_to_product_warehouse_table', 1),
(111, '2021_03_07_093900_add_product_batch_id_to_product_purchases_table', 1),
(112, '2021_03_11_132603_add_product_batch_id_to_product_sales_table', 1),
(113, '2021_03_25_125421_add_is_batch_to_products_table', 1),
(114, '2021_05_19_120127_add_product_batch_id_to_product_returns_table', 1),
(115, '2021_05_22_105611_add_product_batch_id_to_purchase_product_return_table', 1),
(116, '2021_05_23_124848_add_product_batch_id_to_product_transfer_table', 1),
(117, '2021_05_26_153106_add_product_batch_id_to_product_quotation_table', 1),
(118, '2021_06_08_213007_create_reward_point_settings_table', 1),
(119, '2021_06_16_104155_add_points_to_customers_table', 1),
(120, '2021_06_17_101057_add_used_points_to_payments_table', 1),
(121, '2021_07_06_132716_add_variant_list_to_products_table', 1),
(122, '2021_09_27_161141_add_is_imei_to_products_table', 1),
(123, '2021_09_28_170052_add_imei_number_to_product_warehouse_table', 1),
(124, '2021_09_28_170126_add_imei_number_to_product_purchases_table', 1),
(125, '2021_10_03_170652_add_imei_number_to_product_sales_table', 1),
(126, '2021_10_10_145214_add_imei_number_to_product_returns_table', 1),
(127, '2021_10_11_104504_add_imei_number_to_product_transfer_table', 1),
(128, '2021_10_12_160107_add_imei_number_to_purchase_product_return_table', 1),
(129, '2021_10_12_205146_add_is_rtl_to_general_settings_table', 1),
(130, '2022_01_13_191242_create_discount_plans_table', 1),
(131, '2022_01_14_174318_create_discount_plan_customers_table', 1),
(132, '2022_01_14_202439_create_discounts_table', 1),
(133, '2022_01_16_153506_create_discount_plan_discounts_table', 1),
(134, '2022_02_05_174210_add_order_discount_type_and_value_to_sales_table', 1),
(135, '2022_05_26_195506_add_daily_sale_objective_to_products_table', 1),
(136, '2022_05_28_104209_create_dso_alerts_table', 1),
(137, '2022_06_01_112100_add_is_embeded_to_products_table', 1),
(138, '2022_06_14_130505_add_sale_id_to_returns_table', 1),
(139, '2022_07_19_115504_add_variant_data_to_products_table', 1),
(140, '2022_07_25_194300_add_additional_cost_to_product_variants_table', 1),
(141, '2022_09_04_195610_add_purchase_id_to_return_purchases_table', 1),
(142, '2023_01_18_125040_alter_table_general_settings', 1),
(143, '2023_01_18_133701_alter_table_pos_setting', 1),
(144, '2023_01_25_145309_add_expiry_date_to_general_settings_table', 1),
(145, '2023_02_05_132001_add_change_to_payments_table', 1),
(146, '2023_02_23_125656_alter_table_sales', 1),
(147, '2023_02_26_124100_add_package_id_to_general_settings_table', 1),
(148, '2023_03_04_120325_create_custom_fields_table', 1),
(149, '2023_03_14_174658_add_subscription_type_to_general_setting_table', 1),
(150, '2023_03_22_174352_add_currency_id_and_exchange_rate_to_returns_table', 1),
(151, '2023_03_27_114320_add_currency_id_and_exchange_rate_to_purchases_table', 1),
(152, '2023_03_27_132747_add_currency_id_and_exchange_rate_to_return_purchases_table', 1),
(153, '2023_04_25_150236_create_mail_settings_table', 1),
(154, '2023_05_13_125424_add_zatca_to_general_settings_table', 1),
(155, '2023_05_28_155540_create_tables_table', 1),
(156, '2023_05_29_115039_add_is_table_to_pos_setting_table', 1),
(157, '2023_05_29_115301_add_table_id_to_sales_table', 1),
(158, '2023_05_31_165049_add_queue_no_to_sales_table', 1),
(159, '2023_07_23_160254_create_couriers_table', 1),
(160, '2023_07_23_174343_add_courier_id_to_deliveries_table', 1),
(161, '2023_08_12_124016_add_staff_id_to_employees_table', 1),
(162, '2023_08_14_142608_add_is_active_to_currencies_table', 1),
(163, '2023_08_24_130203_change_columns_to_attendances_table', 1),
(164, '2023_09_10_134503_add_without_stock_to_general_settings_table', 1),
(165, '2023_09_26_211542_add_modules_to_general_settings_table', 1),
(166, '2023_10_15_124306_add_return_qty_to_product_sales_table', 1),
(167, '2023_12_03_235606_crete_external_services_table', 1),
(168, '2024_02_04_131826_add_unit_cost_to_product_adjustments_table', 1),
(169, '2024_02_13_173126_change_modules_to_general_settings_table', 1),
(170, '2024_05_02_114215_add_payment_receiver_to_payments', 1),
(171, '2024_05_06_132553_create_sms_templates_table', 1),
(172, '2024_05_07_102225_add_send_sms_to_pos_setting_table', 1),
(173, '2024_05_07_132625_add_is_default_to_sms_templates_table', 1),
(174, '2024_05_08_112211_change_address_and_city_field_to_nullable_in_customers_table', 1),
(175, '2024_05_08_151050_add_is_default_ecommerce_columne_to_sms_templates_table', 1),
(176, '2024_05_20_182757_add_wholesale_price_to_products_table', 1),
(177, '2024_05_21_170500_add_is_sent_to_transfers_table', 1),
(178, '2024_06_04_225113_create_income_categories_table', 1),
(179, '2024_06_04_225128_create_incomes_table', 1),
(180, '2024_06_29_131917_add_is_packing_slip_to_general_settings_table', 1),
(181, '2024_07_05_192531_create_packing_slips_table', 1),
(182, '2024_07_05_193002_create_packing_slip_products_table', 1),
(183, '2024_07_05_194501_add_is_packing_and_delivered_to_product_sales_table', 1),
(184, '2024_07_14_122245_add_delivery_id_to_packing_slips_table', 1),
(185, '2024_07_14_122415_add_variant_id_to_packing_slip_products_table', 1),
(186, '2024_07_14_122519_add_packing_slip_ids_to_deliveries_table', 1),
(187, '2024_07_16_125908_create_challans_table', 1),
(188, '2024_08_12_112830_add_thermal_invoice_size_to_pos_setting', 1),
(189, '2024_08_14_133351_add_expiry_type_value_to_general_settings', 1),
(190, '2024_09_11_151744_add_return_qty_to_product_purchases_table', 1),
(191, '2024_09_12_162309_create_barcodes_table', 1),
(192, '2024_10_10_121312_add_data_to_payment_with_credit_card_table', 1),
(193, '2024_10_10_212501_alter_attendances_table', 1),
(194, '2024_10_10_213757_alter_attendances_table', 1),
(195, '2024_10_14_144917_change_column_to_nullable_to_payment_with_credit_card_table', 1),
(196, '2024_11_10_121521_add_code_and_type_to_accounts_table', 1),
(197, '2024_11_24_100926_add_module_status_to_external_services_table', 1),
(198, '2025_03_09_000000_create_insurance_provider_table', 1),
(199, '2025_03_09_000001_create_payment_with_insurance_table', 1),
(200, '2025_03_09_000002_create_refills_table', 1),
(201, '2025_03_09_000003_create_refill_items_table', 1),
(202, '2025_03_09_000004_add_columns_to_products_table', 1),
(203, '2025_03_09_000005_add_dosage_to_product_sales_table', 1),
(204, '2025_03_09_000006_create_shelves_table', 1),
(205, '2025_03_12_000007_update_products_table_with_markups_and_units', 1),
(206, '2025_03_24_000000_create_payment_with_mobile_money_table', 1),
(207, '2025_03_24_000001_create_sent_sms_table', 1),
(208, '2025_03_24_000002_add_next_refill_date_to_refill_items_table', 1),
(209, '2025_03_24_000003_add_sms_credit_to_general_settings_table', 1),
(210, '2025_03_24_000004_add_customer_name_and_expiry_to_payment_with_insurance_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `money_transfers`
--

CREATE TABLE `money_transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `from_account_id` int(11) NOT NULL,
  `to_account_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `packing_slips`
--

CREATE TABLE `packing_slips` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `delivery_id` int(11) DEFAULT NULL,
  `amount` double NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `packing_slip_products`
--

CREATE TABLE `packing_slip_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `packing_slip_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `payment_receiver` varchar(255) DEFAULT NULL,
  `payment_reference` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `used_points` double DEFAULT NULL,
  `change` double DEFAULT NULL,
  `paying_method` varchar(255) NOT NULL,
  `payment_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `purchase_id`, `sale_id`, `cash_register_id`, `account_id`, `payment_receiver`, `payment_reference`, `user_id`, `amount`, `used_points`, `change`, `paying_method`, `payment_note`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 2, 1, 'iddrisu', 'spr-20250325-064247', 2, 3.26, NULL, 1.74, 'Cash', NULL, '2025-03-25 18:42:47', '2025-03-25 18:42:47'),
(2, NULL, 2, 2, 1, 'iddrisu', 'spr-20250325-065012', 2, 0, NULL, 2, 'Cash', NULL, '2025-03-25 18:50:12', '2025-03-25 18:50:12'),
(3, NULL, 5, 3, 1, NULL, 'spr-20250326-085920', 3, 8, NULL, 21, 'Cash', NULL, '2025-03-26 08:59:20', '2025-03-26 08:59:20'),
(4, NULL, 6, 1, 1, 'intern', 'spr-20250326-092257', 1, 1.3, NULL, 0, 'Mobile Money', NULL, '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_cheque`
--

CREATE TABLE `payment_with_cheque` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `cheque_no` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_credit_card`
--

CREATE TABLE `payment_with_credit_card` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_stripe_id` varchar(255) DEFAULT NULL,
  `charge_id` varchar(255) NOT NULL,
  `data` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_gift_card`
--

CREATE TABLE `payment_with_gift_card` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `gift_card_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_insurance`
--

CREATE TABLE `payment_with_insurance` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_insurance_id` varchar(255) DEFAULT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  `insurer` varchar(255) NOT NULL,
  `insurance_policy_id` varchar(255) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `approved_amount` decimal(10,2) DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_mobile_money`
--

CREATE TABLE `payment_with_mobile_money` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `network` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_with_mobile_money`
--

INSERT INTO `payment_with_mobile_money` (`id`, `payment_id`, `customer_id`, `phone_number`, `reference`, `network`, `created_at`, `updated_at`) VALUES
(1, 4, 1, '0247118423', '48907553128655', 'MTN', '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `payment_with_paypal`
--

CREATE TABLE `payment_with_paypal` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(11) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payrolls`
--

CREATE TABLE `payrolls` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `paying_method` varchar(255) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(4, 'products-edit', 'web', '2018-06-03 01:00:09', '2018-06-03 01:00:09'),
(5, 'products-delete', 'web', '2018-06-03 22:54:22', '2018-06-03 22:54:22'),
(6, 'products-add', 'web', '2018-06-04 00:34:14', '2018-06-04 00:34:14'),
(7, 'products-index', 'web', '2018-06-04 03:34:27', '2018-06-04 03:34:27'),
(8, 'purchases-index', 'web', '2018-06-04 08:03:19', '2018-06-04 08:03:19'),
(9, 'purchases-add', 'web', '2018-06-04 08:12:25', '2018-06-04 08:12:25'),
(10, 'purchases-edit', 'web', '2018-06-04 09:47:36', '2018-06-04 09:47:36'),
(11, 'purchases-delete', 'web', '2018-06-04 09:47:36', '2018-06-04 09:47:36'),
(12, 'sales-index', 'web', '2018-06-04 10:49:08', '2018-06-04 10:49:08'),
(13, 'sales-add', 'web', '2018-06-04 10:49:52', '2018-06-04 10:49:52'),
(14, 'sales-edit', 'web', '2018-06-04 10:49:52', '2018-06-04 10:49:52'),
(15, 'sales-delete', 'web', '2018-06-04 10:49:53', '2018-06-04 10:49:53'),
(16, 'quotes-index', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(17, 'quotes-add', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(18, 'quotes-edit', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(19, 'quotes-delete', 'web', '2018-06-04 22:05:10', '2018-06-04 22:05:10'),
(20, 'transfers-index', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(21, 'transfers-add', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(22, 'transfers-edit', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(23, 'transfers-delete', 'web', '2018-06-04 22:30:03', '2018-06-04 22:30:03'),
(24, 'returns-index', 'web', '2018-06-04 22:50:24', '2018-06-04 22:50:24'),
(25, 'returns-add', 'web', '2018-06-04 22:50:24', '2018-06-04 22:50:24'),
(26, 'returns-edit', 'web', '2018-06-04 22:50:25', '2018-06-04 22:50:25'),
(27, 'returns-delete', 'web', '2018-06-04 22:50:25', '2018-06-04 22:50:25'),
(28, 'customers-index', 'web', '2018-06-04 23:15:54', '2018-06-04 23:15:54'),
(29, 'customers-add', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(30, 'customers-edit', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(31, 'customers-delete', 'web', '2018-06-04 23:15:55', '2018-06-04 23:15:55'),
(32, 'suppliers-index', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(33, 'suppliers-add', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(34, 'suppliers-edit', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(35, 'suppliers-delete', 'web', '2018-06-04 23:40:12', '2018-06-04 23:40:12'),
(36, 'product-report', 'web', '2018-06-24 23:05:33', '2018-06-24 23:05:33'),
(37, 'purchase-report', 'web', '2018-06-24 23:24:56', '2018-06-24 23:24:56'),
(38, 'sale-report', 'web', '2018-06-24 23:33:13', '2018-06-24 23:33:13'),
(39, 'customer-report', 'web', '2018-06-24 23:36:51', '2018-06-24 23:36:51'),
(40, 'due-report', 'web', '2018-06-24 23:39:52', '2018-06-24 23:39:52'),
(41, 'users-index', 'web', '2018-06-25 00:00:10', '2018-06-25 00:00:10'),
(42, 'users-add', 'web', '2018-06-25 00:00:10', '2018-06-25 00:00:10'),
(43, 'users-edit', 'web', '2018-06-25 00:01:30', '2018-06-25 00:01:30'),
(44, 'users-delete', 'web', '2018-06-25 00:01:30', '2018-06-25 00:01:30'),
(45, 'profit-loss', 'web', '2018-07-14 21:50:05', '2018-07-14 21:50:05'),
(46, 'best-seller', 'web', '2018-07-14 22:01:38', '2018-07-14 22:01:38'),
(47, 'daily-sale', 'web', '2018-07-14 22:24:21', '2018-07-14 22:24:21'),
(48, 'monthly-sale', 'web', '2018-07-14 22:30:41', '2018-07-14 22:30:41'),
(49, 'daily-purchase', 'web', '2018-07-14 22:36:46', '2018-07-14 22:36:46'),
(50, 'monthly-purchase', 'web', '2018-07-14 22:48:17', '2018-07-14 22:48:17'),
(51, 'payment-report', 'web', '2018-07-14 23:10:41', '2018-07-14 23:10:41'),
(52, 'warehouse-stock-report', 'web', '2018-07-14 23:16:55', '2018-07-14 23:16:55'),
(53, 'product-qty-alert', 'web', '2018-07-14 23:33:21', '2018-07-14 23:33:21'),
(54, 'supplier-report', 'web', '2018-07-30 03:00:01', '2018-07-30 03:00:01'),
(55, 'expenses-index', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(56, 'expenses-add', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(57, 'expenses-edit', 'web', '2018-09-05 01:07:10', '2018-09-05 01:07:10'),
(58, 'expenses-delete', 'web', '2018-09-05 01:07:11', '2018-09-05 01:07:11'),
(59, 'general_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(60, 'mail_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(61, 'pos_setting', 'web', '2018-10-19 23:10:04', '2018-10-19 23:10:04'),
(62, 'hrm_setting', 'web', '2019-01-02 10:30:23', '2019-01-02 10:30:23'),
(63, 'purchase-return-index', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(64, 'purchase-return-add', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(65, 'purchase-return-edit', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(66, 'purchase-return-delete', 'web', '2019-01-02 21:45:14', '2019-01-02 21:45:14'),
(67, 'account-index', 'web', '2019-01-02 22:06:13', '2019-01-02 22:06:13'),
(68, 'balance-sheet', 'web', '2019-01-02 22:06:14', '2019-01-02 22:06:14'),
(69, 'account-statement', 'web', '2019-01-02 22:06:14', '2019-01-02 22:06:14'),
(70, 'department', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(71, 'attendance', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(72, 'payroll', 'web', '2019-01-02 22:30:01', '2019-01-02 22:30:01'),
(73, 'employees-index', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(74, 'employees-add', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(75, 'employees-edit', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(76, 'employees-delete', 'web', '2019-01-02 22:52:19', '2019-01-02 22:52:19'),
(77, 'user-report', 'web', '2019-01-16 06:48:18', '2019-01-16 06:48:18'),
(78, 'stock_count', 'web', '2019-02-17 10:32:01', '2019-02-17 10:32:01'),
(79, 'adjustment', 'web', '2019-02-17 10:32:02', '2019-02-17 10:32:02'),
(80, 'sms_setting', 'web', '2019-02-22 05:18:03', '2019-02-22 05:18:03'),
(81, 'create_sms', 'web', '2019-02-22 05:18:03', '2019-02-22 05:18:03'),
(82, 'print_barcode', 'web', '2019-03-07 05:02:19', '2019-03-07 05:02:19'),
(83, 'empty_database', 'web', '2019-03-07 05:02:19', '2019-03-07 05:02:19'),
(84, 'customer_group', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(85, 'unit', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(86, 'tax', 'web', '2019-03-07 05:37:15', '2019-03-07 05:37:15'),
(87, 'gift_card', 'web', '2019-03-07 06:29:38', '2019-03-07 06:29:38'),
(88, 'coupon', 'web', '2019-03-07 06:29:38', '2019-03-07 06:29:38'),
(89, 'holiday', 'web', '2019-10-19 08:57:15', '2019-10-19 08:57:15'),
(90, 'warehouse-report', 'web', '2019-10-22 06:00:23', '2019-10-22 06:00:23'),
(91, 'warehouse', 'web', '2020-02-26 06:47:32', '2020-02-26 06:47:32'),
(92, 'brand', 'web', '2020-02-26 06:59:59', '2020-02-26 06:59:59'),
(93, 'billers-index', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(94, 'billers-add', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(95, 'billers-edit', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(96, 'billers-delete', 'web', '2020-02-26 07:11:15', '2020-02-26 07:11:15'),
(97, 'money-transfer', 'web', '2020-03-02 05:41:48', '2020-03-02 05:41:48'),
(98, 'category', 'web', '2020-07-13 12:13:16', '2020-07-13 12:13:16'),
(99, 'delivery', 'web', '2020-07-13 12:13:16', '2020-07-13 12:13:16'),
(100, 'send_notification', 'web', '2020-10-31 06:21:31', '2020-10-31 06:21:31'),
(101, 'today_sale', 'web', '2020-10-31 06:57:04', '2020-10-31 06:57:04'),
(102, 'today_profit', 'web', '2020-10-31 06:57:04', '2020-10-31 06:57:04'),
(103, 'currency', 'web', '2020-11-09 00:23:11', '2020-11-09 00:23:11'),
(104, 'backup_database', 'web', '2020-11-15 00:16:55', '2020-11-15 00:16:55'),
(105, 'reward_point_setting', 'web', '2021-06-27 04:34:42', '2021-06-27 04:34:42'),
(106, 'revenue_profit_summary', 'web', '2022-02-08 13:57:21', '2022-02-08 13:57:21'),
(107, 'cash_flow', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(108, 'monthly_summary', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(109, 'yearly_report', 'web', '2022-02-08 13:57:22', '2022-02-08 13:57:22'),
(110, 'discount_plan', 'web', '2022-02-16 09:12:26', '2022-02-16 09:12:26'),
(111, 'discount', 'web', '2022-02-16 09:12:38', '2022-02-16 09:12:38'),
(112, 'product-expiry-report', 'web', '2022-03-30 05:39:20', '2022-03-30 05:39:20'),
(113, 'purchase-payment-index', 'web', '2022-06-05 14:12:27', '2022-06-05 14:12:27'),
(114, 'purchase-payment-add', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(115, 'purchase-payment-edit', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(116, 'purchase-payment-delete', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(117, 'sale-payment-index', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(118, 'sale-payment-add', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(119, 'sale-payment-edit', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(120, 'sale-payment-delete', 'web', '2022-06-05 14:12:28', '2022-06-05 14:12:28'),
(121, 'all_notification', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(122, 'sale-report-chart', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(123, 'dso-report', 'web', '2022-06-05 14:12:29', '2022-06-05 14:12:29'),
(124, 'product_history', 'web', '2022-08-25 14:04:05', '2022-08-25 14:04:05'),
(125, 'supplier-due-report', 'web', '2022-08-31 09:46:33', '2022-08-31 09:46:33'),
(126, 'custom_field', 'web', '2023-11-13 06:23:34', '2023-11-13 06:23:34'),
(127, 'incomes-index', 'web', '2024-07-11 13:16:43', '2024-07-11 13:16:43'),
(128, 'incomes-add', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(129, 'incomes-edit', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(130, 'incomes-delete', 'web', '2024-07-11 13:16:44', '2024-07-11 13:16:44'),
(131, 'packing_slip_challan', 'web', '2024-07-22 14:16:17', '2024-07-22 14:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `pos_setting`
--

CREATE TABLE `pos_setting` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `product_number` int(11) NOT NULL,
  `keybord_active` tinyint(1) NOT NULL,
  `is_table` tinyint(1) NOT NULL DEFAULT 0,
  `send_sms` tinyint(1) NOT NULL DEFAULT 0,
  `stripe_public_key` varchar(255) DEFAULT NULL,
  `stripe_secret_key` varchar(255) DEFAULT NULL,
  `paypal_live_api_username` varchar(255) DEFAULT NULL,
  `paypal_live_api_password` varchar(255) DEFAULT NULL,
  `paypal_live_api_secret` varchar(255) DEFAULT NULL,
  `payment_options` text DEFAULT NULL,
  `invoice_option` varchar(10) DEFAULT NULL,
  `thermal_invoice_size` varchar(255) NOT NULL DEFAULT '80',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pos_setting`
--

INSERT INTO `pos_setting` (`id`, `customer_id`, `warehouse_id`, `biller_id`, `product_number`, `keybord_active`, `is_table`, `send_sms`, `stripe_public_key`, `stripe_secret_key`, `paypal_live_api_username`, `paypal_live_api_password`, `paypal_live_api_secret`, `payment_options`, `invoice_option`, `thermal_invoice_size`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 2, 1, 0, 0, NULL, NULL, NULL, NULL, NULL, 'cash,card,cheque,gift_card,deposit,mobile_money,credit,insurance', 'thermal', '80', '2023-05-28 06:57:03', '2025-03-24 23:17:23');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `shelf` varchar(50) DEFAULT NULL,
  `max_product` int(11) NOT NULL DEFAULT 50,
  `shelf_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `barcode_symbology` varchar(255) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `retail_units_per_wholesale` double DEFAULT NULL COMMENT 'Number of retail units in one wholesale unit, e.g., 15 bottles per box',
  `cost` double NOT NULL,
  `wholesale_markup` double DEFAULT NULL COMMENT 'Markup percentage for wholesale price',
  `wholesale_price` double DEFAULT NULL COMMENT 'Price per wholesale unit (e.g., box)',
  `retail_markup` double DEFAULT NULL COMMENT 'Markup percentage for retail price',
  `price` double DEFAULT NULL COMMENT 'Price per retail unit (e.g., bottle)',
  `qty` double DEFAULT NULL,
  `alert_quantity` double DEFAULT NULL,
  `daily_sale_objective` double DEFAULT NULL,
  `promotion` tinyint(4) DEFAULT NULL,
  `promotion_price` varchar(255) DEFAULT NULL,
  `starting_date` date DEFAULT NULL,
  `last_date` date DEFAULT NULL,
  `tax_id` int(11) DEFAULT NULL,
  `tax_method` int(11) DEFAULT NULL,
  `image` longtext DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `is_embeded` tinyint(1) DEFAULT NULL,
  `is_variant` tinyint(1) DEFAULT NULL,
  `is_batch` tinyint(1) DEFAULT NULL,
  `is_diffPrice` tinyint(1) DEFAULT NULL,
  `is_imei` tinyint(1) DEFAULT NULL,
  `featured` tinyint(4) DEFAULT NULL,
  `product_list` varchar(255) DEFAULT NULL,
  `variant_list` varchar(255) DEFAULT NULL,
  `qty_list` varchar(255) DEFAULT NULL,
  `price_list` varchar(255) DEFAULT NULL,
  `product_details` text DEFAULT NULL,
  `variant_option` text DEFAULT NULL,
  `variant_value` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `shelf`, `max_product`, `shelf_id`, `name`, `code`, `type`, `barcode_symbology`, `brand_id`, `category_id`, `unit_id`, `purchase_unit_id`, `sale_unit_id`, `retail_units_per_wholesale`, `cost`, `wholesale_markup`, `wholesale_price`, `retail_markup`, `price`, `qty`, `alert_quantity`, `daily_sale_objective`, `promotion`, `promotion_price`, `starting_date`, `last_date`, `tax_id`, `tax_method`, `image`, `file`, `is_embeded`, `is_variant`, `is_batch`, `is_diffPrice`, `is_imei`, `featured`, `product_list`, `variant_list`, `qty_list`, `price_list`, `product_details`, `variant_option`, `variant_value`, `is_active`, `created_at`, `updated_at`) VALUES
(13, NULL, 50, 1, 'gebedol', '11021', 'standard', 'C128', 2, 2, 9, 9, 21, 12, 100, 10, 9.17, 20, 10, 120, 5, 10, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, 1, NULL, 1, 0, NULL, 1, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-25 17:56:52', '2025-03-25 18:32:06'),
(14, NULL, 50, NULL, 'Gastric Ulcer', '06342634', 'standard', 'C39', 3, 3, 9, 9, 7, 12, 200, 20, 20, 50, 25, 120, 150, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, 0, NULL, 1, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-25 18:21:13', '2025-03-26 09:28:56'),
(15, NULL, 50, NULL, 'Paracetamol', '79813673', 'standard', 'C128', 1, 2, 9, 9, 0, 1, 5, 0.01, 5, -0.01, 5, 56, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'zummXD2dvAtI.png', NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, 1, '2025-03-26 08:42:36', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `product_adjustments`
--

CREATE TABLE `product_adjustments` (
  `id` int(10) UNSIGNED NOT NULL,
  `adjustment_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `unit_cost` double DEFAULT NULL,
  `qty` double NOT NULL,
  `action` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_batches`
--

CREATE TABLE `product_batches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `batch_no` varchar(255) NOT NULL,
  `expired_date` date NOT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_batches`
--

INSERT INTO `product_batches` (`id`, `product_id`, `batch_no`, `expired_date`, `qty`, `created_at`, `updated_at`) VALUES
(1, 14, '25-03-2025', '2026-03-25', 108, '2025-03-25 18:32:06', '2025-03-26 09:28:56'),
(2, 13, '25-03-2025', '2027-03-25', 120, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(3, 15, '7890', '2026-10-21', 56, '2025-03-26 08:49:20', '2025-03-26 09:22:57'),
(4, 14, '8097', '2025-03-28', 12, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_purchases`
--

CREATE TABLE `product_purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `purchase_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `recieved` double NOT NULL,
  `return_qty` double NOT NULL DEFAULT 0,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_purchases`
--

INSERT INTO `product_purchases` (`id`, `purchase_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `recieved`, `return_qty`, `purchase_unit_id`, `net_unit_cost`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL, NULL, 10, 10, 0, 1, 10, 0, 10, 10, 110, '2023-05-28 06:59:29', '2023-05-28 06:59:29'),
(2, 2, 14, 1, NULL, NULL, 10, 10, 0, 9, 200, 0, 0, 0, 2000, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(3, 2, 13, 2, NULL, NULL, 10, 10, 0, 9, 100, 0, 0, 0, 1000, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(4, 3, 15, 3, NULL, NULL, 60, 60, 0, 9, 5, 0, 10, 30, 330, '2025-03-26 08:49:20', '2025-03-26 08:49:20'),
(5, 4, 14, 4, NULL, NULL, 1, 1, 0, 9, 200, 0, 0, 0, 200, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `product_quotation`
--

CREATE TABLE `product_quotation` (
  `id` int(10) UNSIGNED NOT NULL,
  `quotation_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_returns`
--

CREATE TABLE `product_returns` (
  `id` int(10) UNSIGNED NOT NULL,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_returns`
--

INSERT INTO `product_returns` (`id`, `return_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `sale_unit_id`, `net_unit_price`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 14, 1, NULL, NULL, 1, 9, 1.63, 0, 0, 0, 1.63, '2025-03-26 09:28:56', '2025-03-26 09:28:56');

-- --------------------------------------------------------

--
-- Table structure for table `product_sales`
--

CREATE TABLE `product_sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `dosage` text NOT NULL,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `return_qty` double NOT NULL DEFAULT 0,
  `sale_unit_id` int(11) NOT NULL,
  `net_unit_price` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_delivered` tinyint(1) DEFAULT NULL,
  `is_packing` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_sales`
--

INSERT INTO `product_sales` (`id`, `dosage`, `sale_id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `qty`, `return_qty`, `sale_unit_id`, `net_unit_price`, `discount`, `tax_rate`, `tax`, `total`, `created_at`, `updated_at`, `is_delivered`, `is_packing`) VALUES
(1, '', 1, 14, 1, NULL, 'null', 2, 1, 9, 1.63, 0, 0, 0, 3.26, '2025-03-25 18:42:47', '2025-03-26 09:28:56', NULL, NULL),
(2, '', 2, 14, 1, NULL, 'null', 1, 0, 9, 1.63, 0, 0, 0, 1.63, '2025-03-25 18:48:59', '2025-03-25 18:51:03', NULL, NULL),
(3, '', 3, 14, 1, NULL, 'null', 3, 0, 9, 1.63, 0, 0, 0, 4.89, '2025-03-26 02:29:39', '2025-03-26 02:29:39', NULL, NULL),
(4, '', 4, 14, 1, NULL, 'null', 80, 0, 9, 25, 0, 0, 0, 2000, '2025-03-26 08:51:58', '2025-03-26 08:51:58', NULL, NULL),
(5, '', 5, 14, 1, NULL, 'null', 10, 0, 9, 1.63, 0, 0, 0, 16.29, '2025-03-26 08:59:20', '2025-03-26 08:59:20', NULL, NULL),
(6, 'once daily', 6, 15, 3, NULL, 'null,null', 4, 0, 9, 0.33, 0, 0, 0, 1.3, '2025-03-26 09:22:57', '2025-03-26 09:22:57', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_transfer`
--

CREATE TABLE `product_transfer` (
  `id` int(10) UNSIGNED NOT NULL,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `item_code` varchar(255) NOT NULL,
  `additional_cost` double DEFAULT NULL,
  `additional_price` double DEFAULT NULL,
  `qty` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_warehouse`
--

CREATE TABLE `product_warehouse` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `qty` double NOT NULL,
  `price` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_warehouse`
--

INSERT INTO `product_warehouse` (`id`, `product_id`, `product_batch_id`, `variant_id`, `imei_number`, `warehouse_id`, `qty`, `price`, `created_at`, `updated_at`) VALUES
(1, '1', NULL, NULL, NULL, 1, 10, 20, '2023-05-28 06:59:29', '2023-05-28 07:00:57'),
(2, '14', 1, NULL, NULL, 1, 108, NULL, '2025-03-25 18:32:06', '2025-03-26 09:28:56'),
(3, '13', 2, NULL, NULL, 1, 120, NULL, '2025-03-25 18:32:06', '2025-03-25 18:32:06'),
(4, '15', 3, NULL, NULL, 1, 56, NULL, '2025-03-26 08:49:20', '2025-03-26 09:22:57'),
(5, '14', 4, NULL, NULL, 1, 12, NULL, '2025-03-26 09:16:17', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` int(11) NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `paid_amount` double NOT NULL,
  `status` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `reference_no`, `user_id`, `warehouse_id`, `supplier_id`, `currency_id`, `exchange_rate`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_cost`, `order_tax_rate`, `order_tax`, `order_discount`, `shipping_cost`, `grand_total`, `paid_amount`, `status`, `payment_status`, `document`, `note`, `created_at`, `updated_at`) VALUES
(1, 'pr-20230528-125929', 1, 1, NULL, 1, 1, 1, 10, 0, 10, 110, 0, 0, 0, 0, 110, 0, 1, 1, NULL, NULL, '2023-05-28 06:59:29', '2023-05-28 06:59:29'),
(2, '1234', 2, 1, 1, 1, 0.06517, 2, 20, 0, 0, 3000, 10, 300, 0, 0, 3300, 0, 1, 1, NULL, NULL, '2025-03-25 00:00:00', '2025-03-25 18:32:06'),
(3, '56789', 3, 1, 1, 2, 100, 1, 60, 0, 30, 330, 10, 33, 0, 0, 363, 0, 1, 1, NULL, NULL, '2025-03-29 00:00:00', '2025-03-26 08:49:20'),
(4, '8789t9037', 1, 1, 1, 2, 1, 1, 1, 0, 0, 200, 0, 0, 0, 0, 200, 0, 1, 1, NULL, NULL, '2025-03-26 00:00:00', '2025-03-26 09:16:17');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_product_return`
--

CREATE TABLE `purchase_product_return` (
  `id` int(10) UNSIGNED NOT NULL,
  `return_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_batch_id` int(11) DEFAULT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `imei_number` text DEFAULT NULL,
  `qty` double NOT NULL,
  `purchase_unit_id` int(11) NOT NULL,
  `net_unit_cost` double NOT NULL,
  `discount` double NOT NULL,
  `tax_rate` double NOT NULL,
  `tax` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quotations`
--

CREATE TABLE `quotations` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `quotation_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `refills`
--

CREATE TABLE `refills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `refill_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `updated_at` datetime NOT NULL,
  `warehouse_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refills`
--

INSERT INTO `refills` (`id`, `customer_id`, `created_at`, `refill_note`, `staff_note`, `updated_at`, `warehouse_id`) VALUES
(1, 3, '2025-03-26 01:37:34', NULL, NULL, '2025-03-26 01:37:34', 1);

-- --------------------------------------------------------

--
-- Table structure for table `refill_items`
--

CREATE TABLE `refill_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `refill_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `refill_interval` int(11) NOT NULL,
  `refill_unit` enum('days','weeks','months') NOT NULL,
  `refill_until` date NOT NULL,
  `next_refill_date` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `refill_items`
--

INSERT INTO `refill_items` (`id`, `refill_id`, `product_id`, `quantity`, `refill_interval`, `refill_unit`, `refill_until`, `next_refill_date`, `created_at`, `updated_at`) VALUES
(1, 1, 14, 1, 2, 'months', '2025-04-06', NULL, '2025-03-26 01:37:34', '2025-03-26 01:37:34');

-- --------------------------------------------------------

--
-- Table structure for table `returns`
--

CREATE TABLE `returns` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `return_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `returns`
--

INSERT INTO `returns` (`id`, `reference_no`, `user_id`, `sale_id`, `cash_register_id`, `customer_id`, `warehouse_id`, `biller_id`, `account_id`, `currency_id`, `exchange_rate`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_price`, `order_tax_rate`, `order_tax`, `grand_total`, `document`, `return_note`, `staff_note`, `created_at`, `updated_at`) VALUES
(1, 'rr-20250326-092856', 1, 1, 1, 2, 1, 1, 1, 1, 0.06517, 1, 1, 0, 0, 1.63, 0, 0, 1.63, NULL, NULL, NULL, '2025-03-26 09:28:56', '2025-03-26 09:28:56');

-- --------------------------------------------------------

--
-- Table structure for table `return_purchases`
--

CREATE TABLE `return_purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `return_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reward_point_settings`
--

CREATE TABLE `reward_point_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `per_point_amount` double NOT NULL,
  `minimum_amount` double NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `guard_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `is_active`, `created_at`, `updated_at`, `guard_name`) VALUES
(1, 'Admin', 'Pharmacy administrator', 1, '2018-06-01 23:46:44', '2025-02-18 10:13:19', 'web'),
(2, 'Super Admin', 'GogoPlus Technical Support', 1, '2018-10-22 02:38:13', '2025-02-18 10:49:13', 'web'),
(5, 'Staff', 'Pharmacy Staff', 0, '2020-11-05 06:43:16', '2025-02-18 10:50:13', 'web'),
(7, 'Pharmacist', 'Pharnacist', 1, '2025-02-18 12:00:10', '2025-02-18 12:00:10', 'web');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(4, 1),
(4, 2),
(4, 5),
(4, 7),
(5, 1),
(5, 2),
(5, 5),
(5, 7),
(6, 1),
(6, 2),
(6, 5),
(6, 7),
(7, 1),
(7, 2),
(7, 5),
(7, 7),
(8, 1),
(8, 2),
(8, 5),
(8, 7),
(9, 1),
(9, 2),
(9, 5),
(9, 7),
(10, 1),
(10, 2),
(10, 5),
(10, 7),
(11, 1),
(11, 2),
(12, 1),
(12, 2),
(12, 5),
(12, 7),
(13, 1),
(13, 2),
(13, 5),
(13, 7),
(14, 1),
(14, 2),
(14, 5),
(15, 1),
(15, 2),
(16, 1),
(16, 2),
(16, 5),
(16, 7),
(17, 1),
(17, 2),
(17, 5),
(17, 7),
(18, 1),
(18, 2),
(18, 5),
(18, 7),
(19, 1),
(19, 2),
(20, 1),
(20, 2),
(20, 5),
(20, 7),
(21, 1),
(21, 2),
(21, 5),
(21, 7),
(22, 1),
(22, 2),
(22, 5),
(22, 7),
(23, 1),
(23, 2),
(24, 1),
(24, 2),
(24, 5),
(24, 7),
(25, 1),
(25, 2),
(25, 5),
(25, 7),
(26, 1),
(26, 2),
(26, 5),
(26, 7),
(27, 1),
(27, 2),
(28, 1),
(28, 2),
(28, 5),
(28, 7),
(29, 1),
(29, 2),
(29, 5),
(29, 7),
(30, 1),
(30, 2),
(30, 5),
(30, 7),
(31, 1),
(31, 2),
(32, 1),
(32, 2),
(32, 5),
(33, 1),
(33, 2),
(33, 5),
(34, 1),
(34, 2),
(34, 5),
(35, 1),
(35, 2),
(35, 5),
(36, 1),
(36, 2),
(36, 5),
(36, 7),
(37, 1),
(37, 2),
(37, 5),
(37, 7),
(38, 1),
(38, 2),
(38, 5),
(38, 7),
(39, 1),
(39, 2),
(39, 5),
(39, 7),
(40, 1),
(40, 2),
(40, 5),
(40, 7),
(41, 1),
(41, 2),
(41, 5),
(41, 7),
(42, 1),
(42, 2),
(42, 7),
(43, 1),
(43, 2),
(43, 7),
(44, 1),
(44, 2),
(45, 1),
(45, 2),
(45, 5),
(45, 7),
(46, 1),
(46, 2),
(46, 5),
(46, 7),
(47, 1),
(47, 2),
(47, 5),
(47, 7),
(48, 1),
(48, 2),
(48, 5),
(48, 7),
(49, 1),
(49, 2),
(49, 5),
(49, 7),
(50, 1),
(50, 2),
(50, 5),
(50, 7),
(51, 1),
(51, 2),
(51, 5),
(51, 7),
(52, 1),
(52, 2),
(52, 5),
(52, 7),
(53, 1),
(53, 2),
(53, 5),
(53, 7),
(54, 1),
(54, 2),
(54, 5),
(55, 1),
(55, 2),
(55, 5),
(55, 7),
(56, 1),
(56, 2),
(56, 5),
(56, 7),
(57, 1),
(57, 2),
(57, 5),
(57, 7),
(58, 1),
(58, 2),
(59, 2),
(59, 5),
(60, 2),
(61, 2),
(62, 1),
(62, 2),
(63, 1),
(63, 2),
(63, 5),
(63, 7),
(64, 1),
(64, 2),
(64, 5),
(64, 7),
(65, 1),
(65, 2),
(65, 5),
(65, 7),
(66, 1),
(66, 2),
(67, 1),
(67, 2),
(67, 5),
(68, 1),
(68, 2),
(69, 1),
(69, 2),
(69, 5),
(70, 1),
(70, 2),
(71, 1),
(71, 2),
(72, 1),
(72, 2),
(73, 1),
(73, 2),
(73, 5),
(74, 1),
(74, 2),
(75, 1),
(75, 2),
(76, 1),
(76, 2),
(77, 1),
(77, 2),
(77, 7),
(78, 1),
(78, 2),
(78, 5),
(78, 7),
(79, 1),
(79, 2),
(79, 5),
(79, 7),
(80, 2),
(81, 1),
(81, 2),
(81, 5),
(81, 7),
(82, 1),
(82, 2),
(83, 2),
(84, 1),
(84, 2),
(84, 5),
(84, 7),
(85, 1),
(85, 2),
(85, 5),
(85, 7),
(86, 1),
(86, 2),
(86, 5),
(87, 1),
(87, 2),
(87, 5),
(87, 7),
(88, 1),
(88, 2),
(88, 5),
(88, 7),
(89, 1),
(89, 2),
(90, 1),
(90, 2),
(90, 5),
(90, 7),
(91, 1),
(91, 2),
(92, 1),
(92, 2),
(92, 5),
(92, 7),
(93, 1),
(93, 2),
(93, 5),
(94, 1),
(94, 2),
(95, 1),
(95, 2),
(96, 1),
(96, 2),
(97, 1),
(97, 2),
(98, 1),
(98, 2),
(98, 5),
(98, 7),
(99, 1),
(99, 2),
(99, 5),
(99, 7),
(100, 1),
(100, 2),
(100, 5),
(100, 7),
(101, 1),
(101, 2),
(101, 5),
(101, 7),
(102, 1),
(102, 2),
(102, 5),
(102, 7),
(103, 1),
(103, 2),
(103, 5),
(103, 7),
(104, 2),
(105, 1),
(105, 2),
(105, 7),
(106, 1),
(106, 2),
(106, 5),
(106, 7),
(107, 1),
(107, 2),
(107, 5),
(107, 7),
(108, 1),
(108, 2),
(108, 5),
(108, 7),
(109, 1),
(109, 2),
(109, 5),
(109, 7),
(110, 1),
(110, 2),
(110, 5),
(110, 7),
(111, 1),
(111, 2),
(111, 5),
(111, 7),
(112, 1),
(112, 2),
(112, 5),
(112, 7),
(113, 1),
(113, 2),
(113, 5),
(113, 7),
(114, 1),
(114, 2),
(114, 5),
(114, 7),
(115, 1),
(115, 2),
(115, 5),
(115, 7),
(116, 1),
(116, 2),
(117, 1),
(117, 2),
(117, 5),
(117, 7),
(118, 1),
(118, 2),
(118, 5),
(118, 7),
(119, 1),
(119, 2),
(119, 5),
(120, 1),
(120, 2),
(121, 1),
(121, 2),
(121, 5),
(121, 7),
(122, 1),
(122, 2),
(122, 5),
(122, 7),
(123, 1),
(123, 2),
(123, 5),
(123, 7),
(124, 1),
(124, 2),
(124, 5),
(124, 7),
(125, 1),
(125, 2),
(125, 5),
(126, 2),
(126, 7),
(127, 1),
(127, 2),
(127, 5),
(128, 1),
(128, 2),
(128, 5),
(129, 1),
(129, 2),
(129, 5),
(130, 1),
(130, 2),
(131, 2),
(132, 1),
(132, 2),
(132, 5);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `cash_register_id` int(11) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `queue` int(11) DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_discount` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_price` double NOT NULL,
  `grand_total` double NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `exchange_rate` double DEFAULT NULL,
  `order_tax_rate` double DEFAULT NULL,
  `order_tax` double DEFAULT NULL,
  `order_discount_type` varchar(255) DEFAULT NULL,
  `order_discount_value` double DEFAULT NULL,
  `order_discount` double DEFAULT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `coupon_discount` double DEFAULT NULL,
  `shipping_cost` double DEFAULT NULL,
  `sale_status` int(11) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `sale_note` text DEFAULT NULL,
  `staff_note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `reference_no`, `user_id`, `cash_register_id`, `table_id`, `queue`, `customer_id`, `warehouse_id`, `biller_id`, `item`, `total_qty`, `total_discount`, `total_tax`, `total_price`, `grand_total`, `currency_id`, `exchange_rate`, `order_tax_rate`, `order_tax`, `order_discount_type`, `order_discount_value`, `order_discount`, `coupon_id`, `coupon_discount`, `shipping_cost`, `sale_status`, `payment_status`, `document`, `paid_amount`, `sale_note`, `staff_note`, `created_at`, `updated_at`) VALUES
(1, 'posr-20250325-064247', 2, 2, NULL, NULL, 2, 1, 1, 1, 2, 0, 0, 3.26, 3.26, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 4, 4, NULL, 3.26, NULL, NULL, '2025-03-25 18:42:47', '2025-03-26 09:28:56'),
(2, '1234', 2, 2, NULL, NULL, 2, 1, 1, 1, 1, 0, 0, 1.63, 1.63, 1, 0.06517, 0, 0, 'Flat', 0, 0, NULL, NULL, 0, 1, 2, NULL, 0, NULL, NULL, '2025-03-25 18:51:03', '2025-03-25 18:51:03'),
(3, 'posr-20250326-022939', 3, 3, NULL, NULL, 1, 1, 1, 1, 3, 0, 0, 4.89, 4.89, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 3, 2, NULL, 0, NULL, NULL, '2025-03-26 02:29:39', '2025-03-26 02:29:39'),
(4, '67879', 3, 3, NULL, NULL, 3, 1, 1, 1, 80, 0, 0, 2000, 2000, 2, 100, 0, 0, 'Flat', NULL, 0, NULL, NULL, 0, 2, 1, NULL, 0, NULL, NULL, '2025-04-02 08:51:58', '2025-03-26 08:51:58'),
(5, '89089', 3, 3, NULL, NULL, 3, 1, 1, 1, 10, 0, 0, 16.29, 16.29, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, NULL, 0, 1, 3, NULL, 8, NULL, NULL, '2025-04-02 08:59:20', '2025-03-26 08:59:20'),
(6, 'posr-20250326-092257', 1, 1, NULL, NULL, 1, 1, 1, 1, 4, 0, 0, 1.3, 1.3, 1, 0.06517, 0, 0, 'Flat', NULL, 0, NULL, 0, 0, 1, 4, NULL, 1.3, NULL, NULL, '2025-03-26 09:22:57', '2025-03-26 09:22:57');

-- --------------------------------------------------------

--
-- Table structure for table `sent_sms`
--

CREATE TABLE `sent_sms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'sent',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shelves`
--

CREATE TABLE `shelves` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shelves`
--

INSERT INTO `shelves` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'general', '2025-03-25 17:59:32', '2025-03-25 17:59:32'),
(3, 'stomach', '2025-03-25 18:21:57', '2025-03-25 18:21:57');

-- --------------------------------------------------------

--
-- Table structure for table `sms_templates`
--

CREATE TABLE `sms_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_default_ecommerce` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_counts`
--

CREATE TABLE `stock_counts` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `category_id` varchar(255) DEFAULT NULL,
  `brand_id` varchar(255) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `initial_file` varchar(255) DEFAULT NULL,
  `final_file` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_adjusted` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) NOT NULL,
  `vat_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) DEFAULT NULL,
  `postal_code` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `image`, `company_name`, `vat_number`, `email`, `phone_number`, `address`, `city`, `state`, `postal_code`, `country`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'John Doe', NULL, 'Test Company', NULL, 'john@gmail.com', '231312', 'Test address', 'Test City', NULL, NULL, NULL, 1, '2023-05-28 06:53:04', '2023-05-28 06:53:04');

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `number_of_person` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `rate` double NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `taxes`
--

INSERT INTO `taxes` (`id`, `name`, `rate`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'VAT 10%', 10, 1, '2023-05-28 06:52:08', '2023-05-28 06:52:08');

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `reference_no` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `from_warehouse_id` int(11) NOT NULL,
  `to_warehouse_id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `total_qty` double NOT NULL,
  `total_tax` double NOT NULL,
  `total_cost` double NOT NULL,
  `shipping_cost` double DEFAULT NULL,
  `grand_total` double NOT NULL,
  `document` varchar(255) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `is_sent` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(10) UNSIGNED NOT NULL,
  `unit_code` varchar(255) NOT NULL,
  `unit_name` varchar(255) NOT NULL,
  `base_unit` int(11) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `operation_value` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_code`, `unit_name`, `base_unit`, `operator`, `operation_value`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'PIECE', 'PIECE', NULL, '*', 1, 1, '2023-05-28 06:51:50', '2025-02-04 17:06:26'),
(2, 'AMPOULE', 'AMPOULE', NULL, '*', 1, 1, '2025-02-04 17:07:04', '2025-02-04 17:07:04'),
(3, 'SACHET', 'SACHET', NULL, '*', 1, 1, '2025-02-04 17:07:20', '2025-02-04 17:07:20'),
(4, 'TAB', 'TAB', NULL, '*', 1, 1, '2025-02-04 17:07:31', '2025-02-04 17:07:31'),
(5, 'TUBE', 'TUBE', NULL, '*', 1, 1, '2025-02-04 17:07:42', '2025-02-04 17:07:42'),
(6, 'VIAL', 'VIAL', NULL, '*', 1, 1, '2025-02-04 17:07:56', '2025-02-04 17:07:56'),
(7, 'BOTTLE', 'BOTTLE', NULL, '*', 1, 1, '2025-02-04 17:08:09', '2025-02-04 17:08:09'),
(8, 'CAP', 'CAP', NULL, '*', 1, 1, '2025-02-04 17:08:24', '2025-02-04 17:08:24'),
(9, 'BOX', 'BOX', NULL, '*', 1, 1, '2025-02-04 17:08:35', '2025-02-04 17:08:35'),
(10, 'JAR', 'JAR', NULL, '*', 1, 1, '2025-02-04 17:08:46', '2025-02-04 17:08:46'),
(11, 'DROP', 'DROP', NULL, '*', 1, 1, '2025-02-04 17:08:57', '2025-02-04 17:08:57'),
(12, 'SINGLE', 'SINGLE', NULL, '*', 1, 1, '2025-02-04 17:09:10', '2025-02-04 17:09:10'),
(13, 'CAN', 'CAN', NULL, '*', 1, 1, '2025-02-04 17:09:21', '2025-02-04 17:09:21'),
(14, 'SUPP', 'SUPP', NULL, '*', 1, 1, '2025-02-04 17:09:35', '2025-02-04 17:09:35'),
(15, 'STRIP', 'STRIP', NULL, '*', 1, 1, '2025-02-04 17:09:52', '2025-02-04 17:09:52'),
(16, 'PESS', 'PESS', NULL, '*', 1, 1, '2025-02-04 17:10:04', '2025-02-04 17:10:04'),
(17, 'LOZENGES', 'LOZENGES', NULL, '*', 1, 1, '2025-02-04 17:10:24', '2025-02-04 17:10:24'),
(18, 'POUCH', 'POUCH', NULL, '*', 1, 1, '2025-02-04 17:10:39', '2025-02-04 17:10:39'),
(19, 'BAG', 'BAG', NULL, '*', 1, 1, '2025-02-04 17:10:49', '2025-02-04 17:10:49'),
(20, 'No Unit', 'No Unit', NULL, '*', 1, 1, '2025-02-04 17:11:30', '2025-02-04 17:11:30'),
(21, 'PACK', 'PACK', NULL, '*', 1, 1, '2025-02-04 17:15:31', '2025-02-04 17:15:31');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`, `phone`, `company_name`, `role_id`, `biller_id`, `warehouse_id`, `is_active`, `is_deleted`) VALUES
(1, 'intern', 'giftybuah@gmail.com', '$2y$10$gtlKmhPKO0iLrXVyhcTaQ.DlEgDX66LqhS0slYrNBpsqIOV6ZwATC', 'pEN60GwtkCZFKVT6tvmmCiYvHqvDX4znpKTdgDca9wxdfVmtbxRixIxH0RzJ', '2018-06-02 03:24:15', '2025-03-24 23:20:25', '0247118423', 'Intern Pharmacy', 2, NULL, NULL, 1, 0),
(2, 'iddrisu', 'iddrisu442g@gmail.com', '$2y$10$WwNSDcjyJzDoEFFC1s2MTuGx5UrmgBhj7iwNceFJqOTA6IgAB7QUe', NULL, '2025-03-24 20:36:04', '2025-03-24 23:15:12', '0550936771', 'Intern Pharmacy', 1, NULL, NULL, 1, 0),
(3, 'obed', 'ninsonobed5630@gmail.com', '$2y$10$vPfQAb2/onfHCkKOJzzbtOU1TtzRKEjldvuEzdgZPsGQZEPavXfGC', NULL, '2025-03-24 20:39:36', '2025-03-24 23:16:16', '0256422216', 'Intern Pharmacy', 1, NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `variants`
--

CREATE TABLE `variants` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `name`, `phone`, `email`, `address`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Test Shop', '9991111', NULL, 'Test address', 1, '2023-05-28 06:51:19', '2023-05-28 06:51:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `action_logs`
--
ALTER TABLE `action_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `action_id` (`action_id`);

--
-- Indexes for table `adjustments`
--
ALTER TABLE `adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `barcodes`
--
ALTER TABLE `barcodes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `billers`
--
ALTER TABLE `billers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cash_registers`
--
ALTER TABLE `cash_registers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `challans`
--
ALTER TABLE `challans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `couriers`
--
ALTER TABLE `couriers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_groups`
--
ALTER TABLE `customer_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_fields`
--
ALTER TABLE `custom_fields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plans`
--
ALTER TABLE `discount_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plan_customers`
--
ALTER TABLE `discount_plan_customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_plan_discounts`
--
ALTER TABLE `discount_plan_discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dso_alerts`
--
ALTER TABLE `dso_alerts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `expense_categories`
--
ALTER TABLE `expense_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `external_services`
--
ALTER TABLE `external_services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gift_cards`
--
ALTER TABLE `gift_cards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gift_card_recharges`
--
ALTER TABLE `gift_card_recharges`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hrm_settings`
--
ALTER TABLE `hrm_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `incomes`
--
ALTER TABLE `incomes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `income_categories`
--
ALTER TABLE `income_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `insurance_provider`
--
ALTER TABLE `insurance_provider`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mail_settings`
--
ALTER TABLE `mail_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `money_transfers`
--
ALTER TABLE `money_transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `packing_slips`
--
ALTER TABLE `packing_slips`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `packing_slip_products`
--
ALTER TABLE `packing_slip_products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_cheque`
--
ALTER TABLE `payment_with_cheque`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_credit_card`
--
ALTER TABLE `payment_with_credit_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_gift_card`
--
ALTER TABLE `payment_with_gift_card`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_insurance`
--
ALTER TABLE `payment_with_insurance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_mobile_money`
--
ALTER TABLE `payment_with_mobile_money`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_with_paypal`
--
ALTER TABLE `payment_with_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payrolls`
--
ALTER TABLE `payrolls`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pos_setting`
--
ALTER TABLE `pos_setting`
  ADD UNIQUE KEY `pos_setting_id_unique` (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_batches`
--
ALTER TABLE `product_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_purchases`
--
ALTER TABLE `product_purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_quotation`
--
ALTER TABLE `product_quotation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_returns`
--
ALTER TABLE `product_returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_sales`
--
ALTER TABLE `product_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_transfer`
--
ALTER TABLE `product_transfer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_product_return`
--
ALTER TABLE `purchase_product_return`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quotations`
--
ALTER TABLE `quotations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refills`
--
ALTER TABLE `refills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `refill_items`
--
ALTER TABLE `refill_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `refill_items_next_refill_date_index` (`next_refill_date`);

--
-- Indexes for table `returns`
--
ALTER TABLE `returns`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `return_purchases`
--
ALTER TABLE `return_purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reward_point_settings`
--
ALTER TABLE `reward_point_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sent_sms`
--
ALTER TABLE `sent_sms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sent_sms_customer_id_index` (`customer_id`),
  ADD KEY `sent_sms_phone_number_index` (`phone_number`);

--
-- Indexes for table `shelves`
--
ALTER TABLE `shelves`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shelves_name_index` (`name`);

--
-- Indexes for table `sms_templates`
--
ALTER TABLE `sms_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_counts`
--
ALTER TABLE `stock_counts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `variants`
--
ALTER TABLE `variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `action_logs`
--
ALTER TABLE `action_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `adjustments`
--
ALTER TABLE `adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `barcodes`
--
ALTER TABLE `barcodes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `billers`
--
ALTER TABLE `billers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cash_registers`
--
ALTER TABLE `cash_registers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `challans`
--
ALTER TABLE `challans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `couriers`
--
ALTER TABLE `couriers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customer_groups`
--
ALTER TABLE `customer_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `custom_fields`
--
ALTER TABLE `custom_fields`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plans`
--
ALTER TABLE `discount_plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plan_customers`
--
ALTER TABLE `discount_plan_customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discount_plan_discounts`
--
ALTER TABLE `discount_plan_discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dso_alerts`
--
ALTER TABLE `dso_alerts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expense_categories`
--
ALTER TABLE `expense_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `external_services`
--
ALTER TABLE `external_services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `gift_cards`
--
ALTER TABLE `gift_cards`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gift_card_recharges`
--
ALTER TABLE `gift_card_recharges`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hrm_settings`
--
ALTER TABLE `hrm_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `incomes`
--
ALTER TABLE `incomes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `income_categories`
--
ALTER TABLE `income_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `insurance_provider`
--
ALTER TABLE `insurance_provider`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mail_settings`
--
ALTER TABLE `mail_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=211;

--
-- AUTO_INCREMENT for table `money_transfers`
--
ALTER TABLE `money_transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packing_slips`
--
ALTER TABLE `packing_slips`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `packing_slip_products`
--
ALTER TABLE `packing_slip_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_with_cheque`
--
ALTER TABLE `payment_with_cheque`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_credit_card`
--
ALTER TABLE `payment_with_credit_card`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_gift_card`
--
ALTER TABLE `payment_with_gift_card`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_insurance`
--
ALTER TABLE `payment_with_insurance`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payment_with_mobile_money`
--
ALTER TABLE `payment_with_mobile_money`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payment_with_paypal`
--
ALTER TABLE `payment_with_paypal`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payrolls`
--
ALTER TABLE `payrolls`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `product_adjustments`
--
ALTER TABLE `product_adjustments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_batches`
--
ALTER TABLE `product_batches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_purchases`
--
ALTER TABLE `product_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_quotation`
--
ALTER TABLE `product_quotation`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_returns`
--
ALTER TABLE `product_returns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_sales`
--
ALTER TABLE `product_sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product_transfer`
--
ALTER TABLE `product_transfer`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_warehouse`
--
ALTER TABLE `product_warehouse`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `purchase_product_return`
--
ALTER TABLE `purchase_product_return`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `quotations`
--
ALTER TABLE `quotations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `refills`
--
ALTER TABLE `refills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `refill_items`
--
ALTER TABLE `refill_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `returns`
--
ALTER TABLE `returns`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `return_purchases`
--
ALTER TABLE `return_purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reward_point_settings`
--
ALTER TABLE `reward_point_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sent_sms`
--
ALTER TABLE `sent_sms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shelves`
--
ALTER TABLE `shelves`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sms_templates`
--
ALTER TABLE `sms_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_counts`
--
ALTER TABLE `stock_counts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `variants`
--
ALTER TABLE `variants`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;
--
-- Database: `pharmacy_main`
--
CREATE DATABASE IF NOT EXISTS `pharmacy_main` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `pharmacy_main`;

-- --------------------------------------------------------

--
-- Table structure for table `audit_log`
--

CREATE TABLE `audit_log` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `token_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `used` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `position` varchar(50) NOT NULL,
  `license_number` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `user_id`, `first_name`, `last_name`, `position`, `license_number`, `phone`, `address`) VALUES
(1, 1, 'System', 'Administrator', 'Chief Pharmacist', 'ADMIN-001', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `is_admin` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL,
  `force_password_change` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password_hash`, `email`, `is_admin`, `is_active`, `created_at`, `last_login`, `force_password_change`) VALUES
(1, 'pharmacy_admin', '$2y$10$N9qo8uLOickgx2ZMRZoMy.MrE7Y4YpHHj.Y./f.n7J4J1sJQZ7qK2', 'admin@pharmacy.com', 1, 1, '2025-04-08 07:15:30', NULL, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`token_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `token_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD CONSTRAINT `audit_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD CONSTRAINT `password_reset_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{\"db\":\"pharmacy_analytics\",\"table\":\"expiring_drugs\"},{\"db\":\"intern\",\"table\":\"permissions\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2025-04-01 17:14:34', '{\"Console\\/Mode\":\"collapse\"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
