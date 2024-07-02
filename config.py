import os


class Config:
    """Set Flask configuration variables"""

    SQLALCHEMY_DATABASE_URI = os.getenv("DB_URL")
    SQLALCHEMY_TRACK_MODIFICATIONS = False

__all__ = ["Config"]
