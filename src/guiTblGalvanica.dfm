object FormTblGalvanica: TFormTblGalvanica
  Left = 0
  Top = 0
  Caption = 'Galvanica'
  ClientHeight = 557
  ClientWidth = 1062
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 467
    Width = 1062
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 409
    ExplicitWidth = 731
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1062
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 787
    object DBNavigator1: TDBNavigator
      Left = 8
      Top = 8
      Width = 135
      Height = 25
      DataSource = dsGalvRecipes
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbRefresh]
      TabOrder = 0
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 1062
    Height = 426
    Align = alClient
    DataSource = dsGalvRecipes
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 472
    Width = 1062
    Height = 85
    Align = alBottom
    DataSource = dsGalvRecipeSteps
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
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
    Left = 48
    Top = 128
    TranslationData = {
      73007400430061007000740069006F006E0073005F0055006E00690063006F00
      640065000D000A00540046006F0072006D00540062006C00470061006C007600
      61006E006900630061000100470061006C00760061006E006900630061000100
      010001000100500020006F002000730020006900200074002000690020006F00
      20006E00200073000D000A0073007400480069006E00740073005F0055006E00
      690063006F00640065000D000A007300740044006900730070006C0061007900
      4C006100620065006C0073005F0055006E00690063006F00640065000D000A00
      7300740046006F006E00740073005F0055006E00690063006F00640065000D00
      0A00540046006F0072006D00540062006C00470061006C00760061006E006900
      6300610001005400610068006F006D0061000100010001000100540061006800
      6F006D0061000D000A00730074004D0075006C00740069004C0069006E006500
      73005F0055006E00690063006F00640065000D000A00440042004E0061007600
      69006700610074006F00720031002E00480069006E0074007300010022004600
      690072007300740020007200650063006F007200640022002C00220050007200
      69006F00720020007200650063006F007200640022002C0022004E0065007800
      740020007200650063006F007200640022002C0022004C006100730074002000
      7200650063006F007200640022002C00220049006E0073006500720074002000
      7200650063006F007200640022002C002200440065006C006500740065002000
      7200650063006F007200640022002C0022004500640069007400200072006500
      63006F007200640022002C00220050006F007300740020006500640069007400
      22002C002200430061006E00630065006C002000650064006900740022002C00
      220052006500660072006500730068002000640061007400610022002C002200
      4100700070006C0079002000750070006400610074006500730022002C002200
      430061006E00630065006C002000750070006400610074006500730022000100
      01000100010022004600690072007300740020007200650063006F0072006400
      22002C0022005000720069006F00720020007200650063006F00720064002200
      2C0022004E0065007800740020007200650063006F007200640022002C002200
      4C0061007300740020007200650063006F007200640022002C00220049006E00
      730065007200740020007200650063006F007200640022002C00220044006500
      6C0065007400650020007200650063006F007200640022002C00220045006400
      6900740020007200650063006F007200640022002C00220050006F0073007400
      2000650064006900740022002C002200430061006E00630065006C0020006500
      64006900740022002C0022005200650066007200650073006800200064006100
      7400610022000D000A007300740053007400720069006E00670073005F005500
      6E00690063006F00640065000D000A00730074004F0074006800650072005300
      7400720069006E00670073005F0055006E00690063006F00640065000D000A00
      7300740043006F006C006C0065006300740069006F006E0073005F0055006E00
      690063006F00640065000D000A0044004200470072006900640031002E004300
      6F006C0075006D006E0073005B0030005D002E005400690074006C0065002E00
      430061007000740069006F006E0001004900440045004C004500540054005200
      4F0043004F004C004F00520045000100010001000D000A004400420047007200
      6900640031002E0043006F006C0075006D006E0073005B0031005D002E005400
      690074006C0065002E00430061007000740069006F006E0001004E004F004D00
      45000100010001000D000A0044004200470072006900640031002E0043006F00
      6C0075006D006E0073005B0032005D002E005400690074006C0065002E004300
      61007000740069006F006E00010043004C00490045004E005400450001000100
      01000D000A0044004200470072006900640031002E0043006F006C0075006D00
      6E0073005B0033005D002E005400690074006C0065002E004300610070007400
      69006F006E0001004400450053004300520049005A0049004F004E0045000100
      010001000D000A0044004200470072006900640031002E0043006F006C007500
      6D006E0073005B0034005D002E005400690074006C0065002E00430061007000
      740069006F006E000100430041005400450047004F0052004900410001000100
      01000D000A0044004200470072006900640031002E0043006F006C0075006D00
      6E0073005B0035005D002E005400690074006C0065002E004300610070007400
      69006F006E00010049004E00550053004F000100010001000D000A0044004200
      470072006900640031002E0043006F006C0075006D006E0073005B0036005D00
      2E005400690074006C0065002E00430061007000740069006F006E0001004400
      4900530050004F004E004900420049004C0045000100010001000D000A004400
      4200470072006900640031002E0043006F006C0075006D006E0073005B003700
      5D002E005400690074006C0065002E00430061007000740069006F006E000100
      50005200450044004500460049004E00490054004F000100010001000D000A00
      44004200470072006900640031002E0043006F006C0075006D006E0073005B00
      38005D002E005400690074006C0065002E00430061007000740069006F006E00
      01004D004900430052004F004E000100010001000D000A004400420047007200
      6900640031002E0043006F006C0075006D006E0073005B0039005D002E005400
      690074006C0065002E00430061007000740069006F006E000100490044004300
      4C00420052000100010001000D000A0044004200470072006900640031002E00
      43006F006C0075006D006E0073005B00310030005D002E005400690074006C00
      65002E00430061007000740069006F006E00010043004F004E00540049004E00
      550045005F00500045005200430045004E005400410047004500010001000100
      0D000A0044004200470072006900640031002E0043006F006C0075006D006E00
      73005B00310031005D002E005400690074006C0065002E004300610070007400
      69006F006E00010052004500540052004500410054004D0045004E0054005F00
      500045005200430045004E0054004100470045000100010001000D000A007300
      7400430068006100720053006500740073005F0055006E00690063006F006400
      65000D000A00540046006F0072006D00540062006C00470061006C0076006100
      6E006900630061000100440045004600410055004C0054005F00430048004100
      52005300450054000100010001000100440045004600410055004C0054005F00
      43004800410052005300450054000D000A00}
  end
  object dsGalvRecipes: TDataSource
    DataSet = dmRecipes.tblGalvRecipes
    Left = 560
    Top = 120
  end
  object dsGalvRecipeSteps: TDataSource
    DataSet = dmRecipes.tblGalvRecipeSteps
    Left = 552
    Top = 400
  end
end
