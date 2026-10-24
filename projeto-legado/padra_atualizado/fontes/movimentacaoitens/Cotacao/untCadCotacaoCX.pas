unit untCadCotacaoCX;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  untCotacao, untFuncoesSimples, cxCurrencyEdit, untTypesSistema,
  untConstantes, cxDataControllerConditionalFormattingRulesManagerDialog, cxTextEdit,
  untCotacaoTypesAndConst;

type
  TfrmCadCotacaoCX = class(TfrmPaiEdit)
    pnlHeader: TPanel;
    rdgStatus: TRadioGroup;
    btnIncluir: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnIncHer: TBitBtnLocked;
    btnExibirDetMultLoja: TBitBtnLocked;
    cxvCotacoes: TcxGridDBTableView;
    cxgCotacoesLevel1: TcxGridLevel;
    cxgCotacoes: TcxGrid;
    cxvCotacoesNUMCOT: TcxGridDBColumn;
    cxvCotacoesMULLOJ: TcxGridDBColumn;
    cxvCotacoesDTACAD: TcxGridDBColumn;
    cxvCotacoesDESCRI: TcxGridDBColumn;
    cxvCotacoesDTAFIN: TcxGridDBColumn;
    cxvCotacoesVLRTOT: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxvCotacoesCUSTOT: TcxGridDBColumn;
    cxvCotacoesCODEMP: TcxGridDBColumn;
    cxvCotacoesEMPDES: TcxGridDBColumn;
    cxvCotacoesDESTCT: TcxGridDBColumn;
    cxvCotacoesDESCOP: TcxGridDBColumn;
    cxvCotacoesSTATUS_ITEGRA: TcxGridDBColumn;
    cxvCotacoesCOT_DTALIM: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdgStatusClick(Sender: TObject);
    procedure btnExibirDetMultLojaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure cxvCotacoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnIncHerClick(Sender: TObject);
  private
    { Private declarations }
    objCotacao: TCotacao;
  public
    { Public declarations }
  end;

var
  frmCadCotacaoCX: TfrmCadCotacaoCX;

implementation

{$R *.dfm}

uses
  untFuncoesRel, untFuncoesRel2;

procedure TfrmCadCotacaoCX.btnAlterarClick(Sender: TObject);
begin
  inherited;
  objCotacao.DisableControls;
  objCotacao.blnRecuperaCotacao := False;

  objCotacao.fAlteraCotacao(opAlterar);
  objCotacao.blnRecuperaCotacao := False;
  objCotacao.blnSalvouCotacao := False;
  rdgStatusClick(Sender);

  objCotacao.EnableControls;
end;

procedure TfrmCadCotacaoCX.btnExcluirClick(Sender: TObject);
var strPedidoCompra: String;
begin
  inherited;
  If objCotacao.fTemPedidoCompraGerado(strPedidoCompra ) Then
    pMensagemOk('Esta cotação não pode ser excluída, pois tem pedido gerado para a mesma [' + strPedidoCompra + ']')
  Else
    objCotacao.fAlteraCotacao(opExcluir);
end;

procedure TfrmCadCotacaoCX.btnExibirDetMultLojaClick(Sender: TObject);
begin

  inherited;

  If objCotacao.IsEmpty Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(98, 5671, [],
                        ['SEQGER'],
                        [objCotacao.FieldByName('AUTOINCREM').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmCadCotacaoCX.btnIncHerClick(Sender: TObject);
begin
  inherited;

  objCotacao.pHeranca;
end;

procedure TfrmCadCotacaoCX.btnIncluirClick(Sender: TObject);
begin
  inherited;
  objCotacao.DisableControls;

  objCotacao.fAlteraCotacao(opIncluir);

  objCotacao.blnRecuperaCotacao := False;
  objCotacao.blnSalvouCotacao := False;
  rdgStatusClick(Sender);


  objCotacao.EnableControls;
end;

procedure TfrmCadCotacaoCX.cxvCotacoesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: Begin
                 If Shift = [ssCtrl] Then
                   Key := 0;
               End;
  End;

end;

procedure TfrmCadCotacaoCX.FormCreate(Sender: TObject);
begin
  inherited;

  objCotacao := TCotacao.Create(Self);

  cxvCotacoes.DataController.DataSource := objCotacao.dtsSource;
end;

procedure TfrmCadCotacaoCX.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6    : If btnExibirDetMultLoja.Enabled Then
                  btnExibirDetMultLojaClick(Sender);

    VK_DELETE: btnExcluir.Click;
    VK_INSERT: btnIncluir.Click;
    VK_RETURN: {If ActiveControl Is TRadioButton Then
                 pHabilitaBotoes(fAbreConsulta(TRUE))
               Else }
                 btnAlterar.Click;
  End;

end;

procedure TfrmCadCotacaoCX.FormShow(Sender: TObject);
begin
  inherited;
  cxvCotacoesSTATUS_ITEGRA.Visible := fCfgSis('UTIBID', varBoolean);
  cxvCotacoesCOT_DTALIM.Visible := fCfgSis('UTIBID', varBoolean);
  pSetFocus(btnIncluir);

end;

procedure TfrmCadCotacaoCX.rdgStatusClick(Sender: TObject);
begin
  inherited;

  Case rdgStatus.ItemIndex Of
    0: objCotacao.fAbreCotacao(stcAbertas);
    1: objCotacao.fAbreCotacao(stcBaixadas);
    2: objCotacao.fAbreCotacao(stcTodas);
  end;
End;

end.
