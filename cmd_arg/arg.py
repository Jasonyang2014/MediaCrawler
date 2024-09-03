import argparse

import config
from tools.utils import str2bool


async def parse_cmd():
    # 读取command arg
    parser = argparse.ArgumentParser(description='Media crawler program.')
    parser.add_argument('--platform', type=str, help='Media platform select (xhs | dy | ks | bili | wb | tieba)',
                        choices=["xhs", "dy", "ks", "bili", "wb", "tieba"], default=config.PLATFORM)
    parser.add_argument('--lt', type=str, help='Login type (qrcode | phone | cookie)',
                        choices=["qrcode", "phone", "cookie"], default=config.LOGIN_TYPE)
    parser.add_argument('--type', type=str, help='crawler type (search | detail | creator)',
                        choices=["search", "detail", "creator"], default=config.CRAWLER_TYPE)
    parser.add_argument('--start', type=int,
                        help='number of start page', default=config.START_PAGE)
    parser.add_argument('--keywords', type=str,
                        help='please input keywords', default=config.KEYWORDS)
    parser.add_argument('--get_comment', type=str2bool,
                        help='''whether to crawl level one comment, supported values case insensitive ('yes', 'true', 
                        't', 'y', '1', 'no', 'false', 'f', 'n', '0')''',
                        default=config.ENABLE_GET_COMMENTS)
    parser.add_argument('--get_sub_comment', type=str2bool,
                        help=''''whether to crawl level two comment, supported values case insensitive ('yes', 
                        'true', 't', 'y', '1', 'no', 'false', 'f', 'n', '0')''',
                        default=config.ENABLE_GET_SUB_COMMENTS)
    parser.add_argument('--save_data_option', type=str,
                        help='where to save the data (csv or db or json)', choices=['csv', 'db', 'json'],
                        default=config.SAVE_DATA_OPTION)
    parser.add_argument('--cookies', type=str,
                        help='cookies used for cookie login type', default=config.COOKIES)

    args = parser.parse_args()

    # override config
    config.PLATFORM = args.platform
    config.LOGIN_TYPE = args.lt
    config.CRAWLER_TYPE = args.type
    config.START_PAGE = args.start
    config.KEYWORDS = args.keywords
    config.ENABLE_GET_COMMENTS = args.get_comment
    config.ENABLE_GET_SUB_COMMENTS = args.get_sub_comment
    config.SAVE_DATA_OPTION = args.save_data_option
    config.COOKIES = args.cookies


class Args():
    def __init__(self, platform=config.PLATFORM,
                 lt=config.LOGIN_TYPE,
                 type=config.CRAWLER_TYPE,
                 start=config.START_PAGE,
                 keywords=config.KEYWORDS,
                 get_comment=config.ENABLE_GET_COMMENTS,
                 get_sub_comment=config.ENABLE_GET_SUB_COMMENTS,
                 save_data_option=config.SAVE_DATA_OPTION,
                 cookies=config.COOKIES,
                 max_count=config.CRAWLER_MAX_NOTES_COUNT,
                 max_comment_count=config.MAX_COMMENT_COUNT
                 ):
        self.platform = platform
        self.lt = lt
        self.type = type
        self.start = start
        self.keywords = keywords
        self.get_comment = get_comment
        self.get_sub_comment = get_sub_comment
        self.save_data_option = save_data_option
        self.cookies = cookies
        self.max_count = max_count
        self.max_comment_count = max_comment_count

    def parse(self):
        config.PLATFORM = self.platform
        config.LOGIN_TYPE = self.lt
        config.CRAWLER_TYPE = self.type
        config.START_PAGE = self.start
        config.KEYWORDS = self.keywords
        config.ENABLE_GET_COMMENTS = self.get_comment
        config.ENABLE_GET_SUB_COMMENTS = self.get_sub_comment
        config.SAVE_DATA_OPTION = self.save_data_option
        config.COOKIES = self.cookies
        config.CRAWLER_MAX_NOTES_COUNT = self.max_count
        config.MAX_COMMENT_COUNT = self.max_comment_count
