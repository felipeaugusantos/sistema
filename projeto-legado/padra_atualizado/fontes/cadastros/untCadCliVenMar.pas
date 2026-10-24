unit untCadCliVenMar;

interface

uses
  Windows, Classes, Controls, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGrids, EditFocus, Uni, DB, AppEvnts, UniClientDataSet, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient, DBGridCitel, System.SysUtils,
  untTypesSistema, untGravando;

type
  TfrmCadCliVenMar = class(TfrmPai)
    pnlCabecalho: TPanel;
    dbgItens: TDBGridCitel;
    Panel1: TPanel;
    Label1: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    lbDesMar: TLabel;
    edtCodMar: TEditFocus;
    lblCliFor: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtDesMar: TEditFocus;
    cdsCliVen: TUniClientDataSet;
    dtsCliVen: TDataSource;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnLimparTodosRegs: TBitBtnLocked;
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure dbgItensEnter(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenEnter(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLimparTodosRegsClick(Sender: TObject);
    function fGetVendMarArraySel(arrVendMar: TConsultasArray; blnOmitirAspas: Boolean = False): String;
    procedure pInsereVendedorDoCliente;
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    intAutInc: Integer;
    arrVendedores : TConsultasArray;
    arrMarcas : TConsultasArray;
    FstrOpMarcaFornecedor : string;
    FrecInfo: TrecInfoMarcaFornecedor ;

    procedure pLimparCampos;
    procedure pHabilitaCab(blnHabilitar: Boolean);
    function fPesquisaMarcaFornecedor(const AstrCodigo: string): string ;
    procedure pInicializaClienteVendedor ;
    procedure pPesquisaMarcaFornecedor(var AstrKey: Char) ;
    function fVerificaRotinaForMarNaoPermitido(strCodForMar: String): Boolean;
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
//    fatVenda: TFatVenda;
  end;


implementation

uses Variants, Forms, untfuncoesSimples, untConsultas, untConstantes;

{$R *.dfm}

procedure TfrmCadCliVenMar.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If ( (edtCodVen.Text='') And (Not fEntraCons(Key)) And (Length(arrVendedores)=0) ) Then
  Begin
    edtNomVen.Text := 'TODOS';
  End
  Else
  Begin

    if fPesqOperador(Self, edtCodVen, edtNomVen, qryTabela, Key, arrSel, False) then
    Begin
      If Length(arrSel) = 1 Then
      Begin
        fValidaCampos(edtCodVen, True);
        Self.SelectNext(ActiveControl, True, True);

      End
      Else
      Begin
        edtCodVen.Text := '';
        edtNomVen.Text := fGetVendMarArraySel(arrSel, True);
        arrVendedores := arrSel;
      End;
    End;
  End;

end;

function TfrmCadCliVenMar.fPesquisaMarcaFornecedor(
  const AstrCodigo: string): string;
begin
  result := '' ;
  if FstrOpMarcaFornecedor = CODIGO_CLIENTE_VENDEDOR_MARCA then
  begin
    result := fRetNomMarca(AstrCodigo) ;
  end
  else if FstrOpMarcaFornecedor = CODIGO_CLIENTE_VENDEDOR_FORNECEDOR then
  begin
    result := fRetNomFornecedor(AstrCodigo) ;
  end;
end;

function TfrmCadCliVenMar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCodVen) Then
  Begin

    If Not fEmptyStr(edtCodVen.Text) Then
    Begin
      edtNomVen.Text := fRetNomVendRep(edtCodVen.Text);

      If fEmptyStr(edtNomVen.Text) Then
      Begin
        pMensagemOk('Vendedor não encontrado!');
        Result := False;
      End;
    End;

  End
  Else If (Sender = edtDesMar) Then
  Begin

    If Not fEmptyStr(edtCodMar.Text) Then
    Begin
      edtDesMar.Text := fPesquisaMarcaFornecedor(edtCodMar.Text);

      If fEmptyStr(edtDesMar.Text) Then
      Begin
        pMensagemOk(FrecInfo.strDescricao + ' não encontrado!');
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadCliVenMar.pEscapePressed;
begin
  inherited;

end;

procedure TfrmCadCliVenMar.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pInsereVendedorDoCliente, 'Aguarde, inserindo vendedores do cliente', '');
End;

procedure TfrmCadCliVenMar.pInicializaClienteVendedor;
var
  LclnColuna: TColumn ;
begin
  if FstrOpMarcaFornecedor = CODIGO_CLIENTE_VENDEDOR_FORNECEDOR then
  begin
    lbDesMar.Caption := 'Fornecedor' ;
    LclnColuna := fFindColumnByName(dbgItens,'MAR_DESMAR') ;
    if Assigned(LclnColuna) then
    begin
      LclnColuna.Title.Caption := 'Fornecedor' ;
      LclnColuna.FieldName := 'FOR_NOMFOR' ;
    end;
    edtCodMar.MaxLength := 8 ;
    edtCodMar.TamCampo := 8 ;
  end;
end;

procedure TfrmCadCliVenMar.pInsereVendedorDoCliente;
  Var
    strAutoincrem: String;
    qryAuxVen,
    qryAuxMar: TUniQuery;
begin

  strAutoincrem := '';

  If (fVerificaCampos) Then
  Begin
    If (btnAdicionar.Tag <> 0) Then
      strAutoincrem := cdsCliVen.FieldByName('AUTOINCREM').AsString;

    If cdsCliVen.Locate('CVE_CODVEN;'+FrecInfo.strFieldCodigoDestino, VarArrayOf([edtCodVen.Text, '']), []) And (fEmptyStr(edtDesMar.Text)) Then
    Begin

      fMensagem('', 'Vendedor cadastrado sem '+FrecInfo.strDescricao+' só pode ser informado uma vez!', ['&Ok']);
      pSetFocus(edtCodVen);

    End
    Else If cdsCliVen.Locate('CVE_CODVEN', edtCodVen.Text, []) And fEmptyStr(edtCodMar.Text) And (Not fEmptyStr(edtDesMar.Text)) Then
    Begin

      fMensagem('', 'Vendedor já cadastrado com ' + FrecInfo.strDescricao + ' informada!', ['&Ok']);
      pSetFocus(edtCodVen);

    End
    Else If cdsCliVen.Locate('CVE_CODVEN;'+FrecInfo.strFieldCodigoDestino, VarArrayOf([edtCodVen.Text, edtCodMar.Text]), []) And (Not fEmptyStr(edtDesMar.Text)) Then
    Begin

      fMensagem('', 'Vendedor e '+FrecInfo.strDescricao+' já cadastrados para este cliente!', ['&Ok']);
      pSetFocus(edtCodVen);

    End
    Else If (not fEmptyStr(edtCodMar.Text)) And (Not fVerificaRotinaForMarNaoPermitido(edtCodMar.Text)) Then
    Begin

      fMensagem('', FrecInfo.strDescricao+' já informado na rotina de Fornecedores e Marcas Não Permitidas para o Cliente!', ['&Ok']);
      pSetFocus(edtCodMar);

    End
    Else
    Begin

      If (Not fEmptyStr(edtCodVen.Text)) Then
      Begin
        If (btnAdicionar.Tag = 0) Then Begin
          cdsCliVen.Append;
          inc(intAutInc);
          strAutoincrem := fStrZero(intAutInc, 3);
          cdsCliVen.FieldByName('AUTOINCREM').AsString := strAutoincrem;
          cdsCliVen.FieldByName('CVE_CODCLI').AsString := edtCodCli.Text;
        End Else Begin
          cdsCliVen.Locate('AUTOINCREM', strAutoincrem, []);
          cdsCliVen.Edit;
        End;

        cdsCliVen.FieldByName('CVE_CODVEN').AsString := edtCodVen.Text;
        cdsCliVen.FieldByName('OPE_NOMOPE').AsString := edtNomVen.Text;

        If (Not fEmptyStr(edtCodMar.Text)) Then
        Begin
          cdsCliVen.FieldByName(FrecInfo.strFieldCodigoDestino).AsString := edtCodMar.Text;
          cdsCliVen.FieldByName(FrecInfo.strFieldNome).AsString := edtDesMar.Text;
          cdsCliVen.Post;
        End
        Else
        Begin
          If Not fEmptyStr(edtDesMar.Text) Then
          Begin
            qryAuxMar := fCriaQuery(Self);
            qryAuxMar.SQL.Clear;
            qryAuxMar.SQL.Add('SELECT ' + FrecInfo.strFieldCodigoOrigem + ', ' + FrecInfo.strFieldNome + ' ');
            qryAuxMar.SQL.Add('  FROM ' + FrecInfo.strTabela + ' ');

            If ((edtDesMar.Text<>'TODOS') And (Length(arrMarcas)>0)) Then
              qryAuxMar.SQL.Add('WHERE ' + FrecInfo.strFieldCodigoOrigem + ' IN ( '+ fGetVendMarArraySel(arrMarcas) +')')
            Else If (fEmptyStr(edtDesMar.Text)) Then
              qryAuxMar.SQL.Add('WHERE FALSE');

            qryAuxMar.Open;

            While (Not qryAuxMar.Eof) Do
            Begin
              If (Not cdsCliVen.Locate('CVE_CODVEN;'+FrecInfo.strFieldCodigoDestino, VarArrayOf([edtCodVen.Text, qryAuxMar.FieldByName(FrecInfo.strFieldCodigoOrigem).asString]), [])) And
                 (fVerificaRotinaForMarNaoPermitido(qryAuxMar.FieldByName(FrecInfo.strFieldCodigoOrigem).asString)) Then
              Begin
                cdsCliVen.Append;
                inc(intAutInc);
                strAutoincrem := fStrZero(intAutInc, 3);
                cdsCliVen.FieldByName('AUTOINCREM').AsString := strAutoincrem;
                cdsCliVen.FieldByName('CVE_CODCLI').AsString := edtCodCli.Text;
                cdsCliVen.FieldByName('CVE_CODVEN').AsString := edtCodVen.Text;
                cdsCliVen.FieldByName('OPE_NOMOPE').AsString := edtNomVen.Text;
                cdsCliVen.FieldByName(FrecInfo.strFieldCodigoDestino).AsString := qryAuxMar.FieldByName(FrecInfo.strFieldCodigoOrigem).asString;
                cdsCliVen.FieldByName(FrecInfo.strFieldNome).AsString := qryAuxMar.FieldByName(FrecInfo.strFieldNome).asString;
                cdsCliVen.Post;
              End;
              qryAuxMar.Next;
            End;
            FreeAndNil(qryAuxMar);
          End;

        End;

      End
      Else
      Begin

        qryAuxVen := fCriaQuery(Self);

        qryAuxVen.SQL.Clear;
        qryAuxVen.SQL.Add('SELECT OPE_CODOPE, OPE_NOMOPE ');
        qryAuxVen.SQL.Add('  FROM CADOPE ');

        If ((edtNomVen.Text<>'TODOS') And (Length(arrVendedores)>0)) Then
          qryAuxVen.SQL.Add('WHERE OPE_CODOPE IN ( '+ fGetVendMarArraySel(arrVendedores) +')');

        qryAuxVen.Open;

        qryAuxMar := fCriaQuery(Self);

        qryAuxMar.SQL.Clear;
        qryAuxMar.SQL.Add('SELECT ' + FrecInfo.strFieldCodigoOrigem + ', ' + FrecInfo.strFieldNome + ' ');
        qryAuxMar.SQL.Add('  FROM ' + FrecInfo.strTabela + ' ');

        If ((edtDesMar.Text<>'TODOS') And (Length(arrMarcas)>0)) Then
          qryAuxMar.SQL.Add('WHERE ' + FrecInfo.strFieldCodigoOrigem + ' IN ( '+ fGetVendMarArraySel(arrMarcas) +')')
        Else If (Not fEmptyStr(edtCodMar.Text)) Then
          qryAuxMar.SQL.Add('WHERE ' + FrecInfo.strFieldCodigoOrigem + ' = '+QuotedStr(edtCodMar.Text));

        qryAuxMar.Open;

        While (Not qryAuxVen.Eof) Do
        Begin
          If qryAuxMar.isEmpty Then
          Begin
            cdsCliVen.Append;
            inc(intAutInc);
            strAutoincrem := fStrZero(intAutInc, 3);
            cdsCliVen.FieldByName('AUTOINCREM').AsString := strAutoincrem;
            cdsCliVen.FieldByName('CVE_CODCLI').AsString := edtCodCli.Text;
            cdsCliVen.FieldByName('CVE_CODVEN').AsString := qryAuxVen.FieldByName('OPE_CODOPE').asString;
            cdsCliVen.FieldByName('OPE_NOMOPE').AsString := qryAuxVen.FieldByName('OPE_NOMOPE').asString;
            cdsCliVen.Post;
          End
          Else
          Begin
            qryAuxMar.First;
            While (Not qryAuxMar.Eof) Do
            Begin
              If (Not cdsCliVen.Locate('CVE_CODVEN;'+FrecInfo.strFieldCodigoDestino, VarArrayOf([qryAuxVen.FieldByName('OPE_CODOPE').asString, qryAuxMar.FieldByName(FrecInfo.strFieldCodigoOrigem).asString]), [])) And
                 (fVerificaRotinaForMarNaoPermitido(qryAuxMar.FieldByName(FrecInfo.strFieldCodigoOrigem).asString)) Then
              Begin
                cdsCliVen.Append;
                inc(intAutInc);
                strAutoincrem := fStrZero(intAutInc, 3);
                cdsCliVen.FieldByName('AUTOINCREM').AsString := strAutoincrem;
                cdsCliVen.FieldByName('CVE_CODCLI').AsString := edtCodCli.Text;
                cdsCliVen.FieldByName('CVE_CODVEN').AsString := qryAuxVen.FieldByName('OPE_CODOPE').asString;
                cdsCliVen.FieldByName('OPE_NOMOPE').AsString := qryAuxVen.FieldByName('OPE_NOMOPE').asString;
                cdsCliVen.FieldByName(FrecInfo.strFieldCodigoDestino).AsString := qryAuxMar.FieldByName(FrecInfo.strFieldCodigoOrigem).asString;
                cdsCliVen.FieldByName(FrecInfo.strFieldNome).AsString := qryAuxMar.FieldByName(FrecInfo.strFieldNome).asString;
                cdsCliVen.Post;
              End;
              qryAuxMar.Next;
            End;
          End;
          qryAuxVen.Next;
        End;

        FreeAndNil(qryAuxVen);
        FreeAndNil(qryAuxMar);

      End;

      btnCancelaItem.Click;
      btnAdicionar.Tag := 0;

    End;

    SetLength(arrVendedores, 0);
    SetLength(arrMarcas, 0);

    btnLimparTodosRegs.Enabled := True;

  End;
End;

procedure TfrmCadCliVenMar.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimparCampos;
  pHabilitaCab(True);

  If pnlCabecalho.Enabled Then
    pSetFocus(edtCodVen)
  Else pSetFocus(btnSair);
end;

procedure TfrmCadCliVenMar.dbgItensEnter(Sender: TObject);
begin
  inherited;
  pLimparCampos;
  pHabilitaCab(False);
end;

procedure TfrmCadCliVenMar.pLimparCampos;
begin
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
end;

procedure TfrmCadCliVenMar.pPesquisaMarcaFornecedor(var AstrKey: Char);
var
  arrMarca : TConsultasArray;
begin
  if FstrOpMarcaFornecedor = CODIGO_CLIENTE_VENDEDOR_MARCA then
  begin
    If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, AstrKey, arrMarca, False) Then
    Begin
      If Length(arrMarca) = 1 Then
      Begin
        fValidaCampos(edtCodMar, True);
        Self.SelectNext(ActiveControl, True, True);
      End
      Else
      Begin
        edtCodMar.Text := '';
        edtDesMar.Text := fGetVendMarArraySel(arrMarca, True);
        arrMarcas := arrMarca;
      End;
    End;
  end
  else if FstrOpMarcaFornecedor = CODIGO_CLIENTE_VENDEDOR_FORNECEDOR then
  begin
    If fPesqFornecedor(conForSimples, Self, edtCodMar, edtDesMar, Nil, AstrKey, arrMarca, False) Then
    Begin
      If Length(arrMarca) = 1 Then
      Begin
        fValidaCampos(edtCodMar, True);
        Self.SelectNext(ActiveControl, True, True);
      End
      Else
      Begin
        edtCodMar.Text := '';
        edtDesMar.Text := fGetVendMarArraySel(arrMarca, True);
        arrMarcas := arrMarca;
      End;
    End;
  end;
end;

procedure TfrmCadCliVenMar.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    If pnlCabecalho.Enabled Then
    Begin
      pHabilitaCab(True);
      edtCodVen.Text := cdsCliVen.FieldByName('CVE_CODVEN').AsString;
      edtNomVen.Text := cdsCliVen.FieldByName('OPE_NOMOPE').AsString;
      edtCodMar.Text := cdsCliVen.FieldByName(FrecInfo.strFieldCodigoDestino).AsString;
      edtDesMar.Text := cdsCliVen.FieldByName(FrecInfo.strFieldNome).AsString;
      pSetFocus(edtCodVen);
      btnAdicionar.Tag := 99;
    End
    Else pSetFocus(btnSair);
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    btnCancelaItem.Click;
    If pnlCabecalho.Enabled Then pHabilitaCab(True);
  End
  Else If (Key = VK_DELETE) Then
  Begin
    If pnlCabecalho.Enabled And (not cdsCliVen.IsEmpty) Then cdsCliVen.Delete;
  End;
end;

procedure TfrmCadCliVenMar.pHabilitaCab(blnHabilitar: Boolean);
begin
  edtCodVen.Enabled := blnHabilitar;
  edtCodMar.Enabled := blnHabilitar;
end;

procedure TfrmCadCliVenMar.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not btnConfirma.Enabled) Then
    Exit;

  Close;
  ModalResult := mrOk;

end;

procedure TfrmCadCliVenMar.btnLimparTodosRegsClick(Sender: TObject);
begin

  If fMensagem('ATENÇÃO!', 'Confirma a exclusão de todos os vendedores para esse cliente?', ['&Sim', '&Não']) = 1 Then
  Begin
    cdsCliVen.DisableControls;
    cdsCliVen.First;

    While Not cdsCliVen.Eof do
      cdsCliVen.Delete;
    cdsCliVen.EnableControls;

    btnCancelaItem.Click;
    btnAdicionar.Tag := 0;

  end;

end;

procedure TfrmCadCliVenMar.FormCreate(Sender: TObject);
begin
  inherited;
  FstrOpMarcaFornecedor := fCfgSis('MLTOP2', varString) ;
  pInicializaClienteVendedor ;
  pInfoMarcaFornecedor(FrecInfo) ;
end;

procedure TfrmCadCliVenMar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_F10: Begin
              btnConfirma.Click;
              Key := 0;
            End;
    VK_F11: Begin
              If btnLimparTodosRegs.Enabled Then
                btnLimparTodosRegs.Click;
              Key := 0;
            End;
  end;
end;

procedure TfrmCadCliVenMar.edtCodMarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If ( (edtCodMar.Text='') And (Not fEntraCons(Key)) And (Length(arrMarcas)=0) ) Then
  Begin
    edtDesMar.Text := 'TODOS';
  End
  Else
  Begin
    pPesquisaMarcaFornecedor(Key) ;
  End;

end;

procedure TfrmCadCliVenMar.edtCodVenEnter(Sender: TObject);
begin
  inherited;
  btnAdicionar.Enabled := True;
end;

procedure TfrmCadCliVenMar.edtCodMarExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtCodMar.Text) Then
    edtDesMar.Text := fPesquisaMarcaFornecedor(edtCodMar.Text);

end;

procedure TfrmCadCliVenMar.FormShow(Sender: TObject);
begin
  inherited;
  intAutInc := 0;
end;

function TfrmCadCliVenMar.fGetVendMarArraySel(arrVendMar: TConsultasArray; blnOmitirAspas: Boolean = False): String;
  Var
    i: Integer;
begin

  Result := '';

  If (Length(arrVendMar) = 0) Then
    Exit;
  Result := IIF(blnOmitirAspas, arrVendMar[0].strCodigo, QuotedStr(arrVendMar[0].strCodigo));
  For i := 1 To Length(arrVendMar) - 1 Do
    Result := Result + ', ' + IIF(blnOmitirAspas, arrVendMar[i].strCodigo, QuotedStr(arrVendMar[i].strCodigo));
end;

function TfrmCadCliVenMar.fVerificaRotinaForMarNaoPermitido(strCodForMar: String): Boolean;
begin
  Result := True;
  If not (fCfgSis('UTIFMP', varBoolean)) then
    Exit;

  If (fCfgSis('MLTOP2', varString) = CODIGO_CLIENTE_VENDEDOR_MARCA) And
     (fMarcaNaoPermitidoParaCliente(edtCodCli.Text, strCodForMar)) Then
    Result := False
  Else If (fCfgSis('MLTOP2', varString) = CODIGO_CLIENTE_VENDEDOR_FORNECEDOR) And
          (fFornecedorNaoPermitidoParaCliente(edtCodCli.Text, strCodForMar)) Then
    Result := False;
end;



end.


