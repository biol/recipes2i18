object dmRecipes: TdmRecipes
  OldCreateOrder = False
  Height = 329
  Width = 429
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 338
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 338
    Top = 72
  end
  object FDGUIxErrorDialog1: TFDGUIxErrorDialog
    Provider = 'Forms'
    Left = 338
    Top = 128
  end
  object recipesCnx: TFDConnection
    Params.Strings = (
      'Database=C:\gdb\MINIMAL_Recipes2i18.GDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    BeforeConnect = recipesCnxBeforeConnect
    Left = 48
    Top = 40
  end
  object tblRecipes: TFDTable
    Active = True
    BeforeInsert = tblRecipesBeforeInsert
    BeforeDelete = tblRecipesBeforeDelete
    IndexFieldNames = 'IDRICETTA'
    Connection = recipesCnx
    UpdateOptions.UpdateTableName = 'INDICERICETTE'
    TableName = 'INDICERICETTE'
    Left = 80
    Top = 104
  end
  object qryUtils: TFDQuery
    Connection = recipesCnx
    Left = 168
    Top = 40
  end
end
