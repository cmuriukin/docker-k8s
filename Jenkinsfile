
pipeline {
    environment {
        registry = 'cmuriukin/docker-k8s'

        registryCredential = 'GIT_HUB_CREDENTIALS'

        dockerImage = ''
    }

    agent any

    stages {
        stage('Cloning our Git') {
      steps {
        git credentialsId: 'GIT_HUB_CREDENTIALS', url: 'https://github.com/cmuriukin/docker-k8s.git', branch: 'main'
      }
        }

        stage('Building our image') {
      steps {
        script {
          /*dockerImage = docker.build registry + ":$BUILD_NUMBER" */
          sh 'docker build -t devops-k8s:latest . '
        }
      }
        }

        stage('Deploy our image') {
      steps {
        script {
          /* groovylint-disable-next-line NestedBlockDepth 
          /docker.withRegistry( '', registryCredential ) {
            dockerImage.push() */
          /* groovylint-disable-next-line NestedBlockDepth */
          withCredentials([string(credentialsId: 'DOCKER_HUB_PASSWORD', variable: 'dockerhubpwd')]) {
            /* groovylint-disable-next-line GStringExpressionWithinString */
            sh 'docker login -u cmuriukin -p ${dockerhubpwd}'
          }
            sh 'docker push devops-k8s:latest'
          }
        }
      }

        stage('Cleaning up') {
      steps {
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
        }
        }
    }

