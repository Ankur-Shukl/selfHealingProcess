<p>
This is a generic self-heal process which can be used to track and heal any process.
To track multiple processes, launch multiple instances of this script.</p>
This can be launched like this </p>
<b>
setsid selfHealProcess.sh process-name identifier "command to restart process"  > ./selfHealProcess.log 2>&1 < /dev/null &
</b>

