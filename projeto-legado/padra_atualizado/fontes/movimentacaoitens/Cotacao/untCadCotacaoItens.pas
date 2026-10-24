unit untCadCotacaoItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls;

type
  TfrmPaiOrdena1 = class(TfrmPaiOrdena)
    Label5: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label9: TLabel;
    edtQtdIte: TEditFocus;
    btnIncluir: TBitBtn;
    btnExcluir: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPaiOrdena1: TfrmPaiOrdena1;

implementation

{$R *.dfm}

end.
