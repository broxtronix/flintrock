#!/bin/bash -e

spark_version="$1"
distribution="$2"

echo "Installing Spark..."
echo "  version: ${spark_version}"
echo "  distribution: ${distribution}"

file="spark-${spark_version}-bin-${distribution}.tgz"

curl --silent --remote-name "https://s3.amazonaws.com/spark-related-packages/${file}"
gzip -t "$file"

mkdir "spark"
# strip-components puts the files in the root of spark/
tar xzf "$file" -C "spark" --strip-components=1
rm "$file"

sudo mkdir "{spark_scratch_dir}"
sudo chown ec2-user:ec2-user "{spark_scratch_dir}"
