from flask import Blueprint, jsonify, request
from db import db
from models import User, UserRoles
from schemas import UserSchema, UserRolesSchema

bp = Blueprint("main", __name__)

user_schema = UserSchema()
users_schema = UserSchema(many=True)
role_schema = UserRolesSchema()
roles_schema = UserRolesSchema(many=True)


@bp.route("/users", methods=["POST"])
def add_user():
    username = request.json["username"]
    email = request.json["email"]
    role_id = request.json["role_id"]
    new_user = User(username=username, email=email, role_id=role_id)
    db.session.add(new_user)
    db.session.commit()
    return user_schema.jsonify(new_user)


@bp.route("/users", methods=["GET"])
def get_users():
    users = User.query.all()
    return users_schema.jsonify(users)


@bp.route("/roles", methods=["POST"])
def add_role():
    role = request.json["role"]
    new_role = UserRoles(role=role)
    db.session.add(new_role)
    db.session.commit()
    return role_schema.jsonify(new_role)


@bp.route("/roles", methods=["GET"])
def get_roles():
    roles = UserRoles.query.all()
    return roles_schema.jsonify(roles)
