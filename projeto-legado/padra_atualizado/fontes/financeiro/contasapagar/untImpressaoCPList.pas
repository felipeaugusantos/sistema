unit untImpressaoCPList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, untTypesSistema, UniClientDataSet, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxProgressBar,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Uni, untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, untFastPrintEditor, untReciboCtr, untReciboCtrMeiaFolha, untRcxRecbBaixDocs, system.strUtils,
  untLiberacao, untMsgLiberacao, untConstantes;//MF: 286456 - 05/06/2023

type
  TfrmImpressaoCPList = class(TfrmPai)
    btnIniBus: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcaTodas: TBitBtnLocked;
    BtnSelecionadas: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    cxGridImpressao: TcxGridCitel;
    cxGridDBTableTitulos: TcxGridDBTableViewCitel;
    cxGridDBTableTitulosDUPLIC: TcxGridDBColumn;
    cxGridDBTableTitulosCODEMP: TcxGridDBColumn;
    cxGridDBTableTitulosNOMFOR: TcxGridDBColumn;
    cxGridDBTableTitulosNOMPOR: TcxGridDBColumn;
    cxGridDBTableTitulosDTACAD: TcxGridDBColumn;
    cxGridDBTableTitulosDTAVEN: TcxGridDBColumn;
    cxGridDBTableTitulosVALORI: TcxGridDBColumn;
    cxGridDBTableTitulosTOTDUP: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    cxGridDBTableTitulosMARDES: TcxGridDBColumn;
    cxGridDBTableTitulosESPDOC: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure BtnSelecionadasClick(Sender: TObject);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcaTodasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridDBTableTitulosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    FqryTitulos: TZClient;
    strValorFiltro,
    strCampoFiltro: String;
    blntemRegLDSelecionado : Boolean;

    cdsImpRec : TUniClientDataSet;
    editorFast: TFastPrintFileEditor;
    reciboCtr : TReciboCtr;
    reciboCtrMeiaFolha : TReciboCtrMeiaFolha;

    objLiberacao : TLiberacao;//MF: 286456 - 05/06/2023

    procedure pMarca;
    procedure pMarcaDesmarca(blnMarca: Boolean);
    procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
    procedure pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure pAfterOpen(DataSet: TDataSet);

    function fImprimindoCPTitulos(pgbStatus: TcxProgressBar = Nil): Boolean;

    function fImprimindoRegistrosLD(pgbStatus: TcxProgressBar = Nil): Boolean;

    function fImprimeReciboLayout(vltCreditoTroco: Double;
                                  vltTotalRecebido: Double;
                                  strNomFil: String = '';
                                  strTipImp : String = ''): Boolean;

    procedure pImprimeReciboLD(strSeqCon, strCodEmp, strNumDup : String);
    procedure ImprimeLD(strNumDup, strSeqCon, strCodEmp: String);
    function fGetSQlLancLD: String;
    function pVerificaRegistrosEspDiferentesSelecionados: Boolean;
    function fVerificaReimpressaoCP(cdsTmp: TUniClientDataSet): Boolean;
  public
    { Public declarations }
    BlnVisLC : Boolean;
  published
    property qryTitulos: TZClient Read FqryTitulos Write FqryTitulos;
  end;

var
  frmImpressaoCPList: TfrmImpressaoCPList;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCadPag, untGravando, untBaixaCtpBusca,
  untConsDuplicSelec,untFuncoes;

procedure TfrmImpressaoCPList.btnConfirmaClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    If blnVisLC Then
    Begin
       If pVerificaRegistrosEspDiferentesSelecionados Then
       Begin
          fMensagem('ATENÇÃO!', 'Existem registros selecionados que possuem layouts diferentes para impressão!', ['&O k']);
          Exit;
       End;
    End;

    pCriarFormularios(TfrmGravando, frmAguarde);
    If (blnVisLC And blntemRegLDSelecionado) Then
       frmAguarde.fExecutarAcao := fImprimindoRegistrosLD
    Else
       frmAguarde.fExecutarAcao := fImprimindoCPTitulos;
    frmAguarde.ShowModal;
    pFreeAndNil(frmAguarde);
  Except
    On E : Exception Do
      pMensagensErro(E.Message, '[TfrmImpressaoCPList.btnConfirmaClick]');
  End;
end;

procedure TfrmImpressaoCPList.btnDesmarcaTodasClick(Sender: TObject);
begin
  inherited;

  pMarcaDesmarca(False);
end;

procedure TfrmImpressaoCPList.btnIniBusClick(Sender: TObject);
  Var
    frmBaixaCtpBusca : TfrmBaixaCtpBusca;
begin
  Try
    pCriarFormularios(TfrmBaixaCtpBusca, frmBaixaCtpBusca);
    if frmBaixaCtpBusca.ShowModal = mrOk then
    begin
      If fEmptyStr(frmBaixaCtpBusca.objFiltro.strValor) Then
        exit;

        strValorFiltro := frmBaixaCtpBusca.objFiltro.strValor;
        strCampoFiltro := frmBaixaCtpBusca.objFiltro.strCampo;

        If Not qryTitulos.FindFirst Then
          fMensagem('ATENÇÃO!', 'Não há duplicatas para serem impressas os CPs!', ['&O k']);

    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmImpressaoCPList.btnIniBusClick]');
    End;
  End;

  pFreeAndNil(frmBaixaCtpBusca);
  pSetFocus(cxGridImpressao);
end;

procedure TfrmImpressaoCPList.btnLocProxClick(Sender: TObject);
begin
  inherited;
  If (Not qryTitulos.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    If Not qryTitulos.FindNext Then
      fMensagem('ATENÇÃO!', 'Não há duplicatas para serem impressas os CPs!', ['&O k']);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);
end;

procedure TfrmImpressaoCPList.btnMarcarTodasClick(Sender: TObject);
begin
  inherited;

  pMarcaDesmarca(True);
end;

procedure TfrmImpressaoCPList.BtnSelecionadasClick(Sender: TObject);
begin
  inherited;
  If Not qryTitulos.IsEmpty Then
    frmConsDuplicSelec.pMostraDuplicatasSelecionadas('CADPAG', qryTitulos);
end;

procedure TfrmImpressaoCPList.cxGridDBTableTitulosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridDBTableTitulosMARDES.Index] = 'M') Then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clBlue;
  End;
end;

//MF: 286456 - 06/06/2023
function TfrmImpressaoCPList.fVerificaReimpressaoCP(cdsTmp: TUniClientDataSet): Boolean;
Var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha: TLinhaMsgLibera;
  blnReimpressao: Boolean;
begin
  Result := True;

  cdsTmp.First;
  cdsTmp.Filter := 'CTP_MARDES = ' + QuotedStr('M');
  cdsTmp.Filtered := True;

  blnReimpressao := False;

  While not cdsTmp.Eof Do
  Begin
    blnReimpressao := fCPJaImpresso(cdsTmp.FieldByName('NRODUP').AsString,
                                      cdsTmp.FieldByName('CTP_PARCEL').AsString,
                                      cdsTmp.FieldByName('CTP_SERIE_').AsString,
                                      cdsTmp.FieldByName('CTP_CODEMP').AsString,
                                      cdsTmp.FieldByName('CTP_CODFOR').AsString);

    If (blnReimpressao) Then
    Begin
      Break;
    End;

    cdsTmp.Next;
  End;

  if (blnReimpressao) Then
  Begin
    If (Not fVerificaAcessoSistema('RMPCPG', strLoginUsuarioLogado)) Then
    Begin
      objLiberacao.Clear;

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'DOCUMENTO'       , 17 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'EMP'             , 4  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'FORNECEDOR'      , 42 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'DT.VENC.'        , 8  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'DT.CAD.'         , 8  , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'VR.DUPLICATA'    , 13 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      cdsTmp.First;
      While not cdsTmp.Eof Do
      Begin
        blnReimpressao := fCPJaImpresso(cdsTmp.FieldByName('NRODUP').AsString,
                                        cdsTmp.FieldByName('CTP_PARCEL').AsString,
                                        cdsTmp.FieldByName('CTP_SERIE_').AsString,
                                        cdsTmp.FieldByName('CTP_CODEMP').AsString,
                                        cdsTmp.FieldByName('CTP_CODFOR').AsString);

        if (blnReimpressao) Then
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('DOCUMENTO'       ,  fPadR(cdsTmp.FieldByName('NRODUP').AsString,12)
                                                 + cdsTmp.FieldByName('CTP_PARCEL').AsString + '-'
                                                 + cdsTmp.FieldByName('CTP_SERIE_').AsString                              , 17 , alEsquerda );
          objLinha.pAddColuna('EMP'             ,  cdsTmp.FieldByName('CTP_CODEMP').AsString                              , 4  , alCentro   );
          objLinha.pAddColuna('FORNECEDOR'      ,  cdsTmp.FieldByName('NOMFOR').AsString                                  , 42 , alEsquerda );
          objLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',cdsTmp.FieldByName('CTP_DTAVEN').AsDateTime) , 8  , alCentro   );
          objLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',cdsTmp.FieldByName('DTACAD').AsDateTime)     , 8  , alCentro   );
          objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(cdsTmp.FieldByName('TOTDUP').AsFloat, ffNumber, 9, 2)      , 13 , alDireita  );
          objTabela.lstLinhas.Add(objLinha);
        End;

        cdsTmp.Next;
      End;

      objLiberacao.objMsgLibera.pAddTexto('Não é permitido reimprimir Comprovante de Pagamento');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddSeparador(140);
      objLiberacao.objMsgLibera.pAddTexto('TÍTULOS SELECIONADOS JÁ IMPRESSOS:', alCentro, teAmbos, '',140);
      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      Result := False;

      While (True) Do
      Begin
        objLiberacao.strDirAce              := 'RMPCPG';
        objLiberacao.strMsgSen              := 'Reimprimir Comprovante de Pagamento';
        objLiberacao.strSenLib              := fCfgSis('SENFVU');
        objLiberacao.tipCliFor              := cfFornecedor;
        objLiberacao.blnMosMen              := True;
        objLiberacao.strCodOpe              := strLoginUsuarioLogado;
        objLiberacao.strCodDig              := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.strTitulo := 'Não é permitido reimprimir Comprovante de Pagamento';

        If (objLiberacao.fLibera) Then
        Begin
          Result := True;
          Break;
        End;

        If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
          Break;
      End;
      pRemoveLiberacao('RMPCPG','');
    End;

  End;
end;

function TfrmImpressaoCPList.fImprimindoCPTitulos(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    cdsClone: TUniClientDataSet;
begin
  Result := True;

  pInformacao('Aguarde... Imprimindo CPs dos Títulos.', pgbStatus);

  cdsClone := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsClone, FqryTitulos);

  cdsClone.Filtered := False;
  cdsClone.Filter   := 'CTP_MARDES = ' + QuotedStr('M');
  cdsClone.Filtered := True;

  If Not cdsClone.IsEmpty Then
  Begin

    //MF: 286456 - 05/06/2023 - INI
    if (Not fVerificaReimpressaoCP(cdsClone)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido reimprimir Comprovante de Pagamento!', ['&Ok']);
      Exit;
    End;
    //MF: 286456 - 05/06/2023 - FIM

    pProgresso(0, cdsClone.RecordCount, pgbStatus);

    cdsClone.First;

    While Not cdsClone.Eof Do
    Begin
      ImprimeCP(cdsClone.FieldByName('NRODUP').AsString,
                cdsClone.FieldByName('CTP_PARCEL').AsString,
                cdsClone.FieldByName('CTP_CODEMP').AsString,
                cdsClone.FieldByName('CTP_CODFOR').AsString,
                cdsClone.FieldByName('CTP_SERIE_').AsString,
                'frmImpressaoCP',//MF: 286456 - 02/06/2023
                True); //MF: 286456 - 02/06/2023

      //If (Not blnReimpressao) Then
      //  pEfetuaImpressao(blnReimpressao, 'frmImpressaoCP');//MF: 286456 - 05/06/2023

      pProgresso(cdsClone.RecNo, cdsClone.RecordCount, pgbStatus);
      cdsClone.Next;
    End;

    pEfetuaImpressao(True, 'frmImpressaoCP'{, cdsClone.RecordCount > 1}); //MF: 286456 - 05/06/2023

    FreeAndNil(cdsClone);

    fMensagem('ATENÇÃO!', 'CPs dos títulos impressos com sucesso!', ['&O k']);
    Close;
  End
  Else
    fMensagem('ATENÇÃO!', 'Marque pelo menos um título para realizar a impressão do CP!', ['&O k']);
end;

function TfrmImpressaoCPList.fImprimindoRegistrosLD(pgbStatus: TcxProgressBar): Boolean;
  Var
    cdsClone: TUniClientDataSet;
begin
  Result := True;

  pInformacao('Aguarde... Imprimindo Registros.', pgbStatus);

  cdsClone := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsClone, FqryTitulos);

  cdsClone.Filtered := False;
  cdsClone.Filter   := 'CTP_MARDES = ' + QuotedStr('M');
  cdsClone.Filtered := True;

  If Not cdsClone.IsEmpty Then
  Begin
    pProgresso(0, cdsClone.RecordCount, pgbStatus);

    With cdsClone Do
    Begin
      First;

      While Not Eof Do
      Begin
        ImprimeLD(FieldByName('CTP_NUMDUP').AsString,
                  FieldByName('SEQCON').AsString,
                  FieldByName('CTP_CODEMP').AsString);

        pProgresso(RecNo, RecordCount, pgbStatus);
        Next;
      End;
    End;

    FreeAndNil(cdsClone);

    fMensagem('ATENÇÃO!', 'Registros impressos com sucesso!', ['&O k']);
    Close;
  End
  Else
    fMensagem('ATENÇÃO!', 'Marque pelo menos um título para realizar a impressão!', ['&O k']);
end;

procedure TfrmImpressaoCPList.FormActivate(Sender: TObject);
begin
  inherited;

  cxGridDBTableTitulosESPDOC.Visible := IIF(BlnVisLc,True,False);

  pSetFocus(cxGridImpressao);
end;

procedure TfrmImpressaoCPList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(FqryTitulos);
end;

procedure TfrmImpressaoCPList.FormCreate(Sender: TObject);
begin
  inherited;

  FqryTitulos := TZClient.Create(Self);
  FqryTitulos.OnFilterRecord := pFilterRecord;
  FqryTitulos.AfterOpen      := pAfterOpen;
  cxGridDBTableTitulos.DataController.DataSource := FqryTitulos.dtsSource;

  objLiberacao := TLiberacao.Create; //MF: 286456 - 05/06/2023
end;

procedure TfrmImpressaoCPList.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F5  : btnIniBus.Click;
    VK_F6  : btnLocProx.Click;
    VK_F7  : btnMarcarTodas.Click;
    VK_F8  : btnDesmarcaTodas.Click;
    VK_F9  : BtnSelecionadas.Click;
    VK_F10 : btnConfirma.Click;
    VK_RETURN: pMarca;
    VK_ESCAPE: Close;
  End;
end;

procedure TfrmImpressaoCPList.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('VALORI') <> nil Then
      TFloatField(FieldByName('VALORI')).DisplayFormat := '#,##0.00';

    If FindField('TOTDUP') <> nil Then
      TFloatField(FieldByName('TOTDUP')).DisplayFormat := '#,##0.00';

    If FindField('CTP_DTAVEN') <> nil Then
      FieldByName('CTP_DTAVEN').Alignment := taRightJustify;

    If FindField('DTACAD') <> nil Then
      FieldByName('DTACAD').Alignment := taRightJustify;
  End;
end;

procedure TfrmImpressaoCPList.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If Not fEmptyStr(strCampoFiltro) Then
  begin
    if CompareText(strCampoFiltro, 'TOTDUP') = 0 then
      Accept := CompareText(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) = 0
    else
      Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
  end;
end;

procedure TfrmImpressaoCPList.pInformacao(strInfo: String;
  pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInfo;
    Application.ProcessMessages;
  End;
end;

procedure TfrmImpressaoCPList.pMarca;
begin
  With qryTitulos Do
  Begin
    If Not IsEmpty Then
    Begin
      Edit;

      If FieldByName('CTP_MARDES').AsString = 'M' Then
        FieldByName('CTP_MARDES').AsString := 'D'
      Else
        FieldByName('CTP_MARDES').AsString := 'M';

      Post;
    End;
  End;
end;

procedure TfrmImpressaoCPList.pMarcaDesmarca(blnMarca: Boolean);
  Var
    intRecNo : Integer;
    prcScroll: TprcScroll;
begin
  With qryTitulos Do
  Begin
    intRecNo := RecNo;

    Try
      pDisableControls(qryTitulos, prcScroll);
      First;

      While Not Eof Do
      Begin
        Edit;
        FieldByName('CTP_MARDES').AsString := IIF(blnMarca, 'M', 'D');
        Post;

        Next;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, 'TfrmImpressaoCPList.pMarcaDesmarca');
    End;

    pEnableControls(qryTitulos, prcScroll);
    RecNo := intRecNo;
  End;
end;

procedure TfrmImpressaoCPList.pProgresso(intProgresso, intMaximo: Integer;
  pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Visible  := (intProgresso + intMaximo) > 0;
    pgbStatus.Position := intProgresso;
    pgbStatus.properties.Max := intMaximo;
    Application.ProcessMessages;
  End;
end;

function TfrmImpressaoCPList.fGetSQlLancLD: String;
  Var
    strSQL: String;
begin
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE           ';
    strSQL := strSQL + '  RCX_NUMDOC AS NUMDOC,        ';
    strSQL := strSQL + '  RCX_ESPDOC AS ESPDOC,        ';
    strSQL := strSQL + '  RCX_PARCEL AS PARCEL,        ';
    strSQL := strSQL + '  RCX_CODEMP AS CODEMP,        ';
    strSQL := strSQL + '  RCX_DESCRI AS HIST01,        ';
    strSQL := strSQL + '  NULL AS HIST02,              ';
    strSQL := strSQL + '  RCX_DTACAD AS DTACAD,        ';
    strSQL := strSQL + '  RCX_DTACAD AS DTAVEN,        ';
    strSQL := strSQL + '  RCX_DTACAD AS DTAREC,        ';
    strSQL := strSQL + '  CURRENT_TIME AS HORREC,      ';
    strSQL := strSQL + '  RCX_DESCRI AS DESCRI,        ';
    strSQL := strSQL + '  NULL AS CODCTA,              ';
    strSQL := strSQL + '  NULL AS DESCTA,              ';
    strSQL := strSQL + '  (                            ';
    strSQL := strSQL + '    IFNULL(RCX_VALDOC, 0)      ';
    strSQL := strSQL + '  ) * (-1) AS VALDOC,          ';
    strSQL := strSQL + '  RCX_VALDOC * (-1) AS VALORI, ';
    strSQL := strSQL + '  RCX_VALDOC * (-1) AS VALREC, ';
    strSQL := strSQL + '  0.00 AS VALDES,              ';
    strSQL := strSQL + '  0.00 AS VALJUR,              ';
    strSQL := strSQL + '  0.00 AS VALCOB,              ';
    strSQL := strSQL + '  0.00 AS DESCOB,              ';
    strSQL := strSQL + '  NULL AS CODCLI,              ';
    strSQL := strSQL + '  NULL AS NOSNUM,              ';
    strSQL := strSQL + '  RCX_SEQCON AS SEQCON,        ';
    strSQL := strSQL + '  RCX_CODOPE AS CODVEN,        ';
    strSQL := strSQL + '  NULL AS NOMCLI,              ';
    strSQL := strSQL + '  NULL AS ENDERE,              ';
    strSQL := strSQL + '  NULL AS BAIRRO,              ';
    strSQL := strSQL + '  NULL AS CIDADE,              ';
    strSQL := strSQL + '  NULL AS ESTADO,              ';
    strSQL := strSQL + '  NULL AS C_E_P_,              ';
    strSQL := strSQL + '  NULL AS C_G_C_,              ';
    strSQL := strSQL + '  NULL AS FONE01,              ';
    strSQL := strSQL + '  NULL AS F_A_X_,              ';
    strSQL := strSQL + '  NULL AS ENDNUM,              ';
    strSQL := strSQL + '  1 AS RESCAI,                 ';
    strSQL := strSQL + '  RCX_SEQCON AS CTR_SEQBAI,    ';
    strSQL := strSQL + '  RCX_CODEMP AS CTR_EMPBAI,    ';
    strSQL := strSQL + '  RCX_NUMDOC AS CTR_NUMDUP,    ';
    strSQL := strSQL + '  RCX_DESCRI AS CTR_HIST01,    ';
    strSQL := strSQL + '  NULL AS CTR_HIST02,          ';
    strSQL := strSQL + '  RCX_PARCEL AS CTR_PARCEL,    ';
    strSQL := strSQL + '  RCX_DTACAD AS CTR_DTAVEN,    ';
    strSQL := strSQL + '  RCX_VALDOC *(-1) AS CTR_VALDUP, ';
    strSQL := strSQL + '  RCX_DTACAD AS CTR_DTACAD,    ';
    strSQL := strSQL + '  RCX_ESPDOC AS CTR_ESPDOC,    ';
    strSQL := strSQL + '  RCX_CODEMP AS CTR_CODEMP,    ';
    strSQL := strSQL + '  RCX_VALDOC *(-1) AS CTR_VALREC, ';
    strSQL := strSQL + '  0.00 AS CTR_VALDES,          ';
    strSQL := strSQL + '  0.00 AS CTR_VALJUR,          ';
    strSQL := strSQL + '  NULL AS CTR_CODCLI,          ';
    strSQL := strSQL + '  NULL AS CTR_NOSNUM,          ';
    strSQL := strSQL + '  NULL AS CLI_NOMCLI,          ';
    strSQL := strSQL + '  NULL AS CLI_FONE01,          ';
    strSQL := strSQL + '  NULL AS CLI_F_A_X_,          ';
    strSQL := strSQL + '  RCX_SEQCON AS CTR_SEQCON,    ';
    strSQL := strSQL + '  RCX_DINREC *(-1) AS CTR_DINHEI, ';
    strSQL := strSQL + '  RCX_CHQAVI *(-1) AS CTR_CHQAVI, ';
    strSQL := strSQL + '  RCX_CHQPRE *(-1) AS CTR_CHQPRE, ';
    strSQL := strSQL + '  RCX_CARREC *(-1) AS CTR_CARTAO, ';
    strSQL := strSQL + '  RCX_ORDREC *(-1) AS CTR_ORDPAG, ';
    strSQL := strSQL + '  RCX_VALCRE AS CTR_CREDITO,   ';
    strSQL := strSQL + '  "D" AS CTR_MARDES,           ';
    strSQL := strSQL + '  0.00 AS CTR_JURSUJ,          ';
    strSQL := strSQL + '  0.00 AS CTR_DESSUJ,          ';
    strSQL := strSQL + '  RCX_CODOPE AS OPEBAI,        ';
    strSQL := strSQL + '  NULL AS CTR_PORBAI,          ';
    strSQL := strSQL + '  NULL AS RCX_CAIXA,           ';
    strSQL := strSQL + '  1 AS RESCAI,                 ';
    strSQL := strSQL + '  RCX_RECPIX AS RECPIX         ';
    strSQL := strSQL + 'FROM CADRCXX                   ';
    strSQL := strSQL + '  WHERE                        ';
    strSQL := strSQL + '     RCX_ESPDOC = "LD"         ';
    strSQL := strSQL + ' AND RCX_SEQCON = :SEQCON      ';
    strSQL := strSQL + ' AND RCX_CODEMP = :SEQEMP      ';
    strSQL := strSQL + ' AND RCX_NUMDOC = :NUMDOC      ';

    Result := strSQL;
End;

procedure TfrmImpressaoCPList.pImprimeReciboLD(strSeqCon, strCodEmp, strNumDup : String);
Var
    strSQL      : String;
    strRecRcx   : String;
    strDescri   : String;
    strNomPro   : String;
    strNomFil   : String;
    strTipImp   : String;
    blnImprimiu : Boolean;
    recValRec   : TRcxValoresReceb;
    arrCodCli   : Array Of TRcxDadosCliente;
    cdsChqVis   : TUniClientDataSet;
    cdsChqPre   : TUniClientDataSet;
    qryAuxImp   : TUniQuery;
    dblDinRec,
    dblCarRec,
    dblChqPre,
    dblChqVis,
    dblOrdRec,
    dblCreRec   : Double;
Begin

  Try
    //If intOpcao = 1 Then
    //   strRecRcx := 'L';
    //Else
    //   strRecRcx := fCfgSis('RECRCX');

    strRecRcx := 'L'; //Considerando a forma como está as impressoes de recibos no caixa;

    cdsChqVis := fCriaCdsCheques(Self);
    cdsChqPre := fCriaCdsCheques(Self);
    cdsImpRec := fCriaClientDatasetReciboCTR;

    If Not cdsImpRec.Active Then
       cdsImpRec.Open;

    cdsImpRec.EmptyDataSet;
    cdsImpRec.Filter   := '';
    cdsImpRec.Filtered := False;

    SetLength(arrCodCli, 0);

    dblDinRec := 0;
    dblCarRec := 0;
    dblChqPre := 0;
    dblChqVis := 0;
    dblOrdRec := 0;
    dblCreRec := 0;

    qryAuxImp := fCriaQuery(Nil);

    With cdsImpRec Do
    Begin

        strSQL := '';
        strSQL := fGetSQlLancLD();

        With qryAuxImp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('SEQCON').AsString := strSeqCon;
          ParamByName('SEQEMP').AsString := strCodEmp;
          ParamByName('NUMDOC').AsString := strNumDup;
          Open;
        End;

        Insert;

        FieldByName('CODCLI').AsString     := qryAuxImp.FieldByName('CODCLI').AsString;
        FieldByName('ESTADO').AsString     := qryAuxImp.FieldByName('ESTADO').AsString;
        FieldByName('DESCRI').AsString     := qryAuxImp.FieldByName('DESCRI').AsString;
        FieldByName('NOMCLI').AsString     := qryAuxImp.FieldByName('NOMCLI').AsString;
        FieldByName('FANSOB').AsString     := '';
        FieldByName('ENDERE').AsString     := qryAuxImp.FieldByName('ENDERE').AsString;
        FieldByName('ENDNUM').AsString     := qryAuxImp.FieldByName('ENDNUM').AsString;
        FieldByName('ENDCMP').AsString     := '';
        FieldByName('BAIRRO').AsString     := qryAuxImp.FieldByName('BAIRRO').AsString;
        FieldByName('C_E_P_').AsString     := qryAuxImp.FieldByName('C_E_P_').AsString;
        FieldByName('CIDADE').AsString     := qryAuxImp.FieldByName('CIDADE').AsString;
        FieldByName('C_G_C_').AsString     := qryAuxImp.FieldByName('C_G_C_').AsString;
        FieldByName('FONE01').AsString     := qryAuxImp.FieldByName('FONE01').AsString;
        FieldByName('SEQCON').AsString     := qryAuxImp.FieldByName('SEQCON').AsString;
        FieldByName('NUMDOC').AsString     := qryAuxImp.FieldByName('NUMDOC').AsString;
        FieldByName('ESPDOC').AsString     := qryAuxImp.FieldByName('ESPDOC').AsString;
        FieldByName('PARCEL').AsString     := qryAuxImp.FieldByName('PARCEL').AsString;
        FieldByName('CODEMP').AsString     := qryAuxImp.FieldByName('CODEMP').AsString;
        FieldByName('DTACAD').AsDateTime   := qryAuxImp.FieldByName('DTACAD').AsDateTime;
        FieldByName('DTAVEN').AsDateTime   := qryAuxImp.FieldByName('DTAVEN').AsDateTime;
        FieldByName('DTAREC').AsDateTime   := qryAuxImp.FieldByName('DTAREC').AsDateTime;
        FieldByName('HORREC').AsDateTime   := qryAuxImp.FieldByName('HORREC').AsDateTime;
        FieldByName('CODVEN').AsString     := qryAuxImp.FieldByName('CODVEN').AsString;
        FieldByName('VALJUR').AsFloat      := qryAuxImp.FieldByName('VALJUR').AsFloat;
        FieldByName('VALDES').AsFloat      := qryAuxImp.FieldByName('VALDES').AsFloat;
        FieldByName('VALDOC').AsFloat      := qryAuxImp.FieldByName('VALDOC').AsFloat;
        FieldByName('VALREC').AsFloat      := qryAuxImp.FieldByName('VALREC').AsFloat;
        FieldByName('VALORI').AsFloat      := qryAuxImp.FieldByName('VALORI').AsFloat;
        FieldByName('CODCTA').AsString     := qryAuxImp.FieldByName('CODCTA').AsString;
        FieldByName('DESCTA').AsString     := qryAuxImp.FieldByName('DESCTA').AsString;
        FieldByName('RCX_DESCRI').AsString := qryAuxImp.FieldByName('DESCRI').AsString;
        FieldByName('RCX_CAIXA').AsString  := qryAuxImp.FieldByName('RCX_CAIXA').AsString;
        FieldByName('RESCAI').AsString     := qryAuxImp.FieldByName('RESCAI').AsString;
        FieldByName('NOMCTA').AsString     := '';//strCta_Pg + ' - ' + fRetDescCentroCusto(strCta_Pg);
        FieldByName('NOMEVE').AsString     := '';//strCodEve + ' - ' + fRetNomEvento(strCodEve);
        FieldByName('OPEBAI').AsString     := qryAuxImp.FieldByName('OPEBAI').AsString;
        FieldByName('RECPIX').AsString     := qryAuxImp.FieldByName('RECPIX').AsString;

        dblDinRec := dblDinRec + qryAuxImp.FieldByName('CTR_DINHEI').AsFloat;
        dblCarRec := dblCarRec + qryAuxImp.FieldByName('CTR_CARTAO').AsFloat;
        dblChqPre := dblChqPre + qryAuxImp.FieldByName('CTR_CHQPRE').AsFloat;
        dblChqVis := dblChqVis + qryAuxImp.FieldByName('CTR_CHQAVI').AsFloat;
        dblOrdRec := dblOrdRec + qryAuxImp.FieldByName('CTR_ORDPAG').AsFloat;
        dblCreRec := dblCreRec + IIF(qryAuxImp.FieldByName('CTR_CREDITO').AsFloat < 0, qryAuxImp.FieldByName('CTR_CREDITO').AsFloat, 0);
        Post;

    End;

    With cdsImpRec Do
    Begin

      If Not IsEmpty Then
      Begin

        pCarregaConfImpr(qryCfgRel, 'frmRcxResumoCaixa_LC');
        If qryCfgRel.IsEmpty Then
          pCarregaConfImpr(qryCfgRel, 'frmRcxResumoCaixa');

        fPreImpressao(qryCfgRel, strNomFil, strTipImp, False);

        strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;

        If fEmptyStr(strNomPro) Then
           strNomPro := 'frmRcxResumoCaixa';

        {**************************************************}
        {* IMPRESSAO DO RECIBO CUSTOMIZADO DO FAST REPORT *}
        {***********************************************JU*}
        blnImprimiu := fImprimeReciboLayout(0,
                                            0,
                                            strNomFil,
                                            strTipImp);

        If Not blnImprimiu Then
        Begin
            Edit;
            FieldByName('DESCRI').AsString := strDescri;
            Post;

            recValRec.strDinRec := FloatToStrF(dblDinRec, ffFixed, 12, 2);
            recValRec.strCarRec := FloatToStrF(dblCarRec, ffFixed, 12, 2);
            recValRec.strChqPre := FloatToStrF(dblChqPre, ffFixed, 12, 2);
            recValRec.strChqVis := FloatToStrF(dblChqVis, ffFixed, 12, 2);
            recValRec.strOrdRec := FloatToStrF(dblOrdRec, ffFixed, 12, 2);
            recValRec.strCreRec := FloatToStrF(dblCreRec, ffFixed, 12, 2);

            blnCalculaTotais := False;  //mudar isso na refatoração dos recibos

            pImpRecBaiDoc(cdsImpRec,
                          strRecRcx,
                          FieldByName('SEQCON').AsInteger,
                          FieldByName('OPEBAI').AsString,
                          arrCodCli,
                          recValRec,
                          cdsChqPre,
                          cdsChqVis,
                          strNomPro,
                          strNomFil,
                          strTipImp,
                          (fCfgSis('RECRCX') = 'B'),
                          FieldByName('ESPDOC').AsString,
                          FieldByName('CODCTA').AsString,
                          '',
                          (FieldByName('RESCAI').AsInteger = 1));

        End;
      End;

    End;

    cdsImpRec.EmptyDataSet;
  Except
    On E: Exception Do
       pMensagensErro(E.Message, '[FrmImpressaoCPList.pImprimeReciboLD]');
  End;

End;

{**************************************************}
{* IMPRESSAO DO RECIBO CUSTOMIZADO DO FAST REPORT *}
{**************************************************}
function TfrmImpressaoCPList.fImprimeReciboLayout(vltCreditoTroco: Double;
                                                  vltTotalRecebido: Double;
                                                  strNomFil : String = '';
                                                  strTipImp : String = ''): Boolean;
begin

  editorFast := TFastPrintFileEditor.Create(Nil);

  If fCfgSis('RECCTR') = 'N' Then
  begin
    reciboCtr  := TReciboCtr.CreateInstance(cdsImpRec, vltCreditoTroco, vltTotalRecebido,Nil, True);
    editorFast.pSetFastPrintFile(reciboCtr);
    reciboCtr.pSetFastType(strTipImp);
  end
  else
  begin
    reciboCtrMeiaFolha  := TReciboCtrMeiaFolha.CreateInstance(cdsImpRec);
    editorFast.pSetFastPrintFile(reciboCtrMeiaFolha);
  end;

  //Abrindo impressora selecionada no autcom
  if strNomFil <> '' Then
     editorFast.pSelectFil(Self.Name, strNomFil, fRetNomeRede);

  Result := False;

  editorFast.intNumeroVias := fCfgSis('VIASLD', varInteger);

  If editorFast.fLoadReport Then
  Begin
     Result := True;

     If Not cdsImpRec.IsEmpty Then
        editorFast.pPrint;

  End;

  FreeAndNil(editorFast);
end;

procedure TfrmImpressaoCPList.ImprimeLD(strNumDup, strSeqCon, strCodEmp: String);
begin
  Try
    pImprimeReciboLD(strSeqCon,
                     strCodEmp,
                     strNumDup);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'Erro ao gerar impressão de LD !','[ImprimeLD]');
    End;
  End;
end;

Function TfrmImpressaoCPList.pVerificaRegistrosEspDiferentesSelecionados(): Boolean;
  Var
    cdsVer: TUniClientDataSet;
    blnTemLD,
    blnTemOutras : Boolean;
begin
  blnTemLD     := False;
  blnTemOutras := False;

  blntemRegLDSelecionado := False;

  Try
    cdsVer := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsVer, FqryTitulos);

    cdsVer.Filtered := False;
    cdsVer.Filter   := 'CTP_MARDES = ' + QuotedStr('M') + ' AND ESPDOC = ' + QuotedStr('LD');
    cdsVer.Filtered := True;

    If Not cdsVer.IsEmpty Then
    Begin
       blnTemLD := True;
       blntemRegLDSelecionado := True;
    End;

    cdsVer.Filtered := False;
    cdsVer.Filter   := 'CTP_MARDES = ' + QuotedStr('M') + ' AND ESPDOC <> ' + QuotedStr('LD');
    cdsVer.Filtered := True;

    If Not cdsVer.IsEmpty Then
       blnTemOutras := True;

    Result := (blnTemLD And blnTemOutras);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'Erro ao verificar registros selecionados !','[pVerificaRegistrosEspDiferentesSelecionados]');
    End;
  End;

End;

end.
