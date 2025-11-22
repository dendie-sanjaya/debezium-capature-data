# Debezium: Simple Change Data Capture for Everyone

In the past, keeping data in sync between databases and other systems was hard. Companies often built custom scripts or used slow batch jobs. This made data out of date and hard to manage. Debezium was created to solve this problem. It is an open-source project started by Red Hat, designed to make Change Data Capture (CDC) easy, fast, and reliable for everyone. Now, with Debezium, you can stream every change in your database to other systems in real-time.

Debezium has grown to support many databases and is used by companies around the world to build modern, event-driven systems. With Debezium, you can keep your data fresh and consistent everywhere, and react to changes as they happen.

---

## Table of Contents
- [Debezium: Simple Change Data Capture for Everyone](#debezium-simple-change-data-capture-for-everyone)
  - [Table of Contents](#table-of-contents)
  - [About Debezium](#about-debezium)
  - [Dependency Preparation](#dependency-preparation)
  - [Debezium with Docker](#debezium-with-docker)
  - [Workflow \& Diagram](#workflow--diagram)
  - [Step-by-Step  Deployment \& Config](#step-by-step--deployment--config)
    - [1. Starting Docker Services](#1-starting-docker-services)
    - [2. Checking Kafka and Kafdrop](#2-checking-kafka-and-kafdrop)
    - [3. PostgreSQL Setup](#3-postgresql-setup)
    - [4. Debezium Connector Configuration](#4-debezium-connector-configuration)

---

## About Debezium

Debezium is a tool for Change Data Capture (CDC). It watches your database for changes (add, update, delete) and sends those changes to other systems, like Kafka, in real-time. Debezium supports many databases, including PostgreSQL, MySQL, and Another. It helps you build systems that react to data changes, keep data correct, and make business faster.

---

## Dependency Preparation

Before running Debezium, you need:
- **Docker & Docker Compose** installed on your machine.
- **Kafka** and **Zookeeper** running (can be started with Docker Compose).
- **PostgreSQL** database with logical replication enabled (`wal_level=logical`).
- A user in PostgreSQL with REPLICATION privilege (see `init-replication-user.sql`).

---

## Debezium with Docker

You can run Debezium and all dependencies using Docker Compose. See the provided `docker-compose.yml` file for a ready-to-use setup. This will start:
- Zookeeper
- Kafka (with auto-create topics enabled)
- PostgreSQL (with sample data and replication user)
- Debezium Connect
- Kafdrop (for monitoring Kafka topics)

To start everything, run:
```sh
docker-compose up
```

The PostgreSQL container will automatically run the script in `init-replication-user.sql` to create the database, table, sample data, and replication user.

---

## Workflow & Diagram

The workflow of Debezium is simple:
1. PostgreSQL records a change in its log.
2. Debezium Connect reads the change and sends it to Kafka.
3. Other systems can read the change from Kafka and update themselves.

![Debezium Architecture Diagram](design/diagram.png)

---

## Step-by-Step  Deployment & Config 

Below are  showing each step of the Debezium setup and usage, with explanations for each step:

### 1. Starting Docker Services
- **docker.png:** Shows the Docker Desktop or Docker Engine running, which is needed to start all containers.
  ![Docker Services](ss/docker.png)
- **docker-run-service.png:** Shows the command `docker-compose up` being run in the terminal. This command starts all services: Zookeeper, Kafka, PostgreSQL, Debezium Connect, and Kafdrop.
  ![Docker Run Service](ss/docker-run-service.png)

### 2. Checking Kafka and Kafdrop
- **images-kafka.png:** Shows Kafka service running and ready to accept connections.
  ![Kafka](ss/images-kafka.png)
- **images-kafka-2.png:** Shows Kafka topics, including those automatically created for Debezium events.
  ![Kafka Topics](ss/images-kafka-2.png)
- **images-kafdrop.png:** Shows the Kafdrop web UI, which lets you browse Kafka topics and see messages in real time.
  ![Kafdrop UI](ss/images-kafdrop.png)

### 3. PostgreSQL Setup
- **images-postgres.png:** Shows PostgreSQL service running, ready for connections.
  ![Postgres Setup](ss/images-postgres.png)
- **postgres-1.png:** Shows the initial database setup, including the creation of the `inventory` database.
  ![Postgres Step 1](ss/postgres-1.png)
- **postgres-2.png:** Shows the creation of the `products` table and insertion of sample data.
  ![Postgres Step 2](ss/postgres-2.png)
- **postgres-3.png:** Shows the creation of the replication user with the required privileges.
  ![Postgres Step 3](ss/postgres-3.png)
- **postgres-4.png:** Shows the logical replication settings (`wal_level=logical`, etc.) applied to PostgreSQL.
  ![Postgres Step 4](ss/postgres-4.png)
- **postgres-5.png:** Shows a successful connection from Debezium to PostgreSQL, ready to capture changes.
  ![Postgres Step 5](ss/postgres-5.png)

### 4. Debezium Connector Configuration
- **debezium-api.png:** Shows the Debezium Connect REST API, where you configure the connector to monitor PostgreSQL.
  ![Debezium API](ss/debezium-api.png)
- **debezium-api-2.png:** Shows the connector configuration details, such as database host, user, and table list.
  ![Debezium API Step 2](ss/debezium-api-2.png)
- **debezium-api-3.png:** Shows the connector being created and activated.
  ![Debezium API Step 3](ss/debezium-api-3.png)
- **debezium-4.png:** Shows the connector running and capturing changes from PostgreSQL.
  ![Debezium Step 4](ss/debezium-4.png)
- **debezium-5.png:** Shows change events being sent to Kafka topics.
  ![Debezium Step 5](ss/debezium-5.png)
- **images-debezium.png:** Shows the overall Debezium setup, including connectors and their status.
  ![Debezium Images](ss/images-debezium.png)

---

