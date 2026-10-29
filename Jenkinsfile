pipeline {
    agent any
    tools {
        // 这里的 'JDK17' 要和你Jenkins全局工具配置里的JDK安装名称完全一致
        jdk 'JDK17'
        // 如果用Maven构建，这里指定你配置的Maven工具名，比如 'Maven3'
        maven 'Maven-3.10.0'
    }
    environment {
        // 指定构建产物输出目录，也可以自定义
        BUILD_OUTPUT_DIR = 'target'
    }
    stages {
        stage('拉取代码') {
            steps {
                checkout scm
                echo "成功拉取 messaging-redis 项目最新代码"
            }
        }
        stage('清理构建环境') {
            steps {
                sh 'mvn clean'
                // Windows 环境下把上面的 sh 替换成 bat，即 bat 'mvn clean'
            }
        }
        stage('执行项目打包') {
            steps {
                sh 'mvn package -Dmaven.test.skip=true'
                // 跳过单元测试执行打包，如果需要执行测试去掉-Dmaven.test.skip=true即可
            }
        }
        stage('归档构建产物') {
            steps {
                archiveArtifacts artifacts: "${BUILD_OUTPUT_DIR}/*.jar", fingerprint: true
                echo "打包完成，Jar包已归档到Jenkins任务产物中,cheer!"
            }
        }
    }
    post {
        success {
            echo "messaging-redis 项目 Pipeline 打包全部流程执行成功"
        }
        failure {
            echo "打包流程执行失败，请查看日志排查问题"
        }
    }
}
