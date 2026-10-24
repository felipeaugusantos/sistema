unit untRelEstSaldoReservado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, Uni, AppEvnts, untTypesSistema,untClassPanelCx,
  BitBtnLockedIncrem, untFuncoesSimples, frxExportCSVTestabilidade, untIFuncoes,
  Vcl.ComCtrls, untGeraExcel, DB, untExcel;

type
  TfrmRelEstSaldoReservado = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label3: TLabel;
    Label10: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtProdutos: TEditFocus;
    edtCliente: TEditFocus;
    edtDesGrupo: TEditFocus;
    edtDesProduto: TEditFocus;
    edtDesCliente: TEditFocus;
    gpbOpcao: TGroupBox;
    ColorLabel3: TColorLabel;
    edtOpcao: TEditFocus;
    gpbQuebra: TGroupBox;
    ColorLabel4: TColorLabel;
    edtQuebra: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    rdgPeriodo: TRadioGroup;
    rdgOrdenacao: TRadioGroup;
    Label1: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    rdgSituacao: TRadioGroup;
    Label12: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    pgbProgresso: TProgressBar;
    Label11: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtGruCmp: TEditFocus;
    Label2: TLabel;
    edtDesGruCmp: TEditFocus;
    ckbPedCom: TCheckBox;
    rdgTipoSaldo: TRadioGroup;
    frxReportJ: TfrxReport;
    frxDocumentos: TfrxDBDataset;
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoEnter(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure edtClienteExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpExit(Sender: TObject);
    procedure rdgSituacaoClick(Sender: TObject);
  private
    { Private declarations }
    qryRelatorio: TUniQuery;
    qryRelDocumentos: TUniQuery;
    qryCliResumo: TUniQuery;
    dtsCliResumo: TDataSource;

    arrVendedor: TConsultasArray;
    arrMarca   : TConsultasArray;

    strArqPDF  : String;
    blnPrevisao: Boolean;
    blnOrdPrevisao: Boolean;
    strMarca,
    strCodEmp: String;
    strCodCli: string;

    fltTotFaltSobGer : Double;
    fltTotFaltSobGrp : Double;
    fltTotFaltSobLin : Double;
    fltTotFaltSobIte : Double;

    function fFiltroEmpresaReservaPedido: String;

    procedure pAcumulaTotais;
    procedure pCriaQryRelatorio;
    procedure pCriaQryRelDocumentos;
    procedure pGeraExcel;
    function fRetFALTSOB: Double;
    procedure pSomaTotais(var Totais: TTotais; Dados: TDataSet);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    function fGetSQLClientes: String;
    function fGetSQLDocumentos: String;
    procedure pRetCliResumo;
    procedure pImpDetalhes(Excel: TExcel; Dados: TDataSet; Campos: TCampos;
      CorFundo: TCorExcel);
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelEstSaldoReservado: TfrmRelEstSaldoReservado;

implementation

uses untConsultas, untFuncoesConsulta;

{$R *.dfm}

//***************************************//
// PESQUISAR CLIENTES                   *//
//************************************RL*//
procedure TfrmRelEstSaldoReservado.edtClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

//***************************************//
// CARREGAR DESCRIÇÃO DO CLIENTE        *//
//************************************RL*//
procedure TfrmRelEstSaldoReservado.pCarregaCliente(Var qryCadCli: TUniQuery);
Begin
  If Not (fEmptyStr(edtCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';
End;

procedure TfrmRelEstSaldoReservado.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  qryRelatorio.SmartFetch.LiveBlock := True;
end;

procedure TfrmRelEstSaldoReservado.pCriaQryRelDocumentos;
begin
  qryRelDocumentos:= fCriaQuery(Self);
  qryRelDocumentos.SmartFetch.LiveBlock := True;
end;

//***************************************//
// PESQUISAR GRUPOS                     *//
//************************************RL*//
procedure TfrmRelEstSaldoReservado.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstSaldoReservado.mskLinhaGrupoEnter(Sender: TObject);
begin
  inherited;
  edtProdutos.Clear;
end;

procedure TfrmRelEstSaldoReservado.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
  Begin
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);
    If fEmptyStr(edtDesGrupo.Text) Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinhaGrupo.Clear;
      pSetFocus(mskLinhaGrupo);
    End;
  End;
end;

procedure TfrmRelEstSaldoReservado.edtClienteExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCliente.Text) Then
    edtDesCliente.Text := 'TODOS'
  Else
    edtDesCliente.Text := fRetNomCliente(edtCliente.Text);

  If fEmptyStr(edtDesCliente.Text) And (Not fEmptyStr(edtCliente.Text))  Then
  Begin
    fMensagem('AVISO','Código do cliente não encontrado.', ['&O K']);
    edtCliente.Clear;
    pSetFocus(edtCliente);
  End;
end;

//***************************************//
// PESQUISAR PRODUTOS                   *//
//************************************RL*//
procedure TfrmRelEstSaldoReservado.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGenIte   : TUniQuery;
    arrSel : TConsultasArray;

begin
  inherited;

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    Key := #0;
    Exit;
  End;

  qryGenIte := fCriaQuery;

  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryGenIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
    Self.SelectNext(ActiveControl, True, True);

  FreeAndNil(qryGenIte);

end;

procedure TfrmRelEstSaldoReservado.edtProdutosExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtProdutos.Text) Then
    edtDesProduto.Text := 'TODOS'
  Else
    edtDesProduto.Text := fRetNomProduto(edtProdutos.Text);


  If fEmptyStr(edtDesProduto.Text) And (Not fEmptyStr(edtProdutos.Text))  Then
  Begin
    fMensagem('AVISO','Código do Produto não encontrado.', ['&O K']);
    edtProdutos.Clear;
    pSetFocus(edtProdutos);
  End;
end;

procedure TfrmRelEstSaldoReservado.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtCodEmpresaExit(Sender);

  pCriaQryRelatorio;
  pCriaQryRelDocumentos;

end;

//***************************************//
// VALIDA CAMPOS                        *//
//************************************RL*//
function TfrmRelEstSaldoReservado.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (Sender = mskDtaIni) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('ATENÇÃO','O CAMPO DATA INICIAL DEVE SER PREENCHIDO ',['&O K']);
      Result := False;
    End;
  End

  Else
  If (Sender = mskDtaFin) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    Begin
      fMensagem('ATENÇÃO','O CAMPO DATA FINAL DEVE SER PREENCHIDO ',['&O K']);
      Result := False;
    End
    Else
    If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
    Begin
      fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&O K']);
      Result := False;
    End;
  End

  Else If (Sender = edtMarca) Then
  Begin

    If fEmptyStr(edtMarca.Text) Then
    Begin
      edtDesMarca.Text := 'TODOS';
    End Else
    Begin
      edtDesMarca.Text := fRetNomMarca(edtMarca.Text);

      If fEmptyStr(edtDesMarca.Text) Then
      Begin
        fMensagem('ATENÇÃO!','Código da Marca não encontrado!',['&O K']);
        Result := False;
      End;
    End;

  End

  Else
  If (Sender = edtOpcao) Then
  Begin

    If (edtOpcao.Text <> 'A') AND (edtOpcao.Text <> 'S') Then
    Begin
      fMensagem('','O CAMPO TIPO DEVE CONTER A OU S ',['&O K']);
      Result := False;
    End;

    rdgOrdenacao.Enabled := edtOpcao.Text = 'A';

    gpbQuebra.Enabled := edtOpcao.Text = 'A';

  End

  Else If (Sender = edtQuebra) Then
  Begin
    If (edtQuebra.Text <> 'A') And (edtQuebra.Text <> 'L') Then
    Begin
      fMensagem('','O campo tipo deve ter A ou L!',['&O K'],0);
      Result := False;
    End;
  End

  Else If (Sender = edtCodEmpresa) Then
  Begin
    If fEmptyStr(edtCodEmpresa.Text) Then
    Begin
      fMensagem('ATENÇÃO!','O campo Empresa deve ter um valor!',['&O K']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmRelEstSaldoReservado.fRetFALTSOB : double;
Begin
  Result := (qryRelatorio.FieldByName('SALDO').AsFloat  +
             qryRelatorio.FieldByName('QTDPEN').AsFloat -
             qryRelatorio.FieldByName('SALRES').AsFloat);
End;

//***************************************//
// DOCUMENTOS PARA RELATORIO ANALITICO  *//
//*************************************JZ//

Function TfrmRelEstSaldoReservado.fGetSQLDocumentos: String;
  Var
    strSQL: String;
Begin
  strSQL := 'SELECT ';
  strSQL := strSQL + ' CONCAT(FDO_NUMDOC,"-",FDO_ESPDOC) AS "NUMDOC", ';
  strSQL := strSQL + ' F.FDO_CODITE AS CODITE, ';
  strSQL := strSQL + ' CONCAT(C.CLI_CODCLI, "  -") AS "CODCLI", ';
  strSQL := strSQL + ' C.CLI_NOMCLI AS "NOMCLI", ';
  strSQL := strSQL + ' FGO_PREVIS AS "PREVIS", ';
  strSQL := strSQL + ' FGO_CODVEN AS "CODVEN", ';
  strSQL := strSQL + ' SUM(FDO_QTDITE) AS SALTOT, ';
  strSQL := strSQL + ' SUM(FDO_QTDBAI) AS SALBAI, ';
  strSQL := strSQL + ' SUM(FDO_QTDITE - FDO_QTDBAI) AS SALRES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI C ';
  strSQL := strSQL + 'INNER JOIN FATDOR F ON F.FDO_CODCLI = C.CLI_CODCLI ';
  strSQL := strSQL + 'INNER JOIN FATGOR ON ';
  strSQL := strSQL + '  FDO_NUMDOC = FGO_NUMDOC AND ';
  strSQL := strSQL + '  FDO_ESPDOC = FGO_ESPDOC AND ';
  strSQL := strSQL + '  FDO_CODEMP = FGO_CODEMP     ';
  strSQL := strSQL + 'INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strSQL := strSQL + 'WHERE '+ IfThen(rdgTipoSaldo.ItemIndex in [0, 2], 'TRUE AND', 'FALSE AND');

  if blnPrevisao Then
    strSQL := strSQL + '  FGO_PREVIS BETWEEN :DTAINI AND :DTAFIN AND '
  Else
    strSQL := strSQL + '  F.FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';

  strSQL := strSQL + '  FDO_JAFATU   = 0 AND ';
  strSQL := strSQL + '  (ROUND(F.FDO_QTDITE,2) - ROUND(F.FDO_QTDBAI,2)) > 0 AND ';
  strSQL := strSQL + '  FDO_ESPDOC   = "PD" ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSQL := strSQL + '  AND ' + fFiltroEmpresaReservaPedido + ' = :CODEMP ';

  If Not fEmptyStr(edtCliente.Text) Then
    strSQL := strSQL + '  AND F.FDO_CODCLI = :CODCLI ';

  If Not fEmptyStr(edtCodVendedor.Text) Then
    strSQL := strSQL + '  AND F.FDO_CODVEN = :CODVEN ';

  If Not fEmptyStr(edtProdutos.Text) Then
    strSQL := strSQL + '  AND F.FDO_CODITE = :CODITE ';

  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSQL + '  CODITE, NUMDOC, CODCLI, FGO_PREVIS ';

  strSQL := strSQL + 'UNION ALL ';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CONCAT(GAG_NUMENT,"-GA") AS "NUMDOC", ';
  strSQL := strSQL + '  MOVGAD.GAD_CODITE AS CODITE, ';
  strSQL := strSQL + '  CONCAT(GAG_CODCLI,"  -") AS "CODCLI", ';
  strSQL := strSQL + '  CLI_NOMCLI AS "NOMCLI", ';
  strSQL := strSQL + '  GAG_DTAENT AS "PREVIS", ';
  strSQL := strSQL + '  GAG_CODVEN AS "CODVEN", ';
  strSQL := strSQL + '  SUM(GAD_QTDREQ - IFNULL((SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = MOVGAD.AUTOINCREM ),0) ) AS SALTOT, ';
  strSQL := strSQL + '  SUM(GAD_QTDDEV) AS SALBAI, ';
  strSQL := strSQL + '  SUM(GAD_QTDREQ - GAD_QTDDEV - GAD_QTDPRE) AS SALRES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGAG INNER JOIN MOVGAD ON MOVGAG.AUTOINCREM = MOVGAD.GAD_SEQGAG ';
  strSQL := strSQL + '         INNER JOIN CADCLI ON MOVGAG.GAG_CODCLI = CADCLI.CLI_CODCLI ';
  strSQL := strSQL + 'WHERE '+ IfThen(rdgTipoSaldo.ItemIndex in [1, 2], 'TRUE AND', 'FALSE AND');
  strSQL := strSQL + '  CAST(GAG_DTAENT AS DATE) BETWEEN :DTAINI AND :DTAFIN AND ';
  strSQL := strSQL + '  IFNULL(GAD_QTDREQ,0) - IFNULL((SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = MOVGAD.AUTOINCREM ),0) > 0  ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSQL := strSQL + '  AND GAG_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtCliente.Text) Then
    strSQL := strSQL + '  AND GAG_CODCLI = :CODCLI ';

  If Not fEmptyStr(edtProdutos.Text) Then
    strSQL := strSQL + '  AND MOVGAD.GAD_CODITE = :CODITE ';

  strSQL := strSQL + ' GROUP BY   CODITE, NUMDOC, CODCLI, PREVIS ';

  strSQL := 'SELECT * FROM ( ' + strSQL + ') A ';
  strSQL := strSQL + ' ORDER BY ';
  If blnOrdPrevisao Then
    strSQL := strSQL + '  CODITE, PREVIS, NOMCLI  '
  Else
    strSQL := strSQL + '  CODITE, NOMCLI, PREVIS  ';

  Result := strSQL;
End;

//***************************************//
// IMPRIMIR RELATÓRIO DE SALDO RESERVADO*//
//************************************RL*//
procedure TfrmRelEstSaldoReservado.btnImprimirClick(Sender: TObject);
  Var
    strSQL,
    strSQLSaldo,
    strSalRes,
    strSalPed : String;
    frxReport: TfrxReport;

  function fRetSQLPedidoCompra: String;
  begin
    If ckbPedCom.Checked Then
      Result :=  ' + QTDPEN ';
  end;

begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  strSQLSaldo := '';
  strSQLSaldo := strSQLSaldo + ' (SELECT SUM(ITE_SALDOS) FROM ITEGER      ';
  strSQLSaldo := strSQLSaldo + ' WHERE                                   ';
  strSQLSaldo := strSQLSaldo + '   CADITE.ITE_CODITE = ITEGER.ITE_CODITE ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSQLSaldo := strSQLSaldo + '  AND ITEGER.ITE_CODEMP = :CODEMP ';

  strSQLSaldo := strSQLSaldo + ' GROUP BY ITEGER.ITE_CODITE) ';

  strSalRes := '';
  strSalRes := strSalRes + ' (SELECT SUM(SALRES) ';
  strSalRes := strSalRes + ' FROM ( ';
  strSalRes := strSalRes + '    SELECT ';
  strSalRes := strSalRes + '      SUM(FDO_QTDITE - FDO_QTDBAI) AS SALRES, ';
  strSalRes := strSalRes + '      FATDOR.FDO_CODITE AS CODITE ';
  strSalRes := strSalRes + '    FROM ';
  strSalRes := strSalRes + '      FATDOR ';
  strSalRes := strSalRes + '    INNER JOIN FATGOR ON ';
  strSalRes := strSalRes + '      FDO_ESPDOC = FGO_ESPDOC AND ';
  strSalRes := strSalRes + '      FDO_NUMDOC = FGO_NUMDOC AND ';
  strSalRes := strSalRes + '      FDO_CODEMP = FGO_CODEMP     ';
  strSalRes := strSalRes + '    INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strSalRes := strSalRes + '    WHERE ' + IfThen(rdgTipoSaldo.ItemIndex in [0, 2], 'TRUE', 'FALSE') + ' AND ';
  strSalRes := strSalRes + '      FATDOR.FDO_ESPDOC = "PD"              AND ';
  strSalRes := strSalRes + '      FATDOR.FDO_JAFATU = 0                 AND ';

  strSalRes := strSalRes + '      (ROUND(FATDOR.FDO_QTDITE,2) - ROUND(FATDOR.FDO_QTDBAI,2)) > 0 AND ';

  Case rdgPeriodo.ItemIndex Of
    0: strSalRes := strSalRes + '   FATDOR.FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
    1: strSalRes := strSalRes + '   FATGOR.FGO_PREVIS BETWEEN :DTAINI AND :DTAFIN ';
  End;

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSalRes := strSalRes + '    AND ' + fFiltroEmpresaReservaPedido + ' = :CODEMP ';

  If Not fEmptyStr(edtCodVendedor.Text) Then
    strSalRes := strSalRes + '  AND FATDOR.FDO_CODVEN = :CODVEN ';

  If Not fEmptyStr(edtCliente.Text) Then
    strSalRes := strSalRes + '  AND FATDOR.FDO_CODCLI = :CODCLI ';

  strSalRes := strSalRes + '    GROUP BY ';
  strSalRes := strSalRes + '      FDO_CODITE )A ';

  strSalRes := strSalRes + '    WHERE A.CODITE = CADITE.ITE_CODITE) ';

  strSalPed := '';
  strSalPed := strSalPed + '  IFNULL((SELECT ';
  strSalPed := strSalPed + '     IFNULL(SUM((PCD_QTDITE - PCD_QTDBAI) * PCD_EMBALA), 0) ';
  strSalPed := strSalPed + '   FROM ';
  strSalPed := strSalPed + '     PCMDET ';

  strSalPed := strSalPed + '     JOIN PCMGER ON PCD_NUMPED = PCG_NUMPED AND ';
  strSalPed := strSalPed + '                    PCD_CODEMP = PCG_CODEMP AND ';
  strSalPed := strSalPed + '                    PCD_ESPDOC = PCG_ESPDOC AND ';
  strSalPed := strSalPed + '                    PCD_NUMCTN = PCG_NUMCTN ';

  strSalPed := strSalPed + '   WHERE ';
  strSalPed := strSalPed + '     PCD_NUMCTN = 0                 AND      ';
  strSalPed := strSalPed + '     PCD_BAIXAD = 0                 AND      ';
  strSalPed := strSalPed + '     PCD_ESPDOC = "PD"              AND      ';
  strSalPed := strSalPed + '     PCD_CODITE = CADITE.ITE_CODITE AND      ';
  strSalPed := strSalPed + '     PCD_DTAENT BETWEEN :DTAINI AND :DTAFIN  ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSalPed := strSalPed + '  AND IF(IFNULL(PCG_EMPDES, "")="", PCD_CODEMP, PCG_EMPDES) = :CODEMP ';

  strSalPed := strSalPed + '   GROUP BY ';
  strSalPed := strSalPed + '     PCD_CODITE),0)  ';

  inherited;

  If blnImprime Then
  Begin

    //***************************************//
    // ANALÍTICO                            *//
    //************************************RL*//
    If edtOpcao.Text = 'A' Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '		PREVIS, ';
      strSQL := strSQL + '    LINHA,  ';
      strSQL := strSQL + '		LINDES, ';
      strSQL := strSQL + '		GRUPO,  ';
      strSQL := strSQL + '		DESGRU, ';
      strSQL := strSQL + '		DESMAR, ';
      strSQL := strSQL + '		CODITE, ';
      strSQL := strSQL + '		DESITE, ';
      strSQL := strSQL + '		REFERE, ';
      strSQL := strSQL + '		DESUNI, ';
      strSQL := strSQL + '		SALDO,  ';
      strSQL := strSQL + '		SUM(SALRES) AS SALRES, ';
      strSQL := strSQL + '		QTDPEN, ';
      strSQL := strSQL + '   NOMOPE  ';
      strSQL := strSQL + ' FROM (    ';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  FATGOR.FGO_PREVIS AS PREVIS, ';
      strSQL := strSQL + '  LEFT(CADITE.ITE_CODGRU,3) AS LINHA, ';
      strSQL := strSQL + '  CONCAT(LEFT(CADITE.ITE_CODGRU,3)," - ", ';
      strSQL := strSQL + '  		(SELECT GRU_DESGRU FROM CADGRU ';
      strSQL := strSQL + '  		  WHERE GRU_CODGRU = CONCAT(LEFT(CADITE.ITE_CODGRU,3),"","000"))) AS LINDES, ';
      strSQL := strSQL + '  CADITE.ITE_CODGRU AS GRUPO, ';
      strSQL := strSQL + '  CONCAT(CADITE.ITE_CODGRU, " - ", CADGRU.GRU_DESGRU) AS DESGRU, ';
      strSQL := strSQL + '  CADMAR.MAR_DESMAR AS DESMAR, ';
      strSQL := strSQL + '  CADITE.ITE_CODITE AS CODITE, ';
      strSQL := strSQL + '  CADITE.ITE_DESITE AS DESITE, ';
      strSQL := strSQL + '  CADITE.ITE_REFERE AS REFERE, ';
      strSQL := strSQL + '  CADUNI.UNI_DESUNI AS DESUNI, ';
      strSQL := strSQL +   strSQLSaldo    + ' AS SALDO,  ';
      strSQL := strSQL +   strSalRes      + ' AS SALRES, ';
      strSQL := strSQL +   strSalPed      + ' AS QTDPEN, ';

      strSQL := strSQL + ' (SELECT ';
      strSQL := strSQL + '    CONCAT(OPE_CODOPE, "-", OPE_NOMOPE)  ';
      strSQL := strSQL + '  FROM ';
      strSQL := strSQL + '    CADOPE ';
      strSQL := strSQL + '  WHERE OPE_CODOPE = FDO_CODVEN ' ;
      strSQL := strSQL + '  LIMIT 1) AS NOMOPE ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADITE ';
      strSQL := strSQL + '  JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI ';
      strSQL := strSQL + '  JOIN FATDOR ON FATDOR.FDO_CODITE = CADITE.ITE_CODITE ';
      strSQL := strSQL + '  JOIN CADMAR ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR ';
      strSQL := strSQL + '  JOIN CADGRU ON CADGRU.GRU_CODGRU = CADITE.ITE_CODGRU ';

      strSQL := strSQL + 'INNER JOIN FATGOR ON ';
      strSQL := strSQL + '  FDO_ESPDOC = FGO_ESPDOC AND ';
      strSQL := strSQL + '  FDO_NUMDOC = FGO_NUMDOC AND ';
      strSQL := strSQL + '  FDO_CODEMP = FGO_CODEMP     ';

      strSQL := strSQL + 'INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';

      strSQL := strSQL + 'WHERE ' + IfThen(rdgTipoSaldo.ItemIndex in [0, 2], 'TRUE AND', 'FALSE AND');

      Case rdgPeriodo.ItemIndex Of
        0: strSQL := strSQL + '  FATDOR.FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
        1: strSQL := strSQL + '  FATGOR.FGO_PREVIS BETWEEN :DTAINI AND :DTAFIN AND ';
      End;

      strSQL := strSQL + '  FATDOR.FDO_ESPDOC = "PD"                      AND ';
      strSQL := strSQL + '  FATDOR.FDO_JAFATU = 0                         AND ';

      strSQL := strSQL + '  (ROUND(FATDOR.FDO_QTDITE,2) - ROUND(FATDOR.FDO_QTDBAI,2)) > 0 ';

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
      Begin
        If RightStr(mskLinhaGrupo.Text,3) = '000' Then
          strSQL := strSQL + '  AND LEFT(CADITE.ITE_CODGRU,3) = LEFT(:CODGRU,3) '
        Else
          strSQL := strSQL + '  AND CADITE.ITE_CODGRU = :CODGRU ';
      End;

      If Not fEmptyStr(edtProdutos.Text) Then
        strSQL := strSQL + '  AND CADITE.ITE_CODITE = :CODITE ';

      If Not fEmptyStr(edtGruCmp.Text) Then
        strSQL := strSQL + '  AND CADITE.ITE_GRUCMP = :GRUCMP ';

      strSQL := strSQL + fStrLocate(edtMarca, arrMarca, 'CADITE.ITE_CODMAR', 'CODMAR');

      If Not fEmptyStr(edtCliente.Text) Then
        strSQL := strSQL + '  AND FATDOR.FDO_CODCLI = :CODCLI ';

      If Not fEmptyStr(edtFornecedor.Text) Then
        strSQL := strSQL + '  AND CADITE.ITE_CODFOR = :CODFOR ';

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + '  AND ' + fFiltroEmpresaReservaPedido + ' = :CODEMP ';

      If Not fEmptyStr(edtCodVendedor.Text) Then
        strSQL := strSQL + '  AND FATDOR.FDO_CODVEN = :CODVEN ';

      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '  CODITE ';

      strSQL := strSQL + ' 	UNION ALL ';
      strSQL := strSQL + '';
      strSQL := strSQL + ' 	SELECT ';
      strSQL := strSQL + ' 		NULL AS PREVIS, ';
      strSQL := strSQL + ' 		LEFT(CADITE.ITE_CODGRU, 3)  AS LINHA, ';
      strSQL := strSQL + ' 		CONCAT( LEFT(CADITE.ITE_CODGRU, 3), " - ", (SELECT GRU_DESGRU FROM CADGRU WHERE GRU_CODGRU = CONCAT( LEFT(CADITE.ITE_CODGRU, 3), "", "000" )) ) AS  LINDES, ';
      strSQL := strSQL + ' 		CADITE.ITE_CODGRU AS GRUPO, ';
      strSQL := strSQL + ' 		CONCAT(CADITE.ITE_CODGRU, " - ", CADGRU.GRU_DESGRU)   AS DESGRU, ';
      strSQL := strSQL + ' 	 	CADMAR.MAR_DESMAR AS DESMAR, ';
      strSQL := strSQL + ' 	 	GAD_CODITE AS CODITE, ';
      strSQL := strSQL + ' 	 	CADITE.ITE_DESITE AS DESITE, ';
      strSQL := strSQL + ' 	 	CADITE.ITE_REFERE AS REFERE, ';
      strSQL := strSQL + ' 	 	CADUNI.UNI_DESUNI AS DESUNI, ';
      strSQL := strSQL + ' 	 	(SELECT SUM(ITE_SALDOS) FROM ITEGER WHERE CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND ITEGER.ITE_CODEMP = :CODEMP GROUP BY ITEGER.ITE_CODITE) AS SALDO, ';
      strSQL := strSQL + ' 		SUM( COALESCE(GAD_QTDREQ, 0) - IFNULL( (SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = D.AUTOINCREM), 0 ) ) AS SALRES, ';
      strSQL := strSQL + ' 		IFNULL(( SELECT ';
      strSQL := strSQL + ' 								IFNULL( SUM( (PCD_QTDITE - PCD_QTDBAI) * PCD_EMBALA ), 0 ) ';
      strSQL := strSQL + ' 	 	  					FROM PCMDET ';
      strSQL := strSQL + ' 	 	    				JOIN PCMGER  ON PCD_NUMPED = PCG_NUMPED ';
      strSQL := strSQL + ' 											 		  AND PCD_CODEMP = PCG_CODEMP ';
      strSQL := strSQL + ' 											 		  AND PCD_ESPDOC = PCG_ESPDOC ';
      strSQL := strSQL + ' 											 		  AND PCD_NUMCTN = PCG_NUMCTN ';
      strSQL := strSQL + ' 	 	  					WHERE PCD_NUMCTN = 0    ';
      strSQL := strSQL + ' 	 	    					AND PCD_BAIXAD = 0    ';
      strSQL := strSQL + ' 	 	    					AND PCD_ESPDOC = "PD" ';
      strSQL := strSQL + ' 	 	    					AND PCD_CODITE = CADITE.ITE_CODITE ';
      strSQL := strSQL + ' 	 	    					AND PCD_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
      strSQL := strSQL + ' 									AND IF( IFNULL(PCG_EMPDES, "") = "", PCD_CODEMP, PCG_EMPDES ) = :CODEMP ';
      strSQL := strSQL + ' 	 	  				 GROUP BY PCD_CODITE), 0) AS QTDPEN, ';
      strSQL := strSQL + ' 		(SELECT     CONCAT(OPE_CODOPE, "-", OPE_NOMOPE)   FROM     CADOPE   WHERE OPE_CODOPE = GAG_CODVEN   LIMIT 1) AS NOMOPE ';
      strSQL := strSQL + ' 	FROM  MOVGAG G ';
      strSQL := strSQL + ' 		INNER JOIN MOVGAD D ON G.AUTOINCREM = D.GAD_SEQGAG     ';
      strSQL := strSQL + ' 		LEFT JOIN CADITE ON CADITE.ITE_CODITE = D.GAD_CODITE   ';
      strSQL := strSQL + ' 		LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = D.GAD_CODITE   ';
      strSQL := strSQL + ' 		                AND ITEGER.ITE_CODEMP = G.GAG_CODEMP   ';
      strSQL := strSQL + ' 		LEFT JOIN CADGRU ON CADGRU.GRU_CODGRU = CADITE.ITE_CODGRU  ';
      strSQL := strSQL + ' 		LEFT JOIN CADMAR ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR  ';
      strSQL := strSQL + ' 		LEFT JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI	 ';
      strSQL := strSQL + ' 	WHERE ' + IfThen(rdgTipoSaldo.ItemIndex in [1, 2], 'TRUE', 'FALSE');
      strSQL := strSQL + ' 		AND CAST(GAG_DTAENT AS DATE)  BETWEEN :DTAINI AND :DTAFIN ';
      strSQL := strSQL + ' AND  IFNULL(GAD_QTDREQ,0) - IFNULL((SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = D.AUTOINCREM ),0) > 0 ';

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
      Begin
        If RightStr(mskLinhaGrupo.Text,3) = '000' Then
          strSQL := strSQL + '  AND LEFT(CADITE.ITE_CODGRU,3) = LEFT(:CODGRU,3) '
        Else
          strSQL := strSQL + '  AND CADITE.ITE_CODGRU = :CODGRU ';
      End;

      If Not fEmptyStr(edtProdutos.Text) Then
        strSQL := strSQL + '  AND CADITE.ITE_CODITE = :CODITE ';

      If Not fEmptyStr(edtGruCmp.Text) Then
        strSQL := strSQL + '  AND CADITE.ITE_GRUCMP = :GRUCMP ';

      strSQL := strSQL + fStrLocate(edtMarca, arrMarca, 'CADITE.ITE_CODMAR', 'CODMAR');

      If Not fEmptyStr(edtCliente.Text) Then
        strSQL := strSQL + '  AND G.GAG_CODCLI = :CODCLI ';

      If Not fEmptyStr(edtFornecedor.Text) Then
        strSQL := strSQL + '  AND CADITE.ITE_CODFOR = :CODFOR ';

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + '  AND G.GAG_CODEMP = :CODEMP ';

      If Not fEmptyStr(edtCodVendedor.Text) Then
        strSQL := strSQL + '  AND G.GAG_CODVEN = :CODVEN ';

      strSQL := strSQL + '    GROUP BY GAD_CODITE ';

      strSQL := strSQL + ' ) AS TAB   ';

      strSQL := strSQL + ' GROUP BY CODITE  ';

      Case rdgSituacao.ItemIndex Of
        0: strSQL := strSQL + ' HAVING (SALDO ' + fRetSQLPedidoCompra + ') <   SALRES ';
        1: strSQL := strSQL + ' HAVING (SALDO ' + fRetSQLPedidoCompra + ') >=  SALRES ';
      End;

    End
    Else
    Begin
      //***************************************//
      // SINTÉTICO                            *//
      //************************************RL*//
      strSQL := '';

			strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  PREVIS, ';
      strSQL := strSQL + '  DESMAR, ';
      strSQL := strSQL + '  CODITE, ';
      strSQL := strSQL + '  DESITE, ';
      strSQL := strSQL + '  REFERE, ';
      strSQL := strSQL + '  DESUNI, ';
      strSQL := strSQL + '  SALDO,  ';
      strSQL := strSQL + '  SUM(SALRES) AS SALRES, ';
      strSQL := strSQL + '  QTDPEN ';
      strSQL := strSQL + ' FROM (    ';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  FATGOR.FGO_PREVIS AS PREVIS, ';
      strSQL := strSQL + '  CADMAR.MAR_DESMAR AS DESMAR, ';
      strSQL := strSQL + '  CADITE.ITE_CODITE AS CODITE, ';
      strSQL := strSQL + '  CADITE.ITE_DESITE AS DESITE, ';
      strSQL := strSQL + '  CADITE.ITE_REFERE AS REFERE, ';
      strSQL := strSQL + '  CADUNI.UNI_DESUNI AS DESUNI, ';

      strSQL := strSQL +   strSQLSaldo + ' AS SALDO,  ';
      strSQL := strSQL +   strSalRes   + ' AS SALRES, ';
      strSQL := strSQL +   strSalPed   + ' AS QTDPEN ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADITE ';
      strSQL := strSQL + '  JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI ';
      strSQL := strSQL + '  JOIN FATDOR ON FATDOR.FDO_CODITE = CADITE.ITE_CODITE ';
      strSQL := strSQL + '  JOIN CADMAR ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR ';

      strSQL := strSQL + 'INNER JOIN FATGOR ON ';
      strSQL := strSQL + '  FDO_ESPDOC = FGO_ESPDOC AND ';
      strSQL := strSQL + '  FDO_NUMDOC = FGO_NUMDOC AND ';
      strSQL := strSQL + '  FDO_CODEMP = FGO_CODEMP     ';

      strSQL := strSQL + 'INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';

      strSQL := strSQL + 'WHERE ' + IfThen(rdgTipoSaldo.ItemIndex in [0, 2], 'TRUE AND', 'FALSE AND');

      Case rdgPeriodo.ItemIndex Of
        0: strSQL := strSQL + '  FATDOR.FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
        1: strSQL := strSQL + '  FATGOR.FGO_PREVIS BETWEEN :DTAINI AND :DTAFIN AND ';
      End;

      strSQL := strSQL + '  FATDOR.FDO_ESPDOC = "PD"                      AND ';
      strSQL := strSQL + '  FATDOR.FDO_JAFATU = 0                         AND ';
      strSQL := strSQL + '  (ROUND(FATDOR.FDO_QTDITE,2) - ROUND(FATDOR.FDO_QTDBAI,2)) > 0 ';

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + '  AND ' + fFiltroEmpresaReservaPedido + ' = :CODEMP ';

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
      Begin
        If RightStr(mskLinhaGrupo.Text,3) = '000' Then
          strSQL := strSQL + '  AND LEFT(CADITE.ITE_CODGRU,3) = LEFT(:CODGRU,3) '
        Else
          strSQL := strSQL + '  AND CADITE.ITE_CODGRU = :CODGRU ';
      End;

      If Not fEmptyStr(edtProdutos.Text) Then
        strSQL := strSQL + '  AND CADITE.ITE_CODITE = :CODITE ';

      If Not fEmptyStr(edtGruCmp.Text) Then
        strSQL := strSQL + '  AND CADITE.ITE_GRUCMP = :GRUCMP ';

      strSQL := strSQL + fStrLocate(edtMarca, arrMarca, 'CADITE.ITE_CODMAR', 'CODMAR');

      If Not fEmptyStr(edtCliente.Text) Then
        strSQL := strSQL + '  AND FATDOR.FDO_CODCLI = :CODCLI ';

      If Not fEmptyStr(edtFornecedor.Text) Then
        strSQL := strSQL + '  AND CADITE.ITE_CODFOR = :CODFOR ';

      If Not fEmptyStr(edtCodVendedor.Text) Then
        strSQL := strSQL + '  AND FATDOR.FDO_CODVEN = :CODVEN ';

      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '  CADITE.ITE_DESITE, ';
      strSQL := strSQL + '  CADITE.ITE_REFERE, ';
      strSQL := strSQL + '  CADUNI.UNI_DESUNI  ';

      strSQL := strSQL + ' 	UNION ALL ';
      strSQL := strSQL + '';
      strSQL := strSQL + ' 	SELECT ';
      strSQL := strSQL + ' 		NULL AS "PREVIS", ';
      strSQL := strSQL + ' 	 	CADMAR.MAR_DESMAR AS "DESMAR", ';
      strSQL := strSQL + ' 	 	GAD_CODITE AS "CODITE", ';
      strSQL := strSQL + ' 	 	CADITE.ITE_DESITE AS "DESITE", ';
      strSQL := strSQL + ' 	 	CADITE.ITE_REFERE AS "REFERE", ';
      strSQL := strSQL + ' 	 	CADUNI.UNI_DESUNI AS "DESUNI", ';
      strSQL := strSQL + ' 	 	(SELECT SUM(ITE_SALDOS) FROM ITEGER WHERE CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND ITEGER.ITE_CODEMP = :CODEMP GROUP BY ITEGER.ITE_CODITE) AS "SALDO", ';
			strSQL := strSQL + ' 		SUM( COALESCE(GAD_QTDREQ, 0) - IFNULL( (SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = D.AUTOINCREM), 0 ) ) AS SALRES, ';
      strSQL := strSQL + ' 		IFNULL(( SELECT ';
      strSQL := strSQL + ' 								IFNULL( SUM( (PCD_QTDITE - PCD_QTDBAI) * PCD_EMBALA ), 0 ) ';
      strSQL := strSQL + ' 	 	  					FROM PCMDET ';
      strSQL := strSQL + ' 	 	    				JOIN PCMGER  ON PCD_NUMPED = PCG_NUMPED ';
      strSQL := strSQL + ' 											 		  AND PCD_CODEMP = PCG_CODEMP ';
      strSQL := strSQL + ' 											 		  AND PCD_ESPDOC = PCG_ESPDOC ';
      strSQL := strSQL + ' 											 		  AND PCD_NUMCTN = PCG_NUMCTN ';
      strSQL := strSQL + ' 	 	  					WHERE PCD_NUMCTN = 0    ';
      strSQL := strSQL + ' 	 	    					AND PCD_BAIXAD = 0    ';
      strSQL := strSQL + ' 	 	    					AND PCD_ESPDOC = "PD" ';
      strSQL := strSQL + ' 	 	    					AND PCD_CODITE = CADITE.ITE_CODITE ';
      strSQL := strSQL + ' 	 	    					AND PCD_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
      strSQL := strSQL + ' 									AND IF( IFNULL(PCG_EMPDES, "") = "", PCD_CODEMP, PCG_EMPDES ) = :CODEMP ';
      strSQL := strSQL + ' 	 	  				 GROUP BY PCD_CODITE), 0) AS "QTDPEN" ';
      strSQL := strSQL + ' 	FROM  MOVGAG G ';
      strSQL := strSQL + ' 		INNER JOIN MOVGAD D ON G.AUTOINCREM = D.GAD_SEQGAG     ';
      strSQL := strSQL + ' 		LEFT JOIN CADITE ON CADITE.ITE_CODITE = D.GAD_CODITE   ';
      strSQL := strSQL + ' 		LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = D.GAD_CODITE   ';
      strSQL := strSQL + ' 		                AND ITEGER.ITE_CODEMP = G.GAG_CODEMP   ';
      strSQL := strSQL + ' 		LEFT JOIN CADGRU ON CADGRU.GRU_CODGRU = CADITE.ITE_CODGRU  ';
      strSQL := strSQL + ' 		LEFT JOIN CADMAR ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR  ';
      strSQL := strSQL + ' 		LEFT JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI	 ';


      strSQL := strSQL + ' 	WHERE ' + IfThen(rdgTipoSaldo.ItemIndex in [1, 2], 'TRUE', 'FALSE');
      strSQL := strSQL + ' 		AND CAST(GAG_DTAENT AS DATE)  BETWEEN :DTAINI AND :DTAFIN ';
      strSQL := strSQL + ' AND  IFNULL(GAD_QTDREQ,0) - IFNULL((SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = D.AUTOINCREM ),0) > 0 ';

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
      Begin
        If RightStr(mskLinhaGrupo.Text,3) = '000' Then
          strSQL := strSQL + '  AND LEFT(CADITE.ITE_CODGRU,3) = LEFT(:CODGRU,3) '
        Else
          strSQL := strSQL + '  AND CADITE.ITE_CODGRU = :CODGRU ';
      End;

      If Not fEmptyStr(edtProdutos.Text) Then
        strSQL := strSQL + '  AND CADITE.ITE_CODITE = :CODITE ';

      If Not fEmptyStr(edtGruCmp.Text) Then
        strSQL := strSQL + '  AND CADITE.ITE_GRUCMP = :GRUCMP ';

      strSQL := strSQL + fStrLocate(edtMarca, arrMarca, 'CADITE.ITE_CODMAR', 'CODMAR');

      If Not fEmptyStr(edtCliente.Text) Then
        strSQL := strSQL + '  AND G.GAG_CODCLI = :CODCLI ';

      If Not fEmptyStr(edtFornecedor.Text) Then
        strSQL := strSQL + '  AND CADITE.ITE_CODFOR = :CODFOR ';

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + '  AND G.GAG_CODEMP = :CODEMP ';

      If Not fEmptyStr(edtCodVendedor.Text) Then
        strSQL := strSQL + '  AND MOVGAG.GAG_CODVEN = :CODVEN ';


			strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '  CADITE.ITE_DESITE, ';
      strSQL := strSQL + '  CADITE.ITE_REFERE, ';
      strSQL := strSQL + '  CADUNI.UNI_DESUNI  ';

      strSQL := strSQL + ' ) AS TAB   ';

      strSQL := strSQL + ' GROUP BY ';
      strSQL := strSQL + '  DESITE, ';
      strSQL := strSQL + '  REFERE, ';
      strSQL := strSQL + '  DESUNI  ';

      Case rdgSituacao.ItemIndex Of
        0: strSQL := strSQL + ' HAVING (SALDO ' + fRetSQLPedidoCompra + ') <   SALRES ';
        1: strSQL := strSQL + ' HAVING (SALDO ' + fRetSQLPedidoCompra + ') >=  SALRES ';
      End;

    End;

    strSQL := strSQL + ' ORDER BY ';

    If edtOpcao.Text = 'A' Then
    Begin
      If edtQuebra.Text = 'L' Then
        strSQL := strSQL + '  GRUPO, CODITE '
      Else
        strSQL := strSQL + '  DESITE ';
    End
    Else
      strSQL := strSQL + '  CODITE ';

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
        ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;

      If Not fEmptyStr(edtProdutos.Text) Then
        ParamByName('CODITE').AsString := edtProdutos.Text;

      If Not fEmptyStr(edtGruCmp.Text) Then
        ParamByName('GRUCMP').AsString := edtGruCmp.Text;

      If Not fEmptyStr(edtCliente.Text) Then
        ParamByName('CODCLI').AsString := edtCliente.Text;

      If Not fEmptyStr(edtFornecedor.Text) Then
        ParamByName('CODFOR').AsString := edtFornecedor.Text;

      If Not fEmptyStr(edtCodVendedor.Text) Then
        ParamByName('CODVEN').AsString := edtCodVendedor.Text;

      pSetaParam(edtMarca.Text,arrMarca,strMarca,'CODMAR',qryRelatorio);

      Open;
    End;

    if edtOpcao.Text = 'A' then
    begin
      With qryRelDocumentos Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fGetSQLDocumentos);

        ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);

        If Not fEmptyStr(edtProdutos.Text) Then
          ParamByName('CODITE').AsString := edtProdutos.Text;

        If Not fEmptyStr(edtCodEmpresa.Text) Then
          ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

        If Not fEmptyStr(edtCliente.Text) Then
          ParamByName('CODCLI').AsString := edtCliente.Text;

        If Not fEmptyStr(edtCodVendedor.Text) Then
          ParamByName('CODVEN').AsString := edtCodVendedor.Text;

        Open;
      End;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try
        frxRelatorio.DataSet := qryRelatorio;
        frxDocumentos.DataSet := qryRelDocumentos;
        frxReport := frxReportJ;

        frxReport.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
        frxReport.Script.Variables['NOMREL'] := 'RELATORIO DE SALDOS RESERVADOS';

        frxReport.Script.Variables['DATA_INICIO'] := mskDtaIni.Text;
        frxReport.Script.Variables['DATA_FINAL']  := mskDtaFin.Text;

        {****************}
        {* HEADER GRUPO *}
        {*************JZ*}
        If Not fEmptyStr(mskLinhaGrupo.Text) Then
          frxReport.Script.Variables['LINHAGRUPO']    := 'LINHA / GRUPO: ' + mskLinhaGrupo.Text + ' - ' + edtDesGrupo.Text
        Else
          frxReport.Script.Variables['LINHAGRUPO']    := 'LINHA / GRUPO: TODOS';

        {******************}
        {* HEADER PRODUTO *}
        {***************JZ*}
        If Not fEmptyStr(edtProdutos.Text) Then
          frxReport.Script.Variables['PRODUTOS'] := 'PRODUTO: ' + edtProdutos.Text + ' - ' + edtDesProduto.Text
        Else
          frxReport.Script.Variables['PRODUTOS'] := 'PRODUTOS: TODOS';

        {******************}
        {* HEADER MARCA   *}
        {***************JZ*}
        frxReport.Script.Variables['MARCA'] := fStrTitulo(edtMarca.Text,edtDesMarca,arrMarca,strMarca,'MARCA');

        {******************}
        {* HEADER CLIENTE *}
        {***************JZ*}
        If Not fEmptyStr(edtCliente.Text) Then
          frxReport.Script.Variables['CLIENTES'] := 'CLIENTE: ' + edtCliente.Text + ' - ' + edtDesCliente.Text
        Else
          frxReport.Script.Variables['CLIENTES'] := 'CLIENTES: TODOS';

        {*****************************************}
        {* FORNCEDOR                             *}
        {**************************************JZ*}
        frxReport.Script.Variables['FORNECEDOR'] := 'FORNECEDOR: ' + ifthen(fEmptyStr(edtFornecedor.Text), 'TODOS', edtFornecedor.Text + ' - ' + edtDesFornecedor.Text);

        {*****************************************}
        {* EMPRESA                               *}
        {**************************************JZ*}
        frxReport.Script.Variables['EMPRESA']  := 'EMPRESA: ' + ifthen(fEmptyStr(edtCodEmpresa.Text), 'TODOS', edtCodEmpresa.Text + ' - ' + edtDesEmpresa.Text);

        {*****************************************}
        {* VENDEDOR                              *}
        {**************************************JZ*}
        frxReport.Script.Variables['VENDEDOR'] := 'VENDEDOR: ' + ifthen(fEmptyStr(edtCodVendedor.Text), 'TODOS', edtCodVendedor.Text + ' - ' + edtDesVendedor.Text);

        {*****************************************}
        {* SITUAÇÃO                              *}
        {**************************************JZ*}
        Case rdgSituacao.ItemIndex Of
          0 : frxReport.Script.Variables['SITUACAO'] := 'SITUAÇÃO: ITENS QUE NÃO PODEM SER ATENDIDOS';
          1 : frxReport.Script.Variables['SITUACAO'] := 'SITUAÇÃO: ITENS QUE PODEM SER ATENDIDOS';
          2 : frxReport.Script.Variables['SITUACAO'] := 'SITUAÇÃO: TODOS OS ITENS';
        End;

        {**************************}
        {* HEADER GRUPO DE COMPRA *}
        {***********************VM*}
        If Not fEmptyStr(edtGruCmp.Text) Then
          frxReport.Script.Variables['GRUPO_COMPRA'] := 'GRUPO DE COMPRAS: ' + edtGruCmp.Text + ' - ' + edtDesGruCmp.Text
        Else
          frxReport.Script.Variables['GRUPO_COMPRA'] := 'GRUPO DE COMPRAS: TODOS';

        If frxReport.FindObject('mmoZebraSin') <> Nil Then
          TfrxMemoView(frxReport.FindObject('mmoZebraSin')).Highlight.Color := StrToIntDef(fCfgSis('CORZEB'), clSilver);

        If frxReport.FindObject('mmoZebraAn') <> Nil Then
          TfrxMemoView(frxReport.FindObject('mmoZebraAn')).Highlight.Color := StrToIntDef(fCfgSis('CORZEB'), clSilver);

        frxReport.Script.Variables['OPCAO'] := edtOpcao.Text;
        frxReport.Script.Variables['QUEBRA'] := edtQuebra.Text;

        If edtDestino.Text = 'E' Then
           pGeraExcel
        Else If edtDestino.Text = 'V' Then
          pPreviewReport(Self.Name, Self.Caption, frxReport)
        Else
          pPrintReport(Self.Name, Self.Caption, strNomImp, frxReport);

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;

    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;
  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelEstSaldoReservado.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODOS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtCodEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresa.Clear;
    pSetFocus(edtCodEmpresa);
  End;

end;

procedure TfrmRelEstSaldoReservado.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstSaldoReservado.edtCodVendedorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodVendedor, edtDesVendedor, arrVendedor, fRetNomVendRep,nil, 'do Vendedor');
end;

procedure TfrmRelEstSaldoReservado.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrVendedor) Then
  Begin
    If fValidaCampos(edtCodVendedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstSaldoReservado.edtDestinoExit(Sender: TObject);
begin
//  inherited;

end;

procedure TfrmRelEstSaldoReservado.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelEstSaldoReservado.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtProdutos);
  qryCliResumo              := fCriaQuery;
  dtsCliResumo              := TDataSource.Create(Self);
  dtsCliResumo.DataSet      := qryCliResumo;
end;

procedure TfrmRelEstSaldoReservado.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
  FreeAndNil(qryRelDocumentos);
  FreeAndNil(qryCliResumo);
end;

procedure TfrmRelEstSaldoReservado.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If ActiveControl Is TRadioButton Then
                 Self.SelectNext(ActiveControl, True, True);
    VK_ESCAPE: Close;
  End;

end;

procedure TfrmRelEstSaldoReservado.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
    edtDesFornecedor.Text := fRetNomFornecedor(edtFornecedor.Text);

  If fEmptyStr(edtDesFornecedor.Text) And (Not fEmptyStr(edtFornecedor.Text))  Then
  Begin
    fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
    edtFornecedor.Clear;
    pSetFocus(edtFornecedor);
  End;

end;

procedure TfrmRelEstSaldoReservado.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstSaldoReservado.edtGruCmpExit(Sender: TObject);
Var
  arrSel : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrSel, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmRelEstSaldoReservado.edtGruCmpKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel : TConsultasArray;
begin
  inherited;
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrSel, True) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstSaldoReservado.edtMarcaExit(Sender: TObject);
begin
  inherited;

//  pEdtCodSelectExit(edtMarca,edtDesMarca,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmRelEstSaldoReservado.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca, True) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelEstSaldoReservado.fFiltroEmpresaReservaPedido: String;
begin
  Result := '( IF(IFNULL(FGO_ENT_CD, "") = "S", FGO_EMP_CD, ' +
            '  IF(IFNULL(FGO_EMP_TE, "") <> "", FGO_EMP_TE, ' +
            '  IF(IFNULL(FGO_EMPFOR, "") <> "", FGO_EMPFOR, ' +
            '  IF(IFNULL(FDO_EMPITE, "") <> "", FDO_EMPITE, ' +
            '  IF(IFNULL(FGO_OPRFLJ, "") = "S", FDO_EMPPRD,FGO_CODEMP))))) )';
end;

Function TfrmRelEstSaldoReservado.fGetSQLClientes: String;
  Var
    strSQL: String;
Begin
  strSQL := 'SELECT ';
  strSQL := strSQL + ' CONCAT(FDO_NUMDOC,"-",FDO_ESPDOC) AS "NUMDOC", ';
  strSQL := strSQL + ' CONCAT(C.CLI_CODCLI, "  -") AS "CODCLI", ';
  strSQL := strSQL + ' C.CLI_NOMCLI AS "NOMCLI", ';
  strSQL := strSQL + ' FGO_PREVIS AS "PREVIS", ';
  strSQL := strSQL + ' FGO_CODVEN AS "CODVEN", ';
  strSQL := strSQL + ' SUM(FDO_QTDITE) AS SALTOT, ';
  strSQL := strSQL + ' SUM(FDO_QTDBAI) AS SALBAI, ';
  strSQL := strSQL + ' SUM(FDO_QTDITE - FDO_QTDBAI) AS SALRES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI C ';
  strSQL := strSQL + 'INNER JOIN FATDOR F ON F.FDO_CODCLI = C.CLI_CODCLI ';
  strSQL := strSQL + 'INNER JOIN FATGOR ON ';
  strSQL := strSQL + '  FDO_NUMDOC = FGO_NUMDOC AND ';
  strSQL := strSQL + '  FDO_ESPDOC = FGO_ESPDOC AND ';
  strSQL := strSQL + '  FDO_CODEMP = FGO_CODEMP     ';
  strSQL := strSQL + 'INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  strSQL := strSQL + 'WHERE '+ IfThen(rdgTipoSaldo.ItemIndex in [0, 2], 'TRUE AND', 'FALSE AND');

  if blnPrevisao Then
    strSQL := strSQL + '  FGO_PREVIS BETWEEN :DTAINI AND :DTAFIN AND '
  Else
    strSQL := strSQL + '  F.FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';

  strSQL := strSQL + '  F.FDO_CODITE = :CODITE AND ';
  strSQL := strSQL + '  FDO_JAFATU   = 0 AND ';
  strSQL := strSQL + '  (ROUND(F.FDO_QTDITE,2) - ROUND(F.FDO_QTDBAI,2)) > 0 AND ';
  strSQL := strSQL + '  FDO_ESPDOC   = "PD" ';

  If Not fEmptyStr(strCodEmp) Then
    strSQL := strSQL + '  AND ' + fFiltroEmpresaReservaPedido + ' = :CODEMP ';

  If (Not (fEmptyStr(strCodCli))) Or (Not (fEmptyStr(edtCliente.Text))) Then
    strSQL := strSQL + '  AND F.FDO_CODCLI = :CODCLI ';

  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSQL + '  NUMDOC, CODCLI, FGO_PREVIS ';

  strSQL := strSQL + 'UNION ALL ';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CONCAT(GAG_NUMENT,"-GA") AS "NUMDOC", ';
  strSQL := strSQL + '  CONCAT(GAG_CODCLI,"  -") AS "CODCLI", ';
  strSQL := strSQL + '  CLI_NOMCLI AS "NOMCLI", ';
  strSQL := strSQL + '  GAG_DTAENT AS "PREVIS", ';
  strSQL := strSQL + '  GAG_CODVEN AS "CODVEN", ';
  strSQL := strSQL + '  SUM(GAD_QTDREQ - IFNULL((SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = MOVGAD.AUTOINCREM ),0) ) AS SALTOT, ';
  strSQL := strSQL + '  SUM(GAD_QTDDEV) AS SALBAI, ';
  strSQL := strSQL + '  SUM(GAD_QTDREQ - GAD_QTDDEV - GAD_QTDPRE) AS SALRES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGAG INNER JOIN MOVGAD ON MOVGAG.AUTOINCREM = MOVGAD.GAD_SEQGAG ';
  strSQL := strSQL + '         INNER JOIN CADCLI ON MOVGAG.GAG_CODCLI = CADCLI.CLI_CODCLI ';
  strSQL := strSQL + 'WHERE '+ IfThen(rdgTipoSaldo.ItemIndex in [1, 2], 'TRUE AND', 'FALSE AND');;
  strSQL := strSQL + '  CAST(GAG_DTAENT AS DATE) BETWEEN :DTAINI AND :DTAFIN ';
  strSQL := strSQL + '  AND  IFNULL(GAD_QTDREQ,0) - IFNULL((SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = MOVGAD.AUTOINCREM ),0) > 0 ';
  strSQL := strSQL + '  AND GAD_CODITE = :CODITE ';

  If Not fEmptyStr(edtCodEmpresa.Text) Then
    strSQL := strSQL + '  AND GAG_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtCliente.Text) Then
    strSQL := strSQL + '  AND GAG_CODCLI = :CODCLI ';

  strSQL := strSQL + ' GROUP BY NUMDOC, CODCLI, PREVIS ';

  strSQL := 'SELECT * FROM ( ' + strSQL + ') A ';
  strSQL := strSQL + ' ORDER BY ';
  If blnOrdPrevisao Then
    strSQL := strSQL + '  PREVIS, NOMCLI  '
  Else
    strSQL := strSQL + '  NOMCLI, PREVIS  ';

  Result := strSQL;
End;

procedure TfrmRelEstSaldoReservado.pRetCliResumo;
begin

  With qryCliResumo Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fGetSQLClientes);
    ParamByName('CODITE').AsString := qryRelatorio.FieldByName('CODITE').AsString;
    ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
    ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

    If Not fEmptyStr(edtCliente.Text) Then
      ParamByName('CODCLI').AsString := edtCliente.Text;

    Open;
  End;
end;


procedure TfrmRelEstSaldoReservado.pGeraExcel;
  Var
    objGeraExcel: TGeraExcel;
begin
  fltTotFaltSobGer := 0;
  fltTotFaltSobGrp := 0;
  fltTotFaltSobLin := 0;
  fltTotFaltSobIte := 0;

  objGeraExcel := TGeraExcel.Create(qryRelatorio, pgbProgresso);

  With objGeraExcel Do
  Begin
    If edtOpcao.Text = 'A' Then
      strNomRel := 'RELATORIO DE SALDOS RESERVADOS - ANALITICO'
    else
      strNomRel := 'RELATORIO DE SALDOS RESERVADOS - SINTÉTICO';

    If (Not fEmptyStr(mskDtaIni.Text)) and
       (Not fEmptyStr(mskDtaFin.Text)) Then
      AddFiltro('REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);

    If edtOpcao.Text = 'A' Then
    Begin
      Case edtQuebra.Text[1] Of
        'L': Begin
               AddQuebra('LINDES', 'LINHA: ');
               AddQuebra('DESGRU', 'GRUPO: ');
             End;
      End;
    End;

    If (Not fEmptyStr(mskLinhaGrupo.Text)) Then
      AddFiltro('LINHA/GRUPO: ' + mskLinhaGrupo.Text + ' - ' + edtDesGrupo.Text)
    Else
      AddFiltro('LINHA/GRUPO: TODOS');

    If (Not fEmptyStr(edtProdutos.Text)) Then
      AddFiltro('PRODUTOS: ' + edtProdutos.Text + ' - ' + edtDesProduto.Text)
    Else
      AddFiltro('PRODUTOS: TODOS');

    If (Not fEmptyStr(edtGruCmp.Text)) Then
      AddFiltro('GRUPO DE COMPRAS: ' + edtGruCmp.Text + ' - ' + edtDesGruCmp.Text)
    Else
      AddFiltro('GRUPO DE COMPRAS: TODOS');

    AddFiltro(fStrTitulo(edtMarca.Text,edtDesMarca,arrMarca,strMarca,'MARCA'));

    If (Not fEmptyStr(edtFornecedor.Text)) Then
      AddFiltro('FORNECEDOR: ' + edtFornecedor.Text + ' - ' + edtDesFornecedor.Text)
    Else
      AddFiltro('FORNECEDOR: TODOS');

    If (Not fEmptyStr(edtCliente.Text)) Then
      AddFiltro('CLIENTES: ' + edtCliente.Text + ' - ' + edtDesCliente.Text)
    Else
      AddFiltro('CLIENTES: TODOS');

    If (Not fEmptyStr(edtCodEmpresa.Text)) Then
      AddFiltro('EMPRESA: ' + edtCodEmpresa.Text + ' - ' + edtDesEmpresa.Text)
    Else
      AddFiltro('EMPRESA: TODAS');

    If (Not fEmptyStr(edtCodVendedor.Text)) Then
      AddFiltro('VENDEDOR: ' + edtCodVendedor.Text + ' - ' + edtDesVendedor.Text)
    Else
      AddFiltro('VENDEDOR: TODOS');

    Case rdgPeriodo.ItemIndex Of
      0: AddFiltro('PERÍODO: ENTRADA');
      1: AddFiltro('PERÍODO: PREVISÃO');
    End;

    Case rdgSituacao.ItemIndex Of
      0: AddFiltro('SITUAÇÃO: ITENS QUE NÃO PODEM SER ATENDIDOS');
      1: AddFiltro('SITUAÇÃO: ITENS QUE PODEM SER ATENDIDOS');
      2: AddFiltro('SITUAÇÃO: TODOS OS ITENS');
    End;

    Case rdgOrdenacao.ItemIndex Of
      0: AddFiltro('ORDENAR PEDIDOS POR: CLIENTE');
      1: AddFiltro('ORDENAR PEDIDOS POR: DATA DE PREVISÃO');
    End;

    AddCampo('CODITE'  , 'CODIGO');
    AddCampo('DESITE'  , 'DESCRICAO');
    AddCampo('REFERE'  , 'REFERENCIA');
    AddCampo('DESUNI'  , 'UNIDADE');
    AddCampo('DESMAR'  , 'MARCA');

    If edtOpcao.Text = 'A' Then
    AddCampo('NOMOPE'  , 'VENDEDOR');

    AddCampo('SALDO'    , 'SALDO');
    AddCampo('QTDPEN'   , 'PED. COM.');
    AddCampo('SALRES'   , 'RESERV.');
    AddCampo(fRetFALTSOB, 'FALTSOB', 'FALT/SOB');

    AddTotais('SALDO');
    AddTotais('QTDPEN');
    AddTotais('SALRES');
    AddTotais('FALTSOB');

    objGeraExcel.OnMontaResumo := pMontaResumo;
    objGeraExcel.OnSomaResumo := pSomaTotais;

    If edtOpcao.Text = 'A' Then
      OnImpDetalhes := pImpDetalhes;

    If fGerarRelatorio Then
    Begin
      fMensagem('','Arquivo gerado com sucesso!',['&OK']);
      strArqPDF := objExcel.NomeArquivo;
    End;

    FreeAndNil(objGeraExcel);

  End;
End;

procedure TfrmRelEstSaldoReservado.pAcumulaTotais;
Begin
  // Alimenta as variáveis utilizadas no totalizador do excel
  fltTotFaltSobGer := fltTotFaltSobGer + (qryRelatorio.FieldByName('SALDO').AsFloat  +
                                          qryRelatorio.FieldByName('QTDPEN').AsFloat -
                                          qryRelatorio.FieldByName('SALRES').AsFloat);

  fltTotFaltSobGrp := fltTotFaltSobGrp + (qryRelatorio.FieldByName('SALDO').AsFloat  +
                                          qryRelatorio.FieldByName('QTDPEN').AsFloat -
                                          qryRelatorio.FieldByName('SALRES').AsFloat);

  fltTotFaltSobLin := fltTotFaltSobLin + (qryRelatorio.FieldByName('SALDO').AsFloat  +
                                          qryRelatorio.FieldByName('QTDPEN').AsFloat -
                                          qryRelatorio.FieldByName('SALRES').AsFloat);

  fltTotFaltSobIte := fltTotFaltSobIte + (qryRelatorio.FieldByName('SALDO').AsFloat  +
                                          qryRelatorio.FieldByName('QTDPEN').AsFloat -
                                          qryRelatorio.FieldByName('SALRES').AsFloat);
End;

procedure TfrmRelEstSaldoReservado.pImpDetalhes(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; CorFundo: TCorExcel);
begin
  With Excel Do
  Begin
    pRetCliResumo;

    With qryCliResumo Do
    Begin
      If Not (IsEmpty) Then
      Begin
        First;
        While Not (Eof) do
        Begin
          ProximaLinha;
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESITE'].Coluna, FieldByName('CODCLI').AsString + FieldByName('NOMCLI').AsString);
          Escrever(LinhaAtual, Campos.ColunaPorNome['REFERE'].Coluna, fPadL(FormatFloat('##,#0.00',FieldByName('SALTOT').AsFloat), 14));
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESUNI'].Coluna, fPadL(FormatFloat('##,#0.00',FieldByName('SALRES').AsFloat), 14));
          Escrever(LinhaAtual, Campos.ColunaPorNome['DESMAR'].Coluna, fPadL(FormatFloat('##,#0.00',FieldByName('SALBAI').AsFloat), 14));
          Escrever(LinhaAtual, Campos.ColunaPorNome['NOMOPE'].Coluna, FieldByName('PREVIS').AsString);
          Escrever(LinhaAtual, Campos.ColunaPorNome['SALDO'].Coluna, FieldByName('NUMDOC').AsString);
          Escrever(LinhaAtual, Campos.ColunaPorNome['QTDPEN'].Coluna, FieldByName('CODVEN').AsString);

          Mesclar    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.ColunaPorNome['DESITE'].Coluna) + IntToStr(LinhaAtual));
          Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
          CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Preto);
          Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
          Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);

          Next;
        End;
      End;
    End;

  End;
end;

procedure TfrmRelEstSaldoReservado.pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
  Var
    strLinIni: String;
begin
  With Excel Do
  Begin
    ProximaLinha;

    strLinIni := IntToStr(LinhaAtual);

    If (Quebra.NomeCampo = 'LINDES') Then
      Escrever(LinhaAtual, 1, 'TOTAL LINHA: ')
    else
      If (Quebra.NomeCampo = 'DESGRU') Then
      Escrever(LinhaAtual, 1, 'TOTAL GRUPO: ')
    else
      If (Quebra.NomeCampo = 'DESITE') Then
      Escrever(LinhaAtual, 1, 'TOTAL PRODUTO: ')
    else
      Escrever(LinhaAtual, 1, 'TOTAL GERAL: ');

    Escrever(LinhaAtual, Campos.ColunaPorNome['SALDO'].Coluna,  Quebra.Totais['SALDO']);
    Escrever(LinhaAtual, Campos.ColunaPorNome['QTDPEN'].Coluna,  Quebra.Totais['QTDPEN']);
    Escrever(LinhaAtual, Campos.ColunaPorNome['SALRES'].Coluna,  Quebra.Totais['SALRES']);

    If (Quebra.NomeCampo = 'LINDES') Then
    Begin
      Escrever(LinhaAtual, Campos.ColunaPorNome['FALTSOB'].Coluna,  fltTotFaltSobLin);
      fltTotFaltSobLin := 0;
    End
    else
      If (Quebra.NomeCampo = 'DESGRU') Then
      Begin
        Escrever(LinhaAtual, Campos.ColunaPorNome['FALTSOB'].Coluna,  fltTotFaltSobGrp);
        fltTotFaltSobGrp := 0;
      End
    else
      If (Quebra.NomeCampo = 'DESITE') Then
      Begin
        Escrever(LinhaAtual, Campos.ColunaPorNome['FALTSOB'].Coluna,  fltTotFaltSobIte);
        fltTotFaltSobIte := 0;
      End
    else
      Begin
        Escrever(LinhaAtual, Campos.ColunaPorNome['FALTSOB'].Coluna,  fltTotFaltSobGer);
        fltTotFaltSobGer := 0;
      End;

    FormatoNumerico('B' + strLinIni, fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));

    Negrito    ('A' + strLinIni, fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + strLinIni, fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), CinzaEscuro);
    CorFonte   ('A' + strLinIni, fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
    Bordas     ('A' + strLinIni, fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
    Alinhamento('A' + strLinIni, fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);
  End;
end;

procedure TfrmRelEstSaldoReservado.pSomaTotais(var Totais: TTotais; Dados: TDataSet);
begin
  Totais['SALDO']   := Totais['SALDO']    + Dados.FieldByName('SALDO').AsFloat;
  Totais['QTDPEN']  := Totais['QTDPEN']   + Dados.FieldByName('QTDPEN').AsFloat;
  Totais['SALRES']  := Totais['SALRES']   + Dados.FieldByName('SALRES').AsFloat;
  Totais['FALTSOB'] := Totais['FALTSOB']  + fRetFALTSOB;

  pAcumulaTotais;
end;



procedure TfrmRelEstSaldoReservado.rdgSituacaoClick(Sender: TObject);
begin
  inherited;
  ckbPedCom.Visible := (rdgSituacao.ItemIndex < 2);
end;

end.

