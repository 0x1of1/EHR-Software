# This script rebuilds and restarts the 1of1Group application with the new branding

Write-Host "Stopping all containers..."
docker compose down

Write-Host "Rebuilding the 1of1Group container..."
docker compose build icehrm

Write-Host "Starting all containers..."
docker compose up -d

Write-Host "Renaming the database..."
docker exec icehrm_v3350os-mysql-1 mysql -uroot -pIceHrmR00t -e "CREATE DATABASE IF NOT EXISTS 1of1group;"
docker exec icehrm_v3350os-mysql-1 mysql -uroot -pIceHrmR00t -e "SET GLOBAL sql_mode=''; SET SESSION sql_mode='';"
docker exec icehrm_v3350os-mysql-1 sh -c "mysqldump -uroot -pIceHrmR00t icehrm > /tmp/icehrm_dump.sql"
docker exec icehrm_v3350os-mysql-1 sh -c "mysql -uroot -pIceHrmR00t 1of1group < /tmp/icehrm_dump.sql"

Write-Host "Updating company name in database..."
docker exec icehrm_v3350os-mysql-1 mysql -uroot -pIceHrmR00t -e "USE 1of1group; UPDATE CompanyStructures SET title='1of1Group', description='1of1Group Main Company' WHERE id=1;"

Write-Host "1of1Group has been successfully rebranded and restarted!"
Write-Host "Please clear your browser cache and access the application at http://localhost:9010" 