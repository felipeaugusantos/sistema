unit untRelPedMetasVendedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, Mask, MaskEditFocus, RLFilters, RLDraftFilter,
  Menus, StdCtrls, EditFocus, QColorLabel, Buttons, ExtCtrls, StrUtils,
  DateUtils, frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF,
  frxExportHTML, frxExportXLS, frxExportRTF, Uni,
  AppEvnts, BitBtnLockedIncrem, frxExportCSVTestabilidade;

type
  TfrmRelPedMetasVendedor = class(TfrmPaiRelatorio)
    Label7: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    lblEmpresa: TLabel;
    Label12: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbQuebra: TGroupBox;
    ColorLabel6: TColorLabel;
    edtQuebra: TEditFocus;
    mskMesAnoIni: TMaskEditFocus;
    mskMesAnoFin: TMaskEditFocus;
    rdgFaturamento: TRadioGroup;
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryRelatorio: TUniQuery;

		procedure pCriaQryRelatorio;
  public
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelPedMetasVendedor: TfrmRelPedMetasVendedor;

implementation

uses  untFuncoesFactory, untTypesSistema, untIFuncoes, untQckPedMetasVendedor,
    Data.DB;


{$R *.dfm}

{*****************}
{* VALIDA CAMPOS *}
{**************RL*}
function TfrmRelPedMetasVendedor.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*************************}
    {* VALIDA PERÍODO INICIAL }
    {**********************RL*}
    If (Sender = mskMesAnoIni) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskMesAnoIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Período Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        Try
          strToDate('01/' + mskMesAnoIni.Text)
        Except
          fMensagem('', 'Mês / Ano inválido !', ['&O k']);
          Result := False;
        End;

      End;


    End

    {*********************}
    {* VALIDA DATA FINAL *}
    {******************RL*}
    Else If (Sender = mskMesAnoFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskMesAnoFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Período Final deve ser preenchido!', ['&O k']);
        Result := False;
      End

      Else
      Try
        If StrToDate('01/' + mskMesAnoIni.Text) > StrToDate('01/' + mskMesAnoFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!','O período inicial deve ser menor que o período final!',['&O K']);
          Result := False;
        End;
      Except
        fMensagem('','Mês / Ano inválido!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtQuebra) Then
    Begin

      If (edtQuebra.Text <> 'V') AND (edtQuebra.Text <> 'M') Then
      Begin
        fMensagem('','O campo deve conter V ou M! ',['&O K']);
        Result := False;
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

procedure TfrmRelPedMetasVendedor.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelPedMetasVendedor.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqOperador(Self, edtCodVendedor, edtDesVendedor, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodVendedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelPedMetasVendedor.edtCodVendedorExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodVendedor.Text) Then
    edtDesVendedor.Text := 'TODOS'
  Else
    edtDesVendedor.Text := fRetNomVendRep(edtCodVendedor.Text);

  If fEmptyStr(edtDesVendedor.Text) And (Not fEmptyStr(edtCodVendedor.Text))  Then
  Begin
    fMensagem('AVISO','Código do vendedor não foi encontrado.', ['&O K']);
    edtDesVendedor.Clear;
    pSetFocus(edtCodVendedor);
  End;

end;

procedure TfrmRelPedMetasVendedor.edtCodEmpresaKeyPress(Sender: TObject;
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

procedure TfrmRelPedMetasVendedor.edtCodEmpresaExit(Sender: TObject);
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

procedure TfrmRelPedMetasVendedor.btnImprimirClick(Sender: TObject);
  Var
    strSQL : String;
    ADay   : Word;
    strSQLFrom : String;
begin
  inherited;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  //***************************************//
  // MONTAR QUERY DO RELATÓRIO             //
  //************************************RL*//
  If blnImprime Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  O.OPE_CODOPE, ';
    strSQL := strSQL + '  O.OPE_NOMOPE, ';
    strSQL := strSQL + '  M.MET_MESANO, ';
    strSQL := strSQL + '  M.MET_TOTMET, ';
    strSQL := strSQL + '  SUM(F.FDO_TOTITE - F.FDO_DESESP) AS  TOTAL, ';
    strSQL := strSQL + '  (SUM(F.FDO_TOTITE - F.FDO_DESESP) / M.MET_TOTMET) * 100 AS METATINGIDA ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  FATDOR F ';
    strSQL := strSQL + '  JOIN CADOPE       O ON F.FDO_CODVEN = O.OPE_CODOPE ';
    strSQL := strSQL + '  JOIN CADMET       M ON F.FDO_CODVEN = M.MET_CODVEN ';
    strSQL := strSQL + '  INNER JOIN FATGOR G ON F.FDO_SEQGER = G.AUTOINCREM ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  F.FDO_PROEMB <> "S" AND ';
    strSQL := strSQL + '  F.FDO_ESPDOC = "PD" AND ';
    strSQL := strSQL + '  O.OPE_CODOPE = M.MET_CODVEN AND ';
    strSQL := strSQL + '  MONTH(F.FDO_DTAENT) BETWEEN SUBSTRING(M.MET_MESANO,1,2) AND SUBSTRING(M.MET_MESANO,1,2) AND ';
    strSQL := strSQL + '  YEAR(F.FDO_DTAENT) BETWEEN SUBSTRING(M.MET_MESANO,3,4) AND SUBSTRING(M.MET_MESANO,3,4) AND ';
    strSQL := strSQL + '  F.FDO_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

    Case rdgFaturamento.ItemIndex Of
      1: Begin
           strSQL := strSQL + ' AND (((IFNULL((SELECT COUNT(*) FROM FATDOR I              ';
           strSQL := strSQL + '              WHERE (I.FDO_SEQGER = F.FDO_SEQGER) AND (F.FDO_QTDBAI > 0)), 0) > 0) AND (G.FGO_MOTBAI IS NULL)) ';
           strSQL := strSQL + '       OR (F.FDO_JAFATU = 1 AND G.FGO_MOTBAI IS NULL)) ';
         End;

      2: strSQl := strSQL + ' AND ((F.FDO_JAFATU = 0) AND (ROUND(F.FDO_QTDBAI, 2) < ROUND(F.FDO_QTDITE, 2))) ';
      3: strSQl := strSQL + ' AND ((F.FDO_JAFATU = 1) AND (G.FGO_MOTBAI IS NOT NULL)) ';
    End;

    If Not fEmptyStr(edtCodVendedor.Text) Then
      strSQL := strSQL + '  AND F.FDO_CODVEN = :CODVEN ';

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND F.FDO_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '  AND LOCATE(F.FDO_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    strSQL := strSQL + '  AND FDO_VLRCON <> 0 ';

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  O.OPE_CODOPE, M.MET_MESANO ';

    strSQLFrom := strSQL;
    strSQLFrom := '(' + strSQLFrom + ') AUX ' ;

    With qryRelatorio Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  OPE_CODOPE, ';
      strSQL := strSQL + '  OPE_NOMOPE, ';
      strSQL := strSQL + '  MET_MESANO, ';
      strSQL := strSQL + '  MET_TOTMET, ';
      strSQL := strSQL + '  SUM(TOTAL) TOTAL, ';
      strSQL := strSQL + '  SUM(METATINGIDA) METATINGIDA, ';
      strSQL := strSQL + '  IF(MET_TOTMET < SUM(TOTAL), 0, MET_TOTMET - SUM(TOTAL)) METCONCLUIR ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '     ' + strSQLFrom + '  ';
      strSQL := strSQL + 'GROUP BY ';
      strSQL := strSQL + ' OPE_CODOPE, MET_MESANO ';
      strSQL := strSQL + 'ORDER BY ';

      If edtQuebra.Text = 'V' Then
        strSQL := strSQL + '  1, 3 '
      Else
        strSQL := strSQL + '  3, 1 ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ADay := DaysInMonth(StrToDate('01/' + mskMesAnoFin.text));
      ParamByName('DTAINI').AsDateTime := strToDate('01/' + mskMesAnoIni.text);
      ParamByName('DTAFIN').AsDateTime := strToDate(IntToStr(ADay) + '/' + mskMesAnoFin.text);

      If Not fEmptyStr(edtCodVendedor.Text) Then
        ParamByName('CODVEN').AsString := edtCodVendedor.Text;

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      Open;
    End;


    If Not qryRelatorio.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmQckPedMetasVendedor,frmQckPedMetasVendedor);

        frmQckPedMetasVendedor.dtsRelatorio.DataSet := qryRelatorio;

        {********************}
        {* CABECALHO DO QCK *}
        {*****************RL*}
        frmQckPedMetasVendedor.rllOrdem.Caption := 'REFERENTE AO PERIODO DE ' + mskMesAnoIni.Text + ' A ' + mskMesAnoFin.Text;

        If fEmptyStr(edtCodVendedor.Text) Then
          frmQckPedMetasVendedor.rllNomeVen.Caption := 'VENDEDOR: TODOS '
        Else
          frmQckPedMetasVendedor.rllNomeVen.Caption := 'VENDEDOR: ' + edtCodVendedor.Text + ' - ' + edtDesVendedor.Text;

        If fEmptyStr(edtCodEmpresa.Text) Then
          frmQckPedMetasVendedor.rllEmpresa.Caption := 'EMPRESA: TODOS '
        Else
          frmQckPedMetasVendedor.rllEmpresa.Caption := 'EMPRESA: ' + edtCodEmpresa.Text + ' - ' + edtDesEmpresa.Text;

        frmQckPedMetasVendedor.rllOpcao.Caption := 'OPCAO: ' + UpperCase( rdgFaturamento.Items.Strings[rdgFaturamento.ItemIndex] );

        If edtQuebra.Text = 'V' Then
        Begin
          frmQckPedMetasVendedor.rllNomeRelatorio.Caption   := 'RELATORIO DE METAS POR VENDEDOR (PEDIDO) - QUEBRA POR VENDEDOR';
          frmQckPedMetasVendedor.rlbTitulo.Visible          := True;
          frmQckPedMetasVendedor.rlbGrupo.Visible           := True;
        End
        Else
        Begin
          frmQckPedMetasVendedor.rllNomeRelatorio.Caption := 'RELATORIO DE METAS POR VENDEDOR (PEDIDO) - QUEBRA POR MES';
          frmQckPedMetasVendedor.rlbTitulo2.Visible       := True;
          frmQckPedMetasVendedor.rlbGrupo2.Visible        := True;
        End;


        If edtDestino.Text = 'V' Then
           frmQckPedMetasVendedor.qckPagina.PreviewModal
        Else
           frmQckPedMetasVendedor.qckPagina.Print;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;

      pFreeAndNil(frmQckPedMetasVendedor);

    End
    Else
    Begin
      pTabelaVazia;
    End;

    btnImprimir.Enabled := True;
    pnlInfo.Caption := '';
  End;

  pSetFocus(mskMesAnoIni);

end;

procedure TfrmRelPedMetasVendedor.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelPedMetasVendedor.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_RETURN) Then
    If (ActiveControl.Parent = rdgFaturamento) Then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmRelPedMetasVendedor.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;
  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskMesAnoIni.Text := FormatDateTime('mm/yyyy',VS_Date);
  mskMesAnoFin.Text := FormatDateTime('mm/yyyy',VS_Date);

  inherited;
end;

end.

