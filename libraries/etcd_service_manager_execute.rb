module EtcdCookbook
  class EtcdServiceManagerExecute < EtcdServiceBase
    resource_name :etcd_service_manager_execute
    provides :docker_service_manager, os: 'linux'

    # Start the service
    action :start do
      bash "start etcd #{name}" do
        code <<-EOF
        #{etcd_cmd} >> #{logfile} 2>&1 &
        PID=$!
        sleep 0.5
        kill -0 $PID
        RET=$?
        exit $RET
        EOF
        environment 'HTTP_PROXY' => http_proxy,
                    'HTTPS_PROXY' => https_proxy,
                    'NO_PROXY' => no_proxy
        not_if "ps -ef | grep -v grep | grep #{Shellwords.escape(etcd_cmd)}"
        action :run
      end

      # loop until etcd is available
      bash "etcd-wait-ready #{name}" do
        code <<-EOF
            timeout=0
            while [ $timeout -lt 20 ];  do
              ((timeout++))
              #{etcdctl_cmd} cluster-health
                if [ $? -eq 0 ]; then
                  break
                fi
               sleep 1
            done
            [[ $timeout -eq 20 ]] && exit 1
            exit 0
            EOF
        not_if "#{etcdctl_cmd} cluster-health"
      end
    end

    action :stop do
      execute "stop etcd #{name}" do
        command "kill `cat #{pid_file}`"
        only_if "#{etcdctl_cmd} cluster-health"
      end
    end

    action :restart do
      action_stop
      action_start
    end
  end
end
