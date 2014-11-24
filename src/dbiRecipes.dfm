object dmRecipes: TdmRecipes
  OldCreateOrder = False
  Height = 508
  Width = 937
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
      'DriverID=FB'
      'CharacterSet=utf8')
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
    Top = 320
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
    Top = 272
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
    Top = 312
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
    Top = 272
  end
  object tblGalvRecipes: TFDTable
    Active = True
    IndexName = 'INDICEELETTROCOLORE_PRIMARY'
    Connection = recipesCnx
    UpdateOptions.UpdateTableName = 'INDICEELETTROCOLRE'
    TableName = 'INDICEELETTROCOLRE'
    Left = 584
    Top = 144
  end
  object CDSClone: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    AutoCommitUpdates = False
    Left = 168
    Top = 424
  end
  object tblGalvRecipeSteps: TFDTable
    Active = True
    IndexName = 'DETTELOXI_PRIMARY'
    MasterSource = dsGalvRecipesLink
    MasterFields = 'IDELETTROCOLORE'
    Connection = recipesCnx
    UpdateOptions.UpdateTableName = 'DETTELOXI'
    TableName = 'DETTELOXI'
    Left = 768
    Top = 224
  end
  object dsGalvRecipesLink: TDataSource
    DataSet = tblGalvRecipes
    Left = 672
    Top = 184
  end
  object dsRecipesLink: TDataSource
    DataSet = tblRecipes
    Left = 136
    Top = 144
  end
  object tblRecipeSteps: TFDTable
    Active = True
    IndexName = 'DETTAGLIORICETTE_PRIMARY'
    MasterSource = dsRecipesLink
    MasterFields = 'IDRICETTA'
    Connection = recipesCnx
    UpdateOptions.UpdateTableName = 'DETTAGLIORICETTE'
    TableName = 'DETTAGLIORICETTE'
    Left = 200
    Top = 192
    object tblRecipeStepsIDRICETTA: TIntegerField
      FieldName = 'IDRICETTA'
      Origin = 'IDRICETTA'
      Required = True
    end
    object tblRecipeStepsID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      Required = True
    end
    object tblRecipeStepsDESCRIZIONE: TWideStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'DESCRIZIONE'
      Size = 100
    end
    object tblRecipeStepsPOSIZIONE: TIntegerField
      FieldName = 'POSIZIONE'
      Origin = 'POSIZIONE'
    end
    object tblRecipeStepsTBAGNO: TIntegerField
      FieldName = 'TBAGNO'
      Origin = 'TBAGNO'
      Required = True
    end
    object tblRecipeStepsPRIORITA: TIntegerField
      FieldName = 'PRIORITA'
      Origin = 'PRIORITA'
    end
    object tblRecipeStepsIDPRELIEVO: TIntegerField
      FieldName = 'IDPRELIEVO'
      Origin = 'IDPRELIEVO'
    end
    object tblRecipeStepsIDDEPOSITO: TIntegerField
      FieldName = 'IDDEPOSITO'
      Origin = 'IDDEPOSITO'
    end
    object tblRecipeStepsRINSINGID: TIntegerField
      FieldName = 'RINSINGID'
      Origin = 'RINSINGID'
    end
    object tblRecipeStepsRINSINGCOUNT: TIntegerField
      FieldName = 'RINSINGCOUNT'
      Origin = 'RINSINGCOUNT'
    end
    object tblRecipeStepsSPRUZZO: TIntegerField
      FieldName = 'SPRUZZO'
      Origin = 'SPRUZZO'
    end
    object tblRecipeStepsPAUSACONTROLLO: TIntegerField
      FieldName = 'PAUSACONTROLLO'
      Origin = 'PAUSACONTROLLO'
    end
    object tblRecipeStepsGALVANICID: TIntegerField
      FieldName = 'GALVANICID'
      Origin = 'GALVANICID'
    end
    object tblRecipeStepsRESERVECOLORCHECK: TIntegerField
      FieldName = 'RESERVECOLORCHECK'
      Origin = 'RESERVECOLORCHECK'
    end
    object tblRecipeStepsposName: TStringField
      FieldKind = fkLookup
      FieldName = 'posName'
      LookupDataSet = tblPositions
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'POSIZIONE'
      Size = 16
      Lookup = True
    end
    object tblRecipeStepsposDSCR: TStringField
      FieldKind = fkLookup
      FieldName = 'posDSCR'
      LookupDataSet = tblPositions
      LookupKeyFields = 'ID'
      LookupResultField = 'DSCR'
      KeyFields = 'POSIZIONE'
      Size = 100
      Lookup = True
    end
    object tblRecipeStepsgalvNome: TStringField
      FieldKind = fkLookup
      FieldName = 'galvNome'
      LookupDataSet = tblGalvRecipes
      LookupKeyFields = 'IDELETTROCOLORE'
      LookupResultField = 'NOME'
      KeyFields = 'GALVANICID'
      Size = 16
      Lookup = True
    end
    object tblRecipeStepsgalvDscr: TStringField
      FieldKind = fkLookup
      FieldName = 'galvDscr'
      LookupDataSet = tblGalvRecipes
      LookupKeyFields = 'IDELETTROCOLORE'
      LookupResultField = 'DESCRIZIONE'
      KeyFields = 'GALVANICID'
      Size = 100
      Lookup = True
    end
  end
end
