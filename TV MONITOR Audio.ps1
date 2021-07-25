Set-AudioDevice -Index 1

$PlayWav=New-Object System.Media.SoundPlayer
$PlayWav.SoundLocation='C:\Windows\Media\chimes.wav'
$PlayWav.playsync()