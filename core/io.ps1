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

function SortAsFileSystem
{
    param (
        [List[string]] $files
    )
    
    Add-Type -TypeDefinition @'
using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
namespace NaturalSort {
    public static class NaturalSort
    {
        [DllImport("shlwapi.dll", CharSet = CharSet.Unicode)]
        public static extern int StrCmpLogicalW(string psz1, string psz2);
    }
    public class NaturalStringComparer : IComparer<string>
    {
        public int Compare(string x, string y)
        {
            return NaturalSort.StrCmpLogicalW(x.ToString(), y.ToString());
        }
    }
}
'@

    [IComparer[string]]$comparer = New-Object NaturalSort.NaturalStringComparer
    $files.Sort($comparer)
}

function TestSortAsFileSystem
{
    [List[string]] $files =  [List[string]]::new()
    $files.Add("xxx")
    $files.Add("_zzz")

    SortAsFileSystem $files
    $files
}

#TestSortAsFileSystem