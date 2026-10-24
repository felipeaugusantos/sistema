unit untRelDASRupturaVendas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF, frxExportHTML,
  frxExportXLS, frxExportRTF, Uni, AppEvnts,
  BitBtnLockedIncrem, frxExportCSVTestabilidade;

type
  TfrmRelDASRupturaVendas = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    gpbClientes: TGroupBox;
    ColorLabel3: TColorLabel;
    edtClientes: TEditFocus;
    lblEmpresa: TLabel;
    edtDesEmpresa: TEditFocus;
    edtCodEmpresa: TEditFocus;
    frxRelatorioJ: TfrxReport;
    frxRelatorioM: TfrxReport;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

uses untFuncoesSimples, untModuloSPR, DB, untConsultas, untCfgRel, untTypesSistema;

{$R *.dfm}

{ TfrmRelDASRupturaVendas }

procedure TfrmRelDASRupturaVendas.FormShow(Sender: TObject);
begin
  edtCodEmpresa.Text := VS_strCodEmp;
  edtCodEmpresaExit(Sender);

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  inherited;
end;

function TfrmRelDASRupturaVendas.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
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
    Else If (Sender = edtClientes) Then
    Begin

      If fEmptyStr(edtClientes.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A opção Clientes deve ser preenchida!', ['&Ok']);
        pSetFocus(edtClientes);
      End
      Else If Pos(edtClientes.Text, 'A_I_T_') <= 0 Then
      Begin
        pSetFocus(edtClientes);
      End;

    End
    Else If (Sender = edtCodEmpresa) Then
    Begin

      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelDASRupturaVendas.btnImprimirClick(Sender: TObject);
  Var
    strSQL     : String;
    strAux     : String;
    strClientes: String;
    strNomeFila: String;
    frxRelat   : TfrxReport;
begin

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  DET_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  DET_ESTADO AS ESTADO, ';
    strSQL := strSQL + '  CLI_CODCID AS CODCID  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET, ';
    strSQL := strSQL + '  CADCLI  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '  DET_CODCLI = CLI_CODCLI AND ';
    strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN  AND ';

    If (Not fEmptyStr(edtCodEmpresa.Text)) Then
      strSQL := strSQL + '  DET_CODEMP = :CODEMP AND '
    Else
      strSQL := strSQL + '  LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 AND ';

    strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '  DET_TIP_FC = "C" AND ';
    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)) ';

    If (Pos(edtClientes.Text, 'AI') > 0) Then
    Begin
      strSQL := strSQL + '  AND CLI_STATUS = :STATUS ';
    End;

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  CODCLI ';

    With frmModuloSPR.qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      If (Not fEmptyStr(edtCodEmpresa.Text)) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

      If (Pos(edtClientes.Text, 'AI') > 0) Then
      Begin
        ParamByName('STATUS').AsString := edtClientes.Text;
      End;

      Open;

      While Not Eof Do
      Begin
        strClientes := strClientes + QuotedStr(FieldByName('CODCLI').AsString) + ', ';
        Next;
      End;

      Close;

      {*****************************}
      {* RETIRA A VIRGULA DO FINAL *}
      {**************************AF*}
      strClientes := LeftStr(strClientes,Length(strClientes) - 2);

      {**********************************************}
      {* PEGA CLIENTES QUE NÃO COMPRARAM NO PERIODO *}
      {*******************************************IV*}
      strAux := '';
      strAux := strAux + ' SELECT SQL_NO_CACHE ';
      strAux := strAux + '    GER_CODCLI, GER_NOMCON, GER_CGCCON, GER_NUMDOC, ';
      strAux := strAux + '    GER_ESPDOC, GER_CODEMP, GER_VLRCON, GER_CODVEN, GER_DTAENT, GER_HORENT  ';
      strAux := strAux + ' FROM MOVGER         ';
      strAux := strAux + '    INNER JOIN CADCLI ON CLI_CODCLI = GER_CODCLI    ';
      strAux := strAux + ' WHERE GER_ESPDOC NOT IN ("FF", "TR", "DV")   AND   ';
      strAux := strAux + '    GER_CODCLI NOT IN (' + VS_strCliFil + ')  AND   ';

      If (Not fEmptyStr(strClientes)) Then
        strAux := strAux + '  GER_CODCLI NOT IN (' + strClientes  + ')  AND   ';

      If (Not fEmptyStr(edtCodEmpresa.Text)) Then
           strAux := strAux + '  GER_CODEMP = :CODEMP AND '
      Else strAux := strAux + '  LOCATE(GER_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 AND ';

      strAux := strAux + '    GER_TIP_FC = "C" AND ';
      strAux := strAux + '    ((LOCATE(GER_CLAFIS, :CLAFIS) > 0) OR (LOCATE(GER_CLAFIS, :CLADEV) > 0)) ';

      strAux := strAux + ' ORDER BY GER_DTAENT DESC, GER_HORENT DESC ';

      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  T.GER_CODCLI,     ';
      strSQL := strSQL + '  IFNULL(T.GER_NOMCON,C.CLI_NOMCLI) AS GER_NOMCON, ';
      strSQL := strSQL + '  T.GER_CGCCON,     ';
      strSQL := strSQL + '  A.ATI_DESATI,     ';
      strSQL := strSQL + '  R.REG_DESREG,     ';
      strSQL := strSQL + '  T.GER_NUMDOC,     ';
      strSQL := strSQL + '  T.GER_ESPDOC,     ';
      strSQL := strSQL + '  T.GER_CODVEN,     ';
      strSQL := strSQL + '  P.OPE_NOMOPE,     ';
      strSQL := strSQL + '  T.GER_VLRCON      ';
      strSQL := strSQL + 'FROM ( ' + strAux + ' ) T ';
      strSQL := strSQL + '  INNER JOIN CADCLI C ON T.GER_CODCLI = C.CLI_CODCLI ';
      strSQL := strSQL + '  LEFT  JOIN CADATI A ON A.ATI_CODATI = C.CLI_CODATI ';
      strSQL := strSQL + '  LEFT  JOIN CADREG R ON R.REG_CODREG = C.CLI_CODREG ';
      strSQL := strSQL + '  LEFT  JOIN CADOPE P ON P.OPE_CODOPE = T.GER_CODVEN ';

      If (Pos(edtClientes.Text, 'AI') > 0) Then
        strSQL := strSQL + 'WHERE C.CLI_STATUS = :STATUS ';

      strSQL := strSQL + 'GROUP BY        ';
      strSQL := strSQL + '  T.GER_CODCLI, ';
      strSQL := strSQL + '  T.GER_CGCCON  ';
      strSQL := strSQL + 'ORDER BY        ';
      strSQL := strSQL + '  GER_NOMCON    ';

      SQL.Clear;
      SQL.Add(strSQL);

      If (Not fEmptyStr(edtCodEmpresa.Text)) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      ParamByName('CLAFIS').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;

      If (Pos(edtClientes.Text, 'AI') > 0) Then
        ParamByName('STATUS').AsString := edtClientes.Text;

      Open;
    End;

    If Not frmModuloSPR.qryRelatorio.IsEmpty Then
    Begin

      pCarregaConfImpr(qryCfgRel, Self.Name);
      strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      If strTipImp = 'M' Then
        frxRelat := frxRelatorioM
      Else
      Begin
        frxRelat := frxRelatorioJ;
        frxRelat.PrintOptions.PrintMode    := pmScale;
        frxRelat.PrintOptions.PrintOnSheet := 9;
      End;

      frxRelat.PrintOptions.Printer := AnsiReplaceText(strNomeFila, '\\' + fRetNomeRede + '\', '');

      frxRelat.Script.Variables['NOMREL'] := 'RELATORIO DE RUPTURA DE VENDAS';
      frxRelat.Script.Variables['PERIOD'] := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;
      frxRelat.Script.Variables['EMPRES'] := 'EMPRESA: ' + IIF( Not fEmptyStr(edtCodEmpresa.Text),
                                                                edtCodEmpresa.Text + '-' + edtDesEmpresa.Text, 'TODAS');

      If edtDestino.Text = 'V' Then
        pPreviewReport(Self.Name, Self.Caption, frxRelat)
      Else If frxRelat.PrepareReport Then
        pPrintReport(Self.Name, Self.Caption, strNomeFila, frxRelat);
    End
    Else
      pTabelaVazia;
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption := '';

end;

procedure TfrmRelDASRupturaVendas.edtCodEmpresaKeyPress(Sender: TObject;
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
    fValidaCampos(edtCodEmpresa, True);
  End;
end;

procedure TfrmRelDASRupturaVendas.edtCodEmpresaExit(Sender: TObject);
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

end.

