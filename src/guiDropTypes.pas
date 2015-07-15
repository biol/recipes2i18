unit guiDropTypes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.StdCtrls,
  Vcl.Mask, siComp, siLngLnk;

type
  TFormDropTypes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    Image1: TImage;
    dbcbFast1: TDBCheckBox;
    dbcbFast2: TDBCheckBox;
    dbcbFast3: TDBCheckBox;
    dbcbFast4: TDBCheckBox;
    dbEditPause1: TDBEdit;
    dbEditPause2: TDBEdit;
    dbEditPause3: TDBEdit;
    dbEditPause4: TDBEdit;
    dbEditQUOTE_4_OP_DM: TDBEdit;
    dbEditQUOTE_3_OP_DM: TDBEdit;
    dbEditQUOTE_2_OP_DM: TDBEdit;
    dbEditQUOTE_1_MM: TDBEdit;
    dbEditQUOTE_3_DM: TDBEdit;
    dbEditQUOTE_2_DM: TDBEdit;
    dbEditQUOTE_1_OP_DM: TDBEdit;
    lblMaximumInclination: TLabel;
    lblTopLevel: TLabel;
    DBEditTOTAL_SECS: TDBEdit;
    lblTOTAL_SECS: TLabel;
    DBEditDscr: TDBEdit;
    btnDupl: TButton;
    EditNewID: TEdit;
    lblNewID: TLabel;
    dbcbFast5: TDBCheckBox;
    dsDropTypes: TDataSource;
    siLangLinked_FormDropTypes: TsiLangLinked;
    procedure FormCreate(Sender: TObject);
    procedure dsDropTypesDataChange(Sender: TObject; Field: TField);
    procedure btnDuplClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDropTypes: TFormDropTypes;

implementation uses math, dbiPickupDropRins, uEtcXE;

{$R *.dfm}




procedure TFormDropTypes.btnDuplClick(Sender: TObject);
var iNewID: integer;
begin
  iNewID := strToIntDef(EditNewID.Text, 0);
  if iNewID < 0 then
  begin
    showMessage('Please, use a positive integer as new ID'); exit
  end;
  dmPickupDropRins.duplicateDropType(dsDropTypes.DataSet.FieldByName('ID').AsInteger, iNewID);
end;

procedure TFormDropTypes.dsDropTypesDataChange(Sender: TObject; Field: TField);
begin
  if Field = nil then btnDupl.Caption := 'Duplicate ID ' + (Sender as TDataSource).DataSet.FieldByName('ID').AsString;
end;

procedure TFormDropTypes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dsDropTypes.DataSet.CheckBrowseMode;
end;

procedure TFormDropTypes.FormCreate(Sender: TObject);
begin
  lblMaximumInclination.Caption := intToStr(k_maximumInclination_mm);
  lblTopLevel.Caption           := intToStr(k_topLevel_mm);
end;

end.


