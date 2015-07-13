object FormLastJobsOfBar: TFormLastJobsOfBar
  Left = 0
  Top = 0
  Caption = 'FormLastJobsOfBar'
  ClientHeight = 466
  ClientWidth = 715
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 0
    Top = 161
    Width = 715
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = -8
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 286
    Width = 715
    Height = 5
    Cursor = crVSplit
    Align = alTop
    ExplicitLeft = 8
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 715
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 160
    ExplicitTop = 48
    ExplicitWidth = 185
    object Label1: TLabel
      Left = 12
      Top = 8
      Width = 24
      Height = 16
      Caption = 'Bar:'
    end
    object EditBar: TEdit
      Left = 42
      Top = 5
      Width = 47
      Height = 24
      TabOrder = 0
      Text = '25'
    end
    object btnSearchBarJobs: TButton
      Left = 95
      Top = 5
      Width = 106
      Height = 25
      Caption = 'Search Bar Jobs'
      TabOrder = 1
      OnClick = btnSearchBarJobsClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 715
    Height = 120
    Align = alTop
    DataSource = dmRecipes.dsLastJobsOfBar
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 166
    Width = 715
    Height = 120
    Align = alTop
    DataSource = dmRecipes.dsMaterialsOfJob
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid3: TDBGrid
    Left = 0
    Top = 291
    Width = 715
    Height = 175
    Align = alClient
    DataSource = dmRecipes.BarMovementsOfJob
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
