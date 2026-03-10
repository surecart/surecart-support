@echo off
echo Updating SureCart Support...
cd /d "%~dp0"
git pull --ff-only 2>nul
for %%r in (surecart-wp surecart surecart-docs surecart-support.wiki) do (
    cd /d "%~dp0.repos\%%r" 2>nul && git pull --ff-only 2>nul
)
cd /d "%~dp0"
echo Ready!
echo.
claude --add-dir "%~dp0.repos\surecart-wp" --add-dir "%~dp0.repos\surecart" --add-dir "%~dp0.repos\surecart-docs" --add-dir "%~dp0.repos\surecart-support.wiki"
