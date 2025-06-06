"""Handlers for short video responses and surveys."""
import logging
from aiogram import Router, F
from aiogram.types import Message
from aiogram.filters import Command

router = Router()
logger = logging.getLogger('video-support')

VIDEO_DIR = 'videos'

@router.message(Command('upload_video'))
async def handle_video_upload(message: Message):
    if not message.video:
        await message.answer('ویدیو ارسال کنید')
        return
    try:
        path = f"{VIDEO_DIR}/{message.video.file_id}.mp4"
        await message.video.download(destination=path)
        await message.answer('ویدیو ذخیره شد')
    except Exception as e:
        logger.exception('Video save failed: %s', e)
        await message.answer('خطا در ذخیره ویدیو')
