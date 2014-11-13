unit guiRecipeDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, FMTBcd, DB, DBClient, Provider, SqlExpr, Grids,
  DBGrids, DBCtrls, StdCtrls, ComCtrls, Mask, siComp, siLngLnk;

type
  TFormRecipeDetails = class(TForm)
    pnlHead: TPanel;
    pnlDetail: TPanel;
    pnlFoot: TPanel;
    DBNavigator1: TDBNavigator;
    dbgDetails: TDBGrid;
    qdsRecipeDetails: TSQLDataSet;
    dspRecipeDetails: TDataSetProvider;
    cdsRecipeDetails: TClientDataSet;
    dsRecipeDetails: TDataSource;
    btnSaveData: TButton;
    qdsPositions: TSQLDataSet;
    dspPositions: TDataSetProvider;
    cdsPositions: TClientDataSet;
    dsPositions: TDataSource;
    cdsPositionsID: TIntegerField;
    cdsPositionsMM: TIntegerField;
    cdsPositionsALIAS: TIntegerField;
    cdsPositionsISOXI: TIntegerField;
    cdsPositionsISELE: TIntegerField;
    cdsPositionsISELE2: TIntegerField;
    cdsPositionsISPAUSE: TIntegerField;
    cdsPositionsHASDEVICE: TIntegerField;
    cdsPositionsISCOLOR: TIntegerField;
    cdsRecipeDetailsIDRICETTA: TIntegerField;
    cdsRecipeDetailsID: TIntegerField;
    cdsRecipeDetailsPOSIZIONE: TIntegerField;
    cdsRecipeDetailsTBAGNO: TIntegerField;
    cdsRecipeDetailsPRIORITA: TIntegerField;
    cdsRecipeDetailsIDPRELIEVO: TIntegerField;
    cdsRecipeDetailsIDDEPOSITO: TIntegerField;
    cdsRecipeDetailsRINSINGID: TIntegerField;
    cdsRecipeDetailsRINSINGCOUNT: TIntegerField;
    cdsRecipeDetailsSPRUZZO: TIntegerField;
    cdsRecipeDetailsPAUSACONTROLLO: TIntegerField;
    cdsRecipeDetailstankDscr: TStringField;
    cdsRecipeDetailstankName: TStringField;
    dblcbPosizioneName: TDBLookupComboBox;
    dblcbPosizioneDscr: TDBLookupComboBox;
    Label1: TLabel;
    qdsTIPIDEPO_07: TSQLDataSet;
    dspTIPIDEPO_07: TDataSetProvider;
    cdsTIPIDEPO_07: TClientDataSet;
    dsTIPIDEPO_07: TDataSource;
    Label2: TLabel;
    dblcbDrop: TDBLookupComboBox;
    dblcbPickup: TDBLookupComboBox;
    Label3: TLabel;
    dblcbRinsing: TDBLookupComboBox;
    Label4: TLabel;
    Label5: TLabel;
    dbeRINSINGCOUNT: TDBEdit;
    qdsTIPIPREL_07: TSQLDataSet;
    dspTIPIPREL_07: TDataSetProvider;
    cdsTIPIPREL_07: TClientDataSet;
    dsTIPIPREL_07: TDataSource;
    qdsTIPIRISC_07: TSQLDataSet;
    dspTIPIRISC_07: TDataSetProvider;
    cdsTIPIRISC_07: TClientDataSet;
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
    cdsRecipeDetailsDESCRIZIONE: TWideStringField;
    cdsPositionsNAME: TWideStringField;
    cdsPositionsDSCR: TWideStringField;
    siLangLinked1: TsiLangLinked;
    cdsRecipeDetailsGALVANICID: TIntegerField;
    cdsRecipeDetailsRESERVECOLORCHECK: TIntegerField;
    qdsGalvRecipes: TSQLDataSet;
    dspGalvRecipes: TDataSetProvider;
    cdsGalvRecipes: TClientDataSet;
    dsGalvRecipes: TDataSource;
    cdsRecipeDetailsGalvDscr: TStringField;
    cdsGalvRecipesIDELETTROCOLORE: TIntegerField;
    cdsGalvRecipesNOME: TWideStringField;
    cdsGalvRecipesCLIENTE: TWideStringField;
    cdsGalvRecipesDESCRIZIONE: TWideStringField;
    cdsGalvRecipesCATEGORIA: TIntegerField;
    cdsGalvRecipesINUSO: TIntegerField;
    cdsGalvRecipesDISPONIBILE: TIntegerField;
    cdsGalvRecipesPREDEFINITO: TIntegerField;
    cdsGalvRecipesMICRON: TIntegerField;
    cdsGalvRecipesIDCLBR: TIntegerField;
    cdsGalvRecipesCONTINUE_PERCENTAGE: TIntegerField;
    cdsGalvRecipesRETREATMENT_PERCENTAGE: TIntegerField;
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
    procedure cdsTIPIDEPO_07NewRecord(DataSet: TDataSet);
    procedure cdsTIPIPREL_07NewRecord(DataSet: TDataSet);
    procedure cdsTIPIRISC_07NewRecord(DataSet: TDataSet);
    procedure btnDropTypesClick(Sender: TObject);
    procedure btnPickupTypesClick(Sender: TObject);
    procedure btnRinsingTypesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    _RecipeID, _lastStep: integer;
    _prelDepoRins: boolean;
    procedure saveData(pAsk: boolean = false);
  public
    lastPickupID, lastDropID, lastRinsingID: integer;

    details_ELERECIPEID
  , details_OXIVOLTSETPOINTX10
  , details_OXIAMPSETPOINT
  , details_OXIDENSITYSETPOINTX100
  , details_OXIMICRONSETPOINTX10
  , details_OXISECONDSSETPOINT: integer;

    procedure setup(pRecipeID: integer; pRecipeName: string);
    procedure DuplicateRecord(cds: TClientDataSet; pID_fieldName: string = 'ID');
    procedure DuplicateRecipe(cds: TClientDataSet; pNewRecipeID: integer; pRecipeID_fieldName: string = 'IDRICETTA');
    procedure openCDSs;
  end;

var
  FormRecipeDetails: TFormRecipeDetails;

implementation uses guiRecipes, guiTblPositions, guiTblTIPIDROP_07,
  guiTblTIPIPICK_07, guiTblTIPIRINS_07, uEtcXE;

{$R *.dfm}

{ TFormRecipeDetails }

procedure TFormRecipeDetails.setup(pRecipeID: integer; pRecipeName: string);
begin _RecipeID := pRecipeID;
  caption := format('R e c i p e   D e t a i l s :   %d) %s', [_RecipeID, pRecipeName]);
  cdsRecipeDetails.Active := false;
  qdsRecipeDetails.params.ParamValues['IDRICETTA'] := _RecipeID;

  { eliminato 22/05/2014
  if details_OXIVOLTSETPOINTX10 <> 0 then begin
    cbSetpoint.ItemIndex := 0;
  end else if details_OXIAMPSETPOINT <> 0 then begin
    cbSetpoint.ItemIndex := 1;
  end else if details_OXIDENSITYSETPOINTX100 <> 0 then begin
    cbSetpoint.ItemIndex := 2;
  end else begin
    cbSetpoint.ItemIndex := 0;
    showMessage('please select a setpoint');
  end;
  cbSetpointClick(cbSetpoint);

  if details_OXIMICRONSETPOINTX10 <> 0 then begin
    cbTarget.ItemIndex := 0;
  end else if details_OXISECONDSSETPOINT <> 0 then begin
    cbTarget.ItemIndex := 1;
  end else begin
    cbTarget.ItemIndex := 0;
    showMessage('please select a target');
  end;
  cbTargetClick(cbTarget);
  }

  with cdsRecipeDetails do begin
    Active := true;
    last;
    _lastStep := fieldByName('ID').AsInteger;
    first;
  end;
end;

procedure TFormRecipeDetails.btnDropTypesClick(Sender: TObject);
begin
  FormTblTIPIDROP_07.show
end;

procedure TFormRecipeDetails.btnDuplicateClick(Sender: TObject);
begin DuplicateRecord(cdsRecipeDetails) end;

procedure TFormRecipeDetails.DuplicateRecord(cds: TClientDataSet; pID_fieldName: string = 'ID');
var CDSClone: TClientDataSet; i: integer; fldFrom, fld: TField;
begin
  with cds do if (not active) or EOF then exit;
  CDSClone := TClientDataSet.Create(self);
  try
    CDSClone.CloneCursor(cds, True);
    with cds do begin
      edit;
      insert;
      for i := 0 to fieldDefs.count - 1 do begin
        fldFrom := CDSClone.fields[i];
        fld := FindField(fieldDefs[i].name);
        if fld <> nil then begin
          if compareText(fieldDefs[i].name, pID_fieldName) = 0 then begin
            // lascio il dato impostato dalla onNewRecord
          end else fld.assign(fldFrom);
        end else raise exception.Create(format('Field not found: %s', [fieldDefs[i].name]));
      end;   // for
      post;
    end;
  finally
    CDSClone.Free;
  end;
end;

procedure TFormRecipeDetails.DuplicateRecipe(cds: TClientDataSet; pNewRecipeID: integer; pRecipeID_fieldName: string = 'IDRICETTA');
var CDSClone: TClientDataSet; i: integer; fldFrom, fld: TField;
begin
  with cds do if (not active) or EOF then exit;
  CDSClone := TClientDataSet.Create(self);
  try
    CDSClone.CloneCursor(cds, True);
    CDSClone.first;
    while not CDSClone.EOF do begin
      if CDSClone.fieldByName(pRecipeID_fieldName).AsInteger <> pNewRecipeID then begin
        with cds do begin
          edit;
          insert;
          for i := 0 to fieldDefs.count - 1 do begin
            fldFrom := CDSClone.fields[i];
            fld := FindField(fieldDefs[i].name);
            if fld <> nil then begin
              if compareText(fieldDefs[i].name, pRecipeID_fieldName) = 0 then begin
                fld.AsInteger := pNewRecipeID;
              end else fld.assign(fldFrom);
            end else raise exception.Create(format('Field not found: %s', [fieldDefs[i].name]));
          end;   // for
          post;
        end;
      end;
      CDSClone.next;
    end;
  finally
    CDSClone.Free;
  end;
  saveData;   close
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
  with cdsRecipeDetails do begin
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

procedure TFormRecipeDetails.cdsTIPIDEPO_07NewRecord(DataSet: TDataSet);
begin inc(lastDropID);
  with Dataset do begin
    FieldByName('ID').AsInteger := lastDropID;
    FieldByName('VEL_Q1').AsInteger := -1;   // true by default
    FieldByName('VEL_Q2').AsInteger := -1;   // true by default
    FieldByName('VEL_Q3').AsInteger := -1;   // true by default
    FieldByName('VEL_Q4').AsInteger := -1;   // true by default
    FieldByName('VEL_Q5').AsInteger := -1;   // true by default
    FieldByName('VEL_ALLI').AsInteger := -1;   // true by default
    FieldByName('VEL_HILO').AsInteger := -1;   // true by default
    FieldByName('PENDENZA').AsInteger := -1;   // true by default
  end;
end;

procedure TFormRecipeDetails.cdsTIPIPREL_07NewRecord(DataSet: TDataSet);
begin   inc(lastPickupID);
  with Dataset do begin
    FieldByName('ID').AsInteger := lastPickupID;
    FieldByName('VEL_Q1').AsInteger := -1;   // true by default
    FieldByName('VEL_Q2').AsInteger := -1;   // true by default
    FieldByName('VEL_Q3').AsInteger := -1;   // true by default
    FieldByName('VEL_Q4').AsInteger := -1;   // true by default
    FieldByName('VEL_Q5').AsInteger := -1;   // true by default
    FieldByName('VEL_ALLI').AsInteger := -1;   // true by default
    FieldByName('VEL_HILO').AsInteger := -1;   // true by default
    FieldByName('PENDENZA').AsInteger := -1;   // true by default
  end;
end;

procedure TFormRecipeDetails.cdsTIPIRISC_07NewRecord(DataSet: TDataSet);
begin   inc(lastRinsingID);
  with Dataset do begin
    FieldByName('ID').AsInteger := lastRinsingID;
    FieldByName('VEL_Q1').AsInteger := -1;   // true by default
    FieldByName('VEL_Q2').AsInteger := -1;   // true by default
    FieldByName('VEL_Q3').AsInteger := -1;   // true by default
    FieldByName('VEL_ALLI').AsInteger := -1;   // true by default
    FieldByName('VEL_HILO').AsInteger := -1;   // true by default
    FieldByName('PENDENZA').AsInteger := -1;   // true by default
  end;
end;

procedure TFormRecipeDetails.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  saveData(true);
  cdsRecipeDetails.Close;
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

procedure TFormRecipeDetails.openCDSs;
begin
  cdsPositions    .Active := true;
  with cdsTIPIDEPO_07 do begin
    Active := true;   last;   lastDropID := fieldByName('ID').AsInteger;
  end;
  with cdsTIPIPREL_07 do begin
    Active := true;   last;   lastPickupID := fieldByName('ID').AsInteger;
  end;
  with cdsTIPIRISC_07 do begin
    Active := true;   last;   lastRinsingID := fieldByName('ID').AsInteger;
  end;
end;

procedure TFormRecipeDetails.saveData(pAsk: boolean);
var f: extended;
begin
  with cdsRecipeDetails do begin
    checkBrowseMode;
    if changeCount > 0 then begin
      if pAsk and (messageDlg('save data ?', mtConfirmation, [mbOK, mbCancel], 0) <> mrOK) then exit;
      applyUpdates(0);
    end;
  end;

(*  // setpoint                                eliminato 22/05/2014
  details_OXIVOLTSETPOINTX10     := 0;
  details_OXIAMPSETPOINT         := 0;
  details_OXIDENSITYSETPOINTX100 := 0;
  f := strToFloat(EditSetpoint.Text);
  case cbSetpoint.itemIndex of
  0: {volt   x 10}   begin details_OXIVOLTSETPOINTX10     := round(f * 10)   end;
  1: {ampere x 1000} begin details_OXIAMPSETPOINT         := round(f * 1000) end;
  2: {a/dm2  x 100}  begin details_OXIDENSITYSETPOINTX100 := round(f * 100 ) end;
  end;

  // target
  details_OXIMICRONSETPOINTX10 := 0;
  details_OXISECONDSSETPOINT   := 0;
  f := strToFloat(EditTarget.Text);
  case cbTarget.itemIndex of
  0: {micron x 10}  begin details_OXIMICRONSETPOINTX10 := round(f * 10) end;
  1: {seconds x 60} begin details_OXISECONDSSETPOINT   := round(f * 60) end;
  end;
*)
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
