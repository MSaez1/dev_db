from flask_marshmallow import Marshmallow
from models import User, UserRoles
from db import db

ma = Marshmallow()


class UserRolesSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = UserRoles
        load_instance = True


class UserSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = User
        load_instance = True

    role = ma.Nested(UserRolesSchema)
