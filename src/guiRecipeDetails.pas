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
    btnRenum: TButton;
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
    btnPositions: TButton;
    lblNewRecipe: TLabel;
    editNewRecipeID: TEdit;
    lblCopyFromID: TLabel;
    EditCopyFromID: TEdit;
    btnNewRecipe: TButton;
    btnGalvanica: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsRecipeDetailsNewRecord(DataSet: TDataSet);
    procedure btnPositionsClick(Sender: TObject);
    procedure Label1DblClick(Sender: TObject);
    procedure Label2DblClick(Sender: TObject);
    procedure Label3DblClick(Sender: TObject);
    procedure Label4DblClick(Sender: TObject);
    procedure btnRenumClick(Sender: TObject);
    procedure btnDropTypesClick(Sender: TObject);
    procedure btnPickupTypesClick(Sender: TObject);
    procedure btnRinsingTypesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNewRecipeClick(Sender: TObject);
    procedure btnGalvanicaClick(Sender: TObject);
  private
    _RecipeID, _lastStep: integer;
    _prelDepoRins: boolean;
    procedure saveData;
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
  guiTblTIPIPICK_07, guiTblTIPIRINS_07, uEtcXE, dbiRecipes, guiGalvRecipes;

{$R *.dfm}

{ TFormRecipeDetails }

procedure TFormRecipeDetails.setup(pRecipeID: integer; pRecipeName, pRecipeDSCR: string);
begin   _RecipeID := pRecipeID;
  caption := format('R e c i p e   D e t a i l s :   %d) %s - %s', [pRecipeID, pRecipeName, pRecipeDSCR]);
end;

procedure TFormRecipeDetails.btnDropTypesClick(Sender: TObject);
begin
  FormTblTIPIDROP_07.show
end;

procedure TFormRecipeDetails.btnGalvanicaClick(Sender: TObject);
begin
  FormGalvRecipes.showModal
end;

procedure TFormRecipeDetails.btnNewRecipeClick(Sender: TObject);
var newID, copyFromID: integer;   sNewName: string;  tblName: string;
begin
  saveData;
  newID := strToIntDef(editNewRecipeID.Text, 0);   editNewRecipeID.Text := intToStr(newID);
  // verifica NON esistenza di newID e che sia > 0
  if newID <= 0 then begin
    showMessage('you can only use positive integers for NEW type ID');   exit
  end;
  if dmRecipes.stepExists(_RecipeID, newID) then begin
    showMessage(format('NEW step %d already exists.', [newID]));   exit
  end;

  copyFromID := strToIntDef(EditCopyFromID .Text, 0);   EditCopyFromID .Text := intToStr(copyFromID);
  // verifica esistenza di copyFromID se e solo se è > 0
  if (copyFromID > 0) and (not dmRecipes.stepExists(_RecipeID, copyFromID)) then begin
    showMessage(format('"copy from" type %d does not exist.', [copyFromID]));   exit
  end;

  // se l'utente conferma ... facciamo un paio di query di inserimento ...
  if (copyFromID > 0) then begin
    if messageDlg(format('Confirm copying existing type %d to NEW type %d ?',
      [copyFromID, newID]), mtConfirmation, [mbOK, mbCancel], 0) <> mrOK then exit;
      sNewName := siLangLinked1.GetTextOrDefault('IDS_6' (* 'copy of' *) ) + intToStr(copyFromID);
  end else begin
    if messageDlg(format('Confirm creating a new EMPTY step at %d ?',
      [newID]), mtConfirmation, [mbOK, mbCancel], 0) <> mrOK then exit;
      sNewName := 'new type';
  end;

  if copyFromID = 0 then begin
    dmRecipes.buildNewEmptyStep(_RecipeID, newID, sNewName);
    exit;  // bona lè
  end;

  // duplica
  dmRecipes.copyStepFromTo(_RecipeID, copyFromID, newID);   // preparo di dettagli della new recipe
end;

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
  with dmRecipes.tblRecipeSteps do try
    disableControls;
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
  finally
    enableControls
  end;
  saveData;
end;

procedure TFormRecipeDetails.btnRinsingTypesClick(Sender: TObject);
begin
  FormTblTIPIRINS_07.show
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
  saveData;
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

procedure TFormRecipeDetails.saveData;
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
