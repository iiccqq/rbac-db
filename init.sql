/*
SQLyog  v12.2.6 (64 bit)
MySQL - 5.7.4-m14 : Database - rbac
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`rbac` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `rbac`;

/*Table structure for table `sys_config` */

DROP TABLE IF EXISTS `sys_config`;

CREATE TABLE `sys_config` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `parentid` int(11) DEFAULT NULL COMMENT '父id',
  `value` varchar(50) DEFAULT NULL COMMENT '值',
  `text` varchar(255) DEFAULT NULL COMMENT '文本',
  `status` tinyint(4) DEFAULT '0' COMMENT '状态   0：正常  1：停用',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `code` varchar(50) DEFAULT NULL COMMENT '别名',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`value`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='系统配置信息表';

/*Data for the table `sys_config` */

insert  into `sys_config`(`id`,`parentid`,`value`,`text`,`status`,`remark`,`code`) values (1,0,'-1','用户状态',0,'用户状态','sys_config_status'),(2,1,'0','正常',0,'正常',NULL),(3,1,'1','停用',0,'停用',NULL),(4,1,'3','隐藏',0,'隐藏',NULL);

/*Table structure for table `sys_log` */

DROP TABLE IF EXISTS `sys_log`;

CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) DEFAULT NULL COMMENT '请求参数',
  `time` bigint(20) NOT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='系统日志';

/*Data for the table `sys_log` */

insert  into `sys_log`(`id`,`username`,`operation`,`method`,`params`,`time`,`ip`,`create_date`) values (1,'admin','保存用户','com.rbac.controller.SysUserController.save()','[1,{\"username\":\"kjklsf\",\"password\":\"ff\",\"email\":\"ff@163.com\",\"mobile\":\"11\",\"status\":1,\"roleIdList\":[3],\"createUserId\":1}]',4105,'127.0.0.1','2017-08-18 17:41:56');

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COMMENT='菜单管理';

/*Data for the table `sys_menu` */

insert  into `sys_menu`(`menu_id`,`parent_id`,`name`,`url`,`perms`,`type`,`icon`,`order_num`) values (1,0,'系统管理',NULL,NULL,0,'fa fa-cog',0),(2,1,'管理员列表','html/sys/user.html',NULL,1,'fa fa-user',1),(3,1,'角色管理','html/sys/role.html',NULL,1,'fa fa-user-secret',2),(4,1,'菜单管理','html/sys/menu.html',NULL,1,'fa fa-th-list',3),(15,2,'查看',NULL,'sys:user:list,sys:user:info',2,NULL,0),(16,2,'新增',NULL,'sys:user:save,sys:role:select',2,NULL,0),(17,2,'修改',NULL,'sys:user:update,sys:role:select',2,NULL,0),(18,2,'删除',NULL,'sys:user:delete',2,NULL,0),(19,3,'查看',NULL,'sys:role:list,sys:role:info',2,NULL,0),(20,3,'新增',NULL,'sys:role:save,sys:menu:list',2,NULL,0),(21,3,'修改',NULL,'sys:role:update,sys:menu:list',2,NULL,0),(22,3,'删除',NULL,'sys:role:delete',2,NULL,0),(23,4,'查看',NULL,'sys:menu:list,sys:menu:info',2,NULL,0),(24,4,'新增',NULL,'sys:menu:save,sys:menu:select',2,NULL,0),(25,4,'修改',NULL,'sys:menu:update,sys:menu:select',2,NULL,0),(26,4,'删除',NULL,'sys:menu:delete',2,NULL,0),(27,1,'参数管理','html/sys/config.html','sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete',1,'fa fa-sun-o',6),(29,1,'系统日志','html/sys/log.html','sys:log:list',1,'fa fa-file-text-o',7);

/*Table structure for table `sys_oss` */

DROP TABLE IF EXISTS `sys_oss`;

CREATE TABLE `sys_oss` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) DEFAULT NULL COMMENT 'URL地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件上传';

/*Data for the table `sys_oss` */

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='角色';

/*Data for the table `sys_role` */

/*Table structure for table `sys_role_menu` */

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='角色与菜单对应关系';

/*Data for the table `sys_role_menu` */

insert  into `sys_role_menu`(`id`,`role_id`,`menu_id`) values (1,NULL,1),(2,NULL,2),(3,NULL,15),(4,NULL,16),(5,NULL,17),(6,NULL,18),(7,10,1),(8,10,2),(9,10,15),(10,10,16),(11,10,17),(12,10,18),(36,11,1),(37,11,2),(38,11,15),(39,11,16),(40,11,17),(41,11,18),(42,12,1),(43,12,2),(44,12,15),(45,12,16),(46,12,17),(47,12,18),(48,13,1),(49,13,2),(50,13,15),(51,13,16),(52,13,17),(53,13,18),(54,13,3),(55,13,19),(56,13,20),(57,13,21),(58,13,22),(59,13,4),(60,13,23),(61,13,24),(62,13,25),(63,13,26),(64,13,5),(65,13,6),(66,13,7),(67,13,8),(68,13,9),(69,13,10),(70,13,11),(71,13,12),(72,13,13),(73,13,14),(74,13,27),(75,13,30),(76,13,29),(77,14,1),(78,14,2),(79,14,15),(80,14,16),(81,14,17),(82,14,18),(83,15,1),(84,15,4),(85,15,23),(86,15,24),(87,15,25),(88,15,26);

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `salt` varchar(20) DEFAULT NULL COMMENT '盐',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='系统用户';

/*Data for the table `sys_user` */

insert  into `sys_user`(`user_id`,`username`,`password`,`salt`,`email`,`mobile`,`status`,`create_user_id`,`create_time`) values (1,'admin','9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d','YzcmCZNvbXocrsz9dm8e','root@163.com','13612345678',1,1,'2016-11-11 11:11:11'),(2,'aa','aa',NULL,'aa@163.com','123',1,NULL,NULL),(3,'bb','bb',NULL,'b@163.com','123123',1,NULL,NULL),(4,'d','c',NULL,'c@163.com','123',1,NULL,NULL),(5,'ff','ff',NULL,'ff@163.com','1234',1,NULL,NULL),(6,'66','66',NULL,'66@163.com','555',1,NULL,NULL),(7,'77','5345',NULL,'77@163.com','77',1,NULL,NULL),(12,'aabb','aaa',NULL,'aa@163.com','123',0,NULL,NULL),(20,'ed','dd',NULL,'dd@163.com','dd',1,1,NULL),(21,'ss','ss',NULL,'ss@163.com','123',1,1,NULL),(22,'13123','123123',NULL,'123123@163.com','123123132',1,1,NULL);

/*Table structure for table `sys_user_role` */

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='用户与角色对应关系';

/*Data for the table `sys_user_role` */

insert  into `sys_user_role`(`id`,`user_id`,`role_id`) values (6,5,1),(7,5,2),(8,5,3),(9,5,4),(10,5,5),(11,10,1),(12,10,2),(13,10,5),(14,10,6),(15,10,15),(16,15,1),(17,15,2),(18,15,4),(22,0,1),(23,0,2),(24,0,3),(25,0,4),(29,7,1),(30,7,2),(31,7,4),(32,7,5),(34,14,3),(35,17,3),(36,18,3),(37,19,3),(38,12,2),(39,20,1),(40,21,5),(41,22,5);

/*Table structure for table `sys_user_session` */

DROP TABLE IF EXISTS `sys_user_session`;

CREATE TABLE `sys_user_session` (
  `sessionid` varchar(32) NOT NULL,
  `captcha` varchar(6) DEFAULT NULL,
  `expire_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`sessionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_user_session` */

insert  into `sys_user_session`(`sessionid`,`captcha`,`expire_time`,`update_time`) values ('62A8B80F3EA763DB2CE3C812F227DD4F','n234d','2017-08-22 16:50:17','2017-08-22 16:49:17'),('9ACBAB4527E641A7DFC6FA85A500DC68','mn3ey','2017-08-22 17:39:21','2017-08-22 17:38:21'),('B8E825996B2D0DC38438826FECD389D7','nnny7','2017-08-22 18:03:28','2017-08-22 18:02:28');

/*Table structure for table `sys_user_token` */

DROP TABLE IF EXISTS `sys_user_token`;

CREATE TABLE `sys_user_token` (
  `user_id` bigint(20) NOT NULL,
  `token` varchar(100) NOT NULL COMMENT 'token',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户Token';

/*Data for the table `sys_user_token` */

insert  into `sys_user_token`(`user_id`,`token`,`expire_time`,`update_time`) values (1,'7b994c31-7dd9-4557-998e-bdece0d2c4d1','2017-08-23 06:02:36','2017-08-22 18:02:36');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
