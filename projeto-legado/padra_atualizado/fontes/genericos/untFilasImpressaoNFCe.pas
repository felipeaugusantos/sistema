unit untFilasImpressaoNFCe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, DBGridCitel, Grids, DBGrids, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, DB, Uni, frxClass,
  frxExportCSVTestabilidade, BitBtnLockedIncrem;

type
  TfrmFilasImpressaoNFCe = class(TfrmPaiSimples)
    dbgPonImp: TDBGridCitel;
    dtsFilNfc: TDataSource;
    procedure dbgPonImpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    qryFil   : TUniQuery;
    strFilImp: String;
  end;


implementation

uses untPai;

{$R *.dfm}

procedure TfrmFilasImpressaoNFCe.dbgPonImpKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (key = VK_RETURN) Then
  Begin
    strFilImp := qryFil.FieldByName('FIL_NOMIMP').AsString;
    FreeAndNil(qryFil);
    ModalResult := mrOk;
  End;

end;

procedure TfrmFilasImpressaoNFCe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If (ModalResult <> mrOk) Then
    Action := caNone
  Else
    inherited;

end;

procedure TfrmFilasImpressaoNFCe.FormShow(Sender: TObject);
begin
  inherited;

  dtsFilNfc.DataSet    := qryFil;
  dbgPonImp.DataSource := dtsFilNfc;
  qryFil.Open;

  pnlInfo.Caption := 'Pressione ENTER para selecionar';
end;

end.
