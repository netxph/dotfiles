function Start-HerderDev {
    param(
        [Parameter(Position = 0)]
        [string]$Path = "."
    )

    $cwd = (Resolve-Path -LiteralPath $Path -ErrorAction Stop).Path

    $workspace = (& herdr workspace create --cwd $cwd --label dev --focus | ConvertFrom-Json)
    $root = $workspace.result.root_pane.pane_id

    & herdr pane split $root --direction right --ratio 0.75 --cwd $cwd --no-focus | Out-Null

    & herdr pane split $root --direction down --ratio 0.75 --cwd $cwd --no-focus | Out-Null

    herdr
}
