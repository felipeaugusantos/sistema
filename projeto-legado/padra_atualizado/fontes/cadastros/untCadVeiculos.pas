unit untCadVeiculos;

interface

uses
  Windows,Classes,Controls,Forms, untPaiCad,AppEvnts, Menus, ComCtrls, strUtils,
  StdCtrls, Buttons, ExtCtrls, untCadVei, DB,DBCtrls, DBEditFocus, DBMemoFocus,
  EditFocus, Mask, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  DBComboBoxFocus, QColorLabel, untRomaneioTarefasFusion;

type
  TfrmCadVeiculos = class(TfrmPaiCad)
    pnlFundo          : TPanel;
    dtsCadVei         : TDataSource;
    dbePlaVei         : TDBEditFocus;
    dbeChassi         : TDBEditFocus;
    dbeCodMod         : TDBEditFocus;
    dbeCodMar         : TDBEditFocus;
    dbeCodCor         : TDBEditFocus;
    dbeAnoVei         : TDBEditFocus;
    dbeCondut         : TDBEditFocus;
    mmoObserv         : TDBMemoFocus;
    lbl1              : TLabel;
    lbl3              : TLabel;
    lbl4              : TLabel;
    lbl5              : TLabel;
    lbl6              : TLabel;
    lbl7              : TLabel;
    lblCondut         : TLabel;
    lbl9              : TLabel;
    edtDesMod         : TEditFocus;
    edtDesMar         : TEditFocus;
    edtDesCor         : TEditFocus;
    pnlDadosBetoneira : TPanel;
    Label1            : TLabel;
    lblMotorista      : TLabel;
    dbeBetone         : TDBEditFocus;
    dbeCodMot         : TDBEditFocus;
    edtNomMot         : TEditFocus;
    chkZeroKm         : TDBCheckBox;
    lblCapCar         : TLabel;
    dbeCapCar         : TDBEditFocus;
    chkVeiculoAtivo: TDBCheckBox;
    dbeTara: TDBEditFocus;
    Label3: TLabel;
    chkReboque: TDBCheckBox;
    lblTipoRodado: TLabel;
    cmbTipoRodado: TDBComboBoxFocus;
    Label5: TLabel;
    cmbTipoCarroceria: TDBComboBoxFocus;
    gbxIntegracaoQualp: TGroupBox;
    Label2: TLabel;
    lblLeiLGPDSN: TColorLabel;
    pnlControlesIntegracaoQualp: TPanel;
    Label4: TLabel;
    cmbTipoVeiculo: TDBComboBoxFocus;
    dbeParticipaIntegracaoQualP: TDBEditFocus;
    Label6: TLabel;
    dbeQuantidadeEixo: TDBEditFocus;
    Label7: TLabel;
    cmbTipoCombustivel: TDBComboBoxFocus;
    Label8: TLabel;
    dbeAutonomiaKml: TDBEditFocus;
    Label9: TLabel;
    cmbTipoAcrescimoFrete: TDBComboBoxFocus;
    Label10: TLabel;
    dbeAcrescimoFrete: TDBEditFocus;
    dbeKMATUA: TDBEditFocus;
    lblKMATUA: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeCodCorKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodModKeyPress(Sender: TObject; var Key: Char);
    function dbeCodModChamaCadastro(Key: Word): string;
    function dbeCodMarChamaCadastro(Key: Word): string;
    function dbeCodCorChamaCadastro(Key: Word): string;
    procedure FormActivate(Sender: TObject);
    procedure dbeCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure chkZeroKmClick(Sender: TObject);
    procedure dbeCapCarEnter(Sender: TObject);
    procedure chkReboqueClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeQuantidadeEixoEnter(Sender: TObject);
    procedure dbeAutonomiaKmlEnter(Sender: TObject);
    procedure dbeAcrescimoFreteEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    objCadVei : TCadVei;
    objRomFusTarefas: TRomaneioTarefasFusion;
    procedure pAtualizaDescricoes(DataSet: TDataSet);

    procedure pPesquisa(strPlacaVeiculo: String = '');
    function fSetaPlacaVeiculoInformada(strPlacaVeiculo: String = ''): Boolean;

    procedure pLimparDadosIntegracaoQualP;
    procedure pCarregaRegistroAntesAlteracao;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
    strPlacaVeiculoIniciarCadastro : String;
  end;

implementation

uses SysUtils, Variants, untFuncoesSimples, untPai, untConsultas, untFuncIns,
  untTypesSistema, untConstantes, untFuncoes, untPesqAux;

{$R *.dfm}

procedure TfrmCadVeiculos.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadVeiculos.FormCreate(Sender: TObject);
begin
  inherited;
  strPlacaVeiculoIniciarCadastro := '';

  objCadVei := TCadVei.Create(Self);
  objCadVei.pOnScroll := pAtualizaDescricoes;

  strNomeTabela     := 'CADVEI';
  strNomeCampo      := 'VEI_PLAVEI';
  qryTabela         := objCadVei.qryTabela;
  dtsCadVei.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbePlaVei;

  If Not fVerificaAcessoSistema('ZEROKM') Then
    chkZeroKm.Visible := False
  Else
    chkZeroKm.Visible := True;

  objRomFusTarefas := TRomaneioTarefasFusion.Create(Self);
end;

procedure TfrmCadVeiculos.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(objRomFusTarefas) then
    FreeAndNil(objRomFusTarefas);
end;

function TfrmCadVeiculos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
Begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Try

      {*****************************************}
      {* VALIDA O NOME DO PORTADOR             *}
      {**************************************MV*}
      If (Sender = dbePlaVei) Then
      Begin
        If Not chkZeroKm.Checked Then
        Begin
          If fEmptyStr(dbePlaVei.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'Placa do Veículo Obrigatório !!!', ['&O k']);
            Result := False;
          End
          Else If Not fValidaPlaVei(dbePlaVei.Text) Then
            Result := False
          Else If (blnBuscaPorChave) Then
          Begin
            If Not fBuscaPorCamposChave Then
              pLimparCampos;
          End;
        End;
      End

      Else If (Sender = dbeCapCar) and (chkReboque.Checked) Then
      Begin
        If (fEmptyStr(dbeCapCar.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Capacidade de Carga do Veículo Obrigatório !!!', ['&O k']);
          Result := False;
        End
        Else If (StrToInt(dbeCapCar.Text) <= 0) or (StrToInt(dbeCapCar.Text) > 999999) Then
        Begin
          fMensagem('ATENÇÃO', 'Capacidade de Carga do Veículo Inválida !!!', ['&O k']);
          Result := False;
        End;
      End

      Else If (Sender = dbeCodMod) Then
      Begin
        If Not fEmptyStr(dbeCodMod.Text) Then
        Begin
          If fIsNumber(dbeCodMod.Text) Then
            If Length(dbeCodMod.Text) < 4 Then
              dbeCodMod.Text := fStrZero(dbeCodMod.Text, 4);

          If fIsNumber(dbeCodMar.Text) Then
            If Length(dbeCodMar.Text) < 4 Then
              dbeCodMar.Text := fStrZero(dbeCodMar.Text, 4);

          pAtualizaDescricoes(qryTabela);
          If fEmptyStr(edtDesMod.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'Modelo de veículo não cadastrado!', ['&O k']);
            Result := False;
          End
          Else If fRetMarcaModeloVeiculo(dbeCodMod.Text) <> dbeCodMar.Text Then
          Begin
            fMensagem('ATENÇÃO', 'Modelo de veículo não pertence à marca informada!', ['&O k']);
            Result := False;
          End;
        End
        Else
        Begin
          fMensagem('ATENÇÃO', 'Modelo do veículo deve ser informado!', ['&O k']);
          Result := False;
        End;
      End

      Else If (Sender = dbeAnoVei) Then
      Begin
        If (fEmptyStr(dbeAnoVei.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'O Ano do Veículo deve ser preenchido!', ['&O k']);
          Result := False;
        End;
      End

      Else If (Sender = dbeCodCor) Then
      Begin
        If Not fEmptyStr(dbeCodCor.Text) Then
        Begin
          If fIsNumber(dbeCodCor.Text) Then
            If Length(dbeCodCor.Text) < 4 Then
              dbeCodCor.Text := fStrZero(dbeCodCor.Text, 4);

          pAtualizaDescricoes(qryTabela);
          If fEmptyStr(edtDesCor.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'Cor de veículo não cadastrada!', ['&O k']);
            Result := False;
          End
        End
        Else
        Begin
          fMensagem('ATENÇÃO', 'Cor do veículo deve ser informada!', ['&O k']);
          Result := False;
        End;
      End

      Else If (Sender = dbeCodMar) Then
      Begin
        If Not fEmptyStr(dbeCodMar.Text) Then
        Begin
          If fIsNumber(dbeCodMar.Text) Then
            If Length(dbeCodMar.Text) < 4 Then
              dbeCodMar.Text := fStrZero(dbeCodMar.Text, 4);

          pAtualizaDescricoes(qryTabela);
          If fEmptyStr(edtDesMar.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'Marca de veículo não cadastrada!', ['&O k']);
            Result := False;
          End
        End
        Else
        Begin
          fMensagem('ATENÇÃO', 'Marca do veículo deve ser informada!', ['&O k']);
          Result := False;
        End;
      End

      else if (Sender = dbeTara) and (chkReboque.Checked) then
      begin
        if (fEmptyStr(dbeTara.Text)) then
        begin
          fMensagem('ATENÇÃO', 'Tara do Veículo Obrigatória !!!', ['&O k']);
          Result := False;
        end
        else if (StrToInt(dbeTara.Text) <= 0) or (StrToInt(dbeTara.Text) > 999999) then
        begin
          fMensagem('ATENÇÃO', 'Tara do Veículo Inválida !!!', ['&O k']);
          Result := False;
        end;
      end

      else if (Sender = cmbTipoCarroceria) then
      begin
        if (cmbTipoCarroceria.ItemIndex = -1) then
        begin
          fMensagem('ATENÇÃO', 'Tipo de Carroceria Obrigatório !!!', ['&O k']);
          Result := False;
        end;
      end

      else if (cmbTipoRodado.Enabled) and (Sender = cmbTipoRodado) then
      begin
        if (cmbTipoRodado.ItemIndex = -1) then
        begin
          fMensagem('ATENÇÃO', 'Tipo de Rodado Obrigatório !!!', ['&O k']);
          Result := False;
        end;
      end

      Else If (Sender = dbeCodMot) And pnlDadosBetoneira.Visible Then
      Begin
        edtNomMot.Clear;
        If Not fEmptyStr(dbeCodMot.Text) Then
        Begin
          pAtualizaDescricoes(qryTabela);
          If fEmptyStr(edtNomMot.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'Motorista não cadastrado!', ['&O k']);
            Result := False;
          End;
        End;
      End

      else if gbxIntegracaoQualp.Visible then
      begin
        if (Sender = dbeParticipaIntegracaoQualP) then
        begin
          if ((fEmptyStr(dbeParticipaIntegracaoQualP.Text)) or
              (Pos(dbeParticipaIntegracaoQualP.Text, 'SN') <= 0)) then
          begin
            fMensagem('ATENÇÃO', 'Preencha o campo Participa da Integração QUALP com (S)im ou (N)ão!', ['&Ok']);
            Result := False;
          end
          else
          begin
            pnlControlesIntegracaoQualp.Enabled := dbeParticipaIntegracaoQualP.Text = 'S';

            if not pnlControlesIntegracaoQualp.Enabled then
              pLimparDadosIntegracaoQualP;
          end;
        end
        else if (Sender = cmbTipoVeiculo) and
           (dbeParticipaIntegracaoQualP.Text = 'S') and
           ((cmbTipoVeiculo.ItemIndex = -1) or (fEmptyStr(cmbTipoVeiculo.Text))) then
        begin
          fMensagem('ATENÇÃO', 'Selecione um tipo de veículo!', ['&Ok']);
          Result := False;
        end
        else if (Sender = dbeQuantidadeEixo) and
           (dbeParticipaIntegracaoQualP.Text = 'S') and
           ((fEmptyStr(dbeQuantidadeEixo.Text)) or (dbeQuantidadeEixo.Text = '0')) then
        begin
          fMensagem('ATENÇÃO', 'Preencha a quantidade de eixos com um valor válido!', ['&Ok']);
          Result := False;
        end
        else if (Sender = cmbTipoCombustivel) and
           (dbeParticipaIntegracaoQualP.Text = 'S') and
           ((cmbTipoCombustivel.ItemIndex = -1) or (fEmptyStr(cmbTipoCombustivel.Text))) then
        begin
          fMensagem('ATENÇÃO', 'Selecione um tipo de combustível!', ['&Ok']);
          Result := False;
        end
        else if (Sender = dbeAutonomiaKml) and
           (dbeParticipaIntegracaoQualP.Text = 'S') and
           ((fEmptyStr(dbeAutonomiaKml.Text)) or (dbeAutonomiaKml.Text = '0') or (dbeAutonomiaKml.Text = '0,00')) then
        begin
          fMensagem('ATENÇÃO', 'Preencha a autonomia em Km/L com um valor válido!', ['&Ok']);
          Result := False;
        end
        else if (Sender = cmbTipoAcrescimoFrete) and
           (dbeParticipaIntegracaoQualP.Text = 'S') and
           ((cmbTipoAcrescimoFrete.ItemIndex = -1) or (fEmptyStr(cmbTipoAcrescimoFrete.Text))) then
        begin
          fMensagem('ATENÇÃO', 'Selecione um tipo de acréscimo no frete!', ['&Ok']);
          Result := False;
        end
        else if (Sender = dbeAcrescimoFrete) and
           (dbeParticipaIntegracaoQualP.Text = 'S') and
           ((fEmptyStr(dbeAcrescimoFrete.Text)) or (dbeAcrescimoFrete.Text = '0') or (dbeAcrescimoFrete.Text = '0,00')) then
        begin
          fMensagem('ATENÇÃO', 'Preencha o acréscimo do frete com um valor válido!', ['&Ok']);
          Result := False;
        end
      end;

      If Not fVerificaAcessoSistema('SEMCON') Then
      Begin

        If (Sender = dbeCondut) And dbeCondut.Visible Then
        Begin
          If fEmptyStr(dbeCondut.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'Defina um condutor!', ['&O k']);
            Result := False;
          End;
        End;

      End;

    Except
      On E: Exception Do
      Begin
        fMensagem('',E.Message,['&OK']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

End;

procedure TfrmCadVeiculos.pAtualizaDescricoes(DataSet: TDataSet);
begin
  edtDesCor.Text := fRetDesCorVeic(dbeCodCor.Text);
  edtDesMar.Text := fRetDesMarcaVeic(dbeCodMar.Text);
  edtDesMod.Text := fRetDesModeloVeic(dbeCodMod.Text);
  edtNomMot.Text := fRetNomeMotorista(dbeCodMot.Text);
end;

procedure TfrmCadVeiculos.pCarregaRegistroAntesAlteracao;
begin
  objRomFusTarefas.pClearDataSets;
  objRomFusTarefas.pLogAdd('CADVEI', ['VEI_PLAVEI'], 'VEI_PLAVEI = ' + QuotedStr(qryTabela.FieldByName('VEI_PLAVEI').AsString));
end;

procedure TfrmCadVeiculos.pInicializaIndices;
Begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('VEI_PLAVEI');
  stlCampos.Add('VEI_CHASSI');
  stlCampos.Add('VEI_CODMOD');
  stlCampos.Add('VEI_CODMAR');
  stlCampos.Add('VEI_CODCOR');
  stlCampos.Add('VEI_ANOVEI');
  stlCampos.Add('VEI_CONDUT');
  stlCampos.Add('AUTOINCREM');
  stlCampos.Add('VEI_OBSERV');
  stlCampos.Add('VEI_PINQLP');
  stlCampos.Add('VEI_TIPVEI');
  stlCampos.Add('VEI_QTDEIX');
  stlCampos.Add('VEI_TIPCMB');
  stlCampos.Add('VEI_AUTKML');
  stlCampos.Add('VEI_TIPAFR');
  stlCampos.Add('VEI_ACRFRE');

  stlCamInd.Add('VEI_PLAVEI');
  stlDesInd.Add('Placa');
End;

procedure TfrmCadVeiculos.pLimparDadosIntegracaoQualP;
begin
  cmbTipoVeiculo.ItemIndex        := -1;
  cmbTipoCombustivel.ItemIndex    := -1;
  cmbTipoAcrescimoFrete.ItemIndex := -1;

  dbeQuantidadeEixo.Text          := '1';
  dbeAutonomiaKml.Text            := '0';
  dbeAcrescimoFrete.Text          := '0';
end;

procedure TfrmCadVeiculos.pPesquisa(strPlacaVeiculo: String = '');
Var
  chrKey: Char;
  arrVeic: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE VEÍCULOS   *}
  {****************************RV*}
  chrKey := '/';
  If fSetaPlacaVeiculoInformada(strPlacaVeiculo) or
     fPesqVeiculos(Self, Nil, Nil, qryTabela, chrKey, arrVeic, True, False) Then
    begin
    pSetFocus(btnAlterar);
    pCarregaRegistroAntesAlteracao;
  end;
end;

function TfrmCadVeiculos.fSetaPlacaVeiculoInformada(strPlacaVeiculo: String = ''): Boolean;
begin
  Result := False;
  If Not fEmptyStr(strPlacaVeiculo) Then
  Begin
    pPesquisaCadVei(qryTabela, qryTabela, strPlacaVeiculo);
    Result := True;
  End;
end;

procedure TfrmCadVeiculos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  chkZeroKm.Enabled := False;
  dbePlaVei.Enabled := False;

  If dbeChassi.Enabled Then
    pSetFocus(dbeChassi);
end;

procedure TfrmCadVeiculos.FormShow(Sender: TObject);
begin
  inherited;
  //Prestcon
  pnlDadosBetoneira.Visible := (fCfgSis('USACCR', varBoolean)) And MatchStr(fCfgSis('TPNFCR'),[PRESTCON,SECOL]);

  If pnlDadosBetoneira.Visible Then
  Begin
    dbeCondut.Visible := False;
    lblCondut.Visible := False;
  End
  Else
  Begin
    Self.Height := Self.Height - pnlDadosBetoneira.Height;
  End;

  gbxIntegracaoQualp.Visible := (fCfgSis('QLPUSA', varBoolean));
  if not gbxIntegracaoQualp.Visible then
    Self.Height := Self.Height - gbxIntegracaoQualp.Height;

  If Not fEmptyStr(strPlacaVeiculoIniciarCadastro) Then
    Self.pPesquisa(strPlacaVeiculoIniciarCadastro);
end;

procedure TfrmCadVeiculos.btnPesquisaClick(Sender: TObject);
begin
  Self.pPesquisa;
end;

procedure TfrmCadVeiculos.chkReboqueClick(Sender: TObject);
begin
  inherited;
  lblTipoRodado.Enabled := (not chkReboque.Checked);
  cmbTipoRodado.Enabled := lblTipoRodado.Enabled;

  If (qryTabela.State In dsEditModes) And (Not chkReboque.Checked) Then
    cmbTipoCarroceria.Field.AsString := cmbTipoCarroceria.Items[0];
end;

procedure TfrmCadVeiculos.chkZeroKmClick(Sender: TObject);
begin
  inherited;
  If (qryTabela.State In [dsInsert]) Then
  Begin
    If chkZeroKm.Checked Then
    Begin
      dbePlaVei.Enabled := False;
      dbePlaVei.Field.Clear;
    End
    Else
      dbePlaVei.Enabled := True;
  End;
end;

procedure TfrmCadVeiculos.dbeAcrescimoFreteEnter(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeAcrescimoFrete.Text) Then
    dbeAcrescimoFrete.Text := IntToStr(0);
end;

procedure TfrmCadVeiculos.dbeAutonomiaKmlEnter(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeAutonomiaKml.Text) Then
    dbeAutonomiaKml.Text := IntToStr(0);
end;

procedure TfrmCadVeiculos.dbeCapCarEnter(Sender: TObject);
begin
  inherited;

  If fEmptyStr(dbeCapCar.Text) Then
    dbeCapCar.Text := IntToStr(0);
end;

function TfrmCadVeiculos.dbeCodCorChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCorVei(Key);
end;

procedure TfrmCadVeiculos.dbeCodCorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCor: TConsultasArray;
begin
  If fPesqCorVeiculo(Self, dbeCodCor, edtDesCor, nil, Key, arrCor) Then
    If fValidaCampos(dbeCodCor) Then
      SelectNext(dbeCodCor, True, True);
end;

function TfrmCadVeiculos.dbeCodMarChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaMarVei(Key);
end;

procedure TfrmCadVeiculos.dbeCodMarKeyPress(Sender: TObject; var Key: Char);
  Var
    arrMarca: TConsultasArray;
begin
  If fPesqMarcaVeiculo(Self, dbeCodMar, edtDesMar, nil, Key, arrMarca) Then
    If fValidaCampos(dbeCodMar) Then
      SelectNext(dbeCodMar, True, True);
end;

function TfrmCadVeiculos.dbeCodModChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaModVei(Key);
end;

procedure TfrmCadVeiculos.dbeCodModKeyPress(Sender: TObject; var Key: Char);
  Var
    arrModelo: TConsultasArray;
begin
  If fPesqModeloVeiculo(Self, dbeCodMod, edtDesMod, nil, Key, arrModelo, True, dbeCodMar.Text) Then
    If fValidaCampos(dbeCodMod) Then
      SelectNext(dbeCodMod, True, True);
end;

procedure TfrmCadVeiculos.dbeCodMotKeyPress(Sender: TObject; var Key: Char);
  Var
    arrMot: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE MOTORISTAS *}
  {****************************RV*}
  If fPesqMotorista(Self, dbeCodMot, edtNomMot, Nil, Key, arrMot) Then
  Begin
    If fValidaCampos(dbeCodMot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadVeiculos.dbeQuantidadeEixoEnter(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeQuantidadeEixo.Text) Then
    dbeQuantidadeEixo.Text := IntToStr(0);
end;

procedure TfrmCadVeiculos.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadVeiculos.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadVeiculos.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    If fEmptyStr(dbeCodMot.Text) Then
      dbeCodMot.Field.Value := null;

    If (qryTabela.State In [dsInsert]) And chkZeroKm.Checked Then
      qryTabela.FieldByName('VEI_PLAVEI').AsString := fProximoVeiculoZeroKm;

    If (qryTabela.State In [dsEdit]) Then
    begin
      if dbeParticipaIntegracaoQualP.Text = 'N' then
      begin
        qryTabela.FieldByName('VEI_TIPVEI').AsString := '';
        qryTabela.FieldByName('VEI_TIPCMB').AsString := '';
        qryTabela.FieldByName('VEI_TIPAFR').AsString := '';
      end;
    end;

    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadVeiculos.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  begin
    fCommit;

    if Assigned(objRomFusTarefas) then
    begin
      objRomFusTarefas.pProcessarTarefas;
      pCarregaRegistroAntesAlteracao;
    end;
  end
  Else
    fRollBack;
end;

procedure TfrmCadVeiculos.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pSetFocus(dbePlaVei);
  chkZeroKm.Enabled := (qryTabela.State In [dsInsert]);
  dbeCapCar.Text    := IntToStr(0);

  If chkZeroKm.Enabled Then
    chkZeroKm.Field.AsString := 'N';

  chkVeiculoAtivo.Field.AsString := 'A';
  chkReboque.Field.AsString := 'N';
  cmbTipoRodado.Field.AsString := '06 - Outros';

  if gbxIntegracaoQualp.Visible then
  begin
    dbeParticipaIntegracaoQualP.Field.AsString := 'N';
    fValidaCampos(dbeParticipaIntegracaoQualP);
  end;

  chkReboqueClick(Sender);

end;

end.
