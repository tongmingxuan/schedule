/*
 Navicat Premium Data Transfer

 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Schema         : schedule

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)

 Date: 13/03/2025 17:27:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_apis
-- ----------------------------
DROP TABLE IF EXISTS `admin_apis`;
CREATE TABLE `admin_apis`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接口名称',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接口路径',
  `template` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接口模板',
  `enabled` tinyint NOT NULL DEFAULT 1 COMMENT '是否启用',
  `args` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '接口参数',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_apis
-- ----------------------------

-- ----------------------------
-- Table structure for admin_code_generators
-- ----------------------------
DROP TABLE IF EXISTS `admin_code_generators`;
CREATE TABLE `admin_code_generators`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名称',
  `table_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表名',
  `primary_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'id' COMMENT '主键名',
  `model_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '模型名',
  `controller_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '控制器名',
  `service_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '服务名',
  `columns` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '字段信息',
  `need_timestamps` tinyint NOT NULL DEFAULT 0 COMMENT '是否需要时间戳',
  `soft_delete` tinyint NOT NULL DEFAULT 0 COMMENT '是否需要软删除',
  `needs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '需要生成的代码',
  `menu_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '菜单信息',
  `page_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '页面信息',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_code_generators
-- ----------------------------
INSERT INTO `admin_code_generators` VALUES (1, '路由列表', 'route', 'id', 'App/Models/Route', 'App/Admin/Controllers/RouteController', 'App/Services/RouteService', '[{\"name\":\"main_id\",\"type_name\":\"int\",\"type\":\"integer\",\"collation\":null,\"nullable\":false,\"default\":null,\"auto_increment\":false,\"comment\":\"\\u4e3b\\u8def\\u7531ID\",\"generation\":null},{\"name\":\"name\",\"type_name\":\"varchar\",\"type\":\"string\",\"collation\":\"utf8mb4_general_ci\",\"nullable\":true,\"default\":null,\"auto_increment\":false,\"comment\":\"\\u8def\\u7531\\u540d\\u79f0\",\"generation\":null},{\"name\":\"config\",\"type_name\":\"json\",\"type\":\"json\",\"collation\":null,\"nullable\":true,\"default\":null,\"auto_increment\":false,\"comment\":\"\\u914d\\u7f6e\\u53c2\\u6570\",\"generation\":null},{\"name\":\"push_url\",\"type_name\":\"varchar\",\"type\":\"string\",\"collation\":\"utf8mb4_general_ci\",\"nullable\":false,\"default\":null,\"auto_increment\":false,\"comment\":\"push\\u5730\\u5740\",\"generation\":null},{\"name\":\"parent_id\",\"type_name\":\"int\",\"type\":\"integer\",\"collation\":null,\"nullable\":true,\"default\":null,\"auto_increment\":false,\"comment\":\"\\u4e0a\\u7ea7ID\",\"generation\":null},{\"name\":\"concurrency\",\"type_name\":\"tinyint\",\"type\":\"tinyInteger\",\"collation\":null,\"nullable\":true,\"default\":\"1\",\"auto_increment\":false,\"comment\":\"\\u5e76\\u53d1\\u6570\\u91cf\",\"generation\":null},{\"name\":\"delay\",\"type_name\":\"int\",\"type\":\"integer\",\"collation\":null,\"nullable\":true,\"default\":\"0\",\"auto_increment\":false,\"comment\":\"\\u5ef6\\u8fdf\\u591a\\u5c11\\u79d2\\u8fd0\\u884c\",\"generation\":null},{\"name\":\"sleep\",\"type_name\":\"int\",\"type\":\"integer\",\"collation\":null,\"nullable\":true,\"default\":\"10\",\"auto_increment\":false,\"comment\":\"\\u8fd0\\u884c\\u4e00\\u8f6e\\u4f11\\u606f\\u65f6\\u95f4\",\"generation\":null},{\"name\":\"limit\",\"type_name\":\"int\",\"type\":\"integer\",\"collation\":null,\"nullable\":true,\"default\":\"10\",\"auto_increment\":false,\"comment\":\"\\u4e00\\u8f6e\\u83b7\\u53d6\\u591a\\u5c11\\u6570\\u636e\",\"generation\":null}]', 1, 1, '[\"need_database_migration\",\"need_create_table\",\"need_model\",\"need_controller\",\"need_service\"]', '{\"enabled\":1,\"parent_id\":0,\"icon\":\"ph:circle\",\"title\":\"\\u8def\\u7531\\u5217\\u8868\",\"route\":\"\\/route\"}', '{\"dialog_form\":\"dialog\",\"row_actions\":[\"create\",\"show\",\"edit\",\"delete\",\"batch_delete\"],\"dialog_size\":\"md\",\"list_display_created_at\":1,\"list_display_updated_at\":1}', '2025-03-10 08:12:24', '2025-03-10 08:12:24');
INSERT INTO `admin_code_generators` VALUES (2, '消息列表', 'task', 'id', 'App/Models/Task', 'App/Admin/Controllers/TaskController', 'App/Services/TaskService', '[{\"name\":\"parent_id\",\"type_name\":\"int\",\"type\":\"integer\",\"collation\":null,\"nullable\":true,\"default\":\"0\",\"auto_increment\":false,\"comment\":\"\\u4e0a\\u7ea7\\u4efb\\u52a1ID\",\"generation\":null},{\"name\":\"main_trace_id\",\"type_name\":\"char\",\"type\":\"string\",\"collation\":\"utf8mb4_general_ci\",\"nullable\":true,\"default\":null,\"auto_increment\":false,\"comment\":\"\\u4e3b-\\u8ddf\\u8e2aID\",\"generation\":null},{\"name\":\"trace_id\",\"type_name\":\"char\",\"type\":\"string\",\"collation\":\"utf8mb4_general_ci\",\"nullable\":false,\"default\":null,\"auto_increment\":false,\"comment\":\"\\u8ddf\\u8e2aID\",\"generation\":null},{\"name\":\"route_id\",\"type_name\":\"int\",\"type\":\"integer\",\"collation\":null,\"nullable\":false,\"default\":null,\"auto_increment\":false,\"comment\":\"\\u8def\\u7531ID\",\"generation\":null},{\"name\":\"push_url\",\"type_name\":\"varchar\",\"type\":\"string\",\"collation\":\"utf8mb4_general_ci\",\"nullable\":false,\"default\":null,\"auto_increment\":false,\"comment\":\"\\u63a8\\u9001\\u5730\\u5740\",\"generation\":null},{\"name\":\"request_param\",\"type_name\":\"text\",\"type\":\"text\",\"collation\":\"utf8mb4_general_ci\",\"nullable\":true,\"default\":null,\"auto_increment\":false,\"comment\":\"\\u8c03\\u7528Finish-api\\u4f20\\u9012\\u53c2\\u6570\",\"generation\":null},{\"name\":\"result\",\"type_name\":\"text\",\"type\":\"text\",\"collation\":\"utf8mb4_general_ci\",\"nullable\":true,\"default\":null,\"auto_increment\":false,\"comment\":\"\\u8fd0\\u884c\\u7ed3\\u679c\",\"generation\":null},{\"name\":\"status\",\"type_name\":\"tinyint\",\"type\":\"tinyInteger\",\"collation\":null,\"nullable\":true,\"default\":\"0\",\"auto_increment\":false,\"comment\":\"\\u8fd0\\u884c\\u72b6\\u6001  0\\u5f85\\u8c03\\u5ea6 1\\u5df2\\u6295\\u9012 2\\u5df2\\u63a5\\u6536finish 3\\u5b50\\u4efb\\u52a1\\u751f\\u6210\\u6210\\u529f  4\\u8fd0\\u884c\\u6210\\u529f  5\\u8fd0\\u884c\\u5f02\\u5e38  6\\u4f5c\\u5e9f\",\"generation\":null},{\"name\":\"count\",\"type_name\":\"tinyint\",\"type\":\"tinyInteger\",\"collation\":null,\"nullable\":true,\"default\":\"0\",\"auto_increment\":false,\"comment\":\"\\u8fd0\\u884c\\u6b21\\u6570\",\"generation\":null},{\"name\":\"delay\",\"type_name\":\"int\",\"type\":\"integer\",\"collation\":null,\"nullable\":true,\"default\":\"0\",\"auto_increment\":false,\"comment\":\"\\u5ef6\\u65f6\\u8fd0\\u884c\",\"generation\":null}]', 1, 1, '[\"need_database_migration\",\"need_create_table\",\"need_model\",\"need_controller\",\"need_service\"]', '{\"enabled\":1,\"parent_id\":0,\"icon\":\"ph:circle\",\"title\":\"\\u6d88\\u606f\\u5217\\u8868\",\"route\":\"\\/task\"}', '{\"dialog_form\":\"dialog\",\"row_actions\":[\"create\",\"show\",\"edit\",\"delete\",\"batch_delete\"],\"dialog_size\":\"md\",\"list_display_created_at\":1,\"list_display_updated_at\":1}', '2025-03-10 08:46:35', '2025-03-10 08:46:35');

-- ----------------------------
-- Table structure for admin_extensions
-- ----------------------------
DROP TABLE IF EXISTS `admin_extensions`;
CREATE TABLE `admin_extensions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_enabled` tinyint NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_extensions_name_unique`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_extensions
-- ----------------------------

-- ----------------------------
-- Table structure for admin_menus
-- ----------------------------
DROP TABLE IF EXISTS `admin_menus`;
CREATE TABLE `admin_menus`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL DEFAULT 0,
  `custom_order` int NOT NULL DEFAULT 0,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单名称',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单路由',
  `url_type` tinyint NOT NULL DEFAULT 1 COMMENT '路由类型(1:路由,2:外链,3:iframe)',
  `visible` tinyint NOT NULL DEFAULT 1 COMMENT '是否可见',
  `is_home` tinyint NOT NULL DEFAULT 0 COMMENT '是否为首页',
  `keep_alive` tinyint NULL DEFAULT NULL COMMENT '页面缓存',
  `iframe_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'iframe_url',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单组件',
  `is_full` tinyint NOT NULL DEFAULT 0 COMMENT '是否是完整页面',
  `extension` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '扩展',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_menus
-- ----------------------------
INSERT INTO `admin_menus` VALUES (1, 0, 0, 'dashboard', 'mdi:chart-line', '/dashboard', 1, 1, 1, NULL, NULL, NULL, 0, NULL, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_menus` VALUES (2, 0, 0, 'admin_system', 'material-symbols:settings-outline', '/system', 1, 1, 0, NULL, NULL, NULL, 0, NULL, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_menus` VALUES (3, 2, 0, 'admin_users', 'ph:user-gear', '/system/admin_users', 1, 1, 0, NULL, NULL, NULL, 0, NULL, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_menus` VALUES (4, 2, 0, 'admin_roles', 'carbon:user-role', '/system/admin_roles', 1, 1, 0, NULL, NULL, NULL, 0, NULL, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_menus` VALUES (5, 2, 0, 'admin_permission', 'fluent-mdl2:permissions', '/system/admin_permissions', 1, 1, 0, NULL, NULL, NULL, 0, NULL, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_menus` VALUES (6, 2, 0, 'admin_menu', 'ant-design:menu-unfold-outlined', '/system/admin_menus', 1, 1, 0, NULL, NULL, NULL, 0, NULL, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_menus` VALUES (7, 2, 0, 'admin_setting', 'akar-icons:settings-horizontal', '/system/settings', 1, 1, 0, NULL, NULL, NULL, 0, NULL, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_menus` VALUES (8, 0, 100, '路由列表', 'ph:circle', '/route', 1, 1, 0, NULL, NULL, NULL, 0, NULL, '2025-03-10 08:12:44', '2025-03-10 08:12:44');
INSERT INTO `admin_menus` VALUES (9, 0, 100, '消息列表', 'ph:circle', '/task', 1, 1, 0, NULL, NULL, NULL, 0, NULL, '2025-03-10 08:48:06', '2025-03-10 08:48:06');

-- ----------------------------
-- Table structure for admin_pages
-- ----------------------------
DROP TABLE IF EXISTS `admin_pages`;
CREATE TABLE `admin_pages`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '页面名称',
  `sign` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '页面标识',
  `schema` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '页面结构',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_pages
-- ----------------------------

-- ----------------------------
-- Table structure for admin_permission_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_permission_menu`;
CREATE TABLE `admin_permission_menu`  (
  `permission_id` int NOT NULL,
  `menu_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  INDEX `admin_permission_menu_permission_id_menu_id_index`(`permission_id` ASC, `menu_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_permission_menu
-- ----------------------------
INSERT INTO `admin_permission_menu` VALUES (1, 1, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permission_menu` VALUES (2, 2, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permission_menu` VALUES (3, 3, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permission_menu` VALUES (2, 3, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permission_menu` VALUES (4, 4, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permission_menu` VALUES (2, 4, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permission_menu` VALUES (5, 5, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permission_menu` VALUES (2, 5, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permission_menu` VALUES (6, 6, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permission_menu` VALUES (2, 6, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permission_menu` VALUES (7, 7, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permission_menu` VALUES (2, 7, '2025-03-10 07:31:19', '2025-03-10 07:31:19');

-- ----------------------------
-- Table structure for admin_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_permissions`;
CREATE TABLE `admin_permissions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `http_method` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `http_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `custom_order` int NOT NULL DEFAULT 0,
  `parent_id` int NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_permissions_name_unique`(`name` ASC) USING BTREE,
  UNIQUE INDEX `admin_permissions_slug_unique`(`slug` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_permissions
-- ----------------------------
INSERT INTO `admin_permissions` VALUES (1, '首页', 'home', NULL, '[\'/home*\']', 0, 0, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permissions` VALUES (2, '系统', 'system', NULL, '', 0, 0, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permissions` VALUES (3, '管理员', 'admin_users', NULL, '[\'/admin_users*\']', 0, 2, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permissions` VALUES (4, '角色', 'roles', NULL, '[\'/roles*\']', 0, 2, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permissions` VALUES (5, '权限', 'permissions', NULL, '[\'/permissions*\']', 0, 2, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permissions` VALUES (6, '菜单', 'menus', NULL, '[\'/menus*\']', 0, 2, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_permissions` VALUES (7, '设置', 'settings', NULL, '[\'/settings*\']', 0, 2, '2025-03-10 07:31:19', '2025-03-10 07:31:19');

-- ----------------------------
-- Table structure for admin_relationships
-- ----------------------------
DROP TABLE IF EXISTS `admin_relationships`;
CREATE TABLE `admin_relationships`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `model` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '模型',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关联名称',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关联类型',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '关联名称',
  `args` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '关联参数',
  `extra` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '额外参数',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_relationships
-- ----------------------------

-- ----------------------------
-- Table structure for admin_role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_permissions`;
CREATE TABLE `admin_role_permissions`  (
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  INDEX `admin_role_permissions_role_id_permission_id_index`(`role_id` ASC, `permission_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_role_permissions
-- ----------------------------
INSERT INTO `admin_role_permissions` VALUES (1, 1, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_role_permissions` VALUES (1, 2, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_role_permissions` VALUES (1, 3, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_role_permissions` VALUES (1, 4, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_role_permissions` VALUES (1, 5, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_role_permissions` VALUES (1, 6, '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_role_permissions` VALUES (1, 7, '2025-03-10 07:31:19', '2025-03-10 07:31:19');

-- ----------------------------
-- Table structure for admin_role_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_users`;
CREATE TABLE `admin_role_users`  (
  `role_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  INDEX `admin_role_users_role_id_user_id_index`(`role_id` ASC, `user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_role_users
-- ----------------------------
INSERT INTO `admin_role_users` VALUES (1, 1, '2025-03-10 07:31:19', '2025-03-10 07:31:19');

-- ----------------------------
-- Table structure for admin_roles
-- ----------------------------
DROP TABLE IF EXISTS `admin_roles`;
CREATE TABLE `admin_roles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_roles_name_unique`(`name` ASC) USING BTREE,
  UNIQUE INDEX `admin_roles_slug_unique`(`slug` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_roles
-- ----------------------------
INSERT INTO `admin_roles` VALUES (1, 'Administrator', 'administrator', '2025-03-10 07:31:19', '2025-03-10 07:31:19');

-- ----------------------------
-- Table structure for admin_settings
-- ----------------------------
DROP TABLE IF EXISTS `admin_settings`;
CREATE TABLE `admin_settings`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_settings
-- ----------------------------
INSERT INTO `admin_settings` VALUES ('admin_locale', '\"zh_CN\"', '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_settings` VALUES ('admin_common_field', '{\"标题/名称\":{\"name\":\"title\",\"type\":\"string\",\"default\":null,\"nullable\":false,\"comment\":\"标题\",\"action_scope\":[\"list\",\"detail\",\"create\",\"edit\"],\"file_column\":0,\"list_component\":{\"list_component_property\":[{\"name\":\"searchable\",\"value\":\"1\"}],\"list_component_type\":\"TableColumn\",\"component_property_options\":[{\"label\":\"align\",\"value\":\"align\"},{\"label\":\"breakpoint\",\"value\":\"breakpoint\"},{\"label\":\"canAccessSuperData\",\"value\":\"canAccessSuperData\"},{\"label\":\"className\",\"value\":\"className\"},{\"label\":\"classNameExpr\",\"value\":\"classNameExpr\"},{\"label\":\"copyable\",\"value\":\"copyable\"},{\"label\":\"filterable\",\"value\":\"filterable\"},{\"label\":\"fixed\",\"value\":\"fixed\"},{\"label\":\"headerAlign\",\"value\":\"headerAlign\"},{\"label\":\"innerStyle\",\"value\":\"innerStyle\"},{\"label\":\"labelClassName\",\"value\":\"labelClassName\"},{\"label\":\"lazyRenderAfter\",\"value\":\"lazyRenderAfter\"},{\"label\":\"popOver\",\"value\":\"popOver\"},{\"label\":\"quickEdit\",\"value\":\"quickEdit\"},{\"label\":\"quickEditOnUpdate\",\"value\":\"quickEditOnUpdate\"},{\"label\":\"remark\",\"value\":\"remark\"},{\"label\":\"searchable\",\"value\":\"searchable\"},{\"label\":\"sortable\",\"value\":\"sortable\"},{\"label\":\"toggled\",\"value\":\"toggled\"},{\"label\":\"type\",\"value\":\"type\"},{\"label\":\"unique\",\"value\":\"unique\"},{\"label\":\"vAlign\",\"value\":\"vAlign\"},{\"label\":\"value\",\"value\":\"value\"},{\"label\":\"width\",\"value\":\"width\"},{\"label\":\"make\",\"value\":\"make\"},{\"label\":\"permission\",\"value\":\"permission\"},{\"label\":\"filteredResults\",\"value\":\"filteredResults\"},{\"label\":\"macro\",\"value\":\"macro\"},{\"label\":\"mixin\",\"value\":\"mixin\"},{\"label\":\"hasMacro\",\"value\":\"hasMacro\"},{\"label\":\"flushMacros\",\"value\":\"flushMacros\"},{\"label\":\"__callStatic\",\"value\":\"__callStatic\"},{\"label\":\"macroCall\",\"value\":\"macroCall\"}]},\"form_component\":{\"form_component_type\":\"TextControl\",\"component_property_options\":[{\"label\":\"addApi\",\"value\":\"addApi\"},{\"label\":\"addControls\",\"value\":\"addControls\"},{\"label\":\"addDialog\",\"value\":\"addDialog\"},{\"label\":\"addOn\",\"value\":\"addOn\"},{\"label\":\"autoComplete\",\"value\":\"autoComplete\"},{\"label\":\"autoFill\",\"value\":\"autoFill\"},{\"label\":\"borderMode\",\"value\":\"borderMode\"},{\"label\":\"className\",\"value\":\"className\"},{\"label\":\"clearValueOnEmpty\",\"value\":\"clearValueOnEmpty\"},{\"label\":\"clearValueOnHidden\",\"value\":\"clearValueOnHidden\"},{\"label\":\"clearable\",\"value\":\"clearable\"},{\"label\":\"creatable\",\"value\":\"creatable\"},{\"label\":\"createBtnLabel\",\"value\":\"createBtnLabel\"},{\"label\":\"deferApi\",\"value\":\"deferApi\"},{\"label\":\"deferField\",\"value\":\"deferField\"},{\"label\":\"deleteApi\",\"value\":\"deleteApi\"},{\"label\":\"deleteConfirmText\",\"value\":\"deleteConfirmText\"},{\"label\":\"delimiter\",\"value\":\"delimiter\"},{\"label\":\"desc\",\"value\":\"desc\"},{\"label\":\"description\",\"value\":\"description\"},{\"label\":\"descriptionClassName\",\"value\":\"descriptionClassName\"},{\"label\":\"disabled\",\"value\":\"disabled\"},{\"label\":\"disabledOn\",\"value\":\"disabledOn\"},{\"label\":\"editApi\",\"value\":\"editApi\"},{\"label\":\"editControls\",\"value\":\"editControls\"},{\"label\":\"editDialog\",\"value\":\"editDialog\"},{\"label\":\"editable\",\"value\":\"editable\"},{\"label\":\"editorSetting\",\"value\":\"editorSetting\"},{\"label\":\"extraName\",\"value\":\"extraName\"},{\"label\":\"extractValue\",\"value\":\"extractValue\"},{\"label\":\"hidden\",\"value\":\"hidden\"},{\"label\":\"hiddenOn\",\"value\":\"hiddenOn\"},{\"label\":\"hint\",\"value\":\"hint\"},{\"label\":\"horizontal\",\"value\":\"horizontal\"},{\"label\":\"id\",\"value\":\"id\"},{\"label\":\"initAutoFill\",\"value\":\"initAutoFill\"},{\"label\":\"initFetch\",\"value\":\"initFetch\"},{\"label\":\"initFetchOn\",\"value\":\"initFetchOn\"},{\"label\":\"inline\",\"value\":\"inline\"},{\"label\":\"inputClassName\",\"value\":\"inputClassName\"},{\"label\":\"inputControlClassName\",\"value\":\"inputControlClassName\"},{\"label\":\"joinValues\",\"value\":\"joinValues\"},{\"label\":\"labelAlign\",\"value\":\"labelAlign\"},{\"label\":\"labelClassName\",\"value\":\"labelClassName\"},{\"label\":\"labelRemark\",\"value\":\"labelRemark\"},{\"label\":\"labelWidth\",\"value\":\"labelWidth\"},{\"label\":\"maxLength\",\"value\":\"maxLength\"},{\"label\":\"minLength\",\"value\":\"minLength\"},{\"label\":\"mode\",\"value\":\"mode\"},{\"label\":\"multiple\",\"value\":\"multiple\"},{\"label\":\"nativeAutoComplete\",\"value\":\"nativeAutoComplete\"},{\"label\":\"nativeInputClassName\",\"value\":\"nativeInputClassName\"},{\"label\":\"onEvent\",\"value\":\"onEvent\"},{\"label\":\"options\",\"value\":\"options\"},{\"label\":\"placeholder\",\"value\":\"placeholder\"},{\"label\":\"prefix\",\"value\":\"prefix\"},{\"label\":\"readOnly\",\"value\":\"readOnly\"},{\"label\":\"readOnlyOn\",\"value\":\"readOnlyOn\"},{\"label\":\"remark\",\"value\":\"remark\"},{\"label\":\"removable\",\"value\":\"removable\"},{\"label\":\"required\",\"value\":\"required\"},{\"label\":\"resetValue\",\"value\":\"resetValue\"},{\"label\":\"row\",\"value\":\"row\"},{\"label\":\"saveImmediately\",\"value\":\"saveImmediately\"},{\"label\":\"selectFirst\",\"value\":\"selectFirst\"},{\"label\":\"showCounter\",\"value\":\"showCounter\"},{\"label\":\"size\",\"value\":\"size\"},{\"label\":\"source\",\"value\":\"source\"},{\"label\":\"static\",\"value\":\"static\"},{\"label\":\"staticClassName\",\"value\":\"staticClassName\"},{\"label\":\"staticInputClassName\",\"value\":\"staticInputClassName\"},{\"label\":\"staticLabelClassName\",\"value\":\"staticLabelClassName\"},{\"label\":\"staticOn\",\"value\":\"staticOn\"},{\"label\":\"staticPlaceholder\",\"value\":\"staticPlaceholder\"},{\"label\":\"staticSchema\",\"value\":\"staticSchema\"},{\"label\":\"style\",\"value\":\"style\"},{\"label\":\"submitOnChange\",\"value\":\"submitOnChange\"},{\"label\":\"suffix\",\"value\":\"suffix\"},{\"label\":\"testIdBuilder\",\"value\":\"testIdBuilder\"},{\"label\":\"transform\",\"value\":\"transform\"},{\"label\":\"trimContents\",\"value\":\"trimContents\"},{\"label\":\"type\",\"value\":\"type\"},{\"label\":\"useMobileUI\",\"value\":\"useMobileUI\"},{\"label\":\"validateApi\",\"value\":\"validateApi\"},{\"label\":\"validateOnChange\",\"value\":\"validateOnChange\"},{\"label\":\"validationErrors\",\"value\":\"validationErrors\"},{\"label\":\"validations\",\"value\":\"validations\"},{\"label\":\"value\",\"value\":\"value\"},{\"label\":\"valuesNoWrap\",\"value\":\"valuesNoWrap\"},{\"label\":\"visible\",\"value\":\"visible\"},{\"label\":\"visibleOn\",\"value\":\"visibleOn\"},{\"label\":\"width\",\"value\":\"width\"},{\"label\":\"make\",\"value\":\"make\"},{\"label\":\"permission\",\"value\":\"permission\"},{\"label\":\"filteredResults\",\"value\":\"filteredResults\"},{\"label\":\"macro\",\"value\":\"macro\"},{\"label\":\"mixin\",\"value\":\"mixin\"},{\"label\":\"hasMacro\",\"value\":\"hasMacro\"},{\"label\":\"flushMacros\",\"value\":\"flushMacros\"},{\"label\":\"__callStatic\",\"value\":\"__callStatic\"},{\"label\":\"macroCall\",\"value\":\"macroCall\"}],\"form_component_property\":[{\"name\":\"required\",\"value\":\"1\"}]},\"detail_component\":[],\"list_filter\":[{\"mode\":\"input\",\"type\":\"contains\",\"filter\":{\"filter_type\":\"TextControl\",\"filter_property\":[{\"name\":\"size\",\"value\":\"md\"},{\"name\":\"clearable\",\"value\":1}],\"component_property_options\":[{\"label\":\"addApi\",\"value\":\"addApi\"},{\"label\":\"addControls\",\"value\":\"addControls\"},{\"label\":\"addDialog\",\"value\":\"addDialog\"},{\"label\":\"addOn\",\"value\":\"addOn\"},{\"label\":\"autoComplete\",\"value\":\"autoComplete\"},{\"label\":\"autoFill\",\"value\":\"autoFill\"},{\"label\":\"borderMode\",\"value\":\"borderMode\"},{\"label\":\"className\",\"value\":\"className\"},{\"label\":\"clearValueOnEmpty\",\"value\":\"clearValueOnEmpty\"},{\"label\":\"clearValueOnHidden\",\"value\":\"clearValueOnHidden\"},{\"label\":\"clearable\",\"value\":\"clearable\"},{\"label\":\"creatable\",\"value\":\"creatable\"},{\"label\":\"createBtnLabel\",\"value\":\"createBtnLabel\"},{\"label\":\"deferApi\",\"value\":\"deferApi\"},{\"label\":\"deferField\",\"value\":\"deferField\"},{\"label\":\"deleteApi\",\"value\":\"deleteApi\"},{\"label\":\"deleteConfirmText\",\"value\":\"deleteConfirmText\"},{\"label\":\"delimiter\",\"value\":\"delimiter\"},{\"label\":\"desc\",\"value\":\"desc\"},{\"label\":\"description\",\"value\":\"description\"},{\"label\":\"descriptionClassName\",\"value\":\"descriptionClassName\"},{\"label\":\"disabled\",\"value\":\"disabled\"},{\"label\":\"disabledOn\",\"value\":\"disabledOn\"},{\"label\":\"editApi\",\"value\":\"editApi\"},{\"label\":\"editControls\",\"value\":\"editControls\"},{\"label\":\"editDialog\",\"value\":\"editDialog\"},{\"label\":\"editable\",\"value\":\"editable\"},{\"label\":\"editorSetting\",\"value\":\"editorSetting\"},{\"label\":\"extraName\",\"value\":\"extraName\"},{\"label\":\"extractValue\",\"value\":\"extractValue\"},{\"label\":\"hidden\",\"value\":\"hidden\"},{\"label\":\"hiddenOn\",\"value\":\"hiddenOn\"},{\"label\":\"hint\",\"value\":\"hint\"},{\"label\":\"horizontal\",\"value\":\"horizontal\"},{\"label\":\"id\",\"value\":\"id\"},{\"label\":\"initAutoFill\",\"value\":\"initAutoFill\"},{\"label\":\"initFetch\",\"value\":\"initFetch\"},{\"label\":\"initFetchOn\",\"value\":\"initFetchOn\"},{\"label\":\"inline\",\"value\":\"inline\"},{\"label\":\"inputClassName\",\"value\":\"inputClassName\"},{\"label\":\"inputControlClassName\",\"value\":\"inputControlClassName\"},{\"label\":\"joinValues\",\"value\":\"joinValues\"},{\"label\":\"labelAlign\",\"value\":\"labelAlign\"},{\"label\":\"labelClassName\",\"value\":\"labelClassName\"},{\"label\":\"labelRemark\",\"value\":\"labelRemark\"},{\"label\":\"labelWidth\",\"value\":\"labelWidth\"},{\"label\":\"maxLength\",\"value\":\"maxLength\"},{\"label\":\"minLength\",\"value\":\"minLength\"},{\"label\":\"mode\",\"value\":\"mode\"},{\"label\":\"multiple\",\"value\":\"multiple\"},{\"label\":\"nativeAutoComplete\",\"value\":\"nativeAutoComplete\"},{\"label\":\"nativeInputClassName\",\"value\":\"nativeInputClassName\"},{\"label\":\"onEvent\",\"value\":\"onEvent\"},{\"label\":\"options\",\"value\":\"options\"},{\"label\":\"placeholder\",\"value\":\"placeholder\"},{\"label\":\"prefix\",\"value\":\"prefix\"},{\"label\":\"readOnly\",\"value\":\"readOnly\"},{\"label\":\"readOnlyOn\",\"value\":\"readOnlyOn\"},{\"label\":\"remark\",\"value\":\"remark\"},{\"label\":\"removable\",\"value\":\"removable\"},{\"label\":\"required\",\"value\":\"required\"},{\"label\":\"resetValue\",\"value\":\"resetValue\"},{\"label\":\"row\",\"value\":\"row\"},{\"label\":\"saveImmediately\",\"value\":\"saveImmediately\"},{\"label\":\"selectFirst\",\"value\":\"selectFirst\"},{\"label\":\"showCounter\",\"value\":\"showCounter\"},{\"label\":\"size\",\"value\":\"size\"},{\"label\":\"source\",\"value\":\"source\"},{\"label\":\"static\",\"value\":\"static\"},{\"label\":\"staticClassName\",\"value\":\"staticClassName\"},{\"label\":\"staticInputClassName\",\"value\":\"staticInputClassName\"},{\"label\":\"staticLabelClassName\",\"value\":\"staticLabelClassName\"},{\"label\":\"staticOn\",\"value\":\"staticOn\"},{\"label\":\"staticPlaceholder\",\"value\":\"staticPlaceholder\"},{\"label\":\"staticSchema\",\"value\":\"staticSchema\"},{\"label\":\"style\",\"value\":\"style\"},{\"label\":\"submitOnChange\",\"value\":\"submitOnChange\"},{\"label\":\"suffix\",\"value\":\"suffix\"},{\"label\":\"testIdBuilder\",\"value\":\"testIdBuilder\"},{\"label\":\"transform\",\"value\":\"transform\"},{\"label\":\"trimContents\",\"value\":\"trimContents\"},{\"label\":\"type\",\"value\":\"type\"},{\"label\":\"useMobileUI\",\"value\":\"useMobileUI\"},{\"label\":\"validateApi\",\"value\":\"validateApi\"},{\"label\":\"validateOnChange\",\"value\":\"validateOnChange\"},{\"label\":\"validationErrors\",\"value\":\"validationErrors\"},{\"label\":\"validations\",\"value\":\"validations\"},{\"label\":\"value\",\"value\":\"value\"},{\"label\":\"valuesNoWrap\",\"value\":\"valuesNoWrap\"},{\"label\":\"visible\",\"value\":\"visible\"},{\"label\":\"visibleOn\",\"value\":\"visibleOn\"},{\"label\":\"width\",\"value\":\"width\"},{\"label\":\"make\",\"value\":\"make\"},{\"label\":\"permission\",\"value\":\"permission\"},{\"label\":\"filteredResults\",\"value\":\"filteredResults\"},{\"label\":\"macro\",\"value\":\"macro\"},{\"label\":\"mixin\",\"value\":\"mixin\"},{\"label\":\"hasMacro\",\"value\":\"hasMacro\"},{\"label\":\"flushMacros\",\"value\":\"flushMacros\"},{\"label\":\"__callStatic\",\"value\":\"__callStatic\"},{\"label\":\"macroCall\",\"value\":\"macroCall\"}]},\"input_name\":\"keywords\"}]},\"单图\":{\"name\":\"image\",\"type\":\"string\",\"default\":null,\"nullable\":true,\"comment\":\"单图\",\"action_scope\":[\"list\",\"detail\",\"create\",\"edit\"],\"file_column\":true,\"list_component\":{\"list_component_type\":\"TableColumn\",\"component_property_options\":[{\"label\":\"align\",\"value\":\"align\"},{\"label\":\"breakpoint\",\"value\":\"breakpoint\"},{\"label\":\"canAccessSuperData\",\"value\":\"canAccessSuperData\"},{\"label\":\"className\",\"value\":\"className\"},{\"label\":\"classNameExpr\",\"value\":\"classNameExpr\"},{\"label\":\"copyable\",\"value\":\"copyable\"},{\"label\":\"filterable\",\"value\":\"filterable\"},{\"label\":\"fixed\",\"value\":\"fixed\"},{\"label\":\"headerAlign\",\"value\":\"headerAlign\"},{\"label\":\"innerStyle\",\"value\":\"innerStyle\"},{\"label\":\"labelClassName\",\"value\":\"labelClassName\"},{\"label\":\"lazyRenderAfter\",\"value\":\"lazyRenderAfter\"},{\"label\":\"popOver\",\"value\":\"popOver\"},{\"label\":\"quickEdit\",\"value\":\"quickEdit\"},{\"label\":\"quickEditOnUpdate\",\"value\":\"quickEditOnUpdate\"},{\"label\":\"remark\",\"value\":\"remark\"},{\"label\":\"searchable\",\"value\":\"searchable\"},{\"label\":\"sortable\",\"value\":\"sortable\"},{\"label\":\"toggled\",\"value\":\"toggled\"},{\"label\":\"type\",\"value\":\"type\"},{\"label\":\"unique\",\"value\":\"unique\"},{\"label\":\"vAlign\",\"value\":\"vAlign\"},{\"label\":\"value\",\"value\":\"value\"},{\"label\":\"width\",\"value\":\"width\"},{\"label\":\"make\",\"value\":\"make\"},{\"label\":\"permission\",\"value\":\"permission\"},{\"label\":\"filteredResults\",\"value\":\"filteredResults\"},{\"label\":\"macro\",\"value\":\"macro\"},{\"label\":\"mixin\",\"value\":\"mixin\"},{\"label\":\"hasMacro\",\"value\":\"hasMacro\"},{\"label\":\"flushMacros\",\"value\":\"flushMacros\"},{\"label\":\"__callStatic\",\"value\":\"__callStatic\"},{\"label\":\"macroCall\",\"value\":\"macroCall\"}],\"list_component_property\":[{\"name\":\"type\",\"value\":\"image\"},{\"name\":\"enlargeAble\",\"value\":\"1\"}]},\"form_component\":{\"form_component_type\":\"ImageControl\",\"component_property_options\":[{\"label\":\"accept\",\"value\":\"accept\"},{\"label\":\"allowInput\",\"value\":\"allowInput\"},{\"label\":\"autoFill\",\"value\":\"autoFill\"},{\"label\":\"autoUpload\",\"value\":\"autoUpload\"},{\"label\":\"btnClassName\",\"value\":\"btnClassName\"},{\"label\":\"btnUploadClassName\",\"value\":\"btnUploadClassName\"},{\"label\":\"capture\",\"value\":\"capture\"},{\"label\":\"className\",\"value\":\"className\"},{\"label\":\"clearValueOnHidden\",\"value\":\"clearValueOnHidden\"},{\"label\":\"compress\",\"value\":\"compress\"},{\"label\":\"compressOptions\",\"value\":\"compressOptions\"},{\"label\":\"crop\",\"value\":\"crop\"},{\"label\":\"cropFormat\",\"value\":\"cropFormat\"},{\"label\":\"cropQuality\",\"value\":\"cropQuality\"},{\"label\":\"delimiter\",\"value\":\"delimiter\"},{\"label\":\"desc\",\"value\":\"desc\"},{\"label\":\"description\",\"value\":\"description\"},{\"label\":\"descriptionClassName\",\"value\":\"descriptionClassName\"},{\"label\":\"disabled\",\"value\":\"disabled\"},{\"label\":\"disabledOn\",\"value\":\"disabledOn\"},{\"label\":\"draggable\",\"value\":\"draggable\"},{\"label\":\"draggableTip\",\"value\":\"draggableTip\"},{\"label\":\"dropCrop\",\"value\":\"dropCrop\"},{\"label\":\"editorSetting\",\"value\":\"editorSetting\"},{\"label\":\"extraName\",\"value\":\"extraName\"},{\"label\":\"extractValue\",\"value\":\"extractValue\"},{\"label\":\"fixedSize\",\"value\":\"fixedSize\"},{\"label\":\"fixedSizeClassName\",\"value\":\"fixedSizeClassName\"},{\"label\":\"frameImage\",\"value\":\"frameImage\"},{\"label\":\"hidden\",\"value\":\"hidden\"},{\"label\":\"hiddenOn\",\"value\":\"hiddenOn\"},{\"label\":\"hideUploadButton\",\"value\":\"hideUploadButton\"},{\"label\":\"hint\",\"value\":\"hint\"},{\"label\":\"horizontal\",\"value\":\"horizontal\"},{\"label\":\"id\",\"value\":\"id\"},{\"label\":\"imageClassName\",\"value\":\"imageClassName\"},{\"label\":\"initAutoFill\",\"value\":\"initAutoFill\"},{\"label\":\"initCrop\",\"value\":\"initCrop\"},{\"label\":\"inline\",\"value\":\"inline\"},{\"label\":\"inputClassName\",\"value\":\"inputClassName\"},{\"label\":\"joinValues\",\"value\":\"joinValues\"},{\"label\":\"labelAlign\",\"value\":\"labelAlign\"},{\"label\":\"labelClassName\",\"value\":\"labelClassName\"},{\"label\":\"labelRemark\",\"value\":\"labelRemark\"},{\"label\":\"labelWidth\",\"value\":\"labelWidth\"},{\"label\":\"limit\",\"value\":\"limit\"},{\"label\":\"maxLength\",\"value\":\"maxLength\"},{\"label\":\"maxSize\",\"value\":\"maxSize\"},{\"label\":\"mode\",\"value\":\"mode\"},{\"label\":\"multiple\",\"value\":\"multiple\"},{\"label\":\"onEvent\",\"value\":\"onEvent\"},{\"label\":\"placeholder\",\"value\":\"placeholder\"},{\"label\":\"reCropable\",\"value\":\"reCropable\"},{\"label\":\"readOnly\",\"value\":\"readOnly\"},{\"label\":\"readOnlyOn\",\"value\":\"readOnlyOn\"},{\"label\":\"receiver\",\"value\":\"receiver\"},{\"label\":\"remark\",\"value\":\"remark\"},{\"label\":\"required\",\"value\":\"required\"},{\"label\":\"resetValue\",\"value\":\"resetValue\"},{\"label\":\"row\",\"value\":\"row\"},{\"label\":\"saveImmediately\",\"value\":\"saveImmediately\"},{\"label\":\"showCompressOptions\",\"value\":\"showCompressOptions\"},{\"label\":\"size\",\"value\":\"size\"},{\"label\":\"src\",\"value\":\"src\"},{\"label\":\"static\",\"value\":\"static\"},{\"label\":\"staticClassName\",\"value\":\"staticClassName\"},{\"label\":\"staticInputClassName\",\"value\":\"staticInputClassName\"},{\"label\":\"staticLabelClassName\",\"value\":\"staticLabelClassName\"},{\"label\":\"staticOn\",\"value\":\"staticOn\"},{\"label\":\"staticPlaceholder\",\"value\":\"staticPlaceholder\"},{\"label\":\"staticSchema\",\"value\":\"staticSchema\"},{\"label\":\"style\",\"value\":\"style\"},{\"label\":\"submitOnChange\",\"value\":\"submitOnChange\"},{\"label\":\"testIdBuilder\",\"value\":\"testIdBuilder\"},{\"label\":\"thumbMode\",\"value\":\"thumbMode\"},{\"label\":\"thumbRatio\",\"value\":\"thumbRatio\"},{\"label\":\"type\",\"value\":\"type\"},{\"label\":\"uploadBtnText\",\"value\":\"uploadBtnText\"},{\"label\":\"useMobileUI\",\"value\":\"useMobileUI\"},{\"label\":\"validateApi\",\"value\":\"validateApi\"},{\"label\":\"validateOnChange\",\"value\":\"validateOnChange\"},{\"label\":\"validationErrors\",\"value\":\"validationErrors\"},{\"label\":\"validations\",\"value\":\"validations\"},{\"label\":\"value\",\"value\":\"value\"},{\"label\":\"visible\",\"value\":\"visible\"},{\"label\":\"visibleOn\",\"value\":\"visibleOn\"},{\"label\":\"width\",\"value\":\"width\"},{\"label\":\"make\",\"value\":\"make\"},{\"label\":\"permission\",\"value\":\"permission\"},{\"label\":\"filteredResults\",\"value\":\"filteredResults\"},{\"label\":\"macro\",\"value\":\"macro\"},{\"label\":\"mixin\",\"value\":\"mixin\"},{\"label\":\"hasMacro\",\"value\":\"hasMacro\"},{\"label\":\"flushMacros\",\"value\":\"flushMacros\"},{\"label\":\"__callStatic\",\"value\":\"__callStatic\"},{\"label\":\"macroCall\",\"value\":\"macroCall\"},{\"label\":\"uploadImagePath\",\"value\":\"uploadImagePath\"},{\"label\":\"uploadImage\",\"value\":\"uploadImage\"},{\"label\":\"uploadFilePath\",\"value\":\"uploadFilePath\"},{\"label\":\"uploadFile\",\"value\":\"uploadFile\"},{\"label\":\"uploadRichPath\",\"value\":\"uploadRichPath\"},{\"label\":\"uploadRich\",\"value\":\"uploadRich\"},{\"label\":\"chunkUploadStart\",\"value\":\"chunkUploadStart\"},{\"label\":\"chunkUpload\",\"value\":\"chunkUpload\"},{\"label\":\"chunkUploadFinish\",\"value\":\"chunkUploadFinish\"}],\"form_component_property\":[{\"name\":\"required\",\"value\":\"1\"}]},\"detail_component\":{\"detail_component_type\":\"StaticExactControl\",\"component_property_options\":[{\"label\":\"autoFill\",\"value\":\"autoFill\"},{\"label\":\"borderMode\",\"value\":\"borderMode\"},{\"label\":\"className\",\"value\":\"className\"},{\"label\":\"clearValueOnHidden\",\"value\":\"clearValueOnHidden\"},{\"label\":\"copyable\",\"value\":\"copyable\"},{\"label\":\"desc\",\"value\":\"desc\"},{\"label\":\"description\",\"value\":\"description\"},{\"label\":\"descriptionClassName\",\"value\":\"descriptionClassName\"},{\"label\":\"disabled\",\"value\":\"disabled\"},{\"label\":\"disabledOn\",\"value\":\"disabledOn\"},{\"label\":\"editorSetting\",\"value\":\"editorSetting\"},{\"label\":\"extraName\",\"value\":\"extraName\"},{\"label\":\"hidden\",\"value\":\"hidden\"},{\"label\":\"hiddenOn\",\"value\":\"hiddenOn\"},{\"label\":\"hint\",\"value\":\"hint\"},{\"label\":\"horizontal\",\"value\":\"horizontal\"},{\"label\":\"id\",\"value\":\"id\"},{\"label\":\"initAutoFill\",\"value\":\"initAutoFill\"},{\"label\":\"inline\",\"value\":\"inline\"},{\"label\":\"inputClassName\",\"value\":\"inputClassName\"},{\"label\":\"labelAlign\",\"value\":\"labelAlign\"},{\"label\":\"labelClassName\",\"value\":\"labelClassName\"},{\"label\":\"labelRemark\",\"value\":\"labelRemark\"},{\"label\":\"labelWidth\",\"value\":\"labelWidth\"},{\"label\":\"mode\",\"value\":\"mode\"},{\"label\":\"onEvent\",\"value\":\"onEvent\"},{\"label\":\"placeholder\",\"value\":\"placeholder\"},{\"label\":\"popOver\",\"value\":\"popOver\"},{\"label\":\"quickEdit\",\"value\":\"quickEdit\"},{\"label\":\"readOnly\",\"value\":\"readOnly\"},{\"label\":\"readOnlyOn\",\"value\":\"readOnlyOn\"},{\"label\":\"remark\",\"value\":\"remark\"},{\"label\":\"required\",\"value\":\"required\"},{\"label\":\"row\",\"value\":\"row\"},{\"label\":\"saveImmediately\",\"value\":\"saveImmediately\"},{\"label\":\"size\",\"value\":\"size\"},{\"label\":\"static\",\"value\":\"static\"},{\"label\":\"staticClassName\",\"value\":\"staticClassName\"},{\"label\":\"staticInputClassName\",\"value\":\"staticInputClassName\"},{\"label\":\"staticLabelClassName\",\"value\":\"staticLabelClassName\"},{\"label\":\"staticOn\",\"value\":\"staticOn\"},{\"label\":\"staticPlaceholder\",\"value\":\"staticPlaceholder\"},{\"label\":\"staticSchema\",\"value\":\"staticSchema\"},{\"label\":\"style\",\"value\":\"style\"},{\"label\":\"submitOnChange\",\"value\":\"submitOnChange\"},{\"label\":\"testIdBuilder\",\"value\":\"testIdBuilder\"},{\"label\":\"text\",\"value\":\"text\"},{\"label\":\"tpl\",\"value\":\"tpl\"},{\"label\":\"type\",\"value\":\"type\"},{\"label\":\"useMobileUI\",\"value\":\"useMobileUI\"},{\"label\":\"validateApi\",\"value\":\"validateApi\"},{\"label\":\"validateOnChange\",\"value\":\"validateOnChange\"},{\"label\":\"validationErrors\",\"value\":\"validationErrors\"},{\"label\":\"validations\",\"value\":\"validations\"},{\"label\":\"value\",\"value\":\"value\"},{\"label\":\"visible\",\"value\":\"visible\"},{\"label\":\"visibleOn\",\"value\":\"visibleOn\"},{\"label\":\"width\",\"value\":\"width\"},{\"label\":\"make\",\"value\":\"make\"},{\"label\":\"permission\",\"value\":\"permission\"},{\"label\":\"filteredResults\",\"value\":\"filteredResults\"},{\"label\":\"macro\",\"value\":\"macro\"},{\"label\":\"mixin\",\"value\":\"mixin\"},{\"label\":\"hasMacro\",\"value\":\"hasMacro\"},{\"label\":\"flushMacros\",\"value\":\"flushMacros\"},{\"label\":\"__callStatic\",\"value\":\"__callStatic\"},{\"label\":\"macroCall\",\"value\":\"macroCall\"}],\"detail_component_property\":[{\"name\":\"type\",\"value\":\"static-image\"},{\"name\":\"enlargeAble\",\"value\":\"1\"}]},\"file_column_multi\":0},\"排序\":{\"type\":\"integer\",\"comment\":\"排序\",\"action_scope\":[\"list\",\"detail\",\"create\",\"edit\"],\"file_column\":0,\"list_component\":[],\"form_component\":{\"form_component_type\":\"NumberControl\",\"component_property_options\":[{\"label\":\"autoFill\",\"value\":\"autoFill\"},{\"label\":\"big\",\"value\":\"big\"},{\"label\":\"borderMode\",\"value\":\"borderMode\"},{\"label\":\"className\",\"value\":\"className\"},{\"label\":\"clearValueOnHidden\",\"value\":\"clearValueOnHidden\"},{\"label\":\"desc\",\"value\":\"desc\"},{\"label\":\"description\",\"value\":\"description\"},{\"label\":\"descriptionClassName\",\"value\":\"descriptionClassName\"},{\"label\":\"disabled\",\"value\":\"disabled\"},{\"label\":\"disabledOn\",\"value\":\"disabledOn\"},{\"label\":\"displayMode\",\"value\":\"displayMode\"},{\"label\":\"editorSetting\",\"value\":\"editorSetting\"},{\"label\":\"extraName\",\"value\":\"extraName\"},{\"label\":\"hidden\",\"value\":\"hidden\"},{\"label\":\"hiddenOn\",\"value\":\"hiddenOn\"},{\"label\":\"hint\",\"value\":\"hint\"},{\"label\":\"horizontal\",\"value\":\"horizontal\"},{\"label\":\"id\",\"value\":\"id\"},{\"label\":\"initAutoFill\",\"value\":\"initAutoFill\"},{\"label\":\"inline\",\"value\":\"inline\"},{\"label\":\"inputClassName\",\"value\":\"inputClassName\"},{\"label\":\"keyboard\",\"value\":\"keyboard\"},{\"label\":\"kilobitSeparator\",\"value\":\"kilobitSeparator\"},{\"label\":\"labelAlign\",\"value\":\"labelAlign\"},{\"label\":\"labelClassName\",\"value\":\"labelClassName\"},{\"label\":\"labelRemark\",\"value\":\"labelRemark\"},{\"label\":\"labelWidth\",\"value\":\"labelWidth\"},{\"label\":\"max\",\"value\":\"max\"},{\"label\":\"min\",\"value\":\"min\"},{\"label\":\"mode\",\"value\":\"mode\"},{\"label\":\"onEvent\",\"value\":\"onEvent\"},{\"label\":\"placeholder\",\"value\":\"placeholder\"},{\"label\":\"precision\",\"value\":\"precision\"},{\"label\":\"prefix\",\"value\":\"prefix\"},{\"label\":\"readOnly\",\"value\":\"readOnly\"},{\"label\":\"readOnlyOn\",\"value\":\"readOnlyOn\"},{\"label\":\"remark\",\"value\":\"remark\"},{\"label\":\"required\",\"value\":\"required\"},{\"label\":\"row\",\"value\":\"row\"},{\"label\":\"saveImmediately\",\"value\":\"saveImmediately\"},{\"label\":\"showAsPercent\",\"value\":\"showAsPercent\"},{\"label\":\"showSteps\",\"value\":\"showSteps\"},{\"label\":\"size\",\"value\":\"size\"},{\"label\":\"static\",\"value\":\"static\"},{\"label\":\"staticClassName\",\"value\":\"staticClassName\"},{\"label\":\"staticInputClassName\",\"value\":\"staticInputClassName\"},{\"label\":\"staticLabelClassName\",\"value\":\"staticLabelClassName\"},{\"label\":\"staticOn\",\"value\":\"staticOn\"},{\"label\":\"staticPlaceholder\",\"value\":\"staticPlaceholder\"},{\"label\":\"staticSchema\",\"value\":\"staticSchema\"},{\"label\":\"step\",\"value\":\"step\"},{\"label\":\"style\",\"value\":\"style\"},{\"label\":\"submitOnChange\",\"value\":\"submitOnChange\"},{\"label\":\"suffix\",\"value\":\"suffix\"},{\"label\":\"testIdBuilder\",\"value\":\"testIdBuilder\"},{\"label\":\"type\",\"value\":\"type\"},{\"label\":\"unitOptions\",\"value\":\"unitOptions\"},{\"label\":\"useMobileUI\",\"value\":\"useMobileUI\"},{\"label\":\"validateApi\",\"value\":\"validateApi\"},{\"label\":\"validateOnChange\",\"value\":\"validateOnChange\"},{\"label\":\"validationErrors\",\"value\":\"validationErrors\"},{\"label\":\"validations\",\"value\":\"validations\"},{\"label\":\"value\",\"value\":\"value\"},{\"label\":\"visible\",\"value\":\"visible\"},{\"label\":\"visibleOn\",\"value\":\"visibleOn\"},{\"label\":\"width\",\"value\":\"width\"},{\"label\":\"make\",\"value\":\"make\"},{\"label\":\"permission\",\"value\":\"permission\"},{\"label\":\"filteredResults\",\"value\":\"filteredResults\"},{\"label\":\"macro\",\"value\":\"macro\"},{\"label\":\"mixin\",\"value\":\"mixin\"},{\"label\":\"hasMacro\",\"value\":\"hasMacro\"},{\"label\":\"flushMacros\",\"value\":\"flushMacros\"},{\"label\":\"__callStatic\",\"value\":\"__callStatic\"},{\"label\":\"macroCall\",\"value\":\"macroCall\"}],\"form_component_property\":[{\"name\":\"required\",\"value\":\"1\"},{\"name\":\"value\",\"value\":\"0\"},{\"name\":\"min\",\"value\":\"0\"},{\"name\":\"max\",\"value\":\"999999\"},{\"name\":\"description\",\"value\":\"越大越靠前\"}]},\"detail_component\":[],\"name\":\"custom_order\",\"default\":\"0\"},\"是否启用\":{\"type\":\"tinyInteger\",\"comment\":\"是否启用\",\"action_scope\":[\"list\",\"detail\",\"create\",\"edit\"],\"file_column\":0,\"list_component\":{\"list_component_type\":\"TableColumn\",\"list_component_property\":[{\"name\":\"quickEdit\",\"value\":\"{\\\"type\\\":\\\"switch\\\",\\\"mode\\\":\\\"inline\\\",\\\"saveImmediately\\\":true}\"}]},\"form_component\":{\"form_component_type\":\"SwitchControl\",\"form_component_property\":[{\"name\":\"value\",\"value\":\"1\"}]},\"detail_component\":{\"detail_component_type\":\"StaticExactControl\",\"detail_component_property\":[{\"name\":\"type\",\"value\":\"static-status\"}]},\"name\":\"enabled\",\"default\":\"1\",\"list_filter\":[{\"mode\":\"input\",\"type\":\"equal\",\"filter\":{\"filter_type\":\"SelectControl\",\"filter_property\":[{\"name\":\"size\",\"value\":\"md\"},{\"name\":\"clearable\",\"value\":\"1\"},{\"name\":\"options\",\"value\":\"[{\\\"value\\\":1,\\\"label\\\":\\\"是\\\"},{\\\"value\\\":0,\\\"label\\\":\\\"否\\\"}]\"}]},\"input_name\":\"enabled\"}]},\"多图\":{\"name\":\"images\",\"type\":\"text\",\"default\":null,\"nullable\":true,\"comment\":\"多图\",\"action_scope\":[\"list\",\"detail\",\"create\",\"edit\"],\"file_column\":true,\"list_component\":{\"list_component_type\":\"TableColumn\",\"list_component_property\":[{\"name\":\"type\",\"value\":\"images\"},{\"name\":\"enlargeAble\",\"value\":\"1\"}]},\"form_component\":{\"form_component_type\":\"ImageControl\",\"form_component_property\":[{\"name\":\"required\",\"value\":\"1\"},{\"name\":\"multiple\",\"value\":\"1\"}]},\"detail_component\":{\"detail_component_type\":\"StaticExactControl\",\"detail_component_property\":[{\"name\":\"type\",\"value\":\"static-images\"},{\"name\":\"enlargeAble\",\"value\":\"1\"}]},\"file_column_multi\":true}}', '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_settings` VALUES ('detail_component_property', '[{\"key\":\"StaticExactControl\",\"value\":[{\"name\":\"type\",\"value\":\"static-image\"},{\"name\":\"enlargeAble\",\"value\":\"1\"}],\"label\":\"单图\"},{\"key\":\"StaticExactControl\",\"value\":[{\"name\":\"type\",\"value\":\"static-images\"},{\"name\":\"enlargeAble\",\"value\":\"1\"}],\"label\":\"多图\"}]', '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_settings` VALUES ('filter_property', '[{\"key\":\"TextControl\",\"value\":[{\"name\":\"size\",\"value\":\"md\"},{\"name\":\"clearable\",\"value\":1}],\"label\":\"文本\"},{\"key\":\"SelectControl\",\"value\":[{\"name\":\"size\",\"value\":\"md\"},{\"name\":\"clearable\",\"value\":\"1\"},{\"name\":\"options\",\"value\":\"[{\\\"value\\\":1,\\\"label\\\":\\\"是\\\"},{\\\"value\\\":0,\\\"label\\\":\\\"否\\\"}]\"}],\"label\":\"是/否\"}]', '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_settings` VALUES ('form_component_property', '[{\"key\":\"TextControl\",\"value\":[{\"name\":\"required\",\"value\":\"1\"}],\"label\":\"文本(必填)\"},{\"key\":\"NumberControl\",\"value\":[{\"name\":\"required\",\"value\":\"1\"},{\"name\":\"value\",\"value\":\"0\"},{\"name\":\"min\",\"value\":\"0\"},{\"name\":\"max\",\"value\":\"999999\"},{\"name\":\"description\",\"value\":\"越大越靠前\"}],\"label\":\"排序字段\"}]', '2025-03-10 07:31:19', '2025-03-10 07:31:19');
INSERT INTO `admin_settings` VALUES ('list_component_property', '[{\"key\":\"TableColumn\",\"value\":[{\"name\":\"searchable\",\"value\":\"1\"}],\"label\":\"文本(带搜索)\"},{\"key\":\"TableColumn\",\"value\":[{\"name\":\"type\",\"value\":\"image\"},{\"name\":\"enlargeAble\",\"value\":\"1\"}],\"label\":\"单图\"},{\"key\":\"TableColumn\",\"value\":[{\"name\":\"quickEdit\",\"value\":\"{\\\"type\\\":\\\"switch\\\",\\\"mode\\\":\\\"inline\\\",\\\"saveImmediately\\\":true}\"}],\"label\":\"开关\"}]', '2025-03-10 07:31:19', '2025-03-10 07:31:19');

-- ----------------------------
-- Table structure for admin_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `enabled` tinyint NOT NULL DEFAULT 1,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_users_username_unique`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_users
-- ----------------------------
INSERT INTO `admin_users` VALUES (1, 'admin', '$2y$12$sXIrLnNB98AV9TojXd0ZrezwKSgBIMtjkhfQEfT.c2QaQFz7bKn5u', 1, 'Administrator', NULL, NULL, '2025-03-10 07:31:19', '2025-03-10 07:31:19');

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache
-- ----------------------------
INSERT INTO `cache` VALUES ('laravel_cache_admin_has_table_admin_relationships', 'b:1;', 2056951812);
INSERT INTO `cache` VALUES ('laravel_cache_admin_relationships', 'O:39:\"Illuminate\\Database\\Eloquent\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}', 2056951812);
INSERT INTO `cache` VALUES ('laravel_cache_app_setting_admin_locale', 's:5:\"zh_CN\";', 2056952408);
INSERT INTO `cache` VALUES ('laravel_cache_app_setting_system_theme_setting', 'N;', 2057208899);

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cancelled_at` int NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_batches
-- ----------------------------

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED NULL DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobs
-- ----------------------------

-- ----------------------------
-- Table structure for keymap
-- ----------------------------
DROP TABLE IF EXISTS `keymap`;
CREATE TABLE `keymap`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字段',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段value',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `created_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_created_all`(`created_at` ASC, `key` ASC, `value` ASC, `task_id` ASC) USING BTREE,
  INDEX `idx_all`(`key` ASC, `value` ASC, `task_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 604 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of keymap
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '0001_01_01_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` VALUES (3, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO `migrations` VALUES (4, '2022_08_22_203040_install_owl_admin', 2);
INSERT INTO `migrations` VALUES (5, '2025_03_10_073107_create_personal_access_tokens_table', 3);

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `personal_access_tokens_token_unique`(`token` ASC) USING BTREE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type` ASC, `tokenable_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------
INSERT INTO `personal_access_tokens` VALUES (1, 'Slowlyo\\OwlAdmin\\Models\\AdminUser', 1, 'admin', '08f67a99d1ce31ebc350a6799da0e8c0112f516a71702e30108d43e119376208', '[\"*\"]', '2025-03-13 17:18:18', NULL, '2025-03-10 07:40:26', '2025-03-13 17:18:18');

-- ----------------------------
-- Table structure for route
-- ----------------------------
DROP TABLE IF EXISTS `route`;
CREATE TABLE `route`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `main_id` int NOT NULL COMMENT '主路由ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由名称',
  `config` json NULL COMMENT '配置参数',
  `push_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'push地址',
  `parent_id` int NULL DEFAULT NULL COMMENT '上级ID',
  `concurrency` tinyint NULL DEFAULT 1 COMMENT '并发数量',
  `delay` int NULL DEFAULT 0 COMMENT '延迟多少秒运行',
  `sleep` int NULL DEFAULT 10 COMMENT '运行一轮休息时间',
  `limit` int NULL DEFAULT 10 COMMENT '一轮获取多少数据',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of route
-- ----------------------------
INSERT INTO `route` VALUES (32, 32, 'account_main', NULL, '192.168.100.128:9501/finish-notify', 0, 1, 0, 10, 20, '2024-12-22 16:30:11', '2024-12-22 16:30:11', NULL);
INSERT INTO `route` VALUES (33, 32, 'account_child_A_1', NULL, '192.168.100.128:9501/finish-notify', 32, 1, 0, 10, 20, '2024-12-22 16:35:58', '2024-12-22 16:35:58', NULL);
INSERT INTO `route` VALUES (34, 32, 'account_child_B_1', NULL, '192.168.100.128:9501/finish-notify', 32, 1, 0, 10, 20, '2024-12-22 16:36:16', '2024-12-22 16:36:16', NULL);
INSERT INTO `route` VALUES (35, 32, 'account_child_C_2', NULL, '192.168.100.128:9501/finish-notify', 34, 1, 0, 10, 20, '2024-12-22 16:36:41', '2024-12-22 16:36:41', NULL);
INSERT INTO `route` VALUES (36, 36, 'xhs_account', NULL, '192.168.100.128:9501/finish-notify', 0, 1, 0, 10, 20, '2024-12-26 16:35:33', '2024-12-26 16:35:33', NULL);
INSERT INTO `route` VALUES (37, 37, 'xhs_customer', NULL, '192.168.100.128:9501/finish-notify', 0, 1, 0, 10, 20, '2024-12-26 16:36:23', '2025-03-12 16:55:29', NULL);
INSERT INTO `route` VALUES (38, 38, 'customer-sync', NULL, 'http://192.168.100.130:9503/schedule-finish-api', 0, 1, 0, 5, 20, '2025-03-13 11:30:21', '2025-03-13 15:31:53', NULL);

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_user_id_index`(`user_id` ASC) USING BTREE,
  INDEX `sessions_last_activity_index`(`last_activity` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('EH51kX8o4DR9q3Vbxbace1Yrj853MUC9GpJTPqdl', NULL, '192.168.100.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicDJvZGhod1I0NXFxenJEbEZhUzRpOHVBSUppdjdVaEF1aWc2dkFCMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xOTIuMTY4LjEwMC4xMzA6OTUwMiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1741592401);
INSERT INTO `sessions` VALUES ('qBtrndkdp2JH0UyLafthjBK9kkwMq0wpgQGBUd6W', NULL, '192.168.100.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNWdQRlpwb3lnb1VhVGdTemxxbmpHSmNQR3FsUjd4S2NsVUFvZjhQSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xOTIuMTY4LjEwMC4xMzA6OTUwMiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1741835686);
INSERT INTO `sessions` VALUES ('Vn1p9MxDidXGgDAxqXrXrZ1HbZqNBjI509L88xLX', NULL, '192.168.100.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibHl1QzVXSG1zSzhBc21hN0pORGVuVlQ3SFhFeEQ5Q0k0SnNWOFJSVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xOTIuMTY4LjEwMC4xMzA6OTUwMiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1741767880);

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '运行次数',
  `parent_id` int NULL DEFAULT 0 COMMENT '上级任务ID',
  `main_trace_id` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '主-跟踪ID',
  `trace_id` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '跟踪ID',
  `route_id` int NOT NULL COMMENT '路由ID',
  `push_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '推送地址',
  `param` json NULL COMMENT '初始参数',
  `request_param` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '调用Finish-api传递参数',
  `result` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '运行结果',
  `status` tinyint NULL DEFAULT 0 COMMENT '运行状态  0待调度 1已投递 2已接收finish 3子任务生成成功  4运行成功  5运行异常  6作废',
  `count` tinyint NULL DEFAULT 0 COMMENT '运行次数',
  `delay` int NULL DEFAULT 0 COMMENT '延时运行',
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  `deleted_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_trace_id`(`trace_id` ASC, `deleted_at` ASC) USING BTREE,
  INDEX `idx_main_id`(`main_trace_id` ASC, `deleted_at` ASC) USING BTREE,
  INDEX `created_idx`(`updated_at` ASC, `deleted_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1208 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
