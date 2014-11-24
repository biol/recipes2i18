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
    object DBNavigator1: TDBNavigator
      Left = 16
      Top = 8
      Width = 240
      Height = 25
      DataSource = dsEleRecipes
      TabOrder = 0
    end
    object btnRinumera: TButton
      Left = 536
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Rinumera'
      TabOrder = 1
      OnClick = btnRinumeraClick
    end
    object EditRenum: TEdit
      Left = 616
      Top = 11
      Width = 49
      Height = 21
      TabOrder = 2
    end
    object btnDuplica: TButton
      Left = 320
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Duplica'
      TabOrder = 3
      OnClick = btnDuplicaClick
    end
    object EditDuplica: TEdit
      Left = 401
      Top = 11
      Width = 49
      Height = 21
      TabOrder = 4
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 521
    Width = 784
    Height = 41
    Align = alBottom
    TabOrder = 1
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
      Top = 6
      Width = 240
      Height = 25
      DataSource = dsEleRecipeSteps
      TabOrder = 0
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 784
    Height = 400
    Align = alClient
    DataSource = dsEleRecipes
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
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
  object dsEleRecipes: TDataSource
    DataSet = dmGalvRecipes.fdqEleRecipes
    Left = 696
    Top = 120
  end
  object dsEleRecipeSteps: TDataSource
    DataSet = dmGalvRecipes.fdqEleRecipeSteps
    Left = 696
    Top = 200
  end
end
