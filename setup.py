# setup.py
from setuptools import setup, find_packages
from pathlib import Path

here = Path(__file__).parent
install_requires = (here / "requirements.txt").read_text().splitlines()

setup(
    name="bluehub",
    version="0.1.0",
    packages=find_packages(include=["vpn_bot", "vpn_bot.*"]),
    include_package_data=True,
    install_requires=install_requires,
    entry_points={
        "console_scripts": [
            "bluehub=main:main",
        ],
    },
)
