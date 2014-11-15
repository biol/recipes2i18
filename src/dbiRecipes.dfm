object dmRecipes: TdmRecipes
  OldCreateOrder = False
  Height = 623
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
  object tblPositions: TFDTable
    Active = True
    IndexFieldNames = 'ID'
    Connection = recipesCnx
    UpdateOptions.UpdateTableName = 'POSITIONS'
    TableName = 'POSITIONS'
    Left = 256
    Top = 240
  end
  object tblTipiPrelievo: TFDTable
    Active = True
    AfterOpen = tblTipiPrelievoAfterOpen
    OnNewRecord = tblTipiPrelievoNewRecord
    IndexFieldNames = 'ID'
    Connection = recipesCnx
    UpdateOptions.UpdateTableName = 'TIPIPREL_07'
    TableName = 'TIPIPREL_07'
    Left = 72
    Top = 216
  end
  object tblTipiDeposito: TFDTable
    Active = True
    AfterOpen = tblTipiDepositoAfterOpen
    OnNewRecord = tblTipiDepositoNewRecord
    IndexFieldNames = 'ID'
    Connection = recipesCnx
    UpdateOptions.UpdateTableName = 'TIPIDEPO_07'
    TableName = 'TIPIDEPO_07'
    Left = 128
    Top = 232
  end
  object tblTipiRisciacquo: TFDTable
    Active = True
    AfterOpen = tblTipiRisciacquoAfterOpen
    OnNewRecord = tblTipiRisciacquoNewRecord
    IndexFieldNames = 'ID'
    Connection = recipesCnx
    UpdateOptions.UpdateTableName = 'TIPIRISC_07'
    TableName = 'TIPIRISC_07'
    Left = 192
    Top = 216
  end
  object tblGalvRecipes: TFDTable
    Active = True
    IndexFieldNames = 'IDELETTROCOLORE'
    Connection = recipesCnx
    UpdateOptions.UpdateTableName = 'INDICEELETTROCOLRE'
    TableName = 'INDICEELETTROCOLRE'
    Left = 320
    Top = 224
  end
  object tblRecipeSteps: TFDTable
    OnNewRecord = tblRecipeStepsNewRecord
    MasterSource = FormRecipes.dsRecipes
    MasterFields = 'IDRICETTA'
    Connection = recipesCnx
    UpdateOptions.UpdateTableName = 'DETTAGLIORICETTE'
    TableName = 'DETTAGLIORICETTE'
    Left = 136
    Top = 120
  end
end
