using namespace System
using namespace System.IO
using namespace System.Collections.Generic
using namespace System.Xml

class Utf8StringWriter : StringWriter {
    [System.Text.Encoding] get_Encoding()
    {
        return [System.Text.Encoding]::UTF8;
    }
}
function XmlToString
{
    param ( [XmlNode] $node )

    [StringWriter] $sw = [Utf8StringWriter]::new()
    [XmlTextWriter] $xtw = [XmlTextWriter]::new($sw)
    $xtw.Formatting = [Formatting]::Indented
    $node.WriteTo($xtw);
    $result = $sw.ToString()
    $xtw.Dispose()
    $sw.Dispose()
    return $result
}