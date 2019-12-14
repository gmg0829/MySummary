CREATE DATABASE flow_log
  CHARACTER SET = 'latin1'
  COLLATE = 'latin1_swedish_ci';

use flow_log;

CREATE TABLE `extra` (
  `love` int(20) DEFAULT NULL,
  `hate` varchar(10) DEFAULT NULL,
  `smig` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `extra_stuff` (
  `appl_no` varchar(100) NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `province` varchar(100) DEFAULT NULL,
  `manual` varchar(10) DEFAULT NULL,
  `manual_staff` varchar(30) DEFAULT NULL,
  `loan` int(11) DEFAULT NULL,
  `overdue` varchar(10) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `ID` varchar(100) DEFAULT NULL,
  `res_ID` int(255) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`res_ID`),
  KEY `appl_no` (`appl_no`)
) ENGINE=InnoDB AUTO_INCREMENT=59415715 DEFAULT CHARSET=utf8;

CREATE TABLE `graph_basic_info` (
  `content` varchar(100) DEFAULT NULL,
  `num` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `graph_gclass` (
  `f_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `f_class` varchar(50) DEFAULT NULL,
  `is_key` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `graph_origin_data` (
  `uid` int(11) NOT NULL,
  `field` varchar(100) DEFAULT NULL,
  `value` varchar(1000) DEFAULT NULL,
  KEY `uidi` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `graph_rel_table` (
  `id` varchar(255) DEFAULT NULL,
  `i_id` varchar(255) DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `list_B` (
  `aid` bigint(20) NOT NULL AUTO_INCREMENT,
  `name_l` varchar(100) DEFAULT NULL,
  `id_l` varchar(20) DEFAULT NULL,
  `phone_l` varchar(13) DEFAULT NULL,
  `com` varchar(255) DEFAULT NULL,
  `list_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`aid`),
  KEY `id_i` (`id_l`)
) ENGINE=InnoDB AUTO_INCREMENT=49742754 DEFAULT CHARSET=utf8;

CREATE TABLE `list_W` (
  `aid` bigint(20) NOT NULL AUTO_INCREMENT,
  `name_l` varchar(100) DEFAULT NULL,
  `id_l` varchar(20) DEFAULT NULL,
  `phone_l` varchar(13) DEFAULT NULL,
  `com` varchar(255) DEFAULT NULL,
  `list_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`aid`),
  KEY `id_i` (`id_l`)
) ENGINE=InnoDB AUTO_INCREMENT=6132014 DEFAULT CHARSET=utf8;

CREATE TABLE `ml_trans_model_dec_result` (
  `res_ID` int(255) NOT NULL AUTO_INCREMENT,
  `appl_no` varchar(255) DEFAULT NULL,
  `res` varchar(511) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`res_ID`),
  KEY `ut` (`update_time`),
  KEY `appl_no` (`appl_no`)
) ENGINE=InnoDB AUTO_INCREMENT=334060 DEFAULT CHARSET=utf8;

CREATE TABLE `ml_trans_model_pcf` (
  `flow_name` text,
  `product_name` text,
  `channel_name` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `ml_trans_model_run_step` (
  `res_ID` int(255) NOT NULL AUTO_INCREMENT,
  `appl_no` varchar(255) DEFAULT NULL,
  `step1` varchar(10) DEFAULT NULL,
  `step2` varchar(10) DEFAULT NULL,
  `res` varchar(1023) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`res_ID`),
  KEY `ut` (`update_time`),
  KEY `an` (`appl_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2527284 DEFAULT CHARSET=utf8;

CREATE TABLE `pre_flow_ana_appl_no_todo` (
  `appl_no` varchar(200) NOT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `pre_flow_ana_report` (
  `vs_id` int(11) NOT NULL AUTO_INCREMENT,
  `flow1` varchar(50) DEFAULT NULL,
  `flow2` varchar(50) DEFAULT NULL,
  `data_date` varchar(30) DEFAULT NULL,
  `data_sample_num` int(11) DEFAULT NULL,
  `operator` varchar(20) DEFAULT NULL,
  `operate_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `res` varchar(3000) DEFAULT NULL,
  PRIMARY KEY (`vs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;

CREATE TABLE `pre_sta_result_day_hist` (
  `flow_name` varchar(50) DEFAULT NULL,
  `date` varchar(10) DEFAULT NULL,
  `num_appl` int(11) DEFAULT NULL,
  `num_accept` int(11) DEFAULT NULL,
  `num_pending` int(11) DEFAULT NULL,
  `num_reject` int(11) DEFAULT NULL,
  `num_manual` int(11) DEFAULT NULL,
  `num_credit` int(11) DEFAULT NULL,
  `sum_quota` int(11) DEFAULT NULL,
  `sum_loan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `pre_sta_step_day_hist` (
  `flow_name` varchar(50) DEFAULT NULL,
  `date` varchar(10) DEFAULT NULL,
  `num_appl` int(11) DEFAULT NULL,
  `num_accept_AF` int(11) DEFAULT NULL,
  `num_accept_CP` int(11) DEFAULT NULL,
  `num_accept_PS` int(11) DEFAULT NULL,
  `percentage_AF` float DEFAULT NULL,
  `percentage_CP` float DEFAULT NULL,
  `percentage_PS` float DEFAULT NULL,
  `num_overdue` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `pre_sta_step_rule_day_hist` (
  `flow_name` varchar(50) DEFAULT NULL,
  `date` varchar(10) DEFAULT NULL,
  `step` varchar(10) DEFAULT NULL,
  `rules` varchar(20) DEFAULT NULL,
  `hits` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `test_laod` (
  `v1` int(11) DEFAULT NULL,
  `v2` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE USER 'model'@'%' IDENTIFIED BY 'model';
GRANT ALL ON *.* TO 'model'@'%';
flush privileges;