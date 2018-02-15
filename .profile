sed -i "/^\[webserver\]/ a port = \":$PORT\"" config.toml

sed -i "/^type = \"postgis\"/ a password = \"$(echo $VCAP_SERVICES | jq -c -r '.["aws-rds-postgres"] | .[0].credentials.password')\"" config.toml
sed -i "/^type = \"postgis\"/ a user = \"$(echo $VCAP_SERVICES | jq -c -r '.["aws-rds-postgres"] | .[0].credentials.username')\"" config.toml
sed -i "/^type = \"postgis\"/ a database = \"$(echo $VCAP_SERVICES | jq -c -r '.["aws-rds-postgres"] | .[0].credentials.database')\"" config.toml
sed -i "/^type = \"postgis\"/ a port = $(echo $VCAP_SERVICES | jq -c -r '.["aws-rds-postgres"] | .[0].credentials.port')" config.toml
sed -i "/^type = \"postgis\"/ a host = \"$(echo $VCAP_SERVICES | jq -c -r '.["aws-rds-postgres"] | .[0].credentials.hostname')\"" config.toml


sed -i "/^type = \"s3\"/ a aws_secret_access_key = \"$(echo $VCAP_SERVICES | jq -c -r '.["aws-s3"] | .[0].credentials.secret_access_key')\"" config.toml
sed -i "/^type = \"s3\"/ a aws_access_key_id = \"$(echo $VCAP_SERVICES | jq -c -r '.["aws-s3"] | .[0].credentials.access_key_id')\"" config.toml
sed -i "/^type = \"s3\"/ a bucket = \"$(echo $VCAP_SERVICES | jq -c -r '.["aws-s3"] | .[0].credentials.bucket')\"" config.toml
sed -i "/^type = \"s3\"/ a region = \"$(echo $VCAP_SERVICES | jq -c -r '.["aws-s3"] | .[0].credentials.region')\"" config.toml
