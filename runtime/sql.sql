/*
 Navicat Premium Data Transfer

 Source Server         : a-本地ubuntu数据库
 Source Server Type    : MySQL
 Source Server Version : 80035 (8.0.35)
 Source Host           : 192.168.1.128:3306
 Source Schema         : schedule

 Target Server Type    : MySQL
 Target Server Version : 80035 (8.0.35)
 File Encoding         : 65001

 Date: 20/10/2024 21:30:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for keymap
-- ----------------------------
DROP TABLE IF EXISTS `keymap`;
CREATE TABLE `keymap`  (
                           `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
                           `key` char(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字段',
                           `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段value',
                           `task_id` int NOT NULL COMMENT '任务ID',
                           PRIMARY KEY (`id`) USING BTREE,
                           INDEX `idx_all`(`key` ASC, `value` ASC, `task_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of keymap
-- ----------------------------
INSERT INTO `keymap` VALUES (6, 'order_sn', '123', 7);
INSERT INTO `keymap` VALUES (8, 'order_sn', '123', 9);
INSERT INTO `keymap` VALUES (12, 'order_sn', '123', 13);
INSERT INTO `keymap` VALUES (14, 'order_sn', '123', 16);
INSERT INTO `keymap` VALUES (16, 'order_sn', '123', 20);
INSERT INTO `keymap` VALUES (5, 'user_id', '1', 7);
INSERT INTO `keymap` VALUES (7, 'user_id', '1', 9);
INSERT INTO `keymap` VALUES (11, 'user_id', '1', 13);
INSERT INTO `keymap` VALUES (13, 'user_id', '1', 16);
INSERT INTO `keymap` VALUES (15, 'user_id', '1', 20);

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
                          `created_at` datetime NULL DEFAULT NULL,
                          `updated_at` datetime NULL DEFAULT NULL,
                          `deleted_at` datetime NULL DEFAULT NULL,
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of route
-- ----------------------------
INSERT INTO `route` VALUES (22, 22, 'tongmingxuan_main', NULL, 'http://192.168.2.100:19501/', 0, 3, 0, '2024-10-20 17:18:43', '2024-10-20 17:18:43', NULL);
INSERT INTO `route` VALUES (23, 22, 'tongmingxuan_child_1', NULL, 'http://192.168.2.100:19501/', 22, 3, 0, '2024-10-20 18:06:30', '2024-10-20 18:06:30', NULL);
INSERT INTO `route` VALUES (24, 22, 'tongmingxuan_child_1_1', NULL, 'http://192.168.2.100:19501/', 23, 3, 0, '2024-10-20 21:16:43', '2024-10-20 21:16:43', NULL);
INSERT INTO `route` VALUES (26, 22, 'tongmingxuan_child_2', NULL, 'http://192.168.2.100:19501/', 22, 3, 0, '2024-10-20 21:24:38', '2024-10-20 21:24:38', NULL);

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
                         `created_at` datetime NULL DEFAULT NULL,
                         `updated_at` datetime NULL DEFAULT NULL,
                         `deleted_at` datetime NULL DEFAULT NULL,
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES (20, 0, 'f5ko5k0bn00d50o1g2hjalw100cmtmrq', 'f5ko5k0bn00d50o1g2hjalw100cmtmrq', 22, 'http://192.168.2.100:19501/', '{\"order_sn\": \"xxxx\"}', NULL, 0, 0, '2024-10-20 21:26:02', '2024-10-20 21:26:02', NULL);
INSERT INTO `task` VALUES (21, 20, 'f5ko5k0bn00d50o1g2hjalw100cmtmrq', 'f5ko5k0bn00d50o1g322vrg300s6nfzm', 23, 'http://192.168.2.100:19501/', NULL, NULL, 0, 0, '2024-10-20 21:26:02', '2024-10-20 21:26:02', NULL);
INSERT INTO `task` VALUES (22, 21, 'f5ko5k0bn00d50o1g2hjalw100cmtmrq', 'f5ko5k0bn00d50o1g33v7i44009tozt7', 24, 'http://192.168.2.100:19501/', NULL, NULL, 0, 0, '2024-10-20 21:26:02', '2024-10-20 21:26:02', NULL);
INSERT INTO `task` VALUES (23, 20, 'f5ko5k0bn00d50o1g2hjalw100cmtmrq', 'f5ko5k0bn00d50o1g35cvlo500wxk7sh', 26, 'http://192.168.2.100:19501/', NULL, NULL, 0, 0, '2024-10-20 21:26:02', '2024-10-20 21:26:02', NULL);

SET FOREIGN_KEY_CHECKS = 1;
