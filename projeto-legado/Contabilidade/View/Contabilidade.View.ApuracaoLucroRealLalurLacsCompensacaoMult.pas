unit Contabilidade.View.ApuracaoLucroRealLalurLacsCompensacaoMult;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, cxTextEdit,
  cxCurrencyEdit, CurrencyEditFocus, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Datasnap.DBClient,
  UniClientDataSet, MemDS, DBAccess, Uni, Contabilidade.Interfaces, cxCalc;

type
  TfrmApuracaoLucroRealLalurLacsCompensacaoMult = class(TfrmPaiConfirmaContabilidade)
    GridCitelTableView: TcxGridDBTableViewCitel;
    GridCitelLevel1: TcxGridLevel;
    GridCitel: TcxGridCitel;
    pnlCabecalho: TPanel;
    cxLabel1: TcxLabel;
    lbDescricaoACompensar: TcxLabel;
    edtDescricaoACompensar: TCurrencyEditFocus;
    dsCompensacao: TDataSource;
    GridCitelTableViewCTA_CODCON: TcxGridDBColumn;
    GridCitelTableViewCTA_DESCRI: TcxGridDBColumn;
    GridCitelTableViewCTA_VLDISP: TcxGridDBColumn;
    GridCitelTableViewCTA_VLACOM: TcxGridDBColumn;
    GridCitelTableViewCTA_VLRSAL: TcxGridDBColumn;
    cxLabel2: TcxLabel;
    edtValorRestante: TCurrencyEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure GridCitelTableViewCTA_VLACOMPropertiesEditValueChanged(
      Sender: TObject);
    procedure GridCitelTableViewFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure btnConfirmaClick(Sender: TObject);
  private
    FblnControleSetFocus: boolean ;
    FllTipo: TLacsLalur ;
    FdtaVigenciaInicial: TDateTime ;
    FfltValorACompensar: double ;
    FcdsCompensacoes: TUniClientDataSet ;
    FcdsCompensacoesNaoOperacional: TUniClientDataSet ;
    FstrAutoIncCompensacao: string ;
    FstrCodEmp: String ;
    function fValidaValorInformadoComACompensar(const AfltACompensar: double; const AcdsCompensacoes: TUniClientDataSet):boolean ;
    procedure pAjustaSaldoDisponivel(const AfltValorInformado: double) ;
    function fValidaCompensacaoCompleta(const AfltACompensar: double; const AcdsCompensacoes: TUniClientDataSet): boolean ;
    function fRetornaValorInformadoACompensar(const AcdsCompensacoes: TUniClientDataSet): double ;
    function fRetornaValorRestante(const AcdsCompensacoes: TUniClientDataSet; const AfltACompensar: double): double ;
    { Private declarations }
  public
    { Public declarations }
    property Tipo: TLacsLalur read FllTipo write FllTipo ;
    property VigenciaInicial: TDateTime read FdtaVigenciaInicial write FdtaVigenciaInicial ;
    property ValorACompensar: double read FfltValorACompensar write FfltValorACompensar ;
    property CompensacoesOperacionais: TUniClientDataSet read FcdsCompensacoes ;
    property CompensacoesNaoOperacionais: TUniClientDataSet read FcdsCompensacoesNaoOperacional ;
    property AutoIncCompensacao: String read FstrAutoIncCompensacao write FstrAutoIncCompensacao ;
    property CodEmp: String read FstrCodEmp write FstrCodEmp ;
  end;

implementation

uses untFuncoesSimples, Contabilidade.Classes.ApuracaoLucroRealLalurLacs ;

{$R *.dfm}

procedure TfrmApuracaoLucroRealLalurLacsCompensacaoMult.btnConfirmaClick(
  Sender: TObject);
begin

  if not fValidaCompensacaoCompleta(edtDescricaoACompensar.Value, FcdsCompensacoes) then
  begin
    fMensagem('ATENÇÃO!', 'A soma dos valores da coluna "Valor a Compensar" deve ser igual a [' + formatCurr('#,##0.00', edtDescricaoACompensar.Value) + ']!', ['&Ok']);
    pSetFocus(GridCitel);
    exit ;
  end;

  if not fValidaValorInformadoComACompensar(edtDescricaoACompensar.Value, FcdsCompensacoes) then
  begin
    pSetFocus(GridCitel);
    exit ;
  end;

  inherited;

end;

procedure TfrmApuracaoLucroRealLalurLacsCompensacaoMult.FormCreate(
  Sender: TObject);
begin
  inherited;
  pCriaEstruturaACompensar(FcdsCompensacoes) ;
  pCriaEstruturaACompensar(FcdsCompensacoesNaoOperacional) ;
  dsCompensacao.Enabled := False ;
  try
    dsCompensacao.DataSet := FcdsCompensacoes ;
  finally
    dsCompensacao.Enabled := True ;
  end;
  FblnControleSetFocus := False ;
end;

procedure TfrmApuracaoLucroRealLalurLacsCompensacaoMult.FormDestroy(
  Sender: TObject);
begin
  inherited;
  FreeAndNil(FcdsCompensacoes) ;
  FreeAndNil(FcdsCompensacoesNaoOperacional) ;
end;

procedure TfrmApuracaoLucroRealLalurLacsCompensacaoMult.FormShow(
  Sender: TObject);
begin
  inherited;
  if FllTipo = llLacs then
  begin
    lbDescricaoACompensar.Caption := 'BC Negativa da CSLL a Compensar:' ;
  end
  else if FllTipo = llLalur then
  begin
    lbDescricaoACompensar.Caption := 'Prejuízos Fiscais - Operacionais a Compensar:' ;
  end
  else
  begin
    lbDescricaoACompensar.Caption := '' ;
  end;
  edtDescricaoACompensar.Value := FfltValorACompensar ;
  pRetornaResumoCompesacao(FdtaVigenciaInicial, FllTipo, FcdsCompensacoes, FcdsCompensacoesNaoOperacional, FstrCodEmp) ;
  pCarregaACompensarInformado(FcdsCompensacoes, FstrAutoIncCompensacao) ;
  edtValorRestante.Value := fRetornaValorRestante(FcdsCompensacoes, edtDescricaoACompensar.Value) ;
end;

function TfrmApuracaoLucroRealLalurLacsCompensacaoMult.fRetornaValorInformadoACompensar(
  const AcdsCompensacoes: TUniClientDataSet): double;
var
  LcdsAux: TUniClientDataSet ;
begin
  result := 0.00 ;
  LcdsAux := TUniClientDataSet.Create(Nil) ;
  try
    LcdsAux.Data := AcdsCompensacoes.Data ;
    LcdsAux.First ;
    while not LcdsAux.Eof do
    begin
      result := result + fFormataFloat(LcdsAux.FieldByName('CTA_VLACOM').AsFloat, 2) ;
      LcdsAux.Next ;
    end;
  finally
    FreeAndNil(LcdsAux) ;
  end;
end;

function TfrmApuracaoLucroRealLalurLacsCompensacaoMult.fRetornaValorRestante(
  const AcdsCompensacoes: TUniClientDataSet;
  const AfltACompensar: double): double;
begin
  result := fFormataFloat(AfltACompensar - fRetornaValorInformadoACompensar(AcdsCompensacoes), 2) ;
end;

function TfrmApuracaoLucroRealLalurLacsCompensacaoMult.fValidaCompensacaoCompleta(
  const AfltACompensar: double;
  const AcdsCompensacoes: TUniClientDataSet): boolean;
var
  LfltValorInformadoACompensar: Double ;
begin
  LfltValorInformadoACompensar := fRetornaValorInformadoACompensar(AcdsCompensacoes) ;
  result := fFormataFloat(LfltValorInformadoACompensar,2) = fFormataFloat(AfltACompensar,2) ;
end;

function TfrmApuracaoLucroRealLalurLacsCompensacaoMult.fValidaValorInformadoComACompensar(
  const AfltACompensar: double; const AcdsCompensacoes: TUniClientDataSet): boolean;
var
  LfltSoma : Double ;
begin
  result := False ;
  LfltSoma := fRetornaValorInformadoACompensar(AcdsCompensacoes) ;

  if fFormataFloat(LfltSoma,2) > fFormataFloat(AfltACompensar,2) then
  begin
    fMensagem('ATENÇÃO!', 'Soma dos valores [' + formatCurr('#,##0.00', LfltSoma) + '] não pode ser maior que [' + formatCurr('#,##0.00', AfltACompensar) + ']!', ['&Ok']);
    exit ;
  end;

  result := True ;
end;

procedure TfrmApuracaoLucroRealLalurLacsCompensacaoMult.GridCitelTableViewCTA_VLACOMPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if fFormataFloat(TcxCalcEdit(Sender).Value, 2) < 0 then
  begin
    fMensagem('ATENÇÃO!', 'Informe valores positivos!', ['&Ok']);
    TcxCalcEdit(Sender).Undo;
    FblnControleSetFocus := True ;
    exit ;
  end;

  if fFormataFloat(TcxCalcEdit(Sender).Value, 2) > fFormataFloat(GridCitelTableViewCTA_VLDISP.DataBinding.Field.AsFloat, 2) then
  begin
    fMensagem('ATENÇÃO!', 'Valor a compensar [' + formatCurr('#,##0.00', TcxCalcEdit(Sender).Value) + '] deve ser menor ou igual ao valor disponível [' + formatCurr('#,##0.00', GridCitelTableViewCTA_VLDISP.DataBinding.Field.AsFloat ) + ']!', ['&Ok']);
    TcxCalcEdit(Sender).Undo;
    FblnControleSetFocus := True ;
    exit ;
  end;

  TcxCalcEdit(Sender).PostEditValue ;

  pAjustaSaldoDisponivel(TcxCalcEdit(Sender).Value) ;

end;

procedure TfrmApuracaoLucroRealLalurLacsCompensacaoMult.GridCitelTableViewFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  if (FblnControleSetFocus) and (APrevFocusedItem = GridCitelTableViewCTA_VLACOM) then
  begin
    FblnControleSetFocus := False ;
    APrevFocusedItem.Focused := True ;
  end;
end;

procedure TfrmApuracaoLucroRealLalurLacsCompensacaoMult.pAjustaSaldoDisponivel(
  const AfltValorInformado: double);
begin
  GridCitelTableView.DataController.DataSet.Edit ;
  GridCitelTableViewCTA_VLRSAL.DataBinding.Field.AsFloat := fFormataFloat(GridCitelTableViewCTA_VLDISP.DataBinding.Field.AsFloat - AfltValorInformado, 2) ;

  ////calcula o valor restante
  edtValorRestante.Value := fRetornaValorRestante(FcdsCompensacoes, edtDescricaoACompensar.Value) ;
end;


end.
