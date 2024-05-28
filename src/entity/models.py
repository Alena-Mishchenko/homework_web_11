from sqlalchemy.orm import Mapped, mapped_column, relationship,DeclarativeBase
from sqlalchemy import Integer, String, Date
from typing import Optional


class Base(DeclarativeBase):
    pass


class Contact(Base):
    __tablename__ = "contacts"
    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    first_name: Mapped[str] = mapped_column(String(50), nullable=False)
    last_name: Mapped[str] = mapped_column(String(50), nullable=False)
    email: Mapped[str] = mapped_column(String(50), unique=True, index=True)
    phone: Mapped[str] = mapped_column(String(20), nullable=False)
    birthday: Mapped[Date] = mapped_column(Date, nullable=False)
    additional_info: Mapped[Optional[str]] = mapped_column(String(200), nullable=True)