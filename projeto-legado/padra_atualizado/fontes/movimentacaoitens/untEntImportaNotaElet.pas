unit untEntImportaNotaElet;

interface

uses
  Windows, Messages, SysUtils, strUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdenaCxGrid, StdCtrls, ExtCtrls, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, System.UITypes, untFuncoesConsulta, untTypesSistema,
  EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons,
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider, frxClass, untTNFEToPedidoCompra,
  frxExportCSVTestabilidade, Datasnap.DBClient, untLiberacao, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxProgressBar, untGerarOrcamentoCompraAuto, untPreNota, Faturamento.Consignacao.Classes,
  untFuncoesSimples,  untFuncoes, untConstantes,  untPaiOrdena,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, untSaldoPedidoCompra, cxGrid,
  untFuncoesPedidoSimples, untZClient;

type
  TfrmEntImportaNotaElet = class(TfrmPaiOrdenaCxGrid)
    rdgStatus: TRadioGroup;
    rdgEmpNot: TRadioGroup;
    btnItens: TBitBtnLocked;
    btnImportar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    shpXmlPen: TShape;
    Label1: TLabel;
    btnDigManual: TBitBtnLocked;
    btnAltNot: TBitBtnLocked;
    btnRecuperarXML: TBitBtnLocked;
    btnImpEti: TBitBtnLocked;
    rdgTipXML: TRadioGroup;
    btnConDir: TBitBtnLocked;
    btnEntDir: TBitBtnLocked;
    btnGerarPedidoCompra: TBitBtnLocked;
    Label3: TLabel;
    DTAEMI: TcxGridDBColumn;
    SERIE_: TcxGridDBColumn;
    NUMDOC: TcxGridDBColumn;
    VALDOC: TcxGridDBColumn;
    CODFOR: TcxGridDBColumn;
    RAZSOC: TcxGridDBColumn;
    NOMFAN: TcxGridDBColumn;
    BAIXAD: TcxGridDBColumn;
    CODEMP: TcxGridDBColumn;
    lblPesquisa: TLabel;
    Label2: TLabel;
    C_G_C_: TcxGridDBColumn;
    MANUAL: TcxGridDBColumn;
    CSTCAD: TcxGridDBColumn;
    CONDIR: TcxGridDBColumn;
    ENTDIR: TcxGridDBColumn;
    edtDtaIni: TMaskEditFocus;
    edtDtaFin: TMaskEditFocus;
    edtCodIte: TEditFocus;
    btnExportaExcel: TBitBtnLocked;
    UF_FOR: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure rdgStatusClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure btnItensClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnDigManualClick(Sender: TObject);
    procedure btnAltNotClick(Sender: TObject);
    procedure btnRecuperarXMLClick(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure dbgConsultaExit(Sender: TObject);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure btnImpEtiClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConDirClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
    procedure btnEntDirClick(Sender: TObject);
    procedure btnGerarPedidoCompraClick(Sender: TObject);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure dbgConsultaDadosKeyPress(Sender: TObject; var Key: Char);
    procedure edtDtaFinExit(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure dbgConsultaDadosEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure btnExportaExcelClick(Sender: TObject);

  private
    { Private declarations }
    edtDescri: TEditFocus;
    arrCodIte: TConsultasArray;
    strOperador: String;
    blnUniCom: Boolean;
    objLiberacao : TLiberacao;

    FblnAcessadoViaRetornoConsignacao : Boolean;
    FblnChamarRetornoConsignacaoNovamente : Boolean;
    FblnAcessadoViaRetornoLocacao: Boolean;

    FstrNumDoc: String;
    FstrEspDoc: String;
    FstrNumSer: String;
    FstrCodEmp: String;
    FblnEntradaEfetivada: Boolean;
    FstrCodCli: String;

    Function fExcluiNota: Boolean;
    Function fExcluiMovEle(strAutInc, strAutIncPed: String): Boolean;
    Function fAtualizaEmpresaDaNota: Boolean;

    Function fLiberaConferencia: Boolean;
    Function fLiberaEntrada: Boolean;

    procedure pMarcaDesmarcaConferencia;
    procedure pMarcaDesmarcaEntrada;
    procedure pProcessaFinalizacaoRetornoLocacao;

    function fTemMovTriAmarrada: Boolean;

  public
    strAutoincrem : String;

    property blnAcessadoViaRetornoConsignacao     : Boolean read FblnAcessadoViaRetornoConsignacao     write FblnAcessadoViaRetornoConsignacao;
    property blnChamarRetornoConsignacaoNovamente : Boolean read FblnChamarRetornoConsignacaoNovamente write FblnChamarRetornoConsignacaoNovamente;
    property blnAcessadoViaRetornoLocacao         : Boolean read FblnAcessadoViaRetornoLocacao         write FblnAcessadoViaRetornoLocacao;
    property strNumDoc: String read FstrNumDoc;
    property strEspDoc: String read FstrEspDoc;
    property strNumSer: String read FstrNumSer;
    property strCodEmp: String read FstrCodEmp;
    property blnEntradaEfetivada: Boolean read FblnEntradaEfetivada;
    property strCodCli: String read FstrCodCli write FstrCodCli;

    { Public declarations }

    Class Function fExcluiNotaDivergencia(strAutInc: String): Boolean;
    procedure pAjustargTipXML;

  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; override;
 end;

implementation

{$R *.dfm}

Uses CheckLst, untEntImportacaoNotaEletronica, untEntNFEDigManual,
  untConsultas,
  untEntEtiquetas, untLibNfe, untFuncFat, untGravando, untFuncoesRel, untFuncoesRel2,
  untEntDigPedido,
  untExportaGridExcel;

function TfrmEntImportaNotaElet.fGetSql(blnLike: Boolean): String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT       ';
  strSQL := strSQL + '   DISTINCT              ';
  strSQL := strSQL + '   G.AUTOINCREM,         ';
  strSQL := strSQL + '   B09_DEMI   AS DTAEMI, ';
  strSQL := strSQL + '   B07_SERIE  AS SERIE_, ';
  strSQL := strSQL + '   B08_NNF    AS NUMDOC, ';
  strSQL := strSQL + '   IFNULL(GER_CONPAG, "01000") AS GER_CONPAG, ';
  strSQL := strSQL + '   W07_VPROD + IFNULL(W18_VSERV, 0) - W10_VDESC AS VALDOC, ';
  strSQL := strSQL + '   IF(GER_TIP_FC = "C", GER_CODCLI, GER_CODFOR) AS CODFOR, ';
  strSQL := strSQL + '   GER_CODCLI, ';
  strSQL := strSQL + '   GER_CODFOR, ';
  strSQL := strSQL + '   C04_XFANT  AS NOMFAN, ';
  strSQL := strSQL + '   C03_XNOME  AS RAZSOC, ';
  strSQL := strSQL + '   IF(GER_DOCENT IS NULL, "N", "S") AS BAIXAD, ';
  strSQL := strSQL + '   IF(IFNULL(GER_TIPENT, "E") = "M", "S", "N") AS MANUAL, ';
  strSQL := strSQL + '   GER_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   GER_CSTCAD AS CSTCAD, ';
  strSQL := strSQL + '   IFNULL(GER_CONDIR, "N") AS CONDIR, ';
  strSQL := strSQL + '   IFNULL(GER_ENTDIR, "N") AS ENTDIR, ';
  strSQL := strSQL + '   GER_TIP_FC, ';
  strSQL := strSQL + '   W08_VFRETE, ';
  strSQL := strSQL + '   W15_VOUTRO, ';
  strSQL := strSQL + '   W09_VSEG, ';
  strSQL := strSQL + '   PR07_CHNFE, ';
  strSQL := strSQL + '   X31_PESOL, ';
  strSQL := strSQL + '   X32_PESOB, ';
  strSQL := strSQL + '   X33_MODFRETE, ';
  strSQL := strSQL + '   X34_CNPJ, ';
  strSQL := strSQL + '   GER_DTALIB AS DTALIB, ';
  strSQL := strSQL + '   GER_DTACON AS DTACON, ';
  strSQL := strSQL + '   E02_CNPJ   AS C_G_C_,  ';
  strSQL := strSQL + '   "XML_OK" AS STATUS,    ';
  strSQL := strSQL + '   GER_PEDCOM, ';
  strSQL := strSQL + '   C12_UF AS ESTADO, ';
  strSQL := strSQL +     fSQLDescontoNotaXML + ' AS DESCONTO ';
  strSQL := strSQL + ', GER_MATREV AS MATREV ';

  strSQL := strSQL + ' FROM                    ';
  strSQL := strSQL + '   GERELE G              ';

  If Not fEmptyStr(edtCodIte.Text) Then
    strSQL := strSQL + 'INNER JOIN DETELE ON DETELE.DET_SEQGER = G.AUTOINCREM ';

  if not fEmptyStr(strAutoincrem) then
    strSQL := strSQL + ' WHERE AUTOINCREM = ' +  QuotedStr(strAutoincrem)
  else
  begin
    if fGetFinalidadeXML(rdgTipXML.Items[rdgTipXML.ItemIndex]) = Ord(tpeFinalidadeXML.xmlEntradaMercadoria) then
      strSQL := strSQL + ' WHERE GER_TIPXML IN ('+IntToStr(Ord(tpeFinalidadeXML.xmlEntradaMercadoria)) +','+ IntToStr(Ord(tpeFinalidadeXML.xmlNfeAjuste))+' )'
    else
      strSQL := strSQL + ' WHERE GER_TIPXML = ' + IntToStr(fGetFinalidadeXML(rdgTipXML.Items[rdgTipXML.ItemIndex]));

    Case rdgEmpNot.ItemIndex Of
      0: strSQL := strSQL + ' AND GER_CODEMP = ' + QuotedStr(VS_strCodEmp);
    End;

    Case rdgStatus.ItemIndex Of
      0: strSQL := strSQL + ' AND GER_DOCENT IS NULL';
      1: strSQL := strSQL + ' AND GER_DOCENT IS NOT NULL ';
    End;

    strSQL := strSQL + fStrLocate(edtCodIte, arrCodIte, 'DET_CODITE', 'CODITE');

    if Not fEmptyDate(edtDtaIni.text) Then
      If Not fEmptyDate(edtDtaFin.text) Then
        strSQL := strSQL + ' AND B09_DEMI BETWEEN :DTAINI AND :DTAFIN ';

    strSQL := strSQL + fStrLocate(edtCodIte, arrCodIte, 'DET_CODITE', 'CODITE');

    If (fCfgSis('XMLVAL', varInteger) = 2) Then
    Begin

      strSQL := strSQL + ' UNION ALL ';
      strSQL := strSQL + ' SELECT DISTINCT X.AUTOINCREM,   ';
      strSQL := strSQL + '        XML_DTAENI,     ';
      strSQL := strSQL + '        XML_SERIE_,     ';
      strSQL := strSQL + '        XML_NUMDOC,     ';
      strSQL := strSQL + '        "" AS GER_CONPAG, ';
      strSQL := strSQL + '        XML_VALTOT,     ';
      strSQL := strSQL + '        FOR_CODFOR,     ';
      strSQL := strSQL + '        FOR_CODFOR,     ';
      strSQL := strSQL + '        FOR_CODFOR,     ';
      strSQL := strSQL + '        FOR_NOMFAN,     ';
      strSQL := strSQL + '        FOR_NOMFOR,     ';
      strSQL := strSQL + '        "N" AS BAIXAD,  ';
      strSQL := strSQL + '        "N" AS MANUAL,  ';
      strSQL := strSQL + '        XML_CODEMP,     ';
      strSQL := strSQL + '        "" AS CSTCAD,   ';
      strSQL := strSQL + '        "N" AS CONDIR,  ';
      strSQL := strSQL + '        "N" AS ENTDIR,  ';
      strSQL := strSQL + '        NULL GER_TIP_FC,';
      strSQL := strSQL + '        NULL W08_VFRETE,';
      strSQL := strSQL + '        NULL W15_VOUTRO,';
      strSQL := strSQL + '        NULL W09_VSEG,  ';
      strSQL := strSQL + '        NULL PR07_CHNFE,';
      strSQL := strSQL + '        NULL X31_PESOL, ';
      strSQL := strSQL + '        NULL X32_PESOB, ';
      strSQL := strSQL + '        NULL X33_MODFRETE,';
      strSQL := strSQL + '        FOR_C_G_C_,     ';
      strSQL := strSQL + '        NULL AS DTALIB, ';
      strSQL := strSQL + '        NULL AS DTACON, ';
      strSQL := strSQL + '        FOR_C_G_C_,     ';
      strSQL := strSQL + '        "XML_ER" AS STATUS, ';
      strSQL := strSQL + '        GER_PEDCOM, ';
      strSQL := strSQL + '        CID_ESTADO AS ESTADO, ';
      strSQL := strSQL + '        NULL AS DESCONTO ';
      strSQL := strSQL + '        ,FOR_MATREV AS MATREV ';
      strSQL := strSQL + ' FROM XMLVAL X ';
      strSQL := strSQL + '   INNER JOIN CADFOR ON FOR_CODFOR = XML_CODFOR ';
      strSQL := strSQL + '   LEFT JOIN CADCID C ON FOR_CODCID = CID_CODCID ';
      strSQL := strSQL + ' WHERE XML_CODEMP = ' + QuotedStr(VS_StrCodEmp);

      if Not fEmptyDate(edtDtaIni.text) Then
        If Not fEmptyDate(edtDtaFin.text) Then
          strSQL := strSQL + ' AND XML_DTAENI BETWEEN :DTAINI AND :DTAFIN ';

    End;
  end;

  Result := strSQL;
End;

procedure TfrmEntImportaNotaElet.FormShow(Sender: TObject);
begin
  inherited;

  pnlHeader.Visible := fEmptyStr(strAutoincrem);

  blnSempreRelerBanco := FALSE;
  blnTemSelecao := FALSE;
  If fCfgSis('CONFME') = '2' Then
  Begin
    MANUAL.Visible := False;
    btnDigManual.Visible := False;
    btnAltNot.Visible    := False;
  End;

  pAjustargTipXML;

  fAbreConsulta(TRUE);

  pSetFocus(dbgConsulta);


end;

function TfrmEntImportaNotaElet.fSetParametros: Boolean;
Var
  strLinha: String;
begin
  Result := true;
  pSetaParam(edtCodIte.Text, arrCodIte, strLinha,  'CODITE', qryConsulta);
  If Not fEmptyDate(edtDtaIni.text) Then
    If Not fEmptyDate(edtDtaFin.text) Then
     pSetaParamPeriodo(edtDtaIni, edtDtaFin, qryConsulta);
end;

procedure TfrmEntImportaNotaElet.rdgStatusClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.State = dsEdit Then
  Begin
    cdsConsulta.Post;
  End;

  btnAltNot.Enabled := rdgTipXML.Items[rdgTipXML.ItemIndex] =  arrFinalidadeXML[xmlEntradaMercadoria];
  btnDigManual.Enabled := rdgTipXML.Items[rdgTipXML.ItemIndex] =  arrFinalidadeXML[xmlEntradaMercadoria];

  btnConDir.Enabled := rdgTipXML.Items[rdgTipXML.ItemIndex] =  arrFinalidadeXML[xmlEntradaMercadoria];
  btnEntDir.Enabled := rdgTipXML.Items[rdgTipXML.ItemIndex] =  arrFinalidadeXML[xmlEntradaMercadoria];
  btnGerarPedidoCompra.Enabled := True;
  If rdgStatus.ItemIndex <> 0 Then
    btnGerarPedidoCompra.Enabled := False;
  fAbreConsulta(TRUE);
end;

procedure TfrmEntImportaNotaElet.btnImpEtiClick(Sender: TObject);
begin
  inherited;

  If Not cdsConsulta.IsEmpty Then
    TfrmEntEtiquetas.pImpEtiXML(cdsConsulta.fieldByName('AUTOINCREM').AsString);
end;

procedure TfrmEntImportaNotaElet.pProcessaFinalizacaoRetornoLocacao;
var
  strCodCliGer: string;
begin
  If (strListIdGerEle.Count = 1) and
     (SameText(fCampoTabela('GER_CODEMP', 'GERELE', ['AUTOINCREM'], [strListIdGerEle.Strings[0]]), VS_StrCodEmp)) then
  Begin
    If fMensagem('', 'Importação do xml finalizada com sucesso. Deseja prosseguir com a entrada',  ['&Sim', '&Não'], 1) = 1 Then
    Begin
      strCodCliGer := fCampoTabela('GER_CODCLI', 'GERELE', ['AUTOINCREM'], [strListIdGerEle.Strings[0]], False);
      If FstrCodCli <> strCodCliGer Then
      Begin
        fMensagem('ATENÇÃO', 'O cliente do XML importado difere do cliente selecionado para o retorno de Locação.', ['&Ok']);
        Exit;
      End;

      If fVerificaAcessoSistema('frmEntDigPedido') Then
      Begin
        pCriarFormularios(TfrmEntDigPedido, frmEntDigPedido);
        Try
          frmEntDigPedido.blnAcessadoViaRetornoLocacao := True;
          frmEntDigPedido.pAjustarTelaEntradaRetornoLocacao;
          FblnEntradaEfetivada := frmEntDigPedido.blnEntradaEfetivada;
          If FblnEntradaEfetivada Then
          Begin
            FstrNumDoc := frmEntDigPedido.strNumDoc;
            FstrEspDoc := 'NF';
            FstrNumSer := frmEntDigPedido.strNumSer;
            FstrCodEmp := frmEntDigPedido.strCodEmp;

            fMensagem('', 'Entrada do documento xml importado realizada com sucesso!', ['&Ok']);
          End;
        Finally
          pFreeAndNil(frmEntDigPedido);
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO', 'Operador sem acesso à rotina de entrada de mercadorias.', ['&Ok']);
      End;
    End;
  End
  Else
  If strListIdGerEle.Count > 0 Then
  Begin
    fMensagem('', 'Importação do xml finalizada com sucesso!', ['&Ok']);
  End;
end;

procedure TfrmEntImportaNotaElet.btnImportarClick(Sender: TObject);
  var
    frmEntDigPedido : TfrmEntDigPedido;
begin
  inherited;

  strListIdGerEle.Clear;

  TfrmEntImportacaoNotaEletronica.fImportar(tpeFinalidadeXML(fGetFinalidadeXML(rdgTipXML.Items[rdgTipXML.ItemIndex])));

  if FblnAcessadoViaRetornoConsignacao then
  Begin
    FblnChamarRetornoConsignacaoNovamente := False;

    if (strListIdGerEle.Count = 1) and
       (SameText(fCampoTabela('GER_CODEMP', 'GERELE', ['AUTOINCREM'], [strListIdGerEle.Strings[0]]), VS_StrCodEmp)) then
    Begin
      If fMensagem('', 'Importação do xml finalizada com sucesso. Deseja prosseguir com a entrada - devolução?',  ['&Sim', '&Não'], 1) = 1 Then
      Begin
        if fVerificaAcessoSistema('frmEntDigPedido') then
        Begin
          pCriarFormularios(TfrmEntDigPedido, frmEntDigPedido);
          frmEntDigPedido.blnAcessadoViaRetornoConsignacao := True;
          frmEntDigPedido.TipoRetornoConsignacao           := ttrImportacaoXML;
          frmEntDigPedido.pCarregaNotaImportacao(strListIdGerEle.Strings[0]);
          pFreeAndNil(frmEntDigPedido);

          FblnChamarRetornoConsignacaoNovamente := True;
        End
        Else
        Begin
          fMensagem('ATENÇÃO', 'Operador sem acesso à rotina de entrada de mercadorias.', ['&Ok']);
        End;
      End
      Else
        FblnChamarRetornoConsignacaoNovamente := True;
    End
    Else
    Begin
      fMensagem('', 'Importação do xml finalizada com sucesso!', ['&Ok']);
      FblnChamarRetornoConsignacaoNovamente := True;
    End;
  End
  Else If FblnAcessadoViaRetornoLocacao Then
  Begin
    pProcessaFinalizacaoRetornoLocacao;
  End
  Else
  Begin
    rdgStatus.ItemIndex := 0;
    fAbreConsulta(TRUE);
  End;

end;

procedure TfrmEntImportaNotaElet.btnItensClick(Sender: TObject);
Var
  strMatRev: String;
begin
  inherited;

  If Not cdsConsulta.IsEmpty Then
  Begin

    If Assigned(prcExecutaRelatorio) Then
    begin
      strMatRev := cdsConsulta.FieldByName('MATREV').AsString; //fBuscaMatRevGerele

      If (fEmptyStr(strMatRev)) Then
        strMatRev := fCampoTabela('FOR_MATREV', 'CADFOR', ['FOR_CODFOR'],[fCampoTabela('GER_CODFOR', 'GERELE', ['AUTOINCREM'], [cdsConsulta.fieldByName('AUTOINCREM').AsString])]);

      prcExecutaRelatorio(115, 5924, [],
                          ['SEQGER','OPCREL'],
                          [cdsConsulta.fieldByName('AUTOINCREM').AsString,
                          IfThen(SameText(strMatRev, 'M'),'1','2')],
                          Sender,
                          nil,
                          True);
    End;


  End;

end;

procedure TfrmEntImportaNotaElet.btnRecuperarXMLClick(Sender: TObject);
  Var
    strNomeExe: String;
    strPath: String;
    strPathXml: String;
    arquivos: TSearchRec;
begin
  inherited;
  strPath := ExtractFilePath(Application.ExeName) + '\recuperarxml\';
  strNomeExe := strPath + 'RecuperarXML.exe';

  strPathXml := fCfgSisL('XMLPAT');

  If Not DirectoryExists(strPathXml) Then
  Begin
    fMensagem('', 'O Path para importação de XML não está definido. Favor definir. (CFG_XMLPAT)', ['&Ok']);
    Exit;
  End;

  If Not FileExists(strNomeExe) Then
  Begin
    fMensagem('', 'Não foi encontrado o arquivo ' + strNomeExe + '. Entre em contato com a Citel.', ['&Ok']);
    Exit;
  End;

  If fMensagem('', 'Os arquivos XML recuperados nesta rotina NÃO TEM validade de guarda.' + #13#10 +
    'Continue exigindo e armazenando o XML enviado pelo seu fornecedor.' + #13#10 +
    'Deseja continuar?', ['&Sim', '&Não']) = 2 Then
  Begin
    Exit;
  End;

  If fCriarProcesso(strNomeExe, True, tcpNormal) Then
  Begin
    If FindFirst(strPath + '*.xml', faArchive, arquivos) = 0 Then
    Begin
      Repeat
        If CopyFile(PChar(strPath + arquivos.Name), PChar(strPathXml + '\' + arquivos.Name), False) Then
          DeleteFile(PChar(strPath + arquivos.Name));
      Until FindNext(arquivos) <> 0;
    FindClose(arquivos);
    End;
  End;
end;

procedure TfrmEntImportaNotaElet.cdsConsultaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cdsConsultaAfterScroll(DataSet);
end;

procedure TfrmEntImportaNotaElet.cdsConsultaAfterPost(DataSet: TDataSet);
begin
  inherited;

  fAtualizaEmpresaDaNota;
  fAbreConsulta(True);

end;

procedure TfrmEntImportaNotaElet.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin
    If IsEmpty Then
      Exit;

    FieldByName('CODEMP').ReadOnly := FieldByName('BAIXAD').AsString = 'S';

    btnAltNot.Enabled    := (FieldByName('STATUS').AsString = 'XML_OK') and (FieldByName('BAIXAD').AsString = 'N');
    btnItens.Enabled     := (FieldByName('STATUS').AsString = 'XML_OK');
    btnConDir.Enabled    := (FieldByName('STATUS').AsString = 'XML_OK') and (FieldByName('BAIXAD').AsString = 'N');
    btnEntDir.Enabled    := (FieldByName('BAIXAD').AsString = 'N');
    btnExcluir.Enabled   := (FieldByName('BAIXAD').AsString = 'N');
    btnDigManual.Enabled := (FieldByName('BAIXAD').AsString = 'N');

  End;

end;

procedure TfrmEntImportaNotaElet.cdsConsultaBeforePost(DataSet: TDataSet);
begin
  inherited;

  With DataSet Do
  Begin

    If (Not fEmptyStr(FieldByName('CODEMP').AsString)) Then
    Begin
      FieldByName('CODEMP').AsString := fStrZero(FieldByName('CODEMP').AsString, 3);

      If fEmptyStr(fRetNomeEmpresa(FieldByName('CODEMP').AsString)) Then
      Begin
        pMensagemOk('Empresa ' + FieldByName('CODEMP').AsString + ' não encontrada!');
        Cancel;
        Abort;
      End;

      If Not fEmpresaAtiva(FieldByName('CODEMP').AsString) Then
      Begin
        pMensagemOk('Empresa ' + FieldByName('CODEMP').AsString + ' inativa no Cadastro de Empresas!');
        Cancel;
        Abort;
      End;

    End;

  End;

end;

procedure TfrmEntImportaNotaElet.dbgConsultaDadosEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
Var
  qryCadEmp: TUniQuery;
  arrEmp: TConsultasArray;
begin
  inherited;

  Case Key Of
    '/',
    '?': If (dbgConsultaDados.GetColumnByFieldName('CODEMP').Focused) And
            (Not dbgConsultaDados.GetColumnByFieldName('CODEMP').DataBinding.Field.ReadOnly) Then
         Begin

           qryCadEmp := fCriaQuery(Self);
           If fPesqEmpresasAtivas(conEmpSimples, Self, Nil, Nil, qryCadEmp, Key, arrEmp) Then
           Begin
             If cdsConsulta.State <> dsEdit Then
               cdsConsulta.Edit;

             cdsConsulta.FieldByName('CODEMP').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
             cdsConsulta.Post;
           End;
           FreeAndNil(qryCadEmp);
           Key := #0;
        End;
  End;
end;


procedure TfrmEntImportaNotaElet.dbgConsultaDadosKeyPress(Sender: TObject;
  var Key: Char);
Var
    qryCadEmp: TUniQuery;
    arrEmp: TConsultasArray;
begin
  inherited;

  Case Key Of
    '/',
    '?': If (dbgConsultaDados.GetColumnByFieldName('CODEMP').Focused) And
            (Not dbgConsultaDados.GetColumnByFieldName('CODEMP').DataBinding.Field.ReadOnly) Then
         Begin

           qryCadEmp := fCriaQuery(Self);
           If fPesqEmpresa(conEmpSimples, Self, Nil, Nil, qryCadEmp, Key, arrEmp) Then
           Begin
             If cdsConsulta.State <> dsEdit Then
               cdsConsulta.Edit;

             dbgConsultaDados.GetColumnByFieldName('CODEMP').DataBinding.Field.AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
             cdsConsulta.Post;
           End;

           FreeAndNil(qryCadEmp);
           Key := #0;
        End;
  End;
end;

procedure TfrmEntImportaNotaElet.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if (cdsConsulta.FieldByName('STATUS').AsString = 'XML_ER') Then
  Begin
    TDBGrid(Sender).Canvas.Brush.Color := shpXmlPen.Brush.Color;
    TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
  End;

end;

procedure TfrmEntImportaNotaElet.dbgConsultaExit(Sender: TObject);
begin
  inherited;

  If cdsConsulta.State = dsEdit Then
  Begin
    cdsConsulta.Post;
  End;

end;

procedure TfrmEntImportaNotaElet.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte,edtDescri, arrCodIte, nil, fRetNomProduto, 'do Produto');
  rdgStatusClick(Sender);
end;

procedure TfrmEntImportaNotaElet.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDescri, Nil, Key, arrCodIte, False, nil, 'Consulta de Itens', '1') Then
    rdgStatusClick(Sender);
end;

procedure TfrmEntImportaNotaElet.edtDtaFinExit(Sender: TObject);
begin
  inherited;
  fAbreConsulta(TRUE);
end;

procedure TfrmEntImportaNotaElet.FormCreate(Sender: TObject);
begin
  inherited;

  pnlTail.Visible := (fCfgSis('XMLVAL', varInteger) = 2);

  objLiberacao := TLiberacao.Create;


  FblnAcessadoViaRetornoConsignacao     := False;
  FblnChamarRetornoConsignacaoNovamente := False;

  edtDescri := TEditFocus.Create(nil);
end;

procedure TfrmEntImportaNotaElet.pAjustargTipXML;
  Var
    intIndex : tpeFinalidadeXML;
begin
  rdgTipXML.Items.Clear;
  For intIndex := Low(arrFinalidadeXML) To High(arrFinalidadeXML) Do
  Begin
    If intIndex = xmlRetornoSimbolico Then
      continue;

    If intIndex = xmlEntradaMercadoriaAuditoria Then
      continue;

    If intIndex = xmlGarantiaRecCliente Then
      If (not fCfgSis('ESP_AD', varBoolean)) and ((VS_strHabilitarCRM And fCfgSis('UTI_AD', varBoolean)) Or (not fCfgSis('GARANT', varBoolean))) Then
        continue;

    If intIndex = xmlConsertoEquipamento Then
      If fCfgSis('CONEQU', varString) <> 'S' Then
        continue;

    If intIndex = xmlGarantiaRetFornecedor Then
      If (fCfgSis('REFENT', varString) <> 'S') Or (not fCfgSis('GARANT', varBoolean)) Then
        continue;

    If intIndex =  xmlEntradaMercadoriasSistemaAnteriorDevolucao then
      If (fCfgSis('SISANT', varString) <> 'S') Then
        continue;

    If intIndex =  xmlRetornoLocacao then
      If fCfgSis('LOCEQU', varString) <> 'S' Then
        continue;

    If intIndex = xmlConsignacaoDevolucaoCliente Then
      If not((fCfgSis('CONSIG', varBoolean)) and (FblnAcessadoViaRetornoConsignacao)) Then
        continue;

    If intIndex = xmlDevolucaoEntradaEmitidaFornecedor Then
      If not (fCfgSis('DEVEFO', varBoolean)) Then
        continue;

    If intIndex = xmlCFG_IMPXGRGarantiaRetFornecedor Then
      If (fCfgSis('IMPXGR', varString) <> 'S') Then
        continue;

    rdgTipXML.Items.Add(arrFinalidadeXML[intIndex]);
  End;

  rdgTipXML.ItemIndex := 0;
  rdgTipXML.Columns := 1;
  If rdgTipXML.Items.Count > 5 Then
    rdgTipXML.Columns := 2;
End;

procedure TfrmEntImportaNotaElet.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  FreeAndNil(edtDescri);
  inherited;
end;

procedure TfrmEntImportaNotaElet.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F4    : btnGerarPedidoCompra.Click;

    VK_F5    : btnExportaExcel.Click;

    VK_F6    : If ssAlt In Shift Then
                 btnImpEti.Click
               Else
                 btnItens.Click;

    VK_F7    : If ssAlt In Shift Then
                 btnConDir.Click
               Else
                 btnImportar.Click;

    VK_F8    :  If ssAlt In Shift Then
                  btnEntDir.Click
                Else
                  btnDigManual.Click;

    VK_F9    : If ssAlt In Shift Then
                 btnExcluir.Click
               Else
                 btnRecuperarXML.Click;

    VK_RETURN: If dbgConsulta.Focused Then
               Begin
                 If cdsConsulta.State = dsEdit Then
                 Begin
                   cdsConsulta.Post;
                 End;
               End;

    VK_F10   : If dbgConsulta.Focused Then
                 btnAltNot.Click;
  End;
  
end;

Function TfrmEntImportaNotaElet.fExcluiMovEle(strAutInc, strAutIncPed: String): Boolean;
  Var
    qryGenEle: TUniQuery;
    qryPedidos: TUniQuery;
    strNumPed : String;
    strAutIncPedido: string;
Begin
  qryGenEle := fCriaQuery;
  qryPedidos := fCriaQuery;
  Try
    If Pos(',', strAutIncPed) > 0 Then
    begin
      strAutIncPed := AnsiReplaceStr(strAutIncPed, ',', '","');
      strAutIncPed := '"' + strAutIncPed + '"';
    End
    Else
      strAutIncPed := '"' + strAutIncPed + '"';

    strNumPed := '';
    With qryGenEle, SQL Do
    Begin
      If Not fLock_Unlock('NFE' + strAutInc, True, False, True) Then
      Begin
        fMensagem('', 'Esse Documento está sendo utilizado em outra Estação por ' +
                     fGetHostLock('NFE' + strAutInc)  + '!', ['&Ok']);
        Result := False;
        Exit;
      End;

      fStartTransaction();
      Clear;
      If  Not fEmptyStr(strAutIncPed) Then
      Begin
        qryPedidos.SQL.Clear;
        qryPedidos.SQL.Add(' SELECT AUTOINCREM ,CONCAT(PCG_NUMPED,"-", PCG_ESPDOC,"-", PCG_CODEMP) AS NUMPED ');
        qryPedidos.SQL.Add(' FROM PCMGER ');
        qryPedidos.SQL.Add(' WHERE AUTOINCREM IN(' + strAutIncPed + ')');
        qryPedidos.Open;

        while not qryPedidos.Eof do
        Begin
          If Not fEmptyStr(qryPedidos.FieldByName('NUMPED').AsString) Then
            strNumPed := qryPedidos.FieldByName('NUMPED').AsString;
          strAutIncPedido := qryPedidos.FieldByName('AUTOINCREM').AsString;
          Clear;
          Add(' SELECT COUNT(1) AS QTD ');
          Add(' FROM PCMGER ');
          Add(' WHERE AUTOINCREM = "'+strAutIncPedido+'" ');
          Add('    AND ((SELECT SUM(PCD_QTDBAI)  FROM PCMDET ');
          Add('          WHERE PCD_NUMPED = PCG_NUMPED ');
          Add('            AND PCD_CODEMP = PCG_CODEMP ');
          Add('            AND PCD_ESPDOC = PCG_ESPDOC ');
          Add('            AND PCD_CODFOR = PCG_CODFOR) = 0)');
          Open;

          If FieldByName('QTD').AsFloat = 1 Then
          Begin
            Clear;
            Add('DELETE FROM DEFBAI');
            Add(' WHERE DEF_AUTPCG = "'+strAutIncPedido+'"');
            ExecSQL;

            Clear;
            Add('DELETE FROM PCMGER');
            Add(' WHERE AUTOINCREM = "'+strAutIncPedido+'"');
            ExecSQL;
          End
          Else
          Begin
          fRollback;
          fMensagem('', 'Não é possivel excluir o registro pois, o pedido de compra '+strNumPed+ ' ' + #10#13 +
                        'vinculado a nota está baixado.', ['&Ok']);
          fLock_Unlock('NFE' + strAutInc, False, False, True);
            Result := False;
            Exit;
          End;
          qryPedidos.Next;
        End;
      End;

      Clear;
      Add('DELETE FROM GERELE WHERE AUTOINCREM = :AUTINC');
      ParamByName('AUTINC').AsString := strAutInc;
      ExecSQL;
      fCommit;

      fLock_Unlock('NFE' + strAutInc, False, False, True);
      Result := True;

    End;

    FreeAndNil(qryGenEle);
    FreeAndNil(qryPedidos)
  Except

    On E: Exception Do
    Begin
      fRollBack();
      fLock_Unlock('NFE' + strAutInc, False, False, True);
      Result := FALSE;
      pMensagensErro(E.Message, '[fExcluiMovEle]');
    End;

  End;
End;

Function TfrmEntImportaNotaElet.fExcluiNota: Boolean;
Begin
  Result := FALSE;

  With cdsConsulta Do
  Begin
    If Not Active Then
      EXit;

    If IsEmpty Then
      EXit;

    Try

      If fExcluiMovEle(FieldByName('AUTOINCREM').AsString,
                       cdsConsulta.FieldByName('GER_PEDCOM').AsString) Then
      Begin
        Delete;
        Result := TRUE;
      End;

    Except

      On E: Exception Do
      Begin
        Result := FALSE;
        pMensagensErro(E.Message, '[fExcluiNota]');
      End;

    End;

  End;

End;

Class function TfrmEntImportaNotaElet.fExcluiNotaDivergencia(strAutInc: String): Boolean;
  Var
    qryGenEle: TUniQuery;
Begin
  Try

    qryGenEle := fCriaQuery;
    With qryGenEle, SQL Do
    Begin

      Clear;
      Add('DELETE FROM XMLVAL WHERE AUTOINCREM = :AUTINC');
      ParamByName('AUTINC').AsString := strAutInc;
      ExecSQL;

    End;

    Result := TRUE;

  Except

    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, '[fExcluiNotaDivergencia]');
    End;

  End;
end;

procedure TfrmEntImportaNotaElet.btnAltNotClick(Sender: TObject);
  Var
    objNFEDig: TNFEDigManual;
begin
  inherited;

  If Not btnAltNot.Visible Then
    Exit;

  With cdsConsulta Do
  Begin
    If IsEmpty Then
      Exit;

    If FieldByName('MANUAL').AsString <> 'S' Then
    Begin
      pMensagemOk('Somente as notas digitadas manualmente podem ser alteradas!');
      Exit;
    End;

    If fieldByName('BAIXAD').AsString = 'S' Then
    Begin
      fMensagem('','Nota baixada não pode ser alterada!', ['&Ok']);
      Exit;
    End;

    objNFEDig := TNFEDigManual.Create(Self, tpeFinalidadeXML(fGetFinalidadeXML(rdgTipXML.Items[rdgTipXML.ItemIndex])));
    If objNFEDig.fAlteraNota(FieldByName('AUTOINCREM').AsString, FieldByName('CODFOR').AsString) Then
    Begin
      fAbreConsulta(TRUE);
      Locate('AUTOINCREM', objNFEDig.strAutInc, []);
    End;

    FreeAndNil(objNFEDig);
    
  End;

end;

Function TfrmEntImportaNotaElet.fLiberaConferencia: Boolean;
var
  intOpcao : Integer;
Begin
  With cdsConsulta Do
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('NOTA FISCAL ELETRÔNICA - CONFERÊNCIA DE PRODUTOS');
    objLiberacao.objMsgLibera.pAddQuebra;

    If FieldByName('CONDIR').AsString = 'S' Then
      objLiberacao.objMsgLibera.pAddTexto('Marcando a nota eletrônica para passar pela pré-nota antes da conferência')
    Else
      objLiberacao.objMsgLibera.pAddTexto('Enviando a nota eletrônica diretamente para conferência, sem passar pela pré-nota');

    objLiberacao.objMsgLibera.pAddSeparador(111);
    objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor'     , FieldByName('CODFOR').AsString + ' - ' + fRetNomFornecedor(FieldByName('CODFOR').AsString) , 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Documento'      , FieldByName('NUMDOC').AsString + '-NF-' + FieldByName('CODEMP').AsString                   , 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Data Emissão'   , FormatDateTime('DD/MM/YYYY', FieldByName('DTAEMI').AsDateTime)                             , 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor Contábil' , FormatFloat('#,##0.00', FieldByName('VALDOC').AsFloat)                                     , 14);
    objLiberacao.objMsgLibera.pAddSeparador(111);

    objLiberacao.strDirAce := 'CONDIR';
    objLiberacao.strMsgSen := 'Liberação para conferência direta';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;

    strOperador := objLiberacao.strOperador;

    If Result And (FieldByName('CONDIR').AsString = 'N') And (fCfgSis('CNVEMB') = 'S') Then
    Begin
      intOpcao  := fMensagem('', 'A Nota está em unidade de: ', ['&Compra', '&Venda'], 1, True);
      blnUniCom := intOpcao = 1;

      Result    := intOpcao > 0;
    End;

  End;
End;

Function TfrmEntImportaNotaElet.fLiberaEntrada: Boolean;
var
  intOpcao : Integer;
Begin
  With cdsConsulta Do
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('NOTA FISCAL ELETRÔNICA - CONFERÊNCIA DE PRODUTOS');
    objLiberacao.objMsgLibera.pAddQuebra;

    If FieldByName('ENTDIR').AsString = 'S' Then
      objLiberacao.objMsgLibera.pAddTexto('Marcando a nota eletrônica para passar pela pré-nota e/ou conferência')
    Else
      objLiberacao.objMsgLibera.pAddTexto('Enviando a nota eletrônica diretamente para entrada de mercadorias');

    objLiberacao.objMsgLibera.pAddSeparador(111);
    objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor'     , FieldByName('CODFOR').AsString + ' - ' + fRetNomFornecedor(FieldByName('CODFOR').AsString) , 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Documento'      , FieldByName('NUMDOC').AsString + '-NF-' + FieldByName('CODEMP').AsString                   , 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Data Emissão'   , FormatDateTime('DD/MM/YYYY', FieldByName('DTAEMI').AsDateTime)                             , 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor Contábil' , FormatFloat('#,##0.00', FieldByName('VALDOC').AsFloat)                                     , 14);
    objLiberacao.objMsgLibera.pAddSeparador(111);

    objLiberacao.strDirAce := 'ENTDIR';
    objLiberacao.strMsgSen := 'Liberação para entrada direta da mercadoria';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;

    strOperador := objLiberacao.strOperador;

    If Result And (FieldByName('ENTDIR').AsString = 'N') And (fCfgSis('CNVEMB') = 'S') Then
    Begin
      intOpcao  := fMensagem('', 'A Nota está em unidade de: ', ['&Compra', '&Venda'], 1, True);
      blnUniCom := intOpcao = 1;

      Result    := intOpcao > 0;
    End;

  End;
End;

procedure TfrmEntImportaNotaElet.pMarcaDesmarcaConferencia;
  Var
    qryGerEle: TUniQuery;
    intRecno: Integer;
Begin
  Try
    qryGerEle := fCriaQuery;

    With qryGerEle, SQL Do
    Begin
      Add('UPDATE GERELE SET ');
      Add('  GER_DTALIB = :DTALIB,');
      Add('  GER_HORLIB = :HORLIB,');
      Add('  GER_OPELIB = :OPELIB,');
      Add('  GER_UNICOM = :UNICOM,');
      Add('  GER_CONDIR = :CONDIR ');

      Add('WHERE AUTOINCREM = :AUTINC');

      If cdsConsulta.fieldByName('CONDIR').AsString = 'S' Then
      Begin
        ParamByName('CONDIR').AsString := 'N';

        ParamByName('DTALIB').Clear;
        ParamByName('HORLIB').Clear;
        ParamByName('OPELIB').Clear;
       End Else
      Begin
        ParamByName('CONDIR').AsString := 'S';

        ParamByName('DTALIB').AsDate   := VS_Date;
        ParamByName('HORLIB').AsTime   := fTime();

        If fEmptyStr(strOperador) Then
          strOperador := strLoginUsuarioLogado;

        ParamByName('OPELIB').AsString := strOperador;
      End;

      If blnUniCom Then
        ParamByName('UNICOM').AsString := 'S'
      Else
        ParamByName('UNICOM').AsString := 'N';

      ParamByName('AUTINC').AsString := cdsConsulta.fieldByName('AUTOINCREM').AsString;

      ExecSQL;
    End;

    FreeAndNil(qryGerEle);

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmEntImportaNotaElet.pMarcaDesmarcaConferencia]');
      Exit;
    End;

  End;

  intRecno := cdsConsulta.Recno;
  With cdsConsulta Do
  Begin
    Edit;

     If FieldByName('CONDIR').AsString = 'S' Then
       FieldByName('CONDIR').AsString := 'N'
     Else
       FieldByName('CONDIR').AsString := 'S';

    Post;
  End;
  cdsConsulta.Recno := intRecno;

  pMensagemOk('Opção de conferência atualizada com sucesso!');
End;

procedure TfrmEntImportaNotaElet.btnConDirClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.IsEmpty Then
    Exit;

  If (Not cdsConsulta.fieldByName('DTALIB').IsNull) And (cdsConsulta.fieldByName('CONDIR').AsString = 'N') Then
  Begin
    pMensagemOk('Já existe uma pré-nota para esse documento!');
    Exit;
  End;

  If (Not cdsConsulta.fieldByName('DTACON').IsNull) Then
  Begin
    pMensagemOk('Essa nota já foi conferida!');
    Exit;
  End;

  If ((fCfgSis('USACON', varBoolean) And (fConferenciaDepoisDaEntrada))) Or
     (fCfgSis('COMFLU', varBoolean)) Then
  Begin
    pMensagemOk('Necessário gerar o pedido de compra utilizar o botão [F4] Gerar Pedido de Compra!');
    Exit;
  End;
  blnUniCom := False;

  If fLiberaConferencia Then
    pMarcaDesmarcaConferencia;
end;

procedure TfrmEntImportaNotaElet.btnDigManualClick(Sender: TObject);
  Var
    objNFEDig: TNFEDigManual;
begin
  inherited;

  If Not btnDigManual.Visible Then
    Exit;

  If Not TNFEDigManual.fValidaProdutoConsumo Then
    Exit;

  objNFEDig := TNFEDigManual.Create(Self, tpeFinalidadeXML(fGetFinalidadeXML(rdgTipXML.Items[rdgTipXML.ItemIndex])));

  If objNFEDig.fAlteraNota Then
  Begin
    fAbreConsulta(TRUE);
    cdsConsulta.Locate('AUTOINCREM', objNFEDig.strAutInc, []);
  End;

  FreeAndNil(objNFEDig);
end;

procedure TfrmEntImportaNotaElet.pMarcaDesmarcaEntrada;
  Var
    qryGerEle: TUniQuery;
Begin
  Try
    qryGerEle := fCriaQuery;

    With qryGerEle, SQL Do
    Begin
      Add('UPDATE GERELE SET ');
      Add('  GER_DTALIB = :DTALIB,');
      Add('  GER_HORLIB = :HORLIB,');
      Add('  GER_OPELIB = :OPELIB,');
      Add('  GER_UNICOM = :UNICOM,');
      Add('  GER_ENTDIR = :ENTDIR ');

      Add('WHERE AUTOINCREM = :AUTINC');

      If cdsConsulta.fieldByName('ENTDIR').AsString = 'S' Then
      Begin
        ParamByName('ENTDIR').AsString := 'N';

        ParamByName('DTALIB').Clear;
        ParamByName('HORLIB').Clear;
        ParamByName('OPELIB').Clear;
      End Else
      Begin
        ParamByName('ENTDIR').AsString := 'S';

        ParamByName('DTALIB').AsDate   := VS_Date;
        ParamByName('HORLIB').AsTime   := fTime();

        If fEmptyStr(strOperador) Then
          strOperador := strLoginUsuarioLogado;

        ParamByName('OPELIB').AsString := strOperador;
      End;

      If blnUniCom Then
        ParamByName('UNICOM').AsString := 'S'
      Else
        ParamByName('UNICOM').AsString := 'N';

      ParamByName('AUTINC').AsString := cdsConsulta.fieldByName('AUTOINCREM').AsString;

      ExecSQL;
    End;

    FreeAndNil(qryGerEle);

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmEntImportaNotaElet.pMarcaDesmarcaEntrada]');
      Exit;
    End;

  End;

  With cdsConsulta Do
  Begin
    Edit;

     If FieldByName('ENTDIR').AsString = 'S' Then
       FieldByName('ENTDIR').AsString := 'N'
     Else
       FieldByName('ENTDIR').AsString := 'S';

    Post;
  End;

  pMensagemOk('Opção de entrada atualizada com sucesso!');
End;

procedure TfrmEntImportaNotaElet.btnEntDirClick(Sender: TObject);
begin
  inherited;

  If Not btnEntDir.Visible Then
    Exit;

  If cdsConsulta.IsEmpty Then
    Exit;

  If (Not cdsConsulta.fieldByName('DTALIB').IsNull) And (cdsConsulta.fieldByName('ENTDIR').AsString = 'N') Then
  Begin
    pMensagemOk('Já existe uma pré-nota para esse documento!');
    Exit;
  End;

  If (Not cdsConsulta.fieldByName('DTACON').IsNull) Then
  Begin
    pMensagemOk('Essa nota já foi conferida!');
    Exit;
  End;

  blnUniCom := False;

  If fLiberaEntrada Then
    pMarcaDesmarcaEntrada;

end;

function TfrmEntImportaNotaElet.fTemMovTriAmarrada: Boolean;
var qryValida: TUniQuery;
begin
  Result := False;
  qryValida := fCriaQuery;
  Try
    qryValida.SQL.Add('SELECT CONCAT("Num. Doc.: ", D.DET_NUMDOC,');
    qryValida.SQL.Add('              " Serie: ", D.DET_SERIE_,');
    qryValida.SQL.Add('              " Especie: ", EG.GER_ESPDOC,');
    qryValida.SQL.Add('              " Fornecedor: ", F.FOR_CODFOR, "-", F.FOR_NOMFOR,');
    qryValida.SQL.Add('              " Empresa: ",D.DET_CODEMP) AS DOCUMENTO');
    qryValida.SQL.Add('  FROM GERELE G');
    qryValida.SQL.Add(' INNER JOIN DETELE DE ON DE.DET_SEQGER = G.AUTOINCREM');
    qryValida.SQL.Add(' INNER JOIN MOVTRI T ON T.DET_AUTELE =  DE.AUTOINCREM');
    qryValida.SQL.Add(' INNER JOIN MOVDET D ON D.AUTOINCREM = T.DET_SEQGER');
    qryValida.SQL.Add(' INNER JOIN MOVGER EG ON EG.AUTOINCREM = D.DET_SEQGER');
    qryValida.SQL.Add(' INNER JOIN CADFOR F ON FOR_CODFOR = EG.GER_CODFOR');
    qryValida.SQL.Add(' WHERE G.AUTOINCREM = "' + cdsConsulta.FieldByName('AUTOINCREM').AsString + '"');
    qryValida.SQL.Add(' GROUP BY EG.AUTOINCREM');

    qryValida.Open;
    If Not qryValida.IsEmpty Then
    Begin
      fMensagem('','Esta nota esta vinculada com o documento: [' + qryValida.FieldByName('DOCUMENTO').AsString + ']', ['&Ok']);
      result := True;
    End;
  Finally
    FreeAndNil(qryValida);
  End;
End;

procedure TfrmEntImportaNotaElet.btnExcluirClick(Sender: TObject);
begin
  inherited;

  With cdsConsulta Do
  Begin
    If Not Active Then
      EXit;

    If IsEmpty Then
      EXit;

    If cdsConsulta.fieldByName('BAIXAD').AsString = 'S' Then
    Begin
      fMensagem('','Nota baixada não pode ser excluida!', ['&Ok']);
      Exit;
    End;

  End;

  If (cdsConsulta.fieldByName('STATUS').AsString = 'XML_OK') And fTemMovTriAmarrada then
    Exit;

  If fMensagem('','Confirma a exclusão da Nota ' + cdsConsulta.fieldByName('NUMDOC').AsString + ' ?', ['&Sim', '&Não'] ) = 1 Then
  Begin
    If (cdsConsulta.fieldByName('STATUS').AsString = 'XML_ER') Then
      fExcluiNotaDivergencia(cdsConsulta.fieldByName('AUTOINCREM').AsString)
    Else
      fExcluiNota;
  End;

  fAbreConsulta(TRUE);
end;

procedure TfrmEntImportaNotaElet.btnExportaExcelClick(Sender: TObject);
  Var
    objExportaExcel: TExportaGridExcel;
begin
  inherited;

  objExportaExcel := TExportaGridExcel.Create(Self, dbgConsultaDados);

  objExportaExcel.fExporta;

  FreeAndNil(objExportaExcel);
end;

procedure TfrmEntImportaNotaElet.btnGerarPedidoCompraClick(Sender: TObject);
begin
  inherited;

  If TNFEToPedidoCompra.fGeraPedidoCompra(cdsConsulta.fieldByName('AUTOINCREM').AsString, tpeNfeToPedidoCompra(ImpNotaEletronica)) Then
    fAbreConsulta(TRUE);

end;

Function TfrmEntImportaNotaElet.fAtualizaEmpresaDaNota: Boolean;
  Var
    qryGerEle: TUniQuery;
Begin
  Try

    qryGerEle := fCriaQuery;
    With qryGerEle, SQL Do
    Begin
      Clear;
      Add('UPDATE GERELE');
      Add('SET GER_CODEMP   = :CODEMP');
      Add('WHERE AUTOINCREM = :AUTINC');

      ParamByName('AUTINC').AsString := cdsConsulta.fieldByName('AUTOINCREM').AsString;
      ParamByName('CODEMP').AsString := cdsConsulta.fieldByName('CODEMP').AsString;

      If fEmptyStr(ParamByName('CODEMP').AsString) Then
        ParamByName('CODEMP').Clear;

      ExecSQL;

      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmEntImportaNotaElet.fAtualizaEmpresaDaNota]');
    End;
  End;

  FreeAndNil(qryGerEle);
End;

end.

