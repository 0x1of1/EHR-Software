docker cp nginx.conf icehrm_v3350os-icehrm-1:/etc/nginx/http.d/default.conf
docker exec icehrm_v3350os-icehrm-1 nginx -s reload 