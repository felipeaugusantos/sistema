unit untFatAltQtdeItensPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  ExtCtrls, DB, Uni, BitBtnLockedIncrem, Mask, MaskEditFocus, untConsertoEquipamento,
  cxProgressBar, TypInfo, Faturamento.Classes.TAlterarPedido, frxClass, frxExportCSVTestabilidade,
  Vcl.Grids, DBGridCitel, Vcl.DBGrids, UniClientDataSet, UniDataSetProvider, untMsgInterna,
  untLiberacao, Faturamento.Origem.TOrigemFaturamento, Vcl.ComCtrls, untFatGor;

type
  TfrmFatAltQtdeItensPedido = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnlBusca: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    edtNumDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtEspDoc: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlDados: TPanel;
    pnlForPagAtu: TPanel;
    lbl7: TLabel;
    edtForPagAtu: TEditFocus;
    edtDesFpgAtu: TEditFocus;
    pnl2: TPanel;
    lbl8: TLabel;
    edtCodCndAtu: TEditFocus;
    mskCndPagAtu: TMaskEditFocus;
    edtDesCndAtu: TEditFocus;
    pnl3: TPanel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    edtCodCli: TEditFocus;
    edtDtaEnt: TEditFocus;
    edtDesCli: TEditFocus;
    edtValDocAtu: TEditFocus;
    pnlItens: TPanel;
    lbl3: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    dbgItens: TDBGridCitel;
    dtDataEntrega: TDateTimePicker;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgItensEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaErro(Sender: TWinControl; strMsgErro: string;
      E: Exception);
    procedure dtDataEntregaChange(Sender: TObject);
    procedure dtDataEntregaExit(Sender: TObject);
    procedure dbgItensKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    dtsDados : TDataSource;
    cdsDados : TUniClientDataSet;
    pvdDados : TUniDataSetProvider;

    cdsVendaBkp : TUniClientDataSet;

    intSemaforoConsulta: Integer;
    intSemaforoValidar : Integer;

    objAltCnd: TAlterarPedido;

    stlForPag: TStringList;
    stlCndPag: TStringList;

    strCcnAnt: String;
    strCndAnt: String;
    strFpgAnt: String;
    strFpgLib: String;

    strCodCndAnt: String;

    blnTemItensDeletados: Boolean;
    blnBaiPed: Boolean;
    blnBaixaPedidoNaoEntregue: Boolean;

    cdsDesEsp : TUniClientDataSet;

    objLiberacao : TLiberacao;

    procedure pLimpaTela;
    procedure pEnviaMsg;
    procedure pAtualizaDadosPedido;
    function fFechaPD: Boolean;

    procedure pBeforeDelete(DataSet: TDataSet);
    procedure pBeforePost(DataSet: TDataSet);
    procedure pAfterInsert(DataSet: TDataSet);
    procedure pAfterOpen(DataSet: TDataSet);

    procedure pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);
    procedure pStepStatusGravacao(pgbProgresso: TcxProgressBar);
    procedure pAtualizaItensRomaneio;
    procedure pAtualizaNumRom;

    function fCalculaDescontoEspecial: Double;
    function fGetProdutosAlterados(blnMsgVen: Boolean = True): String;
    function fPedidoEntFut: Boolean;

    function fBuscaQtdExpAtual(strAutInc: String): Double;
    function fBuscaQtdSepAtual(strAutInc: String): Double;

    procedure pLimparItens;

    function fConfirma: Boolean;
    Function fBaixaPedido(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure pCriaClientDesEsp;
    procedure pProcessaClientDesEsp;
    procedure pProcessarSalDis;
    function fExcluiMovCar: Boolean;

  public
    { Public declarations }

    blnCarregaQtdSepOriginal: Boolean;
    blnCarregaBxSepOriginal: Boolean;
    strUltimoPedido,
    strNumRom,
    strCodOco: String;
    strHisBai: String;
    blnExpedicao: Boolean;
    blnShowMensagemSucesso: Boolean;
    blnTrocaCliente: Boolean;
    strCodCliNov: String;
    blnEstornarValorAdt: Boolean;
    blnBaixaF10PnlDadosPedOrc: Boolean;

    function fCarregarPedido: Boolean;

    class function pBaixarPedidoNaoEntregue(strNumPed, strEspPed, strEmpPed, strCliPed: String;
      blnF10PnlDadosPedOrc: Boolean = False; blnVendaPerdida: Boolean = False;
      strCodOco: String = ''; strHisBai: String = ''; blnMostrarMensagem: Boolean = True;
      blnTrocaCliente: Boolean = False; strCodCliNov: String = '';
      blnEstValorAdt: Boolean = False; FncLimparSeparacao : TFunctionLimparSeparacao = Nil;
      strAutIncGor: String = ''; blnApagarExtLar: Boolean = False; strCodComplementoOcorrencia : String = '';
      strNomeForm: String = ''): Boolean;

    class procedure pMensagemPedidoBaixado(strNumDoc, strEspDoc, strCodEmp, strCodOco : String; strHisBai: String = '');

    class function fGetOcorrencia(Var strHisBai : String; blnHistComplementar : Boolean = False) : String; Overload;

    class function fGetOcorrencia(Var strHisBai : String; var blnGerarVendaPerdida: Boolean;
       blnHistComplementar : Boolean = False; blnMostrarOpVendaPedida: Boolean = False) : String; Overload;

    class function fGetOcorrencia(Var strHisBai, strCodComplementoOcorrencia : String; var blnGerarVendaPerdida: Boolean;
       blnHistComplementar : Boolean = False; blnMostrarOpVendaPedida: Boolean = False;
       blnCrm : Boolean = False; strEspDoc : String = '') : String; Overload;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pEscapePressed; Override;
  end;

var
  frmFatAltQtdeItensPedido: TfrmFatAltQtdeItensPedido;

implementation

uses StrUtils, untConsultas, untPanelCxPedOrc, System.UITypes, untTypesSistema,
  untPnlDadosPedOrc, untFuncoes, untConstantes, untFuncoesSimples, untFuncFat,
  untGravando, untFatCupomDesconto, untDigOcorrencia, untAdiantamentoCliente, untDuplicatas,
  untDisparaEmailAut, untFuncFatTypes, untAdiantamentoClienteGenerico,
  Yapay.Api.Facade, untAlpe, Faturamento.Classes.TValidarVenda, untCadRec;

{$R *.dfm}

procedure TfrmFatAltQtdeItensPedido.btnConfirmaErro(Sender: TWinControl;
  strMsgErro: string; E: Exception);
begin
  inherited;
  If E Is EAbort Then
    Exit;

  If E Is Exception Then
    pMensagensErro(E.Message, '');
end;

procedure TfrmFatAltQtdeItensPedido.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  if (gdFocused in State) then
  begin
    if cdsDados.FieldByName('ITE_ENTRET').AsString = 'E' then
      if (Column.Field.FieldName = 'ITE_DTENTR') then
      Begin
        with dtDataEntrega do
        begin
          dtDataEntrega.Left := Rect.Left + dbgItens.Left + 1;
          dtDataEntrega.Top := Rect.Top + dbgItens.Top + 1;
          dtDataEntrega.Width := Rect.Right - Rect.Left + 2;
          dtDataEntrega.Width := Rect.Right - Rect.Left + 2;
          dtDataEntrega.Height := Rect.Bottom - Rect.Top + 2;

          dtDataEntrega.Visible := True;
          dtDataEntrega.Date := cdsDados.FieldByName('ITE_DTENTR').AsDateTime;
        end;
      End;
  end;

  With cdsDados Do
  Begin
    {**********************************}
    { CONFIGURACAO DE COR P/ SELECAO   }
    {*******************************IV*}
    If (Not Active) Or (IsEmpty) Then
      Exit;

    {**********************************}
    { CONFIGURACAO DE COR P/ EXPEDICAO }
    {*******************************JB*}
    If (fFormataFloat(FieldByName('ITE_QTDITE').AsFloat, 2) = fFormataFloat(FieldByName('ITE_QTDEXP').AsFloat, 2)) Then
    Begin
      If dbgItens.Canvas.Brush.Color = clHighlight Then
        dbgItens.Canvas.Font.Color := clWhite;

      dbgItens.Canvas.Brush.Color := clLime;
    End
    Else
    Begin
      If (fFormataFloat(FieldByName('ITE_QTDITE').AsFloat, 2) > fFormataFloat(FieldByName('ITE_QTDEXP').AsFloat, 2)) And
         (fFormataFloat(FieldByName('ITE_QTDEXP').AsFloat, 2) <> 0) Then
      Begin
        If dbgItens.Canvas.Brush.Color = clHighlight Then
          dbgItens.Canvas.Font.Color := clBlack;

        dbgItens.Canvas.Brush.Color := clYellow;
      end;
    End;
  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatAltQtdeItensPedido.dbgItensEnter(Sender: TObject);
begin
  inherited;
  cdsDados.FieldByName('ITE_QTDITE').FocusControl;
end;

procedure TfrmFatAltQtdeItensPedido.dbgItensKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = Chr(9)) or (cdsDados.FieldByName('ITE_ENTRET').AsString = 'R') then
    Exit;

  if (dbgItens.SelectedField.FieldName = 'ITE_DTENTR') then
  begin
    pSetFocus(dtDataEntrega);
    SendMessage(dtDataEntrega.Handle, WM_Char, word(Key), 0);
  end;
end;

procedure TfrmFatAltQtdeItensPedido.dtDataEntregaChange(Sender: TObject);
var
  intDiaEnt : Extended;
  dtaData   : TDateTime;
begin
  inherited;

  if dtDataEntrega.Date < StrToDate(FormatDateTime('dd/mm/yyyy', fNow())) then
  Begin
    fMensagem('ATENÇÃO!', 'Não é possível uma data de entrega menor que a data atual!', ['&Ok']);
    Exit;
  End;

  dtaData := dtDataEntrega.Date;
  If (Not fTravarDataForaDiaUtil(dtaData, intDiaEnt, edtCodEmp.Text)) Then
    dtDataEntrega.Date := dtaData;

  cdsDados.Edit;
  cdsDados.FieldByName('ITE_DTENTR').AsDateTime := dtDataEntrega.Date;
  cdsDados.Post;
end;

procedure TfrmFatAltQtdeItensPedido.dtDataEntregaExit(Sender: TObject);
begin
  inherited;
  if dbgItens.SelectedField.FieldName = 'ITE_DTENTR' then
    dtDataEntrega.Visible := False;
end;

procedure TfrmFatAltQtdeItensPedido.pAfterInsert(DataSet: TDataSet);
begin
  If (cdsDados.Tag = 0) Then
    DataSet.Cancel;
end;

procedure TfrmFatAltQtdeItensPedido.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('ITE_QTDITE') <> nil Then
      TFloatField(FieldByName('ITE_QTDITE')).DisplayFormat := '#,##0.00';

    If FindField('ITE_QTDEXP') <> nil Then
      TFloatField(FieldByName('ITE_QTDEXP')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TfrmFatAltQtdeItensPedido.pAtualizaDadosPedido;
begin
  With objAltCnd.objVenda Do
  Begin
    edtCodCli.Text    := strCodCli;
    edtDesCli.Text    := strCliNom;
    edtDtaEnt.Text    := FormatDateTime('DD/MM/YYYY', dtaDtaEnt);
    strCodCndAnt      := strCodCnd;
    edtCodCndAtu.Text := strCodCnd;
    mskCndPagAtu.Text := strConPag;
    edtDesCndAtu.Text := strDesCnd;
    edtForPagAtu.Text := strCodFpg;
    edtDesFpgAtu.Text := strDesFpg;
    edtValDocAtu.Text := FormatFloat('##,#0.00', fltTotOri);
    edtCodVen.Text    := strCodVen;
    edtDesVen.Text    := strNomVen;

    pCloneDataSet(cdsDados, cdsVenda);

    (cdsDados.FieldByName('ITE_SALDIS') As TFloatField).DisplayFormat := '#,##0.000';
    pProcessarSalDis;

    pnlItens.Enabled  := True;
    pnlBusca.Enabled  := False;

    pProcessaClientDesEsp;
  End;
end;

procedure TfrmFatAltQtdeItensPedido.pAtualizaItensRomaneio;
  Var
    qryAux   : TUniQuery;
    strAutInc: String;
Begin
  qryAux := fCriaQuery(Nil);
  strAutInc := ''; 
  Try
    With qryAux, SQL Do
    Begin
      {**********************************************************}
      {* SELECIONA ITENS QUE ESTÃO NO ROMDETX MAS NÃO NO FATDOR *}
      {**********************************************************}
      Clear;
      Add('SELECT ');
      Add('  R.AUTOINCREM AS AUTINC ');
      Add('FROM   ');
      Add('  ROMDETX R LEFT JOIN FATDOR D ON R.DET_NUMDOC = D.FDO_NUMDOC ');
      Add('                              AND R.DET_ESPDOC = D.FDO_ESPDOC ');
      Add('                              AND R.DET_CODCLI = D.FDO_CODCLI ');
      Add('                              AND R.DET_AUTINC = D.AUTOINCREM ');
      Add('WHERE R.DET_NUMROM = :NUMROM       ');
      Add('  AND R.DET_EMPROM = :EMPROM       ');
      Add('  AND IFNULL(D.FDO_SEQGER,"") = "" ');
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := VS_strCodEmp;
      Open;

      First;
      While Not Eof Do
      Begin
        If (Not fEmptyStr(FieldByName('AUTINC').AsString)) Then
          pIncrementaListaStr(FieldByName('AUTINC').AsString, strAutInc, True);
        Next;
      End;

      If (Not strAutInc.IsEmpty) Then
      Begin
        Close;
        Clear;
        Add('DELETE FROM ROMDETX                             ');
        Add(' WHERE AUTOINCREM IN (' + strAutInc + ')        ');
        Add('   AND DET_EMPROM = ' + QuotedStr(VS_strCodEmp)  );
        ExecSQL;
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmFatAltQtdeItensPedido.pAtualizaNumRom;
  Var
    qryAux   : TUniQuery;
Begin
  qryAux := fCriaQuery(Self);

  With qryAux, SQL Do
  Begin
    Clear;
    Add('UPDATE FATGOR ');
    Add('SET    FGO_NUMROM = :NUMROM ');
    Add('WHERE  FGO_NUMDOC = :NUMDOC ');
    Add('AND    FGO_ESPDOC = :ESPDOC ');
    Add('AND    FGO_CODCLI = :CODCLI ');
    Add('AND    FGO_CODEMP = :CODEMP ');
    ParamByName('NUMROM').AsString := strNumRom;
    ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    ParamByName('CODCLI').AsString := edtCodCli.Text;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ExecSQL;
  End;

  FreeAndNil(qryAux);
end;

class function TfrmFatAltQtdeItensPedido.fGetOcorrencia(Var strHisBai : String; blnHistComplementar : Boolean = False) : String;
begin
  Try
    Result := '';
    pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);
    frmDigOcorrencia.blnInformarHisCom := blnHistComplementar;
    frmDigOcorrencia.ShowModal;

    If (frmDigOcorrencia.ModalResult = mrOk) Then
    Begin

      Result := frmDigOcorrencia.strCodOco;

      If (blnHistComplementar) Then
        strHisBai := frmDigOcorrencia.edtHisCom.Text;

    end;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmDigOcorrencia);
end;

class function TfrmFatAltQtdeItensPedido.fGetOcorrencia(Var strHisBai : String;
  var blnGerarVendaPerdida: Boolean; blnHistComplementar : Boolean = False;
  blnMostrarOpVendaPedida: Boolean = False) : String;
begin
  Try
    Result := '';
    pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);
    frmDigOcorrencia.blnInformarHisCom  := blnHistComplementar;
    frmDigOcorrencia.blnUsarVendaPerdida := blnMostrarOpVendaPedida;
    frmDigOcorrencia.ShowModal;

    If (frmDigOcorrencia.ModalResult = mrOk) Then
    Begin

      Result := frmDigOcorrencia.strCodOco;

      If (blnHistComplementar) Then
        strHisBai := frmDigOcorrencia.edtHisCom.Text;

      blnGerarVendaPerdida := frmDigOcorrencia.ckbIncluirOrcVendasPerdidas.Checked;

    end;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmDigOcorrencia);
end;

function TfrmFatAltQtdeItensPedido.fFechaPD: Boolean;
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;

  Result := False;

  If (edtEspDoc.Text = 'OR') And (Not fVerificaAcessoSistema('BAIPDV', strLoginUsuarioLogado)) Then Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  If (edtEspDoc.Text = 'PD') And (Not fVerificaAcessoSistema('BXPNFT', strLoginUsuarioLogado)) Then Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  if fEmptyStr(strCodOco) then
    strCodOco := fGetOcorrencia(strHisBai, True);

  If Not fEmptyStr(strCodOco) Then
  Begin
    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.fExecutarAcao := fBaixaPedido;
      frmAguarde.ShowModal;
      Result := frmAguarde.blnConfirma;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
    pFreeAndNil(frmAguarde);
  End;
end;

Function TfrmFatAltQtdeItensPedido.fBaixaPedido(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    strUltPar: String;
    intContUltPar: Integer;

    objAlpe: TAlpe;
    strHistor: String;
    totAdtCli: TTotaisAdiantamento;
begin
  Try
    pInfoStatusGravacao('Aguarde... Baixando pedido', pgbStatus);
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := 8;

    pStepStatusGravacao(pgbStatus);

    Result := True;

    fStartTransaction;

    With objAltCnd, objVenda Do
    Begin

      if Self.blnTrocaCliente then
      begin
        objAltCnd.blnTrocaCliente := True;
        objAltCnd.strCodCli := strCodCliNov;
        if (fValidaUtilizarPedido(objAltCnd.strNumPed, objAltCnd.strEspPed, objAltCnd.strEmpPed, objAltCnd.strEspPed)) and
           (TAdiantamento.fTrocaClienteAdiantamento(objAltCnd.strNumPed, objAltCnd.strEspPed, objAltCnd.strEmpPed, strCodCliNov)) and
           (objAltCnd.fGravarPedido(False)) then
          objAltCnd.fCarregarPedido
        else
        begin
          fRollBack;
          Exit(False);
        end;
      end;

      If (TAlpe.fPedidoAlpe(strNumPed, strEspPed, strEmpPed)) And
         (TAdiantamento.fGetTotaisAdiantamento(strNumPed, strEspPed, strEmpPed).fltValLan > 0.00) then
      Begin
        objAlpe := TAlpe.Create;
        try
          objAlpe.pCarregaPedidoAlpe(strNumPed, strEspPed, strEmpPed);

          strHistor := 'REF. ESTORNO ADIANTAMENTO ALPE. PEDIDO: '+
                       strNumPed+'-'+strEspPed + ' - NUMPOK: ' + objAlpe.strNumPok;

          Result :=  TAdiantamento
                     .fLancarDebitoAdiantamento(strNumPed,
                                               strEspPed,
                                               strEmpPed,
                                               strLoginUsuarioLogado,
                                               strHistor,
                                               TAdiantamento.fGetTotaisAdiantamento(strNumPed, strEspPed, strEmpPed).fltValLan,
                                               StrToInt(fRetRcxCon),
                                               totAdtCli,
                                               strCodCli);
        finally
          FreeAndNil(objAlpe);
        end;
      End
      {***********************************************************}
      {* SE O PEDIDO TIVER DUPLICATAS EM ABERTO, DEVE EXCLUÍ-LAS *}
      {********************************************************MM*}
      Else If (fltDupRec <= 0) Then
      Begin
        pDeletaCadRec(strNumPed, strEspPed, strEmpPed, fRetClienteOriginal);

        {********************************************************************************}
        {* SE O PEDIDO POSSUIR CREDITO DE ADIANTAMENTOS DEVE BAIXAR ESTA SALDO E LANCAR *}
        {* NO CONTAS A RECEBER DO CLIENTE ATRAVES DE DOCUMENTO DE CREDITO "CC"          *}
        {*****************************************************************************JC*}
        If (TAdiantamento.fGetTotaisAdiantamento(strNumPed, strEspPed, strEmpPed).fltValLan > 0.00) Then
        Begin
          If (blnEstornarValorAdt) Then
          Begin
            strHistor := 'REF. ESTORNO ADIANTAMENTO PEDIDO: '+  strNumPed+'-'+strEspPed;

            Result :=  TAdiantamento
                       .fLancarDebitoAdiantamento(strNumPed,
                                                  strEspPed,
                                                  strEmpPed,
                                                  strLoginUsuarioLogado,
                                                  strHistor,
                                                  TAdiantamento.fGetTotaisAdiantamento(strNumPed, strEspPed, strEmpPed).fltValLan,
                                                  StrToInt(fRetRcxCon),
                                                  totAdtCli,
                                                  strCodCli);

            Result := Result And fExcluiMovCar;

            Result := Result And TAdiantamento.fGravaEstornoMovimentoBancario(strNumPed,
                                                                              strEspPed,
                                                                              strEmpPed,
                                                                              strCodCli,
                                                                              strHistor);

          End
          Else
          Begin
            Result := TAdiantamento.fGerarCreditoSaldoAdiantamento(strNumPed,
                                                                   strEspPed,
                                                                   strEmpPed,
                                                                   Self.Name,
                                                                   strLoginUsuarioLogado,
                                                                   False);
          End;
        End;
      End
      Else
      Begin
        {*************************************************************************}
        {* SE O PEDIDO TIVER DUPLICATAS PAGAS, DEVE GERAR CRÉDITO NO MESMO VALOR *}
        {**********************************************************************MM*}
        fltTotCadRec   := fltDupRec * -1;

        //Deve gerar um credito na alteracao de pedido com valor menor que o quitado
        If fCfgSis('GERCRE', varBoolean) And (fltTotCadRec < 0) Then
        Begin
          pInfoStatusGravacao('Aguarde... Apagando Contas a Receber ' + strEspDoc + ' em aberto do Pedido!', pgbStatus);
          pStepStatusGravacao(pgbStatus);

          pDeletaCadRec(strNumPed, strEspPed, strEmpPed, fRetClienteOriginal);

          pInfoStatusGravacao('Aguarde... Gerando Crédito Alteração Pedido!', pgbStatus);
          pStepStatusGravacao(pgbStatus);

          fDigDuplic(arrDuplicata, '01000', 0, fltTotCadRec, False, False, False, VS_Date, False);
          strUltPar := fRetornaUltimaParcela(strNumOrc, 'PD');

          If (Not fEmptyStr(strUltPar)) Then
          Begin
            For intContUltPar := Low(arrDuplicata) To High(arrDuplicata) Do
            Begin
              If (fEmptyStr(ArrDuplicata[intContUltPar].strSequen)) Then
                Break;

              strUltPar := Chr(Ord(strUltPar[1])+1);
              ArrDuplicata[intContUltPar].strSequen := strUltPar;
            End;
          End;

          If ((Pos(strClaFis, VS_strClaVen) > 0) Or (blnBaiPed)) And
             (Not blnBaiEntFut)                                  And
             (IIF(blnCliFil, blnGravaCtrTe, True))               Then
          Begin
            pInfoStatusGravacao('Aguarde... Gravando Contas a Receber', pgbStatus);
            pStepStatusGravacao(pgbStatus);

            strProdutosAlterados := AnsiReplaceStr(fGetProdutosAlterados(False), #13, STRING_QUEBRA);

            Result := fGCadRec;
          End;

        End;

      End;

    End;

    If Result Then
    Begin
      pStepStatusGravacao(pgbStatus);

      pBaixaPedido(edtNumDoc.Text,
                   edtEspDoc.Text,
                   edtCodEmp.Text,
                   strCodOco,
                   strHisBai, '', '', '', blnBaixaF10PnlDadosPedOrc);

      pStepStatusGravacao(pgbStatus);

      fCommit;
    End
    Else
      fRollback;

    pStepStatusGravacao(pgbStatus);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[Baixar Pedidos]');
    End;
  End;
end;

function TfrmFatAltQtdeItensPedido.fBuscaQtdExpAtual(strAutInc: String): Double;
begin
  Result := fCampoTabela('FDO_QTDEXP', 'EXTDOR', ['FDO_SEQFDO'], [strAutInc]);
end;

function TfrmFatAltQtdeItensPedido.fBuscaQtdSepAtual(strAutInc: String): Double;
begin
  Result := fCampoTabela('FDO_QTDSEP', 'EXTDOR', ['FDO_SEQFDO'], [strAutInc]);
end;

procedure TfrmFatAltQtdeItensPedido.pInfoStatusGravacao(strInformacao: String;
  pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
end;

function TfrmFatAltQtdeItensPedido.fCarregarPedido: Boolean;
begin
  objAltCnd.strNumPed := edtNumDoc.Text;
  objAltCnd.strEmpPed := edtCodEmp.Text;

  objAltCnd.blnBaixaPedidoNaoEntregue := blnBaixaPedidoNaoEntregue;

  strUltimoPedido := edtNumDoc.Text;

  Result := objAltCnd.fCarregarPedido;

  If Result Then
    pAtualizaDadosPedido;
end;

class function TfrmFatAltQtdeItensPedido.pBaixarPedidoNaoEntregue(strNumPed, strEspPed, strEmpPed, strCliPed: String;
  blnF10PnlDadosPedOrc: Boolean = False; blnVendaPerdida: Boolean = False; strCodOco: String = ''; strHisBai: String = '';
  blnMostrarMensagem: Boolean = True; blnTrocaCliente: Boolean = False; strCodCliNov: String = '';
  blnEstValorAdt: Boolean = False; FncLimparSeparacao : TFunctionLimparSeparacao = Nil;
  strAutIncGor: String = ''; blnApagarExtLar: Boolean = False; strCodComplementoOcorrencia : String = '';
  strNomeForm: String = ''): Boolean;

  function fRetNumeroOS(strNumero, strEmpresa, strCodCli: string): string;
    var
      qryAux: TUniQuery;
      strSQL: string;
  begin
    strSQL := '';
    strSQL := strSQL + ' SELECT EQU_NUMOSE ';
    strSQL := strSQL + ' FROM EQUGER ';
    strSQL := strSQL + ' WHERE (EQU_TIPPED = "PD" ';
    strSQL := strSQL + '    AND EQU_NUMPED = :NUMPED ';
    strSQL := strSQL + '    AND EQU_EMPPED = :CODEMP ';
    strSQL := strSQL + '    AND EQU_CODCLI = :CODCLI) ';
    strSQL := strSQL + ' UNION ';
    strSQL := strSQL + ' SELECT EQU_NUMOSE ';
    strSQL := strSQL + ' FROM EQUGER ';
    strSQL := strSQL + ' INNER JOIN EQUGOR ON EQUGER.AUTOINCREM = EQUGOR.FGO_SEQEQU ';
    strSQL := strSQL + ' INNER JOIN FATGOR ON EQUGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
    strSQL := strSQL + ' WHERE (FGO_NUMDOC = :NUMPED  ';
    strSQL := strSQL + '    AND FGO_CODEMP = :CODEMP  ';
    strSQL := strSQL + '    AND FGO_CODCLI = :CODCLI) ';

    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Text := strSQL;
        ParamByName('NUMPED').AsString := strNumero;
        ParamByName('CODEMP').AsString := strEmpresa;
        ParamByName('CODCLI').AsString := strCodCli;
        Open;

        Result := FieldByName('EQU_NUMOSE').AsString;
      end;
    finally
      qryAux.Free;
    end;
  end;

  Var
    frmFatAltQtde: TfrmFatAltQtdeItensPedido;
    objConEqu: TConEqu;
    objParametrosMensagem: TParametrosMensagem;
    strRetornoErro: string;
    strCadRec: String;
begin
  Result := False;
  if not TValidaOrigemFaturamento.DocumentoPermiteCancelamento(strNumPed, strEspPed, strEmpPed) then
    Exit;

  if not TYapayFacade.fPedidoPodeSerCancelado(strNumPed, strEspPed, strEmpPed, strRetornoErro) then
  begin
    objParametrosMensagem := TParametrosMensagem.Create;
    try
      objParametrosMensagem.Titulo := 'Yapay';
      objParametrosMensagem.Texto := strRetornoErro;
      objParametrosMensagem.Opcoes := ['&OK'];
      objParametrosMensagem.Url.Caption := 'Visualizar cobrança';
      objParametrosMensagem.Url.Href :=
        TYapayFacade.fLinkPagamento(TYapayFacade.fGetAutIncFatGor(strNumPed, strEspPed, strEmpPed));
      objParametrosMensagem.HeightOpc := 280;
      fMensagem(objParametrosMensagem);
    finally
      objParametrosMensagem.Free;
    end;
    Exit;
  end;

  If (Not blnVendaPerdida) And
     (Not blnTrocaCliente) And
     (Not fLock_Unlock('FATGOR' + strNumPed + strEspPed + strEmpPed, True, False)) Then
  Begin
    fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                  fGetHostLock('FATGOR' + strNumPed + strEspPed + strEmpPed)  + '!', ['&Ok']);
    Exit;
  End;

  Try
    If (TAdiantamento.fGetTotaisAdiantamento(strNumPed,
                                             strEspPed,
                                             strEmpPed).fltValLan = 0.00)
       And
       (
         (TFatVenda.fTotalDuplicataQuitada(strNumPed,
                                           strEspPed,
                                           strEmpPed) = 0.00) Or (Not fCfgSis('GERCRE', varBoolean))
       ) Then
    Begin

      Try
        if fEmptyStr(strCodOco) then
          strCodOco := TfrmFatAltQtdeItensPedido.fGetOcorrencia(strHisBai, True);

        If Not fEmptyStr(strCodOco) Then
        Begin
          Try
            fStartTransaction;

            if (fCfgSis('CONEQU', VarBoolean)) And
               (fCfgSis('GER_OS', VarBoolean)) Then
            begin
              objConEqu := TConEqu.Create(nil);
              try
                objConEqu.strNumero := fRetNumeroOS(strNumPed,
                                                    strEmpPed,
                                                    strCliPed);
                objConEqu.strCodEmp := strEmpPed;
                objConEqu.fCancelaOrdServico('');
              finally
                objConEqu.Free;
              end;
            end;

            If fCfgSis('CUPDES') = 'S' Then
              If Not fDocParcialmenteFat(strNumPed, strEspPed, strEmpPed) Then
                TFatCupomDesconto.DesmarcarCupomUtilizado(strNumPed, strEspPed, strEmpPed);

            If (Not fGerarPedidoReservaEstoqueParaEnderecamentoProdutosSeparados(strNumPed, strEspPed, strEmpPed, True)) Then
            Begin
              fRollback;
              fMensagem('', 'Problemas ao gerar o pedido de reserva de estoque para endereçamento!', ['&Ok']);
              Exit;
            End;

            strCadRec := fRetornaSeqCadRecPedidoDeVendaABaseDeTroca(strNumPed, strEmpPed, strCliPed);

            If (Not fEmptyStr(strCadRec)) And (Not fDeletaCadRec(strCadRec, strNomeForm)) Then
            Begin
              fRollback;
              fMensagem('', Format('Problemas ao deletar contas a receber do pedido "%s"!', [strNumPed]), ['&OK']);
              Exit;
            End;

            If Assigned(FncLimparSeparacao) Then
            Begin
              If Not FncLimparSeparacao(strAutIncGor, blnApagarExtLar) Then
              Begin
                fRollback;
                fMensagem('', Format('Problemas ao limpar a separação do pedido "%s"!', [strNumPed]), ['&OK']);
                Exit;
              End;
            End;

            If (strHisBai <> '') Then
              pBaixaPedido(strNumPed, strEspPed, strEmpPed, strCodOco, strHisBai, '', '', '', blnF10PnlDadosPedOrc, False, '', strCodComplementoOcorrencia)
            Else
              pBaixaPedido(strNumPed, strEspPed, strEmpPed, strCodOco, '', '', '', '', blnF10PnlDadosPedOrc, False, '', strCodComplementoOcorrencia);

            If blnF10PnlDadosPedOrc Then
              pBaixarFormulacaoPedidosNaoSeraoEntregues(strNumPed, strEspPed, strEmpPed);

            pExcluiPENREC(strNumPed, strEmpPed, strEspPed, strCliPed);

            fCommit;

          Except
            fRollback;
            Raise;
          End;

          fDisparaWhatsappAutomatico(strNumPed,
                                     strEspPed,
                                     strEspPed,
                                     '',
                                     'BX',
                                     '',
                                     strCliPed,
                                     '',
                                     True,
                                     '',
                                     TGeraArquivoAnexoEmailAutomatico.New(strNumPed,
                                                                          strEspPed,
                                                                          strEmpPed,
                                                                          strCliPed),
                                     '',
                                     '',
                                     '',
                                     Self.UnitName);

          fDisparaEmailAutomatico(strNumPed,
                                  strEspPed,
                                  strEspPed,
                                  '',
                                  'BX',
                                  '',
                                  strCliPed,
                                  '',
                                  '',
                                  TGeraArquivoAnexoEmailAutomatico.New(strNumPed,
                                                                       strEspPed,
                                                                       strEmpPed,
                                                                       strCliPed));

          fDisparaSMSAutomatico(strNumPed, strEspPed, strEspPed, '', 'BX', '', strCliPed);

          {Envia Mensagem}
          if (blnF10PnlDadosPedOrc) then
            pMensagemPedidoBaixado(strNumPed, strEspPed, strEmpPed, strCodOco, strHisBai);

          Result := True;
          if blnMostrarMensagem then
          begin
            If (strEspPed = 'PD') Then
              fMensagem('', 'Pedido baixado com sucesso!', ['&Ok'])
            Else
              fMensagem('', 'Orçamento baixado com sucesso!', ['&Ok']);
          end;
        End;

      Except
        On E: Exception Do
          pMensagensErro(e.Message, '[pBaixarPedidoNaoEntregue]');
      End;

      Exit;
    End;

    Try
      pCriarFormularios(TfrmFatAltQtdeItensPedido, frmFatAltQtde);
      frmFatAltQtde.edtNumDoc.Text := strNumPed;
      frmFatAltQtde.edtEspDoc.Text := strEspPed;
      frmFatAltQtde.edtCodEmp.Text := strEmpPed;
      frmFatAltQtde.edtDesEmp.Text := fRetNomeEmpresa(strEmpPed);
      frmFatAltQtde.blnExpedicao   := False;
      frmFatAltQtde.blnBaiPed      := True;
      frmFatAltQtde.strNumRom      := fDocumentoEmRomaneio(strNumPed, strEspPed);
      frmFatAltQtde.strCodOco      := strCodOco;
      frmFatAltQtde.strHisBai      := strHisBai;
      frmFatAltQtde.blnShowMensagemSucesso := False;
      frmFatAltQtde.blnCarregaQtdSepOriginal := True;
      frmFatAltQtde.blnTrocaCliente := blnTrocaCliente;
      frmFatAltQtde.strCodCliNov    := strCodCliNov;
      frmFatAltQtde.blnEstornarValorAdt := blnEstValorAdt;
      frmFatAltQtde.blnBaixaF10PnlDadosPedOrc := blnF10PnlDadosPedOrc;
      frmFatAltQtde.blnBaixaPedidoNaoEntregue := True;

      If frmFatAltQtde.fCarregarPedido Then
      Begin
        frmFatAltQtde.pLimparItens;//Remove os itens do pedido indicando que o mesmos nao serao entregues
        Result := frmFatAltQtde.fConfirma;//Confirma a baixa do pedido como nao entregue gerando credito cliente
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    If (Not blnVendaPerdida) Then
      fLock_Unlock('FATGOR' + strNumPed + strEspPed + strEmpPed, False, False);

    pFreeAndNil(frmFatAltQtde);
  End;
end;

procedure TfrmFatAltQtdeItensPedido.pBeforeDelete(DataSet: TDataSet);
begin
  pSetFocus(dbgItens);

  With DataSet Do
  Begin
    If (blnCarregaQtdSepOriginal) And (fFormataFloat(FieldByName('ITE_QTDEXP').AsFloat, 2) <> fFormataFloat(fBuscaQtdExpAtual(FieldByName('ITE_SEQDET').AsString), 2)) Then
    Begin
      cdsDados.FieldByName('ITE_QTDITE').FocusControl;
      fMensagem('ATENÇÃO!', 'Esse item teve quantidade EXPEDIDA alterada pelo coletor!'+#10#13+
                            'Recarregue esse documento para realizar as devidas alterações.', ['&Ok']);
      Cancel;
      Abort;
    End

    Else If (blnCarregaQtdSepOriginal) And (fFormataFloat(FieldByName('ITE_QTDSEP').AsFloat, 2) <> fFormataFloat(fBuscaQtdSepAtual(FieldByName('ITE_SEQDET').AsString), 2)) Then
    Begin
      cdsDados.FieldByName('ITE_QTDITE').FocusControl;
      fMensagem('ATENÇÃO!', 'Esse item teve quantidade SEPARADA alterada pelo coletor!'+#10#13+
                            'Recarregue esse documento para realizar as devidas alterações.', ['&Ok']);
      Cancel;
      Abort;
    End;
  End;
end;

procedure TfrmFatAltQtdeItensPedido.pBeforePost(DataSet: TDataSet);
begin
  pSetFocus(dbgItens);

  With DataSet Do
  Begin
    If (blnCarregaQtdSepOriginal) And (fFormataFloat(FieldByName('ITE_QTDEXP').AsFloat, 2) <> fFormataFloat(fBuscaQtdExpAtual(FieldByName('ITE_SEQDET').AsString), 2)) Then
    Begin
      cdsDados.FieldByName('ITE_QTDITE').FocusControl;
      fMensagem('ATENÇÃO!', 'Esse item teve quantidade EXPEDIDA alterada pelo coletor!'+#10#13+
                            'Recarregue esse documento para realizar as devidas alterações.', ['&Ok']);
      Cancel;
      Abort;
    End

    Else If (blnCarregaQtdSepOriginal) And (fFormataFloat(FieldByName('ITE_QTDSEP').AsFloat, 2) <> fFormataFloat(fBuscaQtdSepAtual(FieldByName('ITE_SEQDET').AsString), 2)) Then
    Begin
      cdsDados.FieldByName('ITE_QTDITE').FocusControl;
      fMensagem('ATENÇÃO!', 'Esse item teve quantidade SEPARADA alterada pelo coletor!'+#10#13+
                            'Recarregue esse documento para realizar as devidas alterações.', ['&Ok']);
      Cancel;
      Abort;
    End

    Else If (FieldByName('ITE_QTDITE').AsFloat > FieldByName('ITE_QTDITE').OldValue) Then
    Begin
      cdsDados.FieldByName('ITE_QTDITE').FocusControl;
      fMensagem('ATENÇÃO!', 'Não é possível aumentar a quantidade do produto!', ['&Ok']);
      Cancel;
      Abort;
    End

    Else If (fItemNaoFracionavel(edtEspDoc.Text, FieldByName('ITE_CODUNI').AsString)) And
            (Not fCfgSis('VENVID', varBoolean)) And //venda vidro
            (Not fCfgSis('VENMAD', varBoolean)) And //venda medeireira
            (Frac(fStrToFloat(FieldByName('ITE_QTDITE').AsString)) <> 0)              Then
    Begin
      cdsDados.FieldByName('ITE_QTDITE').FocusControl;
      fMensagem('ATENÇÃO!', 'Não é possível informar valor fracionado para este produto!', ['&Ok']);
      Cancel;
      Abort;
    End

    Else If (FieldByName('ITE_QTDITE').AsFloat <= 0.00) Then
    Begin
      cdsDados.FieldByName('ITE_QTDITE').FocusControl;
      fMensagem('ATENÇÃO!', 'Não é possível zerar a quantidade do produto.' + #13 +
                            'Se quiser removê-lo, pressione [DELETE]!', ['&Ok']);
      Cancel;
      Abort;
    End

    Else If (FieldByName('ITE_QTDEXP').AsFloat > FieldByName('ITE_QTDITE').AsFloat) Then
    Begin
      cdsDados.FieldByName('ITE_QTDITE').FocusControl;
      fMensagem('ATENÇÃO!', 'A quantidade do produto não pode ser inferior a ' + FormatFloat('#,##0.00',FieldByName('ITE_QTDEXP').AsFloat) + ', ' + #13 +
                            'pois essa quantidade já foi expedida!', ['&Ok']);
      Cancel;
      Abort;
    End

    Else
    begin
      FieldByName('ITE_TOTITE').AsFloat := FieldByName('ITE_QTDITE').AsFloat *
                                           FieldByName('ITE_UNITAR').AsFloat;

      cdsDados.Edit;
      cdsDados.FieldByName('ITE_SALDIS').AsFloat :=
        fRetornaSaldoDisponivel(cdsDados.FieldByName('ITE_CODITE').AsString)
        + (cdsDados.FieldByName('ITE_QTDITE').AsFloat - cdsDados.FieldByName('ITE_QTDEXP').AsFloat);
    end;
  End;
end;

procedure TfrmFatAltQtdeItensPedido.pCriaClientDesEsp;
begin
  cdsDesEsp := TUniClientDataSet.Create(Self);

  With cdsDesEsp.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_SEQDET';
    DataType := ftString;
    Size := 20;
  End;

  With cdsDesEsp.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESESP';
    DataType := ftFloat;
  End;

  cdsDesEsp.CreateDataSet;
  cdsDesEsp.IndexFieldNames := 'ITE_SEQDET';
end;

procedure TfrmFatAltQtdeItensPedido.pLimpaTela;
  Const
    TAG_NAO_LIMPAR = 1;
    TAG_VALORES = 2;
  Var
    intIdx: Integer;
begin
  For intIdx := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[intIdx].Tag <> TAG_NAO_LIMPAR Then
    Begin
      If Self.Components[intIdx] Is TEditFocus Then
        If Self.Components[intIdx].Tag = TAG_VALORES Then
          (Self.Components[intIdx] As TEditFocus).Text := '0,00'
        Else
          (Self.Components[intIdx] As TEditFocus).Clear;

      If Self.Components[intIdx] Is TMaskEditFocus Then
        (Self.Components[intIdx] As TMaskEditFocus).Clear;
    End;
  End;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  edtEspDoc.Text := 'PD';

  strCcnAnt := '';
  strCndAnt := '';
  strFpgAnt := '';
  strFpgLib := '';

  btnConfirma.Enabled   := False;
  pnlItens.Enabled      := False;
  pnlBusca.Enabled      := True;

  pSetFocus(edtNumDoc);
  pLimparItens;
end;

class procedure TfrmFatAltQtdeItensPedido.pMensagemPedidoBaixado(strNumDoc, strEspDoc, strCodEmp, strCodOco : String; strHisBai: String = '');
Var
  msgMensagem : TMsgInterna;
  qryCadOpe,
  qryFatGor   : TUniQuery;
  stlMensagem : TStringList;
Begin

  if strEspDoc <> 'PD' then
    Exit;

  try

    qryCadOpe := fCriaQuery;
    qryFatGor := fCriaQuery;

    qryCadOpe.Close;
    qryCadOpe.SQL.Clear;
    qryCadOpe.SQL.Add('SELECT');
    qryCadOpe.SQL.Add('  OPE_CODOPE AS CODOPE');
    qryCadOpe.SQL.Add('FROM');
    qryCadOpe.SQL.Add('  CADOPE');
    qryCadOpe.SQL.Add('WHERE');

    {Somente para operadores que tenham direitos de acesso a empresa}
    qryCadOpe.SQL.Add('  LOCATE(:CODEMP, OPE_EMPACE) > 0 AND ');
    qryCadOpe.SQL.Add('  OPE_MSGPCA = "S"');

    qryCadOpe.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadOpe.Open;

    if not qryCadOpe.IsEmpty Then
    begin

      {Busca informações do pedido}
      qryFatGor.Close;
      qryFatGor.SQL.Clear;
      qryFatGor.SQL.Add('SELECT');
      qryFatGor.SQL.Add('  FATGOR.FGO_CODCLI,');
      qryFatGor.SQL.Add('  CADCLI.CLI_NOMCLI,');
      qryFatGor.SQL.Add('  FATGOR.FGO_CODVEN,');
      qryFatGor.SQL.Add('  CADOPE.OPE_NOMOPE,');
      qryFatGor.SQL.Add('  FATGOR.FGO_NUMDOC,');
      qryFatGor.SQL.Add('  FATGOR.FGO_DTAENT,');
      qryFatGor.SQL.Add('  FATGOR.FGO_CONPAG,');
      qryFatGor.SQL.Add('  FATGOR.FGO_CODCND,');
      qryFatGor.SQL.Add('  FATGOR.FGO_CODFPG,');
      qryFatGor.SQL.Add('  FATGOR.FGO_VLRCON');
      qryFatGor.SQL.Add('FROM');
      qryFatGor.SQL.Add('  FATGOR');
      qryFatGor.SQL.Add('  INNER JOIN CADCLI ON (CADCLI.CLI_CODCLI = FATGOR.FGO_CODCLI)');
      qryFatGor.SQL.Add('  INNER JOIN CADOPE ON (CADOPE.OPE_CODOPE = FATGOR.FGO_CODVEN)');
      qryFatGor.SQL.Add('WHERE');
      qryFatGor.SQL.Add('  FATGOR.FGO_NUMDOC = :NUMDOC AND');
      qryFatGor.SQL.Add('  FATGOR.FGO_ESPDOC = :ESPDOC AND');
      qryFatGor.SQL.Add('  FATGOR.FGO_CODEMP = :CODEMP');

      qryFatGor.ParamByName('NUMDOC').AsString := strNumDoc;
      qryFatGor.ParamByName('ESPDOC').AsString := strEspDoc;
      qryFatGor.ParamByName('CODEMP').AsString := strCodEmp;
      qryFatGor.Open;

      if not qryFatGor.IsEmpty then
      begin

        msgMensagem := TMsgInterna.Create(nil);
        stlMensagem := TStringList.Create;
        stlMensagem.Clear;

        stlMensagem.Add('BAIXADO: ' + DateToStr(untFuncoesSimples.VS_Date));

        if (strCodOco <> '') then
          stlMensagem.Add('MOTIVO: ' + fRetDescOcorrencia(strCodOco));

        if (not fEmptyStr(strHisBai)) then
          stlMensagem.Add('HISTÓRICO COMPLEMENTAR: ' + strHisBai);

        stlMensagem.Add('DOCUMENTO: ' + strNumDoc + '-' + strEspDoc + '-' + strCodEmp);
        stlMensagem.Add('CLIENTE: ' + qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' + qryFatGor.FieldByName('CLI_NOMCLI').AsString);

        if fCfgSis('USACND', varBoolean) then
        begin
          stlMensagem.Add('CONDIÇÃO DE PAGAMENTO: ' + qryFatGor.FieldByName('FGO_CODCND').AsString + '-' + fRetDesConPag(qryFatGor.FieldByName('FGO_CODCND').AsString));
          stlMensagem.Add('                       (' + qryFatGor.FieldByName('FGO_CODCND').AsString + ')' + fFormataCondPag(qryFatGor.FieldByName('FGO_CONPAG').AsString));
        end
        else
        begin
          stlMensagem.Add('CONDIÇÃO DE PAGAMENTO: (' + qryFatGor.FieldByName('FGO_CODCND').AsString + ')' + fFormataCondPag(qryFatGor.FieldByName('FGO_CONPAG').AsString));
        end;

        stlMensagem.Add('VENDEDOR: ' + qryFatGor.FieldByName('FGO_CODVEN').AsString + '-' + qryFatGor.FieldByName('OPE_NOMOPE').AsString);
        stlMensagem.Add('TOTAL DO DOCUMENTO: ' + FormatFloat('###,#0.00', qryFatGor.FieldByName('FGO_VLRCON').AsFloat));

        qryCadOpe.First;
        While Not qryCadOpe.Eof Do
        Begin
          msgMensagem.fEnviaMensagem('PEDIDO BAIXADO: ' + strNumDoc,
                                     stlMensagem.Text,
                                     qryFatGor.FieldByName('FGO_CODVEN').AsString,
                                     qryCadOpe.FieldByName('CODOPE').AsString,
                                     'N',
                                     '');
          qryCadOpe.Next;
        End;

        FreeAndNil(msgMensagem);
        FreeAndNil(stlMensagem);

      end;

    end;

  finally
    FreeAndNil(qryCadOpe);
    FreeAndNil(qryFatGor);
  end;

End;

procedure TfrmFatAltQtdeItensPedido.pProcessaClientDesEsp;
begin
  cdsDesEsp.EmptyDataSet;

  cdsVenda.First;
  While Not cdsVenda.Eof Do
  Begin

    If Not cdsDesEsp.FindKey([ cdsVenda.FieldByName('ITE_SEQDET').AsString ]) Then
    Begin
      cdsDesEsp.Append;
      cdsDesEsp.FieldByName('ITE_SEQDET').AsString := cdsVenda.FieldByName('ITE_SEQDET').AsString;
      cdsDesEsp.FieldByName('ITE_DESESP').AsFloat := fCampoTabela('FDO_DESESP', 'FATDOR', ['AUTOINCREM'], [cdsVenda.FieldByName('ITE_SEQDET').AsString]);
      cdsDesEsp.Post;
    End;

    cdsVenda.Next;
  End;
end;

procedure TfrmFatAltQtdeItensPedido.pProcessarSalDis;
begin
  cdsDados.DisableControls;

  Try
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('ITE_SALDIS').AsFloat :=
        fRetornaSaldoDisponivel(cdsDados.FieldByName('ITE_CODITE').AsString)
        + (cdsDados.FieldByName('ITE_QTDITE').AsFloat - cdsDados.FieldByName('ITE_QTDEXP').AsFloat);
      cdsDados.Post;

      cdsDados.Next;
    End;
  Finally
    cdsDados.EnableControls;
  End;
end;

procedure TfrmFatAltQtdeItensPedido.pLimparItens;
begin
  cdsDados.EmptyDataSet;
end;

procedure TfrmFatAltQtdeItensPedido.pStepStatusGravacao(
  pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) Then
  Begin
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;
end;

function TfrmFatAltQtdeItensPedido.fPedidoEntFut: Boolean;
  Var
    qryAux   : TUniQuery;
Begin
  qryAux := fCriaQuery(Self);

  With qryAux, SQL Do
  Begin
    Clear;
    Add('SELECT ');
    Add('  GROUP_CONCAT(IFNULL(FDO_INCFUT,"")) AS INCFUT ');
    Add('FROM ');
    Add('  FATDOR F INNER JOIN EXTDOR E ON F.AUTOINCREM = E.FDO_SEQFDO ');
    Add('WHERE FDO_NUMDOC = :NUMDOC ');
    Add('  AND FDO_ESPDOC = :ESPDOC ');
    Add('  AND FDO_CODEMP = :CODEMP ');
    Add('  AND FDO_CODCLI = :CODCLI ');
    ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    ParamByName('CODEMP').AsString := edtCodEmp.Text;
    ParamByName('CODCLI').AsString := edtCodCli.Text;
    Open;

    Result := Not fEmptyStr(AnsiReplaceStr(FieldByName('INCFUT').AsString,',',''));
  End;

  FreeAndNil(qryAux);
end;

function TfrmFatAltQtdeItensPedido.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    blnJaFatu,
    blnJaBaix,
    blnImpresso,
    blnSepImpresso: Boolean;
    strCodRom: String;
    strCodVen: String;

    Function fDocEmRomaneio: Boolean;
    Begin
      strCodRom := '';
      If (Not fEmptyStr(edtNumDoc.Text)) Then
      Begin
        strCodRom := fDocumentoEmRomaneio(edtNumDoc.Text, edtEspDoc.Text);
      End;
      Result := Not fEmptyStr(strCodRom);
    End;

begin

  Result    := True;
  blnJaFatu := False;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin

      If InterlockedIncrement(intSemaforoValidar) = 0 Then
      Begin

        Try

          If (Pos(edtEspDoc.Text, 'OR_PD_') <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Espécie deve ser OR ou PD!', ['&O k']);
            Result := False;
          End
          Else If (Not fDocumentoFatExiste(objAltCnd.qryFatGor, edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, blnJaFatu, blnJaBaix, blnImpresso, strCodVen, blnSepImpresso)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse documento não está cadastrado!', ['&O k']);
            Result := False;
          End

          Else If (blnJaFatu) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse documento já foi faturado!', ['&O k']);
            Result := False;
          End

          Else If (Not fEmptyStr(edtNumDoc.Text)) And (edtEspDoc.Text = 'OR') And (Not fVerificaAcessoSistema('VERORC')) And (strCodVen <> strLoginUsuarioLogado) And (Not fEmptyStr(strCodVen)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Acesso ao documento não permitido!', ['&O k']);
            Result := False;
          End

          Else If (Not fEmptyStr(edtNumDoc.Text)) And (edtEspDoc.Text = 'PD') And (Not fVerificaAcessoSistema('VERPED')) And (strCodVen <> strLoginUsuarioLogado) And (Not fEmptyStr(strCodVen)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Acesso ao documento não permitido!', ['&O k']);
            Result := False;
          End

          Else If fDocEmRomaneio And (Not fCfgSis('USPRRO', varBoolean)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse pedido está associado ao(s) Romaneio(s): ' + strCodRom + '.' + #13#10 +
                                  'Remova esse pedido do(s) romaneio(s) para poder alterá-lo!', ['&Ok']);
            Result := False;
            objAltCnd.qryFatGor.Close;
          End

          {**********************************************}
          {* CASO NAO PERMITA ALTERAR PEDIDOS IMPRESSOS *}
          {*******************************************JC*}
          Else If (Not fCfgSis('ALTPDI', varBoolean)) And (blnImpresso) And
                  (Not fEmptyStr(edtNumDoc.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse pedido já foi impresso portanto não é possível alterá-lo!', ['&Ok']);

            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('Esse pedido já foi impresso portanto não é possível alterá-lo!');

            objLiberacao.objMsgLibera.pAddTextoCaption('Pedido'  , objAltCnd.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                                   objAltCnd.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                                                                   objAltCnd.qryFatGor.FieldByName('FGO_CODEMP').AsString                 , 7);

            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente' , objAltCnd.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                                                                   fRetNomCliente(objAltCnd.qryFatGor.FieldByName('FGO_CODCLI').AsString) , 7);


            objLiberacao.strDirAce := 'ALTPDI';
            objLiberacao.strCodOpe := strLoginUsuarioLogado;
            objLiberacao.blnSempreVariavelUsuario := True;

            If objLiberacao.fLibera Then
            Begin
              Result := True;
            End
            Else
            Begin
              Result := False;
            End;
          End

          {***********************************************************}
          {* CASO NAO PERMITA ALTERAR PEDIDOS COM SEPARAÇÃO IMPRESSA *}
          {********************************************************MM*}
          Else If (blnSepImpresso) And (Not fEmptyStr(edtNumDoc.Text)) Then
          Begin
            If fImpressaoParcialConsiderandoJaImpresso Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é possível alterar esse pedido, pois a separação já foi impressa!', ['&Ok']);
              Result := False;
            End
            Else If (fCfgSis('ALTPDS') = 'N') Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é possível alterar esse pedido, pois a separação já foi impressa!', ['&Ok']);

              objLiberacao.Clear;
              objLiberacao.objMsgLibera.pAddTexto('Não é possível alterar esse pedido, pois a separação já foi impressa!');

              objLiberacao.objMsgLibera.pAddTextoCaption('Pedido'  , objAltCnd.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                                     objAltCnd.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                                                                     objAltCnd.qryFatGor.FieldByName('FGO_CODEMP').AsString                 , 7);

              objLiberacao.objMsgLibera.pAddTextoCaption('Cliente' , objAltCnd.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                                                                     fRetNomCliente(objAltCnd.qryFatGor.FieldByName('FGO_CODCLI').AsString) , 7);


              objLiberacao.strDirAce := 'ALTPDS';
              objLiberacao.strCodOpe := strLoginUsuarioLogado;
              objLiberacao.blnSempreVariavelUsuario := True;

              Result := objLiberacao.fLibera;
            End
            Else If (fCfgSis('ALTPDS') = 'C') And
                    (objAltCnd.qryFatGor.FieldByName('FGO_ENT_CD').AsString = 'S') And
                    (objAltCnd.qryFatGor.FieldByName('FGO_ESPDOC').AsString = 'PD') And
                    (objAltCnd.qryFatGor.FieldByName('FGO_EMP_CD').AsString <> VS_strCodEmp) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é possível alterar, pois este pedido é entrega '
                                  + 'pelo CD e a separação já foi impressa. '
                                  + 'Somente será possível realizar alteração após limpar separação. '
                                  + 'Entre em contato com o responsável pelo CD.', ['&Ok']);
              Result := False;
            End;
          End

          {***********************************************************}
          {* CASO NAO PERMITA ALTERAR PEDIDOS COM ORDEM DE PRODUÇÃO  *}
          {* DE PRODUTOS TINTOMÉTRICOS IMPRESSA                      *}
          {********************************************************MM*}
          Else If (Not fEmptyStr(edtNumDoc.Text)) And
                  (VS_strUsaTmq = 'S')  And
                  (Not fCfgSis('ALTPDT', varBoolean)) And
                  (fTemProdutoTintometrico(objAltCnd.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                           objAltCnd.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                           objAltCnd.qryFatGor.FieldByName('FGO_CODCLI').AsString,
                                           objAltCnd.qryFatGor.FieldByName('FGO_CODEMP').AsString)) And
                  (fTemOrdemProducaoTintaImpresso(objAltCnd.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                                  objAltCnd.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                                  objAltCnd.qryFatGor.FieldByName('FGO_CODCLI').AsString,
                                                  objAltCnd.qryFatGor.FieldByName('FGO_CODEMP').AsString)) Then
          Begin
            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('Não é possível alterar esse pedido, pois a ordem de produção de produtos tintométricos já foi impressa!');

            objLiberacao.objMsgLibera.pAddTextoCaption('Pedido'  , objAltCnd.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                                   objAltCnd.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                                                                   objAltCnd.qryFatGor.FieldByName('FGO_CODEMP').AsString                 , 7);

            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente' , objAltCnd.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                                                                   fRetNomCliente(objAltCnd.qryFatGor.FieldByName('FGO_CODCLI').AsString) , 7);


            objLiberacao.strDirAce := 'ALTPDT';
            objLiberacao.strCodOpe := strLoginUsuarioLogado;
            objLiberacao.blnSempreVariavelUsuario := True;

            If objLiberacao.fLibera Then
            Begin
              Result := True;
            End
            Else
            Begin
              Result := False;
            End;
          End;

          If Result And
             SameText(edtEspDoc.Text, 'PD')                                   And
             ( Not fEmptyStr( edtNumDoc.Text ) )                              And
             (TAdiantamentoGenerico.fRetornaValorBoletosAdiantamentoJaEnviados(
                                objAltCnd.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                objAltCnd.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                objAltCnd.qryFatGor.FieldByName('FGO_CODEMP').AsString,
                                objAltCnd.qryFatGor.FieldByName('FGO_CODCLI').AsString) > 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Não é permitido alterar um pedido com boleto(s) '+
              'de adiantamento já enviado(s) para o banco!', ['&Ok']);
            Result := False;
            objAltCnd.qryFatGor.Close;
          End;

          If Result And
             SameText(edtEspDoc.Text, 'PD')                                   And
             ( Not fEmptyStr( edtNumDoc.Text ) )                              And
             (TAdiantamentoGenerico.fRetornaValorBoletosAdiantamentoJaImpressos(
                                objAltCnd.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                objAltCnd.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                objAltCnd.qryFatGor.FieldByName('FGO_CODEMP').AsString,
                                objAltCnd.qryFatGor.FieldByName('FGO_CODCLI').AsString) > 0) Then
          Begin
            objLiberacao.Clear;

            objLiberacao.objMsgLibera.pAddTexto('Permitir alterar pedido com boleto de adiantamento já impresso');
            objLiberacao.objMsgLibera.pAddQuebra;
            objLiberacao.objMsgLibera.pAddTexto('O pedido de venda ' + objAltCnd.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                'PD' + '-' + objAltCnd.qryFatGor.FieldByName('FGO_CODEMP').AsString);
            objLiberacao.objMsgLibera.pAddTexto('possui boleto de adiantamento já impresso.');


            objLiberacao.strSenFvu := 'V';

            objLiberacao.strDirAce := 'ALTPEDBOLADT';
            objLiberacao.strMsgSen := 'Permitir alterar pedido com boleto de adiantamento já impresso';
            objLiberacao.strCodOpe := strLoginUsuarioLogado;

            If (Not objLiberacao.fLibera) Then
            Begin
              Result := False;
            End;
          End;

          If Result Then
          Begin
            blnMudarFoco := False;
            Result := fCarregarPedido;
          End;

          InterlockedDecrement(intSemaforoValidar);

        Except
          On E: Exception Do
          Begin
            Result := False;
            InterlockedDecrement(intSemaforoValidar);
            pMensagensErro(E.Message, '');
          End;
        End;

      End
      ELse
        InterlockedDecrement(intSemaforoValidar);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatAltQtdeItensPedido.FormCreate(Sender: TObject);
begin
  inherited;
  blnShowMensagemSucesso := True;

  intSemaforoConsulta := -1;
  intSemaforoValidar  := -1;

  blnCarregaQtdSepOriginal := False;
  blnCarregaBxSepOriginal := False;
  
  stlForPag    := TStringList.Create;
  stlForPag.Sorted := True;
  stlForPag.Duplicates := dupIgnore;

  stlCndPag    := TStringList.Create;
  stlCndPag.Sorted := True;
  stlCndPag.Duplicates := dupIgnore;

  blnExpedicao := True;

  objAltCnd := TAlterarPedido.Create(Self);

  objLiberacao := TLiberacao.Create;

  cdsDados := TUniClientDataSet.Create(Self);
  cdsDados.AfterInsert := pAfterInsert;
  cdsDados.BeforePost  := pBeforePost;
  cdsDados.BeforeDelete:= pBeforeDelete; 
  cdsDados.AfterOpen   := pAfterOpen;

  cdsVendaBkp := TUniClientDataSet.Create(Self);

  pvdDados := TUniDataSetProvider.Create(Self);
  dtsDados := fCriaDataSource(cdsDados);

  dbgItens.DataSource := dtsDados;

  blnTemItensDeletados := False;

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := fTamDocCadRec;

  blnBaiPed := False;

  pCriaClientDesEsp;
  mskCndPagAtu.EditMask := MASK_CONPAG;

  blnBaixaF10PnlDadosPedOrc := False;
end;

procedure TfrmFatAltQtdeItensPedido.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(objAltCnd)   Then FreeAndNil(objAltCnd);
  If Assigned(stlForPag)   Then FreeAndNil(stlForPag);
  If Assigned(stlCndPag)   Then FreeAndNil(stlCndPag);
  If Assigned(dtsDados)    Then FreeAndNil(dtsDados);
  If Assigned(cdsDados)    Then FreeAndNil(cdsDados);
  If Assigned(pvdDados)    Then FreeAndNil(pvdDados);
  If Assigned(cdsVendaBkp) Then FreeAndNil(cdsVendaBkp);
  If Assigned(cdsDesEsp)   Then FreeAndNil(cdsDesEsp);
  if Assigned(objLiberacao) then FreeAndNil(objLiberacao);
end;

procedure TfrmFatAltQtdeItensPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10    : btnConfirma.Click;
    VK_ESCAPE : btnSair.Click;
    VK_DELETE :
      If dbgItens.Focused Then
      Begin
        If (fFormataFloat(cdsDados.FieldByName('ITE_QTDITE').AsFloat, 2) =
            fFormataFloat(cdsDados.FieldByName('ITE_QTDEXP').AsFloat, 2)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este produto não pode ser deletado, pois já foi expedido!', ['&Ok']);
          Exit;
        End
        Else
        Begin
          If (fMensagem('', 'Confirma exclusão do produto?', ['&Sim', '&Não']) = 1) Then
          Begin
            cdsDados.Delete;
            blnTemItensDeletados := True;
          End;
        End;
      End;
  End;
End;

procedure TfrmFatAltQtdeItensPedido.FormShow(Sender: TObject);
begin
  inherited;
  If fValidaCampos(edtNumDoc, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmFatAltQtdeItensPedido.btnConfirmaClick(Sender: TObject);
begin
  fConfirma;
end;

function TfrmFatAltQtdeItensPedido.fConfirma: Boolean;
Var
    strMsgExp,
    strMsgSep: String;
begin
  inherited;
  Result := False;

  If btnConfirma.Enabled Then
  Begin
    {******************************************************************}
    {* SE O CLIENTE ESTIVER VAZIO, SIGNIFICA QUE O USUÁRIO EXCLUIU OS *}
    {* PRODUTOS E, POR ISSO, O PEDIDO SERÁ BAIXADO                    *}
    {***************************************************************MM*}
    If cdsDados.IsEmpty Then
    Begin
      If objAltCnd.fCalculaTotalPedido Then
      Begin
        if fFechaPD then
        begin
          Result := True;
          if blnShowMensagemSucesso then
            pMensagemOk('Pedido baixado com sucesso!');
          pEnviaMsg;
          btnSair.Click;
        end
        else
          Result := False;
      End;
    End
    Else
    Begin
      strMsgExp := '';
      strMsgSep := '';
      If blnCarregaQtdSepOriginal Then
      Begin 
        cdsVenda.First;
        While Not cdsVenda.Eof Do
        Begin
          If (fFormataFloat(cdsVenda.FieldByName('ITE_QTDEXP').AsFloat, 2) <> fFormataFloat(fBuscaQtdExpAtual(cdsVenda.FieldByName('ITE_SEQDET').AsString), 2)) Then
          Begin
            pIncrementaListaStr(cdsVenda.FieldByName('ITE_CODITE').AsString, strMsgExp);
          End;

          If (fFormataFloat(cdsVenda.FieldByName('ITE_QTDSEP').AsFloat, 2) <> fFormataFloat(fBuscaQtdSepAtual(cdsVenda.FieldByName('ITE_SEQDET').AsString), 2)) Then
          Begin
            pIncrementaListaStr(cdsVenda.FieldByName('ITE_CODITE').AsString, strMsgSep);
          End;

          cdsVenda.Next;
        End;
      End;

      If (Not strMsgExp.IsEmpty) Or (Not strMsgSep.IsEmpty) Then
      Begin
        fMensagem('Atenção!', IIF(Not strMsgExp.IsEmpty, 'Os seguintes itens tiveram quantidades EXPEDIDAS alteradas pelo coletor: '+strMsgExp+#10#13, '')+
                              IIF(Not strMsgSep.IsEmpty, 'Os seguintes itens tiveram quantidades SEPARADAS alteradas pelo coletor: '+strMsgSep+#10#13, '')+
                              'Recarregue esse documento para realizar as devidas alterações.', ['&Ok']);
        Exit;
      End;

      pCloneDataSet(cdsVendaBkp, cdsVenda);
      pCloneDataSet(cdsVenda,    cdsDados);

      objAltCnd.objVenda.fltDesEsp := fCalculaDescontoEspecial;
      objAltCnd.objVenda.strProdutosAlterados := AnsiReplaceStr(fGetProdutosAlterados(False), #13, STRING_QUEBRA);
      objAltCnd.objVenda.blnEhTelaAltItensPed := True;

      If objAltCnd.fCalculaTotalPedido And objAltCnd.fGravarPedido Then
      Begin
        pAtualizaItensRomaneio;
        pAtualizaNumRom;
        pMensagemOk('Pedido ' + objAltCnd.strNumPed + '-PD alterado com sucesso!');
        pEnviaMsg;
        Result := True;
        btnSair.Click;
      End
      Else
      Begin
        pMensagemOk('Não foi possível alterar o pedido ' + objAltCnd.strNumPed + '-PD!');
        Result := False;
      End;
    End;
  End;
end;

function TfrmFatAltQtdeItensPedido.fExcluiMovCar: Boolean;
var
  qryMovCar: TUniQuery;
  strNumPok: String;
begin
  Result := True;

  strNumPok := objAltCnd.qryFatGor.FieldByName('FGO_NUMPOK').AsString;

  If fEmptyStr(strNumPok) Then
    Exit;

  qryMovCar := fCriaQuery;
  Try
    qryMovCar.DisableControls;
    Try
      qryMovCar.SQL.Text := ' SELECT SQL_NO_CACHE         ' +
                            '   *                         ' +
                            ' FROM MOVCAR                 ' +
                            ' WHERE                       ' +
                            '   MCA_CODEMP      = :CODEMP ' +
                            '   AND MCA_CODCLI  = :CODCLI ' +
                            '   AND MCA_NUMPOK  = :NUMPOK ';

      qryMovCar.ParamByName('CODCLI').AsString := objAltCnd.qryFatGor.FieldByName('FGO_CODCLI').AsString;
      qryMovCar.ParamByName('NUMPOK').AsString := objAltCnd.qryFatGor.FieldByName('FGO_NUMPOK').AsString;
      qryMovCar.ParamByName('CODEMP').AsString := objAltCnd.qryFatGor.FieldByName('FGO_CODEMP').AsString;
      qryMovCar.Open;
      If Not qryMovCar.IsEmpty Then
      begin
        fVerificaIntegridade(Self.Name, 'MOVCAR', qryMovCar);

        fExecutaSQL( 'DELETE '+
                     ' FROM '+
                     '   MOVCAR '+
                     ' WHERE '+
                     '  MCA_CODEMP      = ' + QuotedStr(qryMovCar.FieldByName('MCA_CODEMP').AsString) +
                     '  AND MCA_CODCLI  = ' + QuotedStr(qryMovCar.FieldByName('MCA_CODCLI').AsString) +
                     '  AND MCA_NUMPOK  = ' + QuotedStr(qryMovCar.FieldByName('MCA_NUMPOK').AsString));

      end;
    Except
      Result := False;
    End;

  Finally
    FreeAndNil(qryMovCar);
  End;
end;

function TfrmFatAltQtdeItensPedido.fCalculaDescontoEspecial: Double;
  Var
    fltQtdOriginal   : Double;
    fltQtdRemovida   : Double;
    fltDesEspOriginal: Double;
    fltDesEspRemovido: Double;
begin
  Result := objAltCnd.qryFatGor.FieldByName('FGO_DESESP').AsFloat;

  With cdsVendaBkp Do
  Begin
    First;
    While Not Eof Do
    Begin
      fltQtdOriginal := FieldByName('ITE_QTDITE').AsFloat;

      If Not cdsDados.Locate('ITE_SEQDET', FieldByName('ITE_SEQDET').AsString, []) Then
        fltQtdRemovida := fltQtdOriginal
      Else
        fltQtdRemovida := fltQtdOriginal - cdsDados.FieldByName('ITE_QTDITE').AsFloat;

      fltDesEspRemovido := 0;
      fltDesEspOriginal := fCampoTabela('FDO_DESESP', 'FATDOR', ['AUTOINCREM'], [FieldByName('ITE_SEQDET').AsString]);

      If (fltQtdRemovida > 0) And (fltQtdOriginal <> 0.00) Then
        fltDesEspRemovido := fFormataFloat((fltDesEspOriginal / fltQtdOriginal) * fltQtdRemovida, 2);

      if objAltCnd.objVenda.blnBaiEntFut and Assigned(objAltCnd.objVenda.dicDesEspItens) then
         objAltCnd.objVenda.dicDesEspItens[FieldByName('AUTOINCREM').AsString] := (fltDesEspOriginal - fltDesEspRemovido);

      Result := Result - fltDesEspRemovido;

      Next;
    End;
  End;
end;

class function TfrmFatAltQtdeItensPedido.fGetOcorrencia(var strHisBai, strCodComplementoOcorrencia: String;
  var blnGerarVendaPerdida: Boolean; blnHistComplementar,
  blnMostrarOpVendaPedida, blnCrm: Boolean; strEspDoc : String): String;
begin
  Result := '';
  pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);

  Try
    Try
      frmDigOcorrencia.blnInformarHisCom  := blnHistComplementar;
      frmDigOcorrencia.blnUsarVendaPerdida := blnMostrarOpVendaPedida;
      frmDigOcorrencia.blnCrm := blnCrm;
      frmDigOcorrencia.strOpcDoc := strEspDoc;
      frmDigOcorrencia.ShowModal;

      If (frmDigOcorrencia.ModalResult = mrOk) Then
      Begin
        Result := frmDigOcorrencia.strCodOco;
        If (blnHistComplementar) Then
          strHisBai := frmDigOcorrencia.edtHisCom.Text;

        blnGerarVendaPerdida := frmDigOcorrencia.ckbIncluirOrcVendasPerdidas.Checked;
        strCodComplementoOcorrencia := frmDigOcorrencia.edtCodComplementoOcorrencia.Text;
      end;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;
  Finally
    pFreeAndNil(frmDigOcorrencia);
  End;
end;

function TfrmFatAltQtdeItensPedido.fGetProdutosAlterados(blnMsgVen: Boolean = True): String;
  Var
    strTexto,
    strPedido,
    strItens: String;

  Function fMsgType(strPedido: String): String;
  Begin
    If cdsDados.IsEmpty Then
    Begin
      Result := '';
      Result := Result + 'Por motivos de estoque, seu pedido ' + strPedido + ' possuía apenas um produto e sofreu manutenção.' + #13;
      Result := Result + 'Por este motivo, foi baixado. Será necessário adotar as devidas providências junto à seu cliente.' + #13;

      If Not fPedidoEntFut Then
        Result := Result + 'Caso o pedido possua contas a receber quitado, foi gerado automaticamente crédito para o referido cliente.' + #13;

      Result := Result + 'Segue abaixo, relação dos produtos alterados, com quantidade original e quantidade atual.';
    End
    Else
    Begin
      Result := '';
      Result := Result + 'Por motivos de estoque, seu pedido ' + strPedido + ' sofreu manutenção em produtos.' + #13;
      Result := Result + 'Será necessário adotar as devidas providências junto à seu cliente.' + #13;

      If Not fPedidoEntFut Then
        Result := Result + 'Caso o pedido possua contas a receber quitado, foi gerado automaticamente crédito para o referido cliente.' + #13;

      Result := Result + 'Segue abaixo, relação dos produtos alterados, com quantidade original e quantidade atual.';
    End;
  End;

  Function fItens: String;
    Var
      cdsTemp    : TUniClientDataSet;
      blnCancelaPD: Boolean;
      fltDesEspRemovido : Double;
      fltDesEspOriginal : Double;
  Begin
    {*****************************************************}
    {* SE DELETOU TODOS OS ITENS DO PD, CARREGA cdsVenda *}
    {**************************************************MM*}
    If cdsDados.IsEmpty Then
    Begin
      cdsTemp      := cdsVenda;
      blnCancelaPD := True;
    End
    Else
    Begin
      cdsTemp      := cdsDados;
      blnCancelaPD := False;
    End;

    With cdsTemp Do
    Begin
      Result := '';

      First;
      While Not EOF Do
      Begin
        If blnCancelaPD Then
        Begin
          If cdsDesEsp.FindKey([ FieldByName('ITE_SEQDET').AsString ]) Then
            fltDesEspOriginal := cdsDesEsp.FieldByName('ITE_DESESP').AsFloat
          Else
            fltDesEspOriginal := 0;

          fltDesEspRemovido := fltDesEspOriginal;

          Result := Result +
                   'Produto: '        + FieldByName('ITE_CODITE').AsString + '-' + FieldByName('ITE_DESITE').AsString + '  -  ' +
                   'Unidade: '        + FieldByName('ITE_SIGUNI').AsString + #13 +
                   'Qtde. Original: ' + FloatToStrF(FieldByName('ITE_QTDITE').OldValue,  ffFixed, 12, fCfgSis('DECQTD', varInteger)) + '  -  ' +
                   'Qtde. Atual: 0,00 (DELETADO)' + #13 +
                   'Vlr. Unitário: '  + FloatToStrF(FieldByName('ITE_UNITAR').AsFloat,   ffFixed, 12, fCfgSis('DECQTD', varInteger)) + '  -  ' +
                   'Vlr. Total: '     + FloatToStrF(FieldByName('ITE_TOTITE').AsFloat - fltDesEspRemovido,   ffFixed, 12, fCfgSis('DECQTD', varInteger)) + #13 +
                   IIF(blnMsgVen, '-----------------------------------------------------------------------', '') + #13;
        End
        Else
        Begin
          If (FieldByName('ITE_QTDITE').AsFloat <> FieldByName('ITE_QTDITE').OldValue) Then
          Begin
            If cdsDesEsp.FindKey([ FieldByName('ITE_SEQDET').AsString ]) Then
              fltDesEspOriginal := cdsDesEsp.FieldByName('ITE_DESESP').AsFloat
            Else
              fltDesEspOriginal := 0;

            fltDesEspRemovido := fFormataFloat((fltDesEspOriginal / FieldByName('ITE_QTDITE').OldValue) * FieldByName('ITE_QTDITE').AsFloat, 2);

            Result := Result +
                     'Produto: '        + FieldByName('ITE_CODITE').AsString + '-' + FieldByName('ITE_DESITE').AsString + '  -  ' +
                     'Unidade: '        + FieldByName('ITE_SIGUNI').AsString + #13 +
                     'Qtde. Original: ' + FloatToStrF(FieldByName('ITE_QTDITE').OldValue,  ffFixed, 12, fCfgSis('DECQTD', varInteger)) + '  -  ' +
                     'Qtde. Atual: '    + FloatToStrF(FieldByName('ITE_QTDITE').AsFloat,   ffFixed, 12, fCfgSis('DECQTD', varInteger)) + #13 +
                     'Vlr. Unitário: '  + FloatToStrF(FieldByName('ITE_UNITAR').AsFloat,   ffFixed, 12, fCfgSis('DECQTD', varInteger)) + '  -  ' +
                     'Vlr. Total: '     + FloatToStrF(FieldByName('ITE_TOTITE').AsFloat - fltDesEspRemovido,   ffFixed, 12, fCfgSis('DECQTD', varInteger)) + #13 +
                     IIF(blnMsgVen, '-----------------------------------------------------------------------', '') + #13;
          End;
        End;

        Next;
      End;
    End;

    {********************************************************************}
    {* SE DELETOU ALGUM ITEM DO PD, BUSCA AS INFORMAÇÕES NO cdsVendaBkp *}
    {*****************************************************************MM*}
    If (blnTemItensDeletados) And (Not blnCancelaPD) Then
    Begin
      With cdsVendaBkp Do
      Begin
        First;
        While Not EOF Do
        Begin
          If (Not cdsDados.Locate('ITE_CODITE', FieldByName('ITE_CODITE').AsString, [])) Then
          Begin
            If cdsDesEsp.FindKey([ FieldByName('ITE_SEQDET').AsString ]) Then
              fltDesEspOriginal := cdsDesEsp.FieldByName('ITE_DESESP').AsFloat
            Else
              fltDesEspOriginal := 0;

            fltDesEspRemovido := fltDesEspOriginal;

            Result := Result +
                     'Produto: '        + FieldByName('ITE_CODITE').AsString + '-' + FieldByName('ITE_DESITE').AsString + '  -  ' +
                     'Unidade: '        + FieldByName('ITE_SIGUNI').AsString + #13 +
                     'Qtde. Original: ' + FloatToStrF(FieldByName('ITE_QTDITE').OldValue,  ffFixed, 12, fCfgSis('DECQTD', varInteger)) + '  -  ' +
                     'Qtde. Atual: 0,00 (DELETADO)' + #13 +
                     'Vlr. Unitário: '  + FloatToStrF(FieldByName('ITE_UNITAR').AsFloat,   ffFixed, 12, fCfgSis('DECQTD', varInteger)) + '  -  ' +
                     'Vlr. Total: '     + FloatToStrF(FieldByName('ITE_TOTITE').AsFloat - fltDesEspRemovido,   ffFixed, 12, fCfgSis('DECQTD', varInteger)) + #13 +
                     IIF(blnMsgVen, '-----------------------------------------------------------------------', '') + #13;
          End;

          Next;
        End;
      End;
    End;
  End;


begin
  Result   := '';
  strItens := fItens;

  If fEmptyStr(strItens) Then
    Exit;

  strPedido := edtNumDoc.Text + '-' + edtEspDoc.Text + '-' + edtCodEmp.Text;

  If blnMsgVen Then
  Begin
    strTexto  := 'Prezado Vendedor ' + edtCodVen.Text + ' - ' + edtDesVen.Text + #13 +
                 ' '                                                           + #13 +
                 fMsgType(strPedido)                                           + #13 +
                 ' '                                                           + #13 +
                 'Pedido  : ' + strPedido + IfThen(fPedidoEntFut, ' (Entrega Futura)','') + #13 +
                 'Cliente : ' + edtCodCli.Text + ' - ' + edtDesCli.Text        + #13 +
                 'Romaneio: ' + strNumRom + '-' + edtCodEmp.Text               + #13 +
                 ' '                                                           + #13 +
                 '----------------------------[PRODUTOS]----------------------------' + #13 +
                 strItens                                                      + #13 +
                 ' '                                                           + #13 +
                 'Atenciosamente,'                                             + #13 +
                 strLoginUsuarioLogado + '-' + fRetNomeOperador(strLoginUsuarioLogado) + #13 +
                 IIF(blnExpedicao, 'Setor de Expedição.', '');
  End
  Else
  Begin
    strTexto  := '------------------------------------------------------------------------------' + #13 +
                 'Produtos Alterados do Pedido ' + strPedido + IfThen(fPedidoEntFut, ' (Entrega Futura)','') + #13 +
                 '------------------------------------------------------------------------------' + #13 +
                 strItens                                                                         +
                 '------------------------------------------------------------------------------' + #13 +
                 'Responsável pela alteração,'                                                    + #13 +
                 strLoginUsuarioLogado + '-' + fRetNomeOperador(strLoginUsuarioLogado)            + #13 +
                 IIF(blnExpedicao, 'Setor de Expedição.', '');
  End;

  Result := strTexto;
end;

procedure TfrmFatAltQtdeItensPedido.pEnviaMsg;
  Var
    objMsg  : TMsgInterna;
    strTexto: String;
begin
  strTexto := fGetProdutosAlterados;

  If fEmptyStr(strTexto) Then
    Exit;

  Try
    objMsg := TMsgInterna.Create(Nil);

    If Not objMsg.fEnviaMensagem('Manutenção de Pedido de Venda ' + IIF(blnExpedicao, '(Expedição)', ''),
                                 strTexto,
                                 strLoginUsuarioLogado,
                                 edtCodVen.Text,
                                 'N',
                                 '') Then
    Begin
      fMensagem('ATENÇÃO!', 'Não foi possível enviar a mensagem para o usuário ' +
                             fRetNomeOperador(edtCodVen.Text) + ' avisando sobre a ' +
                            'manutenção do pedido. Favor avisá-lo.', ['&Ok']);
    End;
  Finally
    FreeAndNil(objMsg);
  End;
end;

procedure TfrmFatAltQtdeItensPedido.pEscapePressed;
begin
  If (ActiveControl <> edtNumDoc) Then
    pLimpaTela
  Else
    inherited;
end;

end.
