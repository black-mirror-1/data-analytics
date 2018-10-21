Sub WallStreet():
    Dim tempTotalCount As Double
    Dim tempOpenPrice As Double
    Dim tempClosePrice As Double
    Dim resultRowIndex As Integer
    Dim greatestPercIncrease As Double
    Dim greatestPercDecrease As Double
    Dim greatestTotalVolume As Double
    Dim greatestPercIncreaseTicker As String
    Dim greatestPercDecreaseTicker As String
    Dim greatestTotalVolumeTicker As String

    For Each ws In Worksheets
        resultRowIndex = 2
        ' Add headers for Results
        ws.Cells(1, 11).Value = "Ticker"
        ws.Cells(1, 12).Value = "Yearly Change"
        ws.Cells(1, 13).Value = "Percent Change"
        ws.Cells(1, 14).Value = "Total Stock Volume"
        ' Add headers for Results for level Hard
        ws.Cells(1, 18).Value = "Ticker"
        ws.Cells(1, 19).Value = "Value"
        ws.Cells(2, 17).Value = "Greatest % Increase"
        ws.Cells(3, 17).Value = "Greatest % Decrease"
        ws.Cells(4, 17).Value = "Greatest Total Volume"
        'initialize the Greatest variables
        greatestPercIncrease = 9999999
        greatestPercDecrease = -9999999
        greatestTotalVolume = 0
        greatestPercIncreaseTicker = ""
        greatestPercDecreaseTicker = ""
        greatestTotalVolumeTicker = ""
        'Get the lastRow Index
        lastRow = ws.Cells(Rows.Count, "A").End(xlUp).Row
        ' Loop through all Rows
        For i = 2 To lastRow
            tempTotalCount = ws.Cells(i, 7).Value
            tempOpenPrice = ws.Cells(i, 3).Value
            Do While ws.Cells(i, 1).Value = ws.Cells(i + 1, 1).Value
                ' Take care of the tickers that start trading later in the year; records with zero value
                If tempOpenPrice = 0 Then
                    tempOpenPrice = ws.Cells(i, 3).Value
                End If
                tempTotalCount = tempTotalCount + ws.Cells(i + 1, 7).Value
                i = i + 1
            Loop
            tempClosePrice = ws.Cells(i, 6).Value
            'ticker symbol
            ws.Cells(resultRowIndex, 11).Value = ws.Cells(i, 1).Value
            'Yearly Change
            ws.Cells(resultRowIndex, 12).Value = tempClosePrice - tempOpenPrice
            'Format Year Change based on positive or negetive
            If ws.Cells(resultRowIndex, 12).Value < 0 Then
                ws.Cells(resultRowIndex, 12).Interior.ColorIndex = 3
            Else
                ws.Cells(resultRowIndex, 12).Interior.ColorIndex = 4
            End If
            'percent Change
            ws.Cells(resultRowIndex, 13).Value = (tempClosePrice - tempOpenPrice) / tempOpenPrice
            ws.Cells(resultRowIndex, 13).NumberFormat = "0.00%"
            ' Name this greatestPercIncrease if it is greater than existing
            If greatestPercIncrease = 9999999 Or greatestPercIncrease < ws.Cells(resultRowIndex, 13).Value Then
                greatestPercIncrease = ws.Cells(resultRowIndex, 13).Value
                greatestPercIncreaseTicker = ws.Cells(resultRowIndex, 11).Value
            End If
            ' Name this greatestPercDecrease if it is Lesser than existing
            If greatestPercDecrease = -9999999 Or greatestPercDecrease > ws.Cells(resultRowIndex, 13).Value Then
                greatestPercDecrease = ws.Cells(resultRowIndex, 13).Value
                greatestPercDecreaseTicker = ws.Cells(resultRowIndex, 11).Value
            End If
            'Total Count
            ws.Cells(resultRowIndex, 14).Value = tempTotalCount
            ' Name it the highest total count if it greater the existing
            If greatestTotalVolume = 0 Or greatestTotalVolume < ws.Cells(resultRowIndex, 14).Value Then
                greatestTotalVolume = ws.Cells(resultRowIndex, 14).Value
                greatestTotalVolumeTicker = ws.Cells(resultRowIndex, 11).Value
            End If
            resultRowIndex = resultRowIndex + 1
        Next i
        'MsgBox (ws.Name)
        ' write the Greatest values to sheet
        ws.Cells(2, 18).Value = greatestPercIncreaseTicker
        ws.Cells(2, 19).Value = greatestPercIncrease
        ws.Cells(2, 19).NumberFormat = "0.00%"
        ws.Cells(3, 18).Value = greatestPercDecreaseTicker
        ws.Cells(3, 19).Value = greatestPercDecrease
        ws.Cells(3, 19).NumberFormat = "0.00%"
        ws.Cells(4, 18).Value = greatestTotalVolumeTicker
        ws.Cells(4, 19).Value = greatestTotalVolume
        ws.Cells(4, 19).NumberFormat = "0.00%"
        
    Next ws
    
End Sub