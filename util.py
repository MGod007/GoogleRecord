import pandas as pd
import  openpyxl

def readexcel():
    path = "SearchKeywords.xlsx"
    excel_obj = openpyxl.load_workbook(path)
    sheet_obj = excel_obj.active
    row = sheet_obj.max_row
    column = sheet_obj.max_column
    listofdata = []
    for i   in range(2, row + 1):
        cell_obj = sheet_obj.cell(row=i, column=1)
        listofdata.append(cell_obj.value)
        
    return   listofdata
    
