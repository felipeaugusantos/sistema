unit untFatCortarPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  ExtCtrls, DB, Uni, BitBtnLockedIncrem, Mask, MaskEditFocus, untTypesSistema,
  cxProgressBar, TypInfo, Faturamento.Classes.TAlterarPedido, frxClass,
  frxExportCSVTestabilidade, Vcl.Grids, DBGridCitel, Vcl.DBGrids,
  UniClientDataSet, UniDataSetProvider, untMsgInterna, untLiberacao, System.Math;

type
  TfrmFatCortarPedido = class(TfrmPai)
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
    edtVlrCon: TEditFocus;
    pnlItens: TPanel;
    lbl3: TLabel;
    edtCodVen: TEditFocus;
    dbgItens: TDBGridCitel;
    Label1: TLabel;
    edtTotPro: TEditFocus;
    Label2: TLabel;
    edtDesEsp: TEditFocus;
    Label3: TLabel;
    edtTotIpi: TEditFocus;
    edtTotRet: TEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    edtDesAce: TEditFocus;
    Label6: TLabel;
    edtTotFre: TEditFocus;
    lblTotCBS: TLabel;
    lblTotIBS: TLabel;
    lblTotIS: TLabel;
    edtTotCBS: TEditFocus;
    edtTotIBS: TEditFocus;
    edtTotIS: TEditFocus;
    btnCopiarQtd: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgItensColEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnConfirmaErro(Sender: TWinControl; strMsgErro: string; E: Exception);
    procedure btnCopiarQtdClick(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    dtsDados: TDataSource;
    cdsDados: TUniClientDataSet;

    cdsVendaBkp: TUniClientDataSet;

    intSemaforoValidar: Integer;

    objAltDoc: TAlterarPedido;

    strInRqCp: String;

    cdsInfAdcItem: TUniClientDataSet;
    objLiberacao: TLiberacao;

    procedure pLimparTela;
    procedure pAtualizaDadosDocumento;
    function fCalcularSalDis(pgbStatus: TcxProgressBar = NIL): Boolean;

    procedure pBeforePost(DataSet: TDataSet);
    procedure pAfterInsert(DataSet: TDataSet);
    procedure pAfterOpen(DataSet: TDataSet);

    function fQuantidadePendenteTodosItens: Boolean;
    function fQuantidadeZeradaTodosItens: Boolean;

    procedure pZerarQuantidadeProdutos;
    procedure pAtualizarValorProdutos;
    procedure pCopiarQuantidadePendente;

    function pAcertarQuantidadeDocOriginal: Double;

    procedure pLimparItens;

    procedure pCriaClientInfAdcItem;
    procedure pProcessaClientInfAdcItem;
    procedure pConfirmar;
    function fCarregarDocumento(): Boolean; overload;
    function fCarregarDocumento(strNumPed, strEspPed, strEmpPed: String): Boolean; overload;

    procedure pCortarPedidos;

    procedure pFecharCorteExpedicao(blnCortou: Boolean);

    function fEmpresaParaFaturamentoUsaWMS(strCodEmp: String): Boolean;
    function fEhEmissaoDocumentoWMS(strCodEmp: String): Boolean;
    procedure pAddColunasGrid;
    procedure AjustarTamanhoDaColunaDescricaoDaGrid;

    function PossuiAdiantamento(): Boolean;
    function fDocEmRomaneio(out strCodRom: String): Boolean;
    function fDocumentoVinculadoOrdemServico(out strNumOse: String): Boolean;
    procedure pAddColuna(const strFieldName, strCaption: String);
    function fCodEmp: String;
    function fDesconsideraMultiploVenda(strCodBarEmb: String): Boolean;
    function fPedeSenhaMultiploVenda(DataSet: TDataSet): Boolean;

    procedure pValidaAumentoQuantidade(DataSet: TDataSet);
    procedure pValidaQuantidadeFracionaria(DataSet: TDataSet);
    procedure pValidaQuantidadeNegativa(DataSet: TDataSet);
    procedure pValidaItem(DataSet: TDataSet);
    procedure pValidaQuantidadeMultiplo(DataSet: TDataSet);
    procedure pSetDisplayFormat(DataSet: TDataSet; FieldName, DisplayFormat: String);
    procedure pReturnPressed;
    procedure pLimparComponentes;
    procedure pValidaQuantidadeMultiplo14(DataSet: TDataSet);
    function fCdsDadosHasData: Boolean;
    function fPrecisaAjustarEmbalagemTintaAutomotiva: Boolean;
    function fProdutoFracionario(CodUnid, QtdIte: String): Boolean;
    function fPrecisaValidarItem: Boolean;
    function fValidaCfgVenPed: Boolean;
    function fValidaEscape: Boolean;
    function fInformadoDocumento: Boolean;
    function fCdsDadosClear: Boolean;
    function fGetNumLot: String;

    procedure pEditQuantidade;
  public
    { Public declarations }
    blnSucesso: Boolean;
    blnApresentouMensagem: Boolean;
    strNumPed, strEspPed, strEmpPed: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    procedure pEscapePressed; Override;
  end;

implementation

uses StrUtils, untConsultas, untPanelCxPedOrc, System.UITypes, untPnlDadosPedOrc,
  untFuncoes, untConstantes, untFuncoesSimples, untFuncFat, untGravando,
  untDigOcorrencia, untAdiantamentoCliente, untFatRequisicaoCompras, untTEnvioEmail,
  untAdiantamentoClienteGenerico, untIFatReservaSaldo, untTFatReservaSaldo,
  untFuncTinta, untTFatReprocessarSaldoItem, Yapay.Api.Facade, untCadRec;

{$R *.dfm}

procedure TfrmFatCortarPedido.btnConfirmaErro(Sender: TWinControl; strMsgErro: string; E: Exception);
begin
  inherited;
  If E Is EAbort Then
    Exit;

  If E Is Exception Then
    pMensagensErro(E.Message, '');
end;

function TfrmFatCortarPedido.fCdsDadosHasData: Boolean;
begin
  Result := False;

  if not Assigned(cdsDados) then
    Exit;

  if (cdsDados.IsEmpty) then
    Exit;

  Result := True;
end;

procedure TfrmFatCortarPedido.btnCopiarQtdClick(Sender: TObject);
begin
  inherited;
  If Not btnCopiarQtd.Enabled Then
    Exit;

  If fCdsDadosHasData Then
    pCopiarQuantidadePendente
  Else
    pMensagemOk('É necessário selecionar um documento!');
end;

procedure TfrmFatCortarPedido.dbgItensColEnter(Sender: TObject);
begin
  inherited;
  cdsDados.FieldByName('ITE_QTDBAI').FocusControl;
end;

function TfrmFatCortarPedido.fCdsDadosClear: Boolean;
begin
  Result := False;

  if (Not cdsDados.Active) then
    Exit(True);

  if (cdsDados.IsEmpty) then
    Exit(True);
end;

procedure TfrmFatCortarPedido.dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  If fCdsDadosClear Then
    Exit;

  If (fFormataFloat(cdsDados.FieldByName('ITE_QTDBAI').AsFloat, 2) > 0) Then
  Begin
    If dbgItens.Canvas.Brush.Color <> clHighlight Then
      dbgItens.Canvas.Brush.Color := clMoneyGreen;
  End;

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatCortarPedido.edtNumDocKeyPress(Sender: TObject; var Key: Char);
Var
  strEspDoc: String;
  arrDoc: TConsultasArray;
  objfrmPnl: TPanelCxPedOrc;
  qryFatGor: TUniQuery;
begin
  Try
    inherited;

    strEspDoc := 'OR';

    If fEntraCons(Key) Then
    Begin
      If (fMensagem('', 'Escolha: ', ['&Orçamento', '&Pedido']) = 2) Then
        strEspDoc := 'PD'
      Else
        strEspDoc := 'OR';

      objfrmPnl := TPanelCxPedOrc.Create(TfrmPnlDadosPedOrc, strEspDoc);

      qryFatGor := fCriarQuery(
        'SELECT * FROM FATGOR F ' +
        'LEFT JOIN EXTGOR E ON E.FGO_SEQFGO = F.AUTOINCREM ' +
        'LEFT JOIN SERGOR S ON S.FGO_SEQFGO = F.AUTOINCREM ' +
        'WHERE FALSE', Self);

      If fPesqPedOrc(
        conPedCompleta,
        Self,
        strEspDoc,
        strEspDoc,
        VS_strCodEmp,
        edtNumDoc,
        edtEspDoc,
        edtCodEmp,
        qryFatGor,
        Key,
        arrDoc,
        True,
        objfrmPnl,
        '') Then
      Begin
        edtNumDoc.Text := qryFatGor.FieldByName('FGO_NUMDOC').AsString;
        edtEspDoc.Text := qryFatGor.FieldByName('FGO_ESPDOC').AsString;

        fValidaCampos(edtEspDoc);
      End;

      FreeAndNil(qryFatGor);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatCortarPedido.edtNumDocKeyPress]');
  End;
end;

function TfrmFatCortarPedido.fPrecisaAjustarEmbalagemTintaAutomotiva: Boolean;
begin
  Result := False;

  if (cdsVenda.FieldByName('ITE_IDEPRO').AsString = 'NOR') then
    Exit;

  if (fTintaBaixaProduto(cdsVenda.FieldByName('ITE_IDEPRO').AsString)) then
    Exit;

  if (cdsVenda.FieldByName('ITE_QTDEMB').AsFloat = 0) then
    Exit;

  Result := True;
end;

function TfrmFatCortarPedido.pAcertarQuantidadeDocOriginal: Double;
var
  TotalCorte: Double;
begin
  TotalCorte := 0;
  Try
    cdsDados.DisableControls;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      If cdsVenda.Locate('ITE_SEQDET', cdsDados.FieldByName('ITE_SEQDET').AsString, []) Then
      Begin
        If cdsDados.FieldByName('ITE_QTDBAI').AsFloat > 0 Then
        Begin
          If fFormataFloat(cdsDados.FieldByName('ITE_QTDITE').AsFloat, fCfgSis('DECQTD', varInteger)) = fFormataFloat(cdsDados.FieldByName('ITE_QTDBAI').AsFloat,fCfgSis('DECQTD', varInteger)) Then
          Begin
            cdsVenda.Delete;
            TotalCorte := TotalCorte + cdsVenda.FieldByName ('ITE_TOTITE').AsFloat;
          End
          Else
          Begin
            pEditQuantidade;

            TotalCorte := TotalCorte + (cdsDados.FieldByName('ITE_QTDBAI').AsFloat * cdsVenda.FieldByName('ITE_UNITAR').AsFloat);
          End;
        End;
      End;
      cdsDados.Next;
    End;
    cdsDados.First;
  Finally
    cdsDados.EnableControls;
  End;
  Result := TotalCorte;
end;

procedure TfrmFatCortarPedido.pAddColuna(const strFieldName, strCaption: String);
var
  Coluna: TColumn;
begin
  Coluna := dbgItens.Columns.Add;
  Coluna.FieldName := strFieldName;
  Coluna.Alignment := taRightJustify;
  Coluna.Title.Caption := strCaption;
  Coluna.Title.Alignment := taRightJustify;
end;

procedure TfrmFatCortarPedido.pAddColunasGrid;
var
  strEmpresa: String;
begin
  If (Not fCfgSis('EXISAL', varBoolean)) Then
    Exit;

  If (Not Assigned(fFindColumnByName(dbgItens, 'ESTLOJ'))) Then
  Begin
    pAddColuna('ESTLOJ', 'Qtde Loja');
    pAddColuna('ESTFIL', 'Qtde Filiais');

    If Assigned(objAltDoc.stlEmpresas) Then
    Begin
      For strEmpresa In objAltDoc.stlEmpresas Do
        pAddColuna('EST_EMP_' + LeftStr(strEmpresa, 3), Copy(strEmpresa, 5, 5));
    End;
  End;
end;

procedure TfrmFatCortarPedido.pAfterInsert(DataSet: TDataSet);
begin
  If (cdsDados.Tag = 0) Then
    DataSet.Cancel;
end;

procedure TfrmFatCortarPedido.pSetDisplayFormat(DataSet: TDataSet;
  FieldName, DisplayFormat: String);
var
  Field: TField;
begin
  Field := DataSet.FindField(FieldName);
  If Field <> nil Then
    TFloatField(Field).DisplayFormat := DisplayFormat;
end;

procedure TfrmFatCortarPedido.pAfterOpen(DataSet: TDataSet);
Var
  strEmpresa: String;
begin
  pSetDisplayFormat(DataSet, 'ITE_TOTITE', fMskDigitos(2));
  pSetDisplayFormat(DataSet, 'ITE_UNITAR', fMskDigitos(fCfgSis('DECUNI', varInteger)));
  pSetDisplayFormat(DataSet, 'ITE_QTDITE', fMskDigitos(fCfgSis('DECQTD', varInteger)));
  pSetDisplayFormat(DataSet, 'ITE_QTDBAI', fMskDigitos(fCfgSis('DECQTD', varInteger)));
  pSetDisplayFormat(DataSet, 'ITE_QTDORI', fMskDigitos(fCfgSis('DECQTD', varInteger)));

  If fCfgSis('EXISAL', varBoolean) Then
  Begin
    pSetDisplayFormat(DataSet, 'ESTLOJ', fMskDigitos(fCfgSis('DECQTD', varInteger)));
    pSetDisplayFormat(DataSet, 'ESTFIL', fMskDigitos(fCfgSis('DECQTD', varInteger)));

    If Assigned(objAltDoc.stlEmpresas) Then
      For strEmpresa In objAltDoc.stlEmpresas Do
        pSetDisplayFormat(DataSet, 'EST_EMP_' + LeftStr(strEmpresa, 3), fMskDigitos(fCfgSis('DECQTD', varInteger)));
  End;
end;

procedure TfrmFatCortarPedido.pAtualizaDadosDocumento;
begin
  edtCodCli.Text    := objAltDoc.objVenda.strCodCli;
  edtDesCli.Text    := objAltDoc.objVenda.strCliNom;
  edtCodCndAtu.Text := objAltDoc.objVenda.strCodCnd;
  mskCndPagAtu.Text := objAltDoc.objVenda.strConPag;
  edtDesCndAtu.Text := objAltDoc.objVenda.strDesCnd;
  edtForPagAtu.Text := objAltDoc.objVenda.strCodFpg;
  edtDesFpgAtu.Text := objAltDoc.objVenda.strDesFpg;
  edtCodVen.Text    := objAltDoc.objVenda.strCodVen + ' - ' + objAltDoc.objVenda.strNomVen;

  edtDtaEnt.Text := FormatDateTime('DD/MM/YYYY', objAltDoc.qryFatGor.FieldByName('FGO_DTAENT').AsDateTime);

  edtTotPro.Text := FormatFloat('##,#0.00', objAltDoc.qryFatGor.FieldByName('FGO_TOTPRO').AsFloat);
  edtDesEsp.Text := FormatFloat('##,#0.00', objAltDoc.qryFatGor.FieldByName('FGO_DESESP').AsFloat);
  edtTotIpi.Text := FormatFloat('##,#0.00', objAltDoc.qryFatGor.FieldByName('FGO_TOTIPI').AsFloat);
  edtTotRet.Text := FormatFloat('##,#0.00', objAltDoc.qryFatGor.FieldByName('FGO_TOTRET').AsFloat);
  edtDesAce.Text := FormatFloat('##,#0.00', objAltDoc.qryFatGor.FieldByName('FGO_DESACE').AsFloat);
  edtTotFre.Text := FormatFloat('##,#0.00', objAltDoc.qryFatGor.FieldByName('FGO_TOTFRE').AsFloat);
  edtTotCBS.Text := FormatFloat('##,#0.00', objAltDoc.qryFatGor.FieldByName('FGO_TOTCBS').AsFloat);
  edtTotIBS.Text := FormatFloat('##,#0.00', objAltDoc.qryFatGor.FieldByName('FGO_TOTIBS').AsFloat);
  edtTotIS.Text := FormatFloat('##,#0.00', objAltDoc.qryFatGor.FieldByName('FGO_TOT_IS').AsFloat);
  lblTotCBS.Visible := fSomarNovosImpostosDaReformaAoValorContabil;
  edtTotCBS.Visible := lblTotCBS.Visible;
  lblTotIBS.Visible := lblTotCBS.Visible;
  edtTotIBS.Visible := lblTotCBS.Visible;
  lblTotIS.Visible := lblTotCBS.Visible;
  edtTotIS.Visible := lblTotCBS.Visible;
  edtVlrCon.Text := FormatFloat('##,#0.00', objAltDoc.qryFatGor.FieldByName('FGO_VLRCON').AsFloat);

  pCloneDataSet(cdsDados, cdsVenda);

  { Req.: 103458 - Calcula saldo disponível }
  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Aguarde calculando saldo disponível';
    frmGravando.fExecutarAcao := fCalcularSalDis;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;

  pProcessaClientInfAdcItem;
  pAtualizarValorProdutos;
  pZerarQuantidadeProdutos;

  pnlItens.Enabled := True;
  pnlBusca.Enabled := False;
  btnConfirma.Enabled := True;

  cdsDados.FieldByName('ITE_QTDBAI').FocusControl;
  pSetFocus(dbgItens);
end;

procedure TfrmFatCortarPedido.pAtualizarValorProdutos;
begin
  Try
    cdsDados.DisableControls;
    cdsDados.BeforePost := nil;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      If cdsInfAdcItem.FindKey([cdsDados.FieldByName('ITE_SEQDET').AsString]) Then
      Begin
        cdsDados.Edit;
        cdsDados.FieldByName('ITE_TOTITE').AsFloat := cdsInfAdcItem.FieldByName('ITE_TOTITE').AsFloat - cdsInfAdcItem.FieldByName('ITE_DESESP').AsFloat;
        cdsDados.FieldByName('ITE_UNITAR').AsFloat := cdsDados.FieldByName('ITE_TOTITE').AsFloat / cdsDados.FieldByName('ITE_QTDORI').AsFloat;
        cdsDados.Post;
      End;
      cdsDados.Next;
    End;
    cdsDados.BeforePost := pBeforePost;
    cdsDados.First;
  Finally
    cdsDados.EnableControls;
  End;
end;

function TfrmFatCortarPedido.fCodEmp: String;
Begin
  If Not fEmptyStr(cdsDados.FieldByName('ITE_EMPITE').AsString) Then
    Result := cdsDados.FieldByName('ITE_EMPITE').AsString
  Else If Not fEmptyStr(cdsDados.FieldByName('ITE_CODEMP').AsString) Then
    Result := cdsDados.FieldByName('ITE_CODEMP').AsString
  Else
    Result := VS_strCodEmp;
End;

function TfrmFatCortarPedido.fGetNumLot: String;
var
  LCondicao: Boolean;
begin
  LCondicao := fEhEmissaoDocumentoWMS(fCodEmp);
  if not LCondicao then
    LCondicao := fEmpresaParaFaturamentoUsaWMS(fCodEmp);

  if LCondicao then
  begin
    if cdsDados.FieldByName('ITE_NUMLOT').AsString = 'A DEFINIR' then
      Result := ''
    else
      Result := cdsDados.FieldByName('ITE_NUMLOT').AsString;
  end
  else
    Result := cdsDados.FieldByName('ITE_NUMLOT').AsString;
end;

function TfrmFatCortarPedido.fCalcularSalDis(pgbStatus: TcxProgressBar = NIL): Boolean;
var
  fltSaldos, fltSalDis: Real;
  strNumLot: String;
Begin
  Result := True;

  Try
    cdsDados.BeforePost := nil;
    cdsDados.First;
    Try
      cdsDados.DisableControls;

      While Not cdsDados.Eof Do
      Begin

        cdsDados.Edit;

        strNumLot := fGetNumLot;

        fltSaldos := fRetSaldosEmpresa(cdsDados.FieldByName('ITE_CODITE').AsString, fCodEmp, strNumLot, False);

        fltSalDis := fRetornaSaldoDisponivel(cdsDados.FieldByName('ITE_CODITE').AsString, False, True, strNumLot, True, fCodEmp, edtNumDoc.Text);

        cdsDados.FieldByName('ITE_SALDOS').AsFloat := fltSaldos;
        cdsDados.FieldByName('ITE_SALDIS').AsFloat := fltSalDis;

        cdsDados.Post;

        cdsDados.Next;

      End;

      TFloatField(cdsDados.FieldByName('ITE_SALDOS')).DisplayFormat := '##,#0.000';
      TFloatField(cdsDados.FieldByName('ITE_SALDIS')).DisplayFormat := '##,#0.000';

      cdsDados.BeforePost := pBeforePost;

    Finally
      cdsDados.EnableControls;
    End;

  Except
    Result := False;
  End;

End;

function TfrmFatCortarPedido.fCarregarDocumento: Boolean;
begin
  objAltDoc.strNumPed := edtNumDoc.Text;
  objAltDoc.strEspPed := edtEspDoc.Text;
  objAltDoc.strEmpPed := edtCodEmp.Text;

  objAltDoc.blnValidarMargemValorCndPagto := False;

  Result := objAltDoc.fCarregarPedido;

  strInRqCp := objAltDoc.objVenda.strInRqCp;

  If Result Then
  Begin
    pAtualizaDadosDocumento;
    pCloneDataSet(cdsVendaBkp, cdsVenda);
  End;
end;

function TfrmFatCortarPedido.fQuantidadePendenteTodosItens: Boolean;
begin
  Try
    cdsDados.DisableControls;
    Result := True;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      Result := fFormataFloat(cdsDados.FieldByName('ITE_QTDITE').AsFloat, fCfgSis('DECQTD', varInteger)) =
                fFormataFloat(cdsDados.FieldByName('ITE_QTDBAI').AsFloat, fCfgSis('DECQTD', varInteger));

      If Not Result Then
        Break;

      cdsDados.Next;
    End;
    cdsDados.First;
  Finally
    cdsDados.EnableControls;
  End;
end;

function TfrmFatCortarPedido.fQuantidadeZeradaTodosItens: Boolean;
begin
  Try
    cdsDados.DisableControls;
    Result := True;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      Result := cdsDados.FieldByName('ITE_QTDBAI').AsFloat = 0;

      If Not Result Then
        Break;

      cdsDados.Next;
    End;
    cdsDados.First;
  Finally
    cdsDados.EnableControls;
  End;
end;

function TfrmFatCortarPedido.fDesconsideraMultiploVenda
  (strCodBarEmb: String): Boolean;
begin
  Result := False;

  if (fEmptyStr(strCodBarEmb)) then
    Exit;

  if (fCfgSis('QPDMVC') <> '2') then
    Exit;

  Result := True;
End;

function TfrmFatCortarPedido.fPedeSenhaMultiploVenda(DataSet: TDataSet)
  : Boolean;
Var
  objLiberacao: TLiberacao;
begin
  objLiberacao := TLiberacao.Create;
  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Item ' + DataSet.FieldByName('ITE_CODITE').AsString + ' - ' + LeftStr(DataSet.FieldByName('ITE_DESITE').AsString, 50) + ' com quantidade fora do Múltiplo de Vendas.');
    objLiberacao.objMsgLibera.pAddTexto('Múltiplo de Venda: ' + FloatToStrF(cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3));
    objLiberacao.objMsgLibera.pAddTexto('Quantidade de Venda Digitada: ' + FloatToStrF(DataSet.FieldByName('ITE_QTDBAI').AsFloat, ffNumber, 12, 3));

    objLiberacao.strDirAce := 'SENMTP';
    objLiberacao.strSenLib := fCfgSis('SENMTP');
    objLiberacao.strMsgSen := 'Senha para liberação de venda de item com quantidade fora do múltiplo de venda';
    objLiberacao.strCodOpe := objAltDoc.objVenda.strCodVen;
    objLiberacao.strCodDig := objAltDoc.objVenda.strCodDig;
    objLiberacao.strCliente := objAltDoc.objVenda.strCodCli + '-' + objAltDoc.objVenda.strCliNom;
    objLiberacao.strCpfCnpj := objAltDoc.objVenda.strCliCgc;
    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
end;

procedure TfrmFatCortarPedido.pValidaAumentoQuantidade(DataSet: TDataSet);
begin
  If (DataSet.FieldByName('ITE_QTDBAI').AsFloat > DataSet.FieldByName('ITE_QTDITE').AsFloat) Then
  Begin
    cdsDados.FieldByName('ITE_QTDBAI').FocusControl;
    fMensagem('ATENÇÃO!', 'Não é possível aumentar a quantidade do produto!', ['&Ok']);
    DataSet.Cancel;
    Abort;
  End;
end;

function TfrmFatCortarPedido.fProdutoFracionario(CodUnid, QtdIte: String): Boolean;
begin
  Result := False;
  if (not fItemNaoFracionavel(edtEspDoc.Text, CodUnid)) then
    Exit;

  if (fCfgSis('VENVID', varBoolean)) then // venda vidro
    Exit;

  if (fCfgSis('VENMAD', varBoolean)) then // venda medeireira
    Exit;

  if (Frac(fStrToFloat(QtdIte)) = 0) then
    Exit;

  Result := True;
end;

procedure TfrmFatCortarPedido.pValidaQuantidadeFracionaria(DataSet: TDataSet);
begin
  If fProdutoFracionario(DataSet.FieldByName('ITE_CODUNI').AsString, DataSet.FieldByName('ITE_QTDBAI').AsString) Then
  Begin
    cdsDados.FieldByName('ITE_QTDBAI').FocusControl;
    fMensagem('ATENÇÃO!', 'Não é possível informar valor fracionado para este produto!', ['&Ok']);
    DataSet.Cancel;
    Abort;
  End;
end;

procedure TfrmFatCortarPedido.pValidaQuantidadeNegativa(DataSet: TDataSet);
begin
  If (DataSet.FieldByName('ITE_QTDBAI').AsFloat < 0.00) Then
  Begin
    cdsDados.FieldByName('ITE_QTDBAI').FocusControl;
    fMensagem('ATENÇÃO!', 'Não é permitido informar uma quantidade negativa!', ['&Ok']);
    DataSet.Cancel;
    Abort;
  End;
end;

procedure TfrmFatCortarPedido.pValidaQuantidadeMultiplo(DataSet: TDataSet);
begin
  If (Pos(fCfgSis('MLTVEN'), '14') > 0) Then // 1-Trava / 4-Solicita Senha
    pValidaQuantidadeMultiplo14(DataSet)
  Else If (fCfgSis('MLTVEN') = '3') Then // Avisa
    fMensagem('', 'A quantidade digitada não é múltiplo de: ' + FloatToStrF(cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3), ['&OK']);
end;

procedure TfrmFatCortarPedido.pValidaQuantidadeMultiplo14(DataSet: TDataSet);
Var
  fltValor, fltMltVen: Double;

  blnResult: Boolean;
begin
  If Not SameValue(DataSet.FieldByName('ITE_QTDBAI').AsFloat, DataSet.FieldByName('ITE_SALDIS').AsFloat) Then
  Begin
    blnResult := False;
    fMensagem('', 'A quantidade deve ser igual ou múltiplo de: ' + FloatToStrF(cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, 3), ['&OK']);

    If (fCfgSis('MLTVEN') = '4') Then // Solicita Senha
      blnResult := fPedeSenhaMultiploVenda(DataSet);

    If (Not blnResult) Then
    Begin
      { ***************************************** }
      { * TRAZ COMO SUGESTAO O PROXIMO MULTIPLO * }
      { **************************************JC* }
      fltValor := cdsDados.FieldByName('ITE_QTDBAI').AsFloat;
      fltMltVen := cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat;
      fltValor := Int(((fltValor + fltMltVen) / fltMltVen)) * fltMltVen;

      If (fCfgSis('MLTVEN') = '4') Then
        cdsDados.FieldByName('ITE_QTDBAI').AsFloat := fStrToFloat(FloatToStrF(cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat, ffNumber, 12, fCfgSis('DECQTD', varInteger)))
      Else
        cdsDados.FieldByName('ITE_QTDBAI').AsFloat := fStrToFloat(FloatToStrF(fltValor, ffNumber, 12, fCfgSis('DECQTD', varInteger)));
    End;
  End;
end;

procedure TfrmFatCortarPedido.pValidaItem(DataSet: TDataSet);
var
  fltValor: Double;
begin
  If DataSet.FieldByName('ITE_QTDBAI').AsFloat < cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat Then
    pValidaQuantidadeMultiplo(DataSet)
  Else
  Begin
    { **************************************************************************************************************************************************** }
    { * ESTOU CHAMANDO A fFormataFloatInterna, pois quando usa SAT ele utiliza a fArredondaABNT_NBR5891_77 que por sua vez gera os seguintes resultados: * }
    { * fArredondaABNT_NBR5891_77(12500, 4) = 12500                                                                                                      * }
    { * fArredondaABNT_NBR5891_77(125000, 4) = 0,0001                                                                                                    * }
    { *************************************************************************************************************************************************RN* }
    fltValor := fFormataFloatInterna(cdsDados.FieldByName('ITE_QTDBAI').AsFloat / cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat, 4);
    If (fltValor - Int(fltValor)) > 0 Then
      pValidaQuantidadeMultiplo(DataSet);
  End;
end;

function TfrmFatCortarPedido.fPrecisaValidarItem: Boolean;
begin
  Result := False;

  If (cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat = 0) then
    Exit;

  if (fDesconsideraMultiploVenda(cdsInfAdcItem.FieldByName('BAR_CODBAR').AsString)) then
    Exit;

  Result := True;
end;

procedure TfrmFatCortarPedido.pBeforePost(DataSet: TDataSet);
begin
  pSetFocus(dbgItens);

  pValidaAumentoQuantidade(DataSet);
  pValidaQuantidadeFracionaria(DataSet);
  pValidaQuantidadeNegativa(DataSet);

  If (DataSet.FieldByName('ITE_QTDBAI').AsFloat > 0.00) Then
  Begin
    pProcessaClientInfAdcItem;

    If cdsInfAdcItem.FindKey([cdsDados.FieldByName('ITE_SEQDET').AsString]) Then
    Begin
      If fPrecisaValidarItem Then
        pValidaItem(DataSet);
    End;
  End;

end;

procedure TfrmFatCortarPedido.pCriaClientInfAdcItem;
var
  Field: TFieldDef;
begin
  cdsInfAdcItem := TUniClientDataSet.Create(Self);

  Field := cdsInfAdcItem.FieldDefs.AddFieldDef;
  Field.Name := 'ITE_SEQDET';
  Field.DataType := ftString;
  Field.Size := 20;

  Field := cdsInfAdcItem.FieldDefs.AddFieldDef;
  Field.Name := 'ITE_DESESP';
  Field.DataType := ftFloat;

  Field := cdsInfAdcItem.FieldDefs.AddFieldDef;
  Field.Name := 'ITE_VALFRE';
  Field.DataType := ftFloat;

  Field := cdsInfAdcItem.FieldDefs.AddFieldDef;
  Field.Name := 'ITE_DESACE';
  Field.DataType := ftFloat;

  Field := cdsInfAdcItem.FieldDefs.AddFieldDef;
  Field.Name := 'ITE_TOTITE';
  Field.DataType := ftFloat;

  Field := cdsInfAdcItem.FieldDefs.AddFieldDef;
  Field.Name := 'ITE_MLTVEN';
  Field.DataType := ftFloat;

  Field := cdsInfAdcItem.FieldDefs.AddFieldDef;
  Field.Name := 'BAR_CODBAR';
  Field.DataType := ftString;

  cdsInfAdcItem.CreateDataSet;
  cdsInfAdcItem.IndexFieldNames := 'ITE_SEQDET';
end;

procedure TfrmFatCortarPedido.pLimparComponentes;
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
end;

procedure TfrmFatCortarPedido.pLimparTela;
begin
  If Assigned(objAltDoc) Then
    FreeAndNil(objAltDoc);

  objAltDoc := TAlterarPedido.Create(Self);

  pLimparComponentes;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  edtEspDoc.Text := 'PD';

  btnConfirma.Enabled := False;
  pnlItens.Enabled := False;
  pnlBusca.Enabled := True;

  pSetFocus(edtNumDoc);
  pLimparItens;
end;

function TfrmFatCortarPedido.PossuiAdiantamento: Boolean;
var
  qryAdt: TUniQuery;
begin
  qryAdt := fCriaQuery;
  try
    qryAdt.SQL.Add('SELECT ADT_NUMDOC');
    qryAdt.SQL.Add('FROM ADTCLI');
    qryAdt.SQL.Add('WHERE ADT_NUMDOC = :NUMDOC');
    qryAdt.SQL.Add('  AND ADT_ESPDOC = :ESPDOC');
    qryAdt.SQL.Add('  AND ADT_CODEMP = :CODEMP');

    qryAdt.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    qryAdt.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    qryAdt.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryAdt.Open;

    Result := not qryAdt.IsEmpty;
  finally
    FreeAndNil(qryAdt);
  end;
end;

procedure TfrmFatCortarPedido.pProcessaClientInfAdcItem;
Var
  qryFatDor: TUniQuery;
begin
  qryFatDor := fCriaQuery(nil);

  qryFatDor.SQL.Text :=
    'SELECT F.FDO_DESESP, F.FDO_TOTFRE, F.FDO_DESACE, F.FDO_TOTITE, C.ITE_MLTVEN, I.BAR_CODBAR ' +
    'FROM FATDOR F ' +
    'LEFT JOIN CADITE C ON C.ITE_CODITE = F.FDO_CODITE ' +
    'LEFT JOIN ITEBAR I ON I.BAR_CODITE = C.ITE_CODITE ' +
    'WHERE F.AUTOINCREM = :AUTINC ';

  cdsInfAdcItem.EmptyDataSet;

  cdsVenda.First;
  While Not cdsVenda.Eof Do
  Begin

    If Not cdsInfAdcItem.FindKey
      ([cdsVenda.FieldByName('ITE_SEQDET').AsString]) Then
    Begin
      qryFatDor.Close;
      qryFatDor.ParamByName('AUTINC').AsString := cdsVenda.FieldByName('ITE_SEQDET').AsString;
      qryFatDor.Open;

      cdsInfAdcItem.Append;
      cdsInfAdcItem.FieldByName('ITE_SEQDET').AsString := cdsVenda.FieldByName('ITE_SEQDET').AsString;
      cdsInfAdcItem.FieldByName('ITE_DESESP').AsFloat  := qryFatDor.FieldByName('FDO_DESESP').AsFloat;
      cdsInfAdcItem.FieldByName('ITE_VALFRE').AsFloat  := qryFatDor.FieldByName('FDO_TOTFRE').AsFloat;
      cdsInfAdcItem.FieldByName('ITE_DESACE').AsFloat  := qryFatDor.FieldByName('FDO_DESACE').AsFloat;
      cdsInfAdcItem.FieldByName('ITE_TOTITE').AsFloat  := qryFatDor.FieldByName('FDO_TOTITE').AsFloat;
      cdsInfAdcItem.FieldByName('ITE_MLTVEN').AsFloat  := qryFatDor.FieldByName('ITE_MLTVEN').AsFloat;
      cdsInfAdcItem.FieldByName('BAR_CODBAR').AsString := qryFatDor.FieldByName('BAR_CODBAR').AsString;

      cdsInfAdcItem.Post;
    End;

    cdsVenda.Next;
  End;

  FreeAndNil(qryFatDor);
end;

procedure TfrmFatCortarPedido.pZerarQuantidadeProdutos;
begin
  Try
    cdsDados.DisableControls;
    cdsDados.BeforePost := nil;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('ITE_QTDBAI').AsFloat := 0;
      cdsDados.Post;
      cdsDados.Next;
    End;
    cdsDados.First;
    cdsDados.BeforePost := pBeforePost;
  Finally
    cdsDados.EnableControls;
  End;
end;

procedure TfrmFatCortarPedido.pLimparItens;
begin
  If cdsDados.Active Then
    cdsDados.EmptyDataSet;
end;

function TfrmFatCortarPedido.fDocEmRomaneio(out strCodRom: String): Boolean;
Begin
  strCodRom := '';
  If (Not fEmptyStr(edtNumDoc.Text)) Then
    strCodRom := fDocumentoEmRomaneio(edtNumDoc.Text, edtEspDoc.Text);

  Result := Not fEmptyStr(strCodRom);
End;

function TfrmFatCortarPedido.fDocumentoVinculadoOrdemServico(out strNumOse: String): Boolean;
Begin
  strNumOse := fRetornaOrdemServicoPedido(edtNumDoc.Text, edtCodEmp.Text);
  Result := Not fEmptyStr(strNumOse);
End;

function TfrmFatCortarPedido.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Var
  blnJaFatu, blnJaBaix, blnImpresso, blnSepImpresso: Boolean;
  strCodRom: String;
  strCodVen: String;
  strNumOse: String;
  objParametrosMensagem: TParametrosMensagem;
begin

  Result := True;
  blnJaFatu := False;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O número do documento deve ser informado!', ['&O k']);
        Result := False;
      End
      Else If edtEspDoc.ReadOnly Then
      Begin
        Result := fValidaCampos(edtEspDoc, blnBuscaPorChave);
      End;
    End

    Else If (Sender = edtEspDoc) Then
    Begin

      If InterlockedIncrement(intSemaforoValidar) = 0 Then
      Begin

        Try

          If (Pos(edtEspDoc.Text, 'OR_PD_') <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Espécie deve ser OR ou PD!', ['&O k']);
            Result := False;
          End
          Else If (Not fDocumentoFatExiste(objAltDoc.qryFatGor, edtNumDoc.Text,
            edtEspDoc.Text, edtCodEmp.Text, blnJaFatu, blnJaBaix, blnImpresso,
            strCodVen, blnSepImpresso)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse documento não está cadastrado!', ['&O k']);
            Result := False;
          End

          Else If (blnJaFatu) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse documento já foi faturado!', ['&O k']);
            Result := False;
          End

          Else If (fPedidoFaturadoParcialmente(edtNumDoc.Text, edtEspDoc.Text,
            edtCodEmp.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Documento faturado parcialmente não pode ser alterado!', ['&O k']);
            Result := False;
          End

          else if TYapayFacade.fPedidoPossuiCobrancaAtiva(edtNumDoc.Text,
            edtEspDoc.Text, edtCodEmp.Text) Then
          begin
            objParametrosMensagem := TParametrosMensagem.Create;
            try
              objParametrosMensagem.Titulo := 'Yapay';
              objParametrosMensagem.Texto := 'Pedido possuí Cobrança Yapay e não pode ser alterado/cancelado!';
              objParametrosMensagem.Opcoes := ['&OK'];
              objParametrosMensagem.Url.Caption := 'Visualizar cobrança';
              objParametrosMensagem.Url.Href := TYapayFacade.fLinkPagamento(TYapayFacade.fGetAutIncFatGor(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text));
              fMensagem(objParametrosMensagem);
            finally
              objParametrosMensagem.Free;
            end;
            Result := False;
          End

          Else If fTemServico(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, '') Then
          Begin
            fMensagem('', 'Documento com serviços não pode ser alterado!', ['&OK']);
            Result := False;
          End

          Else If fTemVidro(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text) Then
          Begin
            fMensagem('', 'Documento com vidros não pode ser alterado!', ['&OK']);
            Result := False;
          End

          Else If (Not fEmptyStr(edtNumDoc.Text)) And (edtEspDoc.Text = 'OR')
            And (Not fVerificaAcessoSistema('VERORC')) And
            (strCodVen <> strLoginUsuarioLogado) And
            (Not fEmptyStr(strCodVen)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Acesso ao documento não permitido!', ['&O k']);
            Result := False;
          End

          Else If (Not fEmptyStr(edtNumDoc.Text)) And (edtEspDoc.Text = 'PD')
            And (Not fVerificaAcessoSistema('VERPED')) And
            (strCodVen <> strLoginUsuarioLogado) And
            (Not fEmptyStr(strCodVen)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Acesso ao documento não permitido!', ['&O k']);
            Result := False;
          End

          Else If (edtEspDoc.Text = 'PD') And
            (fDocumentoVinculadoOrdemServico(strNumOse)) Then
          Begin
            pMensagemOk('Este pedido de venda foi gerado a partir' + #13 +
              'da O.S. ' + strNumOse + ' e não pode ser alterado.' + #13 + #13 +
              'As alterações devem ser feitas na própria O.S.!');
            Result := False;
          End

          Else If fDocEmRomaneio(strCodRom) And
            (Not fCfgSis('USPRRO', varBoolean)) Then
          Begin
            fMensagem('ATENÇÃO!',
              'Esse Documento está associado ao(s) Romaneio(s): ' + strCodRom +
              '.' + #13#10 +
              'Remova esse Documento do(s) romaneio(s) para poder alterá-lo!',
              ['&Ok']);
            Result := False;
          End

          Else If fPedidoBaixaEntregaFutura(edtNumDoc.Text, edtEspDoc.Text,
            edtCodEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!',
              'Pedidos de Baixa de Entrega Futura não podem ser alterados!',
              ['&Ok']);
            Result := False;
          End

          Else If (Not fEmptyStr(edtNumDoc.Text)) And
            (SameText(edtEspDoc.Text, 'PD')) And
            (TFatVenda.fTotalDuplicataQuitada(objAltDoc.qryFatGor.FieldByName
            ('FGO_NUMDOC').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString) > 0) Then
          Begin
            Result := False;
            fMensagem('ATENÇÃO!', 'Não é permitido alterar um pedido ' +
              'que possua contas a receber quitado!', ['&OK']);
          End

          Else If (Not fEmptyStr(edtNumDoc.Text)) And
            (SameText(edtEspDoc.Text, 'PD')) And
            (TAdiantamento.fGetTotaisAdiantamento
            (objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString)
            .fltValLan > 0) Then
          Begin
            Result := False;
            fMensagem('ATENÇÃO!', 'Não é permitido Cortar um pedido ' +
              'que possua adiantamento de cliente!', ['&OK']);
          End

          Else If fEhPedOrcMultiloja
            (objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString) Then
          Begin
            Result := False;
            fMensagem('ATENÇÃO!', 'Não é permitido Cortar um pedido ' +
              'multiloja por essa rotina!', ['&OK']);
          End;

          If Result And SameText(edtEspDoc.Text, 'PD') And
            (Not fEmptyStr(edtNumDoc.Text)) And
            (TAdiantamentoGenerico.fRetornaValorBoletosAdiantamento
            (objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString) > 0) Then
          Begin
            Result := False;
            fMensagem('ATENÇÃO!', 'Não é permitido Cortar um pedido ' +
              'com boleto de adiantamento ' + 'que ainda não foi baixado pela '
              + 'remessa bancária!', ['&OK']);
          End;

          { ********************************************** }
          { * CASO NAO PERMITA ALTERAR PEDIDOS IMPRESSOS * }
          { *******************************************JC* }
          If Result And (Not fCfgSis('ALTPDI', varBoolean)) And (blnImpresso)
            And (Not fEmptyStr(edtNumDoc.Text)) And (edtEspDoc.Text = 'PD') Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Documento já foi impresso portanto não é possível alterá-lo!', ['&Ok']);

            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('Esse Documento já foi impresso portanto não é possível alterá-lo!');
            objLiberacao.objMsgLibera.pAddTextoCaption('Documento',
              objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
              objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
              objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString, 9);

            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente',
              objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
              fRetNomCliente(objAltDoc.qryFatGor.FieldByName('FGO_CODCLI')
              .AsString), 9);

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
          End;

          { *********************************************************** }
          { * CASO NAO PERMITA ALTERAR PEDIDOS COM SEPARAÇÃO IMPRESSA * }
          { ********************************************************MM* }
          If Result And (blnSepImpresso) And (Not fEmptyStr(edtNumDoc.Text)) Then
          Begin
            If fImpressaoParcialConsiderandoJaImpresso Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é possível alterar esse Documento, pois a separação já foi impressa!', ['&Ok']);
              Result := False;
            End
            Else If (fCfgSis('ALTPDS') = 'N') Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é possível alterar esse Documento, pois a separação já foi impressa!', ['&Ok']);

              objLiberacao.Clear;
              objLiberacao.objMsgLibera.pAddTexto('Não é possível alterar esse Documento, pois a separação já foi impressa!');
              objLiberacao.objMsgLibera.pAddTextoCaption('Documento',
                objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString, 9);

              objLiberacao.objMsgLibera.pAddTextoCaption('Cliente',
                objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                fRetNomCliente(objAltDoc.qryFatGor.FieldByName('FGO_CODCLI')
                .AsString), 9);

              objLiberacao.strDirAce := 'ALTPDS';
              objLiberacao.strCodOpe := strLoginUsuarioLogado;
              objLiberacao.blnSempreVariavelUsuario := True;

              Result := objLiberacao.fLibera;
            End
            Else If (fCfgSis('ALTPDS') = 'C') And
                    (objAltDoc.qryFatGor.FieldByName('FGO_ENT_CD').AsString = 'S') And
                    (objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString = 'PD') And
                    (objAltDoc.qryFatGor.FieldByName('FGO_EMP_CD').AsString <> VS_strCodEmp) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é possível alterar, pois este pedido é entrega '
                                  + 'pelo CD e a separação já foi impressa. '
                                  + 'Somente será possível realizar alteração após limpar separação. '
                                  + 'Entre em contato com o responsável pelo CD.', ['&Ok']);
              Result := False;
            End;
          End;

          { *********************************************************** }
          { * CASO NAO PERMITA ALTERAR PEDIDOS COM ORDEM DE PRODUÇÃO  * }
          { * DE PRODUTOS TINTOMÉTRICOS IMPRESSA                      * }
          { ********************************************************MM* }
          If (Result) And (Not fEmptyStr(edtNumDoc.Text)) And
            (VS_strUsaTmq = 'S') And (Not fCfgSis('ALTPDT', varBoolean)) And

            (fTemProdutoTintometrico(objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString)) And

            (fTemOrdemProducaoTintaImpresso(objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString,
            objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString)) Then
          Begin
            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('Não é possível alterar esse Documento, pois a ordem de produção de produtos tintométricos já foi impressa!');
            objLiberacao.objMsgLibera.pAddTextoCaption('Documento',
              objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
              objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
              objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString, 9);

            objLiberacao.objMsgLibera.pAddTextoCaption('Cliente',
              objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
              fRetNomCliente(objAltDoc.qryFatGor.FieldByName('FGO_CODCLI')
              .AsString), 9);

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

          If Result Then
          Begin
            blnMudarFoco := False;
            Result := fCarregarDocumento;
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

function TfrmFatCortarPedido.fValidaCfgVenPed: Boolean;
begin
  Result := False;
  if not VS_strHabilitarCRM then
    Exit;

  if not fEmptyStr(fCfgSis('VENPED')) then
    Exit;

  Result := True;
end;

procedure TfrmFatCortarPedido.FormCreate(Sender: TObject);
begin
  inherited;
  intSemaforoValidar := -1;
  objAltDoc := TAlterarPedido.Create(Self);

  objLiberacao := TLiberacao.Create;

  cdsDados := TUniClientDataSet.Create(Self);
  cdsDados.AfterInsert := pAfterInsert;
  cdsDados.BeforePost := pBeforePost;
  cdsDados.AfterOpen := pAfterOpen;

  cdsVendaBkp := TUniClientDataSet.Create(Self);
  dtsDados := fCriaDataSource(cdsDados);

  dbgItens.DataSource := dtsDados;

  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo := fTamDocCadRec;

  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa;
  edtEspDoc.Text := 'PD';

  strNumPed := '';
  strEspPed := '';
  strEmpPed := '';
  blnSucesso := False;
  blnApresentouMensagem := False;

  pCriaClientInfAdcItem;

  If fValidaCfgVenPed Then
  Begin
    pMensagemOk('A configuração "[CFG_VENPED] Tipo de Ocorrência - Venda - Pedido" deve ser informada para prosseguir!');
    blnFecharFormPai := True;
  End;

  pAddColunasGrid();
  mskCndPagAtu.EditMask := MASK_CONPAG;
end;

procedure TfrmFatCortarPedido.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(objAltDoc) Then
    FreeAndNil(objAltDoc);
  If Assigned(dtsDados) Then
    FreeAndNil(dtsDados);
  If Assigned(cdsDados) Then
    FreeAndNil(cdsDados);
  If Assigned(cdsVendaBkp) Then
    FreeAndNil(cdsVendaBkp);
  If Assigned(cdsInfAdcItem) Then
    FreeAndNil(cdsInfAdcItem);
  if Assigned(objLiberacao) Then
    FreeAndNil(objLiberacao);
end;

procedure TfrmFatCortarPedido.pReturnPressed;
begin
  If dbgItens.Focused Then
  Begin
    If cdsDados.State = dsEdit Then
      cdsDados.Post;

    If cdsDados.RecNo < cdsDados.RecordCount Then
    Begin
      cdsDados.Next;
      cdsDados.Edit;
    End
    Else
      pSetFocus(btnConfirma);
  End;
end;

function TfrmFatCortarPedido.fValidaEscape: Boolean;
begin
  Result := False;

  if (not fEmptyStr(strNumPed)) then
    Exit;

  if (not fEmptyStr(strEspPed)) then
    Exit;

  if (not fEmptyStr(strEmpPed)) then
    Exit;

  Result := True;
end;

procedure TfrmFatCortarPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F3: btnCopiarQtd.Click;
    VK_F10: btnConfirma.Click;
    VK_ESCAPE:
      If fValidaEscape Then
        pEscapePressed;
    VK_DELETE:
      If ssCtrl In Shift Then
        Key := 0;
    VK_RETURN: pReturnPressed;
  End;
End;

procedure TfrmFatCortarPedido.FormResize(Sender: TObject);
begin
  inherited;
  AjustarTamanhoDaColunaDescricaoDaGrid;
end;

procedure TfrmFatCortarPedido.AjustarTamanhoDaColunaDescricaoDaGrid;
Var
  ColumnDescricao: TColumn;
  intColumn: Integer;
  intTamUti: Integer;

const
  intValMin: Integer = 390;
begin

  ColumnDescricao := fFindColumnByName(dbgItens, 'ITE_DESITE');

  if Assigned(ColumnDescricao) then
  begin
    intTamUti := 0;

    For intColumn := 0 To dbgItens.Columns.Count - 1 Do
      If (dbgItens.Columns[intColumn].Visible) Then
        If (dbgItens.Columns[intColumn].FieldName <> 'ITE_DESITE') Then
          Inc(intTamUti, dbgItens.Columns[intColumn].Width);

    If (dbgItens.Width - intTamUti - 43) >= intValMin Then
      ColumnDescricao.Width := (dbgItens.Width - intTamUti - 43)
    Else
      ColumnDescricao.Width := intValMin;
  end;

end;

function TfrmFatCortarPedido.fInformadoDocumento(): Boolean;
begin
  Result := False;
  if (fEmptyStr(strNumPed)) then
    Exit;

  if (fEmptyStr(strEspPed)) then
    Exit;

  if (fEmptyStr(strEmpPed)) then
    Exit;

  Result := True;
end;

procedure TfrmFatCortarPedido.FormShow(Sender: TObject);
begin
  inherited;

  If fInformadoDocumento Then
  Begin
    If (Not fCarregarDocumento(strNumPed, strEspPed, strEmpPed)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Carregamento do pedido para corte falhou. Operação cancelada!', ['&Ok']);

      blnSucesso := False;
      blnApresentouMensagem := True;
      PostMessage(Self.Handle, WM_CLOSE, 0, 0);
    End
    Else
    begin
      if not fCdsDadosHasData then
      begin
        fMensagem('ATENÇÃO!', 'Não existem produtos disponíveis para corte. Operação cancelada!', ['&Ok']);

        blnSucesso := False;
        blnApresentouMensagem := True;
        PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      end
      else
        pSetFocus(dbgItens);
    end;
  End;
end;

procedure TfrmFatCortarPedido.btnConfirmaClick(Sender: TObject);
begin
  If fCdsDadosHasData Then
    TfrmGravando.fExecutarModal(pConfirmar, 'Aguarde, Cortando documento...', '')
  Else
    pMensagemOk('É necessário selecionar um documento!');
end;

function TfrmFatCortarPedido.fEhEmissaoDocumentoWMS(strCodEmp: String): Boolean;
begin
  Result := False;

  if not fUsaRotinaWMS(strCodEmp) then
    Exit;

  if not MatchStr(edtEspDoc.Text, ['PD', 'OR', 'EF', 'OE']) then
    Exit;

  Result := True;
end;

function TfrmFatCortarPedido.fEmpresaParaFaturamentoUsaWMS(strCodEmp: String): Boolean;
begin
  If Not fPermiteInformarEmpresaNoItem(edtEspDoc.Text) Then
    Result := fEhEmissaoDocumentoWMS(strCodEmp)
  Else
  Begin
    if fEmptyStr(strCodEmp) then
      Exit(False);

    if not fUsaRotinaWMS(strCodEmp) then
      Exit(False);

    Result := True;
  End;
end;

procedure TfrmFatCortarPedido.pConfirmar;
begin
  inherited;
  If fQuantidadePendenteTodosItens Then
  Begin
    pMensagemOk('Não é possível cortar todos os produtos! A quantidade digitada em todos os produtos é igual a quantidade pendente! ');
    Exit;
  End;

  If fQuantidadeZeradaTodosItens Then
  Begin
    pMensagemOk('Favor informar a quantidade nos produtos antes de cortar o documento!');
    Exit;
  End;

  If Not fEmptyStr(strInRqCp) Then
  Begin
    objAltDoc.objVenda.strInRqCp := '';
    If objAltDoc.objVenda.cdsMovRcd.Active Then
      objAltDoc.objVenda.cdsMovRcd.EmptyDataSet;
  End;

  if PossuiAdiantamento() then
  begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Esse Documento possui adiantamento, será gerado um crédito para o cliente no valor dos produtos cortados!');
    objLiberacao.objMsgLibera.pAddTextoCaption('Documento',
      objAltDoc.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
      objAltDoc.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
      objAltDoc.qryFatGor.FieldByName('FGO_CODEMP').AsString, 9);

    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente',
      objAltDoc.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
      fRetNomCliente(objAltDoc.qryFatGor.FieldByName('FGO_CODCLI')
      .AsString), 9);

    // objLiberacao.strDirAce := 'ALTPDI';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    // objLiberacao.blnSempreVariavelUsuario := True;

    If not objLiberacao.fLibera Then
      Exit
  end;

  pCortarPedidos;
End;

procedure TfrmFatCortarPedido.pFecharCorteExpedicao(blnCortou: Boolean);
begin
  blnSucesso := blnCortou;
  btnSair.Click();
end;

procedure TfrmFatCortarPedido.pCortarPedidos;
begin
  objAltDoc.objVenda.blnManLib    := True;
  objAltDoc.objVenda.blnCortPD    := True;
  objAltDoc.objVenda.strNumOrc    := edtNumDoc.Text;
  objAltDoc.objVenda.strEspOrc    := edtEspDoc.Text;

  objAltDoc.pCarregaCondicao(objAltDoc.objVenda.strCodCnd, objAltDoc.qryFatGor.FieldByName('FGO_PREVIS').AsDateTime);

  If Not fEmptyStr(strInRqCp) Then
  Begin
    objAltDoc.objVenda.strInRqCp := strInRqCp;
    objAltDoc.objVenda.pCarregaItensMovRcd;
  End;

  objAltDoc.objVenda.pBackupExpRet(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text);

  pAcertarQuantidadeDocOriginal;

  If (fCfgSis('RECCND', varBoolean) And (objAltDoc.objVenda.strConPag <> '01999')) Then
  Begin
    objAltDoc.objVenda.pCalculaTaxVpr;

    If fCfgSis('CNDVEN') = 'F' Then
      objAltDoc.objVenda.fltTaxVpr := 0;
  End;

  If objAltDoc.fCalculaTotalPedido Then
  Begin
    if objAltDoc.fGravarPedido then
    begin
      pMensagemOk('Documento ' + edtNumDoc.Text + '-' + edtEspDoc.Text + ' alterado com sucesso!');
      pLimparTela;

      pFecharCorteExpedicao(True);
    end;
  End
  Else
  Begin
    pMensagemOk('Não foi possível alterar o documento ' + edtNumDoc.Text + '-' + edtEspDoc.Text + '!');

    pFecharCorteExpedicao(False);
  End;
end;

procedure TfrmFatCortarPedido.pCopiarQuantidadePendente;
begin
  Try
    cdsDados.DisableControls;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('ITE_QTDBAI').AsFloat := cdsDados.FieldByName('ITE_QTDITE').AsFloat;
      cdsDados.Post;
      cdsDados.Next;
    End;
    cdsDados.First;
  Finally
    cdsDados.EnableControls;
  End;
end;

function TfrmFatCortarPedido.fCarregarDocumento(strNumPed, strEspPed, strEmpPed: String): Boolean;
begin
  edtNumDoc.Text := strNumPed;
  edtEspDoc.Text := strEspPed;
  edtCodEmp.Text := strEmpPed;

  Result := fCarregarDocumento();
end;

procedure TfrmFatCortarPedido.pEditQuantidade;
begin
  cdsVenda.Edit;
  cdsVenda.FieldByName('ITE_QTDITE').AsFloat := cdsDados.FieldByName('ITE_QTDITE').AsFloat - cdsDados.FieldByName('ITE_QTDBAI').AsFloat;

  if cdsVenda.FieldByName('ITE_QTDEXP').AsFloat > cdsVenda.FieldByName('ITE_QTDBAI').AsFloat then
    cdsVenda.FieldByName('ITE_QTDEXP').AsFloat := cdsVenda.FieldByName('ITE_QTDBAI').AsFloat;

  if cdsVenda.FieldByName('ITE_QTDSEP').AsFloat > cdsVenda.FieldByName('ITE_QTDBAI').AsFloat then
    cdsVenda.FieldByName('ITE_QTDSEP').AsFloat := cdsVenda.FieldByName('ITE_QTDBAI').AsFloat;

  if fPrecisaAjustarEmbalagemTintaAutomotiva then
    cdsVenda.FieldByName('ITE_QTDEMB').AsFloat := cdsVenda.FieldByName('ITE_QTDBAI').AsFloat;

  cdsVenda.Post;
end;

procedure TfrmFatCortarPedido.pEscapePressed;
begin
  If (ActiveControl <> edtNumDoc) Then
    pLimparTela
  Else
    inherited;
end;

end.
