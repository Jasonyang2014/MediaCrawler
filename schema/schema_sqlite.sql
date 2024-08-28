-- Table structure for xhs_creator
CREATE TABLE IF NOT EXISTS `xhs_creator` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id` TEXT NOT NULL,
    `nickname` TEXT,
    `avatar` TEXT,
    `ip_location` TEXT,
    `add_ts` INTEGER NOT NULL,
    `last_modify_ts` INTEGER NOT NULL,
    `desc` TEXT,
    `gender` TEXT,
    `follows` TEXT,
    `fans` TEXT,
    `interaction` TEXT,
    `tag_list` TEXT
);

-- Table structure for xhs_note
CREATE TABLE IF NOT EXISTS `xhs_note` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id` TEXT NOT NULL,
    `nickname` TEXT,
    `avatar` TEXT,
    `ip_location` TEXT,
    `add_ts` INTEGER NOT NULL,
    `last_modify_ts` INTEGER NOT NULL,
    `note_id` TEXT NOT NULL,
    `type` TEXT,
    `title` TEXT,
    `desc` TEXT,
    `video_url` TEXT,
    `time` INTEGER NOT NULL,
    `last_update_time` INTEGER NOT NULL,
    `liked_count` TEXT,
    `collected_count` TEXT,
    `comment_count` TEXT,
    `share_count` TEXT,
    `image_list` TEXT,
    `tag_list` TEXT,
    `note_url` TEXT
);

CREATE INDEX IF NOT EXISTS `idx_xhs_note_note_id_209457` ON `xhs_note` (`note_id`);
CREATE INDEX IF NOT EXISTS `idx_xhs_note_time_eaa910` ON `xhs_note` (`time`);

-- Table structure for xhs_note_comment
CREATE TABLE IF NOT EXISTS `xhs_note_comment` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `user_id` TEXT NOT NULL,
    `nickname` TEXT,
    `avatar` TEXT,
    `ip_location` TEXT,
    `add_ts` INTEGER NOT NULL,
    `last_modify_ts` INTEGER NOT NULL,
    `comment_id` TEXT NOT NULL,
    `create_time` INTEGER NOT NULL,
    `note_id` TEXT NOT NULL,
    `content` TEXT NOT NULL,
    `sub_comment_count` INTEGER NOT NULL,
    `pictures` TEXT,
    `parent_comment_id` TEXT
);

CREATE INDEX IF NOT EXISTS `idx_xhs_note_co_comment_8e8349` ON `xhs_note_comment` (`comment_id`);
CREATE INDEX IF NOT EXISTS `idx_xhs_note_co_create__204f8d` ON `xhs_note_comment` (`create_time`);