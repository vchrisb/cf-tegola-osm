sed -i "/\[webserver\]/,/^$/ s/port = .*/port = \":$PORT\"/" config.toml

sed -i "/\[cache\]/,/^$/ s/aws_secret_access_key = .*/aws_secret_access_key = \"$(echo $VCAP_SERVICES | jq -c -r '.["aws-s3"] | .[0].credentials.secret_access_key' | sed 's;/;\\/;g')\"/" config.toml
sed -i "/\[cache\]/,/^$/ s/aws_access_key_id = .*/aws_access_key_id = \"$(echo $VCAP_SERVICES | jq -c -r '.["aws-s3"] | .[0].credentials.access_key_id')\"/" config.toml
sed -i "/\[cache\]/,/^$/ s/bucket = .*/bucket = \"$(echo $VCAP_SERVICES | jq -c -r '.["aws-s3"] | .[0].credentials.bucket')\"/" config.toml
sed -i "/\[cache\]/,/^$/ s/region = .*/region = \"$(echo $VCAP_SERVICES | jq -c -r '.["aws-s3"] | .[0].credentials.region')\"/" config.toml

export DB_PORT=$(echo $VCAP_SERVICES | jq -c -r '.["aws-rds-postgres"] | .[0].credentials.port')
export DB_HOST=$(echo $VCAP_SERVICES | jq -c -r '.["aws-rds-postgres"] | .[0].credentials.hostname')
export DB_NAME=$(echo $VCAP_SERVICES | jq -c -r '.["aws-rds-postgres"] | .[0].credentials.database')
export DB_USER=$(echo $VCAP_SERVICES | jq -c -r '.["aws-rds-postgres"] | .[0].credentials.username')
export DB_PW=$(echo $VCAP_SERVICES | jq -c -r '.["aws-rds-postgres"] | .[0].credentials.password')

sed -i "/\[\[providers\]\]/,/^$/ s/host = .*/host = \"$DB_HOST\"/" config.toml
sed -i "/\[\[providers\]\]/,/^$/ s/port = .*/port = $DB_PORT/" config.toml
sed -i "/\[\[providers\]\]/,/^$/ s/database = .*/database = \"$DB_NAME\"/" config.toml
sed -i "/\[\[providers\]\]/,/^$/ s/user = .*/user = \"$DB_USER\"/" config.toml
sed -i "/\[\[providers\]\]/,/^$/ s/password = .*/password = \"$DB_PW\"/" config.toml

# update environment for import tools
export PATH="/home/vcap/deps/0/apt/usr/lib/postgresql/9.3/bin:$PATH"
export GDAL_DATA="/home/vcap/deps/0/apt/usr/share/gdal/2.1/"
