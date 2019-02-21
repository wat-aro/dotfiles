function dce --description 'Execute `docker-compose exec CONTAINER`'
    docker-compose exec $APP_NAME $argv
end
