object FormSetpointCTRL: TFormSetpointCTRL
  Left = 0
  Top = 0
  Caption = 'd e t t a g l i o   e l e t t r o c o l o r e'
  ClientHeight = 417
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 23
  object lblRecipe: TLabel
    Tag = 15
    Left = 8
    Top = 59
    Width = 153
    Height = 28
    Hint = 'click to manage'
    ParentCustomHint = False
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'setpoint '
    Color = clInfoBk
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    Transparent = False
  end
  object lblPausa: TLabel
    Tag = 15
    Left = 8
    Top = 185
    Width = 153
    Height = 28
    Hint = 'click to manage'
    ParentCustomHint = False
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'pausa '
    Color = clInfoBk
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    Transparent = False
  end
  object Label2: TLabel
    Tag = 15
    Left = 8
    Top = 222
    Width = 153
    Height = 28
    Hint = 'click to manage'
    ParentCustomHint = False
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'rampa '
    Color = clInfoBk
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    Transparent = False
  end
  object Label3: TLabel
    Tag = 15
    Left = 8
    Top = 259
    Width = 153
    Height = 28
    Hint = 'click to manage'
    ParentCustomHint = False
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'stasi '
    Color = clInfoBk
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    Transparent = False
  end
  object Label4: TLabel
    Left = 154
    Top = 11
    Width = 7
    Height = 23
    Caption = ')'
  end
  object lblWACPOS: TLabel
    Tag = 15
    Left = 8
    Top = 296
    Width = 153
    Height = 28
    Hint = 'click to manage'
    ParentCustomHint = False
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'AC + wd '
    Color = clInfoBk
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    Transparent = False
  end
  object lblWACNEG: TLabel
    Tag = 15
    Left = 8
    Top = 333
    Width = 153
    Height = 28
    Hint = 'click to manage'
    ParentCustomHint = False
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'AC - wd '
    Color = clInfoBk
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    Transparent = False
  end
  object Label1: TLabel
    Tag = 15
    Left = 8
    Top = 11
    Width = 98
    Height = 28
    Hint = 'click to manage'
    ParentCustomHint = False
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'prog. '
    Color = clInfoBk
    ParentColor = False
    ParentShowHint = False
    ShowHint = True
    Transparent = False
  end
  object DBEditSetpoint: TDBEdit
    Left = 167
    Top = 56
    Width = 83
    Height = 31
    DataField = 'SETPOINT'
    DataSource = dsDettaglio
    TabOrder = 2
  end
  object DBEditPausa: TDBEdit
    Left = 167
    Top = 182
    Width = 83
    Height = 31
    DataField = 'PAUSE_SECS'
    DataSource = dsDettaglio
    TabOrder = 6
  end
  object DBEditRampa: TDBEdit
    Left = 167
    Top = 219
    Width = 83
    Height = 31
    DataField = 'RAMP_SECS'
    DataSource = dsDettaglio
    TabOrder = 7
  end
  object DBEditStasi: TDBEdit
    Left = 167
    Top = 256
    Width = 83
    Height = 31
    DataField = 'DWELL_SECS'
    DataSource = dsDettaglio
    TabOrder = 8
  end
  object DBEditDescrizione: TDBEdit
    Left = 167
    Top = 8
    Width = 290
    Height = 31
    DataField = 'DSCR'
    DataSource = dsDettaglio
    TabOrder = 1
  end
  object DBEditWACPOS: TDBEdit
    Left = 167
    Top = 293
    Width = 83
    Height = 31
    DataField = 'WACPOS'
    DataSource = dsDettaglio
    TabOrder = 9
  end
  object DBEditWACNEG: TDBEdit
    Left = 167
    Top = 330
    Width = 83
    Height = 31
    DataField = 'WACNEG'
    DataSource = dsDettaglio
    TabOrder = 10
  end
  object DBCbTankChanged: TDBCheckBox
    Left = 8
    Top = 104
    Width = 233
    Height = 17
    Caption = 'tank changed'
    DataField = 'TANK_CHANGED'
    DataSource = dsDettaglio
    TabOrder = 4
    ValueChecked = '1'
    ValueUnchecked = '0'
  end
  object DBCbAuxiliaryRex: TDBCheckBox
    Left = 8
    Top = 136
    Width = 233
    Height = 17
    Caption = 'Auxiliary REX '
    DataField = 'AUXILIARY_REX'
    DataSource = dsDettaglio
    TabOrder = 5
    ValueChecked = '1'
    ValueUnchecked = '0'
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 367
    Width = 328
    Height = 42
    DataSource = dsDettaglio
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbPost, nbCancel]
    TabOrder = 12
  end
  object btnOK: TBitBtn
    Left = 342
    Top = 368
    Width = 115
    Height = 41
    Caption = 'OK'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    TabOrder = 13
    OnClick = btnOKClick
  end
  object DBEditPro: TDBEdit
    Left = 112
    Top = 8
    Width = 43
    Height = 31
    DataField = 'PRO'
    DataSource = dsDettaglio
    TabOrder = 0
  end
  object rgUM: TRadioGroup
    Left = 272
    Top = 45
    Width = 185
    Height = 148
    Caption = ' unit'#224' di misura '
    Items.Strings = (
      'Volt'
      'KAmpere'
      'Ampere/dm'#178)
    TabOrder = 3
    OnClick = rgUMClick
  end
  object rgElePhase: TRadioGroup
    Left = 277
    Top = 219
    Width = 185
    Height = 114
    Caption = ' fase elettrocolore '
    Items.Strings = (
      'Fase DC'
      'Fase AC')
    TabOrder = 11
    OnClick = rgElePhaseClick
  end
  object dsDettaglio: TDataSource
    DataSet = dmRecipes.tblGalvRecipeSteps
    OnDataChange = dsDettaglioDataChange
    Left = 400
    Top = 97
  end
  object siLangLinked1: TsiLangLinked
    Version = '7.3'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    NumOfLanguages = 3
    LangDispatcher = FormRecipes.siLangDispatcher1
    LangDelim = 1
    LangNames.Strings = (
      'Italiano'
      'English'
      'Russian')
    Language = 'Italiano'
    ExcludedProperties.Strings = (
      'Category'
      'SecondaryShortCuts'
      'HelpKeyword'
      'InitialDir'
      'HelpKeyword'
      'ActivePage'
      'ImeName'
      'DefaultExt'
      'FileName'
      'FieldName'
      'PickList'
      'DisplayFormat'
      'EditMask'
      'KeyList'
      'LookupDisplayFields'
      'DropDownSpecRow'
      'TableName'
      'DatabaseName'
      'IndexName'
      'MasterFields'
      'SQL'
      'DeleteSQL'
      'UpdateSQL'
      'ModifySQL'
      'KeyFields'
      'LookupKeyFields'
      'LookupResultField'
      'DataField'
      'KeyField'
      'ListField')
    Left = 427
    Top = 326
    TranslationData = {
      73007400430061007000740069006F006E0073005F0055006E00690063006F00
      640065000D000A0073007400480069006E00740073005F0055006E0069006300
      6F00640065000D000A007300740044006900730070006C00610079004C006100
      620065006C0073005F0055006E00690063006F00640065000D000A0073007400
      46006F006E00740073005F0055006E00690063006F00640065000D000A007300
      74004D0075006C00740069004C0069006E00650073005F0055006E0069006300
      6F00640065000D000A007300740053007400720069006E00670073005F005500
      6E00690063006F00640065000D000A00730074004F0074006800650072005300
      7400720069006E00670073005F0055006E00690063006F00640065000D000A00
      7300740043006F006C006C0065006300740069006F006E0073005F0055006E00
      690063006F00640065000D000A00730074004300680061007200530065007400
      73005F0055006E00690063006F00640065000D000A00}
  end
end
