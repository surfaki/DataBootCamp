Sub stock()

'Variable Definitions
Dim LastCol As Integer
Dim lastRow, Ticker, TickerRow As Long
Dim YC, PC, TSV, TSVData, PCMax, PCMin, TSVMax, TickerGreat, ValueGreat, OpenValue, CloseValue As Double
Dim TickerData, TSVTickerMax, TickerMax, TickerMin As String

'iterate through all sheets
For Each ws In Worksheets
ws.Activate

'initial table size
lastRow = Cells(Rows.Count, 1).End(xlUp).Row
LastCol = Cells(1, Columns.Count).End(xlToLeft).Column

'Column numbers
Ticker = LastCol + 2
YC = LastCol + 3
PC = LastCol + 4
TSV = LastCol + 5

TickerGreat = LastCol + 9
ValueGreat = LastCol + 10

'Column titles
Cells(1, Ticker).Value = "Ticker"
Cells(1, YC).Value = "Yearly Change"
Cells(1, PC).Value = "Percentage Change"
Cells(1, TSV).Value = "Total Stock Volume"

Cells(1, TickerGreat).Value = "Ticker"
Cells(1, ValueGreat).Value = "Value"
Cells(2, TickerGreat - 1).Value = "Greatest % Increase"
Cells(3, TickerGreat - 1).Value = "Greatest % Decrease"
Cells(4, TickerGreat - 1).Value = "Greatest Total Volume"


'Populating Data
TickerData = Cells(2, 1).Value 'Ticker column data
TickerRow = 2   'Active row on generated table
Cells(TickerRow, Ticker).Value = TickerData 'initial value on Ticker col
OpenValue = Cells(2, 3).Value
TSVData = Cells(2, 7).Value 'initial value on TSV Data

For i = 3 To lastRow
    If TickerData <> Cells(i, 1).Value Then
        CloseValue = Cells(i - 1, 6).Value
        TickerRow = TickerRow + 1
        TickerData = Cells(i, 1).Value
        
        'Populating all 4 columns
        Cells(TickerRow, Ticker).Value = TickerData
        Cells(TickerRow - 1, YC).Value = CloseValue - OpenValue
        Cells(TickerRow - 1, PC).Value = (CloseValue - OpenValue) / OpenValue
        Cells(TickerRow - 1, TSV).Value = TSVData
        
        TSVData = 0
        OpenValue = Cells(i, 3).Value
    End If
    TSVData = TSVData + Cells(i, 7).Value
Next i
    
'Populating the last row for YC, PC, TSV
Cells(TickerRow, YC).Value = Cells(lastRow, 6).Value - OpenValue
Cells(TickerRow, PC).Value = (Cells(lastRow, 6).Value - OpenValue) / OpenValue
Cells(TickerRow, TSV).Value = TSVData

'Column width Formatting
Columns(Chr(Asc("A") + TickerGreat - 2) & ":" & Chr(Asc("A") + TickerGreat - 2)).ColumnWidth = 17
Columns(Chr(Asc("A") + YC - 1) & ":" & Chr(Asc("A") + YC - 1)).ColumnWidth = 11
Columns(Chr(Asc("A") + PC - 1) & ":" & Chr(Asc("A") + PC - 1)).ColumnWidth = 15
Columns(Chr(Asc("A") + TSV - 1) & ":" & Chr(Asc("A") + TSV - 1)).ColumnWidth = 15

'Conditional formatting
Range(Chr(Asc("A") + YC - 1) & "2:" & Chr(Asc("A") + YC - 1) & TickerRow).Select
For Each f In Selection
    If f.Value >= 0 Then
        f.Interior.Color = 5287936
    ElseIf f.Value < 0 Then
        f.Interior.Color = 255
    End If
    f.NumberFormat = "0.00"
Next f
'number formating
Range(Chr(Asc("A") + PC - 1) & "2:" & Chr(Asc("A") + PC - 1) & TickerRow).Select
Selection.NumberFormat = "0.00%"

'Populate Summary table
lastRowNew = Cells(Rows.Count, Ticker).End(xlUp).Row

PCMax = 0
TickerMax = 0
PCMin = 0
TickerMin = 0
TSVMax = 0
TSVTickerMax = 0

For i = 2 To lastRowNew
    If Cells(i, PC).Value > PCMax Then
        PCMax = Cells(i, PC).Value
        TickerMax = Cells(i, Ticker).Value
    End If
    If Cells(i, PC).Value < PCMin Then
        PCMin = Cells(i, PC).Value
        TickerMin = Cells(i, Ticker).Value
    End If
    If Cells(i, TSV).Value > TSVMax Then
        TSVMax = Cells(i, TSV).Value
        TSVTickerMax = Cells(i, Ticker).Value
    End If
Next i


Cells(2, TickerGreat).Value = TickerMax
Cells(2, TickerGreat + 1).Value = PCMax
Cells(3, TickerGreat).Value = TickerMin
Cells(3, TickerGreat + 1).Value = PCMin
Cells(4, TickerGreat).Value = TSVTickerMax
Cells(4, TickerGreat + 1).Value = TSVMax

'Sumamry table formating
Range(Chr(Asc("A") + TickerGreat) & "2:" & Chr(Asc("A") + TickerGreat) & 3).Select
Selection.NumberFormat = "0.00%"

'next worksheet
Next ws

End Sub
