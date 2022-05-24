from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model

class Command(BaseCommand):
    

    def add_arguments(self, parser):
        parser.add_argument("--user", required=True)
        parser.add_argument("--password", required=True)
        parser.add_argument("--email", default="admin@inttic.dz")

    def handle(self, *args, **options):

        User = get_user_model()
        if User.objects.exists():
            return

        username = options["user"]
        password = options["password"]
        email = options["email"]
        name="admin"
        User.objects.create_superuser(name=name,username=username, password=password, email=email)

        self.stdout.write(f'Local user "{username}" was created')