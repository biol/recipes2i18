object FormGalvRecipes: TFormGalvRecipes
  Left = 0
  Top = 0
  Caption = 'R i c e t t e   e l e t t r o c o l o r e'
  ClientHeight = 562
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 441
    Width = 784
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 369
    ExplicitWidth = 785
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 784
    Height = 41
    Align = alTop
    TabOrder = 0
    DesignSize = (
      784
      41)
    object lblNewRecipe: TLabel
      Left = 402
      Top = 15
      Width = 70
      Height = 13
      Caption = 'New Recipe ID'
    end
    object lblCopyFromID: TLabel
      Left = 533
      Top = 15
      Width = 62
      Height = 13
      Caption = 'copy from ID'
    end
    object DBNavigator1: TDBNavigator
      Left = 16
      Top = 8
      Width = 240
      Height = 25
      DataSource = dsGalvRecipes
      TabOrder = 0
    end
    object editNewRecipeID: TEdit
      Left = 478
      Top = 12
      Width = 49
      Height = 21
      TabOrder = 1
    end
    object EditCopyFromID: TEdit
      Left = 602
      Top = 12
      Width = 49
      Height = 21
      TabOrder = 2
    end
    object btnNewRecipe: TButton
      Left = 657
      Top = 10
      Width = 112
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'NUOVA ricetta'
      TabOrder = 3
      OnClick = btnNewRecipeClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 521
    Width = 784
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      784
      41)
    object lblRel: TLabel
      Left = 750
      Top = 12
      Width = 19
      Height = 13
      Alignment = taRightJustify
      Caption = 'Rel.'
    end
    object DBNavigator2: TDBNavigator
      Left = 16
      Top = 7
      Width = 240
      Height = 25
      DataSource = dsEleRecipeSteps
      TabOrder = 0
    end
    object btnCalibrations: TButton
      Left = 402
      Top = 7
      Width = 112
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Calibrations'
      TabOrder = 1
      OnClick = btnCalibrationsClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 784
    Height = 400
    Align = alClient
    DataSource = dsGalvRecipes
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'IDELETTROCOLORE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'ID'
        Width = 32
        Visible = True
      end
      item
        Color = clInfoBk
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Ricetta'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRIZIONE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Caption = 'Descrizione'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLIENTE'
        Title.Caption = 'Gruppo'
        Width = 100
        Visible = True
      end
      item
        Color = clInfoBk
        Expanded = False
        FieldName = 'MICRON'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Alignment = taRightJustify
        Title.Caption = #181
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CONTINUE_PERCENTAGE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Cont.%'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'totalSecs'
        Title.Alignment = taRightJustify
        Title.Caption = 'Secondi totali'
        Width = 80
        Visible = True
      end>
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 446
    Width = 784
    Height = 75
    Hint = 'Doppio click per attivare la form di compilazione'
    Align = alBottom
    DataSource = dsEleRecipeSteps
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid2DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'IDELETTROCOLORE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'ID'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRO'
        Title.Alignment = taRightJustify
        Title.Caption = 'step'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ELE_PHASE'
        Title.Alignment = taRightJustify
        Title.Caption = 'Fase'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ePhDscr'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAUSE_SECS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Pausa'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RAMP_SECS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Rampa'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DWELL_SECS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Stasi'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SETPOINT'
        Title.Alignment = taRightJustify
        Title.Caption = 'Setpoint'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UNIT_MEASURE'
        Title.Alignment = taRightJustify
        Title.Caption = 'UM'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'umDscr'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WACPOS'
        Title.Alignment = taRightJustify
        Title.Caption = 'WAC+'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WACNEG'
        Title.Alignment = taRightJustify
        Title.Caption = 'WAC-'
        Width = 61
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DSCR'
        Title.Caption = 'Note'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'calcCtrlFlags'
        Title.Caption = 'CTRL'
        Width = 32
        Visible = True
      end>
  end
  object dsGalvRecipes: TDataSource
    DataSet = dmRecipes.tblGalvRecipes
    Left = 696
    Top = 120
  end
  object dsEleRecipeSteps: TDataSource
    DataSet = dmRecipes.tblGalvRecipeSteps
    Left = 696
    Top = 200
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
    Left = 91
    Top = 86
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
