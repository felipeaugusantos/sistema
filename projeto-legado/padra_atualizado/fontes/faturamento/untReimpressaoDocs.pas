unit untReimpressaoDocs;

interface                           

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, DB, StrUtils, untReimpressao,untTReimpressaoGA, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, untConstantes,
  untTypesSistema;

Type
  TReimpressaoDocGarantia = untTReimpressaoGA.TReimpressaoDocGarantia;

type
  TfrmReimpressaoDocs = class(TfrmPai)
    pnlFundo: TPanel;
    btnImprimir: TBitBtnLocked;
    pnlFiltrosPadrao: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    lblNumCoo: TLabel;
    edtNumCoo: TEditFocus;
    edtSerieDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtNumDoc: TEditFocus;
    Label12: TLabel;
    mskDtaIni: TMaskEditFocus;
    lblDesDtaIni: TLabel;
    Label11: TLabel;
    mskDtaFin: TMaskEditFocus;
    lblDesDtaFin: TLabel;
    rdgCliFor: TRadioGroup;
    rgpNotasFiscais: TRadioGroup;
    pnlBtnCliente: TPanel;
    pnlFiltrosRodape: TPanel;
    lblCliFor: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label3: TLabel;
    shpLiberado: TShape;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    chkDocCan: TCheckBox;
    btnCliOutroVendedor: TBitBtnLocked;
    pnlCabecalho: TPanel;
    lblEmpresa: TLabel;
    lblVeiculo: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    mskPlaVei: TMaskEditFocus;
    edtDesVeiculo: TEditFocus;
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure pCarregaEmpresa;
    procedure edtEspDocChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgCliForClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure btnCliOutroVendedorClick(Sender: TObject);
    procedure btnSairExit(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
  private
    { Private declarations }
    strTip_FC: String;
    reiReimpressao: TReimpressao;
    FTipoConsCli : TTipoConsCli;
    blnBloquCpfCnpj: Boolean;
    strCodCliAnt: String;
    FReimpressaoDocGarantia: TReimpressaoDocGarantia;
    blnReimpressaoGA: Boolean;
    procedure pCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure pCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure pInformarClienteOutroVendedor(const strCodCli: String = '');
    procedure pCarregarCliente;
    procedure pConfigurarModoImpressaoGA;

  public
    { Public declarations }
    blnFaturamento: Boolean;
    blnLiberado   : Boolean;
    strCodVen     : String;
    procedure pSetReimpressaoDocGarantia(pReimpressaoDocGarantia: TReimpressaoDocGarantia);
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

uses untfuncoesSimples, untConsultas, untReimpressaoDocsList, untFatDigCnpj,
  untLiberacao;

{$R *.dfm}

procedure TfrmReimpressaoDocs.edtCodEmpresaExit(Sender: TObject);
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

procedure TfrmReimpressaoDocs.edtCodEmpresaKeyPress(Sender: TObject;
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

procedure TfrmReimpressaoDocs.pCarregaEmpresa;
Begin
  If Not (fEmptyStr(edtCodEmpresa.Text)) Then
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text)
  Else
    edtDesEmpresa.Text := '';
End;

procedure TfrmReimpressaoDocs.pCarregarCliente;
begin
  If fEmptyStr(edtCodCliente.Text) and (Not blnReimpressaoGA) Then
    edtDesCliente.Text := 'TODOS'
  Else
  Begin
    If rdgCliFor.ItemIndex = 0 Then
       edtDesCliente.Text := fRetNomCliente(edtCodCliente.Text)
    Else
       edtDesCliente.Text := fRetNomFornecedor(edtCodCliente.Text)
  End;
end;

procedure TfrmReimpressaoDocs.pCodClienteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes,
                  True, Nil, False, '', '', True, '', '', tfvReimprDocs) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmReimpressaoDocs.pCodFornecedorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmReimpressaoDocs.edtCodClienteExit(Sender: TObject);
begin
  inherited;

  fValidaCampos(edtCodCliente, True);

end;

procedure TfrmReimpressaoDocs.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If rdgCliFor.ItemIndex = 0 Then
    pCodClienteKeyPress(Sender, Key)
  Else
    pCodFornecedorKeyPress(Sender, Key);

end;

procedure TfrmReimpressaoDocs.pCarregaCliente(Var qryCadCli: TUniQuery);
Begin
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';

End;

procedure TfrmReimpressaoDocs.edtCodVendedorExit(Sender: TObject);
begin
  inherited;

  If (blnLiberado) Then
    strCodVen := edtCodVendedor.Text
  Else
  Begin
    strCodVen := fRetCodVendedor(edtCodVendedor.Text);
    If (fEmptyStr(strCodVen)) And (Not fEmptyStr(edtCodVendedor.Text)) Then
    Begin
      fMensagem('AVISO','Vendedor não encontrado.', ['&O K']);
      edtCodVendedor.Clear;
      pSetFocus(edtCodVendedor);
      edtDesVendedor.Clear;
      Exit;
    End;
  End;

  If fEmptyStr(edtCodVendedor.Text) Then
    edtDesVendedor.Text := 'TODOS'
  Else
    edtDesVendedor.Text := fRetNomVendRep(strCodVen);

  If fEmptyStr(edtDesVendedor.Text) And (Not fEmptyStr(strCodVen))  Then
  Begin
    fMensagem('AVISO','Código do vendedor não encontrado.', ['&O K']);
    edtCodVendedor.Clear;
    pSetFocus(edtCodVendedor);
  End;

end;

procedure TfrmReimpressaoDocs.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  If (blnLiberado) And
     (fPesqOperador(Self, edtCodVendedor, edtDesVendedor, qryTabela, Key, arrSel))  Then
  Begin
    If fValidaCampos(edtCodVendedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmReimpressaoDocs.FormShow(Sender: TObject);
begin
  strTip_FC := 'C';

  // SENHA PARA VENDEDOR - REIMPRESSÃO DE DOCUMENTOS
  blnLiberado := fVerificaAcessoSistema('RIMPDC');

  If (Not blnLiberado) Then
  Begin
    edtCodVendedor.MaxLength := 10;
    edtCodVendedor.TamCampo  := 0;
    edtCodVendedor.CompZeros := False;
    edtCodVendedor.PasswordChar := '*';
    edtCodVendedor.TipoTexto := ttAlfanumerico;
    shpLiberado.Brush.Color  := clRed;
  End
  Else
    shpLiberado.Brush.Color  := clGreen;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtCodEmpresaExit(Sender);
  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := fTamDocCadRec;

  mskPlaVei.Visible     := fCfgSis('AUTCEN', varBoolean);
  lblVeiculo.Visible    := mskPlaVei.Visible;
  edtDesVeiculo.Visible := mskPlaVei.Visible;
  if (not mskPlaVei.Visible) then
  begin
    pnlCabecalho.Height := pnlCabecalho.Height -38;
    Self.Height := Self.Height - 38;
  end;

  FTipoConsCli := fStrToTipoConsCli( fCfgSis('CNSCRE', varString) );

  If FTipoConsCli = tpTodosCli Then
  Begin
    pnlBtnCliente.Visible := False;
    Self.Height := Self.Height - pnlBtnCliente.Height;
  End;

  blnBloquCpfCnpj := (FTipoConsCli = tpLibCliVenLog);

  inherited;

  if blnReimpressaoGA then
    pConfigurarModoImpressaoGA;
end;

function TfrmReimpressaoDocs.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
var
  blnLiberarTrava: Boolean;
  strCodVen: String;
  blnConsumidor: Boolean;
  blnTravaCli: Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {***********************}
    {* VALIDA DATA INICIAL *}
    {********************AF*}
    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        mskDtaIni.Text := DateToStr(VS_Date);
      End;
    End
    {*********************}
    {* VALIDA DATA FINAL *}
    {******************AF*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
        mskDtaFin.Text := DateToStr(VS_Date);
      End
      Else
      If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!','A data inicial deve ser menor que a data final!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtEspDoc) and edtEspDoc.visible Then
    Begin
      {*********************************************}
      {* COMENTADO A PEDIDO DO MÁRIO EM 16/01/2013 *}
      {******************************************PZ*}
      {If edtEspDoc.Text = 'PR' Then
      Begin
        fMensagem('ATENÇÃO!', 'Espécie "PR" não permitido na reimpressão', ['&O k']);
        Result := False;
      End
      Else
      Begin}
        If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtEspDoc.Text)) And blnValidaIndividual Then
        Begin
          If (blnLiberado) Then
            btnImprimirClick(Sender)
          Else If (edtCodVendedor.CanFocus) Then
          Begin
            pSetFocus(edtCodVendedor);
            blnMudarFoco := False;
          End;
        End;
      //End;

      edtNumCoo.Visible := Result And (edtEspDoc.Text = 'IF');
      lblNumCoo.Visible := Result And (edtEspDoc.Text = 'IF');

    End

    Else If (Sender = edtNumDoc) Then
    Begin

      If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtEspDoc.Text)) And blnValidaIndividual Then
      Begin
        If (blnLiberado) Then
          btnImprimirClick(Sender)
        Else If (edtCodVendedor.CanFocus) Then
        Begin
          pSetFocus(edtCodVendedor);
          blnMudarFoco := False;
        End;

      End;

    End

    {************************************}
    {* VALIDA VENDEDOR                  *}
    {*********************************LU*}
    Else If (Sender = edtCodVendedor) and edtCodVendedor.visible Then
    Begin

      If (Not blnLiberado) Then
      Begin
        If (fEmptyStr(edtCodVendedor.Text)) Then
        Begin
          fMensagem('', 'O vendedor deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          strCodVen := fRetCodVendedor(edtCodVendedor.Text);
          If (fEmptyStr(strCodVen)) And (Not fEmptyStr(edtCodVendedor.Text)) Then
          Begin
            fMensagem('AVISO','Vendedor não encontrado.', ['&O K']);
            Result := False;
          End;
        End;
      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpReimpressaoDocs) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
          Result := False;
        End;
      End;
    End

    else if (Sender = mskPlaVei) and (mskPlaVei.Visible) then
    begin
      if (fEmptyStr(mskPlaVei.Text)) then
      begin
        edtDesVeiculo.Clear;
      end
      else
      if (fValidaPlaca(mskPlaVei.Text)) then
      begin
        edtDesVeiculo.Text := fRetornaDescricaoVeic(mskPlaVei.Text);
        if (fEmptyStr(edtDesVeiculo.Text)) then
        begin
          fMensagem('ATENÇÃO!', 'Veículo não está cadastrado.', ['&O k']);
          Result := False;
        end
        else
        if (not fEmptyStr(edtCodCliente.Text)) and (not fVeiculoRelacionadoAoCliente(mskPlaVei.Text, edtCodCliente.Text))
           and (not fClienteConsumidor(fRetNomCliente(edtCodCliente.Text), True, True)) then
        begin
          fMensagem('ATENÇÃO!', 'Este veículo não está cadastrado para este cliente.', ['&O k']);
          Result := False;
        end;
      end
      else
      begin
        fMensagem('ATENÇÃO!','Informe uma placa válida!',['&Ok']);
        Result := False;
      end;
    end

    Else If (Sender = edtCodCliente) Then
    Begin
      blnBloquCpfCnpj := IIF((strCodCliAnt <> edtCodCliente.Text) And (FTipoConsCli = tpLibCliVenLog), True, blnBloquCpfCnpj);
      blnConsumidor := fClienteConsumidor(edtDesCliente.Text);
      blnTravaCli := (fTravaCampoOutroVendedor(edtCodCliente.Text, strCodVen)) And (Pos(strCodVen, fGetVendedoresGerentesOrSUBGerentes()) <= 0);

      if blnReimpressaoGA then
        blnLiberarTrava := True
      else
        blnLiberarTrava := blnConsumidor or (FTipoConsCli = tpTodosCli) or ((Not blnBloquCpfCnpj) And (FTipoConsCli = tpLibCliVenLog)) or (fEmptyStr(edtCodCliente.Text)) or (Not blnTravaCli);

      If Not blnLiberarTrava Then
      Begin
        Result := False;
        fMensagem('AVISO','Não é permitido utilizar clientes de outros vendedores (CFG_CNSCRE). ' +
                           'Informe o CPF/CNPJ através do botão "Cliente de outro vendedor".', ['&O K']);
        edtCodCliente.Clear;
      End
      Else
      Begin
        pCarregarCliente;

        If fEmptyStr(edtDesCliente.Text) And  (Not fEmptyStr(edtCodCliente.Text)) And (Not blnReimpressaoGA )  Then
        Begin
          If (rdgCliFor.ItemIndex = 0) or (Not rdgCliFor.visible) Then
            fMensagem('AVISO','Código do cliente não encontrado.', ['&O K'])
          Else
            fMensagem('AVISO','Código do Fornecedor não encontrado.', ['&O K']);

          Result := False;
          edtCodCliente.Clear;
        End;
      End;
      strCodCliAnt := edtCodCliente.Text;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmReimpressaoDocs.mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrVei: TConsultasArray;
begin
  inherited;

  If fPesqVeiculos(Self, mskPlaVei, edtDesVeiculo, Nil, Key, arrVei, True, False, ' VEI_STATUS = "A" ') Then
  Begin
    If fValidaCampos(mskPlaVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmReimpressaoDocs.btnCliOutroVendedorClick(Sender: TObject);
begin
  inherited;

  pInformarClienteOutroVendedor;
end;


procedure TfrmReimpressaoDocs.pInformarClienteOutroVendedor(const strCodCli: String = '');
var
  frmFatDigCnpj: TfrmFatDigCnpj;
  strCodVen: String;
  blnTrava: Boolean;
  strCodCliTmp: String;
  blnLiberado: Boolean;
  objLiberacao: TLiberacao;
begin
  inherited;

  blnLiberado := False;
  pCriarFormularios(TfrmFatDigCnpj, frmFatDigCnpj);
  objLiberacao := TLiberacao.Create;
  Try

    repeat

      blnBloquCpfCnpj := btnCliOutroVendedor.Visible;

      frmFatDigCnpj.blnProspecto := False;
      frmFatDigCnpj.blnPermiteBranco := True;
      frmFatDigCnpj.blnFocarNumCpf := True;
      frmFatDigCnpj.blnListarClientes := True;
      frmFatDigCnpj.ShowModal();
      If (frmFatDigCnpj.ModalResult = MrOk) Then
      Begin
        strCodCliTmp := frmFatDigCnpj.strCodCli;

        If (fEmptyStr(frmFatDigCnpj.edtCgcCpf.Text)) Then
        Begin
          fMensagem('', 'O cnpj/cpf do cliente precisa ser informado!', ['&Ok']);
          pSetFocus(edtCodCliente);
          Exit;
        End;

        If (Not fEmptyStr(strCodCli)) And (strCodCli <> strCodCliTmp) Then
        Begin
          fMensagem('', 'O cnpj/cpf informado não pertence ao cliente selecionado!', ['&Ok']);
          pSetFocus(edtCodCliente);
          Exit;
        End;

        blnTrava := fTravaCampoOutroVendedor(strCodCliTmp, strCodVen);

        If blnTrava Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Reimpressão de Documentos - Permitir visualizar cliente de outro vendedor');
          objLiberacao.objMsgLibera.pAddTextoCaption('Cliente', strCodCliTmp + ' - ' + fRetNomCliente(strCodCliTmp));
          objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor cadastrado', strCodVen + '  - ' + fRetNomVendRep(strCodVen));
          objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor atual'     , strLoginUsuarioLogado + '  - ' + fRetNomVendRep(strLoginUsuarioLogado));

          objLiberacao.strDirAce := 'CNSCRE';
          objLiberacao.strMsgSen := 'Reimpressão de Documentos - Permitir visualizar cliente de outro vendedor';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;
          objLiberacao.strCodDig := strLoginUsuarioLogado;

          blnLiberado := objLiberacao.fLibera;
        End
        Else
        Begin
          blnLiberado := True;
        End;
      End;

    until blnLiberado or (frmFatDigCnpj.ModalResult <> MrOk);

    If blnLiberado And (frmFatDigCnpj.ModalResult = MrOk) Then
    Begin
      blnBloquCpfCnpj := False;
      edtCodCliente.Text := strCodCliTmp;
      strCodCliAnt := strCodCliTmp;
      fValidaCampos(edtCodCliente, True);
    End
    Else
    Begin
      edtCodCliente.Text := EmptyStr;
      pSetFocus(edtCodCliente);
    End;

  Finally
    pFreeAndNil(frmFatDigCnpj);
    FreeAndNil(objLiberacao);
  End;
end;

procedure TfrmReimpressaoDocs.btnImprimirClick(Sender: TObject);
  Var
    intFilCla: Integer;
    blnDocCan: Boolean;
    blnReabrir: Boolean;
    intRecNo: Integer;
begin
  inherited;
  intRecNo := -1;

  If Not fVerificaCampos Then
    Exit;

  If (Not blnLiberado) Then
  Begin
    If (fEmptyStr(edtCodVendedor.Text)) Then
    Begin
      fMensagem('', 'O vendedor deve ser preenchido!', ['&Ok']);
      If edtCodVendedor.Enabled Then
        pSetFocus(edtCodVendedor);
      Exit;
    End;
  End;

  Repeat
    btnImprimir.Enabled := False;

    If Not rgpNotasFiscais.Visible Then
      intFilCla := 0
    Else
      intFilCla := rgpNotasFiscais.ItemIndex;

    If chkDocCan.Checked Then
      blnDocCan := True
    Else
      blnDocCan := False;

    Try
      blnReabrir := False;

      if blnReimpressaoGA then
      begin
              reiReimpressao := TReimpressaoGA.Create(edtNumDoc.Text,
                                                      StrToDate(mskDtaIni.Text),
                                                      StrToDate(mskDtaFin.Text),
                                                      edtCodCliente.Text,
                                                      edtCodEmpresa.Text,
                                                      FReimpressaoDocGarantia);
      end

      else
      begin
        reiReimpressao := TReimpressao.Create(edtNumDoc.Text,
                                              edtEspDoc.Text,
                                              StrToDate(mskDtaIni.Text),
                                              StrToDate(mskDtaFin.Text),
                                              edtCodCliente.Text,
                                              edtCodEmpresa.Text,
                                              strCodVen,
                                              blnFaturamento,
                                              strTip_FC,
                                              True,
                                              False,
                                              False,
                                              IIf(edtEspDoc.Text = 'AJ', 'AJ', ''),
                                              edtSerieDoc.Text,
                                              True,
                                              intFilCla,
                                              blnDocCan,
                                              '',
                                              True,
                                              False,
                                              edtNumCoo.Text,
                                              mskPlaVei.Text);

      end;

      If Not reiReimpressao.objDocumentos.cdsDocumentos.IsEmpty Then
      Begin
        Try
          pCriarFormularios(TfrmReimpressaoDocsList, frmReimpressaoDocsList);
          if blnReimpressaoGA and  (FReimpressaoDocGarantia = TReimpressaoDocGarantia.trRetornoFornecedor) then
          begin
            frmReimpressaoDocsList.dbgDocumentos.Columns[11].Title.Caption := 'Fornecedor';
            frmReimpressaoDocsList.Label2.Visible := False;
            frmReimpressaoDocsList.lblEnvWpp.Visible := False;
          end
          else If (rdgCliFor.ItemIndex = 1)  Then
            frmReimpressaoDocsList.dbgDocumentos.Columns[9].Title.Caption := 'Fornecedor';

          frmReimpressaoDocsList.reiReimpressao := reiReimpressao;
          frmReimpressaoDocsList.intRecNo := intRecNo;
          frmReimpressaoDocsList.ShowModal;
          blnReabrir := frmReimpressaoDocsList.blnReabrir;
          intRecNo := frmReimpressaoDocsList.intRecNo;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[frmReimpressaoDocs.btnImprimirClick]');
          End;
        End;

        pFreeAndNil(frmReimpressaoDocsList);

      End
      Else
      Begin
        fMensagem('','Não há dados para gerar reimpressão!!!',['&O K']);

        If (Sender = edtNumDoc) Then
        Begin
          edtNumDoc.Clear;
        End;

      End;

    Finally
      If (Assigned(reiReimpressao)) Then
        FreeAndNil(reiReimpressao);
      btnImprimir.Enabled := True;
    End;
  Until Not blnReabrir;

end;

procedure TfrmReimpressaoDocs.edtEspDocChange(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtEspDoc.Text)) Then
  Begin
    mskDtaIni.Enabled      := False;
    mskDtaFin.Enabled      := False;
    edtCodCliente.Enabled  := False;

    If (blnLiberado) Then
      edtCodVendedor.Enabled := False
    Else
      edtCodVendedor.Enabled := True;
  End
  Else
  Begin
    mskDtaIni.Enabled      := True;
    mskDtaFin.Enabled      := True;
    edtCodCliente.Enabled  := True;
    edtCodVendedor.Enabled := True;
  End;

  If (Pos(edtEspDoc.Text, 'NF_EL_') > 0)  Then
    rgpNotasFiscais.Visible := True
  Else
    rgpNotasFiscais.Visible := False;

end;

procedure TfrmReimpressaoDocs.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodEmpresa);
end;

procedure TfrmReimpressaoDocs.FormCreate(Sender: TObject);
begin
  inherited;
  blnReimpressaoGa := False;
  blnFaturamento := False;
  strCodVen := '';
  mskPlaVei.EditMask := MASCARA_PLACA_VEICULO;
end;

procedure TfrmReimpressaoDocs.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If ActiveControl Is TRadioButton Then
  Begin

    Case Key Of
      VK_Escape: btnSair.Click;
      VK_Return: SelectNext(ActiveControl,True,True);
    End;

  End;

end;

procedure TfrmReimpressaoDocs.rdgCliForClick(Sender: TObject);
begin
  inherited;

  lblCliFor.Caption := rdgCliFor.Items[rdgCliFor.ItemIndex];

  If strTip_FC <> rdgCliFor.Items[rdgCliFor.ItemIndex][1] Then
  Begin
    edtCodCliente.Clear;
    edtDesCliente.Clear;
  End;

  strTip_FC := rdgCliFor.Items[rdgCliFor.ItemIndex][1];

  btnCliOutroVendedor.Enabled := rdgCliFor.ItemIndex = 0;

end;

procedure TfrmReimpressaoDocs.btnSairExit(Sender: TObject);
begin
  inherited;

  blnBloquCpfCnpj := False;
end;

procedure TfrmReimpressaoDocs.pConfigurarModoImpressaoGA;
begin
  self.Caption := 'Relatório de Reimpressão de Comprovantes';
  Self.Height := 310;
  pnlCabecalho.height := 47;
  pnlFiltrosRodape.height := 50;
  pnlBtnCliente.height := 0;
  pnlBtnCliente.visible  := false;


  Label1.Anchors := [akLeft, akTop];
  Label1.top := 0;

  edtNumDoc.Anchors := [akLeft, akTop];
  edtNumDoc.Top := 14;

  Label11.Anchors := [akLeft, akTop];
  Label11.top := 88;


  Label12.Anchors := [akLeft, akTop];
  Label12.Top := 44;

  mskDtaIni.anchors := [akLeft, akTop];
  mskDtaIni.Top := 57;

  mskDtaFin.anchors :=  [akLeft, akTop];
  mskDtaFin.Top := 105;

  lblDesDtaIni.anchors :=  [akLeft, akTop];
  lblDesDtaIni.top := 56;

  lblDesDtaFin.anchors :=  [akLeft, akTop];
  lblDesDtaFin.top := 105;

  lblCliFor.anchors := [akLeft, akTop];
  lblCliFor.Top := 3;


  edtCodCliente.anchors := [akLeft, akTop];
  edtCodCliente.top := 24;
  edtCodCliente.Tag := 99;

  edtDesCliente.anchors := [akLeft, akTop];
  edtDesCliente.top := 24;

  edtDesVeiculo.visible := False;
  mskPlaVei.visible := False;
  lblVeiculo.visible := False;

  rgpNotasFiscais.visible := False;
  rdgCliFor.visible := False;
  btnCliOutroVendedor.visible := false;

  edtSerieDoc.visible := False;
  edtEspDoc.visible := FAlse;
  edtNumCoo.visible := False;
  edtCodVendedor.Visible := False;
  edtDesVendedor.Visible := False;

  shpLiberado.visible := False;
  chkDocCan.visible := False;

  rdgCliFor.ItemIndex := 0;
  blnLiberado := True;

  Label1.Caption := 'Documento (Número GA)';
end;

procedure TfrmReimpressaoDocs.pSetReimpressaoDocGarantia(
  pReimpressaoDocGarantia: TReimpressaoDocGarantia);
begin
  FReimpressaoDocGarantia := pReimpressaoDocGarantia;
  blnReimpressaoGA := FReimpressaoDocGarantia in [TReimpressaoDocGarantia.trRecebimentoCliente, TReimpressaoDocGarantia.trRetornoFornecedor];
end;


end.

