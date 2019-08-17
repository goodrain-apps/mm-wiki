/*
 Navicat Premium Data Transfer

 Source Server         : 139.196.72.60_21450
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : 139.196.72.60:21455
 Source Schema         : wiki

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 17/08/2019 10:18:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mw_attachment
-- ----------------------------
DROP TABLE IF EXISTS `mw_attachment`;
CREATE TABLE `mw_attachment` (
  `attachment_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '附件 id',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '创建用户id',
  `document_id` int(10) NOT NULL DEFAULT '0' COMMENT '所属文档id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '附件名称',
  `path` varchar(100) NOT NULL DEFAULT '' COMMENT '附件路径',
  `source` tinyint(1) NOT NULL DEFAULT '0' COMMENT '附件来源， 0 默认是附件 1 图片',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`attachment_id`),
  KEY `document_id` (`document_id`,`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件信息表';

-- ----------------------------
-- Table structure for mw_collection
-- ----------------------------
DROP TABLE IF EXISTS `mw_collection`;
CREATE TABLE `mw_collection` (
  `collection_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户收藏关系 id',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '收藏类型 1 文档 2 空间',
  `resource_id` int(10) NOT NULL DEFAULT '0' COMMENT '收藏资源 id ',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`collection_id`),
  UNIQUE KEY `user_id_2` (`user_id`,`resource_id`,`type`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户收藏表';

-- ----------------------------
-- Table structure for mw_config
-- ----------------------------
DROP TABLE IF EXISTS `mw_config`;
CREATE TABLE `mw_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '配置表主键Id',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '配置名称',
  `key` char(50) NOT NULL DEFAULT '' COMMENT '配置键',
  `value` text NOT NULL COMMENT '配置值',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='全局配置表';

-- ----------------------------
-- Records of mw_config
-- ----------------------------
BEGIN;
INSERT INTO `mw_config` VALUES (1, '主页标题', 'main_title', '这里可以填写公司名称，例如：欢迎来到 XXX 公司 wiki 平台！', 1565962421, 1566008111);
INSERT INTO `mw_config` VALUES (2, '主页描述', 'main_description', '这是写一些描述：请使用域账号登录，使用中有任何问题请联系管理员 XXX@XXX.com！', 1565962421, 1566008111);
INSERT INTO `mw_config` VALUES (3, '是否开启自动关注', 'auto_follow_doc_open', '0', 1565962421, 1566008112);
INSERT INTO `mw_config` VALUES (4, '是否开启邮件通知', 'send_email_open', '0', 1565962421, 1566008112);
INSERT INTO `mw_config` VALUES (5, '是否开启统一登录', 'sso_open', '0', 1565962421, 1566008112);
INSERT INTO `mw_config` VALUES (6, '系统版本号', 'system_version', 'v0.1.3', 1565962421, 1565962421);
COMMIT;

-- ----------------------------
-- Table structure for mw_contact
-- ----------------------------
DROP TABLE IF EXISTS `mw_contact`;
CREATE TABLE `mw_contact` (
  `contact_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '联系人 id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '联系人名称',
  `mobile` char(13) NOT NULL DEFAULT '' COMMENT '联系电话',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `position` varchar(100) NOT NULL DEFAULT '' COMMENT '联系人职位',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='联系人表';

-- ----------------------------
-- Table structure for mw_document
-- ----------------------------
DROP TABLE IF EXISTS `mw_document`;
CREATE TABLE `mw_document` (
  `document_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '文档 id',
  `parent_id` int(10) NOT NULL DEFAULT '0' COMMENT '文档父 id',
  `space_id` int(10) NOT NULL DEFAULT '0' COMMENT '空间id',
  `name` varchar(150) NOT NULL DEFAULT '' COMMENT '文档名称',
  `type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '文档类型 1 page 2 dir',
  `path` char(30) NOT NULL DEFAULT '0' COMMENT '存储根文档到父文档的 document_id 值, 格式 0,1,2,...',
  `sequence` int(10) NOT NULL DEFAULT '0' COMMENT '排序号(越小越靠前)',
  `create_user_id` int(10) NOT NULL DEFAULT '0' COMMENT '创建用户 id',
  `edit_user_id` int(10) NOT NULL DEFAULT '0' COMMENT '最后修改用户 id',
  `is_delete` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`document_id`),
  KEY `parent_id` (`parent_id`),
  KEY `space_id` (`space_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文档表';

-- ----------------------------
-- Table structure for mw_email
-- ----------------------------
DROP TABLE IF EXISTS `mw_email`;
CREATE TABLE `mw_email` (
  `email_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '邮箱 id',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '邮箱服务器名称',
  `sender_address` varchar(100) NOT NULL DEFAULT '' COMMENT '发件人邮件地址',
  `sender_name` varchar(100) NOT NULL DEFAULT '' COMMENT '发件人显示名',
  `sender_title_prefix` varchar(100) NOT NULL DEFAULT '' COMMENT '发送邮件标题前缀',
  `host` char(100) NOT NULL DEFAULT '' COMMENT '服务器主机名',
  `port` int(5) NOT NULL DEFAULT '25' COMMENT '服务器端口',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(50) NOT NULL DEFAULT '' COMMENT '密码',
  `is_ssl` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否使用ssl， 0 默认不使用 1 使用',
  `is_used` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否被使用， 0 默认不使用 1 使用',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='邮件服务器表';

-- ----------------------------
-- Table structure for mw_follow
-- ----------------------------
DROP TABLE IF EXISTS `mw_follow`;
CREATE TABLE `mw_follow` (
  `follow_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '关注 id',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '关注类型 1 文档 2 用户',
  `object_id` int(10) NOT NULL DEFAULT '0' COMMENT '关注对象 id',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`follow_id`),
  UNIQUE KEY `user_id_2` (`user_id`,`object_id`,`type`),
  KEY `user_id` (`user_id`),
  KEY `object_id` (`object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户关注表';

-- ----------------------------
-- Table structure for mw_link
-- ----------------------------
DROP TABLE IF EXISTS `mw_link`;
CREATE TABLE `mw_link` (
  `link_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接 id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '链接名称',
  `url` varchar(100) NOT NULL DEFAULT '' COMMENT '链接地址',
  `sequence` int(10) NOT NULL DEFAULT '0' COMMENT '排序号(越小越靠前)',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`link_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='快捷链接表';

-- ----------------------------
-- Table structure for mw_log
-- ----------------------------
DROP TABLE IF EXISTS `mw_log`;
CREATE TABLE `mw_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '系统操作日志 id',
  `level` tinyint(3) NOT NULL DEFAULT '6' COMMENT '日志级别',
  `path` char(100) NOT NULL DEFAULT '' COMMENT '请求路径',
  `get` text NOT NULL COMMENT 'get参数',
  `post` text NOT NULL COMMENT 'post参数',
  `message` varchar(255) NOT NULL DEFAULT '' COMMENT '信息',
  `ip` char(100) NOT NULL DEFAULT '' COMMENT 'ip地址',
  `user_agent` char(200) NOT NULL DEFAULT '' COMMENT '用户代理',
  `referer` char(100) NOT NULL DEFAULT '' COMMENT 'referer',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `username` char(100) NOT NULL DEFAULT '' COMMENT '用户名',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`log_id`),
  KEY `level` (`level`,`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='系统操作日志表';

-- ----------------------------
-- Records of mw_log
-- ----------------------------
BEGIN;
INSERT INTO `mw_log` VALUES (1, 6, '/author/login', '/author/login', '{\"username\":[\"admin\"]}', '登录成功', '192.168.20.64', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'http://8080.gr2693fd.iyl0r2oh.0196bd.grapps.cn/author/index', 1, 'admin', 1565962709);
INSERT INTO `mw_log` VALUES (2, 6, '/author/login', '/author/login', '{\"username\":[\"admin\"]}', '登录成功', '192.168.20.64', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'http://8080.gr2693fd.iyl0r2oh.0196bd.grapps.cn/author/index', 1, 'admin', 1565962709);
INSERT INTO `mw_log` VALUES (3, 6, '/system/config/modify', '/system/config/modify', '{\"main_description\":[\"这是写一些描述：请使用域账号登录，使用中有任何问题请联系管理员 root@goodrain.com！\"],\"main_title\":[\"这里可以填写公司名称，例如：欢迎来到北京好雨科技公司 wiki 平台！\"]}', '修改全局配置成功', '192.168.20.64', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'http://8080.gr2693fd.iyl0r2oh.0196bd.grapps.cn/system/config/global', 1, 'admin', 1565962753);
INSERT INTO `mw_log` VALUES (4, 6, '/author/login', '/author/login', '{\"username\":[\"admin\"]}', '登录成功', '192.168.20.64', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'http://8080.gr2693fd.iyl0r2oh.0196bd.grapps.cn/author/index', 1, 'admin', 1565963049);
INSERT INTO `mw_log` VALUES (5, 6, '/author/login', '/author/login', '{\"username\":[\"admin\"]}', '登录成功', '192.168.20.64', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'http://8080.gr2693fd.iyl0r2oh.0196bd.grapps.cn/author/index', 1, 'admin', 1566008080);
INSERT INTO `mw_log` VALUES (6, 6, '/system/config/modify', '/system/config/modify', '{\"main_description\":[\"这是写一些描述：请使用域账号登录，使用中有任何问题请联系管理员 XXX@XXX.com！\"],\"main_title\":[\"这里可以填写公司名称，例如：欢迎来到 XXX 公司 wiki 平台！\"]}', '修改全局配置成功', '192.168.20.64', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', 'http://8080.gr2693fd.iyl0r2oh.0196bd.grapps.cn/system/config/global', 1, 'admin', 1566008112);
COMMIT;

-- ----------------------------
-- Table structure for mw_log_document
-- ----------------------------
DROP TABLE IF EXISTS `mw_log_document`;
CREATE TABLE `mw_log_document` (
  `log_document_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '文档日志 id',
  `document_id` int(10) NOT NULL DEFAULT '0' COMMENT '文档id',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户id',
  `action` tinyint(3) NOT NULL DEFAULT '1' COMMENT '动作 1 创建 2 修改 3 删除',
  `comment` varchar(255) NOT NULL DEFAULT '' COMMENT '备注信息',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`log_document_id`),
  KEY `document_id` (`document_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文档日志表';

-- ----------------------------
-- Table structure for mw_login_auth
-- ----------------------------
DROP TABLE IF EXISTS `mw_login_auth`;
CREATE TABLE `mw_login_auth` (
  `login_auth_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '认证表主键ID',
  `name` varchar(30) NOT NULL COMMENT '登录认证名称',
  `username_prefix` varchar(30) NOT NULL COMMENT '用户名前缀',
  `url` varchar(200) NOT NULL COMMENT '认证接口 url',
  `ext_data` char(100) NOT NULL DEFAULT '' COMMENT '额外数据: token=aaa&key=bbb',
  `is_used` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被使用， 0 默认不使用 1 使用',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `update_time` int(11) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`login_auth_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='统一登录认证表';

-- ----------------------------
-- Table structure for mw_privilege
-- ----------------------------
DROP TABLE IF EXISTS `mw_privilege`;
CREATE TABLE `mw_privilege` (
  `privilege_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '权限名',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级',
  `type` enum('controller','menu') DEFAULT 'controller' COMMENT '权限类型：控制器、菜单',
  `controller` char(100) NOT NULL DEFAULT '' COMMENT '控制器',
  `action` char(100) NOT NULL DEFAULT '' COMMENT '动作',
  `icon` char(100) NOT NULL DEFAULT '' COMMENT '图标（用于展示)',
  `target` char(200) NOT NULL DEFAULT '' COMMENT '目标地址',
  `is_display` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否显示：0不显示 1显示',
  `sequence` int(10) NOT NULL DEFAULT '0' COMMENT '排序(越小越靠前)',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`privilege_id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='系统权限表';

-- ----------------------------
-- Records of mw_privilege
-- ----------------------------
BEGIN;
INSERT INTO `mw_privilege` VALUES (1, '个人中心', 0, 'menu', '', '', 'glyphicon-leaf', '', 1, 1, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (2, '个人资料', 1, 'controller', 'profile', 'info', 'glyphicon-list', '', 1, 11, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (3, '修改资料', 1, 'controller', 'profile', 'edit', 'glyphicon-list', '', 0, 12, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (4, '修改资料保存', 1, 'controller', 'profile', 'modify', 'glyphicon-list', '', 0, 13, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (5, '关注用户列表', 1, 'controller', 'profile', 'followUser', 'glyphicon-list', '', 0, 14, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (6, '关注文档列表', 1, 'controller', 'profile', 'followDoc', 'glyphicon-list', '', 0, 15, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (7, '我的活动', 1, 'controller', 'profile', 'activity', 'glyphicon-list', '', 1, 16, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (8, '修改密码', 1, 'controller', 'profile', 'password', 'glyphicon-list', '', 1, 17, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (9, '修改密码保存', 1, 'controller', 'profile', 'savePass', 'glyphicon-list', '', 0, 18, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (10, '用户管理', 1, 'menu', '', '', 'glyphicon-user', '', 1, 2, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (11, '添加用户', 10, 'controller', 'user', 'add', 'glyphicon-list', '', 1, 21, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (12, '添加用户保存', 10, 'controller', 'user', 'save', 'glyphicon-list', '', 0, 22, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (13, '用户列表', 10, 'controller', 'user', 'list', 'glyphicon-list', '', 1, 23, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (14, '修改用户', 10, 'controller', 'user', 'edit', 'glyphicon-list', '', 0, 24, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (15, '修改用户保存', 10, 'controller', 'user', 'modify', 'glyphicon-list', '', 0, 25, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (16, '屏蔽用户', 10, 'controller', 'user', 'forbidden', 'glyphicon-list', '', 0, 26, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (17, '恢复用户', 10, 'controller', 'user', 'recover', 'glyphicon-list', '', 0, 27, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (18, '用户详情', 10, 'controller', 'user', 'info', 'glyphicon-list', '', 0, 28, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (19, '角色管理', 1, 'menu', '', '', 'glyphicon-gift', '', 1, 3, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (20, '添加角色', 19, 'controller', 'role', 'add', 'glyphicon-list', '', 1, 31, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (21, '添加角色保存', 19, 'controller', 'role', 'save', 'glyphicon-list', '', 0, 32, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (22, '角色列表', 19, 'controller', 'role', 'list', 'glyphicon-list', '', 1, 33, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (23, '修改角色', 19, 'controller', 'role', 'edit', 'glyphicon-list', '', 0, 34, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (24, '修改角色保存', 19, 'controller', 'role', 'modify', 'glyphicon-list', '', 0, 35, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (25, '角色用户列表', 19, 'controller', 'role', 'user', 'glyphicon-list', '', 0, 36, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (26, '角色权限', 19, 'controller', 'role', 'privilege', 'glyphicon-list', '', 0, 37, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (27, '角色权限保存', 19, 'controller', 'role', 'grantPrivilege', 'glyphicon-list', '', 0, 38, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (28, '删除角色', 19, 'controller', 'role', 'delete', 'glyphicon-list', '', 0, 29, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (29, '重置用户角色', 19, 'controller', 'role', 'resetUser', 'glyphicon-list', '', 0, 310, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (30, '权限管理', 1, 'menu', '', '', 'glyphicon-lock', '', 1, 4, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (31, '添加权限', 30, 'controller', 'privilege', 'add', 'glyphicon-list', '', 1, 41, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (32, '添加权限保存', 30, 'controller', 'privilege', 'save', 'glyphicon-list', '', 0, 42, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (33, '权限列表', 30, 'controller', 'privilege', 'list', 'glyphicon-list', '', 1, 43, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (34, '修改权限', 30, 'controller', 'privilege', 'edit', 'glyphicon-list', '', 0, 44, 1565962420, 1565962420);
INSERT INTO `mw_privilege` VALUES (35, '修改权限保存', 30, 'controller', 'privilege', 'modify', 'glyphicon-list', '', 0, 45, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (36, '删除权限', 30, 'controller', 'privilege', 'delete', 'glyphicon-list', '', 0, 46, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (37, '空间管理', 1, 'menu', '', '', 'glyphicon-th-large', '', 1, 5, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (38, '添加空间', 37, 'controller', 'space', 'add', 'glyphicon-list', '', 1, 51, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (39, '添加空间保存', 37, 'controller', 'space', 'save', 'glyphicon-list', '', 0, 52, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (40, '空间列表', 37, 'controller', 'space', 'list', 'glyphicon-list', '', 1, 53, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (41, '修改空间', 37, 'controller', 'space', 'edit', 'glyphicon-list', '', 0, 54, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (42, '修改空间保存', 37, 'controller', 'space', 'modify', 'glyphicon-list', '', 0, 55, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (43, '空间成员列表', 37, 'controller', 'space', 'member', 'glyphicon-list', '', 0, 56, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (44, '添加空间成员', 37, 'controller', 'space_user', 'save', 'glyphicon-list', '', 0, 57, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (45, '移除空间成员', 37, 'controller', 'space_user', 'remove', 'glyphicon-list', '', 0, 58, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (46, '更新空间成员权限', 37, 'controller', 'space_user', 'modify', 'glyphicon-list', '', 0, 59, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (47, '删除空间', 37, 'controller', 'space', 'delete', 'glyphicon-list', '', 0, 510, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (48, '空间备份', 37, 'controller', 'space', 'download', 'glyphicon-list', '', 0, 512, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (49, '日志管理', 1, 'menu', '', '', 'glyphicon-list-alt', '', 1, 6, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (50, '系统日志', 49, 'controller', 'log', 'system', 'glyphicon-list', '', 1, 61, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (51, '系统日志详情', 49, 'controller', 'log', 'info', 'glyphicon-list', '', 0, 62, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (52, '文档日志', 49, 'controller', 'log', 'document', 'glyphicon-list', '', 1, 63, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (53, '配置管理', 1, 'menu', '', '', 'glyphicon-cog', '', 1, 7, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (54, '全局配置', 53, 'controller', 'config', 'global', 'glyphicon-list', '', 1, 71, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (55, '全局配置保存', 53, 'controller', 'config', 'modify', 'glyphicon-list', '', 0, 72, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (56, '邮箱配置', 53, 'controller', 'email', 'list', 'glyphicon-list', '', 1, 73, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (57, '添加邮件服务器', 53, 'controller', 'email', 'add', 'glyphicon-list', '', 0, 74, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (58, '添加邮件服务器保存', 53, 'controller', 'email', 'save', 'glyphicon-list', '', 0, 75, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (59, '修改邮件服务器', 53, 'controller', 'email', 'edit', 'glyphicon-list', '', 0, 76, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (60, '修改邮件服务器保存', 53, 'controller', 'email', 'modify', 'glyphicon-list', '', 0, 77, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (61, '启用邮件服务器', 53, 'controller', 'email', 'used', 'glyphicon-list', '', 0, 78, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (62, '删除邮件服务器', 53, 'controller', 'email', 'delete', 'glyphicon-list', '', 0, 79, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (63, '登录认证', 53, 'controller', 'auth', 'list', 'glyphicon-list', '', 1, 81, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (64, '添加登录认证', 53, 'controller', 'auth', 'add', 'glyphicon-list', '', 0, 82, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (65, '添加登录认证保存', 53, 'controller', 'auth', 'save', 'glyphicon-list', '', 0, 83, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (66, '修改登录认证', 53, 'controller', 'auth', 'edit', 'glyphicon-list', '', 0, 84, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (67, '修改登录认证保存', 53, 'controller', 'auth', 'modify', 'glyphicon-list', '', 0, 85, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (68, '删除登录认证', 53, 'controller', 'auth', 'delete', 'glyphicon-list', '', 0, 86, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (69, '启用登录认证', 53, 'controller', 'auth', 'used', 'glyphicon-list', '', 0, 87, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (70, '登录认证文档', 53, 'controller', 'auth', 'doc', 'glyphicon-list', '', 0, 88, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (71, '系统管理', 1, 'menu', '', '', 'glyphicon-link', '', 1, 8, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (72, '快捷链接', 71, 'controller', 'link', 'list', 'glyphicon-list', '', 1, 81, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (73, '添加链接', 71, 'controller', 'link', 'add', 'glyphicon-list', '', 0, 82, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (74, '添加链接保存', 71, 'controller', 'link', 'save', 'glyphicon-list', '', 0, 83, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (75, '修改链接', 71, 'controller', 'link', 'edit', 'glyphicon-list', '', 0, 84, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (76, '修改链接保存', 71, 'controller', 'link', 'modify', 'glyphicon-list', '', 0, 85, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (77, '删除链接', 71, 'controller', 'link', 'delete', 'glyphicon-list', '', 0, 86, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (78, '系统联系人', 71, 'controller', 'contact', 'list', 'glyphicon-list', '', 1, 91, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (79, '添加联系人', 71, 'controller', 'contact', 'add', 'glyphicon-list', '', 0, 92, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (80, '添加联系人保存', 71, 'controller', 'contact', 'save', 'glyphicon-list', '', 0, 93, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (81, '修改联系人', 71, 'controller', 'contact', 'edit', 'glyphicon-list', '', 0, 94, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (82, '修改联系人保存', 71, 'controller', 'contact', 'modify', 'glyphicon-list', '', 0, 95, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (83, '删除联系人', 71, 'controller', 'contact', 'delete', 'glyphicon-list', '', 0, 96, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (84, '统计管理', 1, 'menu', '', '', 'glyphicon-signal', '', 1, 9, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (85, '数据统计', 84, 'controller', 'static', 'default', 'glyphicon-list', '', 1, 91, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (86, 'ajax获取空间文档排行', 84, 'controller', 'static', 'spaceDocsRank', 'glyphicon-list', '', 0, 92, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (87, 'ajax获取收藏文档排行', 84, 'controller', 'static', 'collectDocRank', 'glyphicon-list', '', 0, 93, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (88, 'ajax获取文档数量增长趋势', 84, 'controller', 'static', 'docCountByTime', 'glyphicon-list', '', 0, 94, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (89, '系统监控', 84, 'controller', 'static', 'monitor', 'glyphicon-list', '', 1, 95, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (90, 'ajax获取服务器状态', 84, 'controller', 'static', 'serverStatus', 'glyphicon-list', '', 0, 96, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (91, 'ajax获取服务器时间', 84, 'controller', 'static', 'serverTime', 'glyphicon-list', '', 0, 97, 1565962421, 1565962421);
INSERT INTO `mw_privilege` VALUES (92, '测试邮件服务器', 53, 'controller', 'email', 'test', 'glyphicon-list', '', 0, 80, 1565962421, 1565962421);
COMMIT;

-- ----------------------------
-- Table structure for mw_role
-- ----------------------------
DROP TABLE IF EXISTS `mw_role`;
CREATE TABLE `mw_role` (
  `role_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '角色 id',
  `name` char(10) NOT NULL DEFAULT '' COMMENT '角色名称',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '角色类型 0 自定义角色，1 系统角色',
  `is_delete` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否删除，0 否 1 是',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='系统角色表';

-- ----------------------------
-- Records of mw_role
-- ----------------------------
BEGIN;
INSERT INTO `mw_role` VALUES (1, '超级管理员', 1, 0, 1565962420, 1565962420);
INSERT INTO `mw_role` VALUES (2, '管理员', 1, 0, 1565962420, 1565962420);
INSERT INTO `mw_role` VALUES (3, '普通用户', 1, 0, 1565962420, 1565962420);
COMMIT;

-- ----------------------------
-- Table structure for mw_role_privilege
-- ----------------------------
DROP TABLE IF EXISTS `mw_role_privilege`;
CREATE TABLE `mw_role_privilege` (
  `role_privilege_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '角色权限关系 id',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '角色id',
  `privilege_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '权限id',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`role_privilege_id`),
  KEY `role_id` (`role_id`),
  KEY `privilege_id` (`privilege_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='系统角色权限对应关系表';

-- ----------------------------
-- Records of mw_role_privilege
-- ----------------------------
BEGIN;
INSERT INTO `mw_role_privilege` VALUES (1, 3, 1, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (2, 3, 2, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (3, 3, 3, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (4, 3, 4, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (5, 3, 5, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (6, 3, 6, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (7, 3, 7, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (8, 3, 8, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (9, 3, 9, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (10, 2, 1, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (11, 2, 2, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (12, 2, 3, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (13, 2, 4, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (14, 2, 5, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (15, 2, 6, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (16, 2, 7, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (17, 2, 8, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (18, 2, 9, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (19, 2, 37, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (20, 2, 38, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (21, 2, 39, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (22, 2, 40, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (23, 2, 41, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (24, 2, 42, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (25, 2, 43, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (26, 2, 44, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (27, 2, 45, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (28, 2, 46, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (29, 2, 47, 1565962421);
INSERT INTO `mw_role_privilege` VALUES (30, 2, 48, 1565962421);
COMMIT;

-- ----------------------------
-- Table structure for mw_space
-- ----------------------------
DROP TABLE IF EXISTS `mw_space`;
CREATE TABLE `mw_space` (
  `space_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '空间 id',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '名称',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '描述',
  `tags` varchar(255) NOT NULL DEFAULT '' COMMENT '标签',
  `visit_level` enum('private','public') NOT NULL DEFAULT 'public' COMMENT '访问级别：private,public',
  `is_share` tinyint(3) NOT NULL DEFAULT '1' COMMENT '文档是否允许分享 0 否 1 是',
  `is_export` tinyint(3) NOT NULL DEFAULT '1' COMMENT '文档是否允许导出 0 否 1 是',
  `is_delete` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否删除 0 否 1 是',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`space_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='空间表';

-- ----------------------------
-- Table structure for mw_space_user
-- ----------------------------
DROP TABLE IF EXISTS `mw_space_user`;
CREATE TABLE `mw_space_user` (
  `space_user_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户空间关系 id',
  `user_id` int(10) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `space_id` int(10) NOT NULL DEFAULT '0' COMMENT '空间 id',
  `privilege` tinyint(3) NOT NULL DEFAULT '0' COMMENT '空间成员操作权限 0 浏览者 1 编辑者 2 管理员',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`space_user_id`),
  UNIQUE KEY `user_id` (`user_id`,`space_id`),
  KEY `user_id_2` (`user_id`),
  KEY `space_id` (`space_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='空间成员表';

-- ----------------------------
-- Table structure for mw_user
-- ----------------------------
DROP TABLE IF EXISTS `mw_user`;
CREATE TABLE `mw_user` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户 id',
  `username` varchar(100) NOT NULL DEFAULT '' COMMENT '用户名',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '密码',
  `given_name` varchar(50) NOT NULL DEFAULT '' COMMENT '姓名',
  `mobile` char(13) NOT NULL DEFAULT '' COMMENT '手机号',
  `phone` char(13) NOT NULL DEFAULT '' COMMENT '电话',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `department` char(50) NOT NULL DEFAULT '' COMMENT '部门',
  `position` char(50) NOT NULL DEFAULT '' COMMENT '职位',
  `location` char(50) NOT NULL DEFAULT '' COMMENT '位置',
  `im` char(50) NOT NULL DEFAULT '' COMMENT '即时聊天工具',
  `last_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '最后登录ip',
  `last_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `role_id` tinyint(3) NOT NULL DEFAULT '0' COMMENT '角色 id',
  `is_forbidden` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否屏蔽，0 否 1 是',
  `is_delete` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否删除，0 否 1 是',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of mw_user
-- ----------------------------
BEGIN;
INSERT INTO `mw_user` VALUES (1, 'admin', '0192023a7bbd73250516f069df18b500', 'admin', '', '', '', '', '', '', '', '192.168.20.64', 1566008080, 1, 0, 0, 1565962420, 1566008080);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
