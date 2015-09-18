call C:\vmcloak\settings.bat

echo Setting static IPv4 address.
netsh interface ip set address name="Local Area Connection" ^
    static %GUEST_IP% %GUEST_MASK% %GUEST_GATEWAY% 1

echo Installing Python 2.7.6.
start C:\vmcloak\python-2.7.6.msi
C:\vmcloak\click.exe "Python 2.7.6 Setup" "Next >"
C:\vmcloak\click.exe "Python 2.7.6 Setup" "Next >"
C:\vmcloak\click.exe "Python 2.7.6 Setup" "Next >"
C:\vmcloak\click.exe "Python 2.7.6 Setup" "Finish"

cd C:\vmcloak

echo Installing setuptools 18.3.1.
C:\Python27\Python.exe -c "import tarfile ; tarfile.open('setuptools-18.3.1.tar.gz').extractall()"
cd setuptools-18.3.1
C:\Python27\Python.exe setup.py install
cd ..

echo Installing itsdangerous 0.24.
C:\Python27\Python.exe -c "import tarfile ; tarfile.open('itsdangerous-0.24.tar.gz').extractall()"
cd itsdangerous-0.24
C:\Python27\Python.exe setup.py install
cd ..

echo Installing MarkupSafe 0.23.
C:\Python27\Python.exe -c "import tarfile ; tarfile.open('MarkupSafe-0.23.tar.gz').extractall()"
cd MarkupSafe-0.23
C:\Python27\Python.exe setup.py install
cd ..

echo Installing Jinja2 2.8.
C:\Python27\Python.exe -c "import tarfile ; tarfile.open('Jinja2-2.8.tar.gz').extractall()"
cd C:\vmcloak\Jinja2-2.8
C:\Python27\Python.exe setup.py install
cd ..

echo Installing Werkzeug 0.10.4.
C:\Python27\Python.exe -c "import tarfile ; tarfile.open('Werkzeug-0.10.4.tar.gz').extractall()"
cd Werkzeug-0.10.4
C:\Python27\Python.exe setup.py install
cd ..

echo Installing Flask 0.10.1.
C:\Python27\Python.exe -c "import tarfile ; tarfile.open('Flask-0.10.1.tar.gz').extractall()"
cd Flask-0.10.1
C:\Python27\Python.exe setup.py install
cd ..

echo Installing the Agent.
copy C:\vmcloak\agent.py C:\agent.py
if "%DEBUG%" == "yes" (
    set PYTHON=C:\Python27\Pythonw.exe
)
else (
    set PYTHON=C:\Python27\Python.exe
)

reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Run /v Agent /t REG_SZ /d "%PYTHON% C:\agent.py 0.0.0.0 %AGENT_PORT%"

echo Removing VMCloak files.
cd C:\
rem rmdir /S /Q C:\vmcloak

echo Shutting down.
shutdown -s -t 0
