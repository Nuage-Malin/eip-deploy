job("Kubernetes cluster") {
    keepDependencies(true)
    triggers {
        hudsonStartupTrigger {
            nodeParameterName("")
            label("")
            quietPeriod("0")
            runOnChoice("False")
        }
    }
    steps {
        shell('kind create cluster --name nuage-malin --config=/app/kubernetes/cluster.yml')
    }
}

folder("Production") {
    description("Production builds");
}
job("Production/Front") {
    blockOn("Kubernetes cluster") {
        blockLevel('GLOBAL')
        scanQueueFor('ALL')
    }
    scm {
        git {
            remote {
                github("$GIT_REPOSITORY_URL_FRONT", 'ssh')
                credentials('eip_front_production')
                branch("main")
            }
        }
    }
    triggers {
        pollSCM {
            scmpoll_spec('* * * * *')
        }
    }
    steps {
        shell('/app/builders/front.sh')
    }
}
job("Production/Back") {
    blockOn("Kubernetes cluster") {
        blockLevel('GLOBAL')
        scanQueueFor('ALL')
    }
    scm {
        git {
            remote {
                github("$GIT_REPOSITORY_URL_BACK", 'ssh')
                credentials('eip_back_production')
                branch("main")
            }
        }
    }
    triggers {
        pollSCM {
            scmpoll_spec('* * * * *')
        }
    }
    steps {
        shell('/app/builders/back.sh')
    }
}