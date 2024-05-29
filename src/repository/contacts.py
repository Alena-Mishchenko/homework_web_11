from typing import List
from datetime import date, timedelta
# from sqlalchemy.orm import Session
from sqlalchemy.ext.asyncio import AsyncSession
# from sqlalchemy.future import select, func
from src.entity.models import Contact
from src.schemas.schema import ContactSchema, ContactUpdate
from sqlalchemy import select, func

async def get_contacts(limit: int, offset: int, db: AsyncSession) -> List[Contact]:
    result = await db.execute(select(Contact).offset(offset).limit(limit))
    return result.scalars().all()


async def get_contact(contact_id: int, db: AsyncSession) -> Contact:
    result = await db.execute(select(Contact).filter(Contact.id == contact_id))
    return result.scalar_one_or_none()
  

async def create_contact(body: ContactSchema, db: AsyncSession) -> Contact:
    contact = Contact(**body.model_dump(exclude_unset=True))
    db.add(contact)
    await db.commit()
    await db.refresh(contact)
    return contact


async def remove_contact(contact_id: int, db: AsyncSession) -> Contact | None:
    result = await db.execute(select(Contact).filter(Contact.id == contact_id))
    contact = result.scalar_one_or_none()
    if contact:
        await db.delete(contact)
        await db.commit()
    return contact


async def update_contact(contact_id: int, body: ContactUpdate, db: AsyncSession) -> Contact | None:
    result = await db.execute(select(Contact).filter(Contact.id == contact_id))
    contact = result.scalar_one_or_none()
    if contact:
        for key, value in body.model_dump(exclude_unset=True).items():
            setattr(contact, key, value)
            
        await db.commit()
        await db.refresh(contact)
    return contact


async def search_contacts(query: str, db: AsyncSession) -> List[Contact]:
    search_query = f"%{query}%"
    result = await db.execute(
        select(Contact).filter(
            Contact.first_name.ilike(search_query) |
            Contact.last_name.ilike(search_query) |
            Contact.email.ilike(search_query)
        )
    )
    return result.scalars().all()



# async def get_birthdays_within_next_week(db: AsyncSession) -> List[Contact]:
#     current_date = date.today()
#     next_week = current_date + timedelta(days=7)
#     result = await db.execute(select(Contact))
#     contacts = result.scalars().all()
#     upcoming_birthdays = []
#     for contact in contacts:
#         birthday_this_year = contact.birthday.replace(year=current_date.year)

#         if current_date <= birthday_this_year < next_week:
#             upcoming_birthdays.append(contact)
#         else:
#             birthday_next_year = contact.birthday.replace(year=current_date.year + 1)
#             if current_date <= birthday_next_year < next_week:
#                 upcoming_birthdays.append(contact)
#     return upcoming_birthdays




async def get_birthdays_within_next_week(db: AsyncSession) -> List[Contact]:
    current_date = date.today()
    next_week = current_date + timedelta(days=7)

    # Create the date strings for current date and next week
    current_date_str = current_date.strftime('%m-%d')
    next_week_str = next_week.strftime('%m-%d')

    if current_date.month <= next_week.month:
        result = await db.execute(
            select(Contact).filter(
                func.to_char(Contact.birthday, 'MM-DD').between(current_date_str, next_week_str)
            )
        )
    else:
        # Handle the year wrap-around
        result = await db.execute(
            select(Contact).filter(
                (func.to_char(Contact.birthday, 'MM-DD').between(current_date_str, '12-31')) |
                (func.to_char(Contact.birthday, 'MM-DD').between('01-01', next_week_str))
            )
        )

    return result.scalars().all()