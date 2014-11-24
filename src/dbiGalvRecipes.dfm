object dmGalvRecipes: TdmGalvRecipes
  OldCreateOrder = False
  Height = 571
  Width = 396
  object fdqEleRecipes: TFDQuery
    Active = True
    AfterOpen = fdqEleRecipesAfterOpen
    BeforePost = fdqEleRecipesBeforePost
    BeforeDelete = fdqEleRecipesBeforeDelete
    AfterDelete = fdqEleRecipesAfterDelete
    OnCalcFields = fdqEleRecipesCalcFields
    OnNewRecord = fdqEleRecipesNewRecord
    Connection = dmRecipes.recipesCnx
    SQL.Strings = (
      'select * from INDICEELETTROCOLRE'
      'order by IDELETTROCOLORE')
    Left = 48
    Top = 104
    object fdqEleRecipesIDELETTROCOLORE: TIntegerField
      FieldName = 'IDELETTROCOLORE'
      Origin = 'IDELETTROCOLORE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdqEleRecipesNOME: TWideStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 15
    end
    object fdqEleRecipesCLIENTE: TWideStringField
      FieldName = 'CLIENTE'
      Origin = 'CLIENTE'
      Size = 15
    end
    object fdqEleRecipesDESCRIZIONE: TWideStringField
      FieldName = 'DESCRIZIONE'
      Origin = 'DESCRIZIONE'
      Size = 100
    end
    object fdqEleRecipesCATEGORIA: TIntegerField
      FieldName = 'CATEGORIA'
      Origin = 'CATEGORIA'
    end
    object fdqEleRecipesINUSO: TIntegerField
      FieldName = 'INUSO'
      Origin = 'INUSO'
    end
    object fdqEleRecipesDISPONIBILE: TIntegerField
      FieldName = 'DISPONIBILE'
      Origin = 'DISPONIBILE'
    end
    object fdqEleRecipesPREDEFINITO: TIntegerField
      FieldName = 'PREDEFINITO'
      Origin = 'PREDEFINITO'
    end
    object fdqEleRecipesMICRON: TIntegerField
      FieldName = 'MICRON'
      Origin = 'MICRON'
    end
    object fdqEleRecipesIDCLBR: TIntegerField
      FieldName = 'IDCLBR'
      Origin = 'IDCLBR'
    end
    object fdqEleRecipesCONTINUE_PERCENTAGE: TIntegerField
      FieldName = 'CONTINUE_PERCENTAGE'
      Origin = 'CONTINUE_PERCENTAGE'
    end
    object fdqEleRecipesRETREATMENT_PERCENTAGE: TIntegerField
      FieldName = 'RETREATMENT_PERCENTAGE'
      Origin = 'RETREATMENT_PERCENTAGE'
    end
    object fdqEleRecipestotalSecs: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'totalSecs'
      Calculated = True
    end
  end
  object dsEleRecipeLink: TDataSource
    DataSet = fdqEleRecipes
    Left = 72
    Top = 176
  end
  object fdqEleRecipeSteps: TFDQuery
    BeforePost = fdqEleRecipeStepsBeforePost
    OnCalcFields = fdqEleRecipeStepsCalcFields
    OnNewRecord = fdqEleRecipeStepsNewRecord
    MasterSource = dsEleRecipeLink
    MasterFields = 'IDELETTROCOLORE'
    DetailFields = 'IDELETTROCOLORE'
    Connection = dmRecipes.recipesCnx
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'select * from DETTELOXI'
      'where IDELETTROCOLORE = :IDELETTROCOLORE'
      'order by PRO')
    Left = 104
    Top = 256
    ParamData = <
      item
        Name = 'IDELETTROCOLORE'
        DataType = ftInteger
        ParamType = ptInput
        Size = 4
        Value = 1
      end>
    object fdqEleRecipeStepsIDELETTROCOLORE: TIntegerField
      FieldName = 'IDELETTROCOLORE'
      Origin = 'IDELETTROCOLORE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdqEleRecipeStepsPRO: TIntegerField
      FieldName = 'PRO'
      Origin = 'PRO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object fdqEleRecipeStepsDSCR: TStringField
      FieldName = 'DSCR'
      Origin = 'DSCR'
      Size = 32
    end
    object fdqEleRecipeStepsPAUSE_SECS: TIntegerField
      FieldName = 'PAUSE_SECS'
      Origin = 'PAUSE_SECS'
    end
    object fdqEleRecipeStepsRAMP_SECS: TIntegerField
      FieldName = 'RAMP_SECS'
      Origin = 'RAMP_SECS'
    end
    object fdqEleRecipeStepsDWELL_SECS: TIntegerField
      FieldName = 'DWELL_SECS'
      Origin = 'DWELL_SECS'
    end
    object fdqEleRecipeStepsSETPOINT: TSingleField
      FieldName = 'SETPOINT'
      Origin = 'SETPOINT'
    end
    object fdqEleRecipeStepsUNIT_MEASURE: TIntegerField
      FieldName = 'UNIT_MEASURE'
      Origin = 'UNIT_MEASURE'
    end
    object fdqEleRecipeStepsELE_PHASE: TIntegerField
      FieldName = 'ELE_PHASE'
      Origin = 'ELE_PHASE'
    end
    object fdqEleRecipeStepsWACPOS: TIntegerField
      FieldName = 'WACPOS'
      Origin = 'WACPOS'
    end
    object fdqEleRecipeStepsWACNEG: TIntegerField
      FieldName = 'WACNEG'
      Origin = 'WACNEG'
    end
    object fdqEleRecipeStepsTANK_CHANGED: TIntegerField
      FieldName = 'TANK_CHANGED'
      Origin = 'TANK_CHANGED'
    end
    object fdqEleRecipeStepsAUXILIARY_REX: TIntegerField
      FieldName = 'AUXILIARY_REX'
      Origin = 'AUXILIARY_REX'
    end
    object fdqEleRecipeStepsumDscr: TStringField
      FieldKind = fkCalculated
      FieldName = 'umDscr'
      Size = 16
      Calculated = True
    end
    object fdqEleRecipeStepsePhDscr: TStringField
      FieldKind = fkCalculated
      FieldName = 'ePhDscr'
      Size = 16
      Calculated = True
    end
    object fdqEleRecipeStepscalcCtrlFlags: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'calcCtrlFlags'
      Calculated = True
    end
  end
  object fdqDeleteEleRecipeSteps: TFDQuery
    OnCalcFields = fdqEleRecipeStepsCalcFields
    Connection = dmRecipes.recipesCnx
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'delete from DETTELOXI'
      'where IDELETTROCOLORE = :IDELETTROCOLORE')
    Left = 240
    Top = 192
    ParamData = <
      item
        Name = 'IDELETTROCOLORE'
        DataType = ftInteger
        ParamType = ptInput
        Size = 4
        Value = 18
      end>
    object IntegerField1: TIntegerField
      FieldName = 'IDELETTROCOLORE'
      Origin = 'IDELETTROCOLORE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object IntegerField2: TIntegerField
      FieldName = 'PRO'
      Origin = 'PRO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object StringField1: TStringField
      FieldName = 'DSCR'
      Origin = 'DSCR'
      Size = 32
    end
    object IntegerField3: TIntegerField
      FieldName = 'PAUSE_SECS'
      Origin = 'PAUSE_SECS'
    end
    object IntegerField4: TIntegerField
      FieldName = 'RAMP_SECS'
      Origin = 'RAMP_SECS'
    end
    object IntegerField5: TIntegerField
      FieldName = 'DWELL_SECS'
      Origin = 'DWELL_SECS'
    end
    object SingleField1: TSingleField
      FieldName = 'SETPOINT'
      Origin = 'SETPOINT'
    end
    object IntegerField6: TIntegerField
      FieldName = 'UNIT_MEASURE'
      Origin = 'UNIT_MEASURE'
    end
    object IntegerField7: TIntegerField
      FieldName = 'ELE_PHASE'
      Origin = 'ELE_PHASE'
    end
    object IntegerField8: TIntegerField
      FieldName = 'WACPOS'
      Origin = 'WACPOS'
    end
    object IntegerField9: TIntegerField
      FieldName = 'WACNEG'
      Origin = 'WACNEG'
    end
    object IntegerField10: TIntegerField
      FieldName = 'TANK_CHANGED'
      Origin = 'TANK_CHANGED'
    end
    object IntegerField11: TIntegerField
      FieldName = 'AUXILIARY_REX'
      Origin = 'AUXILIARY_REX'
    end
    object StringField2: TStringField
      FieldKind = fkCalculated
      FieldName = 'umDscr'
      Size = 16
      Calculated = True
    end
    object StringField3: TStringField
      FieldKind = fkCalculated
      FieldName = 'ePhDscr'
      Size = 16
      Calculated = True
    end
    object IntegerField12: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'calcCtrlFlags'
      Calculated = True
    end
  end
  object fdqUtils: TFDQuery
    Connection = dmRecipes.recipesCnx
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    Left = 288
    Top = 272
  end
  object fdqInsertEleRecipeSteps: TFDQuery
    Connection = dmRecipes.recipesCnx
    SQL.Strings = (
      'insert into "DETTELOXI"'
      '('
      '  "IDELETTROCOLORE"'
      ', "PRO"'
      ', "DSCR"'
      ', "PAUSE_SECS"'
      ', "RAMP_SECS"'
      ', "DWELL_SECS"'
      ', "SETPOINT"'
      ', "UNIT_MEASURE"'
      ', "ELE_PHASE"'
      ', "WACPOS"'
      ', "WACNEG"'
      ', "TANK_CHANGED"'
      ', "AUXILIARY_REX"'
      ')'
      'values'
      '('
      '  :"IDELETTROCOLORE"'
      ', :"PRO"'
      ', :"DSCR"'
      ', :"PAUSE_SECS"'
      ', :"RAMP_SECS"'
      ', :"DWELL_SECS"'
      ', :"SETPOINT"'
      ', :"UNIT_MEASURE"'
      ', :"ELE_PHASE"'
      ', :"WACPOS"'
      ', :"WACNEG"'
      ', :"TANK_CHANGED"'
      ', :"AUXILIARY_REX"'
      ')')
    Left = 208
    Top = 336
    ParamData = <
      item
        Name = 'IDELETTROCOLORE'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'PRO'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'DSCR'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'PAUSE_SECS'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'RAMP_SECS'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'DWELL_SECS'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'SETPOINT'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'UNIT_MEASURE'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'ELE_PHASE'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'WACPOS'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'WACNEG'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'TANK_CHANGED'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'AUXILIARY_REX'
        IsCaseSensitive = True
        ParamType = ptInput
      end>
  end
  object fdqInsertEleRecipes: TFDQuery
    Connection = dmRecipes.recipesCnx
    SQL.Strings = (
      'insert into "INDICEELETTROCOLRE"'
      '('
      '  "IDELETTROCOLORE"'
      ', "NOME"'
      ', "CLIENTE"'
      ', "DESCRIZIONE"'
      ', "CATEGORIA"'
      ', "INUSO"'
      ', "DISPONIBILE"'
      ', "PREDEFINITO"'
      ', "MICRON"'
      ', "IDCLBR"'
      ', "CONTINUE_PERCENTAGE"'
      ')'
      'values'
      '('
      '  :"IDELETTROCOLORE"'
      ', :"NOME"'
      ', :"CLIENTE"'
      ', :"DESCRIZIONE"'
      ', :"CATEGORIA"'
      ', :"INUSO"'
      ', :"DISPONIBILE"'
      ', :"PREDEFINITO"'
      ', :"MICRON"'
      ', :"IDCLBR"'
      ', :"CONTINUE_PERCENTAGE"'
      ')')
    Left = 72
    Top = 416
    ParamData = <
      item
        Name = 'IDELETTROCOLORE'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'NOME'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'CLIENTE'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'DESCRIZIONE'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'CATEGORIA'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'INUSO'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'DISPONIBILE'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'PREDEFINITO'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'MICRON'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'IDCLBR'
        IsCaseSensitive = True
        ParamType = ptInput
      end
      item
        Name = 'CONTINUE_PERCENTAGE'
        IsCaseSensitive = True
        ParamType = ptInput
      end>
  end
  object fdqEleRecipeStepsTotalSecs: TFDQuery
    BeforePost = fdqEleRecipeStepsBeforePost
    OnCalcFields = fdqEleRecipeStepsCalcFields
    OnNewRecord = fdqEleRecipeStepsNewRecord
    Connection = dmRecipes.recipesCnx
    FetchOptions.AssignedValues = [evCache]
    FetchOptions.Cache = [fiBlobs, fiMeta]
    SQL.Strings = (
      'select sum('
      '    DETTELOXI.PAUSE_SECS '
      '  + DETTELOXI.RAMP_SECS '
      '  + DETTELOXI.DWELL_SECS'
      ') TOTALE'
      'from DETTELOXI'
      'where DETTELOXI.IDELETTROCOLORE = :ID')
    Left = 160
    Top = 120
    ParamData = <
      item
        Name = 'ID'
        DataType = ftString
        ParamType = ptInput
        Value = ''
      end>
  end
end
