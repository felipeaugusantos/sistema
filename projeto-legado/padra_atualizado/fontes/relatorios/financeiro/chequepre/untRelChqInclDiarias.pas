unit untRelChqInclDiarias;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter, Uni,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils, untTypesSistema,
  QColorLabel, Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  AppEvnts, BitBtnLockedIncrem, untFuncoesFactory, frxExportCSVTestabilidade,
  untIFuncoes, untMskC_G_C_;

type
  TfrmRelChqInclDiarias = class(TfrmPaiRelatorio)
    GroupBox1: TGroupBox;
    edtQuebra: TEditFocus;
    Label9: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    ColorLabel2: TColorLabel;
    Label1: TLabel;
    edtCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    ColorLabel3: TColorLabel;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbTelecheque: TGroupBox;
    ColorLabel4: TColorLabel;
    edtTelecheque: TEditFocus;
    chkVisPra: TCheckBox;
    edtValidaCnpjCpf: TEditFocus;
    lblCnpjCpf: TLabel;
    mskCnpjCpf: TMaskEditC_G_C_;
    lblEmit: TLabel;
    edtNomEmit: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtClienteExit(Sender: TObject);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure chkVisPraClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    arrClientes,
    arrEmp,
    arrEmi     : TConsultasArray;

    strClientes: String;
    strEmp     : String;
    strNomEmi, strEndere, strTele01, strCgc: String;

    qryRelatorio: TUniQuery;

		procedure pCriaQryRelatorio;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelChqInclDiarias: TfrmRelChqInclDiarias;

implementation

uses untQckChqInclDiarias, Data.DB, untClassPanelcx, untFuncoesGenerica;

{$R *.dfm}

procedure TfrmRelChqInclDiarias.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;
  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  inherited;

  shpMultSel.Visible := True;
end;

procedure TfrmRelChqInclDiarias.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    strOrdena: String;
begin
  inherited;


  {***********************************}
  {* VERIFICACAO DAS DATAS           *}
  {********************************LE*}

  If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) and fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)))  then
  Begin
    fMensagem('', 'Uma data deve ser selecionada!', ['&OK']);
    Exit;
  End;

  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  IF(CHQ_DTACAD = CHQ_DTAVEN, "A VISTA ", "A PRAZO") AS CHQ_VISPRA, ';
    strSQL := strSQL + '  Q.AUTOINCREM, ';
    strSQL := strSQL + '  Q.CHQ_CODEMP, ';
    strSQL := strSQL + '  Q.CHQ_VALCHQ, ';
    strSQL := strSQL + '  Q.CHQ_CODBCO, ';
    strSQL := strSQL + '  Q.CHQ_NUMAGE, ';
    strSQL := strSQL + '  Q.CHQ_CONCOR, ';
    strSQL := strSQL + '  Q.CHQ_CODCLI, ';
    strSQL := strSQL + '  Q.CHQ_NUMCHQ, ';
    strSQL := strSQL + '  Q.CHQ_DOCUME, ';
    strSQL := strSQL + '  Q.CHQ_NOMEMI, ';
    strSQL := strSQL + '  Q.CHQ_TELEMI, ';
    strSQL := strSQL + '  Q.CHQ_DTAVEN, ';
    strSQL := strSQL + '  Q.CHQ_DTACAD, ';
    strSQL := strSQL + '  Q.CHQ_TELNUM, ';
    strSQL := strSQL + '  C.CLI_CODCLI, ';
    strSQL := strSQL + '  C.CLI_NOMCLI,  ';
    strSQL := strSQL + '  Q.CHQ_C_G_C_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ Q, ';
    strSQL := strSQL + '  CADCLI C ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_CODCLI = CLI_CODCLI AND ';
    strSQL := strSQL + '  CHQ_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

    If Not fEmptyStr(edtCliente.Text) Then
      strSQL := strSQL + fStrLocate(edtCliente, arrClientes, 'CHQ_CODCLI', 'CODCLI');

    If (Not fEmptyStr(edtCodEmpresa.Text)) Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmp, 'CHQ_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + '  AND LOCATE(CHQ_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) Then
      strSQL := strSQL + ' AND Q.CHQ_C_G_C_ = :CADEMI_C_G_C_ ';

    {******************************}
    {* CONSULTA TELECHEQUE        *}
    {***************************RV*}
    If (edtTelecheque.Text = 'S') Then
      strSQL := strSQL + '  AND CHQ_TELCHE = '+QuotedStr('S')
    Else If (edtTelecheque.Text = 'N') Then
      strSQL := strSQL + '  AND CHQ_TELCHE = '+QuotedStr('N');

    strSQL := strSQL + ' ORDER BY ';
    If (edtQuebra.Text = '1') Then
    Begin
      If chkVisPra.Checked Then
        strSQL := strSQL + '  CHQ_VISPRA, CHQ_DTACAD, CHQ_DTAVEN, CHQ_NUMCHQ '
      Else
        strSQL := strSQL + '  CHQ_DTACAD, CHQ_DTAVEN, CHQ_NUMCHQ ';
    End
    Else If (edtQuebra.Text = '2') Then
    Begin
      If chkVisPra.Checked Then
        strSQL := strSQL + '  CHQ_VISPRA, CHQ_DTAVEN, CHQ_NUMCHQ '
      Else
        strSQL := strSQL + '  CHQ_DTAVEN, CHQ_NUMCHQ ';
    End
    Else If (edtQuebra.Text = '3') Then
    Begin
      If chkVisPra.Checked Then
        strSQL := strSQL + '  CHQ_VISPRA, CLI_CODCLI, CHQ_DTAVEN, CHQ_NUMCHQ '
      Else
        strSQL := strSQL + '  CLI_CODCLI, CHQ_DTAVEN, CHQ_NUMCHQ ';
    End
    Else If (edtQuebra.Text = '4') Then
    Begin
      If chkVisPra.Checked Then
        strSQL := strSQL + '  CHQ_VISPRA, CLI_NOMCLI, CHQ_DTAVEN, CHQ_NUMCHQ '
      Else
        strSQL := strSQL + '  CLI_NOMCLI, CHQ_DTAVEN, CHQ_NUMCHQ ';
    End
    Else If (edtQuebra.Text = '5') Then
    Begin
      If chkVisPra.Checked Then
        strSQL := strSQL + '  CHQ_VISPRA, CHQ_NUMCHQ '
      Else
        strSQL := strSQL + '  CHQ_NUMCHQ ';
    End
    Else
    Begin
      strSQL := strSQL + '  AUTOINCREM ';
    End;

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(edtCliente.Text) Then
        pSetaParam(edtCliente.Text, arrClientes, strClientes, 'CODCLI', qryRelatorio);

      If (Not fEmptyStr(edtCodEmpresa.Text)) Then
        pSetaParam(edtCodEmpresa.Text, arrEmp, strEmp, 'CODEMP', qryRelatorio);

      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

      If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) Then
        pSetaParam(mskCnpjCpf.Text, arrEmi, strCgc, 'CADEMI_C_G_C_', qryRelatorio);

      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmQckChqInclDiarias,frmQckChqInclDiarias);

        frmQckChqInclDiarias.dtsRelatorio.DataSet := qryRelatorio;

        frmQckChqInclDiarias.rllNomeRelatorio.Caption := 'RELATORIO DE INCLUSOES DIARIAS DE CHEQUES ';

        If (strTipImp = 'M') Then
          frmQckChqInclDiarias.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckChqInclDiarias.qckPagina.DefaultFilter := Nil;

        If chkVisPra.Checked Then
        Begin
          frmQckChqInclDiarias.rlbTitulo.Visible         := True;
          frmQckChqInclDiarias.rlbGrupoCheque.Visible    := True;
          frmQckChqInclDiarias.rlbGrupoCheque.DataFields := 'CHQ_VISPRA';
        End
        Else If (edtQuebra.Text = '1') Then
        Begin
          frmQckChqInclDiarias.rlbTitulo.Visible    := True;
          frmQckChqInclDiarias.rlbGrupo.Visible     := True;
          frmQckChqInclDiarias.rlbGrupo.DataFields  := 'CHQ_DTACAD';
          frmQckChqInclDiarias.lblDataCampo.Caption := 'DTA VEN';
          frmQckChqInclDiarias.rdbDtaVen.DataField  := 'CHQ_DTAVEN';
          frmQckChqInclDiarias.strCampo             := 'CHQ_DTACAD';
        End
        Else If (edtQuebra.Text = '2') Then
        Begin
          frmQckChqInclDiarias.rlbTitulo.Visible     := True;
          frmQckChqInclDiarias.rlbGrupo.Visible      := True;
          frmQckChqInclDiarias.rlbGrupo.DataFields   := 'CHQ_DTAVEN';
          frmQckChqInclDiarias.lblDataCampo.Caption  := 'DTA CAD';
          frmQckChqInclDiarias.rdbDtaVen.DataField   := 'CHQ_DTACAD';
          frmQckChqInclDiarias.strCampo              := 'CHQ_DTAVEN';
        End
        Else If (edtQuebra.Text = '3') Then
        Begin
          frmQckChqInclDiarias.rlbTitCliente.Visible  := True;
          frmQckChqInclDiarias.rlbGrupoCli.Visible    := True;
          frmQckChqInclDiarias.rlbGrupoCli.DataFields := 'CLI_CODCLI';
          frmQckChqInclDiarias.strCampo               := 'CHQ_DTAVEN';
        End
        Else If (edtQuebra.Text = '4') Then
        Begin
          frmQckChqInclDiarias.rlbTitCliente.Visible  := True;
          frmQckChqInclDiarias.rlbGrupoCli.Visible    := True;
          frmQckChqInclDiarias.rlbGrupoCli.DataFields := 'CLI_NOMCLI';
          frmQckChqInclDiarias.strCampo               := 'CHQ_DTAVEN';
        End
        Else If Pos(edtQuebra.Text, '56') > 0 Then
        Begin
          frmQckChqInclDiarias.rlbTitulo.Visible  := True;
          frmQckChqInclDiarias.rlbDetalhe.Visible := True;
          frmQckChqInclDiarias.strCampo           := 'CHQ_DTAVEN';
        End;

        If (edtCliente.Text = '') Then
          frmQckChqInclDiarias.rllCliente.Caption := 'CLIENTE: TODOS'
        Else
          frmQckChqInclDiarias.rllCliente.Caption := fStrTitulo(edtCliente.Text, edtDesCliente, arrClientes, strClientes, 'CLIENTE');

        If edtCodEmpresa.Text = '' Then
          frmQckChqInclDiarias.rllEmpresa.Caption := 'EMPRESA: TODAS'
        Else
          frmQckChqInclDiarias.rllEmpresa.Caption := fStrTitulo(edtCodEmpresa.Text, edtDesCliente, arrEmp, strEmp, 'EMPRESA');

        If fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) Then
          frmQckChqInclDiarias.rllCgc.Caption := 'EMITENTE: TODOS'
        Else
          frmQckChqInclDiarias.rllCgc.Caption := 'EMITENTE: '+ edtNomEmit.Text;

        Case StrToInt(edtQuebra.Text) of
          1: strOrdena := 'CADASTRO';
          2: strOrdena := 'VENCIMENTO';
          3: strOrdena := 'CÓDIGO CLIENTE';
          4: strOrdena := 'NOME CLIENTE';
          5: strOrdena := 'NUM. CHEQUE';
          6: strOrdena := 'LANÇAMENTO';
        End;

        frmQckChqInclDiarias.rllOrdena.Caption := 'ORDENADO POR: ' + strOrdena;
        frmQckChqInclDiarias.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

        If (edtDestino.Text = 'V') Then
          frmQckChqInclDiarias.qckPagina.PreviewModal
        Else
          frmQckChqInclDiarias.qckPagina.Print;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckChqInclDiarias);
    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;
  btnImprimir.Enabled := True;
  pSetFocus(mskDtaIni);
end;

function TfrmRelChqInclDiarias.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LE*}

      If (Sender = mskDtaFin) then
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (StrToDateDef(mskDtaFin.Text,0) <= 0) then
        Begin
          fMensagem('', 'A Data Final de cadastro informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End
        Else
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        Begin
          fMensagem('', 'O campo Data Final de cadastro deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            fMensagem('', 'O campo Data Inicial de cadastro deve ser preenchido!', ['&Ok']);
            Result := False;
            Sender := mskDtaIni;
          End
          Else
          Begin
            If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
            Begin
              If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
              Begin
                fMensagem('','A data Inicial de cadastro deve ser menor que a data final!',['&O K']);
                Result := False;
                Sender := mskDtaIni;
            End;
          End;
        End;
      End;
    End

    Else  If (Sender = mskDtaIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial de cadastro informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
      End;
    End

    {*******************}
    {* VERIFICA QUEBRA *}
    {****************AF*}
    Else If (Sender = edtQuebra) Then
    Begin
      If edtQuebra.Text = '' Then
      Begin

        fMensagem('ATENÇÃO!','O campo quebra deve ser preenchido!',['&O K']);
        Result := False;

      End
      Else
      Begin

        If (Pos(edtQuebra.Text, '123456') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!','O campo quebra deve ser 1, 2, 3, 4, 5 ou 6!',['&O K']);
          Result := False;
        End;

      End;
    End

    Else If (Sender = edtCodEmpresa) Then
    Begin

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        pDesmarcaLista(edtCodEmpresa, arrEmp)
      Else
        edtDesEmpresa.Text := 'TODOS';

    End

    Else If (Sender = edtTelecheque) Then
    Begin
      If fEmptyStr(edtTeleCheque.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo telecheque deve ser preechindo!',['&O K']);
        Result := False;
      End
      Else
      If (edtTelecheque.Text <> 'S') And
         (edtTelecheque.Text <> 'N') And
         (edtTelecheque.Text <> 'T') Then
      Begin
        fMensagem('ATENÇÃO!','O campo telecheque deve ser S, N ou T!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCliente) Then
    Begin

      If fEmptyStr(edtCliente.Text) Then
        edtDesCliente.Text := 'TODOS';

    End

    Else If (Sender = chkVisPra) Then
      edtQuebra.Enabled := (Not chkVisPra.Checked)

      {***********************************}
    {*  RETORNA NOME POR  CPF OU CNPJ  *}
    {********************************LE*}
    Else if (Sender = edtValidaCnpjCpf) Then
    Begin
      If edtValidaCnpjCpf.Text = '' Then
      Begin
        mskCnpjCpf.EditMask := '';
        mskCnpjCPf.Text := '';
        edtNomEmit.Text := 'TODOS';
        mskCnpjCpf.Enabled := False;
      End
      Else Begin
        If Pos(edtValidaCnpjCPf.Text,'1_2') <= 0  Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo CNPJ/CPF deve ser 1 ou 2!', ['&OK']);
          Result := False;
        End
        Else Begin
          mskCnpjCpf.Enabled := True;
          If edtValidaCnpjCPf.Text = '1'  Then
            mskCnpjCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
          Else
            mskCnpjCPf.EditMask := fRetMascaraC_G_C_(fSetaPais,C_P_F_);
        End;
      End;
    End

    Else if (Sender = mskCnpjCpf) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) Then
      Begin
        strCgc := fTiraCaracEspeciais(mskCnpjCpf.Text);
        If (Length(strCgc) < 14) AND (edtValidaCnpjCpf.Text = '1') OR   (Length(strCgc) < 11) OR
         (Length(strCgc) > 11) AND (edtValidaCnpjCpf.Text = '2') Then
        Begin
          fMensagem('ATENÇÃO', mskCnpjCpf.Text + ' não é um número de '+IfThen(edtValidaCnpjCpf.Text ='1','CNPJ','CPF')+' válido!', ['&Ok']);
          edtNomEmit.Text := 'TODOS';
          Result := False;
        End
        Else  Begin
        fRetDadosEmitente(mskCnpjCPf.Text, strNomEmi, strEndere, strTele01);
        If strNomEmi = '' Then
          edtNomEmit.Text := 'NÃO CADASTRADO'
        Else
         edtNomEmit.Text := strNomEmi;
        End;
      End
      Else Begin
        edtNomEmit.Text := 'TODOS';
        mskCnpjCpf.Enabled := False;
        mskCnpjCpf.EditMask := '';
        mskCnpjCPf.Text := '';
        edtValidaCnpjCpf.Text := '';
      End;
    End;

    {***********************************}
    {*  VALIDAÇÃO DESTINO              *}
    {********************************LE*}

    If (Sender = edtDestino) Then
    Begin
      If fEmptyStr( edtDestino.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo destino deve ser preechindo!',['&O K']);
        Result := False;
      End
      Else
      If (edtDestino.Text <> 'V') And
         (edtDestino.Text <> 'I') Then
      Begin
        fMensagem('ATENÇÃO!','O campo destino deve ser V ou I!',['&O K']);
        Result := False;
      End;
    End
End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelChqInclDiarias.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelChqInclDiarias.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelChqInclDiarias.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelChqInclDiarias.chkVisPraClick(Sender: TObject);
begin
  inherited;
  edtQuebra.Enabled := (Not chkVisPra.Checked);
end;

procedure TfrmRelChqInclDiarias.edtClienteExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCliente, edtDesCliente, arrClientes, Nil, fRetNomCliente, 'do cliente');

end;

procedure TfrmRelChqInclDiarias.edtClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCliente, edtDesCliente, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelChqInclDiarias.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');

end;

procedure TfrmRelChqInclDiarias.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp, False) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.

