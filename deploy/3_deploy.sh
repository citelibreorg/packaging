#!/bin/bash
mvn -e bundlebee:apply@k8s -Pbundlebee
minikube dashboard