unit untFatMostraProdNaoDevolver;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, AppEvnts {Qt,},
  BitBtnLockedIncrem, DBCtrls, DBMemoFocus, frxClass, frxExportCSVTestabilidade, strUtils,
  Datasnap.DBClient;

type
  TfrmFatMostraProdNaoDevolver = class(TfrmPaiSimples)
    dbgItens: TDBGridCitel;
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtnLocked;
    cdsItens: TUniClientDataSet;
    cdsItensITE_CODITE: TStringField;
    cdsItensITE_DESITE: TStringField;
    cdsItensITE_QTDITE: TFloatField;
    cdsItensITE_SALDOS: TFloatField;
    dtsItens: TDataSource;
    splMensagemItem: TSplitter;
    cdsItensITE_TOTAL: TFloatField;
    procedure btnFecharClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure pAbreClientItens;
    Procedure pFechaClientItens;
    Procedure pIncluiItem(strCodIte,
                          strDesIte: String;
                          fltQtdIte,
                          fltVlrUni,
                          fltVlrTot: Double);
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatMostraProdNaoDevolver.btnFecharClick(Sender: TObject);
begin
  inherited;
  pFechaClientItens;
  Close;
end;

procedure TfrmFatMostraProdNaoDevolver.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
    btnFechar.Click;
end;

Procedure TfrmFatMostraProdNaoDevolver.pAbreClientItens;
Begin
  cdsItens.CreateDataSet;
  cdsItens.Open;
  dbgItens.DataSource := dtsItens;
End;

Procedure TfrmFatMostraProdNaoDevolver.pFechaClientItens;
Begin
  cdsItens.Close;
End;

Procedure TfrmFatMostraProdNaoDevolver.pIncluiItem(strCodIte,
                                                   strDesIte: String;
                                                   fltQtdIte,
                                                   fltVlrUni,
                                                   fltVlrTot: Double);
Begin
  Try

    With cdsItens Do
    Begin
      Insert;
      FieLdByName('ITE_CODITE').AsString := strCodIte;
      FieLdByName('ITE_DESITE').AsString := strDesIte;
      FieLdByName('ITE_QTDITE').AsFloat  := fltQtdIte;
      FieLdByName('ITE_VALOR').AsFloat := fltVlrUni;
      FieLdByName('ITE_TOTAL').AsFloat := fltVlrTot;
      Post;
    End;

  Except

    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmFatMostraProdNaoDevolver.pIncluiItem]');
    End;

  End;

End;

end.
