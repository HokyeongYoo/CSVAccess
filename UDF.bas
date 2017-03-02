Attribute VB_Name = "UDF"
Option Explicit


''IGN{
Function EB_Path(S As String) As String
    EB_Path = ActiveWorkbook.Path & "\" & S
End Function
''IGN}


Public Function JoinArray(ByRef SourceArray() As String, ByVal NumRow As Long) As String

    Dim i As Long
    Dim TempStr As String

    For i = 1 To NumRow
        If TempStr <> "" Then
            TempStr = TempStr & "," & SourceArray(i)
        Else
            TempStr = SourceArray(i)
        End If
    Next i
    
    Debug.Print TempStr
    JoinArray = TempStr

End Function


Public Function VLookup(ByVal Target As String, SourceArray() As String, ByVal FieldNum As Long) As String
    
    Dim i As Long
    Dim RecArray() As String
    Dim Adj As Long: Adj = 10
    Dim Key() As String
    Dim NumRow As Long, NumCol As Long
    
    NumRow = CLng(SourceArray(2))
    NumCol = CLng(SourceArray(3))
    If FieldNum > NumCol Then
        Debug.Print "�迭�� �÷� �������� ū �ʵ��ȣ�� �ԷµǾ����ϴ�."
        Exit Function
    End If
    
    For i = 1 + Adj To NumRow + Adj
        If SourceArray(i) <> "" Then
            Key = Split(SourceArray(i), "|")
            If Key(0) = Target Then
                RecArray = Split(SourceArray(i), ",")
                VLookup = RecArray(FieldNum - 1)
                Exit Function
            End If
        End If
    Next i
    
    If i > NumRow + Adj Then
        Debug.Print Target & " �� �ش��ϴ� ���ڵ尡 �������� �ʽ��ϴ�."
    End If
    
End Function



Public Function VLookupAll(ByVal Target As String, SourceArray() As String) As String
    
    Dim i As Long
    Dim Adj As Long: Adj = 10
    Dim Key() As String
    Dim NumRow As Long
    
    NumRow = CLng(SourceArray(2))
    
    For i = 1 + Adj To NumRow + Adj
        If SourceArray(i) <> "" Then
            Key = Split(SourceArray(i), "|")
            If Key(0) = Target Then
                VLookupAll = Key(1)
                Exit Function
            End If
        End If
    Next i
    'Target �� �ش�Ǵ� �ʵ尡 �������� �ʴ� ��� error message ǥ��
    If i > NumRow + Adj Then
        Debug.Print Target & " �� �ش��ϴ� ���ڵ尡 �������� �ʽ��ϴ�."
    End If
    
End Function



Public Function HLookupAll(ByVal Target As String, SourceArray() As String) As String

    Dim i As Long
    Dim RecArray() As String, DataArray() As String
    Dim TargetColNum As Long
    Dim TempStr As String: TempStr = ""
    Dim Adj As Long: Adj = 10
    Dim NumRow As Long
    
    NumRow = CLng(SourceArray(2))
    
    'ù��° ���� Split
    RecArray = Split(SourceArray(0), ",")
    
    'Target �� �ش��ϴ� �÷��� �ε��� ã��
    For i = 0 To UBound(RecArray())
        If RecArray(i) = Target Then
            TargetColNum = i + 1
            Exit For
        End If
    Next i
    'Target �� �ش�Ǵ� �ʵ尡 �������� �ʴ� ��� error message ǥ�� �� ����
    If i > UBound(RecArray()) Then
        Debug.Print Target & " �� �ش��ϴ� �ʵ尡 �������� �ʽ��ϴ�."
        Exit Function
    End If
    
    For i = 1 + Adj To NumRow + Adj
        If SourceArray(i) <> "" Then
            RecArray = Split(SourceArray(i), "|")
            RecArray = Split(RecArray(1), ",")
            TempStr = TempStr & RecArray(TargetColNum - 1) & ","
        End If
    Next i
    
    HLookupAll = Left(TempStr, Len(TempStr) - 1)

End Function



Public Sub CSVImport(ByVal CSVFileName As String, _
                     ByRef ResultArray() As String, _
                     ByRef KeyColStr As String)

    Dim S As String
    Dim fnr As Long
    Dim RecArray() As String
    Dim RecCount As Long
    Dim i As Long
    Dim j As Long
    Dim Temp As Double
    Dim NumRow As Long, NumCol As Long
    Dim ColKey() As String
    
    
    'file number setting
    fnr = FreeFile()
    
    'file open
    Open EB_Path(CSVFileName) For Input As fnr
    
    If KeyColStr = "" Then KeyColStr = "1"
    ColKey = Split(KeyColStr, ",")
    
    '�����ʹ� index 11 ���� �ֱ� ������
    '���� 0~10 ������ 11�� ������ �迭�� ���� ������ �ִ� �������� ����
    NumRow = 10
                
    '���� ������ �ݺ��ؼ� �о���̱�
    Do While Not EOF(fnr)
        '���پ� �о�鿩�� S �� ����
        Line Input #fnr, S
        
        '�о���̴� ���ڵ� ī��Ʈ
        RecCount = RecCount + 1

        '�迭 S �� ����� ������ comma �������� �и�
        RecArray = Split(S, ",")

        '�÷� ������ ���� �� Field �迭�� ��ȯ
        If RecCount = 1 Then
            ResultArray(0) = S
        End If
        
        '���ǵ� Field ������ NumCol �� ���� �� ��ȯ
        If RecCount = 2 Then
            NumCol = UBound(RecArray) + 1
            For i = 1 To NumCol
                If i = 1 Then
                    ResultArray(1) = Left(RecArray(i - 1), 1)
                Else
                    ResultArray(1) = ResultArray(1) & "," & Left(RecArray(i - 1), 1)
                End If
            Next i
        End If

        '������ ���� ������ ��� �ִ� ó�� 3������ ���� ����, ��, ������ �� ó�� �κ�
        If RecCount > 3 Then
            NumRow = NumRow + 1
            
            'Key �迭 �����ؼ� ���� - MaxKeyNum ��ŭ �ݺ�
            For i = 0 To UBound(ColKey)
                For j = 1 To NumCol
                    If CLng(ColKey(i)) = j And i = 0 Then
                        ResultArray(NumRow) = RecArray(i)
                    ElseIf CLng(ColKey(i)) = j And CLng(ColKey(i)) <> 0 Then
                        ResultArray(NumRow) = ResultArray(NumRow) & "_" & RecArray(i)
                    End If
                Next j
            Next i
        
            '������ ����
            ResultArray(NumRow) = ResultArray(NumRow) & "|" & S
            
        End If

    Loop
   
    'file close
    Close fnr
    
    ResultArray(2) = NumRow
    ResultArray(3) = NumCol
    
End Sub

