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

end.
