unit untConsertoEquipAprovacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, StrUtils, untFuncFat, Uni, UniClientDataSet,
  untConsertoEquipamento;

type
  TfrmConsertoEquipAprovacao = class(TfrmPai)
    pnlPrincipal: TPanel;
    lblAprPor: TLabel;
    lblNumPed: TLabel;
    edtAprPor: TEditFocus;
    edtNumPed: TEditFocus;
    btnConfirma: TBitBtnLocked;
    rdgTipoAprov: TRadioGroup;
    pnlDigitador: TPanel;
    lblDigita: TLabel;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    btnPedCmp: TBitBtnLocked;
    pnlEmpFat: TPanel;
    lblEmpFat: TLabel;
    edtCodEmpFat: TEditFocus;
    edtDesEmpFat: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnPedCmpClick(Sender: TObject);
  private
    { Private declarations }
    FobjfatVenda: TFatVenda;
    qryConOpe: TUniQuery;
    function fValidaTipoAprovacao : Boolean;
    procedure pCarregaDigitador;
    procedure pSelecionaTpAprovacao;
    function fValidaAprovacaoCortesia: Boolean;
    function fValidaAprovacaoGarantia : Boolean;
    procedure pCarregaTipoAprovacao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    intTipApr: Integer;
    blnAprova,
    blnFluPro,
    blnTipAprEsp,
    blnNegoci: Boolean;
    strAprPor,
    strNumPed,
    strGarant,
    strCodOpe,
    strSenDig,
    strCodCli: String;
    objConEqu: TConEqu;
    cdsIteNeg: TUniClientDataSet;
    property objfatVenda: TFatVenda read FobjfatVenda write FobjfatVenda;
  end;

const
  arrSubStatusAprova: Array [1..2] Of String = ('APROVADO CLIENTE','APROVADO GARANTIA');

implementation

{$R *.dfm}

uses untFuncoesSimples, untPesqAux, untFatDigPedidoCompraItens, untLiberacao;

procedure TfrmConsertoEquipAprovacao.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if fCfgSis('PROKIT', varBoolean) and  not(fValidaTipoAprovacao) then
    Exit;

  if not fVerificaCampos then
    Exit;

  if (not fValidaAprovacaoCortesia) then
    Exit;

  if (not fValidaAprovacaoGarantia) then
    Exit;

  If (Not fEmptyStr(edtNumPed.Text)) And (StrToInt64(edtNumPed.Text) > 0) Then
    strNumPed := edtNumPed.Text
  Else
    strNumPed := '';

  if (strGarant = 'N') or (not blnTipAprEsp) then
    intTipApr := rdgTipoAprov.ItemIndex + 1
  else
    intTipApr := rdgTipoAprov.ItemIndex + 2;

  strAprPor := edtAprPor.Text;
  strSenDig := edtSenDig.Text;

  btnSair.Click();
end;

procedure TfrmConsertoEquipAprovacao.btnPedCmpClick(Sender: TObject);
var
  cdsVenda: TUniClientDataSet;
begin
  try
    try
      cdsVenda := fCriaTemporaria(Self);

      if (not blnNegoci) then
      begin
        objConEqu.cdsIteEqu.DisableControls;
        objConEqu.cdsIteEqu.First;

        while (not objConEqu.cdsIteEqu.Eof) Do
        begin
          cdsVenda.Insert;
          cdsVenda.FieldByName('AUTOINCREM').AsInteger := objConEqu.cdsIteEqu.FieldByName('SEQITE').AsInteger;
          cdsVenda.FieldByName('ITE_CODITE').AsString := objConEqu.cdsIteEqu.FieldByName('CODITE').AsString;
          cdsVenda.FieldByName('ITE_DESITE').AsString := objConEqu.cdsIteEqu.FieldByName('DESITE').AsString;
          cdsVenda.FieldByName('ITE_CODUNI').AsString := objConEqu.cdsIteEqu.FieldByName('UNIDAD').AsString;
          cdsVenda.FieldByName('ITE_QTDITE').AsFloat  := objConEqu.cdsIteEqu.FieldByName('QTDITE').AsFloat;
          cdsVenda.FieldByName('ITE_UNITAR').AsFloat  := objConEqu.cdsIteEqu.FieldByName('UNITAR').AsFloat;
          cdsVenda.FieldByName('ITE_TOTITE').AsFloat  := objConEqu.cdsIteEqu.FieldByName('TOTITE').AsFloat;
          cdsVenda.FieldByName('ITE_NUMCMP').AsString := objConEqu.cdsIteEqu.FieldByName('NUMCMP').AsString;
          cdsVenda.FieldByName('ITE_NITCMP').AsString := objConEqu.cdsIteEqu.FieldByName('NITCMP').AsString;

          if (objConEqu.cdsIteEqu.FieldByName('DTACMP').AsDateTime <> 0) then
            cdsVenda.FieldByName('ITE_DTACMP').AsDateTime := objConEqu.cdsIteEqu.FieldByName('DTACMP').AsDateTime;

          cdsVenda.Post;

          objConEqu.cdsIteEqu.Next;
        end;

        objConEqu.cdsIteEqu.EnableControls;

        pCriarFormularios(TfrmFatDigPedidoCompraItens, frmFatDigPedidoCompraItens);
        frmFatDigPedidoCompraItens.cdsDados.Data := cdsVenda.Data;
        frmFatDigPedidoCompraItens.strCodCli     := objConEqu.strCodCli;
        frmFatDigPedidoCompraItens.strCodVen     := objConEqu.strCodVen;
        frmFatDigPedidoCompraItens.strNumDoc     := objConEqu.strNumPed;
        frmFatDigPedidoCompraItens.strEspDoc     := 'PD';
        frmFatDigPedidoCompraItens.strCodEmp     := objConEqu.strEmpPed;

        if (frmFatDigPedidoCompraItens.ShowModal = mrOK) then
        begin
          frmFatDigPedidoCompraItens.cdsDados.First;

          while not frmFatDigPedidoCompraItens.cdsDados.Eof do
          begin
            if objConEqu.cdsIteEqu.Locate('CODITE;SEQITE',
              VarArrayOf([frmFatDigPedidoCompraItens.cdsDados.FieldByName('ITE_CODITE').AsString,
                          frmFatDigPedidoCompraItens.cdsDados.FieldByName('AUTOINCREM').AsString]), []) then
            begin
              objConEqu.cdsIteEqu.Edit;
              objConEqu.cdsIteEqu.FieldByName('NUMCMP').AsString := frmFatDigPedidoCompraItens.cdsDados.FieldByName('ITE_NUMCMP').AsString;
              objConEqu.cdsIteEqu.FieldByName('NITCMP').AsString := frmFatDigPedidoCompraItens.cdsDados.FieldByName('ITE_NITCMP').AsString;
              objConEqu.cdsIteEqu.FieldByName('DTACMP').AsDateTime := frmFatDigPedidoCompraItens.cdsDados.FieldByName('ITE_DTACMP').AsDateTime;
              objConEqu.cdsIteEqu.Post;
            end;

            frmFatDigPedidoCompraItens.cdsDados.Next;
          end;
        end;
      end
      else
      begin
        cdsIteNeg.First;

        while (not cdsIteNeg.Eof) Do
        begin
          cdsVenda.Insert;
          cdsVenda.FieldByName('ITE_SEQGER').AsString := cdsIteNeg.FieldByName('SEQGER').AsString;
          cdsVenda.FieldByName('ITE_SEQDET').AsString := cdsIteNeg.FieldByName('AUTINC').AsString;
          cdsVenda.FieldByName('ITE_CODITE').AsString := cdsIteNeg.FieldByName('CODITE').AsString;
          cdsVenda.FieldByName('ITE_DESITE').AsString := cdsIteNeg.FieldByName('DESITE').AsString;
          cdsVenda.FieldByName('ITE_CODUNI').AsString := cdsIteNeg.FieldByName('UNIDAD').AsString;
          cdsVenda.FieldByName('ITE_QTDITE').AsFloat  := cdsIteNeg.FieldByName('QTDITE').AsFloat;
          cdsVenda.FieldByName('ITE_UNITAR').AsFloat  := cdsIteNeg.FieldByName('UNITAR').AsFloat;
          cdsVenda.FieldByName('ITE_TOTITE').AsFloat  := cdsIteNeg.FieldByName('TOTITE').AsFloat;
          cdsVenda.FieldByName('ITE_NUMCMP').AsString := cdsIteNeg.FieldByName('NUMCMP').AsString;
          cdsVenda.FieldByName('ITE_NITCMP').AsString := cdsIteNeg.FieldByName('NITCMP').AsString;

          if (cdsIteNeg.FieldByName('DTACMP').AsDateTime <> 0) then
            cdsVenda.FieldByName('ITE_DTACMP').AsDateTime := cdsIteNeg.FieldByName('DTACMP').AsDateTime;

          cdsVenda.Post;

          cdsIteNeg.Next;
        end;

        pCriarFormularios(TfrmFatDigPedidoCompraItens, frmFatDigPedidoCompraItens);
        frmFatDigPedidoCompraItens.cdsDados.Data := cdsVenda.Data;
        frmFatDigPedidoCompraItens.strCodCli     := strCodCli;
        frmFatDigPedidoCompraItens.strCodVen     := strLoginUsuarioLogado;

        if (frmFatDigPedidoCompraItens.ShowModal = mrOK) then
        begin
          frmFatDigPedidoCompraItens.cdsDados.First;

          while not frmFatDigPedidoCompraItens.cdsDados.Eof do
          begin
            if cdsIteNeg.Locate('SEQGER;AUTINC', VarArrayOf([frmFatDigPedidoCompraItens.cdsDados.FieldByName('ITE_SEQGER').AsString,
                                                             frmFatDigPedidoCompraItens.cdsDados.FieldByName('ITE_SEQDET').AsString]), []) Then
            begin
              cdsIteNeg.Edit;
              cdsIteNeg.FieldByName('NUMCMP').AsString := frmFatDigPedidoCompraItens.cdsDados.FieldByName('ITE_NUMCMP').AsString;
              cdsIteNeg.FieldByName('NITCMP').AsString := frmFatDigPedidoCompraItens.cdsDados.FieldByName('ITE_NITCMP').AsString;
              cdsIteNeg.FieldByName('DTACMP').AsDateTime := frmFatDigPedidoCompraItens.cdsDados.FieldByName('ITE_DTACMP').AsDateTime;
              cdsIteNeg.Post;
            end;

            frmFatDigPedidoCompraItens.cdsDados.Next;
          end;
        end;
      end;
    except
      On E: Exception Do
        pMensagensErro(E.Message, 'TfrmConsertoEquipAprovacao.btnPedCmpClick');
    end;
  finally
    pFreeAndNil(frmFatDigPedidoCompraItens);
    FreeAndNil(cdsVenda);
  end;
end;

procedure TfrmConsertoEquipAprovacao.FormCreate(Sender: TObject);
begin
  inherited;

  blnAprova := False;
  blnTipAprEsp := False;
  blnNegoci := False;
  intTipApr := 0;
  strAprPor := '';
  strNumPed := '';
  strCodOpe := '';
  strSenDig := '';
  strCodCli := '';

  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
end;

procedure TfrmConsertoEquipAprovacao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryConOpe);
end;

procedure TfrmConsertoEquipAprovacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_RETURN) And Assigned(ActiveControl) And Assigned(ActiveControl.Parent) And
     (ActiveControl Is TRadioGroup) Then
    Self.SelectNext(ActiveControl, True, True)
  Else If (Key = VK_ESCAPE) Then
    pEscapePressed;
end;

procedure TfrmConsertoEquipAprovacao.FormShow(Sender: TObject);
begin
  inherited;

  pCarregaTipoAprovacao;

  edtAprPor.Text := strAprPor;
  edtNumPed.Text := strNumPed;

  pSetFocus(rdgTipoAprov);

  pSelecionaTpAprovacao;

  pnlEmpFat.Visible := fCfgSis('FATSSA', varBoolean);
  If Not pnlEmpFat.Visible Then
    Self.Height := Self.Height - pnlEmpFat.Height;

  If pnlEmpFat.Visible Then
  Begin
    If fRetCgcCpf(Self.strCodCli).Length > 11 Then
      edtCodEmpFat.Text := fCfgSis('SSAEPJ')
    Else
      edtCodEmpFat.Text := fCfgSis('SSAEPF');

    If Not fEmptyStr(edtCodEmpFat.Text) Then
      edtDesEmpFat.Text := fRetNomeEmpresa(edtCodEmpFat.Text);
  End;

  if ((not blnFluPro) and (not blnNegoci)) or (not fCfgSis('USADIG', varBoolean)) then
  begin
    Self.Height := Self.Height - pnlDigitador.Height;
    pnlDigitador.Visible := False;
  end
  else
    pSetFocus(edtSenDig);
end;

function TfrmConsertoEquipAprovacao.fValidaAprovacaoCortesia: Boolean;
var
  objLiberacao: TLiberacao;
begin
  Result := True;

  if (rdgTipoAprov.ItemIndex <> rdgTipoAprov.Items.IndexOf('APROVADO CORTESIA')) then
    Exit;

  if fVerificaAcessoSistema('APROSC') then
    Exit;

  objLiberacao := TLiberacao.Create;

  try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir aprovar OS em cortesia');
    objLiberacao.objMsgLibera.pAddSeparador(75);
    objLiberacao.objMsgLibera.pAddTextoCaption('O.S'               , objConEqu.strNumero + '-' + objConEqu.strCodEmp                      , 24);
    objLiberacao.objMsgLibera.pAddTextoCaption('Equipamento'       , objConEqu.strCodEqu + '-' + fRetNomEquipamentoOS(objConEqu.strCodEqu), 24);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Orçamento', FormatFloat('#,##0.00', objConEqu.fltVlrCon)                         , 19);

    objLiberacao.strDirAce := 'APROSC';
    objLiberacao.strMsgSen := 'Permitir aprovar OS em cortesia';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCliente := objConEqu.strCodCli + '-' + fRetNomCliente(objConEqu.strCodCli);
    objLiberacao.strCpfCnpj := objConEqu.strCliCgc;

    Result := objLiberacao.fLibera;
  finally
    FreeAndNil(objLiberacao);
  end;
end;

function TfrmConsertoEquipAprovacao.fValidaAprovacaoGarantia: Boolean;
var
  LLiberacao : TLiberacao;
begin
  Result := True;

  If rdgTipoAprov.ItemIndex <> rdgTipoAprov.Items.IndexOf('APROVADO GARANTIA') Then
    Exit;

  If fVerificaAcessoSistema('PAOSEG') Then
    Exit;

  LLiberacao := TLiberacao.Create;

  Try
    LLiberacao.Clear;
    LLiberacao.objMsgLibera.pAddTexto('Permitir aprovar OS em Garantia');
    LLiberacao.objMsgLibera.pAddSeparador(75);
    LLiberacao.objMsgLibera.pAddTextoCaption('OS'                , objConEqu.strNumero + '-' + objConEqu.strCodEmp                      , 24);
    LLiberacao.objMsgLibera.pAddTextoCaption('Cliente'           , objConEqu.strCodCli + '-' + fRetNomCliente(objConEqu.strCodCli)      , 24);
    LLiberacao.objMsgLibera.pAddTextoCaption('Equipamento'       , objConEqu.strCodEqu + '-' + fRetNomEquipamentoOS(objConEqu.strCodEqu), 24);
    LLiberacao.objMsgLibera.pAddTextoCaption('Valor do Orçamento', FormatFloat('R$ #,##0.00', objConEqu.fltVlrCon)                      , 24);

    LLiberacao.strDirAce  := 'PAOSEG';
    LLiberacao.strMsgSen  := 'Permitir aprovar OS em Garantia';
    LLiberacao.strCodOpe  := strLoginUsuarioLogado;
    Result := LLiberacao.fLibera;
  Finally
    FreeAndNil(LLiberacao);
  End;
end;

function TfrmConsertoEquipAprovacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Not (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Exit;

  if (Sender = edtSenDig) and (pnlDigitador.Visible) then
  begin
    if fEmptyStr(edtSenDig.Text) then
    begin
      fMensagem('ATENÇÃO!', 'O digitador deve ser preenchido!', ['&Ok']);
      Result := False;
    end
    else
    begin
      pCarregaDigitador;

      if qryConOpe.FieldByName('OPE_CODOPE').IsNull then
      begin
        fMensagem('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&Ok']);
        Result := False;
      end
      else If qryConOpe.FieldByName('OPE_STATUS').AsString <> 'A' then
      begin
        fMensagem('ATENÇÃO!', 'Digitador está inativo!', ['&Ok']);
        Result := False;
      end;
    end;
  end

  Else If (Sender = edtCodEmpFat) And pnlEmpFat.Visible Then
  Begin
    edtDesEmpFat.Text := fRetNomeEmpresa(edtCodEmpFat.Text);

    If Not fEmptyStr(edtCodEmpFat.Text) Then
    Begin
      If fEmptyStr(edtDesEmpFat.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'A Empresa de Faturamento deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End;

  If Not (Result) Then
    pSetFocus(Sender);
end;

function TfrmConsertoEquipAprovacao.fValidaTipoAprovacao: Boolean;
  var
    LblnPossuiBrinde : Boolean;
begin
  Result := True;

  if rdgTipoAprov.ItemIndex = 2 then
  Begin
    LblnPossuiBrinde := FobjfatVenda.fPossuiBrindeProduto;

    if not LblnPossuiBrinde  then
      LblnPossuiBrinde := FobjfatVenda.fPossuiBrindeServico;

    if LblnPossuiBrinde then
    Begin
      fMensagem('ATENÇÃO!', 'Foram adicionados itens como brinde e neste caso não é permitido finalizar '+
        'a ordem de serviço como "Aprovado Cortesia". Altere o tipo do item ou escolha outro tipo de Aprovação!', ['&Ok']);
      Result := False;
    End;
  End;
end;

procedure TfrmConsertoEquipAprovacao.pCarregaDigitador;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, edtSenDig.Text, True);
  edtNomDig.Text := qryConOpe.FieldByName('OPE_NOMOPE').AsString;
  strCodOpe := qryConOpe.FieldByName('OPE_CODOPE').AsString;
end;

procedure TfrmConsertoEquipAprovacao.pCarregaTipoAprovacao;
var
  intCont: Integer;
begin
  rdgTipoAprov.Items.Clear();

  if (strGarant = 'N') and (blnTipAprEsp) then
    rdgTipoAprov.Items.Add('APROVADO CLIENTE')
  else if (strGarant <> 'N') and (blnTipAprEsp) then
  begin
    rdgTipoAprov.Items.Add('APROVADO GARANTIA');

    if (blnAprova) and (fCfgSis('BONPED', varBoolean)) then
      rdgTipoAprov.Items.Add('APROVADO CORTESIA');
  end
  else
  begin
    for intCont := 1 to Length(arrSubStatusAprova) do
      rdgTipoAprov.Items.Add(arrSubStatusAprova[intCont]);

    if (blnAprova) and (fCfgSis('BONPED', varBoolean)) then
      rdgTipoAprov.Items.Add('APROVADO CORTESIA');
  end;

  rdgTipoAprov.Columns := rdgTipoAprov.Items.Count;
end;

procedure TfrmConsertoEquipAprovacao.pSelecionaTpAprovacao;
begin
  case AnsiIndexStr(strGarant, ['N', 'L', 'F', 'R']) of
    0: rdgTipoAprov.ItemIndex := 0;
    1:
      begin
        if blnTipAprEsp then
        begin
          rdgTipoAprov.ItemIndex := 0;
          if (blnAprova) And (fCfgSis('BONPED', varBoolean)) then
            rdgTipoAprov.ItemIndex := 1;
        end
        else
        begin
          rdgTipoAprov.ItemIndex := 1;
          if (blnAprova) And (fCfgSis('BONPED', varBoolean)) then
            rdgTipoAprov.ItemIndex := 2;
        end;
      end;
    2, 3:
      begin
        if blnTipAprEsp then
          rdgTipoAprov.ItemIndex := 0
        else
          rdgTipoAprov.ItemIndex := 1;
      end;
  end;
end;

end.
