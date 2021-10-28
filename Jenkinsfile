
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
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push() */
          /* groovylint-disable-next-line NestedBlockDepth 
            sh withCredentials([string(credentialsId: 'DOCKER_HUB_PASSWORD', variable: 'dockerhubpwd')]) {
             groovylint-disable-next-line GStringExpressionWithinString 
            sh 'docker login -u cmuriukin -p ${dockerhubpwd}'
            }
            sh 'docker push devops-k8s:latest' */
            script {
                    // CUSTOM REGISTRY
                    docker.withRegistry('https://hub.docker.com/') {

                        /* Build the container image */
                        def dockerImage = docker.build("docker-k8s:${env.BUILD_ID}")

                        /* Push the container to the custom Registry */
                        dockerImage.push()

                    }
                    /* Remove docker image
                    sh 'docker rmi -f my-image:${env.BUILD_ID}'   */
            }


          }
        }
      }

          stage('SSH Into k8s Server') {
            steps {
        def remote = [:]
        remote.name = 'minikube'
        remote.host = '172.31.81.192'
        remote.user = 'ubuntu'
        remote.password = '#andela123'
        remote.allowAnyHosts = true

        stage('Put pod-from-inside.yaml onto k8smaster') {
            sshPut remote: remote, from: 'pod-from-inside.yaml', into: '.'
        }

        stage('Deploy pod-from-inside.yaml') {
          sshCommand remote: remote, command: "kubectl apply -f pod-from-inside.yaml"
        }
            }
      
        stage('Cleaning up') {
      steps {
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
        }
          }
        }

