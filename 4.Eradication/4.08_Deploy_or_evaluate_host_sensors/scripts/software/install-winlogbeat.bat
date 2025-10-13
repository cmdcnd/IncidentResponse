c:\SoftwareTools\winlogbeat.msi /q
copy c:\SoftwareTools\winlogbeat.yml C:\ProgramData\Elastic\Beats\winlogbeat\
net start "winlogbeat"
