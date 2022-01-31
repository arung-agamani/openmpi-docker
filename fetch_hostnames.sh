#!/bin/bash

# Use this script for fetching IPs of other containers and put it to a file
dig +short mpi_node >> mpi_hostname
echo "Hostnames configured"