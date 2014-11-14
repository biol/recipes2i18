unit guiTblPositions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DBCtrls, ExtCtrls, guiRecipeDetails, siComp, siLngLnk,
  Data.DB;

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
