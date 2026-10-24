unit untRelChqDevolvidos;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter, Uni,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  QColorLabel, Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  AppEvnts, BitBtnLockedIncrem, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, untFuncoesFactory,
  untIFuncoes, untTypesSistema, untMskC_G_C_;

type
  TfrmRelChqDevolvidos = class(TfrmPaiRelatorio)
    Label11: TLabel;
    lblDesDtaIni: TLabel;
    lblDesDtaFin: TLabel;
    Label12: TLabel;
    Label1: TLabel;
    edtCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    rdgEstado: TRadioGroup;
    gpbOpcao: TGroupBox;
    edtOpcao: TEditFocus;
    lbl1: TColorLabel;
    lbl2: TColorLabel;
    lbl3: TColorLabel;
    lbl4: TColorLabel;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    gpbTelecheque: TGroupBox;
    ColorLabel4: TColorLabel;
    edtTelecheque: TEditFocus;
    gpbIncCtr: TGroupBox;
    ColorLabel2: TColorLabel;
    edtIncCtr: TEditFocus;
    edtDesCid: TEditFocus;
    edtCodCid: TEditFocus;
    Label2: TLabel;
    rdgOrdem: TRadioGroup;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    edtValidaCnpjCpf: TEditFocus;
    lblCnpjCpf: TLabel;
    mskCnpjCpf: TMaskEditC_G_C_;
    lblEmit: TLabel;
    edtNomEmit: TEditFocus;
    lbl5: TColorLabel;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtClienteExit(Sender: TObject);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure mskDtaIniPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure mskDtaFinPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure edtOpcaoChange(Sender: TObject);

  private
    { Private declarations }
    qryRelatorio: TUniQuery;
    strNomEmi, strEndere, strTele01, strCgc: String;
    arrEmi: TConsultasArray;


		procedure pCriaQryRelatorio;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmRelChqDevolvidos: TfrmRelChqDevolvidos;

implementation

uses untQckChqDevolvidos,Data.DB, untClassPanelcx,untFuncoesGenerica;

{$R *.dfm}

procedure TfrmRelChqDevolvidos.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Date := VS_Date;
  mskDtaFin.Date := VS_Date;

  edtOpcaoChange(Self);
  inherited;
end;

procedure TfrmRelChqDevolvidos.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
begin
  inherited;

   if not fValidaCampos(self, false) then
     Exit;
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
    strSQL := strSQL + '  IFNULL(CHQ_DTADV2, CHQ_DTADEV) AS CHQ_DTADEV, '; // usado para quebra
    strSQL := strSQL + '  Q.*, ';
    strSQL := strSQL + '  IF(IFNULL(Q.CHQ_MOTDV2, "") = "", Q.CHQ_MOTDEV, Q.CHQ_MOTDV2) AS CHQ_MOTIVO, ';
    strSQL := strSQL + '  C.CLI_NOMCLI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ Q, ';
    strSQL := strSQL + '  CADCLI C  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CHQ_CODCLI = CLI_CODCLI AND ';
    strSQL := strSQL + '  CHQ_DTADEV IS NOT NULL  AND ';

    If edtOpcao.Text = '1' Then
    Begin
      strSQL := strSQL + '  CHQ_DTADEV BETWEEN :DTAINI AND :DTAFIN ';
      Case rdgEstado.ItemIndex Of
         0: Begin
              strSQL := strSQL + ' AND (CHQ_DTADP2 IS NULL AND CHQ_DEVDEF IS NULL) ';
            End;

         1: Begin
              strSQL := strSQL + ' AND (  ((CHQ_DTADP2 IS NOT NULL) AND (CHQ_DTADV2 IS NULL AND CHQ_DTADP3 IS NULL AND CHQ_DTADV3 IS NULL))  OR (CHQ_DEVDEF = 1) )';
            End;
      End;
    End
    Else If edtOpcao.Text = '2' Then
    Begin
      strSQL := strSQL + '  CHQ_DTADV2 BETWEEN :DTAINI AND :DTAFIN ';
      Case rdgEstado.ItemIndex Of
         0: Begin
              strSQL := strSQL + ' AND (CHQ_DTADP3 IS NULL AND CHQ_DEVDEF IS NULL) ';
            End;

         1: Begin
              strSQL := strSQL + ' AND (  ((CHQ_DTADP3 IS NOT NULL) AND (CHQ_DTADV3 IS NULL ))  OR (CHQ_DEVDEF = 1) )';
            End;
      End;
    End
    Else If edtOpcao.Text = '3' Then
    Begin
      strSQL := strSQL + '  ( (CHQ_DTADEV BETWEEN :DTAINI AND :DTAFIN) AND ';
      strSQL := strSQL + '    (CHQ_DTADV2 BETWEEN :DTAINI AND :DTAFIN) )   ';
      Case rdgEstado.ItemIndex Of
         0: Begin
              strSQL := strSQL + ' AND (CHQ_DTADP3 IS NULL AND CHQ_DEVDEF IS NULL) ';
            End;

         1: Begin
              strSQL := strSQL + ' AND (  ((CHQ_DTADP3 IS NOT NULL) AND (CHQ_DTADV3 IS NULL ))  OR (CHQ_DEVDEF = 1) )';
            End;
      End;
    End
    Else If edtOpcao.Text = '4' Then
    Begin
      strSQL := strSQL + '  ( ( (CHQ_DTADEV BETWEEN :DTAINI AND :DTAFIN) AND ';
      strSQL := strSQL + '      (CHQ_DTADV2 BETWEEN :DTAINI AND :DTAFIN) AND ';
      strSQL := strSQL + '      (CHQ_DTADV3 BETWEEN :DTAINI AND :DTAFIN)     ) OR  ';
      strSQL := strSQL + '    (CHQ_DEVDEF = 1)                                    )';
    End
    Else If edtOpcao.Text = '5' Then
    Begin
      strSQL := strSQL + '  ( (CHQ_DTADEV BETWEEN :DTAINI AND :DTAFIN) OR ';
      strSQL := strSQL + '    (CHQ_DTADV2 BETWEEN :DTAINI AND :DTAFIN) OR ';
      strSQL := strSQL + '    (CHQ_DTADV3 BETWEEN :DTAINI AND :DTAFIN) )  ';
    End;


    If edtIncCtr.Text = 'N' Then
      strSQL := strSQL + ' AND CHQ_INCCTR = '+QuotedStr('N')
    Else If edtIncCtr.Text = 'S' Then
      strSQL := strSQL + ' AND CHQ_INCCTR = '+QuotedStr('S');

    If Not fEmptyStr(edtCliente.Text) Then
      strSQL := strSQL + '  AND CHQ_CODCLI = :CODCLI ';

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + '  AND CHQ_CODEMP = :CODEMP '
    Else
      strSQL := strSQL + '  AND LOCATE(CHQ_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';

    {******************************}
    {* CONSULTA TELECHEQUE        *}
    {***************************RV*}
    If (edtTelecheque.Text = 'S') Then
      strSQL := strSQL + '  AND CHQ_TELCHE = '+QuotedStr('S')
    Else If (edtTelecheque.Text = 'N') Then
      strSQL := strSQL + '  AND CHQ_TELCHE = '+QuotedStr('N');

    If Not fEmptyStr(edtCodCid.Text) Then
      strSQL := strSQL + '  AND CHQ_CODCID = :CODCID ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) then
      strSQL := strSQL + '  AND CHQ_C_G_C_ = :CADEMI_C_G_C_  ';

    strSQL := strSQL + ' ORDER BY ';

    If rdgOrdem.ItemIndex = 0 Then
      strSQL := strSQL + '  IFNULL(CHQ_DTADV2, CHQ_DTADEV), ';

    strSQL := strSQL + '  CHQ_NOMEMI, CHQ_CODBCO, CHQ_NUMAGE, CHQ_CONCOR, CHQ_NUMCHQ ';

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate := mskDtaIni.Date;
      ParamByName('DTAFIN').AsDate := mskDtaFin.Date;

      If Not fEmptyStr(edtCliente.Text) Then
        ParamByName('CODCLI').AsString := edtCliente.Text;

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

      If Not fEmptyStr(edtCodCid.Text) Then
        ParamByName('CODCID').AsString := edtCodCid.Text;

       If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) then
        pSetaParam(mskCnpjCpf.Text, arrEmi, strCgc, 'CADEMI_C_G_C_', qryRelatorio);

      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmQckChqDevolvidos,frmQckChqDevolvidos);

        frmQckChqDevolvidos.dtsRelatorio.DataSet := qryRelatorio;

        If strTipImp = 'M' Then
          frmQckChqDevolvidos.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckChqDevolvidos.qckPagina.DefaultFilter := Nil;

        frmQckChqDevolvidos.rllNomeRelatorio.Caption := 'RELATORIO DE CHEQUES DEVOLVIDOS POR PERIODO';

        If edtCliente.Text = '' Then
          frmQckChqDevolvidos.rllCliente.Caption := 'CLIENTE: TODOS'
        Else
          frmQckChqDevolvidos.rllCliente.Caption := 'CLIENTE: ' + edtDesCliente.Text;

        If fEmptyStr(edtCodEmpresa.Text) Then
          frmQckChqDevolvidos.rllEmpresa.Caption := 'EMPRESA: TODAS '
        Else
          frmQckChqDevolvidos.rllEmpresa.Caption := 'EMPRESA: ' + edtCodEmpresa.Text + ' - ' + edtDesEmpresa.Text;

        If fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) then
          frmQckChqDevolvidos.rllCgc.Caption := 'EMITENTE: TODOS'
        Else
          frmQckChqDevolvidos.rllCgc.Caption := 'EMITENTE: '+edtNomEmit.Text;
        If fEmptyStr(edtCodCid.Text) Then
        Begin
          If strTipImp = 'M' Then
            frmQckChqDevolvidos.rllCodCid.Caption := 'PRACA: TODAS'
          Else
            frmQckChqDevolvidos.rllCodCid.Caption := 'PRAÇA: TODAS';
        End
        Else
        Begin
          If strTipImp = 'M' Then
            frmQckChqDevolvidos.rllCodCid.Caption := 'PRACA: ' + edtCodCid.Text + ' - ' + edtDesCid.Text
          Else
            frmQckChqDevolvidos.rllCodCid.Caption := 'PRAÇA: ' + edtCodCid.Text + ' - ' + edtDesCid.Text;
        End;

        {*****************************************************}
        {* MOSTRA NO CABECALHO DO RELATORIO O TIPO DE CHEQUE *}
        {**************************************************JB*}
        frmQckChqDevolvidos.rllCheques.Caption   := Concat('CHEQUES: ',  UpperCase(rdgEstado.Items.Strings[rdgEstado.ItemIndex]));

        If edtOpcao.Text = '1' Then
        Begin
          frmQckChqDevolvidos.rllDevolucao.Caption := 'CONSIDERAR APENAS PRIMEIRA DEVOLUÇÃO NO PERÍODO';
        End
        Else If edtOpcao.Text = '2' Then
        Begin
          frmQckChqDevolvidos.rllDevolucao.Caption := 'CONSIDERAR APENAS SEGUNDA DEVOLUÇÃO NO PERÍODO';
        End
        Else If edtOpcao.Text = '3' Then
        Begin
          frmQckChqDevolvidos.rllDevolucao.Caption := 'CONSIDERAR PRIMEIRA E SEGUNDA DEVOLUÇÕES NO PERÍODO';
        End
        Else If edtOpcao.Text = '4' Then
        Begin
          frmQckChqDevolvidos.rllDevolucao.Caption := 'CONSIDERAR PRIMEIRA OU SEGUNDA DEVOLUÇÕES NO PERÍODO';
        End;

        frmQckChqDevolvidos.strOrdem := 'REFERENTE AO PERIODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text;

        If rdgOrdem.ItemIndex = 1 Then
        Begin
          frmQckChqDevolvidos.rlbGrupo.Visible := False;
          frmQckChqDevolvidos.rlbDetalhe.Visible := True;
          frmQckChqDevolvidos.rllTotGer.Caption := 'Total Geral:';
        End;

        If edtDestino.Text = 'V' Then
          frmQckChqDevolvidos.qckPagina.PreviewModal
        Else
          frmQckChqDevolvidos.qckPagina.Print;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckChqDevolvidos);
    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;
  btnImprimir.Enabled := True;
  pSetFocus(edtCliente);
end;

function TfrmRelChqDevolvidos.fValidaCampos(Sender: TWinControl;
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
          fMensagem('', 'A Data Final de devolução informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End
        Else
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        Begin
          fMensagem('', 'O campo Data Final de devolução deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            fMensagem('', 'O campo Data Inicial de devolução deve ser preenchido!', ['&Ok']);
            Result := False;
            Sender := mskDtaIni;
          End
          Else
          Begin
            If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
            Begin
              If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
              Begin
                fMensagem('','A data Inicial de devolução deve ser menor que a data final!',['&O K']);
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
        fMensagem('', 'A Data Inicial de devolução informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
      End;
    End
    Else If (Sender = edtOpcao) Then
    Begin

      If fEmptyStr(edtOpcao.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo considerar apenas deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If (Pos(edtOpcao.Text, '12345') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!','O campo considerar apenas deve ser 1, 2, 3, 4 ou 5!',['&O K']);
          Result := False;
        End;
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
    End

    Else If (Sender = edtTelecheque) Then
    Begin
      If fEmptyStr(edtTelecheque.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo telecheque deve ser preenchido!',['&O K']);
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

    Else If (Sender = edtIncCtr) Then
    Begin
     If fEmptyStr(edtIncCtr.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo inc pelo Contas a Receber deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If Pos(edtIncCtr.Text,'SNT') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!','O campo inc pelo Contas a Receber deve ser S, N ou T!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtDestino) Then
    Begin
      If fEmptyStr(edtDestino.Text) Then
      Begin
        fMensagem('ATENÇÃO!','O campo destino deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If Pos(edtDestino.Text, 'VI') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo destino deve ser V ou I!', ['&O K']);
        Result := False;
      End;
    End

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
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelChqDevolvidos.mskDtaFinPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If Error Then
    pMensagemOk('Data Invalida');

end;

procedure TfrmRelChqDevolvidos.mskDtaIniPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If Error Then
    pMensagemOk('Data Invalida');

end;

procedure TfrmRelChqDevolvidos.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelChqDevolvidos.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCliente);
end;

procedure TfrmRelChqDevolvidos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelChqDevolvidos.edtClienteExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCliente.Text) Then
    edtDesCliente.Text := 'TODOS '
  Else
    edtDesCliente.Text := fRetNomCliente(edtCliente.Text);


  If fEmptyStr(edtDesCliente.Text) And (Not fEmptyStr(edtCliente.Text)) Then
  Begin
    fMensagem('AVISO','Código do cliente não encontrado.', ['&O K']);
    edtCliente.Clear;
    pSetFocus(edtCliente);
  End;

end;

procedure TfrmRelChqDevolvidos.edtClienteKeyPress(Sender: TObject;
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

procedure TfrmRelChqDevolvidos.edtCodCidExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodCid.Text) Then
    edtDesCid.Text := 'TODAS '
  Else
    edtDesCid.Text := fRetNomCidade(edtCodCid.Text);


  If fEmptyStr(edtDesCid.Text) And (Not fEmptyStr(edtCodCid.Text)) Then
  Begin
    fMensagem('AVISO','Código da cidade não encontrado.', ['&O K']);
    edtCodCid.Clear;
    pSetFocus(edtCodCid);
  End;

end;

procedure TfrmRelChqDevolvidos.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;

  If fPesqCidade(Self, edtCodCid, edtDesCid, Nil, Nil, Key, arrCidade) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelChqDevolvidos.edtCodEmpresaExit(Sender: TObject);
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

procedure TfrmRelChqDevolvidos.edtCodEmpresaKeyPress(Sender: TObject;
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

procedure TfrmRelChqDevolvidos.edtOpcaoChange(Sender: TObject);
  procedure pMarcaTodos;
  begin
    TRadioButton(rdgEstado.Controls[0]).Enabled := True;
    TRadioButton(rdgEstado.Controls[1]).Enabled := True;
    TRadioButton(rdgEstado.Controls[2]).Enabled := True;
  end;
  function fValidaOpcao:Boolean;
  begin
    Result := (StrToInt(edtOpcao.Text) >= 0) AND (StrToInt(edtOpcao.Text) <= 5);
  end;
begin
  inherited;
  if not fValidaOpcao then
  begin
    fMensagem('Atenção','São aceitos apenas valores entre 1 e 5',['&OK']);
    Exit;
  end;
  pMarcaTodos;
  case StrToInt(edtOpcao.Text) of
    4 : begin
          rdgEstado.itemIndex                         := 1;
          TRadioButton(rdgEstado.Controls[0]).Enabled := False;
          TRadioButton(rdgEstado.Controls[2]).Enabled := False;
        end;
    5 : begin
          rdgEstado.itemIndex                         := 2;
          TRadioButton(rdgEstado.Controls[0]).Enabled := False;
          TRadioButton(rdgEstado.Controls[1]).Enabled := False;
        end;
  end;
end;

end.

