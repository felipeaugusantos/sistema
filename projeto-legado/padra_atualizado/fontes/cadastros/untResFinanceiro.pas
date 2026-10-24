Unit untResFinanceiro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils,
  Uni, AppEvnts, DB, DateUtils, BitBtnLockedIncrem, untConstantes, MemDS,
  frxClass, frxExportCSVTestabilidade, cxProgressBar,
  UniClientDataSet, Datasnap.DBClient, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons, Vcl.Mask, MaskEditFocus, dxScreenTip,
  cxClasses, dxCustomHint, cxHint;

type
  TfrmResFinanceiro = class(TfrmPai)
    pnlCliente: TPanel;
    Panel2: TPanel;
    pnlUltCom: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtNumNota: TEditFocus;
    edtVrUltCom: TEditFocus;
    edtInativo: TEditFocus;
    edtDtaUltCom: TEditFocus;
    pnlAtrasados: TPanel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    edtMaiorAtrasado: TEditFocus;
    edtAtualAtrasado: TEditFocus;
    edtMediaAtrasado: TEditFocus;
    pnlCadastro: TPanel;
    lbl1: TLabel;
    edtAcumulo: TEditFocus;
    edtPonderadaAtraso: TEditFocus;
    Label13: TLabel;
    btnObsCli: TBitBtnLocked;
    edtAcumuloAno: TEditFocus;
    edtDtaMaiAcumulo: TEditFocus;
    Label17: TLabel;
    Label18: TLabel;
    Label34: TLabel;
    pnlDataCadastro: TPanel;
    Label35: TLabel;
    edtCadastro: TEditFocus;
    btnDadosCobr: TBitBtnLocked;
    pnlDadosCliente: TPanel;
    pnlRedLoj: TPanel;
    Label1: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label38: TLabel;
    edtCodRedLoj: TEditFocus;
    edtDesRedLoj: TEditFocus;
    chkRedLoj: TCheckBox;
    lblCpfCnpjCliente: TLabel;
    edtCpfCnpjCliente: TEditFocus;
    btnCopiarCpfCnpj: TcxButton;
    btnAlterarLimCre: TBitBtnLocked;
    Panel1: TPanel;
    pnlDados: TPanel;
    Panel5: TPanel;
    lblChequeAVista: TLabel;
    lblChequeAPrazo: TLabel;
    lblPredatados: TLabel;
    Label4: TLabel;
    edtQtdChequeAVistaEmAberto: TEditFocus;
    edtQtdChequeAPrazoEmAberto: TEditFocus;
    edtValorChequeAVistaEmAberto: TEditFocus;
    edtValorChequeAPrazoEmAberto: TEditFocus;
    edtQtdChequeAVistaLiquidados: TEditFocus;
    edtQtdChequeAPrazoLiquidados: TEditFocus;
    edtValorChequeAVistaLiquidados: TEditFocus;
    edtValorChequeAPrazoLiquidados: TEditFocus;
    btnChequeAVistaEmAberto: TBitBtnLocked;
    btnChequeAPrazoEmAberto: TBitBtnLocked;
    btnChequeAVistaLiquidado: TBitBtnLocked;
    btnChequeAPrazoLiquidado: TBitBtnLocked;
    edtQtdAberto2: TEditFocus;
    edtVrAberto2: TEditFocus;
    btnChqPreAberto: TBitBtnLocked;
    edtQtdLiq2: TEditFocus;
    edtVrLiq2: TEditFocus;
    btnChqPreLiquidado: TBitBtnLocked;
    edtQtdAberto3: TEditFocus;
    edtVrAberto3: TEditFocus;
    btnChqDevAberto: TBitBtnLocked;
    edtQtdLiq3: TEditFocus;
    edtVrLiq3: TEditFocus;
    btnChqDevLiquidado: TBitBtnLocked;
    pnlPedNaoFat: TPanel;
    Label16: TLabel;
    edtQtdPedNaoFat: TEditFocus;
    edtTotPedNaoFat: TEditFocus;
    btnPedNaoFat: TBitBtnLocked;
    Panel7: TPanel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label23: TLabel;
    lblTitulosDentroPrazo: TLabel;
    edtQtdAberto1: TEditFocus;
    edtVrAberto1: TEditFocus;
    edtQtdLiq1: TEditFocus;
    edtVrLiq1: TEditFocus;
    btnTitAberto: TBitBtnLocked;
    btnTitLiquidado: TBitBtnLocked;
    edtAtrasQtd: TEditFocus;
    edtAtrasVr: TEditFocus;
    edtAtrasLiqQtd: TEditFocus;
    edtAtrasLiqVr: TEditFocus;
    btnTitAtrasado: TBitBtnLocked;
    btnTitLiqAtrasado: TBitBtnLocked;
    edtQtdDentroPrazoAberto: TEditFocus;
    edtValorDentroPrazoAberto: TEditFocus;
    btnTitulosDentroPrazoAberto: TBitBtnLocked;
    edtQtdDentroPrazoLiquidado: TEditFocus;
    edtValorDentroPrazoLiquidado: TEditFocus;
    btnTitulosDentroPrazoLiquidado: TBitBtnLocked;
    Panel6: TPanel;
    Label22: TLabel;
    edtTotalQtd: TEditFocus;
    edtTotalVr: TEditFocus;
    edtTotalLiqQtd: TEditFocus;
    edtTotalLiqValor: TEditFocus;
    pnlEPemAberto: TPanel;
    Label12: TLabel;
    edtQtdEPemAberto: TEditFocus;
    edtTotEPemAberto: TEditFocus;
    btnEmpAberto: TBitBtnLocked;
    Panel8: TPanel;
    Label31: TLabel;
    Label36: TLabel;
    edtQtdAbertoCred: TEditFocus;
    edtVrAbertoCred: TEditFocus;
    btnCredAberto: TBitBtnLocked;
    edtQtdLiqCred: TEditFocus;
    edtVrLiqCred: TEditFocus;
    btnCredLiquidado: TBitBtnLocked;
    edtTeleQtd: TEditFocus;
    edtTeleVr: TEditFocus;
    edtTeleLiqQtd: TEditFocus;
    edtTeleLiqVr: TEditFocus;
    btnTelechequeEmAberto: TBitBtnLocked;
    btnTelechequeLiquidado: TBitBtnLocked;
    Panel9: TPanel;
    Label37: TLabel;
    Label39: TLabel;
    edtQtdPrd: TEditFocus;
    edtLiqPrd: TEditFocus;
    edtMedPrd: TEditFocus;
    edtMedLiqPrd: TEditFocus;
    pnlDados2: TPanel;
    Panel3: TPanel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    edtLimTotal: TEditFocus;
    edtDisponivel: TEditFocus;
    edtCreditos: TEditFocus;
    btnExiCre: TBitBtnLocked;
    Panel4: TPanel;
    Label30: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label11: TLabel;
    edtMaiorCompra: TEditFocus;
    edtDtaMaiorCompra: TEditFocus;
    edtNotaMaiorComp: TEditFocus;
    mskCndPag: TMaskEditFocus;
    Label40: TLabel;
    btnLimiteAlpe: TBitBtnLocked;
    lblLimiteAlpe: TLabel;
    lblCash: TLabel;
    edtQtdAbertoCash: TEditFocus;
    edtVrAbertoCash: TEditFocus;
    btnCashAberto: TBitBtnLocked;
    edtQtdLiqCash: TEditFocus;
    edtVrLiqCash: TEditFocus;
    btnCashLiquidado: TBitBtnLocked;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);

    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure FormShow(Sender: TObject);

    function fAtribuiValores(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure btnObsCliClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnTitAbertoClick(Sender: TObject);
    procedure btnChqPreAbertoClick(Sender: TObject);
    procedure btnChqDevAbertoClick(Sender: TObject);
    procedure btnTitAtrasadoClick(Sender: TObject);
    procedure btnTitLiquidadoClick(Sender: TObject);
    procedure btnChqPreLiquidadoClick(Sender: TObject);
    procedure btnChqDevLiquidadoClick(Sender: TObject);
    procedure btnTitLiqAtrasadoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnExiCreClick(Sender: TObject);
    procedure btnPedNaoFatClick(Sender: TObject);
    procedure edtCadastroMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edtAcumuloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edtCadastroMouseLeave(Sender: TObject);
    procedure edtAcumuloMouseLeave(Sender: TObject);
    procedure edtPonderadaAtrasoMouseLeave(Sender: TObject);
    procedure edtAtualAtrasadoMouseLeave(Sender: TObject);
    procedure edtMaiorAtrasadoMouseLeave(Sender: TObject);
    procedure edtMediaAtrasadoMouseLeave(Sender: TObject);
    procedure edtMediaAtrasadoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edtMaiorAtrasadoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edtAtualAtrasadoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edtPonderadaAtrasoMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure edtAcumuloAnoMouseLeave(Sender: TObject);
    procedure edtDtaMaiAcumuloMouseLeave(Sender: TObject);
    procedure edtAcumuloAnoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edtDtaMaiAcumuloMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure chkRedLojClick(Sender: TObject);
    procedure btnCredAbertoClick(Sender: TObject);
    procedure btnCashAbertoClick(Sender: TObject);
    procedure btnCredLiquidadoClick(Sender: TObject);
    procedure btnCashLiquidadoClick(Sender: TObject);
    procedure btnDadosCobrClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCopiarCpfCnpjClick(Sender: TObject);
    procedure btnAlterarLimCreClick(Sender: TObject);
    procedure btnEmpAbertoClick(Sender: TObject);
    procedure btnTitulosDentroPrazoAbertoClick(Sender: TObject);
    procedure btnTitulosDentroPrazoLiquidadoClick(Sender: TObject);
    procedure btnTelechequeEmAbertoClick(Sender: TObject);
    procedure btnTelechequeLiquidadoClick(Sender: TObject);
    procedure btnChequeAVistaEmAbertoClick(Sender: TObject);
    procedure btnChequeAVistaLiquidadoClick(Sender: TObject);
    procedure btnChequeAPrazoEmAbertoClick(Sender: TObject);
    procedure btnChequeAPrazoLiquidadoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLimiteAlpeClick(Sender: TObject);

  private
    blnAjustaData : Boolean;
    procedure pCarregaDados();
    function DefaultCheckBoxMesmaRedeDeLoja: Boolean;
    function fRetTitAberto(strExp: String): Double;
    function fRetTitLiquidado(strExp: String): Double;
    function fRetChqLiquidados(strExp: String): Double;
    function fRetChqDevolvidosLiq(strExp: String): Double;
    function fRetCreditos(strExp: String): Double;
    function fRetCashback(strExp: String): Double;
    function fRetTitAtrasados(strExp: String): Double;
    function fRetTitAtrasadosLiq(strExp: String): Double;
    function fRetTelecheques(strExp: String): Double;
    function fRetTelechequesLiq(strExp: String): Double;
    function fRetCreditosLiq(strExp: String): Double;
    function fRetCashbackLiq(strExp: String): Double;

    function fRetTitulosDentroPrazoEmAberto(strExp: String): Double;
    function fRetTitulosDentroPrazoLiquidados(strExp: String): Double;
    function fRetChequeAVistaEmAberto(strExp: String): Double;
    function fRetChequeAVistaLiquidados(strExp: String): Double;
    function fRetChequeAPrazoEmAberto(strExp: String): Double;
    function fRetChequeAPrazoLiquidados(strExp: String): Double;

    procedure pLimpaInfo;
    Procedure pVisibleCampoCashback;
    { Private declarations }
    Type TPonderada = Record
      intDiasAtr: Double;
      fltTotVlr : Double;
      fltTotPon : Double;
    End;

    procedure pTrazProrrogacoes;
    function fDataAcumulados: TDate;
    function fRetornaMediaPonderada: String;
    function fRetornaMediaPonderadaNova:String;
    function fBuscaMaiorAtrasado:String;

    function fGetSqlDtaVenctoOriginal(blnAS:Boolean = true):String;

    procedure pAtribuiUltimaCompra();
    procedure pAtribuiMaiorCompra();
    procedure pAtribuiAcumulados();
  protected
      function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  private
    strRedLoj: String;
  public
    { Public declarations }
    strCodCli: String;
    blnVeioFatVendas : Boolean;
    blnClienteProfissional: Boolean;
    blnPermiteEditarArquivosDeConsultaDeCredito : Boolean;
    function fValRedLoj(Const strCodCli: String): Boolean;
    procedure pSetaAjusteData(ajuste:Boolean);
  end;

var
  frmResFinanceiro: TfrmResFinanceiro;
  blnChkRed: Boolean;
  //function fRetSQL(typTab: typTipTab; typCon: typTipCon; strRedeLoja: String = ''): String;

implementation

uses  untfuncoesSimples, untTypesSistema, untFatMostraObsCliente,
      untConsultas, untGravando,
      untFuncoesRel, untFuncoesGenerica, ClipBrd, untMostraDadosCobranca,
      untLimiteCredito, untAlpePaymentProductsArrangements;

{$R *.dfm}

procedure TfrmResFinanceiro.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;

  If (edtCodCliente.ReadOnly) Then
    Exit;

  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;
procedure TfrmResFinanceiro.edtDtaMaiAcumuloMouseLeave(Sender: TObject);
begin
  inherited;
  pLimpaInfo;
end;

procedure TfrmResFinanceiro.edtDtaMaiAcumuloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  pnlInfo.Caption := 'Data do maior valor acumulado de títulos em aberto no dia';
end;

procedure TfrmResFinanceiro.edtMaiorAtrasadoMouseLeave(Sender: TObject);
begin
  inherited;
  pLimpaInfo;
end;

procedure TfrmResFinanceiro.edtMaiorAtrasadoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  pnlInfo.Caption := 'Maior quantidade de dias em atraso de títulos já pagos';
end;

procedure TfrmResFinanceiro.edtMediaAtrasadoMouseLeave(Sender: TObject);
begin
  inherited;
  pLimpaInfo;
end;

procedure TfrmResFinanceiro.edtMediaAtrasadoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  pnlInfo.Caption := 'Média da quantidade de dias em atraso de títulos já pagos';
end;

procedure TfrmResFinanceiro.edtPonderadaAtrasoMouseLeave(Sender: TObject);
begin
  inherited;
  pLimpaInfo;
end;

procedure TfrmResFinanceiro.edtPonderadaAtrasoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  pnlInfo.Caption := 'Média ponderada da quantidade de dias em atraso de títulos já pagos';
end;

{****************************************}
{* FUNÇÃO QUE CALCULA A MÉDIA PONDERADA *}
{* E JOGA O VALOR NO EDIT               *}
{*************************************JU*}
function TfrmResFinanceiro.fRetornaMediaPonderada: String;
  Var
    qryAuxDta    : TUniQuery;
    arrPonderada : Array of TPonderada;
    strSQL       : String;
    intTamanho   : Integer;
    intPosicao   : Integer;
    fltTotVlr    : Double;
    fltTotPon    : Double;
begin

  Result    := '0,00';
  qryAuxDta := fCriaQuery(Nil);
  intTamanho:= 1;

  strSQL := '';

  If (fCfgSis('CVOREF') = 'S') Then
     strSQL := strSQL + ' SELECT DATEDIFF(CTR_DTAREC, '+ fGetSqlDtaVenctoOriginal(false) + ') AS DIFDTA,      '
  Else
     strSQL := strSQL + ' SELECT DATEDIFF(CTR_DTAREC, CTR_DTAVEN) AS DIFDTA,      ';

  strSQL := strSQL + '  IFNULL(                                        ';
  strSQL := strSQL + '    SUM(                                         ';
  strSQL := strSQL + '      CTR_VALORI + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0) ';
  strSQL := strSQL + '    ),                                           ';
  strSQL := strSQL + '    0                                            ';
  strSQL := strSQL + '  ) AS VALREC                                    ';
  strSQL := strSQL + ' FROM                                                    ';
  strSQL := strSQL + '   CADREC                                                ';
  strSQL := strSQL + ' INNER JOIN CADCLI                                       ';
  strSQL := strSQL + '   ON CLI_CODCLI = CTR_CODCLI                            ';
  strSQL := strSQL + ' WHERE (                                                 ';
  If (Not fEmptyStr(strRedLoj)) And (chkRedLoj.Checked = True) Then
    strSQL := strSQL + '  CLI_CODRED = :REDE                                  '
  Else
  Begin
    strSQL := strSQL + '  CLI_CODCLI = :CODCLI                                  ';
    If (fCfgSis('TRFTCR', varString) = '2') And chkRedLoj.Checked Then
    Begin
      strSQL := strSQL + '    OR CLI_CODRED =                                      ';
      strSQL := strSQL + '    (SELECT                                              ';
      strSQL := strSQL + '       CLI_CODRED                                        ';
      strSQL := strSQL + '     FROM                                                ';
      strSQL := strSQL + '       CADCLI                                            ';
      strSQL := strSQL + '     WHERE CLI_CODCLI = :CODCLI)                         ';
    End;
  End;
  strSQL := strSQL + ' ) AND CTR_VALDUP = 0                                    ';
  strSQL := strSQL + '   AND CTR_DTAREC IS NOT NULL                            ';
  strSQL := strSQL + '   AND CTR_DTAVEN <= CTR_DTAREC                          ';

  //Somente das empresas que o operador tem direito de acesso.
  If fCfgSis('EMREFN') = '1' Then
    strSQL := strSQL + '   AND CTR_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

  strSQL := strSQL + ' GROUP BY DIFDTA                                         ';

  qryAuxDta.SQL.Text := strSQL;
  If (Not fEmptyStr(strRedLoj)) And (chkRedLoj.Checked = True) Then
    qryAuxDta.ParamByName('REDE').AsString   := strRedLoj
  Else
    qryAuxDta.ParamByName('CODCLI').AsString := edtCodCliente.Text;
  qryAuxDta.Open;
  qryAuxDta.First;

  While Not qryAuxDta.Eof Do
  Begin
    SetLength(arrPonderada, intTamanho);

    arrPonderada[intTamanho - 1].intDiasAtr := qryAuxDta.FieldByName('DIFDTA').AsInteger;
    arrPonderada[intTamanho - 1].fltTotVlr  := qryAuxDta.FieldByName('VALREC').AsFloat;
    arrPonderada[intTamanho - 1].fltTotPon  := qryAuxDta.FieldByName('VALREC').AsFloat * qryAuxDta.FieldByName('DIFDTA').AsInteger;

    Inc(intTamanho);

    qryAuxDta.Next;
  End;

  fltTotVlr := 0;
  fltTotPon := 0;

  For intPosicao := 0 To High(arrPonderada) Do
  Begin
    fltTotVlr := fltTotVlr + arrPonderada[intPosicao].fltTotVlr;
    fltTotPon := fltTotPon + arrPonderada[intPosicao].fltTotPon;
  End;

  If fltTotVlr <> 0 Then
  Begin
    Result := FloatToStrF(fltTotPon / fltTotVlr, ffNumber, 15, 2);
  End;

  FreeAndNil(qryAuxDta);
end;

function TfrmResFinanceiro.fRetornaMediaPonderadaNova: String;
  function fBuscaProxDiaUtil(data:TDateTime):TDateTime;
    function fExisteFeriado(data:TDateTime):Boolean;
    var
      qryFeriado :TUniQuery;
    begin
      qryFeriado := fCriaQuery(self);
      qryFeriado.SQL.Text :=
          ' SELECT COUNT(FER_DTAFER) FROM CADFER WHERE FER_DTAFER = ' +
               QuotedStr(FormatDateTime('YYYY-MM-DD',data));
      qryFeriado.Open;
      Result := qryFeriado.fields[0].AsInteger > 0;
      FreeAndNil(qryFeriado);
    end;
  Var
    dataNova : TDateTime;
  begin

    dataNova := data;

    if DayOfWeek(dataNova) = 1 then
      dataNova := datanova + 1;

    if DayOfWeek(dataNova) = 7 then
      dataNova := datanova + 2;

    while (fExisteFeriado(dataNova)) or (dayOfWeek(dataNova) in [1,7]) do
      dataNova := datanova + 1;

    result := dataNova;
  end;


  Var
    qryAuxDta    : TUniQuery;
    arrPonderada : Array of TPonderada;
    strSQL       : String;
    intTamanho   : Integer;
    intPosicao   : Integer;
    fltTotVlr    : Double;
    fltTotPon    : Double;

    dtaDtaVen: TDateTime;
    intAtraso: Double;

begin

  Result    := '0,00';
  qryAuxDta := fCriaQuery(Nil);
  intTamanho:= 1;

  strSQL := '';

  If (fCfgSis('CVOREF') = 'S') Then
      strSQL := strSQL + ' SELECT CTR_DTAREC, '+ fGetSqlDtaVenctoOriginal + ', '
  Else
      strSQL := strSQL + ' SELECT CTR_DTAREC, CTR_DTAVEN, ';

  strSQL := strSQL + '   IFNULL(SUM(CTR_VALORI + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)), 0) AS VALREC ';
  strSQL := strSQL + ' FROM                                                    ';
  strSQL := strSQL + '   CADREC                                                ';
  strSQL := strSQL + ' INNER JOIN CADCLI                                       ';
  strSQL := strSQL + '   ON CLI_CODCLI = CTR_CODCLI                            ';
  strSQL := strSQL + ' WHERE (                                                 ';
  If (Not fEmptyStr(strRedLoj)) And (chkRedLoj.Checked = True) Then
    strSQL := strSQL + '  CLI_CODRED = :REDE                                 '
  Else
  Begin
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI                                 ';
    If (fCfgSis('TRFTCR', varString) = '2') And chkRedLoj.Checked Then
    Begin
      strSQL := strSQL + '    OR CLI_CODRED =                                  ';
      strSQL := strSQL + '    (SELECT                                          ';
      strSQL := strSQL + '       CLI_CODRED                                    ';
      strSQL := strSQL + '     FROM                                            ';
      strSQL := strSQL + '       CADCLI                                        ';
      strSQL := strSQL + '     WHERE CLI_CODCLI = :CODCLI)                     ';
    End;
  End;
  strSQL := strSQL + ' ) AND CTR_VALDUP = 0                                    ';
  strSQL := strSQL + '   AND CTR_VALORI > 0                                    ';
  strSQL := strSQL + '   AND CTR_DTAREC IS NOT NULL                            ';
  strSQL := strSQL + '   AND CTR_DTAVEN <= CTR_DTAREC                          ';

  //Somente das empresas que o operador tem direito de acesso.
  If fCfgSis('EMREFN') = '1' Then
    strSQL := strSQL + '   AND CTR_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

  strSQL := strSQL + ' GROUP BY CTR_DTAREC, CTR_DTAVEN                         ';

  qryAuxDta.SQL.Text := strSQL;
   If (Not fEmptyStr(strRedLoj)) And (chkRedLoj.Checked = True) Then
     qryAuxDta.ParamByName('REDE').AsString   := strRedLoj
   Else
     qryAuxDta.ParamByName('CODCLI').AsString := edtCodCliente.Text;
  qryAuxDta.Open;

  While Not qryAuxDta.Eof Do
  Begin

    if blnAjustaData then
      dtaDtaVen := fBuscaProxDiaUtil(qryAuxDta.FieldByName('CTR_DTAVEN').AsDateTime)
    else
      dtaDtaVen := qryAuxDta.FieldByName('CTR_DTAVEN').AsDateTime;

    intAtraso := qryAuxDta.FieldByName('CTR_DTAREC').AsDateTime - dtaDtaVen;

    If dtaDtaVen <= qryAuxDta.FieldByName('CTR_DTAREC').AsDateTime Then
    Begin
      SetLength(arrPonderada, intTamanho);

      arrPonderada[intTamanho - 1].intDiasAtr := intAtraso;
      arrPonderada[intTamanho - 1].fltTotVlr  := qryAuxDta.FieldByName('VALREC').AsFloat;
      arrPonderada[intTamanho - 1].fltTotPon  := qryAuxDta.FieldByName('VALREC').AsFloat * intAtraso;

      Inc(intTamanho);
    End;


    qryAuxDta.Next;
  End;

  fltTotVlr := 0;
  fltTotPon := 0;

  For intPosicao := 0 To High(arrPonderada) Do
  Begin
    fltTotVlr := fltTotVlr + arrPonderada[intPosicao].fltTotVlr;
    fltTotPon := fltTotPon + arrPonderada[intPosicao].fltTotPon;
  End;

  If fltTotVlr <> 0 Then
  Begin
    Result := FloatToStrF(fltTotPon / fltTotVlr, ffNumber, 15, 2);
  End;

  FreeAndNil(qryAuxDta);
end;

function TfrmResFinanceiro.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodCliente) Then
    Begin
      edtDesCliente.Clear;
      edtCpfCnpjCliente.Clear;

      If fEmptyStr(edtCodCliente.Text) Then
      Begin
        fMensagem('ATENÇÃO','É necessário informar o código do cliente!',['&O K']);
        Result := False;
      End
      Else
      begin
        edtDesCliente.Text := fRetNomCliente(edtCodCliente.Text);
        edtCpfCnpjCliente.Text := fFormataCpfCgc(fRetCgcCpf(edtCodCliente.Text), fSetaPais);
        if Length(edtCpfCnpjCliente.Text) = 18 then
          lblCpfCnpjCliente.Caption := 'CNPJ:'
        else
          lblCpfCnpjCliente.Caption := 'CPF:';
      end;

      If fEmptyStr(edtDesCliente.Text) And (Not fEmptyStr(edtCodCliente.Text)) Then
      Begin
        fMensagem('ATENÇÃO','Código do cliente não encontrado!',['&O k']);
        Result := False;
      End;

      If Result Then
      begin
        fValRedLoj(edtCodCliente.Text);
        pCarregaDados();
      end;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmResFinanceiro.fValRedLoj(const strCodCli: String): Boolean;
var
  qryRed : TUniQuery;
  strSQL : String;
begin
  Result := False;
  qryRed := fCriaQuery(nil);

  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CLI_CODRED, RED_DESRED ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADCLI ';
    strSQL := strSQL + ' LEFT JOIN CADRED ON RED_CODRED = CLI_CODRED ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CLI_CODCLI = :CODCLI ';
    strSQL := strSQL + ' AND COALESCE(CLI_CODRED <> "", "") ';

    With qryRed Do
    Begin
      Close;
      Sql.Clear;
      Sql.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      Open
    End;

    If Not qryRed.IsEmpty Then
    Begin
      strRedLoj := qryRed.FieldByName('CLI_CODRED').AsString;
      edtCodRedLoj.Text := qryRed.FieldByName('CLI_CODRED').AsString;
      edtDesRedLoj.Text := qryRed.FieldByName('RED_DESRED').AsString;
      Result := True;
    End;

    pnlRedLoj.Visible := Not qryRed.IsEmpty;
    if not pnlRedLoj.Visible then
      Self.Height := (Self.Height - pnlRedLoj.Height);
  Finally
    FreeAndNil(qryRed);
  End;

end;

procedure TfrmResFinanceiro.pCarregaCliente(Var qryCadCli: TUniQuery);
begin
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';
end;

procedure TfrmResFinanceiro.pCarregaDados;
begin
  strCodCli := edtCodCliente.Text;
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Carregando dados...';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao     := fAtribuiValores;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmResFinanceiro.pLimpaInfo;
begin
  pnlInfo.Caption := '';
end;

procedure TfrmResFinanceiro.pSetaAjusteData(ajuste: Boolean);
begin
  blnAjustaData := ajuste;
end;

procedure TfrmResFinanceiro.pTrazProrrogacoes;
  Var
    strSQL : String;
    qryPrd : TUniQuery;
    intQtdA: Integer;
    fltDiaA: Double;
    fltMedA: Double;
    intQtdL: Integer;
    fltDiaL: Double;
    fltMedL: Double;
begin
  {************************}
  {* DUPLICATAS EM ABERTO *}
  {*********************FS*}
  qryPrd := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' SELECT                                             ';
  strSQL := strSQL + '   COUNT(P.CTR_CODCLI) AS QTDPRD,                   ';
  strSQL := strSQL + '   SUM(P.CTR_DIAPRD) AS DIAPRD                      ';
  strSQL := strSQL + ' FROM                                               ';
  strSQL := strSQL + '   CTRPRD P                                         ';
  strSQL := strSQL + '   JOIN CADREC R ON P.CTR_NUMDUP = R.CTR_NUMDUP AND ';
  strSQL := strSQL + '                    P.CTR_PARCEL = R.CTR_PARCEL AND ';
  strSQL := strSQL + '                    P.CTR_SEQBAI = R.CTR_SEQBAI AND ';
  strSQL := strSQL + '                    P.CTR_ESPDOC = R.CTR_ESPDOC AND ';
  strSQL := strSQL + '                    P.CTR_CODCLI = R.CTR_CODCLI AND ';
  strSQL := strSQL + '                    P.CTR_CODEMP = R.CTR_CODEMP     ';
  strSQL := strSQL + '   JOIN CADCLI ON CLI_CODCLI = P.CTR_CODCLI';
  strSQL := strSQL + ' WHERE                                              ';
  If (Not fEmptyStr(strRedLoj)) And (chkRedLoj.Checked = True) Then
    strSQL := strSQL + '  CLI_CODRED = :REDE AND                          '
  else
    strSQL := strSQL + '   P.CTR_CODCLI = :CODCLI AND                     ';
  strSQL := strSQL + '   R.CTR_DTAREC IS NULL                             ';

  With qryPrd Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If (Not fEmptyStr(strRedLoj)) And (chkRedLoj.Checked = True) Then
      ParamByName('REDE').AsString   := strRedLoj
    Else
      ParamByName('CODCLI').AsString := edtCodCliente.Text;

    Open;

    intQtdA := 0;
    fltDiaA := 0;
    fltMedA := 0;

    First;

    While Not Eof Do
    Begin
      intQtdA := intQtdA + FieldByName('QTDPRD').AsInteger;
      fltDiaA := fltDiaA + FieldByName('DIAPRD').AsFloat;

      Next;
    End;
  End;

  If IntQtdA > 0 Then
    fltMedA := fltDiaA / intQtdA;

  edtQtdPrd.Text := IntToStr(intQtdA);
  edtMedPrd.Text := FormatFloat('#,##0.00', fltMedA);

  {*************************}
  {* DUPLICATAS LIQUIDADAS *}
  {**********************FS*}
  strSQL := '';
  strSQL := strSQL + ' SELECT                                             ';
  strSQL := strSQL + '   COUNT(P.CTR_CODCLI) AS QTDPRD,                   ';
  strSQL := strSQL + '   SUM(P.CTR_DIAPRD) AS DIAPRD                      ';
  strSQL := strSQL + ' FROM                                               ';
  strSQL := strSQL + '   CTRPRD P                                         ';
  strSQL := strSQL + '   JOIN CADREC R ON P.CTR_NUMDUP = R.CTR_NUMDUP AND ';
  strSQL := strSQL + '                    P.CTR_PARCEL = R.CTR_PARCEL AND ';
  strSQL := strSQL + '                    P.CTR_SEQBAI = R.CTR_SEQBAI AND ';
  strSQL := strSQL + '                    P.CTR_ESPDOC = R.CTR_ESPDOC AND ';
  strSQL := strSQL + '                    P.CTR_CODCLI = R.CTR_CODCLI AND ';
  strSQL := strSQL + '                    P.CTR_CODEMP = R.CTR_CODEMP     ';
  strSQL := strSQL + '   JOIN CADCLI ON CLI_CODCLI = P.CTR_CODCLI';
  strSQL := strSQL + ' WHERE                                              ';
  If (Not fEmptyStr(strRedLoj)) And (chkRedLoj.Checked = True) Then
    strSQL := strSQL + '  CLI_CODRED = :REDE AND                          '
  else
    strSQL := strSQL + '   P.CTR_CODCLI = :CODCLI AND                     ';
  strSQL := strSQL + '   R.CTR_DTAREC IS NOT NULL                         ';

  With qryPrd Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If (Not fEmptyStr(strRedLoj)) And (chkRedLoj.Checked = True) Then
      ParamByName('REDE').AsString   := strRedLoj
    Else
      ParamByName('CODCLI').AsString := edtCodCliente.Text;

    Open;

    intQtdL := 0;
    fltDiaL := 0;
    fltMedL := 0;

    First;

    While Not Eof Do
    Begin
      intQtdL := intQtdL + FieldByName('QTDPRD').AsInteger;
      fltDiaL := fltDiaL + FieldByName('DIAPRD').AsFloat;

      Next;
    End;
  End;

  If IntQtdL > 0 Then
    fltMedL := fltDiaL / intQtdL;

  edtLiqPrd.Text    := IntToStr(intQtdL);
  edtMedLiqPrd.Text := FormatFloat('#,##0.00', fltMedL);
end;

procedure TfrmResFinanceiro.pVisibleCampoCashback;
begin
  lblCash.Visible := False;
  edtQtdAbertoCash.Visible := False;
  edtVrAbertoCash.Visible := False;
  edtQtdLiqCash.Visible := False;
  edtVrLiqCash.Visible := False;
  btnCashAberto.Visible := False;
  btnCashLiquidado.Visible := False;

  If (Not fCfgSis('EXCBRF', varBoolean)) Or
    (Not fClienteProfissional(strCodCli)) Then
  Begin
    Panel8.Height := 60;
    Label36.Top := 34;
    edtTeleQtd.Top := 31;
    edtTeleVr.Top := 31;
    btnTelechequeEmAberto.Top := 32;
    edtTeleLiqQtd.Top := 31;
    edtTeleLiqVr.Top := 31;
    btnTelechequeLiquidado.Top := 32;
    Exit;
  End;

  lblCash.Visible := True;
  edtQtdAbertoCash.Visible := True;
  edtVrAbertoCash.Visible := True;
  edtQtdLiqCash.Visible := True;
  edtVrLiqCash.Visible := True;
  btnCashAberto.Visible := True;
  btnCashLiquidado.Visible := True;
end;

procedure TfrmResFinanceiro.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCliente);
end;

procedure TfrmResFinanceiro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fExecutaSQL('SET @ABRINDO_CONSULTA=FALSE');
end;

procedure TfrmResFinanceiro.FormCreate(Sender: TObject);
begin
  inherited;
  blnPermiteEditarArquivosDeConsultaDeCredito := False;
  blnVeioFatVendas := False;

  pConfiguraPopup(btnTitAberto);
  pConfiguraPopup(btnTitLiquidado);
  pConfiguraPopup(btnChqPreAberto);
  pConfiguraPopup(btnChqPreLiquidado);
  pConfiguraPopup(btnChqDevAberto);
  pConfiguraPopup(btnChqDevLiquidado);
  pConfiguraPopup(btnCredAberto);
  pConfiguraPopup(btnCredLiquidado);
  pConfiguraPopup(btnPedNaoFat);
  pConfiguraPopup(btnTitAtrasado);
  pConfiguraPopup(btnTitLiqAtrasado);
  pConfiguraPopup(btnExiCre);
  pConfiguraPopup(btnCashAberto);
  pConfiguraPopup(btnCashLiquidado);
end;

procedure TfrmResFinanceiro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case key Of
    VK_F5 : btnDadosCobr.Click;
    VK_F6 : btnObsCli.Click;
    VK_F7 : btnAlterarLimCre.Click;
  End;
end;

procedure TfrmResFinanceiro.FormShow(Sender: TObject);
begin
  inherited;
  fExecutaSQL('SET @ABRINDO_CONSULTA=TRUE');
  pnlPedNaoFat.Visible := fCfgSis('MPDAFF', VarBoolean) Or fCfgSis('PDVLIM', VarBoolean);
  If Not pnlPedNaoFat.Visible Then
    Self.Height := (Self.Height - pnlPedNaoFat.Height);

  pnlEPemAberto.Visible := fCfgSis('LMCEMP', VarBoolean);
  If Not pnlEPemAberto.Visible Then
    Self.Height := (Self.Height - pnlEPemAberto.Height);

  If fCfgSis('MPREFF') = 'S' Then
  Begin
    lblPredatados.Visible := TRUE;
    edtQtdAberto2.Visible := TRUE;
    edtVrAberto2.Visible  := TRUE;
    edtQtdLiq2.Visible    := TRUE;
    edtVrLiq2.Visible     := TRUE;
  End Else
  Begin
    lblPredatados.Visible := FALSE;
    edtQtdAberto2.Visible := FALSE;
    edtVrAberto2.Visible  := FALSE;
    edtQtdLiq2.Visible    := FALSE;
    edtVrLiq2.Visible     := FALSE;
  End;

  If Not fEmptyStr(strCodCli) Then
  Begin
    edtCodCliente.Text := strCodCli;
//    edtCodCliente.ReadOnly := True;
    fValidaCampos(edtCodCliente, True);
    pSetFocus(btnSair);
  End;

  pVisibleCampoCashback;

  btnAlterarLimCre.Enabled := fVerificaAcessoSistema('mnuPermitirAlterarLimiteCreditoCliente');

  btnDadosCobr.Enabled     := fVerificaAcessoSistema('UTDCOB', strLoginUsuarioLogado);

  chkRedLoj.Checked := DefaultCheckBoxMesmaRedeDeLoja;

  lblLimiteAlpe.Visible := fCfgSis('ALPKNK', varBoolean);
  btnLimiteAlpe.Visible := fCfgSis('ALPKNK', varBoolean);
  btnDadosCobr.Visible  := Not blnVeioFatVendas;
  btnObsCli.Visible     := Not blnVeioFatVendas;
  btnAlterarLimCre.Visible := Not blnVeioFatVendas;
  edtCodCliente.Enabled := Not blnVeioFatVendas;
end;

procedure TfrmResFinanceiro.btnAlterarLimCreClick(Sender: TObject);
begin
  inherited;
  TfrmLimiteCredito.AlterarLimiteCredito(strCodCli);
  pCarregaDados;
end;

procedure TfrmResFinanceiro.btnChequeAPrazoEmAbertoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(385, 17328, [],
                        ['CODCLI','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);

end;

procedure TfrmResFinanceiro.btnChequeAPrazoLiquidadoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(386, 17329, [],
                        ['CODCLI','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);

end;

procedure TfrmResFinanceiro.btnChequeAVistaEmAbertoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(383, 17326, [],
                        ['CODCLI','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);

end;

procedure TfrmResFinanceiro.btnChequeAVistaLiquidadoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(384, 17327, [],
                        ['CODCLI','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);

end;

procedure TfrmResFinanceiro.btnChqDevAbertoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(369, 17312, [],
                        ['CODCLI','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);

end;

procedure TfrmResFinanceiro.btnChqDevLiquidadoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(373, 17316, [],
                        ['CODCLI','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);

end;

procedure TfrmResFinanceiro.btnChqPreAbertoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(370, 17313, [],
                        ['CODCLI','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);

end;

procedure TfrmResFinanceiro.btnChqPreLiquidadoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(372, 17315, [],
                        ['CODCLI','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);
end;

procedure TfrmResFinanceiro.btnCopiarCpfCnpjClick(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(edtCpfCnpjCliente.Text) then
  begin
    Clipboard.AsText := edtCpfCnpjCliente.Text;
    pnlInfo.Caption := Copy(lblCpfCnpjCliente.Caption, 1, Length(lblCpfCnpjCliente.Caption ) -1) +
      ' copiado com sucesso !'
  end;
end;

procedure TfrmResFinanceiro.btnCredAbertoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(368, 17311, [],
                        ['CODCLI', 'AJUDTA','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(blnAjustaData,'Sim','Não'), IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);
end;

procedure TfrmResFinanceiro.btnCashAbertoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(428, 23882, [],
                        ['CODCLI', 'AJUDTA','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(blnAjustaData,'Sim','Não'), IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);
end;

procedure TfrmResFinanceiro.btnCredLiquidadoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(374, 17317, [],
                        ['CODCLI', 'AJUDTA','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(blnAjustaData,'Sim','Não'), IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);
end;

procedure TfrmResFinanceiro.btnCashLiquidadoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(429, 23998, [],
                        ['CODCLI', 'AJUDTA','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(blnAjustaData,'Sim','Não'), IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);
end;

procedure TfrmResFinanceiro.btnDadosCobrClick(Sender: TObject);
var
  frmMostraDadosCobranca: TfrmMostraDadosCobranca;
begin
  inherited;
  If (btnDadosCobr.Visible) And (btnDadosCobr.Enabled) Then
  Begin
    Try

      pCriarFormularios(TfrmMostraDadosCobranca, frmMostraDadosCobranca);
      frmMostraDadosCobranca.strCodCli := edtCodCliente.Text;
      frmMostraDadosCobranca.Alterar := True;
      frmMostraDadosCobranca.blnPermiteEditarArquivosDeConsultaDeCredito := blnPermiteEditarArquivosDeConsultaDeCredito;
      if frmMostraDadosCobranca.ShowModal = MrOk then
        frmMostraDadosCobranca.Gravar;
    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[frmFatLiberacaoCliente.pMostraConsultaCredito]');
    End;

    pFreeAndNil(frmMostraDadosCobranca);
  End;
end;

procedure TfrmResFinanceiro.btnEmpAbertoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(301, 9612, [],
                        ['CODCLI','ENTRED'],
                        [edtCodCliente.Text, IfThen(chkRedLoj.Checked,'Sim','Não')],
                        nil,
                        nil,
                        True);
end;

procedure TfrmResFinanceiro.btnExiCreClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(368, 17311, [],
                        ['CODCLI', 'AJUDTA','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(blnAjustaData,'Sim','Não'), IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);
end;

procedure TfrmResFinanceiro.btnLimiteAlpeClick(Sender: TObject);
var
  fltLimiteTotal,
  fltLimiteUtilizado,
  fltLimiteDisponivel,
  fltTotalDebito: Double;

  blnStopSupply: Boolean;

  strMsg: String;
  strCgc: String;
begin
  fltLimiteTotal := 0.0;
  fltLimiteUtilizado := 0.0;
  fltLimiteDisponivel := 0.0;
  fltTotalDebito := 0.0;

  strCgc := fRetCgcCpf(edtCodCliente.Text);

  if fEmptyStr(strCgc) then
    Exit;

  if not TControllerPaymentProductsArrangements.fConsultaAlpeLimiteBoleto(strCgc,
                                                                          fltLimiteTotal,
                                                                          fltLimiteUtilizado,
                                                                          fltLimiteDisponivel,
                                                                          blnStopSupply,
                                                                          strMsg) then
  begin
    if blnStopSupply then
      fMensagem('', 'StopSupply: '+strMsg, ['&Ok']);

    Exit;
  end;

  if fCfgSis('PDALLM', varBoolean) and (not fEmptyStr(strCgc)) then
    fltTotalDebito := fRetTotalPedidoVendaAberto(edtCodCliente.Text, '', True);

  fltLimiteUtilizado := fltLimiteUtilizado + fltTotalDebito;
  fltLimiteDisponivel := fltLimiteDisponivel - fltTotalDebito;

  fMensagem('', 'Limites Alpe:'+#13#10+#13#10+
                'Limite Total: '+Format('%m', [fltLimiteTotal])+#13#10+
                'Limite Utilizado: '+Format('%m', [fltLimiteUtilizado])+#13#10+
                'Limite Disponível: '+Format('%m', [fltLimiteDisponivel]), ['&Ok']);
end;

procedure TfrmResFinanceiro.btnObsCliClick(Sender: TObject);
var
  qryQuery: TUniQuery;
begin
  inherited;
  If (btnObsCli.Visible) And (btnObsCli.Enabled) Then
  Begin
    Try
      qryQuery := fCriaQuery(Self);
      With qryQuery Do
      Begin
        SQL.Clear;
        SQL.Add(' SELECT ');
        SQL.Add('   CLI_OBSERV ');
        SQL.Add(' FROM CADCLI ');
        SQL.Add(' WHERE CLI_CODCLI = :CODCLI ');
        ParamByName('CODCLI').AsString := edtCodCliente.Text;
        Open;

        If (Not FieldByName('CLI_OBSERV').IsNull) And (FieldByName('CLI_OBSERV').AsString <> '') Then
        Begin
          Try
            pCriarFormularios(TfrmFatMostraObsCliente, frmFatMostraObsCliente);
            frmFatMostraObsCliente.memObserv.Texto := FieldByName('CLI_OBSERV').AsString;
            frmFatMostraObsCliente.strCodCli       := edtCodCliente.Text;
            frmFatMostraObsCliente.showModal;
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '[btnObsCliClick]');
          End;
          pFreeAndNil(frmFatMostraObsCliente);
        End
        Else
          fMensagem('Informação', 'Nenhuma observação encontrada para este cliente', ['&OK']);
      End;
    Finally
      FreeAndNil(qryQuery);
    End;
  End;
end;

procedure TfrmResFinanceiro.btnPedNaoFatClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(378, 17321, [],
                        ['CODCLI'],
                        [edtCodCliente.Text],
                        nil,
                        nil,
                        True);
end;

procedure TfrmResFinanceiro.btnTelechequeEmAbertoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(381, 17324, [],
                        ['CODCLI','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);

end;

procedure TfrmResFinanceiro.btnTelechequeLiquidadoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(382, 17325, [],
                        ['CODCLI','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);

end;

procedure TfrmResFinanceiro.btnTitAbertoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(371, 17314, [],
                        ['CODCLI', 'AJUDTA','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(blnAjustaData,'Sim','Não'), IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);

end;

procedure TfrmResFinanceiro.btnTitAtrasadoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(375, 17318, [],
                        ['CODCLI', 'AJUDTA','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(blnAjustaData,'Sim','Não'), IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);
end;

procedure TfrmResFinanceiro.btnTitLiqAtrasadoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(377, 17320, [],
                        ['CODCLI', 'AJUDTA','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(blnAjustaData,'Sim','Não'), IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);
end;

procedure TfrmResFinanceiro.btnTitLiquidadoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(376, 17319, [],
                        ['CODCLI', 'AJUDTA','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(blnAjustaData,'Sim','Não'), IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);
end;

procedure TfrmResFinanceiro.btnTitulosDentroPrazoAbertoClick(Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(379, 17322, [],
                        ['CODCLI', 'AJUDTA','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(blnAjustaData,'Sim','Não'), IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);

end;

procedure TfrmResFinanceiro.btnTitulosDentroPrazoLiquidadoClick(
  Sender: TObject);
begin
  inherited;
   prcExecutaRelatorio(380, 17323, [],
                        ['CODCLI', 'AJUDTA','ENTRED','CODRED'],
                        [edtCodCliente.Text, IfThen(blnAjustaData,'Sim','Não'), IfThen(chkRedLoj.Checked,'Sim','Não'), IfThen(fEmptyStr(strRedLoj),'XXXXX',strRedLoj)],
                        nil,
                        nil,
                        True);

end;

procedure TfrmResFinanceiro.chkRedLojClick(Sender: TObject);
begin
  inherited;
  blnChkRed := chkRedLoj.checked;
  fValRedLoj(edtCodCliente.Text);
  pCarregaDados();
end;

function TfrmResFinanceiro.DefaultCheckBoxMesmaRedeDeLoja: Boolean;
begin
  Result := True;
  If Not (fCfgSis('TRFTCR', varString) = '2') Then
    Result := False
  Else If Not pnlRedLoj.Visible  Then
    Result := False
  Else If fEmptyStr(edtCodCliente.Text) Then
    Result := False;
end;

procedure TfrmResFinanceiro.edtAcumuloAnoMouseLeave(Sender: TObject);
begin
  inherited;
  pLimpaInfo;
end;

procedure TfrmResFinanceiro.edtAcumuloAnoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  pnlInfo.Caption := 'Maior valor acumulado de títulos em aberto no dia nos últimos 12 meses';
end;

procedure TfrmResFinanceiro.edtAcumuloMouseLeave(Sender: TObject);
begin
  inherited;
  pLimpaInfo;
end;

procedure TfrmResFinanceiro.edtAcumuloMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  pnlInfo.Caption := 'Valor acumulado de compras do cliente nos últimos 3 meses';
end;

procedure TfrmResFinanceiro.edtAtualAtrasadoMouseLeave(Sender: TObject);
begin
  inherited;
  pLimpaInfo;
end;

procedure TfrmResFinanceiro.edtAtualAtrasadoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  pnlInfo.Caption := 'Quantidade de dias do último título em aberto vencido';
end;

procedure TfrmResFinanceiro.edtCadastroMouseLeave(Sender: TObject);
begin
  inherited;
  pLimpaInfo;
end;

procedure TfrmResFinanceiro.edtCadastroMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  pnlInfo.Caption := 'Data de quando o cliente foi cadastrado no sistema';
end;

function TfrmResFinanceiro.fBuscaMaiorAtrasado: String;
  function fBuscaProxDiaUtil(data:TDateTime):TDateTime;
    function fExisteFeriado(data:TDateTime):Boolean;
    var
      qryFeriado :TUniQuery;
    begin
      qryFeriado := fCriaQuery(self);
      qryFeriado.SQL.Text :=
          ' SELECT COUNT(FER_DTAFER) FROM CADFER WHERE FER_DTAFER = ' +
               QuotedStr(FormatDateTime('YYYY-MM-DD',data));
      qryFeriado.Open;
      Result := qryFeriado.fields[0].AsInteger > 0;
      FreeAndNil(qryFeriado);
    end;
  Var
    dataNova : TDateTime;
  begin

    dataNova := data;

    if DayOfWeek(dataNova) = 1 then
      dataNova := datanova + 1;

    if DayOfWeek(dataNova) = 7 then
      dataNova := datanova + 2;

    while (fExisteFeriado(dataNova)) or (dayOfWeek(dataNova) in [1,7]) do
      dataNova := datanova + 1;

    result := dataNova;
  end;

Var
    qryAuxDta    : TUniQuery;
    atraso       : Double;
    maiorAtraso  : Double;


    strSQL       : String;

    dtaDtaVen    : TDateTime;
    dtaDtaBase   : TDateTime;


begin

  strSQL := '';
  strSQL := strSQL + ' SELECT                       ';

  If (fCfgSis('CVOREF') = 'S') Then
     strSQL := strSQL + fGetSqlDtaVenctoOriginal()
  Else
     strSQL := strSQL + '    CTR_DTAVEN            ';

  strSQL := strSQL + '    ,CTR_DTAREC               ';
  strSQL := strSQL + ' FROM CADREC                  ';
  strSQL := strSQL + ' INNER JOIN CADCLI            ';
  strSQL := strSQL + '   ON CLI_CODCLI = CTR_CODCLI ';
  strSQL := strSQL + ' WHERE (                      ';
  If (Not fEmptyStr(strRedLoj)) And (chkRedLoj.Checked = True) Then
    strSQL := strSQL + '  CLI_CODRED = :REDE        '
  Else
  Begin
    strSQL := strSQL + '  CLI_CODCLI = :CODCLI      ';
    If (fCfgSis('TRFTCR', varString) = '2') And chkRedLoj.Checked Then
    Begin
      strSQL := strSQL + ' OR CLI_CODRED =              ';
      strSQL := strSQL + ' (SELECT                      ';
      strSQL := strSQL + '    CLI_CODRED                ';
      strSQL := strSQL + '  FROM                        ';
      strSQL := strSQL + '    CADCLI                    ';
      strSQL := strSQL + '  WHERE CLI_CODCLI = :CODCLI) ';
    End;
  End;
  strSQL := strSQL + ' )                            ';

  //Somente das empresas que o operador tem direito de acesso.
  If fCfgSis('EMREFN') = '1' Then
    strSQL := strSQL + ' AND CTR_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

  strSQL := strSQL + ' AND CTR_DTAREC > CTR_DTAVEN     ';
  strSQL := strSQL + ' AND CTR_VALORI > 0              ';
  strSQL := strSQL + ' GROUP BY CTR_DTAVEN, CTR_DTAREC ';
  strSQL := strSQL + ' ORDER BY CTR_DTAVEN             ';

  qryAuxDta := fCriaQuery(Self);
  qryAuxDta.SQL.Add(strSQL);
  If (Not fEmptyStr(strRedLoj)) And (chkRedLoj.Checked = True) Then
    qryAuxDta.ParamByName('REDE').AsString   := strRedLoj
  Else
    qryAuxDta.ParamByName('CODCLI').AsString := edtCodCliente.Text;
  qryAuxDta.Open;

  maiorAtraso := 0;
  While not qryAuxDta.Eof do
  begin
    dtaDtaVen  := qryAuxDta.FieldByName('CTR_DTAVEN').AsDateTime;

    if qryAuxDta.FieldByName('CTR_DTAREC').IsNull then
      dtaDtaBase := Date
    else
      dtaDtaBase := qryAuxDta.FieldByName('CTR_DTAREC').AsDateTime;

    if blnAjustaData then
      dtaDtaVen := fBuscaProxDiaUtil(dtaDtaVen);

    atraso := dtaDtaBase - dtaDtaVen;

    if atraso > maiorAtraso then
      maiorAtraso := atraso;

    qryAuxDta.Next;
  end;

  Result := FloatToStrF( maiorAtraso, ffNumber, 15,0);

  FreeAndNil(qryAuxDta);

end;

function TfrmResFinanceiro.fGetSqlDtaVenctoOriginal(blnAS:Boolean = true):String;
var
  strResult :string;
begin
    strResult := '';
    strResult := strResult + ' IFNULL( '+
                                     ' (SELECT CTR_DTAVEN FROM LOGCTR L '+
                                     '   WHERE '+ //-- L.CTR_DESCRI = 'INCLUSÃO' AND
                                     '         L.CTR_NUMDUP = CADREC.CTR_NUMDUP AND '+
                                     '         L.CTR_ESPDOC = CADREC.CTR_ESPDOC AND '+
                                     '         L.CTR_PARCEL = CADREC.CTR_PARCEL AND '+
                                     '         L.CTR_CODEMP = CADREC.CTR_CODEMP AND '+
                                     '         L.CTR_CODCLI = CADREC.CTR_CODCLI AND '+
                                     '         L.CTR_SEQBAI = 0 '+
                                     '   GROUP BY CTR_NUMDUP, CTR_ESPDOC, CTR_PARCEL, CTR_CODEMP, CTR_CODCLI '+
                                     '   ORDER BY CTR_DTALOG, CTR_HORLOG), CADREC.CTR_DTAVEN) ';
    If blnAS Then
       strResult := strResult + ' AS CTR_DTAVEN ';

    result := strResult;
end;

Function TfrmResFinanceiro.fDataAcumulados: TDate;
  Var
    intIndice,
    intDecMes,
    intMes,
    intAno: Integer;
Begin

  If DayOf(VS_Date) = DaysInMonth(VS_Date) Then
    intDecMes := 3
  Else
    intDecMes := 4;

  intAno := YearOf(VS_Date);
  intMes := MonthOf(VS_Date);

  For intIndice := 1 To intDecMes Do
  Begin
    If intMes = 1 Then
    Begin
      intMes := 12;
      Dec(intAno);
    End Else
    Begin
      Dec(intMes);
    End;
  End;

  Result := StartOfAMonth(intAno, intMes);
End;

function TfrmResFinanceiro.fRetTitAberto(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;
  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CTR_VALDUP) AS VALDUP FROM ( ' +
                fRetSQLResFinanceiro(ttCadRec, tcTitAbertos, strRedLoj, blnChkRed,blnAjustaData,blnClienteProfissional) + ') AS T ';

      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALDUP').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function TfrmResFinanceiro.fRetTitLiquidado(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;
  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CTR_VALREC) AS VALREC FROM ( ' +
                fRetSQLResFinanceiro(ttCadRec, tcTitLiquidados, strRedLoj,blnChkRed,blnAjustaData,blnClienteProfissional) + ') AS T ';

      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALREC').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function TfrmResFinanceiro.fRetChqLiquidados(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;

  If Not fCfgSis('MPREFF', varBoolean) Then
  Begin
    Result :=  0;
    Exit;
  End;

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CHQ_VALCHQ) AS VALCHQ FROM ( ' +
                fRetSQLResFinanceiro(ttCadChq, tcChqLiquidados, strRedLoj,blnChkRed,blnAjustaData) + ') AS T ';

      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALCHQ').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function TfrmResFinanceiro.fRetChqDevolvidosLiq(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;
  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CHQ_VALCHQ) AS VALCHQ FROM ( ' +
                fRetSQLResFinanceiro(ttCadChq, tcChqDevolvidosLiq, strRedLoj,blnChkRed,blnAjustaData) + ') AS T ';

      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALCHQ').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function TfrmResFinanceiro.fRetTitAtrasados(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;
  
  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CTR_VALDUP) AS VALDUP FROM ( ' +
                fRetSQLResFinanceiro(ttCadRec, tcTitAtrazados, strRedLoj,blnChkRed,blnAjustaData, blnClienteProfissional) + ') AS T ';

      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALDUP').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function TfrmResFinanceiro.fRetTitAtrasadosLiq(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;
  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CTR_VALREC) AS VALREC FROM ( ' +
                fRetSQLResFinanceiro(ttCadRec, tcTitAtrazadosLiq, strRedLoj,blnChkRed,blnAjustaData,blnClienteProfissional) + ') AS T ';

      SQL.Add(strSQL);
     If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
     Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALREC').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function TfrmResFinanceiro.fRetCreditos(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;
  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CTR_VALDUP) AS VALDUP FROM ( ' +
                fRetSQLResFinanceiro(ttCadRec, tcTitCreditos, strRedLoj,blnChkRed,blnAjustaData,blnClienteProfissional) + ') AS T ';

      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALDUP').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function TfrmResFinanceiro.fRetCreditosLiq(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;
  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CTR_VALREC) AS VALREC FROM ( ' +
                fRetSQLResFinanceiro(ttCadRec, tcTitCreditosLiq, strRedLoj,blnChkRed,blnAjustaData, blnClienteProfissional) + ') AS T ';

      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALREC').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
end;

function TfrmResFinanceiro.fRetTelecheques(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CHQ_VALCHQ) AS VALCHQ FROM ( ' +
                fRetSQLResFinanceiro(ttCadChq, tcTeleChq, strRedLoj,blnChkRed,blnAjustaData) + ') AS T ';

      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;
      Open;
    End;

    Result := qryGen.FieldByName('VALCHQ').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function TfrmResFinanceiro.fRetTelechequesLiq(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CHQ_VALCHQ) AS VALCHQ FROM ( ' +
                fRetSQLResFinanceiro(ttCadChq, tcTeleChqLiq, strRedLoj,blnChkRed,blnAjustaData) + ') AS T ';

      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALCHQ').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function TfrmResFinanceiro.fRetTitulosDentroPrazoEmAberto(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CTR_VALDUP) AS VALDUP FROM ( ' +
                fRetSQLResFinanceiro(ttCadRec, tcTitDentroPrazoAbertos, strRedLoj, blnChkRed,blnAjustaData,blnClienteProfissional) + ') AS T ';

      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALDUP').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function TfrmResFinanceiro.fRetTitulosDentroPrazoLiquidados(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;
  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CTR_VALREC) AS VALREC FROM ( ' +
                fRetSQLResFinanceiro(ttCadRec, tcTitDentroPrazoLiquidados, strRedLoj,blnChkRed,blnAjustaData,blnClienteProfissional) + ') AS T ';

      SQL.Add(strSQL);
     If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
     Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALREC').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function TfrmResFinanceiro.fRetChequeAVistaEmAberto(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;

  If Not fCfgSis('MPREFF', varBoolean) Then
  Begin
    Result :=  0;
    Exit;
  End;

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CHQ_VALCHQ) AS VALCHQ FROM ( ' +
                fRetSQLResFinanceiro(ttCadChq, tcChqAVistaEmAberto, strRedLoj,blnChkRed,blnAjustaData) + ') AS T ';

      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALCHQ').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function TfrmResFinanceiro.fRetChequeAVistaLiquidados(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;

  If Not fCfgSis('MPREFF', varBoolean) Then
  Begin
    Result :=  0;
    Exit;
  End;

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CHQ_VALCHQ) AS VALCHQ FROM ( ' +
                fRetSQLResFinanceiro(ttCadChq, tcChqAVistaLiquidados, strRedLoj,blnChkRed,blnAjustaData) + ') AS T ';

      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALCHQ').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function TfrmResFinanceiro.fRetCashback(strExp: String): Double;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Result := 0;

  Try
    qryGen := fCriaQuery;
    qryGen.Close;
    qryGen.SQL.Clear;

    strSQL := 'SELECT ' + strExp + '(CTR_VALDUP) AS VALDUP FROM ( ' +
      fRetSQLResFinanceiro(ttCadRec, tcTitCashback, strRedLoj,blnChkRed,blnAjustaData, blnClienteProfissional) + ') AS T ';

    qryGen.SQL.Add(strSQL);

    If Not fEmptyStr(strRedLoj) And (blnChkRed) then
      qryGen.ParamByName('REDE').AsString := strRedLoj
    Else
      qryGen.ParamByName('CODCLI').AsString := edtCodCliente.Text;

    qryGen.Open;
    Result := qryGen.FieldByName('VALDUP').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[fRetCashback]');
  End;
end;

function TfrmResFinanceiro.fRetCashbackLiq(strExp: String): Double;
Var
  qryGen: TUniQuery;
  strSQL: String;
begin
  Result := 0;

  Try
    qryGen := fCriaQuery;
    qryGen.Close;
    qryGen.SQL.Clear;

    strSQL := 'SELECT ' + strExp + '(CTR_VALREC) AS VALREC FROM ( ' +
                fRetSQLResFinanceiro(ttCadRec, tcTitCashbackLiq, strRedLoj,blnChkRed,blnAjustaData, blnClienteProfissional) + ') AS T ';

    qryGen.SQL.Add(strSQL);

    If Not fEmptyStr(strRedLoj) And (blnChkRed) then
      qryGen.ParamByName('REDE').AsString := strRedLoj
    Else
      qryGen.ParamByName('CODCLI').AsString := edtCodCliente.Text;

    qryGen.Open;
    Result := qryGen.FieldByName('VALREC').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[fRetCashbackLiq]');
  End;
end;

function TfrmResFinanceiro.fRetChequeAPrazoEmAberto(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;

  If Not fCfgSis('MPREFF', varBoolean) Then
  Begin
    Result :=  0;
    Exit;
  End;

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CHQ_VALCHQ) AS VALCHQ FROM ( ' +
                fRetSQLResFinanceiro(ttCadChq, tcChqAPrazoEmAberto, strRedLoj,blnChkRed,blnAjustaData) + ') AS T ';

      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALCHQ').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function TfrmResFinanceiro.fRetChequeAPrazoLiquidados(strExp: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;

  If Not fCfgSis('MPREFF', varBoolean) Then
  Begin
    Result :=  0;
    Exit;
  End;

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      strSQL := 'SELECT ' + strExp + '(CHQ_VALCHQ) AS VALCHQ FROM ( ' +
                fRetSQLResFinanceiro(ttCadChq, tcChqAPrazoLiquidados, strRedLoj,blnChkRed,blnAjustaData) + ') AS T ';

      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (blnChkRed) then
        ParamByName('REDE').AsString := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      Open;
    End;

    Result := qryGen.FieldByName('VALCHQ').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

procedure TfrmResFinanceiro.pAtribuiAcumulados;
Var
  cdsAcumuladoAno : TUniClientDataSet;
  qryGenCli : TUniQuery;
  strSQL : String;
  fltAcumulado: Double;

  function fCriaDataSetAcumuladoAno : TUniClientDataSet;
  begin

    Result := TUniClientDataSet.Create(Self);

    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'DATA';
      DataType := ftDate;
      Required := False;
    End;

    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'VALOR';
      DataType := ftFloat;
      Required := False;
    End;

    Result.IndexDefs.Add('IDX_ORDEM', 'VALOR', [ixDescending]);
    Result.IndexDefs[0].DescFields := 'VALOR';

    Result.IndexName := 'IDX_ORDEM';

    Result.CreateDataSet;

  end;

  function fGetValorAcumuladoAno(dtaData : TDate) : Double;
  var
    strSQL : String;
    qryAux : TUniQuery;
  begin

    strSQL :=          '  SELECT                           ';
    strSQL := strSQL + '    SUM(IF( CTR_DTAREC IS NOT NULL, (CTR_VALREC - IFNULL(CTR_VALJUR,0) + IFNULL(CTR_VALDES,0)), CTR_VALDUP )) AS ACUMULO    ';
    strSQL := strSQL + '  FROM                             ';
    strSQL := strSQL + '    CADREC B                       ';
    strSQL := strSQL + '    INNER JOIN CADCLI              ';
    strSQL := strSQL + '      ON CLI_CODCLI = B.CTR_CODCLI ';
    strSQL := strSQL + '  WHERE (                          ';

    If (Not fEmptyStr(strRedLoj) And (chkRedLoj.Checked = True)) Then
      strSQL := strSQL + '  CLI_CODRED = :REDE             '
    Else
    begin

      strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

      If (fCfgSis('TRFTCR', varString) = '2') And chkRedLoj.Checked Then
      Begin
        strSQL := strSQL + '    OR CLI_CODRED =                              ';
        strSQL := strSQL + '    (SELECT                                      ';
        strSQL := strSQL + '       CLI_CODRED                                ';
        strSQL := strSQL + '     FROM                                        ';
        strSQL := strSQL + '       CADCLI                                    ';
        strSQL := strSQL + '     WHERE CLI_CODCLI = :CODCLI)                 ';
      End;

    end;

    strSQL := strSQL + '    )                                  ';
    strSQL := strSQL + '    AND (                              ';
    strSQL := strSQL + '      (B.CTR_DTACAD <> B.CTR_DTAVEN)   ';
    strSQL := strSQL + '      OR (                             ';
    strSQL := strSQL + '        (B.CTR_DTACAD = B.CTR_DTAVEN)  ';
    strSQL := strSQL + '        AND (                          ';
    strSQL := strSQL + '          B.CTR_DTAREC > B.CTR_DTAVEN  ';
    strSQL := strSQL + '          OR B.CTR_DTAREC IS NULL      ';
    strSQL := strSQL + '        )                              ';
    strSQL := strSQL + '      )                                ';
    strSQL := strSQL + '    )                                  ';
    strSQL := strSQL + '    AND B.CTR_DTAVEN >= :DTAANO        ';

    {$IFDEF TESTABILIDADE_AUTCOM}
      // Filtro utilizado somente no teste automatizado
      strSQL := strSQL + '  AND (YEAR(B.CTR_DTAVEN) = YEAR(CURRENT_DATE) AND MONTH(B.CTR_DTAVEN) = MONTH(CURRENT_DATE)) ';
    {$ENDIF}

    strSQL := strSQL + '    AND B.CTR_DTACAD <= :DATA   ';
    strSQL := strSQL + '    AND (                       ';
    strSQL := strSQL + '      B.CTR_DTAREC >= :DATA     ';
    strSQL := strSQL + '      OR B.CTR_DTAREC IS NULL   ';
    strSQL := strSQL + '    )                           ';

    qryAux := fCriaQuery();

    Try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSQL);

      If qryAux.FindParam('REDE') <> Nil Then
        qryAux.ParamByName('REDE').AsString := strRedLoj;

      If qryAux.FindParam('CODCLI') <> Nil Then
        qryAux.ParamByName('CODCLI').AsString := edtCodCliente.Text;

      qryAux.ParamByName('DTAANO').AsDate := IncYear(VS_Date, -1);
      qryAux.ParamByName('DATA').AsDate   := dtaData;
      qryAux.Open;

      If Not qryAux.IsEmpty Then
        Result := qryAux.FieldByName('ACUMULO').AsFloat
      Else
        Result := 0;

    Finally
      FreeAndNil(qryAux);
    End;

  end;

begin

  qryGenCli := fCriaQuery(Self);

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT                             ';
    strSQL := strSQL + '  DISTINCT(C.CTR_DTACAD) AS DTACUM ';
    strSQL := strSQL + 'FROM                               ';
    strSQL := strSQL + '  CADREC C                         ';
    strSQL := strSQL + '  INNER JOIN CADCLI                ';
    strSQL := strSQL + '    ON CLI_CODCLI = C.CTR_CODCLI   ';
    strSQL := strSQL + 'WHERE (                            ';

    If Not fEmptyStr(strRedLoj) And (chkRedLoj.Checked = True) Then
      strSQL := strSQL + '  CLI_CODRED = :REDE '
    Else
    Begin
      strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

      If (fCfgSis('TRFTCR', varString) = '2') And chkRedLoj.Checked Then
      Begin
        strSQL := strSQL + '    OR CLI_CODRED =                              ';
        strSQL := strSQL + '    (SELECT                                      ';
        strSQL := strSQL + '       CLI_CODRED                                ';
        strSQL := strSQL + '     FROM                                        ';
        strSQL := strSQL + '       CADCLI                                    ';
        strSQL := strSQL + '     WHERE CLI_CODCLI = :CODCLI)                 ';
      End;

    End;

    strSQL := strSQL + '  )                                    ';
    strSQL := strSQL + '  AND (                                ';
    strSQL := strSQL + '    (C.CTR_DTACAD <> C.CTR_DTAVEN)     ';
    strSQL := strSQL + '    OR (                               ';
    strSQL := strSQL + '      (C.CTR_DTACAD = C.CTR_DTAVEN)    ';
    strSQL := strSQL + '      AND (                            ';
    strSQL := strSQL + '        C.CTR_DTAREC > C.CTR_DTAVEN    ';
    strSQL := strSQL + '        OR C.CTR_DTAREC IS NULL        ';
    strSQL := strSQL + '      )                                ';
    strSQL := strSQL + '    )                                  ';
    strSQL := strSQL + '  )                                    ';
    strSQL := strSQL + '  AND C.CTR_DTAVEN >= :DTAANO          ';

    {$IFDEF TESTABILIDADE_AUTCOM}
      // Filtro utilizado somente no teste automatizado
      strSQL := strSQL + '  AND (YEAR(C.CTR_DTAVEN) = YEAR(CURRENT_DATE) AND MONTH(C.CTR_DTAVEN) = MONTH(CURRENT_DATE)) ';
    {$ENDIF}

    strSQL := strSQL + 'ORDER BY DTACUM DESC ';

    With qryGenCli Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If FindParam('REDE') <> Nil Then
        ParamByName('REDE').AsString := strRedLoj;

      If FindParam('CODCLI') <> Nil Then
        ParamByName('CODCLI').AsString := edtCodCliente.Text;

      ParamByName('DTAANO').AsDate := IncYear(VS_Date, -1);
      Open;

      cdsAcumuladoAno := fCriaDataSetAcumuladoAno;

      Try

        If Not IsEmpty Then
        Begin
          First;
          While Not Eof Do
          Begin
            cdsAcumuladoAno.Append;
            cdsAcumuladoAno.FieldByName('DATA').AsDateTime := qryGenCli.FieldByName('DTACUM').AsDateTime;
            cdsAcumuladoAno.FieldByName('VALOR').AsFloat   := fGetValorAcumuladoAno(qryGenCli.FieldByName('DTACUM').AsDateTime);
            cdsAcumuladoAno.Post;
            Next;
          End;
        End;

        cdsAcumuladoAno.First;

        edtAcumuloAno.Clear;
        edtDtaMaiAcumulo.Clear;

        If Not cdsAcumuladoAno.IsEmpty Then
        Begin
          edtAcumuloAno.Text    := FloatToStrF(cdsAcumuladoAno.FieldByName('VALOR').AsFloat, ffNumber, 15, 2);
          edtDtaMaiAcumulo.Text := cdsAcumuladoAno.FieldByName('DATA').AsString;
        End;

      Finally
        FreeAndNil(cdsAcumuladoAno);
      End;

    End;

    fltAcumulado := fRetValorAcumuladoNoPeriodo(edtCodCliente.Text, fDataAcumulados, strRedLoj, chkRedLoj.Checked, True);
    edtAcumulo.Text := FloatToStrF(fltAcumulado, ffNumber, 15, 2);
  Finally
    FreeAndNil(qryGenCli);
  End;

end;

procedure TfrmResFinanceiro.pAtribuiMaiorCompra;
Var
  qryGenCli: TUniQuery;
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CLI_DOMCOM, ';
  strSQL := strSQL + '  CLI_VRMCOM, ';
  strSQL := strSQL + '  CLI_DTMCOM  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI ';
  strSQL := strSQL + 'WHERE ';
  If Not fEmptyStr(strRedLoj) And (chkRedLoj.Checked = True) Then
    strSQL := strSQL + '  CLI_CODRED = :REDE '
  Else
  Begin
    strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';
    If (fCfgSis('TRFTCR', varString) = '2') And chkRedLoj.Checked Then
    Begin
      strSQL := strSQL + ' OR CLI_CODRED =              ';
      strSQL := strSQL + ' (SELECT                      ';
      strSQL := strSQL + '    CLI_CODRED                ';
      strSQL := strSQL + '  FROM                        ';
      strSQL := strSQL + '    CADCLI                    ';
      strSQL := strSQL + '  WHERE CLI_CODCLI = :CODCLI) ';
    End;
  End;
  strSQL := strSQL + 'ORDER BY CLI_VRMCOM DESC ';
  strSQL := strSQL + 'LIMIT 1 ';

  qryGenCli := fCriaQuery(Self);
  Try
    With qryGenCli Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (chkRedLoj.Checked = True) Then
        ParamByName('REDE').AsString   := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;
      Open;

      edtMaiorCompra.Text    := FloatToStrF(FieldByName('CLI_VRMCOM').AsFloat, ffNumber, 15, 2);
      edtDtaMaiorCompra.Text := FieldByName('CLI_DTMCOM').AsString;
      edtNotaMaiorComp.Text  := FieldByName('CLI_DOMCOM').AsString;
    End;
  Finally
    FreeAndNil(qryGenCli);
  End;
end;

procedure TfrmResFinanceiro.pAtribuiUltimaCompra;
Var
  qryGenCli: TUniQuery;
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_CONPAG, ';
  strSQL := strSQL + '  CLI_ULTCOM, ';
  strSQL := strSQL + '  CLI_VRUCOM, ';
  strSQL := strSQL + '  CLI_DOUCOM, ';
  strSQL := strSQL + '  DATEDIFF(' + fCurrentDate + ', CLI_ULTCOM) AS INATIVO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI ';
  strSQL := strSQL + '  LEFT JOIN MOVGER                             ';
  strSQL := strSQL + '     ON GER_NUMDOC = LEFT(CLI_DOUCOM, 12)      ';
  strSQL := strSQL + '    AND GER_CODCLI = CLI_CODCLI                ';
  strSQL := strSQL + '    AND GER_ESPDOC = RIGHT(CLI_DOUCOM, 2)      ';
  strSQL := strSQL + '    AND GER_DTAENT = CLI_ULTCOM                ';

  strSQL := strSQL + 'WHERE ';
  If Not fEmptyStr(strRedLoj) And (chkRedLoj.Checked = True) Then
    strSQL := strSQL + ' CLI_CODRED = :REDE '
  Else
  Begin
    strSQL := strSQL + ' CLI_CODCLI = :CODCLI ';
    If (fCfgSis('TRFTCR', varString) = '2') And chkRedLoj.Checked Then
    Begin
      strSQL := strSQL + ' OR CLI_CODRED =              ';
      strSQL := strSQL + ' (SELECT                      ';
      strSQL := strSQL + '    CLI_CODRED                ';
      strSQL := strSQL + '  FROM                        ';
      strSQL := strSQL + '    CADCLI                    ';
      strSQL := strSQL + '  WHERE CLI_CODCLI = :CODCLI) ';
    End;
  End;
  strSQL := strSQL + 'ORDER BY CLI_ULTCOM DESC ';
  strSQL := strSQL + 'LIMIT 1 ';

  qryGenCli := fCriaQuery(Self);
  Try
    With qryGenCli Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      If Not fEmptyStr(strRedLoj) And (chkRedLoj.Checked = True) Then
        ParamByName('REDE').AsString   := strRedLoj
      Else
        ParamByName('CODCLI').AsString := edtCodCliente.Text;
      Open;

      edtDtaUltCom.Text := FieldByName('CLI_ULTCOM').AsString;
      mskCndPag.Text    :=  FieldByName('GER_CONPAG').AsString;
      edtVrUltCom.Text  := FloatToStrF(FieldByName('CLI_VRUCOM').AsFloat, ffNumber, 15, 2);
      edtNumNota.Text   := FieldByName('CLI_DOUCOM').AsString;
      edtInativo.Text   := FieldByName('INATIVO').AsString;
    End;
  Finally
    FreeAndNil(qryGenCli);
  End;
end;

function TfrmResFinanceiro.fAtribuiValores(pgbStatus: TcxProgressBar = Nil): Boolean;

  function fBuscaMaiorAtraso(cliente:String):String;
    function fExisteFeriado(data:TDateTime):Boolean;
    var
      qryFeriado :TUniQuery;
    begin
      qryFeriado := fCriaQuery(self);
      qryFeriado.SQL.Text :=
          ' SELECT COUNT(FER_DTAFER) FROM CADFER WHERE FER_DTAFER = ' +
               QuotedStr(FormatDateTime('YYYY-MM-DD',data));
      qryFeriado.Open;
      Result := qryFeriado.fields[0].AsInteger > 0;
      FreeAndNil(qryFeriado);
    end;

  Var
    qryAtraso: TUniQuery;
    strSQL : String;
    dataNova : TDateTime;
  begin
    qryAtraso := fCriaQuery(self);
    strSQL := '';
    strSQL := strSQL + ' SELECT ';

    If (fCfgSis('CVOREF') = 'S') Then
       strSQL := strSQL + fGetSqlDtaVenctoOriginal()
    Else
       strSQL := strSQL + ' CTR_DTAVEN ';

    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    CADREC ';
    strSQL := strSQL + '  INNER JOIN CADCLI ';
    strSQL := strSQL + '    ON CLI_CODCLI = CTR_CODCLI ';
    strSQL := strSQL + '  WHERE (';
    If Not (fEmptyStr(strRedLoj)) And (chkRedLoj.Checked = True) Then
      strSQL := strSQL + '  CLI_CODRED = :REDE '
    Else
    Begin
      strSQL := strSQL + '    CTR_CODCLI = :CODCLI ';
      If (fCfgSis('TRFTCR', varString) = '2') And chkRedLoj.Checked Then
      Begin
        strSQL := strSQL + ' OR CLI_CODRED = ';
        strSQL := strSQL + ' (SELECT ';
        strSQL := strSQL + '    CLI_CODRED ';
        strSQL := strSQL + '  FROM ';
        strSQL := strSQL + '    CADCLI ';
        strSQL := strSQL + '  WHERE CLI_CODCLI = :CODCLI) ';
      End;
    End;
    strSQL := strSQL + '  ) AND (CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) > 0 ';
    strSQL := strSQL + '    AND CTR_DTAVEN < :DTAVEN ';
    strSQL := strSQL + '    AND CTR_DTAREC IS NULL ';

    //Somente das empresas que o operador tem direito de acesso.
    If fCfgSis('EMREFN') = '1' Then
      strSQL := strSQL + '    AND CTR_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

    strSQL := strSQL + '  ORDER BY ';
    strSQL := strSQL + '    CTR_DTAVEN  LIMIT 1 ';

    qryAtraso.SQL.Add(strSQL);
    If Not (fEmptyStr(strRedLoj)) And (chkRedLoj.Checked = True) Then
      qryAtraso.ParamByName('REDE').AsString     := strRedLoj
    Else
      qryAtraso.ParamByName('CODCLI').AsString   := cliente;
    qryAtraso.ParamByName('DTAVEN').AsDateTime := VS_Date;

    qryAtraso.Open;

    If (Not qryAtraso.IsEmpty) And (qryAtraso.Fields[0].AsDateTime > 0) Then
    Begin
      dataNova := qryAtraso.Fields[0].AsDateTime;

      If blnAjustaData then
      Begin
        while (dayOfWeek(dataNova) in [1, 7]) Or (fExisteFeriado(dataNova)) do
          dataNova := datanova + 1;
      End;

      result := FloatToStrF(Date - dataNova, ffNumber, 15, 0);
    End
    Else
      Result := '0';
  end;

Var
  intQtdPedNaoFat,
  intQtdEPemAberto: Integer;
  fltTotPedNaoFat,
  fltTotEPemAberto: Real;

const
  MAX_PROG = 25;
begin
  blnClienteProfissional := fClienteProfissional(strCodCli);

  {*****************}
  {* ULTIMA COMPRA *}
  {**************LB*}
  pAtribuiUltimaCompra;
  pProgresso(1, MAX_PROG, pgbStatus);

  {*****************}
  {* DATA CADASTRO *}
  {**************LB*}
  pnlDataCadastro.Visible := (fCfgSis('TRFTCR', varString) = '1');
  if pnlDataCadastro.Visible Then
    edtCadastro.Text  := fCampoTabela('CLI_DTACAD', 'CADCLI', ['CLI_CODCLI'], [edtCodCliente.Text]);
  edtCreditos.Text  := FloatToStrF(fRetCreditos('SUM'), ffNumber, 15, 2);

  If (fCfgSis('EXCBRF', varBoolean)) And (blnClienteProfissional) Then
    edtCreditos.Text := FloatToStrF(fStrToFloat(edtCreditos.Text) + fRetCashback('SUM'), ffNumber, 15, 2);

  pProgresso(2, MAX_PROG, pgbStatus);

  {*********************************************}
  {* SOMA E QTD DE VALORES ABERTO E LIQUIDADOS *}
  {******************************************LB*}
  edtQtdAberto1.Text  := FloatToStr(fRetTitAberto('COUNT'));
  edtVrAberto1.Text   := FloatToStrF(fRetTitAberto('SUM'), ffNumber, 15, 2);
  pProgresso(3, MAX_PROG, pgbStatus);

  edtQtdLiq1.Text     := FloatToStr(fRetTitLiquidado('COUNT'));
  edtVrLiq1.Text      := FloatToStrF(fRetTitLiquidado('SUM'), ffNumber, 15, 2);
  pProgresso(4, MAX_PROG, pgbStatus);

  edtQtdAberto2.Text  := FloatToStr(fRetChqAberto('COUNT', edtCodCliente.Text, strRedLoj, blnChkRed,blnAjustaData));
  edtVrAberto2.Text   := FloatToStrF(fRetChqAberto('SUM', edtCodCliente.Text, strRedLoj, blnChkRed,blnAjustaData), ffNumber, 15, 2);
  pProgresso(5, MAX_PROG, pgbStatus);

  edtQtdLiq2.Text     := FloatToStr(fRetChqLiquidados('COUNT'));
  edtVrLiq2.Text      := FloatToStrF(fRetChqLiquidados('SUM'), ffNumber, 15, 2);
  pProgresso(6, MAX_PROG, pgbStatus);

  edtVrAberto3.Text   := FloatToStrF(fRetChqDevolvidos('SUM', edtCodCliente.Text, strRedLoj, blnChkRed,blnAjustaData), ffNumber, 15, 2);
  edtQtdAberto3.Text  := FloatToStr(fRetChqDevolvidos('COUNT', edtCodCliente.Text, strRedLoj, blnChkRed,blnAjustaData));
  pProgresso(7, MAX_PROG, pgbStatus);

  edtVrLiq3.Text      := FloatToStrF(fRetChqDevolvidosLiq('SUM'), ffNumber, 15, 2);
  edtQtdLiq3.Text     := FloatToStr(fRetChqDevolvidosLiq('COUNT'));
  pProgresso(8, MAX_PROG, pgbStatus);

  edtAtrasQtd.Text    := FloatToStr(fRetTitAtrasados('COUNT'));
  edtAtrasVr.Text     := FloatToStrF(fRetTitAtrasados('SUM'), ffNumber, 15, 2);
  pProgresso(9, MAX_PROG, pgbStatus);

  edtAtrasLiqQtd.Text := FloatToStr(fRetTitAtrasadosLiq('COUNT'));
  edtAtrasLiqVr.Text  := FloatToStrF(fRetTitAtrasadosLiq('SUM'), ffNumber, 15, 2);
  pProgresso(10, MAX_PROG, pgbStatus);

  {**************}
  {* TELECHEQUE *}
  {***********RV*}
  edtTeleQtd.Text := FloatToStr(fRetTelecheques('COUNT'));
  edtTeleVr.Text  := FloatToStrF(fRetTelecheques('SUM'), ffNumber, 15, 2);

  edtTeleLiqQtd.Text := FloatToStr(fRetTelechequesLiq('COUNT'));
  edtTeleLiqVr.Text  := FloatToStrF(fRetTelechequesLiq('SUM'), ffNumber, 15, 2);
  pProgresso(20, MAX_PROG, pgbStatus);


  {*************************}
  {* TRAZ INFORMAÇÕES REF. *}
  {* AOS CRÉDITOS          *}
  {**********************FS*}
  edtQtdAbertoCred.Text := FloatToStr(fRetCreditos('COUNT'));
  edtVrAbertoCred.Text  := FloatToStrF(fRetCreditos('SUM'), ffNumber, 15, 2);
  pProgresso(11, MAX_PROG, pgbStatus);

  edtQtdLiqCred.Text := FloatToStr(fRetCreditosLiq('COUNT'));
  edtVrLiqCred.Text  := FloatToStrF(fRetCreditosLiq('SUM'), ffNumber, 15, 2);
  pProgresso(12, MAX_PROG, pgbStatus);

  edtQtdPedNaoFat.Text  := '0';
  edtTotPedNaoFat.Text  := '0';
  edtQtdEPemAberto.Text := '0';
  edtTotEPemAberto.Text := '0';
  fltTotPedNaoFat       := 0;
  fltTotEPemAberto      := 0;

  If fCfgSis('MPDAFF', VarBoolean) Or fCfgSis('PDVLIM', VarBoolean) Then
  Begin
    edtTotPedNaoFat.Text := FloatToStrF(fTotalPedidosEmAberto(strCodCli, IfThen(blnChkRed, strRedLoj, ''), intQtdPedNaoFat),ffNumber,15,2);
    fltTotPedNaoFat      := fTotalPedidosEmAberto(strCodCli, IfThen(blnChkRed, strRedLoj, ''), intQtdPedNaoFat, True);
    edtQtdPedNaoFat.Text := FloatToStr(intQtdPedNaoFat);
  End;

  If fCfgSis('LMCEMP', VarBoolean) Then
  Begin
    fltTotEPemAberto      := fTotalEmprestimosEmAberto(strCodCli, intQtdEPemAberto);
    edtTotEPemAberto.Text := FloatToStrF(fltTotEPemAberto,ffNumber,15,2);
    edtQtdEPemAberto.Text := FloatToStr(intQtdEPemAberto);
  End;
  pProgresso(13, MAX_PROG, pgbStatus);

  {*************************}
  {* TRAZ INFORMAÇÕES REF. *}
  {* AOS CASHBACK          *}
  {**********************RG*}
  If (fCfgSis('EXCBRF', varBoolean)) And (blnClienteProfissional) Then
  Begin
    edtQtdAbertoCash.Text := FloatToStr(fRetCashback('COUNT'));
    edtVrAbertoCash.Text  := FloatToStrF(fRetCashback('SUM'), ffNumber, 15, 2);
    pProgresso(24, MAX_PROG, pgbStatus);

    edtQtdLiqCash.Text := FloatToStr(fRetCashbackLiq('COUNT'));
    edtVrLiqCash.Text  := FloatToStrF(fRetCashbackLiq('SUM'), ffNumber, 15, 2);
    pProgresso(25, MAX_PROG, pgbStatus);
  End;

  {**********}
  {* TOTAIS *}
  {*******LB*}
  edtTotalQtd.Text      := IntToStr(StrToInt(edtQtdAberto1.Text) + StrToIntDef(edtTeleQtd.Text,0) + StrToInt(edtQtdAberto2.Text) + StrToInt(edtQtdAberto3.Text) + StrToInt(edtQtdPedNaoFat.Text) + StrToInt(edtQtdAbertoCred.Text) + StrToInt(edtQtdEPemAberto.Text));
  edtTotalVr.Text       := FloatToStrF(fStrToFloat(edtVrAberto1.Text) + fStrToFloat(edtTeleVr.Text) + fStrToFloat(edtVrAberto2.Text) + fStrToFloat(edtVrAberto3.Text) + fStrToFloat(edtTotPedNaoFat.Text) + fStrToFloat(edtVrAbertoCred.Text) + fStrToFloat(edtTotEPemAberto.Text), ffNumber, 15, 2);
  edtTotalLiqQtd.Text   := IntToStr(StrToInt(edtQtdLiq1.Text) + StrToIntDef(edtTeleLiqQtd.Text,0) + StrToInt(edtQtdLiq2.Text) + StrToInt(edtQtdLiq3.Text) + StrToInt(edtQtdLiqCred.Text));
  edtTotalLiqValor.Text := FloatToStrF(fStrToFloat(edtVrLiq1.Text) + fStrToFloat(edtTeleLiqVr.Text) + fStrToFloat(edtVrLiq2.Text) + fStrToFloat(edtVrLiq3.Text) + fStrToFloat(edtVrLiqCred.Text), ffNumber, 15, 2);

  If (fCfgSis('EXCBRF', varBoolean)) And (blnClienteProfissional) Then
  Begin
    edtTotalQtd.Text      := IntToStr(StrToInt(edtTotalQtd.Text) + StrToInt(edtQtdAbertoCash.Text));
    edtTotalVr.Text       := FloatToStrF(fStrToFloat(edtTotalVr.Text) + fStrToFloat(edtVrAbertoCash.Text), ffNumber, 15, 2);
    edtTotalLiqQtd.Text   := IntToStr(StrToInt(edtTotalLiqQtd.Text) + StrToInt(edtQtdLiqCash.Text));
    edtTotalLiqValor.Text := FloatToStrF(fStrToFloat(edtTotalLiqValor.Text) + fStrToFloat(edtVrLiqCash.Text), ffNumber, 15, 2);
  End;

  pProgresso(14, MAX_PROG, pgbStatus);

  {*****************************}
  {* TOTAL LIMITE / DISPONIVEL *}
  {**************************LB*}
  edtLimTotal.Text := FloatToStrF(fLimiteCreditoCliente(edtCodCliente.Text, blnChkRed, strRedLoj), ffNumber, 15, 2);
  edtDisponivel.Text := FloatToStrF(fStrToFloat(edtLimTotal.Text) - fStrToFloat(edtVrAberto1.Text), ffNumber, 15, 2);
  pProgresso(15, MAX_PROG, pgbStatus);

  {*****************************************}
  {* CHEQUE ENTRA NA CONTA CORRENTE?       *}
  {**************************************MV*}
  If fCfgSis('CHQCCO') = 'S' Then
    edtDisponivel.Text := FloatToStrF(fStrToFloat(edtDisponivel.Text) - fStrToFloat(edtVrAberto2.Text),ffNumber, 15, 2);

  {*****************************************}
  {* RETIRA CHEQUES DEVOLVIDOS E TIT CH    *}
  {**************************************AF*}
  edtDisponivel.Text := FloatToStrF(fStrToFloat(edtDisponivel.Text) - fStrToFloat(edtVrAberto3.Text),ffNumber, 15, 2);

  {****************************}
  {* RETIRA PEDIDOS EM ABERTO *}
  {*************************JC*}
  If fCfgSis('PDVLIM', VarBoolean) Then
  begin
    if fCfgSis('CSDCOU', VarBoolean) then
      edtDisponivel.Text := FloatToStrF(fStrToFloat(edtDisponivel.Text) - fltTotPedNaoFat,ffNumber, 15, 2)
    else
      edtDisponivel.Text := FloatToStrF((fStrToFloat(edtDisponivel.Text) -
                                         fTotalPedidosEmAberto(strCodCli,
                                                               IfThen(blnChkRed, strRedLoj, ''),
                                                               intQtdPedNaoFat,
                                                               True,
                                                               '"001","007","012","013"')),
                                        ffNumber, 15, 2);
  end;

  {********************************}
  {* RETIRA EMPRESTIMOS EM ABERTO *}
  {*****************************BL*}
  If fCfgSis('LMCEMP', VarBoolean) Then
    edtDisponivel.Text := FloatToStrF(fStrToFloat(edtDisponivel.Text) - fltTotEPemAberto,ffNumber, 15, 2);

  {****************}
  {* MAIOR COMPRA *}
  {*************LB*}
  pAtribuiMaiorCompra();
  pProgresso(16, MAX_PROG, pgbStatus);

  {****************}
  {* ACUMULO      *}
  {*************IV*}
  pAtribuiAcumulados();
  pProgresso(17, MAX_PROG, pgbStatus);

  {*******************}
  {* DENTRO DO PRAZO *}
  {*******************}
  edtQtdDentroPrazoAberto.Text := FloatToStr(fRetTitulosDentroPrazoEmAberto('COUNT'));
  edtValorDentroPrazoAberto.Text := FloatToStrF(fRetTitulosDentroPrazoEmAberto('SUM'), ffNumber, 15, 2);

  edtQtdDentroPrazoLiquidado.Text := FloatToStr(fRetTitulosDentroPrazoLiquidados('COUNT'));
  edtValorDentroPrazoLiquidado.Text := FloatToStrF(fRetTitulosDentroPrazoLiquidados('SUM'), ffNumber, 15, 2);

  pProgresso(18, MAX_PROG, pgbStatus);

  {***********}
  {* ATRASOS *}
  {********LB*}
  edtAtualAtrasado.Text := fBuscaMaiorAtraso(edtCodCliente.Text);
  edtMaiorAtrasado.Text := fBuscaMaiorAtrasado;
  edtMediaAtrasado.Text := FloatToStrF(fBuscaMediaDeAtraso(edtCodCliente.Text, strRedLoj, chkRedLoj.Checked, blnAjustaData), ffNumber, 15, 2);

  if blnAjustaData then
    edtPonderadaAtraso.Text := fRetornaMediaPonderadaNova
  else
    edtPonderadaAtraso.Text := fRetornaMediaPonderada;
  pProgresso(19, MAX_PROG, pgbStatus);

  {******************}
  {* CHEQUE A VISTA *}
  {******************}
  edtQtdChequeAVistaEmAberto.Text := FloatToStr(fRetChequeAVistaEmAberto('COUNT'));
  edtValorChequeAVistaEmAberto.Text := FloatToStrF(fRetChequeAVistaEmAberto('SUM'), ffNumber, 15, 2);

  edtQtdChequeAVistaLiquidados.Text := FloatToStr(fRetChequeAVistaLiquidados('COUNT'));
  edtValorChequeAVistaLiquidados.Text := FloatToStrF(fRetChequeAVistaLiquidados('SUM'), ffNumber, 15, 2);

  pProgresso(21, MAX_PROG, pgbStatus);

  {******************}
  {* CHEQUE A PRAZO *}
  {******************}
  edtQtdChequeAPrazoEmAberto.Text := FloatToStr(fRetChequeAPrazoEmAberto('COUNT'));
  edtValorChequeAPrazoEmAberto.Text := FloatToStrF(fRetChequeAPrazoEmAberto('SUM'), ffNumber, 15, 2);

  edtQtdChequeAPrazoLiquidados.Text := FloatToStr(fRetChequeAPrazoLiquidados('COUNT'));
  edtValorChequeAPrazoLiquidados.Text := FloatToStrF(fRetChequeAPrazoLiquidados('SUM'), ffNumber, 15, 2);

  pProgresso(22, MAX_PROG, pgbStatus);

  {****************************************}
  {* DUPLICATAS COM VENCIMENTO PRORROGADO *}
  {*************************************FS*}
  pTrazProrrogacoes;
  pProgresso(23, MAX_PROG, pgbStatus);
  result := True;
end;

end.

