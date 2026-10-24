{***********************}
{* qryConEmp -> CADEMP *}
{********************JB*}

unit untRelFiscOpeInterSaidas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Mask, MaskEditFocus, RLFilters, RLDraftFilter,
  Menus, StdCtrls, EditFocus, QColorLabel, Buttons, ExtCtrls, frxDesgn,
  frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, AppEvnts, Uni, untTypesSistema, strUtils,
  ComboBoxFocus, BitBtnLockedIncrem, frxExportCSVTestabilidade;

type
  TfrmRelFiscOpeInterSaidas = class(TfrmPaiRelatorio)
    lblEmpresa: TLabel;
    Label11: TLabel;
    lblDesDtaIni: TLabel;
    lblDesDtaFin: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    edtEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtDesEstado: TEditFocus;
    cmbEstados: TComboBoxFocus;
    Shape1: TShape;
    procedure FormShow(Sender: TObject);
    procedure edtEmpresaExit(Sender: TObject);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);

    procedure btnImprimirClick(Sender: TObject);
    procedure cmbEstadosExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    arrEmp: TConsultasArray;
    strEmpresa: String;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelFiscOpeInterSaidas: TfrmRelFiscOpeInterSaidas;

implementation

uses untQckFiscOpeInterEntradas,
     untConstantes, Data.DB, untFuncoesFactory, untIFuncoes;

{$R *.dfm}

procedure TfrmRelFiscOpeInterSaidas.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelFiscOpeInterSaidas.FormShow(Sender: TObject);
  Var
    intCont: Integer;
begin
  edtEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  cmbEstados.Clear;
  cmbEstados.Items.Add('');

  For intCont := Low(ESTADOS) To High(ESTADOS) Do
    cmbEstados.Items.Add(String(ESTADOS[intCont]));

  inherited;
end;

procedure TfrmRelFiscOpeInterSaidas.edtEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelFiscOpeInterSaidas.edtEmpresaKeyPress(Sender: TObject; var Key: Char);

begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtEmpresa, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelFiscOpeInterSaidas.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
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

    End;

    If (Sender = edtEmpresa) Then
    Begin
      If Not fEmptyStr(edtEmpresa.Text) And (edtEmpresa.Text <> '000') Then
      Begin
        If Pos(edtEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End;

  End;

end;

procedure TfrmRelFiscOpeInterSaidas.btnImprimirClick(Sender: TObject);
Var
  strSQL      : String;
  QryRelatorio: TUniQuery;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;
  inherited;

  If blnImprime Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE     ';
    strSQL := strSQL + '  FIS_NUMDOC AS NUMDOC, ';
    strSQL := strSQL + '  FIS_SERIE_ AS SERIE_, ';
    strSQL := strSQL + '  FIS_DTAENT AS DTAENT, ';
    strSQL := strSQL + '  FIS_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  FIS_ESTADO AS ESTADO, ';

    strSQL := strSQL + '  IF(FIS_TIP_FC = "C", IF((CLI_NOMCLI LIKE "%CONSUMIDOR%") OR (CLI_NOMCLI LIKE "%SEGURADORA%"), ';
    strSQL := strSQL + '    CONCAT(IFNULL(N.GER_NOMCON,""),IFNULL(M.GER_NOMCON,"")), CLI_NOMCLI), FOR_NOMFOR) AS NOMCLI, ';

    strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_ENDERE, FOR_ENDERE) AS ENDERE, ';
    strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_E_P_, FOR_C_E_P_) AS C_E_P_, ';
    strSQL := strSQL + '  IF(FIS_TIP_FC = "C", IFNULL(M.GER_CIDCON, IFNULL(N.GER_CIDCON, CLI_CODCID)), FOR_CODCID) AS CODCID, ';
    strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS C_G_C_, ';
    strSQL := strSQL + '  IF(FIS_TIP_FC = "C", CLI_I_E_S_, FOR_I_E_S_) AS I_E_S_, ';

    strSQL := strSQL + '  (SELECT SQL_NO_CACHE CID_NOMCID FROM CADCID WHERE CID_CODCID = CODCID) AS NOMCID, ';

    strSQL := strSQL + '  FIS_CLFSC1 AS CLFSC1, ';
    strSQL := strSQL + '  FIS_CLFSC2 AS CLFSC2, ';
    strSQL := strSQL + '  FIS_CLFSC3 AS CLFSC3, ';
    strSQL := strSQL + '  FIS_CLFSC4 AS CLFSC4, ';
    strSQL := strSQL + '  FIS_CLFSC5 AS CLFSC5, ';

    strSQL := strSQL + '  IF(FIS_VLCON1 IS NULL,0,FIS_VLCON1) AS VLCON1, ';
    strSQL := strSQL + '  IF(FIS_VLCON2 IS NULL,0,FIS_VLCON2) AS VLCON2, ';
    strSQL := strSQL + '  IF(FIS_VLCON3 IS NULL,0,FIS_VLCON3) AS VLCON3, ';
    strSQL := strSQL + '  IF(FIS_VLCON4 IS NULL,0,FIS_VLCON4) AS VLCON4, ';
    strSQL := strSQL + '  IF(FIS_VLCON5 IS NULL,0,FIS_VLCON5) AS VLCON5, ';

    strSQL := strSQL + '  IF(FIS_BASIC1 IS NULL,0,FIS_BASIC1) AS BASIC1, ';
    strSQL := strSQL + '  IF(FIS_BASIC2 IS NULL,0,FIS_BASIC2) AS BASIC2, ';
    strSQL := strSQL + '  IF(FIS_BASIC3 IS NULL,0,FIS_BASIC3) AS BASIC3, ';
    strSQL := strSQL + '  IF(FIS_BASIC4 IS NULL,0,FIS_BASIC4) AS BASIC4, ';
    strSQL := strSQL + '  IF(FIS_BASIC5 IS NULL,0,FIS_BASIC5) AS BASIC5, ';

    strSQL := strSQL + '  IF(FIS_ALQIC1 IS NULL,0,FIS_ALQIC1) AS ALQIC1, ';
    strSQL := strSQL + '  IF(FIS_ALQIC2 IS NULL,0,FIS_ALQIC2) AS ALQIC2, ';
    strSQL := strSQL + '  IF(FIS_ALQIC3 IS NULL,0,FIS_ALQIC3) AS ALQIC3, ';
    strSQL := strSQL + '  IF(FIS_ALQIC4 IS NULL,0,FIS_ALQIC4) AS ALQIC4, ';
    strSQL := strSQL + '  IF(FIS_ALQIC5 IS NULL,0,FIS_ALQIC5) AS ALQIC5, ';

    strSQL := strSQL + '  IF(FIS_VLRIC1 IS NULL,0,FIS_VLRIC1) AS VLRIC1, ';
    strSQL := strSQL + '  IF(FIS_VLRIC2 IS NULL,0,FIS_VLRIC2) AS VLRIC2, ';
    strSQL := strSQL + '  IF(FIS_VLRIC3 IS NULL,0,FIS_VLRIC3) AS VLRIC3, ';
    strSQL := strSQL + '  IF(FIS_VLRIC4 IS NULL,0,FIS_VLRIC4) AS VLRIC4, ';
    strSQL := strSQL + '  IF(FIS_VLRIC5 IS NULL,0,FIS_VLRIC5) AS VLRIC5, ';

    strSQL := strSQL + '  IF(FIS_BCRET1 IS NULL,0,FIS_BCRET1) AS BC_RT1, ';
    strSQL := strSQL + '  IF(FIS_BCRET2 IS NULL,0,FIS_BCRET2) AS BC_RT2, ';
    strSQL := strSQL + '  IF(FIS_BCRET3 IS NULL,0,FIS_BCRET3) AS BC_RT3, ';
    strSQL := strSQL + '  IF(FIS_BCRET4 IS NULL,0,FIS_BCRET4) AS BC_RT4, ';
    strSQL := strSQL + '  IF(FIS_BCRET5 IS NULL,0,FIS_BCRET5) AS BC_RT5, ';

    strSQL := strSQL + '  IF(FIS_RETID1 IS NULL,0,FIS_RETID1) AS BCRET1, ';
    strSQL := strSQL + '  IF(FIS_RETID2 IS NULL,0,FIS_RETID2) AS BCRET2, ';
    strSQL := strSQL + '  IF(FIS_RETID3 IS NULL,0,FIS_RETID3) AS BCRET3, ';
    strSQL := strSQL + '  IF(FIS_RETID4 IS NULL,0,FIS_RETID4) AS BCRET4, ';
    strSQL := strSQL + '  IF(FIS_RETID5 IS NULL,0,FIS_RETID5) AS BCRET5, ';

    strSQL := strSQL + '  IF(FIS_ISENT1 IS NULL,0,FIS_ISENT1) AS ISENT1, ';
    strSQL := strSQL + '  IF(FIS_ISENT2 IS NULL,0,FIS_ISENT2) AS ISENT2, ';
    strSQL := strSQL + '  IF(FIS_ISENT3 IS NULL,0,FIS_ISENT3) AS ISENT3, ';
    strSQL := strSQL + '  IF(FIS_ISENT4 IS NULL,0,FIS_ISENT4) AS ISENT4, ';
    strSQL := strSQL + '  IF(FIS_ISENT5 IS NULL,0,FIS_ISENT5) AS ISENT5, ';

    strSQL := strSQL + '  IF(FIS_VLRIP1 IS NULL,0,FIS_VLRIP1) AS VLRIP1, ';
    strSQL := strSQL + '  IF(FIS_VLRIP2 IS NULL,0,FIS_VLRIP2) AS VLRIP2, ';
    strSQL := strSQL + '  IF(FIS_VLRIP3 IS NULL,0,FIS_VLRIP3) AS VLRIP3, ';
    strSQL := strSQL + '  IF(FIS_VLRIP4 IS NULL,0,FIS_VLRIP4) AS VLRIP4, ';
    strSQL := strSQL + '  IF(FIS_VLRIP5 IS NULL,0,FIS_VLRIP5) AS VLRIP5,  ';

    strSQL := strSQL + '  IF(FIS_BASIP1 IS NULL,0,FIS_BASIP1) AS BASIP1, ';
    strSQL := strSQL + '  IF(FIS_BASIP2 IS NULL,0,FIS_BASIP2) AS BASIP2, ';
    strSQL := strSQL + '  IF(FIS_BASIP3 IS NULL,0,FIS_BASIP3) AS BASIP3, ';
    strSQL := strSQL + '  IF(FIS_BASIP4 IS NULL,0,FIS_BASIP4) AS BASIP4, ';
    strSQL := strSQL + '  IF(FIS_BASIP5 IS NULL,0,FIS_BASIP5) AS BASIP5,  ';

    strSQL := strSQL + '  IF(FIS_OUTRA1 IS NULL,0,FIS_OUTRA1) AS OUTRA1, ';
    strSQL := strSQL + '  IF(FIS_OUTRA2 IS NULL,0,FIS_OUTRA2) AS OUTRA2, ';
    strSQL := strSQL + '  IF(FIS_OUTRA3 IS NULL,0,FIS_OUTRA3) AS OUTRA3, ';
    strSQL := strSQL + '  IF(FIS_OUTRA4 IS NULL,0,FIS_OUTRA4) AS OUTRA4, ';
    strSQL := strSQL + '  IF(FIS_OUTRA5 IS NULL,0,FIS_OUTRA5) AS OUTRA5  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFIS ';
    strSQL := strSQL + '  LEFT JOIN CADCLI ON FIS_FORCLI = CLI_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADFOR ON FIS_FORCLI = FOR_CODFOR ';

    strSQL := strSQL + '  LEFT JOIN MOVGER M ON  ';
    strSQL := strSQL + '    M.GER_NUMDOC = FIS_NUMDOC AND  ';
    strSQL := strSQL + '    M.GER_ESPDOC = FIS_ESPDOC AND  ';
    strSQL := strSQL + '    M.GER_CODEMP = FIS_CODEMP      ';

    strSQL := strSQL + '  LEFT JOIN NOTGER N ON  ';
    strSQL := strSQL + '    N.GER_NUMDOC = FIS_NUMDOC AND  ';
    strSQL := strSQL + '    N.GER_ESPDOC = FIS_ESPDOC AND  ';
    strSQL := strSQL + '    N.GER_CODEMP = FIS_CODEMP      ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN AND ';
    strSQL := strSQL + '  FIS_ENTSAI = "S" ';

    strSQL := strSQL + fStrLocateEmpresa(edtEmpresa, arrEmp, 'FIS_CODEMP', 'CODEMP');

    If Not fEmptyStr(cmbEstados.Items[cmbEstados.ItemIndex]) Then
      strSQL := strSQL + ' AND FIS_ESTADO = :ESTADO '
    Else
      strSQL := strSQL + ' AND FIS_ESTADO <> :ESTADO ';

    QryRelatorio := fCriaQuery;

    try

      With QryRelatorio Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

        If Not fEmptyStr(edtEmpresa.Text) Then
          pSetaParam(edtEmpresa.Text, arrEmp, strEmpresa, 'CODEMP', QryRelatorio);

        If Not fEmptyStr(cmbEstados.Items[cmbEstados.ItemIndex]) Then
          ParamByName('ESTADO').AsString := cmbEstados.Items[cmbEstados.ItemIndex]
        Else
          ParamByName('ESTADO').AsString := fCadEmp('ESTADO');

        Open;
      End;

      If Not QryRelatorio.IsEmpty Then
      Begin
        Try
          pCriarFormularios(TfrmQckFiscOpeInterEntradas,frmQckFiscOpeInterEntradas);

          If strTipImp = 'M' Then
            frmQckFiscOpeInterEntradas.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckFiscOpeInterEntradas.qckPagina.DefaultFilter := Nil;

          {********************}
          {* CABEÇALHO DO QCK *}
          {*****************LB*}
          If strTipImp = 'M' Then
          Begin
            frmQckFiscOpeInterEntradas.rllNomeRelatorio.Caption := 'RELATORIO DE OPERACOES INTERESTADUAIS - SAIDAS ';
            frmQckFiscOpeInterEntradas.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
          End
          Else
          Begin
            frmQckFiscOpeInterEntradas.rllNomeRelatorio.Caption := 'RELATÓRIO DE OPERAÇÕES INTERESTADUAIS - SAÍDAS ';
            frmQckFiscOpeInterEntradas.strOrdem := 'REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
          End;

          frmQckFiscOpeInterEntradas.strCodEmpresa := fStrTitulo(edtEmpresa.Text, edtDesEmpresa, arrEmp, strEmpresa, '',TRUE);
          frmQckFiscOpeInterEntradas.strCarregaInfEmpresa := IfThen(edtEmpresa.Text = '000', 'N', 'S');

          If fEmptyStr(cmbEstados.Items[cmbEstados.ItemIndex]) Then
            frmQckFiscOpeInterEntradas.rllEstado.Caption := 'ESTADO: TODOS '
          Else
            frmQckFiscOpeInterEntradas.rllEstado.Caption := 'ESTADO: ' + cmbEstados.Items[cmbEstados.ItemIndex] + ' - ' + edtDesEstado.Text;

          If fEmptyStr(edtEmpresa.Text) Then
            frmQckFiscOpeInterEntradas.rllEmpresa.Caption := 'EMPRESA: TODOS '
          Else
            frmQckFiscOpeInterEntradas.rllEmpresa.Caption := 'EMPRESA: ' + fStrTitulo(edtEmpresa.Text, edtDesEmpresa, arrEmp, strEmpresa, '',TRUE);

          frxRelatorio.DataSet := QryRelatorio;

          frmQckFiscOpeInterEntradas.dtsRelatorio.DataSet := QryRelatorio;

          If edtDestino.Text = 'V' Then
            pPreviewReport(Self.Name, Self.Caption, frmQckFiscOpeInterEntradas.qckPagina, frmQckFiscOpeInterEntradas.rpsSetup)
          Else
            pPrintReport(Self.Name, Self.Caption, strNomImp, frmQckFiscOpeInterEntradas.qckPagina);

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;
        pFreeAndNil(frmQckFiscOpeInterEntradas);
      End
      Else
      Begin
        pTabelaVazia;
      End;
    finally
      FreeAndNil(QryRelatorio);
    end;
  end;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';
end;

procedure TfrmRelFiscOpeInterSaidas.cmbEstadosExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(cmbEstados.Items[cmbEstados.ItemIndex]) Then
    edtDesEstado.Text := 'TODOS '
  Else
    edtDesEstado.Text := fRetNomeEstado(cmbEstados.Items[cmbEstados.ItemIndex]);

  If fEmptyStr(edtDesEstado.Text) And (Not fEmptyStr(cmbEstados.Items[cmbEstados.ItemIndex])) Then
  Begin
    fMensagem('ATENÇÃO','Estado não encontrado',['&O K']);
    pSetFocus(cmbEstados);
  End;

  If (cmbEstados.Items[cmbEstados.ItemIndex] = fCadEmp('ESTADO')) Then
  Begin
    fMensagem('ATENÇÃO','Operações inter estaduais não podem ser dentro do estado!',['&O K']);
    pSetFocus(cmbEstados);
    Exit;
  End;
end;

end.

