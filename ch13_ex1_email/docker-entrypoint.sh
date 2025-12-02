#!/bin/bash
# Script to substitute environment variables in persistence.xml at runtime

# Set default values if environment variables are not set
DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-5432}
DB_NAME=${DB_NAME:-Murach_DB}
DB_USER=${DB_USER:-emailuser}
DB_PASSWORD=${DB_PASSWORD:-123456}

# Path to persistence.xml
PERSISTENCE_XML="/usr/local/tomcat/webapps/ROOT/WEB-INF/classes/META-INF/persistence.xml"

# Wait for the WAR to be deployed
while [ ! -f "$PERSISTENCE_XML" ]; do
    echo "Waiting for WAR deployment..."
    sleep 2
done

# Update persistence.xml with environment variables
sed -i "s|localhost:5432/Murach_DB|${DB_HOST}:${DB_PORT}/${DB_NAME}|g" "$PERSISTENCE_XML"
sed -i "s|<property name=\"jakarta.persistence.jdbc.user\" value=\"emailuser\"/>|<property name=\"jakarta.persistence.jdbc.user\" value=\"${DB_USER}\"/>|g" "$PERSISTENCE_XML"
sed -i "s|<property name=\"jakarta.persistence.jdbc.password\" value=\"123456\"/>|<property name=\"jakarta.persistence.jdbc.password\" value=\"${DB_PASSWORD}\"/>|g" "$PERSISTENCE_XML"

echo "Database configuration updated:"
echo "  Host: ${DB_HOST}:${DB_PORT}"
echo "  Database: ${DB_NAME}"
echo "  User: ${DB_USER}"

# Start Tomcat
exec catalina.sh run
