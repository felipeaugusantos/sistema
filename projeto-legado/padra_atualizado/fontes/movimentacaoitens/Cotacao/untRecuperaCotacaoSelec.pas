unit untRecuperaCotacaoSelec;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, untCotacao,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmRecuperaCotacaoSelec = class(TfrmPaiConfirma)
    btnDescarta: TBitBtnLocked;
    cxgPedidosLevel1: TcxGridLevel;
    cxvPedidos: TcxGridDBTableViewCitel;
    cxgPedidos: TcxGridCitel;
    cxvPedidosCODOPE: TcxGridDBColumn;
    cxvPedidosNOMOPE: TcxGridDBColumn;
    cxvPedidosCODEMP: TcxGridDBColumn;
    cxvPedidosNUMPED: TcxGridDBColumn;
    cxvPedidosDESCRI: TcxGridDBColumn;
    cxvPedidosDTAPED: TcxGridDBColumn;
    cxvPedidosCOT_HOREDI: TcxGridDBColumn;
    procedure btnDescartaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
     objCotacao: TCotacao;
  end;

var
  frmRecuperaCotacaoSelec: TfrmRecuperaCotacaoSelec;

implementation

{$R *.dfm}

procedure TfrmRecuperaCotacaoSelec.btnDescartaClick(Sender: TObject);
begin
  inherited;

  If objCotacao.cdsCotacoes.IsEmpty Then
    Exit;

  If fPergunta('Confirma o descarte da cópia de segurança da Cotação selecionado?') Then
  Begin
    objCotacao.pApaga_CopiaSeguranca(objCotacao.cdsCotacoes.FieldByName('AUTINC').AsString);
    cxvPedidos.DataController.DataSource.DataSet.Delete;
  end;

End;

procedure TfrmRecuperaCotacaoSelec.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrok Then
  Begin

    objCotacao.fMarcaCotacao(objCotacao.cdsCotacoes.FieldByName('AUTINC').AsString);

  End;

end;

end.
