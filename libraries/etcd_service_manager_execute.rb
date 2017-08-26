module EtcdCookbook
  class EtcdServiceManagerExecute < EtcdServiceBase
    resource_name :etcd_service_manager_execute
    provides :etcd_service_manager, os: 'linux'

    # Start the service
    action :start do
      user 'etcd' do
        action :create
        only_if { new_resource.run_user == 'etcd' }
      end

      file logfile do
        owner new_resource.run_user
        action :create
      end

      directory new_resource.data_dir do
        owner new_resource.run_user
        action :create
      end

      Chef::Log.debug("The etcd command is #{etcd_cmd}")

      bash "start etcd #{new_resource.name}" do
        code <<-EOF
        su -c "#{etcd_cmd} >> #{logfile}" #{new_resource.run_user} 2>&1 &
        PID=$!
        sleep 0.5
        kill -0 $PID
        RET=$?
        exit $RET
        EOF
        environment 'HTTP_PROXY' => new_resource.http_proxy,
                    'HTTPS_PROXY' => new_resource.https_proxy,
                    'NO_PROXY' => new_resource.no_proxy
        not_if "ps -ef | grep -v grep | grep #{Shellwords.escape(etcd_cmd)}"
        action :run
      end

      # loop until etcd is available
      bash "etcd-wait-ready #{new_resource.name}" do
        code <<-EOF
            timeout=0
            while [ $timeout -lt 20 ];  do
              ((timeout++))
              su -c "#{etcdctl_cmd} cluster-health" #{new_resource.run_user}
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
      execute "stop etcd #{new_resource.name}" do
        command "kill `cat #{pid_file}`"
        only_if "#{etcdctl_cmd} cluster-health"
      end
    end

    action :restart do
      action_stop
      action_start
    end

    action_class do
      include EtcdHelpers::Service
    end
  end
end
