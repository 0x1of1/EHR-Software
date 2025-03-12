# This script fixes the database issue by copying tables from icehrm to 1of1group

Write-Host "Creating a dump of the icehrm database..."
docker exec icehrm_v3350os-mysql-1 sh -c "mysqldump -uroot -pIceHrmR00t icehrm > /tmp/icehrm_dump.sql"

Write-Host "Importing the dump into the 1of1group database..."
docker exec icehrm_v3350os-mysql-1 sh -c "mysql -uroot -pIceHrmR00t 1of1group < /tmp/icehrm_dump.sql"

Write-Host "Verifying tables were copied..."
docker exec icehrm_v3350os-mysql-1 mysql -uroot -pIceHrmR00t -e "SHOW TABLES FROM 1of1group;"

Write-Host "Updating company name in database..."
docker exec icehrm_v3350os-mysql-1 mysql -uroot -pIceHrmR00t -e "USE 1of1group; UPDATE CompanyStructures SET title='1of1Group', description='1of1Group Main Company' WHERE id=1;"

Write-Host "Restarting the icehrm container..."
docker restart icehrm_v3350os-icehrm-1

Write-Host "Database fix completed!"
Write-Host "Please clear your browser cache and access the application at http://localhost:9010" 