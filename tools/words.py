import asyncio
import json
import logging
from collections import Counter
import uuid
import aiofiles
import jieba
import matplotlib.pyplot as plt
from wordcloud import WordCloud

import config
from tools import utils

plot_lock = asyncio.Lock()


class AsyncWordCloudGenerator:
    def __init__(self):
        logging.getLogger('jieba').setLevel(logging.WARNING)
        self.stop_words_file = config.STOP_WORDS_FILE
        self.lock = asyncio.Lock()
        self.stop_words = self.load_stop_words()
        self.custom_words = config.CUSTOM_WORDS
        for word, group in self.custom_words.items():
            jieba.add_word(word)

    def load_stop_words(self):
        with open(self.stop_words_file, 'r', encoding='utf-8') as f:
            return set(f.read().strip().split('\n'))

    async def generate_word_frequency_and_cloud(self, data, save_words_prefix):
        all_text = ' '.join(item['content'] for item in data)
        word_freq = await self.count_words_to_json_file(all_text, save_words_prefix)

        # Try to acquire the plot lock without waiting
        if plot_lock.locked():
            utils.logger.info("Skipping word cloud generation as the lock is held.")
            return

        await self.generate_word_cloud(word_freq, f'{save_words_prefix}_words_cloud.png')

    async def count_words_to_json_file(self, all_text, save_words_prefix):
        words = [word for word in jieba.lcut(all_text) if word not in self.stop_words and len(word.strip()) > 0]
        word_freq = Counter(words)
        # Save word frequency to file
        freq_file = f"{save_words_prefix}_word_freq.json"
        sorted_words = dict(word_freq.most_common())
        async with aiofiles.open(freq_file, 'w', encoding='utf-8') as file:
            await file.write(json.dumps(sorted_words, ensure_ascii=False, indent=4))
        return word_freq

    async def generate_web_words_cloud(self, word_list, save_words_prefix, top_number):
        all_text = ' '.join(item for item in word_list)
        word_freq = await self.count_words_to_json_file(all_text, save_words_prefix)

        # Try to acquire the plot lock without waiting
        if plot_lock.locked():
            utils.logger.info("Skipping word cloud generation as the lock is held.")
            return ''
        filename = str(uuid.uuid4())
        await self.generate_word_cloud(word_freq, f'{filename}.png', top_number=top_number,
                                       save_path='templates/images/')

        return f'/images/{filename}.png'

    async def generate_word_cloud(self, word_freq, save_words_cloud_filename, top_number=20, save_path=''):
        await plot_lock.acquire()
        top_20_word_freq = dict(word_freq.most_common(top_number))
        wordcloud = WordCloud(
            font_path=config.FONT_PATH,
            width=800,
            height=400,
            background_color='white',
            max_words=200,
            stopwords=self.stop_words,
            colormap='viridis',
            contour_color='steelblue',
            contour_width=1
        ).generate_from_frequencies(top_20_word_freq)

        # Save word cloud image
        plt.figure(figsize=(10, 5), facecolor='white')
        plt.imshow(wordcloud, interpolation='bilinear')

        plt.axis('off')
        plt.tight_layout(pad=0)
        plt.savefig(f"{save_path}{save_words_cloud_filename}", format='png', dpi=100)
        plt.close()

        plot_lock.release()
