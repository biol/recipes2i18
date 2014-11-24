unit guiSetpointCTRL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, ExtCtrls, Mask, DBCtrls, Buttons;

type
  TFormSetpointCTRL = class(TForm)
    dsDettaglio: TDataSource;
    lblRecipe: TLabel;
    DBEditSetpoint: TDBEdit;
    lblPausa: TLabel;
    DBEditPausa: TDBEdit;
    DBEditRampa: TDBEdit;
    Label2: TLabel;
    DBEditStasi: TDBEdit;
    Label3: TLabel;
    DBEditDescrizione: TDBEdit;
    Label4: TLabel;
    DBEditWACPOS: TDBEdit;
    lblWACPOS: TLabel;
    DBEditWACNEG: TDBEdit;
    lblWACNEG: TLabel;
    DBCbTankChanged: TDBCheckBox;
    DBCbAuxiliaryRex: TDBCheckBox;
    DBNavigator1: TDBNavigator;
    btnOK: TBitBtn;
    DBEditPro: TDBEdit;
    rgUM: TRadioGroup;
    rgElePhase: TRadioGroup;
    Label1: TLabel;
    procedure btnOKClick(Sender: TObject);
    procedure dsDettaglioDataChange(Sender: TObject; Field: TField);
    procedure rgUMClick(Sender: TObject);
    procedure rgElePhaseClick(Sender: TObject);
  private
    _isOxi: boolean;
  public
    procedure hideFields(pOxi, pDIGI, pBru: boolean);
  end;

var
  FormSetpointCTRL: TFormSetpointCTRL;

implementation uses dbiRecipes;
{$R *.dfm}

procedure TFormSetpointCTRL.btnOKClick(Sender: TObject);
begin
  close
end;

procedure TFormSetpointCTRL.dsDettaglioDataChange(Sender: TObject;
  Field: TField);
begin
  try if not (Sender as TDataSource).DataSet.Active then exit except exit end;
  if Field = nil then with (Sender as TDataSource).dataset do try
    if _isOxi     then rgUM      .ItemIndex := fieldByName('UNIT_MEASURE').AsInteger;
    if not _isOxi then rgElePhase.ItemIndex := fieldByName('ELE_PHASE'   ).AsInteger;
  except
  end
end;

procedure TFormSetpointCTRL.hideFields(pOxi, pDIGI, pBru: boolean);
begin _isOxi := pOxi; 
  with rgUM do begin
    Visible := pOXI;
    items.Clear;
    items.Add('Volt');
    if pOXI then begin
      items.Add('KAmpere');
      items.Add('Ampere/dm²');
    end;
    ItemIndex := dsDettaglio.dataset.fieldByName('UNIT_MEASURE').AsInteger;
  end;
  with rgElePhase do begin
    Visible := not pOXI;
    ItemIndex := dsDettaglio.dataset.fieldByName('ELE_PHASE').AsInteger;
  end;
  lblPausa  .Visible := not pOXI;    DBEditPausa    .Visible := not pOXI;
  lblWACPOS .Visible := not pOXI;    DBEditWACPOS   .Visible := not pOXI;
  lblWACNEG .Visible := not pOXI;    DBEditWACNEG   .Visible := not pOXI;
end;

procedure TFormSetpointCTRL.rgElePhaseClick(Sender: TObject);
begin with dsDettaglio.dataset do if active then try
  if _isOxi then exit;   // niente fase DC/AC con l'OXI
  edit;
  fieldByName('ELE_PHASE').AsInteger := (Sender as TRadioGroup).ItemIndex;
except
end end;

procedure TFormSetpointCTRL.rgUMClick(Sender: TObject);
begin with dsDettaglio.dataset do if active then try
  if not _isOxi then exit;   // solo Volt con l'ele
  edit;
  fieldByName('UNIT_MEASURE').AsInteger := (Sender as TRadioGroup).ItemIndex;
except
end end;

end.
