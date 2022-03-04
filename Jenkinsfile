pipeline {
    agent any

    stages {
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                echo "Deploying Ceph Node Pre-reqs on: ${params.HOST}"
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        
    }
}
