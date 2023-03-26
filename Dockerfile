# FROM python:3.10

# WORKDIR /app

# COPY WEB .

# RUN pip install -r requirements.txt 

# EXPOSE 80

# ENTRYPOINT python manage.py runserver 0.0.0.0:80

FROM python:3.10

# Establecer variables de entorno
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiar el directorio de la aplicación al contenedor
COPY sitioindicadores .

# Instalar dependencias de la aplicación
RUN pip install -r requirements.txt 

# Copiar el archivo de configuración de Nginx
COPY nginx.conf /etc/nginx/sites-available/default


RUN python manage.py collectstatic --noinput && python manage.py makemigrations && python manage.py migrate
RUN echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'admin123')"

# Exponer los puertos
EXPOSE 80

# Comando de inicio para Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:80", "sitioindicadores.wsgi:application"]
