from typing import List
from datetime import date, timedelta

from sqlalchemy.ext.asyncio import AsyncSession

from src.entity.models import Contact, User
from src.schemas.schema import ContactSchema, ContactUpdate
from sqlalchemy import select, func

async def get_contacts(limit: int, offset: int, db: AsyncSession, user: User) -> List[Contact]:
    result = await db.execute(select(Contact).filter(Contact.user_id == user.id).offset(offset).limit(limit))
    return result.scalars().all()


async def get_contact(contact_id: int, db: AsyncSession, user: User) -> Contact:
    result = await db.execute(select(Contact).filter(Contact.id == contact_id, Contact.user_id == user.id))
    return result.scalar_one_or_none()
  

async def create_contact(body: ContactSchema, db: AsyncSession, user: User) -> Contact:
    contact = Contact(**body.model_dump(exclude_unset=True), user=user)
    db.add(contact)
    await db.commit()
    await db.refresh(contact)
    return contact


async def remove_contact(contact_id: int, db: AsyncSession, user: User) -> Contact | None:
    result = await db.execute(select(Contact).filter(Contact.id == contact_id, Contact.user_id == user.id))
    contact = result.scalar_one_or_none()
    if contact:
        await db.delete(contact)
        await db.commit()
    return contact


async def update_contact(contact_id: int, body: ContactUpdate, db: AsyncSession, user: User) -> Contact | None:
    result = await db.execute(select(Contact).filter(Contact.id == contact_id, Contact.user_id == user.id))
    contact = result.scalar_one_or_none()
    if contact:
        for key, value in body.model_dump(exclude_unset=True).items():
            setattr(contact, key, value)
            
        await db.commit()
        await db.refresh(contact)
    return contact


async def search_contacts(query: str, db: AsyncSession, user: User) -> List[Contact]:
    search_query = f"%{query}%"
    result = await db.execute(
        select(Contact).filter(
            (Contact.first_name.ilike(search_query)|
            Contact.last_name.ilike(search_query) |
            Contact.email.ilike(search_query))&
            (Contact.user_id == user.id)
        )
    )
    return result.scalars().all()



async def get_birthdays_within_next_week(db: AsyncSession, user: User) -> List[Contact]:
    current_date = date.today()
    next_week = current_date + timedelta(days=7)

    current_date_str = current_date.strftime('%m-%d')
    next_week_str = next_week.strftime('%m-%d')

    if current_date.month <= next_week.month:
        result = await db.execute(
            select(Contact).filter(
                func.to_char(Contact.birthday, 'MM-DD').between(current_date_str, next_week_str),
                Contact.user_id == user.id
            )
        )
    else:
        result = await db.execute(
            select(Contact).filter(
                (func.to_char(Contact.birthday, 'MM-DD').between(current_date_str, '12-31')) |
                (func.to_char(Contact.birthday, 'MM-DD').between('01-01', next_week_str)),
                Contact.user_id == user.id
            )
        )

    return result.scalars().all()