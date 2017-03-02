Attribute VB_Name = "CSV"
Option Explicit

Public Const MaxColNum As Long = 300
Public Const MaxKeyNum As Long = 5

''START(1,1)
Public Sub Main()
    
    Dim TotResultArray(10000) As String                 'CSV ��ü ���� �����ϴ� �迭
    Dim i As Long, j As Long
    Dim JoinStr As String
    Dim TempStr As String
    Dim ResultData() As String
    Dim KeyCol As String                                'Ű�� ���� �÷��� ��ȣ�� �޸� �������� �Է�
    Dim InputFileName As String                         'CSV ���� �̸�(��� ����)
    Dim TargetKey As String
    Dim TargetField As String

'====================================================================================================================================================
'����ڰ� �Է������ �ϴ� �Ķ���� ��
'====================================================================================================================================================
    KeyCol = "1,2,3,4,5"                                'ù��°���� �ټ���° �÷��� ������� �����ؼ� Ű�� �����
    
    InputFileName = "load_comm.csv"                     'CSV ���ϸ�
    TargetKey = "P029107001B_0_1_0_0"                   '�˻� ����� �Ǵ� Key ��
    TargetField = "Alp_Ini_GP"                          '�˻� ����� �Ǵ� Field �̸�
'====================================================================================================================================================
    
    
    Call CSVImport(InputFileName, TotResultArray(), KeyCol)
'====================================================================================================================================================
    'CSVImport Sub
    'CSV data file �� ������ TotResultArray �迭�� ����. String �Ӽ��� �迭��
    '1st �Ķ����(InputFileName) : ��� CSV ���ϸ�
    '2nd �Ķ����(TotResultArray()) : CSV ������ ��ȯ�ޱ� ���� �迭
        'index 0 : �ʵ� �̸�
        'index 1 : �ʵ� �Ӽ�
        'index 11~ : ������ ���ڵ�
    '3rd �Ķ����(KeyCol) : CSV ���� �� Key Field �� ��ġ�� ��� �ִ� ����. �޸��� ����.
    '[����] ByRef �� ó���Ǵ� �迭������ �ݵ�� 0 ���� �ε��� ���� �ʿ�. �׷��� ������ �ϳ��� �ڷ� �и��� ��
'====================================================================================================================================================
    
'    JoinStr = JoinArray(TotResultArray(), TSize(0))
'    Debug.Print JoinStr
    
    Debug.Print "# of Rows: ", TotResultArray(2)
    Debug.Print "# of Cols: ", TotResultArray(3)
    
    For j = 6 To 29
        Debug.Print j, "VLookup", VLookup(TargetKey, TotResultArray(), j)
    Next j
    
    Debug.Print "VLookupAll", VLookupAll(TargetKey, TotResultArray())
    Debug.Print "HLookupAll", HLookupAll(TargetField, TotResultArray())

'====================================================================================================================================================
    'VLookup Function : ��ȯ���� �ݵ�� Double type
    '1st �Ķ����(TargetKey) : ã���� �ϴ� Key ��
    '2nd �Ķ����(TotResultArray()) : Source Array ��ü
    '3rd �Ķ����(j) : ���� ������ ���� ��� �÷� ����
'====================================================================================================================================================
    
'====================================================================================================================================================
    'VLookupAll Function - VLookup �� �����ϳ� TargetKey �� �ش��ϴ� �� �� ��ü�� ��ȯ����
    '��ȯ���� �ݵ�� String Type. comma �� ���еǾ��ֱ� ������ �ݵ�� Split ó������� ��
    '1st �Ķ����(TargetKey) : ã���� �ϴ� Key ��
    '2nd �Ķ����(TotResultArray()) : Source Array ��ü
'====================================================================================================================================================
    
'====================================================================================================================================================
    'HLookupAll Function - VLookup �� �����ϳ� TargetField �� �ش��ϴ� �� �� ��ü�� ��ȯ����
    '��ȯ���� �ݵ�� String Type. comma �� ���еǾ��ֱ� ������ �ݵ�� Split ó������� ��
    '1st �Ķ����(TargetField) : ã���� �ϴ� Key ��
    '2nd �Ķ����(TotResultArray()) : Source Array ��ü
'====================================================================================================================================================
    
    
'    TempStr = VLookupAll("1010101011M", TotResultArray())
'    ResultData = Split(TempStr, ",")

'    For j = LBound(ResultData) To UBound(ResultData)
'        Debug.Print LBound(ResultData), UBound(ResultData), j, ResultData(j)
'    Next j
'
'    Debug.Print TempDbl
    
    'Debug.Print No_Row, No_Col
    

End Sub


