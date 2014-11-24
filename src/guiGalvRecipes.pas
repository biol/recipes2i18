unit guiGalvRecipes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.DBCtrls, Vcl.StdCtrls;

type
  TFormGalvRecipes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    dsEleRecipes: TDataSource;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    dsEleRecipeSteps: TDataSource;
    Splitter1: TSplitter;
    DBGrid2: TDBGrid;
    DBNavigator2: TDBNavigator;
    btnRinumera: TButton;
    EditRenum: TEdit;
    btnDuplica: TButton;
    EditDuplica: TEdit;
    lblRel: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRinumeraClick(Sender: TObject);
    procedure btnDuplicaClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  FormGalvRecipes: TFormGalvRecipes;

implementation

{$R *.dfm}

uses dbiRecipes, guiSetpointCTRL, dbiGalvRecipes, uEtcXE;
var
  _isOxi : boolean = false;
  _isDIGI: boolean = true;
  _isBru : boolean = false;

procedure TFormGalvRecipes.btnDuplicaClick(Sender: TObject);
var iRecipe: integer;
begin
  iRecipe := strToIntDef(editDuplica.text, 0); editDuplica.text := intToStr(iRecipe);
  if iRecipe <= 0 then begin
    showMessage('Si prega di specificare un nuovo ID, intero positivo');   exit
  end;
  dmGalvRecipes.eleRecipeDuplicate(iRecipe);
end;

procedure TFormGalvRecipes.btnRinumeraClick(Sender: TObject);
var iRecipe: integer;
begin
  iRecipe := strToIntDef(editRenum.text, 0); editRenum.text := intToStr(iRecipe);
  if iRecipe <= 0 then begin
    showMessage('Si prega di specificare un nuovo ID, intero positivo');   exit
  end;
  dmGalvRecipes.eleRecipeRenum(iRecipe);
end;

procedure TFormGalvRecipes.DBGrid2DblClick(Sender: TObject);
begin with FormSetpointCTRL do begin
  hideFields(_isOxi, _isDIGI, _isBru);
  showModal
end end;

procedure TFormGalvRecipes.FormClose(Sender: TObject; var Action: TCloseAction); begin dmGalvRecipes.saveData end;

procedure TFormGalvRecipes.FormCreate(Sender: TObject);
begin
  lblRel.caption := 'Rel.' + sGetBuildInfo
end;

end.
