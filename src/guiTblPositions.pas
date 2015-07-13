unit guiTblPositions;

interface

uses
  SysUtils, Forms, Dialogs, siComp, siLngLnk, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, System.Classes, Vcl.Controls, Vcl.ExtCtrls;

type
  TFormTblPositions = class(TForm)
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    siLangLinked1: TsiLangLinked;
    dsPositions: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTblPositions: TFormTblPositions;

implementation

{$R *.dfm}

uses dbiRecipes;

procedure TFormTblPositions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  with dsPositions.DataSet do if active then checkBrowseMode
end;

end.
