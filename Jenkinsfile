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
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST rm -rf ~/cortx-scripts
                echo "Git clone dir removed..."
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST git clone https://github.com/pranav-sahasrabudhe/cortx-scripts
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST bash ~/cortx-scripts/prereq.sh
                '''
            }
        }
        stage('Verify') {
            steps {
                echo 'Verifying...'
                echo "Verifying Ceph Node Pre-reqs on: $TEST_HOST"
                sh '''#!/usr/bin/env bash
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST ls -ltr /home
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST ntpdate ntp.seagate.com
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST cat /etc/fstab
                // Testing if services are stopped
                sshpass -p $TEST_PASS ssh -o StrictHostKeyChecking=no $TEST_USER@$TEST_HOST echo "Verification Successful"
                '''
            }
        }
        
    }
}
