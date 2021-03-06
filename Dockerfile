FROM python:3.7-stretch

ENV PYTHONUNBUFFERED 1

# Copy over the RDS Certificate Authority Bundle
# See https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html
COPY rds-combined-ca-bundle.pem /rds-combined-ca-bundle.pem

# Copy over chamber, which is used for reading secrets in AWS SSM Parameter Store
# See https://github.com/segmentio/chamber
COPY bin_linux/chamber /bin/chamber

RUN mkdir /sunrise

WORKDIR /sunrise

COPY requirements.txt /sunrise/

RUN pip install --no-cache-dir -r requirements.txt

COPY . /sunrise/
