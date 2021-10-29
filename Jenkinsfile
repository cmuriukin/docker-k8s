pipeline {
    agent any
    environment {
      DOCKERHUB_CREDENTIALS = credentials('cmuriuki-dockerhub')
    }
  stages {
    stage('Docker Build and Tag') {
      steps {
        sh 'docker build -t docker-k8s:latest .'
        sh 'docker tag docker-k8s cmuriukin/docker-k8s:latest'
        sh 'docker tag docker-k8s cmuriukin/docker-k8s:$BUILD_NUMBER'
      }
    }

    stage('Publish image to Docker Hub') {
      steps {
          sh  'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin '
          sh  'docker push cmuriukin/docker-k8s:latest'
          sh  'docker push cmuriukin/docker-k8s:$BUILD_NUMBER'
      }
    }
  }

     /*stage('Run Docker container on Jenkins Agent') {
      steps {
        sh 'docker run -d -p 4030:80 nikhilnidhi/nginxtest'
      }
    }
   stage('Run Docker container on remote hosts') {
      steps {
        sh 'docker -H ssh://jenkins@172.31.28.25 run -d -p 4001:80 nikhilnidhi/nginxtest' */
      }
