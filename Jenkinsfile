pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        bat 'echo "Build stage"'
      }
    }
    stage('Test') {
      steps {
        powershell(script: 'get-service', returnStatus: true)
      }
    }
  }
}