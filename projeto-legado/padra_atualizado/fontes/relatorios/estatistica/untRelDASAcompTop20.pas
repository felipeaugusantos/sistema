unit untRelDASAcompTop20;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus,
  QColorLabel, ExtCtrls, Buttons, Uni, untFuncoesSimples, DateUtils,
  BitBtnLockedIncrem, frxExportCSVTestabilidade;

type
  TfrmRelDASAcompTop20 = class(TfrmPaiRelatorio)
    lblCodVen: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    lblCodRep: TLabel;
    edtCodRep: TEditFocus;
    edtDesRep: TEditFocus;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    lblCodCid: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    lblCodAti: TLabel;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    frxDasTop20J: TfrxReport;
    frxDasTop20M: TfrxReport;
    rdgOrdem: TRadioGroup;
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    arrVended: TConsultasArray;
    arrRepres: TConsultasArray;
    arrCidade: TConsultasArray;
    arrEmpres: TConsultasArray;
    arrAtivid: TConsultasArray;

    strVended: String;
    strRepres: String;
    strAtivid: String;
    strEmpres: String;
    strCidade: String;
  public
    { Public declarations }
  protected
    { Protected declarations }
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

uses untConstantes,  untModuloSPR, untFuncoesConsulta, untPai, untConsultas,
     StrUtils, untFuncTinta, untCfgRel, Data.DB;

{$R *.dfm}

function TfrmRelDASAcompTop20.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    intIndex: Integer;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodEmp) Then
    Begin

      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin

        If Length(arrEmpres) > 0 Then
        Begin

          For intIndex := Low(arrEmpres) To High(arrEmpres) Do
            If Pos(arrEmpres[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a Empresa ' + arrEmpres[intIndex].strCodigo + '!', ['&O k']);
              Break;
              Result := False;
            End;

        End
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin

          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;

        End;

      End
      Else pDesmarcaLista(edtCodEmp, arrEmpres);

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelDASAcompTop20.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if fPesqOperador(Self, edtCodVen, edtDesVen, qryTabela, Key, arrVended, False) then
  Begin
    fValidaCampos(edtCodVen, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelDASAcompTop20.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtDesVen, arrVended, fRetNomVendRep, Nil, 'do Vendedor');
end;

procedure TfrmRelDASAcompTop20.edtCodRepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if fPesqOperador(Self, edtCodRep, edtDesRep, qryTabela, Key, arrRepres, False) then
  Begin
    fValidaCampos(edtCodRep, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelDASAcompTop20.edtCodRepExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodRep, edtDesRep, arrRepres, fRetNomVendRep, Nil, 'do Representante');
end;

procedure TfrmRelDASAcompTop20.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmpres, False, True) Then
  Begin
    fValidaCampos(edtCodEmp, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelDASAcompTop20.edtCodEmpExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrEmpres, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmRelDASAcompTop20.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtNomCid, Nil, Nil, Key, arrCidade, False) Then
  Begin
    fValidaCampos(edtCodCid, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelDASAcompTop20.edtCodCidExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodCid, edtNomCid, arrCidade, fRetNomCidadeSemOpc, Nil, 'da Cidade');
end;

procedure TfrmRelDASAcompTop20.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrAtivid, False) Then
  Begin
    fValidaCampos(edtCodAti, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelDASAcompTop20.edtCodAtiExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodAti, edtDesAti, arrAtivid, Nil, fRetNomAtividade, 'da Atividade');
end;

procedure TfrmRelDASAcompTop20.btnImprimirClick(Sender: TObject);
Var
  strSQL     : String;
  strCreate  : String;
  strMesAtu  : String;
  strMesAnt  : String;
  strAnoAtu  : String;
  strAnoAnt  : String;
  strVlrCon  : String;
  strVlrLit  : String;
  strNomeFila: String;
  frxRelat   : TfrxReport;
begin

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin
    strVlrCon := 'SUM( IF( (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF( LEFT( DET_CLAFIS,1)<5, ' +
                 '-( DET_TOTITE-DET_DESESP-DET_DESCFF ), DET_TOTITE-DET_DESESP-DET_DESCFF ) ) )';

    strVlrLit := 'SUM( IF( LEFT(DET_CLAFIS,1)<5, -(DET_QTDITE), DET_QTDITE ) * ' + fStrRelFatorLit + ' )';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  DET_CODCLI,       ';
    strSQL := strSQL + '  CLI_DTACAD,       ';
    strSQL := strSQL + '  IFNULL(GER_NOMCON,CLI_NOMCLI) AS GER_NOMCON, ';
    strSQL := strSQL + '  0 AS GER_ULTATU,  ';
    strSQL := strSQL + '  0 AS ACU_ANOATU,  ';
    strSQL := strSQL + '  0 AS GER_ULTANT,  ';
    strSQL := strSQL + '  0 AS ACU_ANOANT,  ';
    strSQL := strSQL + '  0 AS LIT_ULTATU,  ';
    strSQL := strSQL + '  0 AS LIT_ANOATU,  ';
    strSQL := strSQL + '  0 AS LIT_ANOANT   ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  MOVDET ';
    strSQL := strSQL + '  INNER JOIN MOVGER ON DET_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + '  INNER JOIN CADCLI ON CLI_CODCLI = DET_CODCLI        ';
    strSQL := strSQL + '  LEFT  JOIN CADUNI ON DET_UNIDAD = UNI_CODUNI        ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  ANO_REF AND ';
    strSQL := strSQL + '  MES_REF AND ';
    strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '  DET_ESPDOC NOT IN ("FF", "TR", "DV", "PD") AND ';
    strSQL := strSQL + '  ( ( LOCATE(DET_CLAFIS, :CLAVEN) > 0 ) OR     ';
    strSQL := strSQL + '    ( LOCATE(DET_CLAFIS, :CLADEV) > 0 ) )  AND ';
    strSQL := strSQL + '  DET_TIP_FC = "C"  ';

    If Not fEmptyStr(edtCodEmp.Text) Then
         strSQL := strSQL + fStrLocate(edtCodEmp, arrEmpres, 'DET_CODEMP', 'CODEMP')
    Else strSQL := strSQL + '  AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + fStrLocate(edtCodVen, arrVended, 'DET_CODVEN', 'CODVEN');
    strSQL := strSQL + fStrLocate(edtCodRep, arrRepres, 'DET_CODREP', 'CODREP');
    strSQL := strSQL + fStrLocate(edtCodAti, arrAtivid, 'CLI_CODATI', 'CODATI');
    strSQL := strSQL + fStrLocate(edtCodCid, arrCidade, 'IFNULL(GER_CIDCON,CLI_CODCID)', 'CODCID');

    strSQL := strSQL + ' GROUP BY DET_CODCLI ';

    strMesAtu := AnsiReplaceStr(strSQL,   'MES_REF','MONTH(DET_DTAENT) = :MESREF');
    strMesAtu := AnsiReplaceStr(strMesAtu,'ANO_REF','YEAR(DET_DTAENT)  = :ANOREF');
    strMesAtu := AnsiReplaceStr(strMesAtu,'0 AS GER_ULTATU',strVlrCon + ' AS GER_ULTATU');
    strMesAtu := AnsiReplaceStr(strMesAtu,'0 AS LIT_ULTATU',strVlrLit + ' AS LIT_ULTATU');

    strMesAnt := AnsiReplaceStr(strSQL,   'MES_REF','MONTH(DET_DTAENT) = :MESREF');
    strMesAnt := AnsiReplaceStr(strMesAnt,'ANO_REF','YEAR(DET_DTAENT)  = :ANOANT');
    strMesAnt := AnsiReplaceStr(strMesAnt,'0 AS GER_ULTANT',strVlrCon + ' AS GER_ULTANT');

    strAnoAtu := AnsiReplaceStr(strSQL,   'MES_REF','TRUE');
    strAnoAtu := AnsiReplaceStr(strAnoAtu,'ANO_REF','YEAR(DET_DTAENT)  = :ANOREF');
    strAnoAtu := AnsiReplaceStr(strAnoAtu,'0 AS ACU_ANOATU',strVlrCon + ' AS ACU_ANOATU');
    strAnoAtu := AnsiReplaceStr(strAnoAtu,'0 AS LIT_ANOATU',strVlrLit + ' AS LIT_ANOATU');

    strAnoAnt := AnsiReplaceStr(strSQL,   'MES_REF','TRUE');
    strAnoAnt := AnsiReplaceStr(strAnoAnt,'ANO_REF','YEAR(DET_DTAENT)  = :ANOANT');
    strAnoAnt := AnsiReplaceStr(strAnoAnt,'0 AS ACU_ANOANT',strVlrCon + ' AS ACU_ANOANT');
    strAnoAnt := AnsiReplaceStr(strAnoAnt,'0 AS LIT_ANOANT',strVlrLit + ' AS LIT_ANOANT');

    strSQL := strMesAtu + ' UNION ALL ' + strMesAnt + ' UNION ALL ' + strAnoAtu + ' UNION ALL ' + strAnoAnt;

    strCreate := '';
    strCreate := strCreate + 'SELECT        ';
    strCreate := strCreate + '  DET_CODCLI      AS GER_CODCLI, ';
    strCreate := strCreate + '  GER_NOMCON      AS GER_NOMCON, ';
    strCreate := strCreate + '  CLI_DTACAD      AS CLI_DTACAD, ';
    strCreate := strCreate + '  SUM(GER_ULTATU) AS GER_ULTATU, ';
    strCreate := strCreate + '  SUM(ACU_ANOATU) AS ACU_ANOATU, ';
    strCreate := strCreate + '  SUM(GER_ULTANT) AS GER_ULTANT, ';
    strCreate := strCreate + '  SUM(ACU_ANOANT) AS ACU_ANOANT, ';
    strCreate := strCreate + '  SUM(LIT_ULTATU) AS LIT_ULTATU, ';
    strCreate := strCreate + '  SUM(LIT_ANOATU) AS LIT_ANOATU, ';
    strCreate := strCreate + '  SUM(LIT_ANOANT) AS LIT_ANOANT, ';
    strCreate := strCreate + '  IF(SUM(LIT_ULTATU) > 0,        ';
    strCreate := strCreate + '     SUM(GER_ULTATU)/SUM(LIT_ULTATU), 0) AS MED_ULTATU, ';
    strCreate := strCreate + '  IF(SUM(LIT_ANOATU) > 0,        ';
    strCreate := strCreate + '     SUM(ACU_ANOATU)/SUM(LIT_ANOATU), 0) AS MED_ANOATU, ';
    strCreate := strCreate + '  IF(SUM(LIT_ANOANT) > 0,        ';
    strCreate := strCreate + '     SUM(ACU_ANOANT)/SUM(LIT_ANOANT), 0) AS MED_ANOANT, ';
    strCreate := strCreate + '  IF(SUM(GER_ULTANT) > 0,        ';
    strCreate := strCreate + '     (((SUM(GER_ULTATU)/SUM(GER_ULTANT))*100)-100),     ';
    strCreate := strCreate + '     IF(SUM(GER_ULTATU) = 0, 0, 100)) AS ACU_CRESCI     ';
    strCreate := strCreate + 'FROM ( ' + strSQL + ' ) TAB      ';
    strCreate := strCreate + 'GROUP BY      ';
    strCreate := strCreate + '  GER_CODCLI, ';
    strCreate := strCreate + '  GER_NOMCON  ';
    strCreate := strCreate + 'ORDER BY      ';

    if rdgOrdem.ItemIndex = 0 then
    begin
      strCreate := strCreate + '  GER_ULTATU DESC, ';
      strCreate := strCreate + '  ACU_ANOATU DESC, ';
    end
    else
    begin
      strCreate := strCreate + '  ACU_ANOATU DESC, ';
      strCreate := strCreate + '  GER_ULTATU DESC, ';
    end;

    strCreate := strCreate + '  GER_ULTANT DESC, ';
    strCreate := strCreate + '  ACU_ANOANT DESC  ';

    strCreate := strCreate + 'LIMIT 20      ';

    With frmModuloSPR.qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strCreate);

      If Params.FindParam('LITGAL') <> Nil Then
      Begin
        If SameText(fCfgSis('LITGAL'), 'L') Then
             ParamByName('LITGAL').AsFloat := 1
        Else ParamByName('LITGAL').AsFloat := FLT_LITRO_GALAO;
      End;

      ParamByName('MESREF').AsString := FormatDateTime('mm',   IncMonth(VS_Date,-1));
      ParamByName('ANOREF').AsString := FormatDateTime('yyyy', IncMonth(VS_Date,-1));
      ParamByName('ANOANT').AsString := FormatDateTime('yyyy', IncYear(IncMonth(VS_Date,-1),-1));
      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

      pSetaParam(edtCodVen.Text, arrVended, strVended, 'CODVEN', frmModuloSPR.qryRelatorio);
      pSetaParam(edtCodRep.Text, arrRepres, strRepres, 'CODREP', frmModuloSPR.qryRelatorio);
      pSetaParam(edtCodAti.Text, arrAtivid, strAtivid, 'CODATI', frmModuloSPR.qryRelatorio);
      pSetaParam(edtCodEmp.Text, arrEmpres, strEmpres, 'CODEMP', frmModuloSPR.qryRelatorio);
      pSetaParam(edtCodCid.Text, arrCidade, strCidade, 'CODCID', frmModuloSPR.qryRelatorio);

      Open;
    End;

    If Not frmModuloSPR.qryRelatorio.IsEmpty Then
    Begin

      pCarregaConfImpr(qryCfgRel, Self.Name);
      fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);

      If strTipImp = 'M' Then
        frxRelat := frxDasTop20M
      Else
      Begin
        frxRelat := frxDasTop20J;
        frxRelat.PrintOptions.PrintMode    := pmScale;
        frxRelat.PrintOptions.PrintOnSheet := 9; 
      End;

      frxRelat.PrintOptions.Printer := AnsiReplaceText(strNomeFila, '\\' + fRetNomeRede + '\', '');

      frxRelat.Script.Variables['NOMREL'] := 'RELATORIO DE ACOMPANHAMENTO DOS TOP 20';
      frxRelat.Script.Variables['VENDED'] := fStrTitulo(edtCodVen.Text, edtDesVen, arrVended, strVended, 'VENDEDOR');
      frxRelat.Script.Variables['REPRES'] := fStrTitulo(edtCodRep.Text, edtDesRep, arrRepres, strRepres, 'REPRESENTANTE');
      frxRelat.Script.Variables['ATIVID'] := fStrTitulo(edtCodAti.Text, edtDesAti, arrAtivid, strAtivid, 'ATIVIDADE');
      frxRelat.Script.Variables['CIDADE'] := fStrTitulo(edtCodCid.Text, edtNomCid, arrCidade, strCidade, 'CIDADE');
      frxRelat.Script.Variables['EMPRES'] := fStrTitulo(edtCodEmp.Text, edtDesEmp, arrEmpres, strEmpres, 'EMPRESA', True);
      frxRelat.Script.Variables['CLASS']  := 'SOMENTE CLASS.: ' + VS_strClaVen;

      If edtDestino.Text = 'V' Then
        pPreviewReport(Self.Name, Self.Caption, frxRelat)
      Else If frxRelat.PrepareReport Then
        pPrintReport(Self.Name, Self.Caption, strNomeFila, frxRelat);

    End
    Else
      pTabelaVazia;

    btnImprimir.Enabled := True;
    pnlInfo.Caption := '';
  End;

end;

end.
