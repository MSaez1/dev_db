from db import db


class UserRoles(db.Model):
    __tablename__ = "user_roles"
    id = db.Column(db.Integer, primary_key=True)
    role = db.Column(db.String(80), unique=True, nullable=False)

    def __repr__(self):
        return f"<UserRoles {self.role}>"


class User(db.Model):
    __tablename__ = "users"
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    role_id = db.Column(db.Integer, db.ForeignKey("user_roles.id"), nullable=False)
    role = db.relationship("UserRoles", backref=db.backref("users", lazy=True))

    def __repr__(self):
        return f"<User {self.username}>"
