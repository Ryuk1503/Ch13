#!/bin/bash
# Script to configure database connection at runtime

# Set default values if environment variables are not set
DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-5432}
DB_NAME=${DB_NAME:-Murach_DB}
DB_USER=${DB_USER:-emailuser}
DB_PASSWORD=${DB_PASSWORD:-123456}
PORT=${PORT:-8080}

echo "Configuring Tomcat..."
echo "  Port: ${PORT}"
echo "  Database: ${DB_HOST}:${DB_PORT}/${DB_NAME}"
echo "  User: ${DB_USER}"

# Configure Tomcat to use PORT environment variable
sed -i "s/8080/${PORT}/g" /usr/local/tomcat/conf/server.xml

# Set Java system properties for database connection
export CATALINA_OPTS="$CATALINA_OPTS -DDB_HOST=${DB_HOST}"
export CATALINA_OPTS="$CATALINA_OPTS -DDB_PORT=${DB_PORT}"
export CATALINA_OPTS="$CATALINA_OPTS -DDB_NAME=${DB_NAME}"
export CATALINA_OPTS="$CATALINA_OPTS -DDB_USER=${DB_USER}"
export CATALINA_OPTS="$CATALINA_OPTS -DDB_PASSWORD=${DB_PASSWORD}"

# Start Tomcat
exec catalina.sh run
