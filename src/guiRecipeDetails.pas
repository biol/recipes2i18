unit guiRecipeDetails;

interface

uses
  SysUtils, Forms, Dialogs, siComp, siLngLnk, Data.DB,
  Vcl.Controls, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Mask, System.Classes,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;
type
  TFormRecipeDetails = class(TForm)
    pnlHead: TPanel;
    pnlDetail: TPanel;
    pnlFoot: TPanel;
    DBNavigator1: TDBNavigator;
    dsRecipeDetails: TDataSource;
    btnSaveData: TButton;
    dsPositions: TDataSource;
    dblcbPosizioneName: TDBLookupComboBox;
    dblcbPosizioneDscr: TDBLookupComboBox;
    Label1: TLabel;
    dsTIPIDEPO_07: TDataSource;
    Label2: TLabel;
    dblcbDrop: TDBLookupComboBox;
    dblcbPickup: TDBLookupComboBox;
    Label3: TLabel;
    dblcbRinsing: TDBLookupComboBox;
    Label4: TLabel;
    Label5: TLabel;
    dbeRINSINGCOUNT: TDBEdit;
    dsTIPIPREL_07: TDataSource;
    dsTIPIRISC_07: TDataSource;
    Label6: TLabel;
    dbeTBAGNO: TDBEdit;
    dbcbPRIORITA: TDBComboBox;
    Label7: TLabel;
    DBNavigator2: TDBNavigator;
    btnPositions: TButton;
    btnRenum: TButton;
    btnDuplicate: TButton;
    btnDropTypes: TButton;
    btnPickupTypes: TButton;
    btnRinsingTypes: TButton;
    Label8: TLabel;
    Label9: TLabel;
    dbeSPRUZZO: TDBEdit;
    dbePAUSACONTROLLO: TDBEdit;
    siLangLinked1: TsiLangLinked;
    dsGalvRecipes: TDataSource;
    lblGalvanica: TLabel;
    dblcbGalvanica: TDBLookupComboBox;
    dbgDetails: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveDataClick(Sender: TObject);
    procedure cdsRecipeDetailsNewRecord(DataSet: TDataSet);
    procedure btnPositionsClick(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure Label2DblClick(Sender: TObject);
    procedure Label3DblClick(Sender: TObject);
    procedure Label4DblClick(Sender: TObject);
    procedure btnRenumClick(Sender: TObject);
    procedure btnDuplicateClick(Sender: TObject);
    procedure btnDropTypesClick(Sender: TObject);
    procedure btnPickupTypesClick(Sender: TObject);
    procedure btnRinsingTypesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    _RecipeID, _lastStep: integer;
    _prelDepoRins: boolean;
    procedure saveData(pAsk: boolean = false);
  public

    details_ELERECIPEID
  , details_OXIVOLTSETPOINTX10
  , details_OXIAMPSETPOINT
  , details_OXIDENSITYSETPOINTX100
  , details_OXIMICRONSETPOINTX10
  , details_OXISECONDSSETPOINT: integer;

    procedure setup(pRecipeID: integer; pRecipeName, pRecipeDSCR: string);
  end;

var
  FormRecipeDetails: TFormRecipeDetails;

implementation uses guiRecipes, guiTblPositions, guiTblTIPIDROP_07,
  guiTblTIPIPICK_07, guiTblTIPIRINS_07, uEtcXE, dbiRecipes;

{$R *.dfm}

{ TFormRecipeDetails }

procedure TFormRecipeDetails.setup(pRecipeID: integer; pRecipeName, pRecipeDSCR: string);
begin
  caption := format('R e c i p e   D e t a i l s :   %d) %s - %s', [pRecipeID, pRecipeName, pRecipeDSCR]);
end;

procedure TFormRecipeDetails.btnDropTypesClick(Sender: TObject);
begin
  FormTblTIPIDROP_07.show
end;

procedure TFormRecipeDetails.btnDuplicateClick(Sender: TObject);
begin dmRecipes.DuplicateRecord(dmRecipes.tblRecipeSteps) end;

procedure TFormRecipeDetails.btnPickupTypesClick(Sender: TObject);
begin
  FormTblTIPIPICK_07.Show
end;

procedure TFormRecipeDetails.btnPositionsClick(Sender: TObject);
begin
  FormTblPositions.show
end;

procedure TFormRecipeDetails.btnRenumClick(Sender: TObject);
var i: integer;
begin   i := 0;
  with dmRecipes.tblRecipeSteps do begin
    first;
    if EOF then exit;
    while not EOF do Begin
      edit; fieldByName('ID').AsInteger := i; inc(i); post;
      next;
    End;
    i := i * 10;   _lastStep := i;
    last;
    while i > 0 do Begin
      if locate('ID', (i div 10 - 1), []) then begin
        edit; fieldByName('ID').AsInteger := i; dec(i, 10); post;
      end else showMessage('can''t locate for ' + intToStr(i));
    End;
  end;
  saveData;
end;

procedure TFormRecipeDetails.btnRinsingTypesClick(Sender: TObject);
begin
  FormTblTIPIRINS_07.show
end;

procedure TFormRecipeDetails.btnSaveDataClick(Sender: TObject);
begin
  saveData
end;

procedure TFormRecipeDetails.cdsRecipeDetailsNewRecord(DataSet: TDataSet);
begin
  with dataSet do begin
    fieldByName('IDRICETTA').AsInteger := _RecipeID;
    inc(_lastStep, 10);
    fieldByName('ID').AsInteger := _lastStep;
  end;
end;

procedure TFormRecipeDetails.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  saveData(true);
end;

procedure TFormRecipeDetails.FormCreate(Sender: TObject);
begin
  _prelDepoRins := puntoIni.ReadBool('config', 'prelDepoRins'   , true);
  btnDropTypes   .Visible := _prelDepoRins;
  btnPickupTypes .Visible := _prelDepoRins;
  btnRinsingTypes.Visible := _prelDepoRins;
end;

procedure TFormRecipeDetails.Label1DblClick(Sender: TObject);
begin
  FormTblPositions.show
end;

procedure TFormRecipeDetails.Label2DblClick(Sender: TObject);
begin
  FormTblTIPIDROP_07.show
end;

procedure TFormRecipeDetails.Label3DblClick(Sender: TObject);
begin
  FormTblTIPIPICK_07.Show
end;

procedure TFormRecipeDetails.Label4DblClick(Sender: TObject);
begin
  FormTblTIPIRINS_07.show
end;

procedure TFormRecipeDetails.saveData(pAsk: boolean);
begin
  dmRecipes.tblRecipeSteps.checkBrowseMode;
end;

end.

{

  d.IDRICETTA,
  d.ID,
  d.POSIZIONE,
  d.TBAGNO,
  d.PRIORITA,
  d.IDPRELIEVO,
  d.IDDEPOSITO,
  d.RINSINGID,
  d.RINSINGCOUNT,
  d.SPRUZZO,
  d.PAUSACONTROLLO,
  p.ID POS_ID,
  p.NAME POS_NAME,
  p.DSCR POS_DSCR,
  p.MM POS_MM,
  p.ALIAS POS_ALIAS,
  p.ISOXI POS_ISOXI,
  p.ISELE POS_ISELE,
  p.ISELE2 POS_ISELE2,
  p.ISPAUSE POS_ISPAUSE,
  p.HASDEVICE POS_HASDEVICE,
  p.ISCOLOR POS_ISCOLOR,


PATH
====
C:\Programmi\SIEMENS\SIMATIC.NCM\s7bin;
C:\Programmi\File comuni\Siemens\ACE\Bin;
e:\RailsInstaller\Git\cmd;
e:\RailsInstaller\Ruby1.9.2\bin;
C:\Programmi\Rockwell Software\RSCommon;
C:\Programmi\CollabNet\Subversion Client;
C:\Programmi\Embarcadero\RAD Studio\8.0\bin;
C:\Documents and Settings\All Users\Documenti\RAD Studio\8.0\Bpl;
C:\Programmi\CodeGear\RAD Studio\5.0\bin;
C:\Documents and Settings\All Users\Documenti\RAD Studio\5.0\Bpl;
%SystemRoot%\system32;
%SystemRoot%;
%SystemRoot%\System32\Wbem;
C:\Programmi\CodeGear\RAD Studio\5.0\lib\SDL\R5;
C:\Programmi\wkhtmltopdf;
C:\Programmi\Git\cmd;
C:\Programmi\Rockwell Automation\Common\Components;
C:\Documents and Settings\biol\Dati applicazioni\npm;
C:\Programmi\nodejs\


}
