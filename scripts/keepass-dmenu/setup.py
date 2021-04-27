from setuptools import setup

setup(
    name="keepass-dmenu",
    version="1.0.0",
    description="Provides a dmenu-compatible interface for KeePass databases.",
    scripts=["keepass-dmenu.py", "keepass-dmenu"],
    install_requires=[
        "pykeepass_cache",
        "pyotp",
        "configparser"
    ]
)
