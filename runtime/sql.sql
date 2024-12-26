/*
 Navicat Premium Data Transfer

 Source Server         : schedule-prod-tongmingxuan
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : 59.110.171.117:3306
 Source Schema         : schedule

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 26/12/2024 19:12:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB AUTO_INCREMENT = 356 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of keymap
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of route
-- ----------------------------
INSERT INTO `route` VALUES (32, 32, 'account_main', NULL, 'http://127.0.0.1:8000/schedule/api/task/test', 0, 1, 0, 3, 10, '2024-12-22 16:30:11', '2024-12-22 16:30:11', NULL);
INSERT INTO `route` VALUES (33, 32, 'account_child_A_1', NULL, 'http://127.0.0.1:8000/schedule/api/task/test', 32, 1, 0, 3, 10, '2024-12-22 16:35:58', '2024-12-22 16:35:58', NULL);
INSERT INTO `route` VALUES (34, 32, 'account_child_B_1', NULL, 'http://127.0.0.1:8000/schedule/api/task/test', 32, 1, 0, 3, 10, '2024-12-22 16:36:16', '2024-12-22 16:36:16', NULL);
INSERT INTO `route` VALUES (35, 32, 'account_child_C_2', NULL, 'http://127.0.0.1:8000/schedule/api/task/test', 34, 1, 0, 3, 10, '2024-12-22 16:36:41', '2024-12-22 16:36:41', NULL);
INSERT INTO `route` VALUES (36, 36, 'xhs_account', NULL, 'http://127.0.0.1:8000/schedule/api/task/test', 0, 1, 0, 5, 20, '2024-12-26 16:35:33', '2024-12-26 16:35:33', NULL);
INSERT INTO `route` VALUES (37, 37, 'xhs_customer', NULL, 'http://127.0.0.1:8000/schedule/api/task/test', 0, 1, 0, 10, 10, '2024-12-26 16:36:23', '2024-12-26 16:36:23', NULL);

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
                         `result` json NULL COMMENT '运行结果',
                         `status` tinyint NULL DEFAULT 0 COMMENT '运行状态  0待调度 1已投递 2已接收finish 3子任务生成成功  4运行成功  5运行异常  6作废',
                         `count` tinyint NULL DEFAULT 0 COMMENT '运行次数',
                         `delay` int NULL DEFAULT 0 COMMENT '延时运行',
                         `created_at` datetime NULL DEFAULT NULL,
                         `updated_at` datetime NULL DEFAULT NULL,
                         `deleted_at` datetime NULL DEFAULT NULL,
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1017 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
