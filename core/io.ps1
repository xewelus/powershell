using namespace System
using namespace System.IO
using namespace System.Collections.Generic
function CollectFiles {
    param (
        [string] $folder,
        [List[string]] $files = $null,
        [bool] $sort = $true
    )

    if (!$files) { $files = [List[string]]::new() }

    foreach ($dir in [Directory]::GetDirectories($folder))
    {
        CollectFiles $dir $files $false;
    }
    $files.AddRange([Directory]::GetFiles($folder));

    if ($sort) 
    {
        $files.Sort();
    }

    return $files;
}
