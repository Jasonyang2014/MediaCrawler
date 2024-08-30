-- --------------------------------------------------------
-- 主机:                           D:\python_workstation\mc\MediaCrawler\data\sqlite.db
-- 服务器版本:                        3.44.0
-- 服务器操作系统:
-- HeidiSQL 版本:                  12.6.0.6765
-- --------------------------------------------------------

-- 导出 sqlite 的数据库结构

-- 导出  表 sqlite.bilibili_up_info 结构
CREATE TABLE IF NOT EXISTS `bilibili_up_info`
(
    `id`             INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id`        TEXT,
    `nickname`       TEXT,
    `avatar`         TEXT,
    `add_ts`         INTEGER NOT NULL,
    `last_modify_ts` INTEGER NOT NULL,
    `total_fans`     INTEGER,
    `total_liked`    INTEGER,
    `user_rank`      INTEGER,
    `is_official`    INTEGER
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.bilibili_video 结构
CREATE TABLE IF NOT EXISTS `bilibili_video`
(
    `id`               INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id`          TEXT,
    `nickname`         TEXT,
    `avatar`           TEXT,
    `add_ts`           INTEGER NOT NULL,
    `last_modify_ts`   INTEGER NOT NULL,
    `video_id`         TEXT    NOT NULL,
    `video_type`       TEXT    NOT NULL,
    `title`            TEXT,
    `desc`             TEXT,
    `create_time`      INTEGER NOT NULL,
    `liked_count`      TEXT,
    `video_play_count` TEXT,
    `video_danmaku`    TEXT,
    `video_comment`    TEXT,
    `video_url`        TEXT,
    `video_cover_url`  TEXT,
    source_keyword     TEXT DEFAULT ''
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.bilibili_video_comment 结构
CREATE TABLE IF NOT EXISTS `bilibili_video_comment`
(
    `id`                INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id`           TEXT,
    `nickname`          TEXT,
    `avatar`            TEXT,
    `add_ts`            INTEGER NOT NULL,
    `last_modify_ts`    INTEGER NOT NULL,
    `comment_id`        TEXT    NOT NULL,
    `video_id`          TEXT    NOT NULL,
    `content`           TEXT,
    `create_time`       INTEGER NOT NULL,
    `sub_comment_count` TEXT    NOT NULL,
    `parent_comment_id` TEXT
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.douyin_aweme 结构
CREATE TABLE IF NOT EXISTS `douyin_aweme`
(
    `id`              INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id`         TEXT,
    `sec_uid`         TEXT,
    `short_user_id`   TEXT,
    `user_unique_id`  TEXT,
    `nickname`        TEXT,
    `avatar`          TEXT,
    `user_signature`  TEXT,
    `ip_location`     TEXT,
    `add_ts`          INTEGER NOT NULL,
    `last_modify_ts`  INTEGER NOT NULL,
    `aweme_id`        TEXT    NOT NULL,
    `aweme_type`      TEXT    NOT NULL,
    `title`           TEXT,
    `desc`            TEXT,
    `create_time`     INTEGER NOT NULL,
    `liked_count`     TEXT,
    `comment_count`   TEXT,
    `share_count`     TEXT,
    `collected_count` TEXT,
    `aweme_url`       TEXT,
    source_keyword    TEXT DEFAULT ''
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.douyin_aweme_comment 结构
CREATE TABLE IF NOT EXISTS `douyin_aweme_comment`
(
    `id`                INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id`           TEXT,
    `sec_uid`           TEXT,
    `short_user_id`     TEXT,
    `user_unique_id`    TEXT,
    `nickname`          TEXT,
    `avatar`            TEXT,
    `user_signature`    TEXT,
    `ip_location`       TEXT,
    `add_ts`            INTEGER NOT NULL,
    `last_modify_ts`    INTEGER NOT NULL,
    `comment_id`        TEXT    NOT NULL,
    `aweme_id`          TEXT    NOT NULL,
    `content`           TEXT,
    `create_time`       INTEGER NOT NULL,
    `sub_comment_count` TEXT    NOT NULL,
    `parent_comment_id` TEXT
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.dy_creator 结构
CREATE TABLE IF NOT EXISTS `dy_creator`
(
    `id`             INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id`        TEXT    NOT NULL,
    `nickname`       TEXT,
    `avatar`         TEXT,
    `ip_location`    TEXT,
    `add_ts`         INTEGER NOT NULL,
    `last_modify_ts` INTEGER NOT NULL,
    `desc`           TEXT,
    `gender`         TEXT,
    `follows`        TEXT,
    `fans`           TEXT,
    `interaction`    TEXT,
    `videos_count`   TEXT
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.kuaishou_video 结构
CREATE TABLE IF NOT EXISTS `kuaishou_video`
(
    `id`              INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id`         TEXT,
    `nickname`        TEXT,
    `avatar`          TEXT,
    `add_ts`          INTEGER NOT NULL,
    `last_modify_ts`  INTEGER NOT NULL,
    `video_id`        TEXT    NOT NULL,
    `video_type`      TEXT    NOT NULL,
    `title`           TEXT,
    `desc`            TEXT,
    `create_time`     INTEGER NOT NULL,
    `liked_count`     TEXT,
    `viewd_count`     TEXT,
    `video_url`       TEXT,
    `video_cover_url` TEXT,
    `video_play_url`  TEXT,
    source_keyword    TEXT DEFAULT ''
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.kuaishou_video_comment 结构
CREATE TABLE IF NOT EXISTS `kuaishou_video_comment`
(
    `id`                INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id`           TEXT,
    `nickname`          TEXT,
    `avatar`            TEXT,
    `add_ts`            INTEGER NOT NULL,
    `last_modify_ts`    INTEGER NOT NULL,
    `comment_id`        TEXT    NOT NULL,
    `video_id`          TEXT    NOT NULL,
    `content`           TEXT,
    `create_time`       INTEGER NOT NULL,
    `sub_comment_count` TEXT    NOT NULL
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.sqlean_define 结构
CREATE TABLE IF NOT EXISTS sqlean_define
(
    name text primary key,
    type text,
    body text
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.tieba_comment 结构
CREATE TABLE IF NOT EXISTS `tieba_comment`
(
    `id`                INTEGER PRIMARY KEY AUTOINCREMENT,
    `comment_id`        TEXT NOT NULL,
    `parent_comment_id` TEXT    DEFAULT '',
    `content`           TEXT NOT NULL,
    `user_link`         TEXT    DEFAULT '',
    `user_nickname`     TEXT    DEFAULT '',
    `user_avatar`       TEXT    DEFAULT '',
    `tieba_id`          TEXT    DEFAULT '',
    `tieba_name`        TEXT NOT NULL,
    `tieba_link`        TEXT NOT NULL,
    `publish_time`      TEXT    DEFAULT '',
    `ip_location`       TEXT    DEFAULT '',
    `sub_comment_count` INTEGER DEFAULT 0,
    `note_id`           TEXT NOT NULL,
    note_url            TEXT,
    add_ts              integer,
    last_modify_ts      integer
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.tieba_creator 结构
CREATE TABLE IF NOT EXISTS tieba_creator
(
    id                    INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id               TEXT    NOT NULL,
    user_name             TEXT    NOT NULL,
    nickname              TEXT,
    avatar                TEXT,
    ip_location           TEXT,
    add_ts                INTEGER NOT NULL,
    last_modify_ts        INTEGER NOT NULL,
    gender                TEXT,
    follows               TEXT,
    fans                  TEXT,
    registration_duration TEXT
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.tieba_note 结构
CREATE TABLE IF NOT EXISTS `tieba_note`
(
    `id`                INTEGER PRIMARY KEY AUTOINCREMENT,
    `note_id`           TEXT    NOT NULL,
    `title`             TEXT    NOT NULL,
    `desc`              TEXT,
    `note_url`          TEXT    NOT NULL,
    `publish_time`      TEXT    NOT NULL,
    `user_link`         TEXT    DEFAULT '',
    `user_nickname`     TEXT    DEFAULT '',
    `user_avatar`       TEXT    DEFAULT '',
    `tieba_id`          TEXT    DEFAULT '',
    `tieba_name`        TEXT    NOT NULL,
    `tieba_link`        TEXT    NOT NULL,
    `total_replay_num`  INTEGER DEFAULT 0,
    `total_replay_page` INTEGER DEFAULT 0,
    `ip_location`       TEXT    DEFAULT '',
    `add_ts`            INTEGER NOT NULL,
    `last_modify_ts`    INTEGER NOT NULL,
    source_keyword      TEXT    DEFAULT ''
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.weibo_creator 结构
CREATE TABLE IF NOT EXISTS weibo_creator
(
    id             INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id        TEXT    NOT NULL,
    nickname       TEXT,
    avatar         TEXT,
    ip_location    TEXT,
    add_ts         INTEGER NOT NULL,
    last_modify_ts INTEGER NOT NULL,
    desc           TEXT,
    gender         TEXT,
    follows        TEXT,
    fans           TEXT,
    tag_list       TEXT
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.weibo_note 结构
CREATE TABLE IF NOT EXISTS `weibo_note`
(
    `id`               INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id`          TEXT,
    `nickname`         TEXT,
    `avatar`           TEXT,
    `gender`           TEXT,
    `profile_url`      TEXT,
    `ip_location`      TEXT,
    `add_ts`           INTEGER NOT NULL,
    `last_modify_ts`   INTEGER NOT NULL,
    `note_id`          TEXT    NOT NULL,
    `content`          TEXT,
    `create_time`      INTEGER NOT NULL,
    `create_date_time` TEXT    NOT NULL,
    `liked_count`      TEXT,
    `comments_count`   TEXT,
    `shared_count`     TEXT,
    `note_url`         TEXT,
    source_keyword     TEXT DEFAULT ''
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.weibo_note_comment 结构
CREATE TABLE IF NOT EXISTS `weibo_note_comment`
(
    `id`                 INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id`            TEXT,
    `nickname`           TEXT,
    `avatar`             TEXT,
    `gender`             TEXT,
    `profile_url`        TEXT,
    `ip_location`        TEXT,
    `add_ts`             INTEGER NOT NULL,
    `last_modify_ts`     INTEGER NOT NULL,
    `comment_id`         TEXT    NOT NULL,
    `note_id`            TEXT    NOT NULL,
    `content`            TEXT,
    `create_time`        INTEGER NOT NULL,
    `create_date_time`   TEXT    NOT NULL,
    `comment_like_count` TEXT    NOT NULL,
    `sub_comment_count`  TEXT    NOT NULL,
    `parent_comment_id`  TEXT
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.xhs_creator 结构
CREATE TABLE IF NOT EXISTS `xhs_creator`
(
    `id`             INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id`        TEXT    NOT NULL,
    `nickname`       TEXT,
    `avatar`         TEXT,
    `ip_location`    TEXT,
    `add_ts`         INTEGER NOT NULL,
    `last_modify_ts` INTEGER NOT NULL,
    `desc`           TEXT,
    `gender`         TEXT,
    `follows`        TEXT,
    `fans`           TEXT,
    `interaction`    TEXT,
    `tag_list`       TEXT
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.xhs_note 结构
CREATE TABLE IF NOT EXISTS "xhs_note"
(
    id               INTEGER
        primary key autoincrement,
    user_id          TEXT    not null,
    nickname         TEXT,
    avatar           TEXT,
    ip_location      TEXT,
    add_ts           INTEGER not null,
    last_modify_ts   INTEGER not null,
    note_id          TEXT    not null,
    type             TEXT,
    title            TEXT,
    desc             TEXT,
    video_url        TEXT,
    time             INTEGER not null,
    last_update_time INTEGER not null,
    liked_count      INTEGER,
    collected_count  TEXT,
    comment_count    TEXT,
    share_count      TEXT,
    image_list       TEXT,
    tag_list         TEXT,
    note_url         TEXT,
    source_keyword   TEXT
);

-- 数据导出被取消选择。

-- 导出  表 sqlite.xhs_note_comment 结构
CREATE TABLE IF NOT EXISTS `xhs_note_comment`
(
    `id`                INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id`           TEXT    NOT NULL,
    `nickname`          TEXT,
    `avatar`            TEXT,
    `ip_location`       TEXT,
    `add_ts`            INTEGER NOT NULL,
    `last_modify_ts`    INTEGER NOT NULL,
    `comment_id`        TEXT    NOT NULL,
    `create_time`       INTEGER NOT NULL,
    `note_id`           TEXT    NOT NULL,
    `content`           TEXT    NOT NULL,
    `sub_comment_count` INTEGER NOT NULL,
    `pictures`          TEXT,
    `parent_comment_id` TEXT,
    like_count          integer
);


CREATE TABLE IF NOT EXISTS  sqlean_define
(
    name text primary key,
    type text,
    body text
);

CREATE INDEX  IF NOT EXISTS `idx_xhs_note_co_comment_8e8349` ON `xhs_note_comment` (`comment_id`);
CREATE INDEX  IF NOT EXISTS `idx_xhs_note_co_create__204f8d` ON `xhs_note_comment` (`create_time`);
CREATE INDEX  IF NOT EXISTS idx_xhs_note_note_id_209457 on xhs_note (note_id);
CREATE INDEX  IF NOT EXISTS idx_xhs_note_time_eaa910 on xhs_note (time);
CREATE INDEX  IF NOT EXISTS `idx_bilibili_vi_video_i_31c36e` ON `bilibili_video` (`video_id`);
CREATE INDEX  IF NOT EXISTS `idx_bilibili_vi_create__73e0ec` ON `bilibili_video` (`create_time`);
CREATE INDEX  IF NOT EXISTS `idx_bilibili_vi_comment_41c34e` ON `bilibili_video_comment` (`comment_id`);
CREATE INDEX  IF NOT EXISTS `idx_bilibili_vi_video_i_f22873` ON `bilibili_video_comment` (`video_id`);
CREATE INDEX  IF NOT EXISTS `idx_bilibili_vi_user_123456` ON `bilibili_up_info` (`user_id`);
CREATE INDEX  IF NOT EXISTS `idx_douyin_awem_aweme_i_6f7bc6` ON `douyin_aweme` (`aweme_id`);
CREATE INDEX  IF NOT EXISTS `idx_douyin_awem_create__299dfe` ON `douyin_aweme` (`create_time`);
CREATE INDEX  IF NOT EXISTS `idx_douyin_awem_comment_fcd7e4` ON `douyin_aweme_comment` (`comment_id`);
CREATE INDEX  IF NOT EXISTS `idx_douyin_awem_aweme_i_c50049` ON `douyin_aweme_comment` (`aweme_id`);
CREATE INDEX  IF NOT EXISTS `idx_kuaishou_vi_video_i_c5c6a6` ON `kuaishou_video` (`video_id`);
CREATE INDEX  IF NOT EXISTS `idx_kuaishou_vi_create__a10dee` ON `kuaishou_video` (`create_time`);
CREATE INDEX  IF NOT EXISTS `idx_kuaishou_vi_comment_ed48fa` ON `kuaishou_video_comment` (`comment_id`);
CREATE INDEX  IF NOT EXISTS `idx_kuaishou_vi_video_i_e50914` ON `kuaishou_video_comment` (`video_id`);
CREATE INDEX  IF NOT EXISTS `idx_weibo_note_note_id_f95b1a` ON `weibo_note` (`note_id`);
CREATE INDEX  IF NOT EXISTS `idx_weibo_note_create__692709` ON `weibo_note` (`create_time`);
CREATE INDEX  IF NOT EXISTS `idx_weibo_note_create__d05ed2` ON `weibo_note` (`create_date_time`);
CREATE INDEX  IF NOT EXISTS `idx_weibo_note__comment_c7611c` ON `weibo_note_comment` (`comment_id`);
CREATE INDEX  IF NOT EXISTS `idx_weibo_note__note_id_24f108` ON `weibo_note_comment` (`note_id`);
CREATE INDEX  IF NOT EXISTS `idx_weibo_note__create__667fe3` ON `weibo_note_comment` (`create_date_time`);
CREATE INDEX  IF NOT EXISTS `idx_tieba_note_note_id` ON `tieba_note` (`note_id`);
CREATE INDEX  IF NOT EXISTS `idx_tieba_note_publish_time` ON `tieba_note` (`publish_time`);
CREATE INDEX  IF NOT EXISTS tieba_comment_comment_id_index on tieba_comment (comment_id);
CREATE INDEX  IF NOT EXISTS tieba_comment_id_index on tieba_comment (id);
CREATE INDEX  IF NOT EXISTS tieba_comment_note_id_index on tieba_comment (note_id);
CREATE INDEX  IF NOT EXISTS tieba_comment_publish_time_index on tieba_comment (publish_time);

