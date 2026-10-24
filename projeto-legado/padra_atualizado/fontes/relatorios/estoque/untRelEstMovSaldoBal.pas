unit untRelEstMovSaldoBal;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter,
  QColorLabel, EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus,
  StrUtils, Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport, Uni,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  AppEvnts, ComCtrls, BitBtnLockedIncrem, untTypesSistema,
  frxExportCSVTestabilidade, Math, untIFuncoes;

type
  TRecTotSin = Record
    fltSalAnt,
    fltSalBal,
    fltSalDif,
    fltML_Ant,
    fltML_Bal: Double;
  End;

type
  TfrmRelEstMovSaldoBal = class(TfrmPaiRelatorio)
    Label9: TLabel;
    mskLinhaGrupo: TMaskEditFocus;
    Label3: TLabel;
    mskLinhaGrupo2: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtDesGrupo2: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label1: TLabel;
    edtEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    chkImpRef: TCheckBox;
    gpbOpcao: TGroupBox;
    edtOpcao: TEditFocus;
    ColorLabel2: TColorLabel;
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupo2Exit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupo2KeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaEmpresa(Var qryCadEmp: TUniQuery);
    procedure mskLinhaGrupoEnter(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure edtEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpresaExit(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    blnPrimeiraVez: Boolean;
    qryRelatorio: TUniQuery;

    procedure pGeraExcel;
    procedure pCriaQryRelatorio;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    blnImprimeDireto: Boolean;
  end;

var
  frmRelEstMovSaldoBal: TfrmRelEstMovSaldoBal;

implementation

uses untQckEstMovSaldoBal, untExcel, untFuncoesFactory, DB;

{$R *.dfm}

procedure TfrmRelEstMovSaldoBal.mskLinhaGrupoExit(Sender: TObject);
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

procedure TfrmRelEstMovSaldoBal.mskLinhaGrupo2Exit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo2.Text) Then
    edtDesGrupo2.Text := 'TODOS'
  Else
  Begin
    edtDesGrupo2.Text := fRetNomeLinhaGrupo(mskLinhaGrupo2.Text);
    If fEmptyStr(edtDesGrupo2.Text) Then
    Begin
      fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
      mskLinhaGrupo2.Clear;
      pSetFocus(mskLinhaGrupo2);
    End;
  End;
end;

procedure TfrmRelEstMovSaldoBal.mskLinhaGrupoKeyPress(Sender: TObject;
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

procedure TfrmRelEstMovSaldoBal.mskLinhaGrupo2KeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  If fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    Key := #0;
    Exit;
  End;

  If fPesqGrupo(Self, mskLinhaGrupo2, edtDesGrupo2, nil, Key, arrSel) Then  
  Begin
    If fValidaCampos(mskLinhaGrupo2, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

{*****************}
{* VALIDA CAMPOS *}
{**************ED*}
function TfrmRelEstMovSaldoBal.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
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

    End;

    If (Sender = mskLinhaGrupo) Then
    Begin
      mskLinhaGrupo2.Enabled := Not fEmptyStr(mskLinhaGrupo.Text);
    End
    Else

    If (Sender = mskLinhaGrupo2) Then
    Begin

      If Not fEmptyStr(mskLinhaGrupo2.Text) Then
      Begin

        If mskLinhaGrupo2.Text < mskLinhaGrupo.Text Then
        Begin
          fMensagem('','A Linha/Grupo inicial deve ser menor que a final!',['&O K']);
          Result := False;
        End;

      End;
    End

    {**************************}
    {* VERIFICA CAMPO DESTINO *}
    {***********************LU*}
    Else If (Sender = edtDestino) Then
    Begin
      If (edtDestino.Text <> 'I') And (edtDestino.Text <> 'V') And (edtDestino.Text <> 'E') Then
      Begin
        fMensagem('','O campo Destino deve ser V, I ou E!',['&O K'],0);
        Result := False;
      End;
    End

    {**************************}
    {* VERIFICA CAMPO EMPRESA *}
    {***********************LU*}
    Else If (Sender = edtEmpresa) Then
    Begin
      If Not fEmptyStr(edtEmpresa.Text) Then
      Begin
        If Pos(edtEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtOpcao) Then
    Begin
      Result := (Pos(edtOpcao.Text, 'LF') > 0);
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelEstMovSaldoBal.mskLinhaGrupoEnter(Sender: TObject);
begin
  inherited;
  mskLinhaGrupo2.Clear;
  edtDesGrupo2.Text := '';
end;

procedure TfrmRelEstMovSaldoBal.btnImprimirClick(Sender: TObject);
  CONST
    STR_SALDOS = ' IFNULL(S.SBA_SALDOS, 0) ';
    STR_SALBAL = ' IFNULL(S.SBA_SALBAL, 0) ';
    STR_DIFERE = ' (' + STR_SALBAL + ' - ' + STR_SALDOS + ') ';
    STR_DIF_ML = ' (IFNULL(S.SBA_ML_BAL, 0) - IFNULL(S.SBA_SAL_ML, 0)) ';
    STR_CUSFEC = ' ( ' + STR_DIFERE + ' * IFNULL(G.ITE_PRECUS,0) ) ';
    STR_CUS_ML = ' ( ' + STR_DIF_ML + ' * (G.ITE_PRECUS / IF(ITE_CNV_ML IS NULL OR ITE_CNV_ML = "" OR ITE_CNV_ML = 0,1, ITE_CNV_ML))) ';
  Var
    strSQL: String;
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  If edtDestino.Text <> 'E' Then
    inherited;

  If (blnImprime) or (edtDestino.Text = 'E') Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  LEFT(I.ITE_CODGRU,3) AS LINHA, ';
    strSQL := strSQL + '  I.ITE_CODGRU AS GRUPO,  ';
    strSQL := strSQL + '  S.SBA_CODITE AS CODITE, ';
    strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  G.ITE_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '  I.ITE_CODUNI AS UNIDAD, ';
    strSQL := strSQL + '  DATE_FORMAT(S.SBA_DTABAL,"%d/%m/%y") AS DTAULT, ';

    strSQL := strSQL + STR_SALDOS + ' AS SALDOS, ';
    strSQL := strSQL + STR_SALBAL + ' AS SALBAL, ';
    strSQL := strSQL + STR_DIFERE + ' AS DIFERE, ';
    strSQL := strSQL + ' ( ' + STR_CUSFEC + ' + ' + STR_CUS_ML + ' ) AS SALDIF, ' ;

    strSQL := strSQL + '  IFNULL(S.SBA_SAL_ML,0) AS SAL_ML, ';
    strSQL := strSQL + '  IFNULL(S.SBA_ML_BAL,0) AS BAL_ML, ';
    strSQL := strSQL + '  (IFNULL(S.SBA_ML_BAL,0) - IFNULL(S.SBA_SAL_ML,0)) AS DIF_ML, ';

    strSQL := strSQL + '  I.ITE_CODFOR AS CODFOR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVSBA S, ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  S.SBA_CODITE = G.ITE_CODITE AND ';
    strSQL := strSQL + '  S.SBA_CODEMP = G.ITE_CODEMP AND ';
    strSQL := strSQL + '  S.SBA_DTABAL BETWEEN :DTAINI AND :DTAFIN';

    If Not fEmptyStr(edtEmpresa.Text) Then
      strSQL := strSQL + '  AND G.ITE_CODEMP = :CODEMP ';

    {*******************************************}
    {* VERIFICA MSKLINHAGRUPO E MSKLINHAGRUPO2 *}
    {* SE DIGITAR UMA LINHA ELE VAI MONTAR UM  *}
    {* SELECT PARA PEGAR TODOS OS GRUPOS DESTA *}
    {* LINHA TANTO NO MSKLINHAGRUPO QUANTO     *}
    {* MSKLINHAGRUPO2                          *}
    {****************************************ED*}
    If Not fEmptyStr(mskLinhaGrupo.Text) Then
    Begin
      {***********************************************}
      {* VERIFICA SE O QUE FOI DIGITADO EH UMA LINHA *}
      {********************************************ED*}
      If RightStr(mskLinhaGrupo.Text,3) = '000' Then
      Begin

        If Not fEmptyStr(mskLinhaGrupo2.Text) Then
        Begin
          If RightStr(mskLinhaGrupo2.Text,3) = '000' Then
            strSQL := strSQL + '  AND LEFT(I.ITE_CODGRU,3) BETWEEN LEFT(:CODGRU,3) AND LEFT(:CODGRU2,3) '
          Else
            strSQL := strSQL + '  AND I.ITE_CODGRU BETWEEN CONCAT(LEFT(:CODGRU,3),"000") AND :CODGRU2 ';
        End
        Else
          strSQL := strSQL + '  AND LEFT(I.ITE_CODGRU,3) = LEFT(:CODGRU,3) ';

      End
      Else
      Begin

        If Not fEmptyStr(mskLinhaGrupo2.Text) Then
        Begin
          If RightStr(mskLinhaGrupo2.Text,3) = '000' Then
            strSQL := strSQL + '  AND I.ITE_CODGRU BETWEEN :CODGRU AND CONCAT(LEFT(:CODGRU2,3),"099") '
          Else
            strSQL := strSQL + '  AND I.ITE_CODGRU BETWEEN :CODGRU AND :CODGRU2 ';
        End
        Else
          strSQL := strSQL + '  AND I.ITE_CODGRU = :CODGRU ';

      End;
    End;


    strSQL := strSQL + ' ORDER BY ';
    If edtOpcao.Text = 'L' Then
      strSQL := strSQL + '   LINHA, GRUPO, DESITE '
    Else
      strSQL := strSQL + '   CODFOR, DESITE ';

    With  qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(mskLinhaGrupo.Text) Then
        ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;

      If Not fEmptyStr(mskLinhaGrupo2.Text) Then
        ParamByName('CODGRU2').AsString := mskLinhaGrupo2.Text;

      If Not fEmptyStr(edtEmpresa.Text) Then
        ParamByName('CODEMP').AsString   := edtEmpresa.Text;

      ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);

      Open;
    End;

    If Not  qryRelatorio.IsEmpty Then
    Begin

      If edtDestino.Text = 'E' Then
        pGeraExcel
      Else
      Begin

        Try
          pCriarFormularios(TfrmQckEstMovSaldoBal,frmQckEstMovSaldoBal);

          frmQckEstMovSaldoBal.dtsRelatorio.DataSet := qryRelatorio;

          If strTipImp = 'M' Then
            frmQckEstMovSaldoBal.qckPagina.DefaultFilter := rldFiltro
          Else
            frmQckEstMovSaldoBal.qckPagina.DefaultFilter := Nil;

          frmQckEstMovSaldoBal.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

          {******************}
          {* HEADER GRUPO 1 *}
          {***************ED*}
          If Not fEmptyStr(mskLinhaGrupo2.Text) Then
            frmQckEstMovSaldoBal.rllGrupo.Caption := 'LINHA/GRUPO INICIAL: ' + mskLinhaGrupo.Text + ' - ' + edtDesGrupo.Text
          Else
            frmQckEstMovSaldoBal.rllGrupo.Caption := 'LINHA/GRUPO INICIAL: TODOS';
          {******************}
          {* HEADER GRUPO 2 *}
          {***************ED*}
          If Not fEmptyStr(mskLinhaGrupo2.Text) Then
            frmQckEstMovSaldoBal.rllGrupoFin.Caption := 'LINHA/GRUPO FINAL: ' + mskLinhaGrupo2.Text + ' - ' + edtDesGrupo2.Text
          Else
            frmQckEstMovSaldoBal.rllGrupoFin.Caption := 'LINHA/GRUPO FINAL: TODOS';

          If Not fEmptyStr(edtEmpresa.Text) Then
            frmQckEstMovSaldoBal.rllEmpresa.Caption := 'EMPRESA: ' + edtEmpresa.Text + ' - ' + edtDesEmpresa.Text
          Else
            frmQckEstMovSaldoBal.rllEmpresa.Caption := 'EMPRESA: TODAS';

          If edtOpcao.Text = 'L' Then
            frmQckEstMovSaldoBal.rllOpcao.Caption := 'OPÇÃO: LINHA / GRUPO'
          Else
            frmQckEstMovSaldoBal.rllOpcao.Caption := 'OPÇÃO: FORNECEDOR';

          If Not chkImpRef.Checked Then
          Begin
            With frmQckEstMovSaldoBal Do
            Begin
              rdbDescriLin.Width  := rdbDescriLin.Width + rdbRefereLin.Width;

              rllReferencia.Visible := False;
              rdbRefereLin.Visible  := False;
              rdbRefereFor.Visible  := False;
            End;
          End;

          If (edtOpcao.Text = 'F') Then
          Begin
            frmQckEstMovSaldoBal.rlbGrupo.Visible    := False;
            frmQckEstMovSaldoBal.rlbGrupoFor.Visible := True;
          End;

          If edtDestino.Text = 'V' Then
            frmQckEstMovSaldoBal.qckPagina.PreviewModal
          Else
            frmQckEstMovSaldoBal.qckPagina.Print;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[frmRelEstMovSaldoBal.btnImprimirClick]');
          End;
        End;
        pFreeAndNil(frmQckEstMovSaldoBal);

      End;

    End
    Else
    Begin
      pTabelaVazia;
    End;

  End;
  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';

end;

procedure TfrmRelEstMovSaldoBal.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelEstMovSaldoBal.FormCreate(Sender: TObject);
begin
  inherited;
  blnImprimeDireto := False;
  blnPrimeiraVez   := True;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
end;

procedure TfrmRelEstMovSaldoBal.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelEstMovSaldoBal.FormPaint(Sender: TObject);
begin
  inherited;
  If (blnPrimeiraVez) Then
  Begin

    blnPrimeiraVez := False;

    If (blnImprimeDireto) Then
    Begin
      btnImprimir.Click;
      Close;
    End;

  End;
end;

procedure TfrmRelEstMovSaldoBal.FormShow(Sender: TObject);
begin
  inherited;
  pCriaQryRelatorio;
end;

procedure TfrmRelEstMovSaldoBal.edtEmpresaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstMovSaldoBal.edtEmpresaExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtEmpresa.Text) Then
    edtDesEmpresa.Text := 'TODAS'
  Else
    edtDesEmpresa.Text := fRetNomeEmpresa(edtEmpresa.Text);

  If fEmptyStr(edtDesEmpresa.Text) And (Not fEmptyStr(edtEmpresa.Text))  Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtEmpresa.Clear;
    pSetFocus(edtEmpresa);
  End;
end;

procedure TfrmRelEstMovSaldoBal.pCarregaEmpresa(Var qryCadEmp: TUniQuery);
Begin
  If Not (fEmptyStr(edtEmpresa.Text)) Then
    edtDesEmpresa.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString
  Else
    edtDesEmpresa.Text := '';
End;

procedure TfrmRelEstMovSaldoBal.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelEstMovSaldoBal.pGeraExcel;

  var
    arrSintetico: Array Of Array Of String;

    intCont: Integer;
    intQtdCol : Integer;
    intConRef : Integer;
    strUltCol : String;
    strLinAnt : String;
    strGruAnt : String;
    strGruMsk : String;
    objExcel  : TExcel;

    RecTotGru : TRecTotSin;
    RecTotGer : TRecTotSin;

    procedure pZeraTotais(Var recTotais: TRecTotSin);
    begin
      With recTotais Do
      Begin
        fltSalAnt := 0;
        fltSalBal := 0;
        fltSalDif := 0;
        fltML_Ant := 0;
        fltML_Bal := 0;
      End;
    end;

    procedure pSomaTotais(Var recTotais: TRecTotSin);
    begin
      With recTotais Do
      Begin
        fltSalAnt := fltSalAnt +  qryRelatorio.FieldByName('SALDOS').AsCurrency;
        fltSalBal := fltSalBal +  qryRelatorio.FieldByName('SALBAL').AsCurrency;
        fltSalDif := fltSalDif +  qryRelatorio.FieldByName('SALDIF').AsCurrency;
        fltML_Ant := fltML_Ant +  qryRelatorio.FieldByName('SAL_ML').AsCurrency;
        fltML_Bal := fltML_Bal +  qryRelatorio.FieldByName('BAL_ML').AsCurrency;
      End;
    End;

    procedure pMontaResumo(Var recTotais: TRecTotSin; intResumo: Integer);
      Var
        strTotal: String;
    begin
      With objExcel, recTotais Do
      Begin

        If (intResumo = 1) Then strTotal := 'TOTAL GRUPO: ';
        If (intResumo = 2) Then strTotal := 'TOTAL GERAL: ';

        ProximaLinha;

        Escrever(LinhaAtual, 01, strTotal);
        Escrever(LinhaAtual, 06 + ifthen(chkImpRef.Checked, 1, 0), fPadL(FormatFloat('##,#0.00', fltSalAnt), 14));
        Escrever(LinhaAtual, 07 + ifthen(chkImpRef.Checked, 1, 0), fPadL(FormatFloat('##,#0.00', fltSalBal), 14));
        Escrever(LinhaAtual, 12 + ifthen(chkImpRef.Checked, 1, 0), fPadL(FormatFloat('##,#0.00', fltSalDif), 14));

        Escrever(LinhaAtual, 09 + ifthen(chkImpRef.Checked, 1, 0), fPadL(FormatFloat('##,#0.00', fltML_Ant), 14));
        Escrever(LinhaAtual, 10 + ifthen(chkImpRef.Checked, 1, 0), fPadL(FormatFloat('##,#0.00', fltML_Bal), 14));

        Negrito(LinhaAtual, 01, True);

        If (chkImpRef.Checked) Then
        Begin
          Alinhamento('F' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Direita);
          Mesclar ('A' + IntToStr(LinhaAtual), 'F' + IntToStr(LinhaAtual));
        End
        Else
        Begin
          Alinhamento('E' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Direita);
          Mesclar ('A' + IntToStr(LinhaAtual), 'E' + IntToStr(LinhaAtual));
        End;

        CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
        CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
        Bordas  ('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

      End;
    end;

begin

  If chkImpRef.Checked Then
    SetLength(arrSintetico, 13, 2)
  Else
    SetLength(arrSintetico, 12, 2);

  arrSintetico[00][00] := 'CODIGO';
  arrSintetico[01][00] := 'DESCRICAO';

  If (chkImpRef.Checked) Then
  Begin
    arrSintetico[02][00] := 'REFERENCIA';
    intConRef := 2;
  End
  Else
    intConRef := 1;

  arrSintetico[intConRef + 01][00] := 'UNID.';
  arrSintetico[intConRef + 02][00] := 'EMP';
  arrSintetico[intConRef + 03][00] := 'DTA.BAL.';
  arrSintetico[intConRef + 04][00] := 'SAL.ANT.';
  arrSintetico[intConRef + 05][00] := 'SAL.BAL.';
  arrSintetico[intConRef + 06][00] := 'DIFER.';
  arrSintetico[intConRef + 07][00] := 'SAL. ML ANT.';
  arrSintetico[intConRef + 08][00] := 'SAL. ML BAL.';
  arrSintetico[intConRef + 09][00] := 'DIFER.';
  arrSintetico[intConRef + 10][00] := 'DIF.CUSTO';

  arrSintetico[00][01] := 'CODITE';
  arrSintetico[01][01] := 'DESITE';

  If (chkImpRef.Checked) Then
  Begin
    arrSintetico[02][01] := 'REFERE';
    intConRef := 2;
  End
  Else
    intConRef := 1;

  arrSintetico[intConRef + 01][01] := 'UNIDAD';
  arrSintetico[intConRef + 02][01] := 'CODEMP';
  arrSintetico[intConRef + 03][01] := 'DTAULT';
  arrSintetico[intConRef + 04][01] := 'SALDOS';
  arrSintetico[intConRef + 05][01] := 'SALBAL';
  arrSintetico[intConRef + 06][01] := 'DIFERE';
  arrSintetico[intConRef + 07][01] := 'SAL_ML';
  arrSintetico[intConRef + 08][01] := 'BAL_ML';
  arrSintetico[intConRef + 09][01] := 'DIF_ML';
  arrSintetico[intConRef + 10][01] := 'SALDIF';

  objExcel := TExcel.fCriarExcel(Self);

  If Not objExcel.CriarArquivo Then
  begin
    FreeAndNil(objExcel);
    Exit;
  End;

  With objExcel Do
  Begin

    PintarTudo(Branco);
    DefinirFonte(CourierNew, 10);

    pZeraTotais(RecTotGru);
    pZeraTotais(RecTotGer);

    LinhaAtual := 1;
    intQtdCol  := Length(arrSintetico);
    strUltCol  := fGetLetraAlfa(intQtdCol);

    pnlInfo.Caption       := 'Aguarde... Gerando Arquivo!';

    Escrever(ProximaLinha,01, fRetNomeEmpresa);
    Escrever(ProximaLinha,01, 'RELATORIO DE MOVIMENTACAO DE SALDO DE BALANCO');
    Escrever(ProximaLinha,01, 'REFERENTE AO PERIODO DE ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text)) + ' A ' + FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaFin.Text)));
    Escrever(ProximaLinha,01, 'LINHA/GRUPO INICIAL: ' + ifthen(fEmptyStr(mskLinhaGrupo.Text), 'TODOS', mskLinhaGrupo.Text + '-' + edtDesGrupo.Text));
    Escrever(ProximaLinha,01, 'LINHA/GRUPO FINAL: ' + ifthen(fEmptyStr(mskLinhaGrupo2.Text), 'TODOS', mskLinhaGrupo2.Text + '-' + edtDesGrupo2.Text));
    Escrever(ProximaLinha,01, 'EMPRESA: ' + ifthen(fEmptyStr(edtEmpresa.Text), 'TODAS', edtEmpresa.Text + '-' + edtDesEmpresa.Text));
    Escrever(ProximaLinha,01, 'OPCAO: ' + ifthen(edtOpcao.Text = 'L', 'LINHA/GRUPO', 'FORNECEDOR'));

    With  qryRelatorio Do
    Begin

      For intCont := 1 To LinhaAtual Do
      Begin
        Mesclar('A' + IntToStr(intCont), strUltCol + IntToStr(intCont));
        Negrito('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), True);
        Alinhamento('A' + IntToStr(intCont), strUltCol + IntToStr(intCont), Centro);
      End;

      CorFundo('A2', strUltCol + '3', Cinza);
      Bordas('A2', strUltCol + '3',True,True,True,True);

      ProximaLinha;

      For intCont := 1 To intQtdCol Do
      Begin
        Escrever(LinhaAtual, intCont, arrSintetico[intCont - 1, 00]);
        Negrito(LinhaAtual, intCont, True);

        If FieldByName(arrSintetico[intCont - 1, 01]).DataType = ftFloat Then
          Alinhamento(LinhaAtual,intCont, Direita)
        Else
          Alinhamento(LinhaAtual,intCont, Esquerda);

      End;

      CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Preto);
      CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
      Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

      First;

      While Not Eof Do
      Begin

        strLinAnt := FieldByName('LINHA').AsString;

        Escrever(ProximaLinha, 01, strLinAnt + '.000 - ' + fRetNomeLinhaGrupo(strLinAnt + '000'));
        Negrito(LinhaAtual, 01, True);

        Mesclar('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
        CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Verde_Mar);
        CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
        Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, False, False);

        While (Not Eof) And (FieldByName('LINHA').AsString = strLinAnt) Do
        Begin

          strGruAnt := FieldByName('GRUPO').AsString;
          strGruMsk := LeftStr(FieldByName('GRUPO').AsString,2) + '.' + RightStr(FieldByName('GRUPO').AsString,2);

          Escrever(ProximaLinha, 01, '   ' + strGruMsk + ' - ' + fRetNomeLinhaGrupo(strGruAnt));
          Negrito(LinhaAtual, 01, True);

          Mesclar('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));
          CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Verde_Mar);
          CorFonte('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Branco);
          Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), True, True, False, False);

          While (Not Eof) And (FieldByName('GRUPO').AsString = strGruAnt) Do
          Begin

            ProximaLinha;

            For intCont := 1 To intQtdCol Do
            Begin

              If FieldByName(arrSintetico[intCont - 1, 01]).DataType = ftFloat Then
              Begin
                Escrever(LinhaAtual, intCont, FormatFloat('##,#0.00', FieldByName(arrSintetico[intCont - 1, 01]).AsFloat));
                Alinhamento(LinhaAtual, intCont, Direita);
              End
              Else
              Begin
                Escrever(LinhaAtual, intCont, '''' + FieldByName(arrSintetico[intCont - 1, 01]).AsString);
                Alinhamento(LinhaAtual, intCont, Esquerda);
              End;

            End;

            Bordas('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual));

            If LinhaAtual Mod 2 = 0 Then
              CorFundo('A' + IntToStr(LinhaAtual), strUltCol + IntToStr(LinhaAtual), Cinza);

            pSomaTotais(RecTotGru);
            pSomaTotais(RecTotGer);

            Next;
          End;

          pMontaResumo(RecTotGru,1);
          pZeraTotais(RecTotGru);

        End;

      End;

      pMontaResumo(RecTotGer,2);
      pZeraTotais(RecTotGer);

      OrientacaoPagina(Retrato);

      CongelarPaines('A10');
      AutoAjuste;
      SalvarArquivo;
      FecharArquivo;

      pnlInfo.Caption := '';

      fMensagem('ATENÇÃO','Arquivo gerado com sucesso!',['&OK']);
    End;
  End;

  FreeAndNil(objExcel);

end;

procedure TfrmRelEstMovSaldoBal.edtDestinoExit(Sender: TObject);
begin
//  inherited;
end;

end.


