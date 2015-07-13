object PasswordDlg: TPasswordDlg
  Left = 245
  Top = 108
  BorderStyle = bsNone
  Caption = 'p i n M a i l X E'
  ClientHeight = 220
  ClientWidth = 239
  Color = clGreen
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 66
    Width = 212
    Height = 13
    Caption = 'Inserire user e password (max 8 car.)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 156
    Width = 181
    Height = 26
    Caption = 'Per cambiare password inserire la nuova qui sotto due volte'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label3: TLabel
    Left = 0
    Top = 0
    Width = 239
    Height = 23
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'pinMailXE'
    Color = clYellow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = False
    ExplicitWidth = 95
  end
  object Label4: TLabel
    Left = 0
    Top = 23
    Width = 239
    Height = 26
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = 'l o g i n'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = False
    ExplicitWidth = 233
  end
  object EditUser: TEdit
    Left = 8
    Top = 84
    Width = 105
    Height = 21
    MaxLength = 8
    TabOrder = 0
  end
  object OKBtn: TButton
    Left = 70
    Top = 116
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object CancelBtn: TButton
    Left = 150
    Top = 116
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object EditPwd: TEdit
    Left = 120
    Top = 84
    Width = 105
    Height = 21
    MaxLength = 8
    PasswordChar = '*'
    TabOrder = 1
  end
  object EditNewPwd: TEdit
    Left = 8
    Top = 188
    Width = 105
    Height = 21
    MaxLength = 8
    PasswordChar = '*'
    TabOrder = 4
  end
  object EditNewPwd2: TEdit
    Left = 120
    Top = 188
    Width = 105
    Height = 21
    MaxLength = 8
    PasswordChar = '*'
    TabOrder = 5
  end
  object siLangLinked_PasswordDlg: TsiLangLinked
    Version = '7.3'
    StringsTypes.Strings = (
      'TIB_STRINGLIST'
      'TSTRINGLIST')
    StoreAsUTF8 = True
    NumOfLanguages = 3
    LangDispatcher = FormMain.siLangDispatcher1
    LangDelim = 1
    LangNames.Strings = (
      'Italiano'
      'English'
      'Other')
    Language = 'Italiano'
    CommonContainer = FormMain.siLang_FormMain
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
    Left = 104
    Top = 96
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
