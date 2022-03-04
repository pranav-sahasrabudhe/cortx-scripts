pipeline {
    agent any
    environment {
        TEST_HOST = "${params.HOST}"
        TEST_USER = "${params.USER_NAME}"
        TEST_PASS = "${params.USER_PASS}"
    }

    stages {
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                echo "Deploying Ceph Node Pre-reqs on: $TEST_HOST"
                sh '''#!/usr/bin/env bash
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST cat /root/test_jenkins 
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
