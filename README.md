# Framadate Docker Deployment

This repository provides a Docker-based deployment setup for Framadate, a popular online scheduling tool developed by Framasoft.

## Prerequisites

- Docker
- Git

## Installation

1. Clone this repository

   ```bash
   git clone https://github.com/surmatik/Framadate-Docker.git
   cd Framadate-Docker
   ```
2. Clone the Framadate application into the app directory
   ```bash
   git clone https://framagit.org/framasoft/framadate/framadate.git app
   ```
3. Edit the apache.conf file to set your domain under 'ServerName'.
   ```bash
   nano apache.conf

   ServerName your-domain.com
   ```
4. Build the Docker image
   ```bash
   docker-compose build
   ```
5. Start Containers
   ```bash
   docker-compose up -d
   ```

## Accessing the Web Interface
After running the above steps, you can access the Framadate web interface by navigating to your specified domain in your web browser. You'll be prompted to configure Framadate.

Database Servername: mysql:host=mysql;dbname=framadate;port=3306