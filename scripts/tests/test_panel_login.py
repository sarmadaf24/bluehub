# 📁 test_panel_login.py

import asyncio
import httpx

# 🧾 مقادیر اتصال رو تنظیم کن دقیق!
PANEL_URL = "https://bluehub1.varzeshnews24.online:54322/aOQyy6wVYyI7M9T"
USERNAME = "C1kt5SJPdF"
PASSWORD = "MTJzS5Opyt"

async def test_panel_connection():
    async with httpx.AsyncClient(base_url=PANEL_URL, follow_redirects=True, verify=False) as client:
        try:
            resp = await client.post("/login", json={
                "username": USERNAME,
                "password": PASSWORD
            })

            if resp.status_code == 200 and "3x-ui" in resp.headers.get("set-cookie", ""):
                print("✅ اتصال موفق به پنل 3x-ui")
            else:
                print("❌ اتصال برقرار نشد یا کوکی معتبر دریافت نشد")
                print(f"⛔ status code: {resp.status_code}")
                print(f"📨 response text: {resp.text}")

        except Exception as e:
            print(f"❌ خطا در اتصال به پنل: {e}")

if __name__ == "__main__":
    asyncio.run(test_panel_connection())
