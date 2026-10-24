unit untRelFatRelOrc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Mask, MaskEditFocus, RLFilters, RLDraftFilter,
  Menus, StdCtrls, EditFocus, QColorLabel, Buttons, ExtCtrls, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, Uni, AppEvnts, untTypesSistema,
  BitBtnLockedIncrem, frxExportCSVTestabilidade, untGeraExcel, untExcel, DB,
  Vcl.ComCtrls;

type
  TfrmRelFatRelOrc = class(TfrmPaiRelatorio)
    Label11: TLabel;
    lblDesDtaIni: TLabel;
    lblDesDtaFin: TLabel;
    Label12: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label1: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    gpbTipo: TGroupBox;
    edtTipo: TEditFocus;
    Label2: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    gpbSituacao: TGroupBox;
    Label16: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    Label4: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    Label3: TLabel;
    mskLinhaGrupo2: TMaskEditFocus;
    edtDesGrupo2: TEditFocus;
    edtSituacao: TEditFocus;
    lbTodos: TColorLabel;
    lbFaturados: TColorLabel;
    lbNaoFaturados: TColorLabel;
    lbBaixadosNaoFat: TColorLabel;
    lbl5: TColorLabel;
    pnlDados2: TPanel;
    chkMsgs: TCheckBox;
    chkAgrVend: TCheckBox;
    pnlOcorrencia: TPanel;
    Label5: TLabel;
    edtCodOco: TEditFocus;
    edtDesOco: TEditFocus;
    ColorLabel2: TColorLabel;
    ColorLabel3: TColorLabel;
    pbProgresso: TProgressBar;
    pnlFaseObra: TPanel;
    Label6: TLabel;
    edtCodFase: TEditFocus;
    edtDesFase: TEditFocus;
    edtDesRepresentante: TEditFocus;
    Label7: TLabel;
    edtCodRepresentante: TEditFocus;
    gpbVendedor: TGroupBox;
    lblVendedor: TColorLabel;
    edtVendedor: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoEnter(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupo2Exit(Sender: TObject);
    procedure mskLinhaGrupo2KeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOcoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOcoExit(Sender: TObject);
    procedure edtCodFaseExit(Sender: TObject);
    procedure edtCodFaseKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepresentanteExit(Sender: TObject);
    procedure edtCodRepresentanteKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }

    procedure pGeraExcel(qryDados: TUniQuery);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotais(Var Totais: TTotais; Dados: TDataSet);
    procedure pImprimeDetalhes(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    procedure pImpTitGrupo(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras);
    function fRetTitSituacao: String;

  public
    { Public declarations }
    arrCliente,
    arrVendedor,
    arrRepresentante,
    arrEmpresa,
    arrRede,
    arrGruLinIni,
    arrGruLinFin,
    arrOcor,
    arrFase       : TConsultasArray;
    QryRel        : TUniQuery;

    strCliente      : String;
    strVendedor     : String;
    strRepresentante: String;
    strEmpresa      : String;
    strRede         : String;
    strOcorrencia   : String;
    strFase         : String;
 protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelFatRelOrc: TfrmRelFatRelOrc;


implementation

uses untQckFatRelOrc, untFuncoesFactory, untIFuncoes, untClassPanelCx;

{$R *.dfm}

procedure TfrmRelFatRelOrc.FormShow(Sender: TObject);
begin
  frxRelatorio.DataSet := QryRel;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);

  If fCfgSis('FASOBR') = 'S' Then
  Begin
    pnlFaseObra.Visible := True;
    Self.Height         := 595 + pnlFaseObra.Height;
  End
  Else
  Begin
    pnlFaseObra.Visible := False;
    Self.Height         := 595;
  End;

  inherited;

  pSetFocus(mskDtaIni);

  gpbVendedor.Enabled := (fCfgSis('REPVEN', varBoolean));
  If (Not gpbVendedor.Enabled) Then edtVendedor.Text := '1';
end;

procedure TfrmRelFatRelOrc.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  If Not edtCodCliente.ReadOnly Then
    pEdtCodSelectExit(edtCodCliente, edtDesCliente, arrCliente, Nil, fRetNomCliente, 'do cliente');

  If Not fEmptyStr(edtCodCliente.Text) Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
    pSetFocus(edtCodVendedor);
  End Else
  Begin
    edtCodRede.Enabled := True;
    pSetFocus(edtCodRede);
  End;
end;

procedure TfrmRelFatRelOrc.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatRelOrc.edtCodVendedorExit(Sender: TObject);
begin
  inherited;
  If Not edtCodVendedor.ReadOnly Then
    pEdtCodSelectExit(edtCodVendedor, edtDesVendedor, arrVendedor, fRetNomVendRep,nil,'do Vendedor');
end;

procedure TfrmRelFatRelOrc.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrVendedor, False) Then
  Begin
    If fValidaCampos(edtCodVendedor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatRelOrc.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  If Not edtCodEmpresa.ReadOnly Then
    pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelFatRelOrc.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True) Then
  Begin
    fValidaCampos(edtCodEmpresa,False);
    self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatRelOrc.edtCodFaseExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFase,edtDesFase,arrFase,nil,fRetNomFaseObra,'da fase da obra');
end;

procedure TfrmRelFatRelOrc.edtCodFaseKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqFaseObra(Self, edtCodFase, edtDesFase, Nil, Key, arrFase, False) Then
  Begin
    If fValidaCampos(edtCodFase, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatRelOrc.edtCodOcoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodOco,edtDesOco,arrOcor,nil,fRetDescOcorrencia,'da ocorrência');
end;

procedure TfrmRelFatRelOrc.edtCodOcoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE OCORRÊNCIAS *}
  {*****************************RV*}
  If fPesqOcorrencia(Self, edtCodOco, edtDesOco, Nil, Key, arrOcor, False) Then
  Begin
    If fValidaCampos(edtCodOco, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatRelOrc.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede');
end;

procedure TfrmRelFatRelOrc.edtCodRedeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {**********************************}
  {* NOVA CONSULTA DE REDE DE LOJAS *}
  {*******************************RV*}
  If fPesqRedeLojas(Self, edtCodRede, edtDesRede, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRede, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatRelOrc.edtCodRepresentanteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRepresentante, edtDesRepresentante, arrRepresentante, fRetNomVendRep,nil,'do Representante');
end;

procedure TfrmRelFatRelOrc.edtCodRepresentanteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodRepresentante, edtDesRepresentante, nil, Key, arrRepresentante, False) Then
  Begin
    If fValidaCampos(edtCodRepresentante, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatRelOrc.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;

  function fRetSQLAnalitico: String;
  begin
    Result := '';
    Result := Result + 'SELECT SQL_NO_CACHE ';
    Result := Result + '  CONCAT(FDO_NUMDOC,"-",FDO_ESPDOC) AS NUMDOC, ';
    Result := Result + '  FDO_DTAENT AS DTAENT, ';
    Result := Result + '  CONCAT(FDO_CODVEN,"-",OPE_NOMOPE) AS CODVEN, ';
    Result := Result + '  CONCAT(FDO_CODCLI,"-",IF(FGO_NOMCON IS NULL, CLI_NOMCLI, FGO_NOMCON)) AS NOMCLI, ';
    Result := Result + '  IF(IFNULL(FGO_NOMCON,"") = "", CLI_FONE01, FGO_TELCON) AS TELCLI, ';
    Result := Result + '  CONCAT(LEFT(GRU_CODGRU,3),".",RIGHT(GRU_CODGRU,3),".",FDO_CODITE) AS CODITE, ';
    Result := Result + '  FDO_DESCRI AS DESCRI, ';
    Result := Result + '  FDO_CODEMP AS CODEMP, ';
    Result := Result + '  FDO_QTDITE - FDO_QTDBAI AS QTDITE, ';
    Result := Result + '  FDO_UNITAR AS UNITAR, ';
    Result := Result + '  FDO_TOTITE AS TOTITE, ';
    Result := Result + '  FDO_VALRET AS VALRET, ';
    Result := Result + '  FDO_VALIPI AS VALIPI, ';
    Result := Result + '  0' + fRelSqlValorReformaFdoRef('FATDOR.AUTOINCREM') + ' AS VALREF, ';
    Result := Result + '  FDO_TOTFRE AS VALFRE, ';
    Result := Result + '  FDO_CONPAG AS CONPAG, ';
    Result := Result + '  FGO_MEN001 AS MEN001, ';
    Result := Result + '  FGO_MEN002 AS MEN002, ';
    Result := Result + '  FDO_DESESP AS DESESP, ';
    Result := Result + '  CONCAT(FGO_MOTBAI," ",IF(IFNULL(FGO_CODOCO,0) = 0,"",CONCAT("OCORRÊNCIA: ", OCO_DESOCO))) AS MOTBAI ';
    Result := Result + 'FROM ';
    Result := Result + '  FATDOR ';
    Result := Result + '  INNER JOIN FATGOR ON FDO_SEQGER = FATGOR.AUTOINCREM ';
    Result := Result + '  INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
    Result := Result + '  INNER JOIN CADCLI ON FDO_CODCLI = CLI_CODCLI ';
    Result := Result + '  INNER JOIN CADOPE ON FDO_CODVEN = OPE_CODOPE ';
    Result := Result + '  INNER JOIN CADITE ON ITE_CODITE = FDO_CODITE ';
    Result := Result + '  INNER JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU ';
    Result := Result + '  LEFT  JOIN CADOCO ON OCO_CODOCO = FGO_CODOCO ';
    Result := Result + 'WHERE ';
    Result := Result + '  FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    Result := Result + '  FDO_ESPDOC = "OR" ';

    If edtSituacao.Text = 'N' Then
      Result := Result + '  AND FDO_JAFATU = 0 '
    Else If edtSituacao.Text = 'J' Then
      Result := Result + '  AND ((FDO_JAFATU = 1) AND (IFNULL(TRIM(FGO_MOTBAI), "") = "") AND (IFNULL(TRIM(FDO_NUMFAT), "") <> "") AND (IFNULL(TRIM(FDO_TIPFAT), "") <> "")) '
    Else If edtSituacao.Text = 'B' Then
      Result := Result + '  AND ((FDO_JAFATU = 1) AND (IFNULL(TRIM(FGO_MOTBAI), "") <> "") AND (IFNULL(TRIM(FDO_NUMFAT), "") = "") AND (IFNULL(TRIM(FDO_TIPFAT), "") = "")) ';

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
    Begin
      If RightStr(mskLinhaGrupo.Text,3) = '000' Then
      Begin
        If Not fEmptyStr(mskLinhaGrupo2.Text) Then
        Begin
          If RightStr(mskLinhaGrupo2.Text,3) = '000' Then
            Result := Result + '  AND LEFT(ITE_CODGRU,3) BETWEEN LEFT(:CODGRU,3) AND LEFT(:CODGRU2,3) '
          Else
            Result := Result + '  AND ITE_CODGRU BETWEEN CONCAT(LEFT(:CODGRU,3),"000") AND :CODGRU2 ';
        End
        Else
          Result := Result + '  AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) ';
      End
      Else
      Begin
        If Not fEmptyStr(mskLinhaGrupo2.Text) Then
        Begin
          If RightStr(mskLinhaGrupo2.Text,3) = '000' Then
            Result := Result + '  AND ITE_CODGRU BETWEEN :CODGRU AND CONCAT(LEFT(:CODGRU2,3),"099") '
          Else
            Result := Result + '  AND ITE_CODGRU BETWEEN :CODGRU AND :CODGRU2 ';
        End
        Else
          Result := Result + '  AND ITE_CODGRU = :CODGRU ';
      End;
    End;

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      Result := Result + fStrLocateEmpresa(edtCodEmpresa, arrEmpresa, 'FDO_CODEMP', 'CODEMP')
    Else
      Result := Result + '  AND LOCATE(FDO_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    Result := Result + fStrLocate(edtCodCliente, arrCliente, 'CLI_CODCLI', 'CODCLI');
    Result := Result + fStrLocate(edtCodVendedor, arrVendedor, 'OPE_CODOPE','CODVEN');
    Result := Result + fStrLocate(edtCodRepresentante, arrRepresentante, 'FDO_CODREP','CODREP');
    Result := Result + fStrLocate(edtCodOco, arrOcor, 'FGO_CODOCO','CODOCO');
    Result := Result + fStrLocate(edtCodFase, arrFase, 'EXTGOR.FGO_FASOBR','CODFAS');
    Result := Result + fStrLocate(edtCodRede,arrRede,'CLI_CODRED','CODRED');

    If (edtVendedor.Text = '2') Then
      Result := AnsiReplaceStr(Result, 'FDO_CODVEN', 'FDO_CODVE2');
  End;

begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;
  // VARIAVEIS DO GERA EXCEL
  inherited;

  If blnImprime Then
  Begin

    {******************************}
    {* SELECT RELATORIO ANALITICO *}
    {***************************LB*}
    If edtTipo.Text = 'A' Then
    Begin

      strSQL := fRetSQLAnalitico;

      strSQL := strSQL + 'ORDER BY ';
      If Not chkAgrVend.Checked Then
        strSQL := strSQL + '  NUMDOC '
      Else
        strSQL := strSQL + '  CODVEN, NUMDOC ';

    End

    {******************************}
    {* SELECT RELATORIO SINTETICO *}
    {***************************LB*}
    Else
    Begin

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  NUMDOC, ';
      strSQL := strSQL + '  DTAENT, ';
      strSQL := strSQL + '  CODVEN, ';
      strSQL := strSQL + '  NOMCLI, ';
      strSQL := strSQL + '  TELCLI, ';
      strSQL := strSQL + '  CODEMP, ';
      strSQL := strSQL + '  MEN001, ';
      strSQL := strSQL + '  MEN002, ';
      strSQL := strSQL + '  MOTBAI, ';
      strSQL := strSQL + '  SUM((TOTITE+VALRET+VALFRE+VALIPI+VALREF)-DESESP) AS TOTITE  ';
      strSQL := strSQL + 'FROM ('+fRetSQLAnalitico+') AS SQL_ANL ';

      strSQL := strSQL + 'GROUP BY NUMDOC ';

      strSQL := strSQL + 'ORDER BY ';
      If Not chkAgrVend.Checked Then
        strSQL := strSQL + '  NUMDOC '
      Else
        strSQL := strSQL + '  CODVEN, NUMDOC ';

    End;

    QryRel := fCriaQuery;

    With QryRel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQl);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
        ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;

      If Not fEmptyStr(mskLinhaGrupo2.Text) Then
        ParamByName('CODGRU2').AsString := mskLinhaGrupo2.Text;

      pSetaParam(edtCodCliente.Text, arrCliente, strCliente, 'CODCLI', QryRel);
      pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', QryRel);
      pSetaParam(edtCodVendedor.Text, arrVendedor, strVendedor, 'CODVEN', QryRel);
      pSetaParam(edtCodRepresentante.Text, arrRepresentante, strRepresentante, 'CODREP', QryRel);
      pSetaParam(edtCodOco.Text, arrOcor, strOcorrencia, 'CODOCO', QryRel);
      pSetaParam(edtCodRede.Text, arrRede, strRede, 'CODRED', QryRel);
      pSetaParam(edtCodFase.Text, arrFase, strFase, 'CODFAS', QryRel);

      Open;
    End;

    If Not QryRel.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmQckFatRelOrc,frmQckFatRelOrc);

        frmQckFatRelOrc.rllTitMsg01.Visible  := False;
        frmQckFatRelOrc.rldValMsg011.Visible := False;
        frmQckFatRelOrc.rldValMsg012.Visible := False;

        frmQckFatRelOrc.rllTitMsg02.Visible  := False;
        frmQckFatRelOrc.rldValMsg021.Visible := False;
        frmQckFatRelOrc.rldValMsg022.Visible := False;

        frmQckFatRelOrc.rllTitMsg03.Visible  := False;
        frmQckFatRelOrc.rldValMsg031.Visible := False;
        frmQckFatRelOrc.rldValMsg032.Visible := False;

        frmQckFatRelOrc.rllTitMsg04.Visible  := False;
        frmQckFatRelOrc.rldValMsg041.Visible := False;
        frmQckFatRelOrc.rldValMsg042.Visible := False;

        If (edtSituacao.Text = 'B') Then
        Begin
          frmQckFatRelOrc.rlbTituloGrupo.Height := 57;
          frmQckFatRelOrc.RLBand3.Height        := 57;
          frmQckFatRelOrc.RLBand7.Height        := 30;
          frmQckFatRelOrc.rlbDetalhe.Height     := 30;
          frmQckFatRelOrc.rllMOTBAI.Visible     := True;
          frmQckFatRelOrc.rllMOTBAI1.Visible    := True;
          frmQckFatRelOrc.rllMOTBAI2.Visible    := True;
          frmQckFatRelOrc.rllMOTBAI3.Visible    := True;
        End
        Else
        Begin
          frmQckFatRelOrc.rllTitMsg01.Top       := frmQckFatRelOrc.rllTitMsg01.Top - 14;
          frmQckFatRelOrc.rldValMsg011.Top      := frmQckFatRelOrc.rldValMsg011.Top - 14;
          frmQckFatRelOrc.rldValMsg012.Top      := frmQckFatRelOrc.rldValMsg012.Top - 14;
          frmQckFatRelOrc.rllTitMsg02.Top       := frmQckFatRelOrc.rllTitMsg02.Top - 14;
          frmQckFatRelOrc.rldValMsg021.Top      := frmQckFatRelOrc.rldValMsg021.Top - 14;
          frmQckFatRelOrc.rldValMsg022.Top      := frmQckFatRelOrc.rldValMsg022.Top - 14;
          frmQckFatRelOrc.rllTitMsg03.Top       := frmQckFatRelOrc.rllTitMsg03.Top - 14;
          frmQckFatRelOrc.rldValMsg031.Top      := frmQckFatRelOrc.rldValMsg031.Top - 14;
          frmQckFatRelOrc.rldValMsg032.Top      := frmQckFatRelOrc.rldValMsg032.Top - 14;
          frmQckFatRelOrc.rllTitMsg04.Top       := frmQckFatRelOrc.rllTitMsg04.Top - 14;
          frmQckFatRelOrc.rldValMsg041.Top      := frmQckFatRelOrc.rldValMsg041.Top - 14;
          frmQckFatRelOrc.rldValMsg042.Top      := frmQckFatRelOrc.rldValMsg042.Top - 14;
          frmQckFatRelOrc.rlbTituloGrupo.Height := 45;
          frmQckFatRelOrc.RLBand3.Height        := 45;
          frmQckFatRelOrc.RLBand7.Height        := 17;
          frmQckFatRelOrc.rlbDetalhe.Height     := 17;
          frmQckFatRelOrc.rllMOTBAI.Visible     := False;
          frmQckFatRelOrc.rllMOTBAI1.Visible    := False;
          frmQckFatRelOrc.rllMOTBAI2.Visible    := False;
          frmQckFatRelOrc.rllMOTBAI3.Visible    := False;
        End;

        If strTipImp = 'M' Then
          frmQckFatRelOrc.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckFatRelOrc.qckPagina.DefaultFilter := Nil;

        {********************}
        {* CABEÇALHO DO QCK *}
        {*****************LB*}
        frmQckFatRelOrc.strOrdem := 'REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
        frmQckFatRelOrc.rllCliente.Caption := fStrTitulo(edtCodCliente.Text, edtDesCliente, arrCliente, strCliente, 'CLIENTE');
        frmQckFatRelOrc.rllRedeLoja.Caption := fStrTitulo(edtCodRede.Text, edtDesRede, arrRede, strRede, 'REDE DE LOJAS', True);
        frmQckFatRelOrc.rllVendedor.Caption := fStrTitulo(edtCodVendedor.Text, edtDesVendedor, arrVendedor, strVendedor, 'VENDEDOR');
        frmQckFatRelOrc.rllRepresentante.Caption := fStrTitulo(edtCodRepresentante.Text, edtDesRepresentante, arrRepresentante, strRepresentante, 'REPRESENTANTE');
        frmQckFatRelOrc.rllOcorrencia.Caption := fStrTitulo(edtCodOco.Text, edtDesOco, arrOcor, strOcorrencia, 'OCORRÊNCIA', True);
        frmQckFatRelOrc.rllEmpresa.Caption := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA', True);
        If fCfgSis('FASOBR') = 'S' Then
         frmQckFatRelOrc.rllFaseObra.Caption := fStrTitulo(edtCodFase.Text, edtDesFase, arrFase, strFase, 'FASE DA OBRA', True);
        frmQckFatRelOrc.rllSituacao.Caption := fRetTitSituacao;
        frmQckFatRelOrc.rllGrupo.Caption := 'LINHA/GRUPO INICIAL: ' + IFThen(fEmptyStr(mskLinhaGrupo.Text), 'TODAS', mskLinhaGrupo.Text + ' - ' + edtDesGrupo.Text);
        frmQckFatRelOrc.rllGrupoFin.Caption := 'LINHA/GRUPO FINAL: ' + IFThen(fEmptyStr(mskLinhaGrupo.Text), 'TODAS', mskLinhaGrupo2.Text + ' - ' + edtDesGrupo2.Text);
        frmQckFatRelOrc.rllOpcVen.Caption := 'OPÇÃO DE VENDEDOR: VENDEDOR ' + edtVendedor.Text;

        If edtTipo.Text = 'A' Then
        Begin
          frmQckFatRelOrc.rllNomeRelatorio.Caption := 'RELATÓRIO DE ORÇAMENTOS - ANALÍTICO ';
          frmQckFatRelOrc.rlbTitulo.Visible := True;
          frmQckFatRelOrc.rlbSumario.Borders.DrawTop := False;

          If chkAgrVend.Checked Then
          Begin
            frmQckFatRelOrc.rlbGrupo.Visible     := False;
            frmQckFatRelOrc.rlbGroupVend.Visible := True;

            If chkMsgs.Checked Then
            Begin
              If (edtSituacao.Text = 'B') Then
                frmQckFatRelOrc.RLBand3.Height       := 83
              Else
                frmQckFatRelOrc.RLBand3.Height       := 70;

              frmQckFatRelOrc.rllTitMsg02.Visible  := True;
              frmQckFatRelOrc.rldValMsg021.Visible := True;
              frmQckFatRelOrc.rldValMsg022.Visible := True;
            End;
          End
          Else
          Begin
            frmQckFatRelOrc.rlbGrupo.Visible     := True;
            frmQckFatRelOrc.rlbGroupVend.Visible := False;

            If chkMsgs.Checked Then
            Begin
              If (edtSituacao.Text = 'B') Then
                frmQckFatRelOrc.rlbTituloGrupo.Height := 83
              Else
                frmQckFatRelOrc.rlbTituloGrupo.Height := 70;

              frmQckFatRelOrc.rllTitMsg01.Visible   := True;
              frmQckFatRelOrc.rldValMsg011.Visible  := True;
              frmQckFatRelOrc.rldValMsg012.Visible  := True;
            End;
          End;

        End
        Else
        Begin
          frmQckFatRelOrc.rllNomeRelatorio.Caption := 'RELATÓRIO DE ORÇAMENTOS - SINTÉTICO ';
          frmQckFatRelOrc.rlbTituloSint.Visible := True;

          If chkAgrVend.Checked Then
          Begin
            frmQckFatRelOrc.rlbDetalhe.Visible       := False;
            frmQckFatRelOrc.rlbGrupoVendSint.Visible := True;
            frmQckFatRelOrc.rllTitVend.Visible       := False;
            frmQckFatRelOrc.RLLabel15.Left           := frmQckFatRelOrc.RLDBText33.Left;

            If chkMsgs.Checked Then
            Begin
              If (edtSituacao.Text = 'B') Then
                frmQckFatRelOrc.RLBand7.Height       := 55
              Else
                frmQckFatRelOrc.RLBand7.Height       := 42;

              frmQckFatRelOrc.rllTitMsg03.Visible  := True;
              frmQckFatRelOrc.rldValMsg031.Visible := True;
              frmQckFatRelOrc.rldValMsg032.Visible := True;
            End;
          End
          Else
          Begin
            frmQckFatRelOrc.rlbDetalhe.Visible       := True;
            frmQckFatRelOrc.rlbGrupoVendSint.Visible := False;
            frmQckFatRelOrc.rllTitVend.Visible       := True;
            frmQckFatRelOrc.RLLabel15.Left           := frmQckFatRelOrc.RLDBText16.Left;

            If chkMsgs.Checked Then
            Begin
              If (edtSituacao.Text = 'B') Then
                frmQckFatRelOrc.rlbDetalhe.Height    := 55
              Else
                frmQckFatRelOrc.rlbDetalhe.Height    := 42;

              frmQckFatRelOrc.rllTitMsg04.Visible  := True;
              frmQckFatRelOrc.rldValMsg041.Visible := True;
              frmQckFatRelOrc.rldValMsg042.Visible := True;
            End;
          End;

        End;

        frmQckFatRelOrc.dtsRelatorio.DataSet := QryRel;

        If strTipImp = 'M' Then
          pRemoveAcentoObjRelFortes(TForm(frmQckFatRelOrc));

        If edtDestino.Text = 'V' Then
          frmQckFatRelOrc.qckPagina.PreviewModal
        Else If edtDestino.Text = 'I' Then
          frmQckFatRelOrc.qckPagina.Print
        else If edtDestino.Text = 'E' Then
          pGeraExcel(QryRel);

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;

      pFreeAndNil(frmQckFatRelOrc);

    End
    Else
      pTabelaVazia;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';
End;

function TfrmRelFatRelOrc.fRetTitSituacao: String;
begin
  Result := '';
  If edtSituacao.Text = 'N' Then
    Result := 'SITUAÇÃO: NÃO FATURADO'
  Else If edtSituacao.Text = 'J' Then
    Result := 'SITUAÇÃO: JÁ FATURADO'
  Else If edtSituacao.Text = 'B' Then
    Result := 'SITUAÇÃO: BAIXADOS E NÃO FATURADOS'
  Else If edtSituacao.Text = 'T' Then
    Result := 'SITUAÇÃO: TODOS';
end;

function TfrmRelFatRelOrc.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
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

    Else
    If (Sender = edtTipo) Then
    Begin

      If (edtTipo.Text <> 'A') And (edtTipo.Text <> 'S') Then
      Begin
        fMensagem('','O Campo tipo deve conter A ou S ',['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtSituacao) Then
    Begin

      If (Pos(edtSituacao.Text,'TJNB') <= 0) Then
      Begin
        fMensagem('','O Campo Situação deve conter N, J, B ou T ',['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Pos(edtSituacao.Text,'B') > 0) Then
        Begin
          pnlOcorrencia.Top := 405;
          pnlOcorrencia.Visible := True;
          If pnlFaseObra.Visible Then
            Self.Height := 595 + pnlOcorrencia.Height + pnlFaseObra.Height
          Else
            Self.Height := 595 + pnlOcorrencia.Height;
        End
        Else
        Begin
          pnlOcorrencia.Visible := False;
          If pnlFaseObra.Visible Then
            Self.Height := 595 + pnlFaseObra.Height
          Else
            Self.Height := 595;
        End;
      End;
    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) And (edtCodEmpresa.Text <> '000') Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = mskLinhaGrupo) Then
    Begin

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
        mskLinhaGrupo2.Enabled := True
      Else
        mskLinhaGrupo2.Enabled := False;

    End

    Else If ( Pos(edtDestino.Text, 'V_I_E_')<= 0 ) Then
    begin
      fMensagem('ATENÇÃO!', 'Destino deve ser (V)ídeo, (I)mpressora ou (E)xcel.', ['&O k']);
      Result := False;
    end

    Else If (Sender = edtVendedor) Then Begin

      If fCfgSis('REPVEN', varBoolean) Then Begin
        If Pos(edtVendedor.Text,'12') <= 0 Then Begin
          fMensagem('ATENÇÃO!', 'O campo Opção de Vendedor deve ser 1 ou 2!', ['&OK']);
          Result := False;
        End;
      End;

    End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelFatRelOrc.mskLinhaGrupo2Exit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo2.Text) Then
    edtDesGrupo2.Text := 'TODOS'
  Else
    edtDesGrupo2.Text := fRetNomeLinhaGrupo(mskLinhaGrupo2.Text);


  If fEmptyStr(edtDesGrupo2.Text) And (Not fEmptyStr(mskLinhaGrupo2.Text))  Then
  Begin
    fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
    mskLinhaGrupo2.Clear;
    pSetFocus(mskLinhaGrupo2);
  End;

end;

procedure TfrmRelFatRelOrc.mskLinhaGrupo2KeyPress(Sender: TObject;
  var Key: Char);
Begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinhaGrupo2, edtDesGrupo2, Nil, Key, arrGruLinFin) Then
  Begin
    If fValidaCampos(mskLinhaGrupo2, True) Then
      SelectNext(ActiveControl, True, True);
  End;
  
end;

procedure TfrmRelFatRelOrc.mskLinhaGrupoEnter(Sender: TObject);
begin
  inherited;
  mskLinhaGrupo2.Clear;
  edtDesGrupo2.Text := '';
end;

procedure TfrmRelFatRelOrc.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);


  If fEmptyStr(edtDesGrupo.Text) And (Not fEmptyStr(mskLinhaGrupo.Text))  Then
  Begin
    fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
    mskLinhaGrupo.Clear;
    pSetFocus(mskLinhaGrupo);
  End;
end;

procedure TfrmRelFatRelOrc.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
Begin

  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, arrGruLinFin) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelFatRelOrc.pGeraExcel(qryDados: TUniQuery);
  var
    objExcel : TGeraExcel;
begin
  try
    try
      { CRIA O OBJETO EXCEL }
      Self.Height := Self.Height + 10;
      objExcel := TGeraExcel.Create(qryDados, pbProgresso);

      with objExcel do
      begin
        { TITULOS }
        If (edtTipo.Text= 'A') Then
          strNomRel := 'RELATÓRIO DE ORÇAMENTOS - ANALÍTICO '
        else
          strNomRel := 'RELATÓRIO DE ORÇAMENTOS - SINTÉTICO ';

        { FILTROS }
        AddFiltro(fStrTitulo(edtCodCliente.Text, edtDesCliente, arrCliente, strCliente,'CLIENTES'));
        AddFiltro(fStrTitulo(edtCodVendedor.Text, edtDesVendedor, arrVendedor, strVendedor,'VENDEDOR'));
        AddFiltro(fStrTitulo(edtCodRepresentante.Text, edtDesRepresentante, arrRepresentante, strRepresentante,'REPRESENTANTE'));
        AddFiltro(fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa,'EMPRESA', True));
        AddFiltro(fRetTitSituacao);
        AddFiltro(fStrTitulo(edtCodRede.Text, edtDesRede, arrRede, strRede,'REDE', True));
        AddFiltro('LINHA/GRUPO INICIAL: ' + IFThen(fEmptyStr(mskLinhaGrupo.Text), 'TODAS', mskLinhaGrupo.Text + ' - ' + edtDesGrupo.Text));
        AddFiltro('LINHA/GRUPO FINAL: ' + IFThen(fEmptyStr(mskLinhaGrupo.Text), 'TODAS', mskLinhaGrupo2.Text + ' - ' + edtDesGrupo2.Text));
        AddFiltro(fStrTitulo(edtCodOco.Text, edtDesOco, arrOcor, strOcorrencia,'OCORRÊNCIA', True));

        If fCfgSis('FASOBR') = 'S' Then
          AddFiltro(fStrTitulo(edtCodFase.Text, edtDesFase, arrFase, strFase, 'FASE DA OBRA', True));

        AddFiltro('OPÇÃO DE VENDEDOR: VENDEDOR ' + edtVendedor.Text);
        AddFiltro('REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text);

        { CAMPOS }
        If (edtTipo.Text = 'S') Then
        begin  { SINTÉTICO }
          AddCampo('NUMDOC', 'DOCUMENTO');
          AddCampo('CODEMP', 'EMPRESA');
          AddCampo('DTAENT', 'DATA ENTRADA');
          AddCampo('CODVEN', 'VENDEDOR');
          AddCampo('NOMCLI', 'NOME DO CLIENTE');
          AddCampo('TELCLI', 'TELEFONE');
          AddCampo('TOTITE', 'VR. TOTAL');
        end
        else
        begin  { ANALÍTICO }
          AddCampo('CODITE', 'CÓDIGO');
          AddCampo('DESCRI', 'DESCRIÇÃO');
          AddCampo('QTDITE', 'QTDE');
          AddCampo('UNITAR', 'PR.UNITÁRIO');
          AddCampo('TOTITE', 'VR.TOTAL');
        end;

        { QUEBRA }
        If ( chkAgrVend.Checked ) then
          AddQuebra('CODVEN', 'VENDEDOR');

        AddQuebra('NUMDOC', '', False);

        AddTotais('TOTITE');

        If (edtTipo.Text = 'A') Then
        Begin
          AddTotais('TOTRET');
          AddTotais('TOTIPI');
          AddTotais('TOTREF');
          AddTotais('TOTFRE');
          AddTotais('TOTDES');
        End;

        { EVENTOS }
        OnImpTitGrupo := pImpTitGrupo;
        OnMontaResumo := pMontaResumo;

        If (edtTipo.Text = 'S') Then
          OnImpDetalhes := pImprimeDetalhes;

        OnSomaResumo  := pSomaTotais;

       { FECHA E SALVA ARQUIVO }
       if ( fGerarRelatorio ) then
         fMensagem('', 'Relatório gerado com sucesso!', ['&O k']);
      end;
    except
      fMensagem('ATENÇÃO', 'Ocorreu algum erro na geração da Planilha Excel!', ['&O k']);
    end;
  finally
    Self.Height := Self.Height - 10;
    FreeAndNil(objExcel);
  end;
end;

procedure TfrmRelFatRelOrc.pImprimeDetalhes(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; CorFundo: TCorExcel);
begin
  If (edtTipo.Text = 'S') And (chkMsgs.Checked) Then
  begin
    If (Not fEmptyStr(Dados.FieldByName('MEN001').AsString)) Then
    begin
      Excel.ProximaLinha;
      Excel.Escrever(Excel.LinhaAtual, 1, 'MENSAGENS: ' + Dados.FieldByName('MEN001').AsString);
      Excel.Mesclar('A' + IntToStr(Excel.LinhaAtual), 'G' + IntToStr(Excel.LinhaAtual));
    end;

    If (Not fEmptyStr(Dados.FieldByName('MEN002').AsString)) Then
    begin
      Excel.ProximaLinha;
      Excel.Escrever(Excel.LinhaAtual, 1, '           ' +  Dados.FieldByName('MEN002').AsString);
      Excel.Mesclar('A' + IntToStr(Excel.LinhaAtual), 'G' + IntToStr(Excel.LinhaAtual));
    end;
  end;
end;

procedure TfrmRelFatRelOrc.pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
  var
    strQuebra : String;
    fltValQue : Double;

    procedure pFormataTotal(strLetraIni, strLetraFim: String; blnMesclar: Boolean=False);
    begin
      with Excel do
      Begin
        If blnMesclar Then
          Mesclar    (strLetraIni + IntToStr(LinhaAtual), strLetraFim + IntToStr(LinhaAtual));
        Negrito    (strLetraIni + IntToStr(LinhaAtual), strLetraFim + IntToStr(LinhaAtual), True);
        CorFundo   (strLetraIni + IntToStr(LinhaAtual), strLetraFim + IntToStr(LinhaAtual), Amarelo);
        CorFonte   (strLetraIni + IntToStr(LinhaAtual), strLetraFim + IntToStr(LinhaAtual), Azul);
        Bordas     (strLetraIni + IntToStr(LinhaAtual), strLetraFim + IntToStr(LinhaAtual));
        Alinhamento(strLetraIni + IntToStr(LinhaAtual), strLetraFim + IntToStr(LinhaAtual), Direita);
      End
    End;
begin
  With Excel Do
  Begin
    strQuebra := '';
    fltValQue := 0.00;

    If (Quebra.NomeCampo = 'CODVEN') Then
    Begin
      strQuebra := 'TOTAL DO VENDEDOR';
      fltValQue := Quebra.Totais['TOTITE'];
    End
    Else If (edtTipo.Text = 'A') And (Quebra.NomeCampo = 'NUMDOC') Then
    Begin
      If Quebra.Totais['TOTDES'] > 0 Then
         strQuebra := 'DESC. ESPE.: ' + FormatFloat('##,##0.00', Quebra.Totais['TOTDES']) + '   ';
      strQuebra := strQuebra + 'TOTAL DO DOCUMENTO';
      fltValQue := Quebra.Totais['TOTITE'];
    End
    Else If (Quebra.NomeCampo = '[GERAL]') Then
    Begin
      strQuebra := 'TOTAL GERAL';
      fltValQue := Quebra.Totais['TOTITE'];
    End;

    If (edtTipo.Text = 'S') And (Not fEmptyStr(strQuebra)) Then
    Begin
      ProximaLinha;

      Escrever(LinhaAtual, 6, strQuebra );
      Mesclar('A' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual));
      pFormataTotal('A', fGetLetraAlfa(Campos.Colunas.Count));
      Escrever(LinhaAtual, 7, FormatFloat('##,##0.00', Quebra.Totais['TOTITE']));
      pFormataTotal('G', fGetLetraAlfa(Campos.Colunas.Count));
    End
    Else If (edtTipo.Text = 'A') Then
    Begin
      If fltValQue > 0 Then
      Begin
        If Quebra.Totais['TOTRET'] <> 0 Then
        Begin
          ProximaLinha;
          Escrever(LinhaAtual, 4, 'TOTAL DA SUBSTITUIÇÃO');
          pFormataTotal('A', 'D', True);
          Escrever(LinhaAtual, 5, FormatFloat('##,##0.00', Quebra.Totais['TOTRET']));
          pFormataTotal('D', 'E');
        End;

        If Quebra.Totais['TOTIPI'] <> 0 Then
        Begin
          ProximaLinha;
          Escrever(LinhaAtual, 4, 'TOTAL DO IPI');
          pFormataTotal('A', 'D', True);
          Escrever(LinhaAtual, 5, FormatFloat('##,##0.00', Quebra.Totais['TOTIPI']));
          pFormataTotal('D', 'E');
        End;

        If Quebra.Totais['TOTREF'] <> 0 Then
        Begin
          ProximaLinha;
          Escrever(LinhaAtual, 4, 'TOTAL CBS/IBS/IS');
          pFormataTotal('A', 'D', True);
          Escrever(LinhaAtual, 5, FormatFloat('##,##0.00', Quebra.Totais['TOTREF']));
          pFormataTotal('D', 'E');
        End;

        If Quebra.Totais['TOTFRE'] <> 0 Then
        Begin
          ProximaLinha;
          Escrever(LinhaAtual, 4, 'TOTAL DO FRETE');
          pFormataTotal('A', 'D', True);
          Escrever(LinhaAtual, 5, FormatFloat('##,##0.00', Quebra.Totais['TOTFRE']));
          pFormataTotal('D', 'E');
        End;

        ProximaLinha;
        Escrever(LinhaAtual, 4, strQuebra);
        pFormataTotal('A', 'D', True);
        Escrever(LinhaAtual, 5, FormatFloat('##,##0.00', fltValQue));
        pFormataTotal('D', 'E');
      End;
    End;
  End;
end;

procedure TfrmRelFatRelOrc.pImpTitGrupo(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Quebra: TRecQuebras);
  var
    strEscLin1, strEscLin2, strEscLin3, strEscLin4 : String;
begin
  if (edtTipo.Text = 'A') Then
  begin
    if (Quebra.NomeCampo = 'NUMDOC') then
    begin
      // MONTA A LINHA 1
      strEscLin1 := '';
      strEscLin1 := strEscLin1 + 'DOCUMENTO: ' + Dados.FieldByName('NUMDOC').AsString + '  ';
      strEscLin1 := strEscLin1 + 'EMPRESA: ' + Dados.FieldByName('CODEMP').AsString + '  ';
      strEscLin1 := strEscLin1 + 'DATA ENTRADA: ' + Dados.FieldByName('DTAENT').AsString + '  ';

      // MONTA A LINHA 2
      strEscLin2 := '';
      strEscLin2 := strEscLin2 + 'COND.PGTO: ' + Dados.FieldByName('CONPAG').AsString + '  ';

      // MONTA A LINHA 3
      strEscLin3 := '';
      strEscLin3 := strEscLin3 + 'CLIENTE: ' + Dados.FieldByName('NOMCLI').AsString;

      // MONTA A LINHA 4
      strEscLin4 := '';
      If Not fEmptyStr(Dados.FieldByName('MOTBAI').AsString) Then
        strEscLin4 := strEscLin4 + 'MOTIVO BAIXA: ' + Dados.FieldByName('MOTBAI').AsString + '  ';

      // ESCREVE A LINHA 1
      Excel.ProximaLinha;
      Excel.Escrever(Excel.LinhaAtual, 1, strEscLin1);
      Excel.Mesclar('A' + IntToStr(Excel.LinhaAtual), IfThen(edtTipo.Text = 'A', 'E' + IntToStr(Excel.LinhaAtual), 'G' + IntToStr(Excel.LinhaAtual)));

      // ESCREVE A LINHA 2
      Excel.ProximaLinha;
      Excel.Escrever(Excel.LinhaAtual, 1, strEscLin2);
      Excel.Mesclar('A' + IntToStr(Excel.LinhaAtual), IfThen(edtTipo.Text = 'A', 'E' + IntToStr(Excel.LinhaAtual), 'G' + IntToStr(Excel.LinhaAtual)));

      // ESCREVE A LINHA 3
      Excel.ProximaLinha;
      Excel.Escrever(Excel.LinhaAtual, 1, strEscLin3);
      Excel.Mesclar('A' + IntToStr(Excel.LinhaAtual), IfThen(edtTipo.Text = 'A', 'E' + IntToStr(Excel.LinhaAtual), 'G' + IntToStr(Excel.LinhaAtual)));

      // ESCREVE A LINHA 4
      If Not fEmptyStr(strEscLin4) Then
      Begin
        Excel.ProximaLinha;
        Excel.Escrever(Excel.LinhaAtual, 1, strEscLin4);
        Excel.Mesclar('A' + IntToStr(Excel.LinhaAtual), IfThen(edtTipo.Text = 'A', 'E' + IntToStr(Excel.LinhaAtual), 'G' + IntToStr(Excel.LinhaAtual)));
      End;

      If (chkMsgs.Checked) Then
      begin
        If (Not fEmptyStr(Dados.FieldByName('MEN001').AsString)) Then
        begin
          Excel.ProximaLinha;
          Excel.Escrever(Excel.LinhaAtual, 1, 'MENSAGENS: ' + Dados.FieldByName('MEN001').AsString);
          Excel.Mesclar('A' + IntToStr(Excel.LinhaAtual), 'E' + IntToStr(Excel.LinhaAtual));
        end;

        If (Not fEmptyStr(Dados.FieldByName('MEN002').AsString)) Then
        begin
          Excel.ProximaLinha;
          Excel.Escrever(Excel.LinhaAtual, 1, '           ' + Dados.FieldByName('MEN002').AsString);
          Excel.Mesclar('A' + IntToStr(Excel.LinhaAtual), 'E' + IntToStr(Excel.LinhaAtual));
        end;
      End;
    end;
  end;
end;

procedure TfrmRelFatRelOrc.pSomaTotais(var Totais: TTotais; Dados: TDataSet);
begin
  If (edtTipo.Text = 'A') Then
  Begin
    Totais['TOTRET'] := Totais['TOTRET'] + Dados.FieldByName('VALRET').AsFloat;
    Totais['TOTFRE'] := Totais['TOTFRE'] + Dados.FieldByName('VALFRE').AsFloat;
    Totais['TOTIPI'] := Totais['TOTIPI'] + Dados.FieldByName('VALIPI').AsFloat;
    Totais['TOTREF'] := Totais['TOTREF'] + Dados.FieldByName('VALREF').AsFloat;

    Totais['TOTDES'] := Totais['TOTDES'] + Dados.FieldByName('DESESP').AsFloat;

    Totais['TOTITE'] := Totais['TOTITE'] + ((Dados.FieldByName('TOTITE').AsFloat +
                                             Dados.FieldByName('VALRET').AsFloat +
                                             Dados.FieldByName('VALFRE').AsFloat +
                                             Dados.FieldByName('VALIPI').AsFloat +
                                             Dados.FieldByName('VALREF').AsFloat) - Dados.FieldByName('DESESP').AsFloat);
  End
  Else
    Totais['TOTITE'] := Totais['TOTITE'] + Dados.FieldByName('TOTITE').AsFloat;
end;

procedure TfrmRelFatRelOrc.FormCreate(Sender: TObject);
begin
  inherited;
  shpMultSel.Visible    := True;
  pnlOcorrencia.Visible := False;
end;

end.

