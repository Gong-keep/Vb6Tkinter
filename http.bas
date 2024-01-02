Attribute VB_Name = "http"
Option Explicit
'���������ȡ��Ϣ����Ҫ���� "Microsoft WinHTTP Services, version 5.1"

'������sUrl��URL
'������postData��post����(���ΪPOST)
'������method��������Ϊ"POST"��"GET"
'������cookies��post��get���ϵ�cookie
'���أ�post��get���ص�����
Public Function HttpGetResponse(sUrl As String, Optional ByVal postData As String = "", Optional ByVal method As String = "GET", Optional ByVal cookies As String = "") As String
    Dim request As winhttp.WinHttpRequest
    If Len(Trim(cookies)) = 0 Then
        cookies = "a:x," ' cookieΪ�������Ū��cookie����Ȼ���ױ���
    End If
    
    On Error Resume Next
    Set request = CreateObject("WinHttp.WinHttpRequest.5.1")
    
    With request
        .Open UCase(method), sUrl, True 'True:ͬ����������
        .SetTimeouts 30000, 30000, 30000, 30000 '���ó�ʱʱ��Ϊ30s
        .Option(WinHttpRequestOption_SslErrorIgnoreFlags) = &H3300 '�ǳ���Ҫ(���Դ���)
        .SetRequestHeader "User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        .SetRequestHeader "Accept", "text/html, application/xhtml+xml, */*"
        .SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
        .SetRequestHeader "Cookie", cookies
        .SetRequestHeader "Content-Length", Len(postData)
        .Send postData '' ��ʼ����
        
        .WaitForResponse '�ȴ�����
        'MsgBox WinHttp.Status'����״̬
        HttpGetResponse = .ResponseText '�õ������ı�(����������)
    End With
    Set request = Nothing
End Function


