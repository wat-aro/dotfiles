function dcr --description 'Execute `docker-compose run --rm APP_NAME`'
    docker-compose run --rm $APP_NAME $argv
end
