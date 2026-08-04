function Start-HerdrDev {
    param(
        [Parameter(Position = 0)]
        [string]$Path = "."
    )

    $cwd = (Resolve-Path -LiteralPath $Path -ErrorAction Stop).Path
    $workspaceName = (Get-Item -LiteralPath $cwd).Name
    if ([string]::IsNullOrWhiteSpace($workspaceName)) {
        $workspaceName = $cwd
    }

    $serverStatus = herdr status server 2>$null
    if (-not ($serverStatus -match 'status: running')) {
        $herdrExe = (Get-Command herdr -CommandType Application -ErrorAction Stop).Source
        Start-Process -FilePath $herdrExe -ArgumentList 'server' -WindowStyle Hidden | Out-Null

        for ($attempt = 0; $attempt -lt 50; $attempt++) {
            Start-Sleep -Milliseconds 100
            $serverStatus = herdr status server 2>$null
            if ($serverStatus -match 'status: running') { break }
        }
    }

    if (-not ($serverStatus -match 'status: running')) {
        throw "Herdr server failed to start."
    }

    $workspace = (& herdr workspace create --cwd $cwd --label $workspaceName --focus | ConvertFrom-Json)
    if ($LASTEXITCODE -ne 0 -or $null -eq $workspace.result.root_pane.pane_id) {
        throw "Herdr failed to create the workspace. Is the Herdr server running?"
    }

    $root = $workspace.result.root_pane.pane_id

    # The first API call starts Herdr's server; wait for it before renaming the tab.

    for ($attempt = 0; $attempt -lt 20; $attempt++) {
        herdr status server *> $null
        if ($LASTEXITCODE -eq 0) { break }
        Start-Sleep -Milliseconds 100
    }

    $tabs = (& herdr tab list | ConvertFrom-Json).result.tabs
    $tab = $tabs | Where-Object workspace_id -eq $workspace.result.root_pane.workspace_id | Select-Object -First 1
    if ($null -eq $tab) { throw "Herdr failed to find the new tab." }

    & herdr tab rename $tab.tab_id $workspaceName | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "Herdr failed to name the tab." }

    $right = (& herdr pane split $root --direction right --ratio 0.75 --cwd $cwd --no-focus | ConvertFrom-Json)
    if ($LASTEXITCODE -ne 0 -or $null -eq $right.result.pane.pane_id) {
        throw "Herdr failed to create the right pane."
    }

    & herdr pane split $root --direction down --ratio 0.75 --cwd $cwd --no-focus | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "Herdr failed to create the lower pane." }

    & herdr pane run $root nvim | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "Herdr failed to start nvim in the root pane." }

    & herdr pane run $right.result.pane.pane_id pi | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "Herdr failed to start pi in the right pane." }

    herdr
}
