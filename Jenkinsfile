pipeline {
  agent any
  environment {
    IMAGE_NAME = "idan2025/hello-node"
  }
  stages {
    stage('Code Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/idan2025/Nodejs_Repo.git'
      }
    }
    stage('Docker Build & Tag') {
      steps {
        sh '''
          docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .
          docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest
        '''
      }
    }
    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub-credentials',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker push ${IMAGE_NAME}:${BUILD_NUMBER}
            docker push ${IMAGE_NAME}:latest
          '''
        }
      }
    }
    stage('Docker Run') {
      steps {
        sh '''
          docker rm -f hello-node || true
          docker pull ${IMAGE_NAME}:latest
          docker run -d --name hello-node -p 5000:5000 ${IMAGE_NAME}:latest
        '''
      }
    }
  }
}
