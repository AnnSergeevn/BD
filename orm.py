import sqlalchemy
import sqlalchemy as sq
from sqlalchemy.orm import declarative_base, relationship, sessionmaker

Base = declarative_base()

class PUBLISHER(Base):
    __tablename__ = "publisher"

    id = sq.Column(sq.Integer, primary_key=True)
    name = sq.Column(sq.String(length=40), unique=True)

    # homeworks = relationship("Homework", back_populates="course")

class BOOK(Base):
    __tablename__ = "book"

    id = sq.Column(sq.Integer, primary_key=True)
    title = sq.Column(sq.String(length=40), unique=True)
    publisher_id = sq.Column(sq.Integer, sq.ForeignKey("publisher.id"), nullable=False)

    # course = relationship(Course, back_populates="homeworks")
    publisher = relationship(PUBLISHER, backref="book")


class SHOP(Base):
    __tablename__ = "shop"

    id = sq.Column(sq.Integer, primary_key=True)
    name = sq.Column(sq.String(length=40), unique=True)

class Stock(Base):
    __tablename__ = "stock"

    id = sq.Column(sq.Integer, primary_key=True)
    book_id = sq.Column(sq.Integer, sq.ForeignKey("book.id"), nullable=False)
    shop_id = sq.Column(sq.Integer, sq.ForeignKey("shop.id"), nullable=False)
    number = sq.Column(sq.Integer, nullable=False)


    # course = relationship(Course, back_populates="homeworks")
    book = relationship(BOOK, backref="stock")
    shop = relationship(SHOP, backref="stock")

class Sale(Base):
    __tablename__ = "sale"

    id = sq.Column(sq.Integer, primary_key=True)
    price = sq.Column(sq.Integer, nullable=False)
    date_sale = sq.Column(sq.DateTime, nullable=False)

    stock_id = sq.Column(sq.Integer, sq.ForeignKey("stock.id"), nullable=False)
    count = sq.Column(sq.Integer, nullable=False)


    # course = relationship(Course, back_populates="homeworks")
    stock = relationship(Stock, backref="sale")



def create_tables(engine):
    # Base.metadata.drop_all(engine)
    Base.metadata.create_all(engine)


def creation_obj():
    # создание объектов
    pub_name = PUBLISHER(name="Онегин")
    print(pub_name.id)
    book1 = BOOK(title="Капитанская дочка", publisher=pub_name)
    book2 = BOOK(title="Руслан и Людмила ", publisher=pub_name)
    book3 = BOOK(title="Евгений Онегин ", publisher=pub_name)

    session.add(pub_name)
    print(pub_name.id)
    session.add_all([book1, book2, book3])
    session.commit()  # фиксируем изменения
    print(pub_name.id)

    shop_name = SHOP(name="Буквоед")
    print(shop_name.id)
    stock1 = Stock(id=1, book = book1, shop= shop_name, number=600)
    stock2 = Stock(id=2, book = book2, shop=shop_name, number=500)

    session.add(shop_name)
    print(shop_name.id)
    session.add_all([stock1, stock2])
    session.commit()  # фиксируем изменения
    print(shop_name.id)

    shop_name = SHOP(name="Лабиринт")
    print(shop_name.id)
    stock3 = Stock(id=3, book = book1, shop= shop_name, number=580)
    session.add(shop_name)
    print(shop_name.id)
    session.add_all([stock3])
    session.commit()  # фиксируем изменения
    print(shop_name.id)

    shop_name = SHOP(name="Кижный дом")
    print(shop_name.id)
    stock4 = Stock(id=4, book = book3, shop= shop_name, number=490)
    session.add(shop_name)
    print(shop_name.id)
    session.add_all([stock4])
    session.commit()  # фиксируем изменения
    print(shop_name.id)

    sale1 = Sale(id=1, price=600, date_sale= '2022-11-09', stock_id = 1, count=3)
    sale2 = Sale(id=2, price=500, date_sale='2022.11.08', stock_id = 2, count=3)
    sale3 = Sale(id=3, price=580, date_sale='2022.11.05', stock_id=3, count=3)
    sale4 = Sale(id=4, price=490, date_sale='2022.11.02', stock_id=4, count=3)
    sale5 = Sale(id=5, price=600, date_sale='2022.10.26', stock_id=1, count=3)

    session.add_all([sale1, sale2, sale3, sale4,sale5])

def del_obj():

    # удаление объектов
    session.query(Sale).delete()
    session.commit()  # фиксируем изменения

    session.query(Stock).delete()
    session.commit()  # фиксируем изменения
    session.query(SHOP).delete()
    session.commit()  # фиксируем изменения
    session.query(BOOK).delete()
    session.commit()  # фиксируем изменения
    session.query(PUBLISHER).delete()
    session.commit()  # фиксируем изменения


def search_info():
    publisher_input = input("Введите имя или идентификатор издателя: ")


    try:
        publisher_id = int(publisher_input)
        publisher = (
            Session().query(PUBLISHER).filter(PUBLISHER.id == publisher_id).first()
        )
    except ValueError:
        publisher = (
            Session().query(PUBLISHER).filter(PUBLISHER.name == publisher_input).first()
        )

    if publisher is None:
        print("Издатель не найден")
    else:
        sales = (
            Session()
            .query(Sale)
            .join(Stock)
            .join(SHOP)
            .join(BOOK)
            .join(PUBLISHER)
            .filter(PUBLISHER.id == publisher.id)
            .order_by(Sale.date_sale)
            .all()
        )

        for sale in sales:
            print(
                f"{sale.stock.book.title} | {sale.stock.shop.name} | {sale.price} | {sale.date_sale}"
            )

        print(f"Найдено {len(sales)} продаж для издателя {publisher.name}")





if __name__ == "__main__":
    DSN = "postgresql://postgres:netology@localhost:5432/netology_bd"
    engine = sqlalchemy.create_engine(DSN)
    create_tables(engine)

    # сессия
    Session = sessionmaker(bind=engine)
    session = Session()
    #creation_obj()
    #del_obj()

    search_info()



    session.commit()  # фиксируем изменения

    session.close()