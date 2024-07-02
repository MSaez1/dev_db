from app import create_app
from db import db
from models import User, UserRoles

app = create_app()

with app.app_context():
    # Crear roles
    admin_role = UserRoles(role="admin")
    mod_role = UserRoles(role="mod")
    user_role = UserRoles(role="user")

    # Agregar roles a la sesión
    db.session.add(admin_role)
    db.session.add(mod_role)
    db.session.add(user_role)

    # Crear usuarios
    user1 = User(username="admin_user", email="admin@example.com", role=admin_role)
    user2 = User(username="mod_user", email="mod@example.com", role=mod_role)
    user3 = User(username="basic_user", email="user@example.com", role=user_role)

    # Agregar usuarios a la sesión
    db.session.add(user1)
    db.session.add(user2)
    db.session.add(user3)

    # Confirmar los cambios en la base de datos
    db.session.commit()

    print("Seed data added successfully.")
