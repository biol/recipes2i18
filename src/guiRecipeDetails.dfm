object FormRecipeDetails: TFormRecipeDetails
  Left = 0
  Top = 0
  Caption = 'Dettaglio Ricetta'
  ClientHeight = 600
  ClientWidth = 951
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
  object pnlHead: TPanel
    Left = 0
    Top = 0
    Width = 951
    Height = 41
    Align = alTop
    TabOrder = 0
    DesignSize = (
      951
      41)
    object DBNavigator1: TDBNavigator
      Left = 8
      Top = 8
      Width = 240
      Height = 25
      DataSource = dsRecipeDetails
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btnSaveData: TButton
      Left = 415
      Top = 9
      Width = 87
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Salva'
      TabOrder = 1
      OnClick = btnSaveDataClick
    end
    object btnPositions: TButton
      Left = 854
      Top = 9
      Width = 87
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'P o s i z i o n i'
      TabOrder = 2
      OnClick = btnPositionsClick
    end
  end
  object pnlDetail: TPanel
    Left = 0
    Top = 440
    Width = 951
    Height = 119
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      951
      119)
    object Label1: TLabel
      Left = 44
      Top = 10
      Width = 28
      Height = 13
      Alignment = taRightJustify
      Caption = 'Vasca'
      OnDblClick = Label1DblClick
    end
    object Label2: TLabel
      Left = 31
      Top = 40
      Width = 41
      Height = 13
      Hint = '2click to manage drop types'
      Alignment = taRightJustify
      Caption = 'deposito'
      ParentShowHint = False
      ShowHint = True
      OnDblClick = Label2DblClick
    end
    object Label3: TLabel
      Left = 34
      Top = 64
      Width = 38
      Height = 13
      Hint = '2click to manage pickup types'
      Alignment = taRightJustify
      Caption = 'prelievo'
      ParentShowHint = False
      ShowHint = True
      OnDblClick = Label3DblClick
    end
    object Label4: TLabel
      Left = 497
      Top = 39
      Width = 47
      Height = 13
      Hint = '2click to manage rinsing types'
      Alignment = taRightJustify
      Caption = 'risciacquo'
      ParentShowHint = False
      ShowHint = True
      OnDblClick = Label4DblClick
    end
    object Label5: TLabel
      Left = 478
      Top = 64
      Width = 66
      Height = 13
      Alignment = taRightJustify
      Caption = 'n.ro risciacqui'
    end
    object Label6: TLabel
      Left = 237
      Top = 64
      Width = 36
      Height = 13
      Alignment = taRightJustify
      Caption = 'secondi'
    end
    object Label7: TLabel
      Left = 240
      Top = 40
      Width = 34
      Height = 13
      Alignment = taRightJustify
      Caption = 'priorit'#224
    end
    object Label8: TLabel
      Left = 336
      Top = 40
      Width = 73
      Height = 13
      Alignment = taRightJustify
      Caption = 'controllo colore'
    end
    object Label9: TLabel
      Left = 343
      Top = 64
      Width = 65
      Height = 13
      Alignment = taRightJustify
      Caption = 'spruzzo/mov.'
    end
    object lblGalvanica: TLabel
      Left = 26
      Top = 95
      Width = 46
      Height = 13
      Alignment = taRightJustify
      Caption = 'Galvanica'
      OnDblClick = Label1DblClick
    end
    object dblcbPosizioneName: TDBLookupComboBox
      Left = 75
      Top = 6
      Width = 145
      Height = 21
      DataField = 'POSIZIONE'
      DataSource = dsRecipeDetails
      KeyField = 'ID'
      ListField = 'NAME'
      ListSource = dsPositions
      TabOrder = 0
    end
    object dblcbPosizioneDscr: TDBLookupComboBox
      Left = 229
      Top = 6
      Width = 467
      Height = 21
      DataField = 'POSIZIONE'
      DataSource = dsRecipeDetails
      KeyField = 'ID'
      ListField = 'DSCR'
      ListSource = dsPositions
      TabOrder = 1
    end
    object dblcbDrop: TDBLookupComboBox
      Left = 75
      Top = 36
      Width = 145
      Height = 21
      DataField = 'IDDEPOSITO'
      DataSource = dsRecipeDetails
      KeyField = 'ID'
      ListField = 'DSCR'
      ListSource = dsTIPIDEPO_07
      TabOrder = 2
    end
    object dblcbPickup: TDBLookupComboBox
      Left = 75
      Top = 60
      Width = 145
      Height = 21
      DataField = 'IDPRELIEVO'
      DataSource = dsRecipeDetails
      KeyField = 'ID'
      ListField = 'DSCR'
      ListSource = dsTIPIPREL_07
      TabOrder = 3
    end
    object dblcbRinsing: TDBLookupComboBox
      Left = 551
      Top = 35
      Width = 145
      Height = 21
      DataField = 'RINSINGID'
      DataSource = dsRecipeDetails
      KeyField = 'ID'
      ListField = 'DSCR'
      ListSource = dsTIPIRISC_07
      TabOrder = 4
    end
    object dbeRINSINGCOUNT: TDBEdit
      Left = 551
      Top = 61
      Width = 57
      Height = 21
      DataField = 'RINSINGCOUNT'
      DataSource = dsRecipeDetails
      TabOrder = 5
    end
    object dbeTBAGNO: TDBEdit
      Left = 280
      Top = 61
      Width = 57
      Height = 21
      DataField = 'TBAGNO'
      DataSource = dsRecipeDetails
      TabOrder = 6
    end
    object dbcbPRIORITA: TDBComboBox
      Left = 280
      Top = 37
      Width = 57
      Height = 21
      DataField = 'PRIORITA'
      DataSource = dsRecipeDetails
      Items.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5')
      TabOrder = 7
    end
    object btnDropTypes: TButton
      Left = 886
      Top = 5
      Width = 55
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Depositi'
      TabOrder = 8
      OnClick = btnDropTypesClick
    end
    object btnPickupTypes: TButton
      Left = 886
      Top = 34
      Width = 55
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Prelievi'
      TabOrder = 9
      OnClick = btnPickupTypesClick
    end
    object btnRinsingTypes: TButton
      Left = 886
      Top = 59
      Width = 55
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Risciacqui'
      TabOrder = 10
      OnClick = btnRinsingTypesClick
    end
    object dbeSPRUZZO: TDBEdit
      Left = 415
      Top = 61
      Width = 57
      Height = 21
      DataField = 'SPRUZZO'
      DataSource = dsRecipeDetails
      TabOrder = 11
    end
    object dbePAUSACONTROLLO: TDBEdit
      Left = 415
      Top = 36
      Width = 57
      Height = 21
      DataField = 'PAUSACONTROLLO'
      DataSource = dsRecipeDetails
      TabOrder = 12
    end
    object dblcbGalvanica: TDBLookupComboBox
      Left = 75
      Top = 91
      Width = 145
      Height = 21
      DataField = 'GALVANICID'
      DataSource = dsRecipeDetails
      KeyField = 'IDELETTROCOLORE'
      ListField = 'NOME'
      ListSource = dsGalvRecipes
      TabOrder = 13
    end
  end
  object pnlFoot: TPanel
    Left = 0
    Top = 559
    Width = 951
    Height = 41
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      951
      41)
    object DBNavigator2: TDBNavigator
      Left = 8
      Top = 8
      Width = 240
      Height = 25
      DataSource = dsRecipeDetails
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object btnRenum: TButton
      Left = 770
      Top = 6
      Width = 171
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'RINUMERA per 10'
      TabOrder = 1
      OnClick = btnRenumClick
    end
  end
  object dbgDetails: TDBGrid
    Left = 0
    Top = 41
    Width = 951
    Height = 399
    Align = alClient
    DataSource = dsRecipeDetails
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'IDRICETTA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'ID'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID'
        Title.Alignment = taRightJustify
        Title.Caption = 'step'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'POSIZIONE'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Alignment = taRightJustify
        Title.Caption = 'pos.'
        Width = 32
        Visible = True
      end
      item
        Color = clYellow
        Expanded = False
        FieldName = 'TBAGNO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Alignment = taRightJustify
        Title.Caption = 'seconds'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'posName'
        Title.Caption = 'tank'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'posDSCR'
        ReadOnly = True
        Title.Caption = 'description'
        Width = 170
        Visible = True
      end
      item
        Alignment = taCenter
        Color = clInfoBk
        Expanded = False
        FieldName = 'PRIORITA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Alignment = taCenter
        Title.Caption = 'priority'
        Width = 50
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IDDEPOSITO'
        Title.Alignment = taCenter
        Title.Caption = 'drop'
        Width = 32
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IDPRELIEVO'
        Title.Alignment = taCenter
        Title.Caption = 'pick'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RINSINGID'
        Title.Alignment = taRightJustify
        Title.Caption = 'rins'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RINSINGCOUNT'
        Title.Alignment = taRightJustify
        Title.Caption = 'rins#'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PAUSACONTROLLO'
        Title.Alignment = taRightJustify
        Title.Caption = 'color check'
        Width = 59
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'RESERVECOLORCHECK'
        Title.Alignment = taCenter
        Title.Caption = 'RCC'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SPRUZZO'
        Title.Alignment = taRightJustify
        Title.Caption = 'mov.spray'
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GALVANICID'
        Title.Alignment = taRightJustify
        Title.Caption = 'Galv.ID'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'galvNome'
        Title.Caption = 'Galvanic Recipe'
        Width = 160
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'galvDscr'
        Title.Caption = 'Galvanic Description'
        Visible = True
      end>
  end
  object dsRecipeDetails: TDataSource
    DataSet = dmRecipes.tblRecipeSteps
    Left = 261
    Top = 122
  end
  object dsPositions: TDataSource
    DataSet = dmRecipes.tblPositions
    Left = 539
    Top = 111
  end
  object dsTIPIDEPO_07: TDataSource
    DataSet = dmRecipes.tblTipiDeposito
    Left = 392
    Top = 122
  end
  object dsTIPIPREL_07: TDataSource
    DataSet = dmRecipes.tblTipiPrelievo
    Left = 392
    Top = 178
  end
  object dsTIPIRISC_07: TDataSource
    DataSet = dmRecipes.tblTipiRisciacquo
    Left = 392
    Top = 242
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
    Left = 56
    Top = 344
    TranslationData = {
      73007400430061007000740069006F006E0073005F0055006E00690063006F00
      640065000D000A00540046006F0072006D005200650063006900700065004400
      65007400610069006C00730001004400650074007400610067006C0069006F00
      2000520069006300650074007400610001005200200065002000630020006900
      2000700020006500200020002000440020006500200074002000610020006900
      20006C00200073000100010001004400650074007400610067006C0069006F00
      2000520069006300650074007400610001005200200065002000630020006900
      2000700020006500200020002000440020006500200074002000610020006900
      20006C00200073000D000A00620074006E00440072006F007000540079007000
      6500730001004400650070006F0073006900740069000100440052004F005000
      73000100010001004400650070006F0073006900740069000100440052004F00
      500073000D000A00620074006E005000690063006B0075007000540079007000
      6500730001005000720065006C00690065007600690001005000490043004B00
      5500500073000100010001005000720065006C00690065007600690001005000
      490043004B005500500073000D000A00620074006E0050006F00730069007400
      69006F006E0073000100500020006F00200073002000690020007A0020006900
      20006F0020006E00200069000100500020006F00200073002000690020007400
      2000690020006F0020006E0020007300010001000100500020006F0020007300
      2000690020007A002000690020006F0020006E00200069000100500020006F00
      2000730020006900200074002000690020006F0020006E00200073000D000A00
      620074006E00520065006E0075006D000100520049004E0055004D0045005200
      4100200070006500720020003100300001007300740065007000730020005200
      45004E0055004D00200062007900200031003000010001000100520049004E00
      55004D0045005200410020007000650072002000310030000100730074006500
      700073002000520045004E0055004D002000620079002000310030000D000A00
      620074006E00520069006E00730069006E006700540079007000650073000100
      52006900730063006900610063007100750069000100520049004E0053004900
      4E00470073000100010001005200690073006300690061006300710075006900
      0100520049004E00530049004E00470073000D000A00620074006E0053006100
      7600650044006100740061000100530061006C00760061000100530061007600
      650020004400610074006100010001000100530061006C007600610001005300
      610076006500200044006100740061000D000A004C006100620065006C003100
      0100560061007300630061000100740061006E006B0001000100010056006100
      7300630061000100740061006E006B000D000A004C006100620065006C003200
      01006400650070006F007300690074006F000100640072006F00700001000100
      01006400650070006F007300690074006F000100640072006F0070000D000A00
      4C006100620065006C00330001007000720065006C006900650076006F000100
      7000690063006B00750070000100010001007000720065006C00690065007600
      6F0001007000690063006B00750070000D000A004C006100620065006C003400
      01007200690073006300690061006300710075006F000100720069006E007300
      69006E0067000100010001007200690073006300690061006300710075006F00
      0100720069006E00730069006E0067000D000A004C006100620065006C003500
      01006E002E0072006F0020007200690073006300690061006300710075006900
      0100720069006E00730069006E006700200043006F0075006E00740001000100
      01006E002E0072006F0020007200690073006300690061006300710075006900
      0100720069006E00730069006E006700200043006F0075006E0074000D000A00
      4C006100620065006C00360001007300650063006F006E006400690001007300
      650063006F006E00640073000100010001007300650063006F006E0064006900
      01007300650063006F006E00640073000D000A004C006100620065006C003700
      01007000720069006F00720069007400E00001007000720069006F0072006900
      740079000100010001007000720069006F00720069007400E000010070007200
      69006F0072006900740079000D000A004C006100620065006C00380001006300
      6F006E00740072006F006C006C006F00200063006F006C006F00720065000100
      63006F006C006F007200200063006800650063006B0001000100010063006F00
      6E00740072006F006C006C006F00200063006F006C006F007200650001006300
      6F006C006F007200200063006800650063006B000D000A004C00610062006500
      6C003900010073007000720075007A007A006F002F006D006F0076002E000100
      6D006F0076002E00730070007200610079000100010001007300700072007500
      7A007A006F002F006D006F0076002E0001006D006F0076002E00730070007200
      610079000D000A0073007400480069006E00740073005F0055006E0069006300
      6F00640065000D000A004C006100620065006C0032000100320063006C006900
      63006B00200074006F0020006D0061006E006100670065002000640072006F00
      70002000740079007000650073000100010001000100320063006C0069006300
      6B00200074006F0020006D0061006E006100670065002000640072006F007000
      2000740079007000650073000D000A004C006100620065006C00330001003200
      63006C00690063006B00200074006F0020006D0061006E006100670065002000
      7000690063006B00750070002000740079007000650073000100010001000100
      320063006C00690063006B00200074006F0020006D0061006E00610067006500
      20007000690063006B00750070002000740079007000650073000D000A004C00
      6100620065006C0034000100320063006C00690063006B00200074006F002000
      6D0061006E006100670065002000720069006E00730069006E00670020007400
      79007000650073000100010001000100320063006C00690063006B0020007400
      6F0020006D0061006E006100670065002000720069006E00730069006E006700
      2000740079007000650073000D000A007300740044006900730070006C006100
      79004C006100620065006C0073005F0055006E00690063006F00640065000D00
      0A007300740046006F006E00740073005F0055006E00690063006F0064006500
      0D000A00540046006F0072006D00520065006300690070006500440065007400
      610069006C00730001005400610068006F006D00610001000100010001005400
      610068006F006D0061000D000A00730074004D0075006C00740069004C006900
      6E00650073005F0055006E00690063006F00640065000D000A00640062006300
      62005000520049004F0052004900540041002E004900740065006D0073000100
      30002C0031002C0032002C0033002C0034002C00350001000100010001003000
      2C0031002C0032002C0033002C0034002C0035000D000A00440042004E006100
      760069006700610074006F00720031002E00480069006E007400730001002200
      4600690072007300740020007200650063006F007200640022002C0022005000
      720069006F00720020007200650063006F007200640022002C0022004E006500
      7800740020007200650063006F007200640022002C0022004C00610073007400
      20007200650063006F007200640022002C00220049006E007300650072007400
      20007200650063006F007200640022002C002200440065006C00650074006500
      20007200650063006F007200640022002C002200450064006900740020007200
      650063006F007200640022002C00220050006F00730074002000650064006900
      740022002C002200430061006E00630065006C00200065006400690074002200
      2C00220052006500660072006500730068002000640061007400610022000100
      01000100010022004600690072007300740020007200650063006F0072006400
      22002C0022005000720069006F00720020007200650063006F00720064002200
      2C0022004E0065007800740020007200650063006F007200640022002C002200
      4C0061007300740020007200650063006F007200640022002C00220049006E00
      730065007200740020007200650063006F007200640022002C00220044006500
      6C0065007400650020007200650063006F007200640022002C00220045006400
      6900740020007200650063006F007200640022002C00220050006F0073007400
      2000650064006900740022002C002200430061006E00630065006C0020006500
      64006900740022002C0022005200650066007200650073006800200064006100
      7400610022000D000A00440042004E006100760069006700610074006F007200
      32002E00480069006E0074007300010022004600690072007300740020007200
      650063006F007200640022002C0022005000720069006F007200200072006500
      63006F007200640022002C0022004E0065007800740020007200650063006F00
      7200640022002C0022004C0061007300740020007200650063006F0072006400
      22002C00220049006E00730065007200740020007200650063006F0072006400
      22002C002200440065006C0065007400650020007200650063006F0072006400
      22002C002200450064006900740020007200650063006F007200640022002C00
      220050006F00730074002000650064006900740022002C002200430061006E00
      630065006C002000650064006900740022002C00220052006500660072006500
      7300680020006400610074006100220001000100010001002200460069007200
      7300740020007200650063006F007200640022002C0022005000720069006F00
      720020007200650063006F007200640022002C0022004E006500780074002000
      7200650063006F007200640022002C0022004C00610073007400200072006500
      63006F007200640022002C00220049006E007300650072007400200072006500
      63006F007200640022002C002200440065006C00650074006500200072006500
      63006F007200640022002C002200450064006900740020007200650063006F00
      7200640022002C00220050006F00730074002000650064006900740022002C00
      2200430061006E00630065006C002000650064006900740022002C0022005200
      6500660072006500730068002000640061007400610022000D000A0073007400
      53007400720069006E00670073005F0055006E00690063006F00640065000D00
      0A00730074004F00740068006500720053007400720069006E00670073005F00
      55006E00690063006F00640065000D000A007300740043006F006C006C006500
      6300740069006F006E0073005F0055006E00690063006F00640065000D000A00
      73007400430068006100720053006500740073005F0055006E00690063006F00
      640065000D000A00540046006F0072006D005200650063006900700065004400
      65007400610069006C0073000100440045004600410055004C0054005F004300
      4800410052005300450054000100010001000100440045004600410055004C00
      54005F0043004800410052005300450054000D000A00}
  end
  object dsGalvRecipes: TDataSource
    DataSet = dmRecipes.tblGalvRecipes
    Left = 651
    Top = 111
  end
end
