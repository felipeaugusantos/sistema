unit untRelFatPedVendaFaturados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Mask, MaskEditFocus, frxDesgn, frxClass, frxDBSet,
  frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS, frxExportTXT,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, Buttons, BitBtnLockedIncrem, untGeraExcel, untExcel, untFuncoesFactory,
  Uni, StrUtils, ComCtrls, frxExportRTF, frxExportCSVTestabilidade, untIFuncoes,
  untTypesSistema, Data.DB, untClassPanelCx;

type
  TfrmRelFatPedVendaFaturados = class(TfrmPaiRelatorio)
    Label5: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label6: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblConfirmacao2: TLabel;
    Label1: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label14: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    pgbProgresso: TProgressBar;
    Label2: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    lbl2: TLabel;
    edtCodRepresentante: TEditFocus;
    edtDesRepresentante: TEditFocus;
    lblDepVen: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    lbl4: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    lblMarca: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    lbl3: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    Label3: TLabel;
    edtCodProduto: TEditFocus;
    edtDesProduto: TEditFocus;
    Label4: TLabel;
    edtDocumento: TEditFocus;
    edtEspDoc: TEditFocus;
    Label7: TLabel;
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepresentanteExit(Sender: TObject);
    procedure edtCodRepresentanteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    arrClientes : TConsultasArray;
    arrRede     : TConsultasArray;
    arrEmpresa  : TConsultasArray;
    arrFornec   : TConsultasArray;
    arrVended   : TConsultasArray;
    arrRepres   : TConsultasArray;
    arrMarcas   : TConsultasArray;
    arrDepart   : TConsultasArray;
    arrProduto  : TConsultasArray;
    arrGrupos   : TConsultasArray;

    strClientes,
    strRede,
    strEmpresa,
    strFornec,
    strVended,
    strRepres,
    strMarcas,
    strGrupos,
    strDepart,
    strProduto  : String;

    function fSQLRelatorio: String;
    function fSQLWhere: String;
    procedure pSetParam(qryRel: TUniQuery);

    procedure pGeraExcel(qryRelatorio: TUniQuery);
    procedure pMontaResumo(Excel: TExcel;Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotais(Var Totais: TTotais; Dados: TDataSet);
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelFatPedVendaFaturados: TfrmRelFatPedVendaFaturados;

implementation

uses untConstantes;

{$R *.dfm}

procedure TfrmRelFatPedVendaFaturados.btnImprimirClick(Sender: TObject);
  Var
    qryRelatorio: TUniQuery;
begin
  If Not fVerificaCampos Then
    Exit;

  btnImprimir.Enabled := False;
  pnlDados.Enabled    := False;
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  qryRelatorio := fCriaQuery;

  With qryRelatorio Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fSQLRelatorio + fSQLWhere);

    pSetParam(qryRelatorio);
    Open;
  End;

  If Not qryRelatorio.IsEmpty Then
  Begin
    Try
      pGeraExcel(qryRelatorio);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a geração do excel)]');
    End;
  End
  Else
    pTabelaVazia;

  FreeAndNil(qryRelatorio);
  btnImprimir.Enabled := True;
  pnlDados.Enabled    := True;
  pnlInfo.Caption := '';
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelFatPedVendaFaturados.edtCodClienteExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodCliente,edtDesCliente,arrClientes,nil,fRetNomCliente,'do Cliente');
  If Not fEmptyStr(edtCodCliente.Text) Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
    pSetFocus(edtFornecedor);
  End Else
  Begin
    edtCodRede.Enabled := True;
    pSetFocus(edtCodRede);
  End;
end;

procedure TfrmRelFatPedVendaFaturados.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatPedVendaFaturados.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrDepart, fRetDescDepartamento, Nil, 'do Departamento do Vendedor');
end;

procedure TfrmRelFatPedVendaFaturados.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDepart, False) Then
  Begin
    If fValidaCampos(edtCodDep, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatPedVendaFaturados.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelFatPedVendaFaturados.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatPedVendaFaturados.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarcas, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmRelFatPedVendaFaturados.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarcas, False) Then
  Begin
    If fValidaCampos(edtCodMar, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatPedVendaFaturados.edtCodProdutoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodProduto,edtDesProduto, arrProduto,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmRelFatPedVendaFaturados.edtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodProduto, edtDesProduto, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    fValidaCampos(edtCodProduto,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatPedVendaFaturados.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
end;

procedure TfrmRelFatPedVendaFaturados.edtCodRedeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRedeLojas(Self, edtCodRede, edtDesRede, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRede, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatPedVendaFaturados.edtCodRepresentanteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRepresentante, edtDesRepresentante, arrRepres, fRetNomVendRep, nil, 'do Representante');
end;

procedure TfrmRelFatPedVendaFaturados.edtCodRepresentanteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fPesqOperador(Self, edtCodRepresentante, edtDesRepresentante, nil, Key, arrRepres, False)) Then
  Begin
    If fValidaCampos(edtCodRepresentante, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatPedVendaFaturados.edtCodVendedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVendedor, edtDesVendedor, arrVended, fRetNomVendRep, nil, 'do Vendedor');
end;

procedure TfrmRelFatPedVendaFaturados.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fPesqOperador(Self, edtCodVendedor, edtDesVendedor, Nil, Key, arrVended, False)) Then
  Begin
    If fValidaCampos(edtCodVendedor, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatPedVendaFaturados.edtDestinoExit(Sender: TObject);
begin
  //inherited;

end;

procedure TfrmRelFatPedVendaFaturados.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor, edtDesFornecedor, arrFornec, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmRelFatPedVendaFaturados.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtFornecedor, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatPedVendaFaturados.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelFatPedVendaFaturados.FormCreate(Sender: TObject);
begin
  inherited;
  blnExcel := True;
  pSetaCodIte(edtCodProduto);
end;

procedure TfrmRelFatPedVendaFaturados.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If ActiveControl Is TRadioButton Then
  Begin
    Case Key Of
      VK_Escape: btnSair.Click;
    End;
  End;
end;

procedure TfrmRelFatPedVendaFaturados.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

  edtDocumento.MaxLength := fTamDocCadRec;
  edtDocumento.TamCampo  := fTamDocCadRec;

  pSetFocus(mskDtaIni);
  shpMultSel.Visible := True;
  blnExcel := True;
end;

function TfrmRelFatPedVendaFaturados.fSQLRelatorio: String;
    function fSQLQtdIte: String;
    Begin
      Result := Result + ' (IFNULL((SELECT                                ';
      Result := Result + '    SUM(IFNULL(DET_QTDITE,0))                   ';
      Result := Result + '   FROM                                         ';
      Result := Result + '   MOVDET                                       ';
      Result := Result + ' WHERE DET_NUM_PD = FDO_NUMDOC                  ';
      Result := Result + '   AND DET_ESP_PD = FDO_ESPDOC                  ';
      Result := Result + '   AND DET_EMP_PD = FDO_CODEMP                  ';
      Result := Result + '   AND DET_CODITE = FDO_CODITE                  ';
      Result := Result + '   AND DET_IND_PD = FDO_SEQIND                  ';
      Result := Result + '   AND DET_ESPDOC <> "PR"                       ';
      Result := Result + ' GROUP BY DET_NUM_PD,                           ';
      Result := Result + '          DET_ESP_PD,                           ';
      Result := Result + '          DET_EMP_PD,                           ';
      Result := Result + '          DET_CODITE), 0))                      ';
    End;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   DET.DET_DTAENT AS DTAFAT, ';
  Result := Result + '   FDO_NUMDOC AS NUMPED, ';
  Result := Result + '   FDO_ESPDOC AS ESPPED, ';
  Result := Result + '   FDO_CODEMP AS EMPPED, ';
  Result := Result + '   DET.DET_NUMDOC AS DOCFAT, ';
  Result := Result + '   DET.DET_ESPDOC AS TIPFAT, ';
  Result := Result + '   DET.DET_CODEMP AS EMPFAT, ';
  Result := Result + '   V.OPE_CODOPE AS CODOPE, ';
  Result := Result + '   V.OPE_NOMOPE AS NOMVEN, ';
  Result := Result + '   D.OPE_CODOPE AS CODDIG, ';
  Result := Result + '   D.OPE_NOMOPE AS NOMDIG, ';
  Result := Result + '   CLI_CODCLI AS CODCLI, ';
  Result := Result + '   CLI_NOMCLI AS NOMCLI, ';
  Result := Result + '   ATC.ATI_CODATI AS CODATI, ';
  Result := Result + '   ATC.ATI_DESATI AS DESATI, ';
  Result := Result + '   CLI_BAIRRO AS BAIRRO, ';
  Result := Result + '   CID_NOMCID AS NOMCID, ';
  Result := Result + '   CID_ESTADO AS ESTADO, ';
  Result := Result + '   FOR_CODFOR AS CODFOR, ';
  Result := Result + '   FOR_NOMFOR AS NOMFOR, ';
  Result := Result + '   ATF.ATI_CODATI AS ATIFOR, ';
  Result := Result + '   ATF.ATI_DESATI AS ATIDES, ';
  Result := Result + '   ITE_CODITE AS CODITE, ';
  Result := Result + '   ITE_DESITE AS DESITE, ';
  Result := Result + '   (SELECT CADGRU.GRU_CODGRU FROM CADGRU WHERE CADGRU.GRU_CODGRU = CONCAT(LEFT(ITE_CODGRU, 3), "000")) AS CODLIN, ';
  Result := Result + '   (SELECT CADGRU.GRU_DESGRU FROM CADGRU WHERE CADGRU.GRU_CODGRU = CONCAT(LEFT(ITE_CODGRU, 3), "000")) AS DESLIN, ';
  Result := Result + '   (SELECT CADGRU.GRU_CODGRU FROM CADGRU WHERE CADGRU.GRU_CODGRU = ITE_CODGRU) AS CODGRU, ';
  Result := Result + '   (SELECT CADGRU.GRU_DESGRU FROM CADGRU WHERE CADGRU.GRU_CODGRU = ITE_CODGRU) AS DESGRU, ';
  Result := Result + '   MAR_CODMAR AS CODMAR, ';
  Result := Result + '   MAR_DESMAR AS DESMAR, ';
  Result := Result + '   FDO_TIPEMB AS TIPEMB, ';
  Result := Result + fSQLQtdIte + ' AS QTDITE, ';
  Result := Result + '  FDO_UNITAR - (IF(FDO_DESESP = 0.00, 0.00, (FDO_DESESP / FDO_QTDITE))) AS UNITAR, ';
  Result := Result + ' (IFNULL((SELECT                                ';
  Result := Result + '    SUM(DET_TOTITE - DET_DESESP)                ';
  Result := Result + '   FROM                                         ';
  Result := Result + '   MOVDET                                       ';
  Result := Result + ' WHERE DET_NUM_PD = FDO_NUMDOC                  ';
  Result := Result + '   AND DET_ESP_PD = FDO_ESPDOC                  ';
  Result := Result + '   AND DET_EMP_PD = FDO_CODEMP                  ';
  Result := Result + '   AND DET_CODITE = FDO_CODITE                  ';
  Result := Result + '   AND DET_IND_PD = FDO_SEQIND                  ';
  Result := Result + '   AND LEFT(DET_CLAFIS,1) >= 5                  ';
  Result := Result + ' GROUP BY DET_NUM_PD,                           ';
  Result := Result + '          DET_ESP_PD,                           ';
  Result := Result + '          DET_EMP_PD,                           ';
  Result := Result + '          DET_CODITE ), 0)) AS VALTOT,          ';
  Result := Result + '   ((' + fSQLQtdIte + ' * (FDO_TOTCUS / FDO_QTDITE)) / ' + fSQLQtdIte + ') AS UNICUS, ';
  Result := Result + '   (' + fSQLQtdIte + ' * (FDO_TOTCUS / FDO_QTDITE)) AS TOTCUS ';
  Result := Result + ' FROM ';
  Result := Result + '   FATDOR ';

  Result := Result + ' LEFT JOIN MOVDET DET ON DET.DET_NUM_PD  = FDO_NUMDOC AND ';
  Result := Result + '                         DET.DET_EMP_PD  = FDO_CODEMP AND ';
  Result := Result + '                         DET.DET_ESP_PD  = FDO_ESPDOC AND ';
  Result := Result + '                         DET.DET_CODITE  = FDO_CODITE AND ';
  Result := Result + '                         DET.DET_IND_PD  = FDO_SEQIND     ';

  Result := Result + '      JOIN FATGOR ON FATGOR.AUTOINCREM  = FDO_SEQGER ';
  Result := Result + '      JOIN CADOPE V   ON V.OPE_CODOPE   = FDO_CODVEN ';
  Result := Result + ' LEFT JOIN CADOPE D   ON D.OPE_CODOPE   = FDO_CODDIG ';
  Result := Result + '      JOIN CADCLI     ON CLI_CODCLI     = FDO_CODCLI ';
  Result := Result + ' LEFT JOIN CADATI ATC ON ATC.ATI_CODATI = CLI_CODATI ';
  Result := Result + ' LEFT JOIN CADCID     ON CID_CODCID     = CLI_CODCID ';
  Result := Result + ' LEFT JOIN CADATI ATF ON ATF.ATI_CODATI = CLI_CODATI ';
  Result := Result + ' LEFT JOIN CADMAR     ON MAR_CODMAR     = FDO_CODMAR ';
  Result := Result + '      JOIN CADITE     ON ITE_CODITE     = FDO_CODITE ';
  Result := Result + '      JOIN CADGRU GR  ON GR.GRU_CODGRU  = ITE_CODGRU ';
  Result := Result + ' LEFT JOIN CADFOR     ON FOR_CODFOR     = ITE_CODFOR ';
end;

function TfrmRelFatPedVendaFaturados.fSQLWhere: String;
begin
  Result := '';
  Result := Result + ' WHERE ';
  Result := Result + '   FDO_ESPDOC = "PD" AND ';
  Result := Result + '   FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
  Result := Result + '   FDO_CODITE <> :ITESER AND ';
  Result := Result + '   FDO_CODITE <> :SERTER AND ';
  Result := Result + '   FDO_VLRCON <> 0 ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    Result := Result + fStrLocate(edtCodEmpresa,arrEmpresa,'FDO_CODEMP','CODEMP')
  Else
    Result := Result + ' AND LOCATE(FDO_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

  If Not fEmptyStr(edtCodCliente.Text) Then
    Result := Result + fStrLocate(edtCodCliente,arrClientes,'FDO_CODCLI','CODCLI');

  If (Not fEmptyStr(edtCodRede.Text)) Then
    Result := Result + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

  Result := Result + fStrLocate(edtFornecedor, arrFornec, 'ITE_CODFOR', 'CODFOR');
  Result := Result + fStrLocate(edtCodVendedor, arrVended, 'FDO_CODVEN', 'CODVEN');
  Result := Result + fStrLocate(edtCodRepresentante, arrRepres, 'CLI_CODREP', 'CODREP');
  Result := Result + fStrLocate(edtCodMar, arrMarcas, 'FDO_CODMAR', 'CODMAR');
  Result := Result + fStrLocateLinGru(mskLinhaGrupo, arrGrupos, 'ITE_CODGRU', 'CODGRU');
  Result := Result + fStrLocate(edtCodDep, arrDepart, 'V.OPE_CODDEP', 'CODDEP');
  Result := Result + fStrLocate(edtCodProduto, arrProduto, 'FDO_CODITE', 'CODITE');

  If Not fEmptyStr(edtDocumento.Text) Then
    Result := Result + ' AND DET.DET_NUMDOC = :NUMDOC ';

  If Not fEmptyStr(edtEspDoc.Text) Then
    Result := Result + ' AND DET.DET_ESPDOC = :ESPDOC ';

  Result := Result + ' AND ((EXISTS (                                ';
  Result := Result + '    SELECT                                     ';
  Result := Result + '      DET_NUMDOC                               ';
  Result := Result + '    FROM                                       ';
  Result := Result + '      MOVDET                                   ';
  Result := Result + '    WHERE                                      ';
  Result := Result + '      DET_NUM_PD = FDO_NUMDOC AND              ';
  Result := Result + '      DET_ESP_PD = FDO_ESPDOC AND              ';
  Result := Result + '      DET_EMP_PD = FDO_CODEMP AND              ';
  Result := Result + '      DET_CODITE = FDO_CODITE                  ';
  Result := Result + '    LIMIT 1) AND ((FGO_MOTBAI IS NULL) OR (FGO_MOTBAI IS NOT NULL AND FDO_QTDBAI > 0)))';
  Result := Result + ' OR (FDO_QTDBAI > 0 AND FGO_MOTBAI IS NULL)  ';
  Result := Result + ' OR (FDO_JAFATU = 1 AND FGO_MOTBAI IS NULL)) ';
end;

function TfrmRelFatPedVendaFaturados.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
  Var
    intIndex: Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;
    End
    Else If (Sender = edtCodCliente) Then
    Begin
      if (fEmptyStr(edtCodCliente.Text)) then
        pDesmarcaLista(edtCodCliente,arrClientes);
    End
    Else If (Sender = edtCodRede) Then
    Begin
      if (fEmptyStr(edtCodRede.Text)) then
        pDesmarcaLista(edtCodRede,arrRede);
    End
    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
      	If Length(arrEmpresa) > 0 Then
        Begin
          For intIndex := Low(arrEmpresa) To High(arrEmpresa) Do
          Begin
            If Pos(arrEmpresa[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a Empresa ' + arrEmpresa[intIndex].strCodigo + '!', ['&O k']);
              Result := False;
              Break;
            End;
          End;
        End
        Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;

      If (fEmptyStr(edtCodEmpresa.Text)) Then
        pDesmarcaLista(edtCodEmpresa, arrEmpresa);
    End
    Else If (Sender = edtDestino) Then
    Begin
      If Not fEmptyStr(edtDestino.Text) Then
      Begin
        If (Pos(edtDestino.Text, 'E') <= 0) Then
        Begin
          fMensagem('', 'O destino deve ser (E)xcel!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('', 'Defina um destino!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelFatPedVendaFaturados.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo, edtDesGrupo, arrGrupos, fRetNomeLinhaGrupo, Nil, 'da Linha/Grupo', 6);
end;

procedure TfrmRelFatPedVendaFaturados.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, arrGrupos, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatPedVendaFaturados.pGeraExcel(qryRelatorio: TUniQuery);
  Var
    objGeraExcel: TGeraExcel;
    strNumDoc: String;
begin
  Try
    objGeraExcel := TGeraExcel.Create(qryRelatorio, pgbProgresso);

    With objGeraExcel Do
    Begin
      strNomRel := 'RELATÓRIO PEDIDO DE VENDA X FATURADO [*/**]';

      AddFiltro(fStrTitulo(edtCodVendedor.Text, edtDesVendedor, arrVended, strVended, 'VENDEDOR'));
      AddFiltro(fStrTitulo(edtCodRepresentante.Text, edtDesRepresentante, arrRepres, strRepres, 'REPRESENTANTE'));
      AddFiltro(fStrTitulo(edtCodDep.Text, edtDesDep, arrDepart, strDepart, 'DEPARTAMENTO DO VENDEDOR'));
      AddFiltro(fStrTitulo(edtCodCliente.Text, edtDesCliente, arrClientes, strClientes, 'CLIENTE'));
      AddFiltro(fStrTitulo(edtCodRede.Text, edtDesRede, arrRede, strRede, 'REDE DE LOJAS'));
      AddFiltro(fStrTitulo(edtFornecedor.Text, edtDesFornecedor, arrFornec, strFornec, 'FORNECEDOR'));
      AddFiltro(fStrTitulo(edtCodMar.Text, edtDesMar, arrMarcas, strMarcas, 'MARCA'));
      AddFiltro(fStrTitulo(mskLinhaGrupo.Text, edtDesGrupo, arrGrupos, strGrupos, 'LINHA/GRUPO'));
      AddFiltro(fStrTitulo(edtCodProduto.Text, edtDesProduto, arrProduto, strProduto, 'PRODUTO'));
      AddFiltro(fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA'));

      strNumDoc := edtDocumento.Text +
                   IfThen((Not fEmptyStr(edtDocumento.Text)) And (Not fEmptyStr(edtEspDoc.Text)), '-', '') +
                   edtEspDoc.Text;

      If Not fEmptyStr(strNumDoc) Then
        AddFiltro('DOCUMENTO: ' + strNumDoc)
      Else
        AddFiltro('DOCUMENTO: TODOS');

      AddFiltro('REFERENTE AO PERÍODO DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFin.Text)));

      AddCampo('DTAFAT', 'DT.FAT.');
      AddCampo('NUMPED', 'NUM.PED.');
      AddCampo('ESPPED', 'ESP.PED.');
      AddCampo('EMPPED', 'EMP.PED.');
      AddCampo('DOCFAT', 'DOC.FAT.');
      AddCampo('TIPFAT', 'ESP.FAT.');
      AddCampo('EMPFAT', 'EMP.FAT.');
      AddCampo('CODOPE', 'COD.VEN.');
      AddCampo('NOMVEN', 'NOME VENDEDOR');
      AddCampo('CODDIG', 'COD.DIG.');
      AddCampo('NOMDIG', 'NOME DIGITADOR');
      AddCampo('CODCLI', 'COD.CLIENTE');
      AddCampo('NOMCLI', 'NOME CLIENTE');
      AddCampo('CODATI', 'COD.ATIV.CLIENTE');
      AddCampo('DESATI', 'DESC.ATIV.CLIENTE');
      AddCampo('BAIRRO', 'BAIRRO');
      AddCampo('NOMCID', 'CIDADE');
      AddCampo('ESTADO', 'UF');
      AddCampo('CODFOR', 'COD.FORN.');
      AddCampo('NOMFOR', 'NOME FORNECEDOR');
      AddCampo('ATIFOR', 'COD.ATIV.FORN.');
      AddCampo('ATIDES', 'DESC.ATIV.FORNECEDOR');
      AddCampo('CODITE', 'COD.ITEM');
      AddCampo('DESITE', 'PRODUTO');
      AddCampo('CODLIN', 'LINHA');
      AddCampo('DESLIN', 'DESC.LINHA');
      AddCampo('CODGRU', 'GRUPO');
      AddCampo('DESGRU', 'DESC.GRUPO');
      AddCampo('CODMAR', 'COD.MARCA');
      AddCampo('DESMAR', 'DESC.MARCA');
      AddCampo('TIPEMB', 'EMBALAGEM');
      AddCampo('QTDITE', 'QUANTIDADE');
      AddCampo('UNITAR', 'VR.UNITÁRIO');
      AddCampo('VALTOT', 'VR.TOTAL');
      AddCampo('UNICUS', 'CUSTO UNIT.');
      AddCampo('TOTCUS', 'CUSTO TOTAL');

      AddTotais('VALTOT');
      AddTotais('TOTCUS');

      OnMontaResumo := pMontaResumo;
      OnSomaResumo  := pSomaTotais;

      If fGerarRelatorio Then
        fMensagem('','Arquivo gerado com sucesso!',['&OK']);
    End;

    FreeAndNil(objGeraExcel);
  Except
    On E: Exception Do
    Begin
      FreeAndNil(objGeraExcel);
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmRelFatPedVendaFaturados.pMontaResumo(Excel: TExcel;
  Campos: TCampos; Quebra: TRecQuebras);
begin
  With Excel Do
  Begin
    ProximaLinha;
    Escrever(LinhaAtual, Campos.ColunaPorNome['UNITAR'].Coluna, 'TOTAL GERAL: ');
    Escrever(LinhaAtual, Campos.ColunaPorNome['VALTOT'].Coluna, (FormatFloat('##,#0.00', Quebra.Totais['VALTOT'])));
    Escrever(LinhaAtual, Campos.ColunaPorNome['TOTCUS'].Coluna, (FormatFloat('##,#0.00', Quebra.Totais['TOTCUS'])));

    Alinhamento('AH' + IntToStr(LinhaAtual), 'AH' + IntToStr(LinhaAtual), Direita);
    Alinhamento('AJ' + IntToStr(LinhaAtual), 'AJ' + IntToStr(LinhaAtual), Direita);

    CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    CorFonte('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
    Negrito ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    Bordas  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
  End;
end;

procedure TfrmRelFatPedVendaFaturados.pSetParam(qryRel: TUniQuery);
begin
  With qryRel Do
  Begin
    ParamByName('DTAINI').AsDate   := StrToDate(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDate   := StrToDate(mskDtaFin.Text);

    If Not fEmptyStr(edtDocumento.Text) Then
      ParamByName('NUMDOC').AsString := edtDocumento.Text;

    If Not fEmptyStr(edtEspDoc.Text) Then
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;

    If Params.FindParam('ITESER') <> Nil Then
      ParamByName('ITESER').AsString := fCfgSis('ITESER');

    If Params.FindParam('SERTER') <> Nil Then
      ParamByName('SERTER').AsString := fCfgSis('SERTER');

    If Not fEmptyStr(edtCodCliente.Text) Then
      pSetaParam(edtCodCliente.Text, arrClientes, strClientes, 'CODCLI', qryRel);

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryRel);

    If Not fEmptyStr(edtCodRede.Text) Then
      pSetaParamOR(edtCodRede, arrRede, 'CODRED', qryRel);

    If Not fEmptyStr(edtCodProduto.Text) Then
      pSetaParam(edtCodProduto.Text, arrProduto, strProduto, 'CODITE', qryRel);

    If Not fEmptyStr(edtFornecedor.Text) Then
      pSetaParam(edtFornecedor.Text, arrFornec, strFornec, 'CODFOR', qryRel);

    If Not fEmptyStr(edtCodVendedor.Text) Then
      pSetaParam(edtCodVendedor.Text, arrVended, strVended, 'CODVEN', qryRel);

    If Not fEmptyStr(edtCodRepresentante.Text) Then
      pSetaParam(edtCodRepresentante.Text, arrRepres, strRepres, 'CODREP', qryRel);

    If Not fEmptyStr(edtCodMar.Text) Then
      pSetaParam(edtCodMar.Text, arrMarcas, strMarcas, 'CODMAR', qryRel);

    pSetaParam(mskLinhaGrupo.Text, arrGrupos, strGrupos, 'CODGRU', qryRel);

    If Not fEmptyStr(edtCodDep.Text) Then
      pSetaParam(edtCodDep.Text, arrDepart, strDepart, 'CODDEP', qryRel);
  End;
end;

procedure TfrmRelFatPedVendaFaturados.pSomaTotais(var Totais: TTotais;
  Dados: TDataSet);
begin
  Totais['VALTOT'] := Totais['VALTOT'] + Dados.FieldByName('VALTOT').AsFloat;
  Totais['TOTCUS'] := Totais['TOTCUS'] + Dados.FieldByName('TOTCUS').AsFloat;
end;

end.
