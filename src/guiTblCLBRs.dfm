object FormTblCLBR: TFormTblCLBR
  Left = 0
  Top = 0
  Caption = 'C a l i b r a t i o n s'
  ClientHeight = 237
  ClientWidth = 678
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 678
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 731
    DesignSize = (
      678
      41)
    object lblNoInsNoDel: TLabel
      Left = 471
      Top = 14
      Width = 198
      Height = 13
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = '9 records requested: no insert, no delete'
    end
    object DBNavigator1: TDBNavigator
      Left = 8
      Top = 8
      Width = 182
      Height = 25
      DataSource = dsTblCLBR
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbPost, nbCancel, nbRefresh]
      TabOrder = 0
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 678
    Height = 196
    Align = alClient
    DataSource = dsTblCLBR
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IDCLBR'
        Title.Alignment = taCenter
        Title.Caption = 'ID'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DSCR'
        Title.Caption = 'Description'
        Width = 400
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RO'
        Title.Alignment = taRightJustify
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'KAPPA'
        Title.Alignment = taRightJustify
        Title.Caption = 'K'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OFFSET_STIMA_MICRON'
        Title.Alignment = taRightJustify
        Title.Caption = 'Offset (u estim.)'
        Width = 100
        Visible = True
      end>
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
    CommonContainer = FormRecipes.siLang1
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
    Left = 552
    Top = 96
    TranslationData = {
      73007400430061007000740069006F006E0073005F0055006E00690063006F00
      640065000D000A00540046006F0072006D00540062006C0043004C0042005200
      0100500020006F002000730020006900200074002000690020006F0020006E00
      200073000100010001000100500020006F002000730020006900200074002000
      690020006F0020006E00200073000D000A0073007400480069006E0074007300
      5F0055006E00690063006F00640065000D000A00730074004400690073007000
      6C00610079004C006100620065006C0073005F0055006E00690063006F006400
      65000D000A007300740046006F006E00740073005F0055006E00690063006F00
      640065000D000A00540046006F0072006D00540062006C0043004C0042005200
      01005400610068006F006D00610001000100010001005400610068006F006D00
      61000D000A00730074004D0075006C00740069004C0069006E00650073005F00
      55006E00690063006F00640065000D000A00440042004E006100760069006700
      610074006F00720031002E00480069006E007400730001002200460069007200
      7300740020007200650063006F007200640022002C0022005000720069006F00
      720020007200650063006F007200640022002C0022004E006500780074002000
      7200650063006F007200640022002C0022004C00610073007400200072006500
      63006F007200640022002C00220049006E007300650072007400200072006500
      63006F007200640022002C002200440065006C00650074006500200072006500
      63006F007200640022002C002200450064006900740020007200650063006F00
      7200640022002C00220050006F00730074002000650064006900740022002C00
      2200430061006E00630065006C002000650064006900740022002C0022005200
      6500660072006500730068002000640061007400610022000100010001000100
      22004600690072007300740020007200650063006F007200640022002C002200
      5000720069006F00720020007200650063006F007200640022002C0022004E00
      65007800740020007200650063006F007200640022002C0022004C0061007300
      740020007200650063006F007200640022002C00220049006E00730065007200
      740020007200650063006F007200640022002C002200440065006C0065007400
      650020007200650063006F007200640022002C00220045006400690074002000
      7200650063006F007200640022002C00220050006F0073007400200065006400
      6900740022002C002200430061006E00630065006C0020006500640069007400
      22002C0022005200650066007200650073006800200064006100740061002200
      0D000A007300740053007400720069006E00670073005F0055006E0069006300
      6F00640065000D000A00730074004F0074006800650072005300740072006900
      6E00670073005F0055006E00690063006F00640065000D000A00730074004300
      6F006C006C0065006300740069006F006E0073005F0055006E00690063006F00
      640065000D000A0073007400430068006100720053006500740073005F005500
      6E00690063006F00640065000D000A00540046006F0072006D00540062006C00
      43004C00420052000100440045004600410055004C0054005F00430048004100
      52005300450054000100010001000100440045004600410055004C0054005F00
      43004800410052005300450054000D000A00}
  end
  object dsTblCLBR: TDataSource
    DataSet = dmRecipes.tblCLBR
    Left = 624
    Top = 72
  end
end
