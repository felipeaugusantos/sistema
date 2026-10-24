unit untRelChqRepassados;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter, Uni,
  EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils, untTypesSistema,
  QColorLabel, Menus, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  AppEvnts, BitBtnLockedIncrem, frxExportCSVTestabilidade, untMskC_G_C_;

type
  TfrmRelChqRepassados = class(TfrmPaiRelatorio)
    gpbOrdem: TGroupBox;
    ColorLabel2: TColorLabel;
    edtOrdem: TEditFocus;
    Label12: TLabel;
    mskDtaIni: TMaskEditFocus;
    lblDesDtaIni: TLabel;
    Label9: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblDesDtaFin: TLabel;
    Label10: TLabel;
    edtCodFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    Label1: TLabel;
    edtCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label2: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label13: TLabel;
    Label14: TLabel;
    edtNomEmit: TEditFocus;
    edtValidaCnpjCpf: TEditFocus;
    mskCnpjCpf: TMaskEditC_G_C_;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCodFornecedorExit(Sender: TObject);
    procedure edtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtClienteExit(Sender: TObject);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryRelatorio: TUniQuery;
    strNomEmi, strEndere, strTele01,  strCgc: String;
    blnBaixaChequesRepasse : Boolean;
		procedure pCriaQryRelatorio;
    function fFiltroCheques(strNomTab: String): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
    arrCheques : TStringArray;
  end;

var
  frmRelChqRepassados: TfrmRelChqRepassados;

implementation

uses untfuncoesFactory, untQckChqRepassados, untIFuncoes, Data.DB, untClassPanelcx, untFuncoesGenerica;

{$R *.dfm}

procedure TfrmRelChqRepassados.FormShow(Sender: TObject);
begin
  pCriaQryRelatorio;
  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;
  inherited;

  blnBaixaChequesRepasse := (Length(arrCheques) > 0) And (Pos('CADCHQ', arrCheques[0]) > 0);

  If (blnBaixaChequesRepasse) Then
  Begin
    edtOrdem.Text := 'V';
    edtOrdem.Enabled := False;
    edtCodEmpresa.Text := '';
    edtDesEmpresa.Text := '';
    edtCodEmpresa.Enabled := False;

    mskDtaIni.Clear;
    mskDtaFin.Clear;
    mskDtaIni.Enabled := False;
    mskDtaFin.Enabled := False;

    edtCodFornecedor.Enabled := False;
    edtCliente.Enabled := False;
    edtCodPor.Enabled := False;

    edtValidaCnpjCpf.Text := '';
    mskCnpjCpf.Clear;
    edtNomEmit.Text := 'TODOS';
  End;
end;

procedure TfrmRelChqRepassados.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
begin
  inherited;

  {***********************************}
  {* VERIFICACAO DAS DATAS           *}
  {********************************LE*}

  If (Not blnBaixaChequesRepasse) And
     (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)))  then
  Begin
    fMensagem('', 'Uma data deve ser selecionada!', ['&OK']);
    Exit;
  End;

  If blnImprime Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  Q.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  F.FOR_NOMFOR ';

    strSQL := strSQL + '  FROM CADCHQ Q ';
    strSQL := strSQL + ' INNER JOIN CADCLI C ON CHQ_CODCLI = CLI_CODCLI ';
    strSQL := strSQL + IfThen(blnBaixaChequesRepasse, 'LEFT', 'INNER') + ' JOIN CADFOR F ON CHQ_FORREP = FOR_CODFOR ';
    strSQL := strSQL + ' WHERE TRUE ';

    If (Not blnBaixaChequesRepasse) Then
    Begin
      strSQL := strSQL + '   AND CHQ_DTAREP BETWEEN :DTAINI AND :DTAFIN ';

      If Not fEmptyStr(edtCodFornecedor.Text) Then
        strSQL := strSQL + '  AND CHQ_FORREP = :FORREP ';

      If Not fEmptyStr(edtCliente.Text) Then
        strSQL := strSQL + '  AND CHQ_CODCLI = :CODCLI ';

      If Not fEmptyStr(edtCodPor.Text) Then
        strSQL := strSQL + '  AND CHQ_CODPOR = :CODPOR '
      Else If fCfgSis('DACPOR', varBoolean) Then
      Begin
        strSQL := strSQL + '  AND (IFNULL(CHQ_CODPOR, "") = "" ';
        strSQL := strSQL + '  OR LOCATE(CHQ_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
        strSQL := strSQL + '  AND (IFNULL(CHQ_PORCUS, "") = "" ';
        strSQL := strSQL + '  OR LOCATE(CHQ_PORCUS, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
        strSQL := strSQL + '  AND (IFNULL(CHQ_PORDEB, "") = "" ';
        strSQL := strSQL + '  OR LOCATE(CHQ_PORDEB, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
        strSQL := strSQL + '  AND (IFNULL(CHQ_PORCHQ, "") = "" ';
        strSQL := strSQL + '  OR LOCATE(CHQ_PORCHQ, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      End;

      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + '  AND Q.CHQ_CODEMP = :CODEMP '
      Else
        strSQL := strSQL + '  AND LOCATE(Q.CHQ_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';


      If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) Then
        strSQL := strSQL + ' AND CHQ_C_G_C_ = :CADEMI_C_G_C_';
    End
    Else
    Begin
      strSQL := strSQL + ' < FILTRO CADCHQ > ';
    End;

    strSQL := strSQL + ' ORDER BY ';

    If edtOrdem.Text = 'R' Then
      strSQL := strSQL + '  CHQ_DTAREP '
    Else
      strSQL := strSQL + '  CHQ_DTAVEN ';

    If (blnBaixaChequesRepasse) Then
    Begin
      strSQL := AnsiReplaceStr(strSQL, '< FILTRO CADCHQ >', fFiltroCheques('CADCHQ'));
    End;

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (Not blnBaixaChequesRepasse) Then
      Begin
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

        If Not fEmptyStr(edtCodFornecedor.Text) Then
          ParamByName('FORREP').AsString := edtCodFornecedor.Text;

        If Not fEmptyStr(edtCliente.Text) Then
          ParamByName('CODCLI').AsString := edtCliente.Text;

        If Not fEmptyStr(edtCodPor.Text) Then
          ParamByName('CODPOR').AsString := edtCodPor.Text;

        If Not fEmptyStr(edtCodEmpresa.Text) Then
          ParamByName('CODEMP').AsString := edtCodEmpresa.Text;

        If Not fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) Then
          ParamByName('CADEMI_C_G_C_').AsString := fTiraCaracEspeciais(mskCnpjCpf.Text);
      End;

      Open;
    End;

    If Not qryRelatorio.IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmQckChqRepassados,frmQckChqRepassados);

        frmQckChqRepassados.rllMensag.Visible := blnBaixaChequesRepasse;

        If Not frmQckChqRepassados.rllMensag.Visible Then
        Begin
          frmQckChqRepassados.rllNomeForm.Top := 1;
          frmQckChqRepassados.RLPanel1.Top := 1;
          frmQckChqRepassados.rlbResumo.Height :=
            frmQckChqRepassados.rlbResumo.Height - frmQckChqRepassados.rllMensag.Height;
        End;

        frmQckChqRepassados.dtsRelatorio.DataSet := qryRelatorio;

        frmQckChqRepassados.rllNomeRelatorio.Caption := 'RELATÓRIO DE CHEQUES REPASSADOS';

        If strTipImp = 'M' Then
          frmQckChqRepassados.qckPagina.DefaultFilter := rldFiltro
        Else
          frmQckChqRepassados.qckPagina.DefaultFilter := Nil;

        If (Not blnBaixaChequesRepasse) Then
          frmQckChqRepassados.strOrdem := 'REFERENTE AO PERÍODO DE ' + mskDtaIni.Text + ' A ' + mskDtaFin.Text
        Else
          frmQckChqRepassados.strOrdem := 'REFERENTE A SELEÇÃO EFETUADA NA TELA "SELEÇÃO DE CHEQUES PARA REPASSE"';

        If edtCodFornecedor.Text = '' Then
          frmQckChqRepassados.rllFornecedor.Caption := 'FORNECEDOR: TODOS'
        Else
          frmQckChqRepassados.rllFornecedor.Caption := 'FORNECEDOR: ' + edtDesFornecedor.Text;

        If edtCliente.Text = '' Then
          frmQckChqRepassados.rllCliente.Caption := 'CLIENTE: TODOS'
        Else
          frmQckChqRepassados.rllCliente.Caption := 'CLIENTE: ' + edtDesCliente.Text;

        If fEmptyStr(edtCodPor.Text) Then
          frmQckChqRepassados.rllPortador.Caption := 'PORTADOR: TODOS'
        Else
          frmQckChqRepassados.rllPortador.Caption := 'PORTADOR: ' + edtDesPor.Text;

        If fEmptyStr(edtCodEmpresa.Text) Then
          frmQckChqRepassados.rllCodEmpresa.Caption := 'EMPRESA: TODAS'
        Else
          frmQckChqRepassados.rllCodEmpresa.Caption := 'EMPRESA: ' + edtCodEmpresa.Text + ' - ' + edtDesEmpresa.Text;

        If fEmptyStr(fTiraCaracEspeciais(mskCnpjCpf.Text)) Then
          frmQckChqRepassados.rllCgc.Caption := 'EMITENTE: TODOS'
        Else
          frmQckChqRepassados.rllCgc.Caption := 'EMIENTE: ' + edtNomEmit.Text;

        If edtOrdem.Text = 'R' Then
        Begin
          frmQckChqRepassados.rllOrdenacao.Caption  := 'ORDEM: REPASSE';
          frmQckChqRepassados.blnVencimento         := False;
          frmQckChqRepassados.rlbGrupo.DataFields   := 'CHQ_DTAREP';
        End
        Else
        Begin
          frmQckChqRepassados.rllOrdenacao.Caption  := 'ORDEM: VENCIMENTO';
          frmQckChqRepassados.blnVencimento         := True;
          frmQckChqRepassados.rlbGrupo.DataFields   := 'CHQ_DTAVEN';
        End;

        // QUANDO O RELATORIO FOR CHAMADO PELA TELA DE
        // REPASSE DE CHEQUES, OCULTAR AS COLUNAS
        // FORN. REPASSE, HISTORICO E DTA REP
        // REQ 58581
        // FA
        if blnBaixaChequesRepasse then
        begin
          with frmQckChqRepassados do
          begin
            rlLabel3.Visible := False;
            rlLabel9.Visible := False;
            rlLabel7.Visible := False;
            RLDBText5.Width  := 250;
          end;
        end;

        If edtDestino.Text = 'V' Then
          frmQckChqRepassados.qckPagina.PreviewModal
        Else
          frmQckChqRepassados.qckPagina.Print;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;
      End;
      pFreeAndNil(frmQckChqRepassados);
    End
    Else
    Begin
      pTabelaVazia;
    End;
  End;
  btnImprimir.Enabled := True;
  pSetFocus(edtOrdem);
end;

procedure TfrmRelChqRepassados.edtCodEmpresaExit(Sender: TObject);
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

procedure TfrmRelChqRepassados.edtCodEmpresaKeyPress(Sender: TObject;
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

procedure TfrmRelChqRepassados.edtCodFornecedorExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
    edtDesFornecedor.Text := fRetNomFornecedor(edtCodFornecedor.Text);

  If fEmptyStr(edtDesFornecedor.Text) And (Not fEmptyStr(edtCodFornecedor.Text))  Then
  Begin
    fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
    edtCodFornecedor.Clear;
    pSetFocus(edtCodFornecedor);
  End;
end;

procedure TfrmRelChqRepassados.edtCodFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelChqRepassados.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LE*}

      If (Sender = mskDtaFin) And (mskDtaFin.Enabled) then
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (StrToDateDef(mskDtaFin.Text,0) <= 0) then
        Begin
          fMensagem('', 'A Data Final de repasse informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End
        Else
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        Begin
          fMensagem('', 'O campo Data Final de repasse deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
          Begin
            fMensagem('', 'O campo Data Inicial de repasse deve ser preenchido!', ['&Ok']);
            Result := False;
            Sender := mskDtaIni;
          End
          Else
          Begin
            If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
            Begin
              If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
              Begin
                fMensagem('','A data Inicial de repasse deve ser menor que a data final!',['&O K']);
                Result := False;
                Sender := mskDtaIni;
            End;
          End;
        End;
      End;
    End

    Else  If (Sender = mskDtaIni) And (mskDtaIni.Enabled) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial de repasse informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
      End;
    End;

    {******************}
    {* VERIFICA DESTINO *}
    {***************LE*}
    If (Sender = edtDestino) Then
    Begin
      If edtDestino.Text = '' Then
      Begin

        fMensagem('ATENÇÃO!','O campo destino deve ser preenchido!',['&O K']);
        Result := False;

      End
      Else
      Begin

        If (edtDestino.Text <> 'V') And (edtDestino.Text <> 'I') Then
        Begin
          fMensagem('ATENÇÃO!','O campo destino deve ser V ou I!',['&O K']);
          Result := False;
        End;

      End;
    End

   Else If (Sender = edtOrdem) Then
    Begin
      If edtOrdem.Text = '' Then
      Begin

        fMensagem('ATENÇÃO!','O campo ordem deve ser preenchido!',['&O K']);
        Result := False;

      End
      Else
      Begin

        If (edtOrdem.Text <> 'R') And (edtOrdem.Text <> 'V') Then
        Begin
          fMensagem('ATENÇÃO!','O campo ordem deve ser R ou V!',['&O K']);
          Result := False;
        End;

      End;
    End

    Else If (Sender = edtCodPor) And (edtCodPor.Enabled) Then
    Begin
      If (Not fEmptyStr(edtCodPor.Text)) Then
      Begin
        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        If (fEmptyStr(edtDesPor.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','Esse Portador não está cadastrado!',['&O k']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
        edtDesPor.Text := 'TODOS';
    End;


    {***********************************}
    {*  RETORNA NOME POR  CPF OU CNPJ  *}
    {********************************LE*}
    If (Sender = edtValidaCnpjCpf) And (edtValidaCnpjCPf.Enabled) Then
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

    Else if (Sender = mskCnpjCpf) And (mskCnpjCpf.Enabled) Then
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

procedure TfrmRelChqRepassados.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;

end;

procedure TfrmRelChqRepassados.FormActivate(Sender: TObject);
begin
  inherited;
  If (blnBaixaChequesRepasse) Then
    btnImprimir.Click
  Else
    pSetFocus(edtOrdem);
end;

procedure TfrmRelChqRepassados.FormCreate(Sender: TObject);
begin
  inherited;
  blnBaixaChequesRepasse := False;
end;

procedure TfrmRelChqRepassados.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

procedure TfrmRelChqRepassados.edtClienteExit(Sender: TObject);
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

procedure TfrmRelChqRepassados.edtClienteKeyPress(Sender: TObject;
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

procedure TfrmRelChqRepassados.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryGenPor: TUniQuery;
    arrSel : TConsultasArray;

begin
  inherited;

  qryGenPor := fCriaQuery(nil);

  If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, qryGenPor, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodPor, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(qryGenPor);

end;

function TfrmRelChqRepassados.fFiltroCheques(strNomTab: String): String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := Low(arrCheques) To High(arrCheques) Do
  Begin
    If SameText(strNomTab, Copy(arrCheques[intCnt], 1, Length(arrCheques[intCnt])-20)) Then
    Begin
      If fEmptyStr(Result) Then
        Result := '"' + RightStr(arrCheques[intCnt], 20) + '"'
      Else
        Result := Result + ', ' + '"' + RightStr(arrCheques[intCnt], 20) + '"';
    End;
  End;

  If Not fEmptyStr(Result) Then
    Result := ' AND Q.AUTOINCREM IN (' + Result + ') ';
end;

end.

