pipeline {
    agent any
   
    environment {
      DOCKERHUB_CREDENTIALS = credentials('cmuriuki-dockerhub')
    }
  stages {
    stage('Cloning our Git') {
        steps {
          git credentialsId: 'GIT_HUB_CREDENTIALS', url: 'https://github.com/cmuriukin/docker-k8s.git', branch: 'main'
        }
    }
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
    stage('Deploy to k8s') {
      steps {
        sshagent(['k8s']) {
          sh 'ssh StrictHostKeyChecking=no ubuntu@35.170.200.117 kubectl apply -f pod-from-inside.yaml'
        }
      }
    }
  }
}
