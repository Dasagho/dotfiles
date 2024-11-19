function start --argument report_name
    if test -z "$report_name"
        set report_names dialserver dialcontact dialreport

        for report_name in $report_names
            docker exec -d $report_name /tmp/Run.sh

        end
    else
        docker exec -d "dial$report_name" /tmp/Run.sh
    end
end
