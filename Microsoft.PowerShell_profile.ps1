# -----------------------------------------------------------------------------
# Imports
# -----------------------------------------------------------------------------
Import-Module $HOME\scoop\apps\posh-git\current\posh-git.psd1

# -----------------------------------------------------------------------------
# Env Variables
# -----------------------------------------------------------------------------
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1

# -----------------------------------------------------------------------------
# Wezterm > oh-my-posh
# -----------------------------------------------------------------------------
function Set-EnvVar
{
  $p = $executionContext.SessionState.Path.CurrentLocation
  $osc7 = ""
  if ($p.Provider.Name -eq "FileSystem")
  {
    $ansi_escape = [char]27
    $provider_path = $p.ProviderPath -Replace "\\", "/"
    $osc7 = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}${ansi_escape}\"
  }
  $env:OSC7=$osc7
}
New-Alias -Name 'Set-PoshContext' -Value 'Set-EnvVar' -Scope Global -Force

# -----------------------------------------------------------------------------
# Initialize plugins
# -----------------------------------------------------------------------------
oh-my-posh init pwsh --config ~/.oh-my-posh.json | Invoke-Expression
Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
