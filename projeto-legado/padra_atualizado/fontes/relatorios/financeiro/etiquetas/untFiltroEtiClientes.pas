unit untFiltroEtiClientes;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, untTypesSistema,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, strUtils,
  EditFocus, Menus, Uni, AppEvnts, QColorLabel, untFuncoesSimples, Mask,
  MaskEditFocus, BitBtnLockedIncrem, ComboBoxFocus, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFiltroEtiClientes = class(TfrmPaiSimples)
    Label1: TLabel;
    Label2: TLabel;
    edtNomIni: TEditFocus;
    edtNomFin: TEditFocus;
    Label3: TLabel;
    edtCodVen: TEditFocus;
    Label4: TLabel;
    edtCodAti: TEditFocus;
    Label6: TLabel;
    edtCodCid: TEditFocus;
    Label8: TLabel;
    edtBairro: TEditFocus;
    Label9: TLabel;
    edtEstado: TEditFocus;
    Label10: TLabel;
    edtQtdEti: TEditFocus;
    edtNomVen: TEditFocus;
    edtNomAti: TEditFocus;
    edtNomCid: TEditFocus;
    pnlFundo: TPanel;
    shpMultSel: TShape;
    GroupBox2: TGroupBox;
    chkMosFil: TCheckBox;
    gpb1: TGroupBox;
    lbl3: TLabel;
    lbl4: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    gpbAniv: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    mskAniIni: TMaskEditFocus;
    mskAniFin: TMaskEditFocus;
    Label5: TLabel;
    edtCodCac: TEditFocus;
    edtDesCac: TEditFocus;
    gpbTipPeriodo: TGroupBox;
    lblTipPeriodo: TColorLabel;
    edtTipPer: TEditFocus;
    edtCodReg: TEditFocus;
    Label7: TLabel;
    edtDesReg: TEditFocus;
    edtVlrFat: TEditFocus;
    Label11: TLabel;
    lbl5: TLabel;
    edtRevist: TEditFocus;
    ColorLabel1: TColorLabel;
    lblSexo: TLabel;
    cmbSexo: TComboBoxFocus;
    gpbCGCCPF: TGroupBox;
    lblOrdem1: TColorLabel;
    edtCGCCPF: TEditFocus;
    lblTipCli: TLabel;
    lblConFin: TLabel;
    clbConFin: TColorLabel;
    edtTipCli: TEditFocus;
    edtDesTpc: TEditFocus;
    edtConFin: TEditFocus;
    gpbCompraPeri: TGroupBox;
    Label12: TLabel;
    mskCompraIni: TMaskEditFocus;
    Label13: TLabel;
    mskCompraFin: TMaskEditFocus;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    mskNaoCompraIni: TMaskEditFocus;
    mskNaoCompraFin: TMaskEditFocus;
    Label17: TLabel;
    ColorLabel2: TColorLabel;
    procedure FormCreate(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodCacExit(Sender: TObject);
    procedure edtCodCacKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtTipCliKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function fRetDescricaoTipoCli(strCodTip: String): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;

    strNomIni: String;
    strNomFin: String;
    strCodVen: String;
    strCodAti: String;
    strCodCid: String;
    strBairro: String;
    strEstado: String;
    strStatus: String;
    intQtdEti: Integer;
    strAniIni: String;
    strAniFin: String;
    strDtaIni: String;
    strDtaFin: String;
    strCodCac: String;
    strRevist: String;
    strSexo__: String;
    strCodReg: String;
    strTipPer: String;
    fltVlrFat: Double;
    strCGCCPF: String;
    strTipCli: String;
    strConFin: String;

    strComIni: String;
    strComFin: String;
    strNaoIni: String;
    strNaoFin: String;

    arrVendedor : TConsultasArray;
    arrAtividade: TConsultasArray;
    arrCidade   : TConsultasArray;
    arrCanal    : TConsultasArray;
    arrRegiao   : TConsultasArray;
    arrTipCli   : TConsultasArray;
  end;


implementation

uses untFuncoesConsulta, untConsultas;

{$R *.dfm}

{ TfrmFiltroEtiClientes }

function TfrmFiltroEtiClientes.fRetDescricaoTipoCli(strCodTip: String): String;
Var
  strSQL   : String;
  qryGenClg: TUniQuery;
begin
  Try
    qryGenClg := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  TIP_DESTIP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TIPCLG ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TIP_CODTIP = :CODTIP ';

    With qryGenClg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODTIP').AsString := strCodTip;
      Open;
      Result := FieldByName('TIP_DESTIP').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenClg);
  End;
end;

function TfrmFiltroEtiClientes.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*****************************************}
    {* VALIDA O NOME INICIAL                 *}
    {**************************************MV*}
    If (Sender = edtNomIni) Then
    Begin
      If fEmptyStr(edtNomIni.Text) Then
      Begin
        edtNomFin.Enabled := False;
      End
      Else
      Begin
        edtNomFin.Enabled := True;
      End;
    End

    {*****************************************}
    {* VALIDA O NOME FINAL                   *}
    {**************************************MV*}
    Else If (Sender = edtNomFin) Then
    Begin

      If edtNomIni.Text > edtNomFin.Text Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome Final não pode ser menor que o Inicial', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA A REGIÃO                       *}
    {**************************************AC*}

    Else If (Sender = edtCodReg) Then
    Begin
      pDesmarcaLista(edtCodReg, arrRegiao);
    End

    {*****************************************}
    {* VALIDA O BAIRRO                       *}
    {**************************************MV*}
    Else If (Sender = edtBairro) Then
    Begin

    End

    {*****************************************}
    {* VALIDA O ESTADO                       *}
    {**************************************MV*}
    Else If (Sender = edtEstado) Then
    Begin
      If Not fEmptyStr(edtEstado.Text) Then
      Begin
        If (Not fValidaEstado(edtEstado.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', edtEstado.Text + ' não é um Estado válido!', ['&O k']);
          edtEstado.Clear;
          Result := False;
        End;
      End;
    End

    {**************************}
    {* VALIDA O CAMPO REVISTA *}
    {***********************PZ*}
    Else If (sender = edtRevist) Then
    Begin
      If (Pos(edtRevist.Text, 'SN') <= 0) And (Not fEmptyStr(edtRevist.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Revista deve ser S ou N.',['&O k']);
        Result := False;
      End;
    End

    {***********************************}
    {* VALIDA O CAMPO CONSUMIDOR FINAL *}
    {********************************CG*}
    Else If (sender = edtConFin) Then
    Begin
      If (Pos(edtConFin.Text, 'SNT') <= 0) And (Not fEmptyStr(edtConFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O campo Consumidor Final deve ser S(im), N(ão) ou T(odos).',['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA PERÍODO DE VENDA               *}
    {**************************************RV*}
    Else If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        mskDtaFin.Enabled := False;
        mskCompraIni.Enabled := True;
        mskNaoCompraIni.Enabled := True;
        mskCompraFin.Enabled := True;
        mskNaoCompraFin.Enabled := True;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
        mskCompraIni.Enabled := False;
        mskNaoCompraIni.Enabled := False;
        mskCompraFin.Enabled := False;
        mskNaoCompraFin.Enabled := False;
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

    {*****************************************}
    {* VALIDA O DIA/MÊS DE ANIVERSÁRIO       *}
    {**************************************RV*}
    Else If (Sender = mskAniIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskAniIni.Text)) Then
      Begin
        mskAniFin.Enabled := False;
      End
      Else
      Begin
        mskAniFin.Enabled := True;
      End;
    End

    {*****************************************}
    {* VALIDA O DIA/MÊS DE ANIVERSÁRIO       *}
    {**************************************MV*}
    Else If (Sender = mskAniFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskAniFin.Text)) Then
      Begin
        fMensagem('', 'O Dia/Mês Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If StrToDate(mskAniIni.Text) > StrToDate(mskAniFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Dia/Mês Final não pode ser menor que o Inicial', ['&O k']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA A QUANTIDADE DE ETIQUETAS      *}
    {**************************************MV*}
    Else If (Sender = edtQtdEti) Then
    Begin

      If fEmptyStr(edtQtdEti.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Defina uma quantidade de etiquetas!', ['&O  k']);
        Result := False;
        pSetFocus(Sender);
      End
      Else If StrToInt(edtQtdEti.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Defina uma quantidade de etiquetas maior que zero!', ['&O  k']);
        Result := False;
        pSetFocus(Sender);
      End
      Else
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(mskCompraIni.Text)) Then
        Begin
          If (Not fValidaCampos(mskCompraFin, False)) Or (Not fValidaCampos(mskNaoCompraFin, False)) Then
          Begin
            Result := False;
            Exit;
          End;
        End;

        If fMensagem('', 'Confirma dados do filtro?', ['&Sim', '&Não']) = 1 Then
        Begin
          blnConfirma := True;

          strNomIni := edtNomIni.Text;
          strNomFin := edtNomFin.Text;
          strCodVen := edtCodVen.Text;
          strCodAti := edtCodAti.Text;
          strCodCid := edtCodCid.Text;
          strCodCac := edtCodCac.Text;
          strRevist := edtRevist.Text;
          strSexo__ := LeftStr(cmbSexo.Text, 1);          
          strCodReg := edtCodReg.Text;
          strBairro := edtBairro.Text;
          strEstado := edtEstado.Text;
          intQtdEti := StrToInt(edtQtdEti.Text);
          strAniIni := mskAniIni.Text;
          strAniFin := mskAniFin.Text;
          strDtaIni := mskDtaIni.Text;
          strDtaFin := mskDtaFin.Text;
          strTipPer := edtTipPer.Text;
          fltVlrFat := fStrToFloat(edtVlrFat.Text);
          strCGCCPF := IfThen((edtCGCCPF.Text = 'J'), '1', IfThen((edtCGCCPF.Text = 'F'), '2', '')); // cliente jurídica/física
          strTipCli := edtTipCli.Text;
          strConFin := edtConFin.Text;

          strComIni := mskCompraIni.Text;
          strComFin := mskCompraFin.Text;
          strNaoIni := mskNaoCompraIni.Text;
          strNaoFin := mskNaoCompraFin.Text;

          Close;
        End;
      End;
    End

    {******************************************}
    {* VALIDA TIPO DO CLIENTE JURÍDICO/FÍSICO *}
    {************************************* MA *}

    Else If (Sender = edtCGCCPF) Then
    Begin

      If Not fEmptyStr(edtCGCCPF.Text) Then
        If Pos(edtCGCCPF.Text, 'J_F_T_') <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'Apenas as opções J(urídica), F(ísica) ou T(odos) são válidas !', ['&Ok']);
          Result := False;
        End;

    End

    Else If (Sender = edtTipPer) Then
    Begin

      If fEmptyStr(edtTipPer.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'É necessário informar o Tipo de Período 1 ou 2!', ['&Ok']);
        Result := False;
      End
      Else If Pos(edtTipPer.Text, '1_2_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO', 'Apenas as opções (1) e (2) são válidas !', ['&Ok']);
        Result := False;
      End;

    End

    {*********************************************************}
    {* VALIDA O PERÍODO QUE O CLIENTE COMPROU E NÃO COMPPROU *}
    {**************************************************** AM *}

    Else If (Sender = mskCompraIni) Or (Sender = mskCompraFin) Then
    Begin

      If (fEmptyStr(fTiraCaracEspeciais(mskCompraIni.Text))) Or (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      Begin
        mskNaoCompraIni.Enabled := False;
        mskCompraFin.Enabled := False;
        mskNaoCompraFin.Enabled := False;
      End
      Else
      Begin
        mskNaoCompraIni.Enabled := True;
        mskCompraFin.Enabled := True;
        mskNaoCompraFin.Enabled := True;

        If (Sender = mskCompraFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskCompraFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchida!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskCompraIni.Text) > StrToDate(mskCompraFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If (Sender = mskNaoCompraIni) Or (Sender = mskNaoCompraFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskNaoCompraIni.Text)) Then
      Begin
        fMensagem('','A data inicial deve ser preenchida!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If (Sender = mskNaoCompraFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskNaoCompraFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskNaoCompraIni.Text) > StrToDate(mskNaoCompraFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFiltroEtiClientes.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmFiltroEtiClientes.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fEntraCons(Key) then
  begin
    if fPesqOperador(Self, edtCodVen, edtNomVen, qryTabela, Key, arrVendedor, False) then
    Begin
      fValidaCampos(edtCodVen, False);
      Self.SelectNext(ActiveControl, True, True);
    End;
  end;
end;

procedure TfrmFiltroEtiClientes.edtTipCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = '/' then
  begin
    if fPesqTipoCliente(Self, edtTipCli, edtDesTpc, nil, Key, arrTipCli, False) then
		  Self.SelectNext(ActiveControl, True, True);
  end

  else
  begin
    edtDesTpc.Text := fRetDescricaoTipoCli(edtTipCli.Text);

    if fEmptyStr(edtDesTpc.Text) then
    begin
      edtTipCli.Clear;
      edtDesTpc.Clear;
    end;
  end
end;

procedure TfrmFiltroEtiClientes.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtNomAti, Nil, Key, arrAtividade, False) Then
	Begin
		fValidaCampos(edtCodAti, False);
		Self.SelectNext(ActiveControl, True, True);
	End;
end;

procedure TfrmFiltroEtiClientes.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtNomCid, edtEstado, Nil, Key, arrCidade, False) Then
	Begin
		fValidaCampos(edtCodCid, False);
		Self.SelectNext(ActiveControl, True, True);
	End;
end;

procedure TfrmFiltroEtiClientes.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg, edtDesReg, arrRegiao, nil, fRetNomRegiao, 'da Região');
end;

procedure TfrmFiltroEtiClientes.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE CANAL DE REGIAO *}
  {*********************************AC*}
  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrRegiao, false) Then
  Begin
		fValidaCampos(edtCodReg, False);
		Self.SelectNext(ActiveControl, True, True);
	End;

end;

procedure TfrmFiltroEtiClientes.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtNomVen, arrVendedor, fRetNomVendRep, nil, 'do Vendedor');
end;

procedure TfrmFiltroEtiClientes.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtNomAti, arrAtividade, nil, fRetNomAtividade, 'da Atividade');
end;


procedure TfrmFiltroEtiClientes.edtCodCacExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCac, edtDesCac, arrCanal, nil, fRetNomCanalAcesso, 'do Canal');
end;

procedure TfrmFiltroEtiClientes.edtCodCacKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE CANAL DE ACESSO *}
  {*********************************DP*}
  If fPesqCanalAcesso(Self, edtCodCac, edtDesCac, Nil, Key, arrCanal, false) Then
  Begin
		fValidaCampos(edtCodCac, False);
		Self.SelectNext(ActiveControl, True, True);
	End;

end;

procedure TfrmFiltroEtiClientes.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtNomCid, arrCidade, fRetNomCidadeSemOpc, nil, 'da Cidade');
end;

End.
