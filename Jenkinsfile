pipeline {
    agent any

    stages {
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                echo "Deploying Ceph Node Pre-reqs on: ${params.HOST}"
                 sh '''#!/usr/bin/env bash
                ssh ${params.USER_NAME}@${params.HOST} -pw ${params.USER_PASS} cat /root/test_jenkins
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        
    }
}
