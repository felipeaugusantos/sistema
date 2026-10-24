unit untDigCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, untFuncFat, DB,
  untTypesSistema;

type
  TfrmDigCliente = class(TfrmPai)
    pnlGeral: TPanel;
    lblCliFor: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    pnlDocumento: TPanel;
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    var
      blnOnShow: Boolean;
      strCodCliPediuDadosConsumidor: String;

    procedure pCarregaDadosConsumidor(strCodCli: String);
    function fDigDadosConsumidor: Boolean;
    function fEhClienteForaEstabelecimento(strCodCli: string): Boolean;
    function fValidaSelecaoDeClientes(const arrConsulta: TConsultasArray): Boolean;
    procedure pValidarPreenchimentoCliente;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    regConsum: TRegistroConsumidor;
    blnPedDadosConsumidor: Boolean;
    blnChamadaVeioDoF11 : Boolean;
    blnPermiteVenderApenasDinheiroECartaoParaInativo: Boolean;
    blnTravaInativo: Boolean; //untAtendimento
    objVenda : TFatVenda;
    strOpcDoc: string;
    blnChamadaVeioDoOrcamento: Boolean;
    blnChamadorF11 : Boolean;
    strCodCli: String;
    arrClientes: TConsultasArray;
    blnSomentePessoaFisica: Boolean;
  end;

var
  frmDigCliente: TfrmDigCliente;

implementation

uses untFuncoesSimples, untFuncIns, untFuncIns2, untFatDadosCliConsumidor, untPesqAux,
  untConsultas, untPanelCxClientes, untPnlDadosCliente, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmDigCliente.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    objfrmPnl : TPanelCxClientes;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  objfrmPnl := TPanelCxClientes.Create(TfrmPnlDadosCliente);
  objfrmPnl.blnChamadorF11F3 := blnChamadorF11;

  try
    if strOpcDoc = 'EM' then
    begin
      If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, True, objfrmPnl,
                      False, '', strOpcDoc, True, '', '', tfvNenhum, '', blnSomentePessoaFisica) Then
      Begin
        If fValidaCampos(edtCodCli, True) Then
          SelectNext(ActiveControl, True, True);
      End;
    end
    Else If strOpcDoc = 'AT' Then
    begin
      If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, False, objfrmPnl ) Then
      Begin
        If Length(arrClientes) > 1 Then
        Begin
          If fValidaSelecaoDeClientes(arrClientes) Then
            SelectNext(ActiveControl, True, True);
        End
        Else
        Begin
          If fValidaCampos(edtCodCli, True) Then
            SelectNext(ActiveControl, True, True);
        End;
      End;
    End
    else
    begin
      If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, True, objfrmPnl ) Then
      Begin
        If fValidaCampos(edtCodCli, True) Then
          SelectNext(ActiveControl, True, True);
      End;
    end;
  Finally
    FreeAndNil(objfrmPnl);
  end;
end;

procedure TfrmDigCliente.edtNumDocKeyPress(Sender: TObject; var Key: Char);
Var
  arrRemessas: TConsultasArray;
  LstrCodCli: String;
begin
  inherited;

  If fEntraCons(Key) And fEmptyStr(edtCodCli.Text) Then
  Begin
    pMensagemOk('Preencha o cliente da remessa.');
    pSetFocus(edtCodCli);
    Exit;
  End;

  If fPesqRetornoRemessa(Self, edtNumDoc, LstrCodCli, Key, arrRemessas, edtCodCli.Text) Then
    edtEspDoc.Text := 'NF';
end;

function TfrmDigCliente.fDigDadosConsumidor: Boolean;
begin
  With regConsum Do
  Try
    pCriarFormularios(TfrmFatDadosCliConsumidor, frmFatDadosCliConsumidor);
    frmFatDadosCliConsumidor.strCodCli      := edtCodCli.Text;      // - Código
    frmFatDadosCliConsumidor.edtNomCli.Text := strCliNom;           // - Nome
    frmFatDadosCliConsumidor.edtEndere.Text := strCliEnd;           // - Endereco
    frmFatDadosCliConsumidor.edtBairro.Text := strCliBai;           // - Bairro
    frmFatDadosCliConsumidor.mskNumCep.Text := strCliCep;           // - Cep
    frmFatDadosCliConsumidor.edtCodCid.Text := strCodCid;           // - Cod. Cidade
    frmFatDadosCliConsumidor.edtNomCid.Text := strCliCid;           // - Cidade
    frmFatDadosCliConsumidor.edtEstado.Text := strCliEst;           // - Estado
    frmFatDadosCliConsumidor.mskTelCon.Text := strCliTel;           // - Telefone
    frmFatDadosCliConsumidor.edtCgcCpf.Text := IntToStr(intCgcCpf); // - CGC/CPF
    frmFatDadosCliConsumidor.mskNumCgc.Text := strCliCgc;           // - CNPJ
    frmFatDadosCliConsumidor.edtInsEst.Text := strCliIes;           // - Ins.Estadual
    frmFatDadosCliConsumidor.edtRgCli.Text  := strCli_Rg;           // - Rg
    frmFatDadosCliConsumidor.strEstado      := strCliEst;           // - Estado
    frmFatDadosCliConsumidor.edtEmail_.Text := strCliEml;           // - E-mail
    frmFatDadosCliConsumidor.edtCodCac.Text := strCodCac;           // - Canal de Acesso

    If Not (fEmptyStr(strCodCac)) Then
     frmFatDadosCliConsumidor.edtDesCadCac.Text := fRetNomCanalAcesso(strCodCac);

    If (fCfgSis('PRECAD', varBoolean)) Then
    Begin
      frmFatDadosCliConsumidor.edtCodAtividade.Text := strCodAti;           // - Código de Atividade do Cliente Consumidor
      frmFatDadosCliConsumidor.edtNomAtividade.Text := fRetAtividade(strCodAti);   // - Nome de Atividade do Cliente Consumidor
    End;

    frmFatDadosCliConsumidor.objVenda := objVenda;
    frmFatDadosCliConsumidor.ShowModal;
    Result := frmFatDadosCliConsumidor.blnConfirma;
    If frmFatDadosCliConsumidor.blnConfirma Then
    Begin
      strCliNom := frmFatDadosCliConsumidor.edtNomCli.Text; // - Nome
      strCliEnd := frmFatDadosCliConsumidor.edtEndere.Text; // - Endereco
      strCliBai := frmFatDadosCliConsumidor.edtBairro.Text; // - Bairro
      strCliCep := frmFatDadosCliConsumidor.mskNumCep.Text; // - Cep
      strCodCid := frmFatDadosCliConsumidor.edtCodCid.Text; // - Cód. Cidade
      strCliCid := frmFatDadosCliConsumidor.edtNomCid.Text; // - Cidade
      strCliEst := frmFatDadosCliConsumidor.edtEstado.Text; // - Estado
      strCliTel := frmFatDadosCliConsumidor.mskTelCon.Text; // - Telefone
      strCliCgc := frmFatDadosCliConsumidor.mskNumCgc.Text; // - CNPJ
      strCli_Rg := frmFatDadosCliConsumidor.edtRgCli.Text;  // - RG
      If fEmptyStr(frmFatDadosCliConsumidor.edtCgcCpf.Text) Then
        intCgcCpf := 0
      Else
        intCgcCpf := StrToInt(frmFatDadosCliConsumidor.edtCgcCpf.Text); // - CGC/CPF
      strCliIes := frmFatDadosCliConsumidor.edtInsEst.Text;             // - Ins.Estadual
      strCliEml := frmFatDadosCliConsumidor.edtEmail_.Text;             // - E-mail
      If (fCfgSis('PRECAD', varBoolean)) Then
        strCodAti := frmFatDadosCliConsumidor.edtCodAtividade.Text;

      strCodCac := frmFatDadosCliConsumidor.edtCodCac.Text; // - Canal de Acesso

      edtNomCli.Text := strCliNom;

      strCodCliPediuDadosConsumidor := edtCodCli.Text;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmFatDadosCliConsumidor);
end;

function TfrmDigCliente.fEhClienteForaEstabelecimento(
  strCodCli: string): Boolean;
var
  qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery();

  try
    Result := False;
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT COALESCE(CLI_REMOUT, "N") AS REMOUT FROM CADCLI WHERE CLI_CODCLI = :CADCLI');
    qryConsulta.ParamByName('CADCLI').AsString := strCodCli;
    qryConsulta.Open;
    Result := (not qryConsulta.IsEmpty) and (qryConsulta.FieldByName('REMOUT').AsString = 'S');
  finally
    FreeAndNil(qryConsulta);
  end;
end;

procedure TfrmDigCliente.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCli);
end;

procedure TfrmDigCliente.FormCreate(Sender: TObject);
begin
  inherited;
  blnOnShow := False;
  blnPedDadosConsumidor := True;
  blnChamadaVeioDoF11 := False;
  blnPermiteVenderApenasDinheiroECartaoParaInativo := False;
  blnTravaInativo := True;
  objVenda := Nil;
  strOpcDoc := EmptyStr;
  blnChamadaVeioDoOrcamento := False;
  strCodCli := '';
  blnSomentePessoaFisica := False;
  strCodCliPediuDadosConsumidor := '';
end;

procedure TfrmDigCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If fIsInsert(Key) Then
  Begin
    If edtCodCli.Focused Then
    Begin
      If fVerificaAcessoSistema('frmCadClientes') Then
      Begin
        edtCodCli.Text := fChamaCadCli(Key);
        If fValidaCampos(edtCodCli) Then
          SelectNext(ActiveControl, True, True);
      End;
    End;
  End;
end;

procedure TfrmDigCliente.FormShow(Sender: TObject);
begin
  inherited;
  blnOnShow := True;
  Try

    pValidarPreenchimentoCliente;
    pnlDocumento.Enabled := strOpcDoc = 'EM';
    pnlDocumento.Visible := pnlDocumento.Enabled;

  Finally
    blnOnShow := False;
  End;
end;

function TfrmDigCliente.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  function fDevePedirDadosConsumidor():Boolean;
  begin
    Result := blnPedDadosConsumidor And
              (strCodCliPediuDadosConsumidor <> edtCodCli.Text) And
              fClienteConsumidor(edtNomCli.Text, False)

  end;
begin
  Result := True;

  {*****************************************}
  {* VALIDA CLIENTE                        *}
  {**************************************MV*}
  If Sender = edtCodCli Then
  Begin
    pDesmarcaLista(edtCodCli, arrClientes);
    If fEmptyStr(edtCodCli.Text) Then
    Begin
      fMensagem('', 'O cliente deve ser preenchido!' , ['&Ok']);
      Result := False;
    End
    Else If blnChamadaVeioDoF11 And TFatVenda.fTravarVendaClientePessoaFisica(edtCodCli.Text) Then
    Begin
      Result := False;
    End
    Else If (strOpcDoc = 'AT') And (Length(arrClientes) > 1) Then
    Begin
      Result := fValidaSelecaoDeClientes(arrClientes);
    End
    Else
    Begin
      If blnSomentePessoaFisica Then
      Begin
        edtNomCli.Clear;
        if fClientePessoaFisica(edtCodCli.Text) Then
          edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
      End
      Else
      Begin
        edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
      End;
      If fEmptyStr(edtNomCli.Text) Then
      Begin
        fMensagem('AVISO', 'Cliente não encontrado!', ['&Ok']);
        Result := False;
      End
      Else If (Not blnChamadaVeioDoF11) And (blnTravaInativo) And
          (Not fRetStatusCliente(edtCodCli.Text)) Then
      Begin
        fMensagem('', 'Esse cliente está com atividade suspensa!', ['&OK']);
        Result := False;
      End
      Else If (blnChamadaVeioDoF11) And (Not fRetStatusCliente(edtCodCli.Text)) And
              (Not blnPermiteVenderApenasDinheiroECartaoParaInativo) Then
      Begin
        fMensagem('', 'Esse cliente está com atividade suspensa!', ['&OK']);
        Result := False;
      End
      Else If (blnChamadaVeioDoF11) And (Not fPermiteClienteDiaFixoOuDiaSemana(edtCodCli.Text, False)) Then
      Begin
        Result := False;
      End
      Else If (strOpcDoc = 'EM') And (not fEhClienteForaEstabelecimento(edtCodCli.Text)) then
      begin
        edtNomCli.Clear;
        fMensagem('', 'Informe apenas clientes configurados como fora de estabelecimento!', ['&OK']);
        Result := False;
      end
      Else If fDevePedirDadosConsumidor() Then
      Begin
        pCarregaDadosConsumidor(edtCodCli.Text);
        if blnChamadaVeioDoOrcamento Or (blnChamadaVeioDoF11 And blnOnShow) then
          Result := True
        else
          Result := fDigDadosConsumidor;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmDigCliente.fValidaSelecaoDeClientes(const arrConsulta: TConsultasArray):Boolean;
  Var
    intCnt : Integer;
    strInativos : String;
    strConsumidores : String;
    msgAviso : String;
begin
  strInativos := EmptyStr;
  strConsumidores := EmptyStr;
  msgAviso := EmptyStr;

  For intCnt := 0 To Pred(Length(arrConsulta)) Do
  Begin
    If (blnTravaInativo) And (Not fRetStatusCliente(arrConsulta[intCnt].strCodigo)) Then
    Begin
      If (fEmptyStr(strInativos)) Then
        strInativos := arrConsulta[intCnt].strCodigo
      Else
        strInativos := strInativos + ', ' + arrConsulta[intCnt].strCodigo;
      End;

    If fClienteConsumidor(fRetNomCliente(arrConsulta[intCnt].strCodigo), False) Then
    Begin
      If (fEmptyStr(strConsumidores)) Then
        strConsumidores := arrConsulta[intCnt].strCodigo
      Else
        strConsumidores := strConsumidores + ', ' + arrConsulta[intCnt].strCodigo;
    End;
  End;

  Result := fEmptyStr(strInativos + strConsumidores);

  If Not Result Then
  Begin
    If Not fEmptyStr(strInativos) Then
      msgAviso := 'Esses clientes estão com atividade suspensa: ' + strInativos;

    If Not fEmptyStr(strConsumidores) Then
    Begin
      If (fEmptyStr(msgAviso)) Then
        msgAviso := 'Clientes "CONSUMIDOR" não podem estar na multi-seleção: ' + strConsumidores
      Else
        msgAviso := msgAviso + #13#13 + 'Clientes "CONSUMIDOR" não podem estar na multi-seleção: ' + strConsumidores;
    End;

    fMensagem('', msgAviso, ['&Ok']);
  End;
end;

procedure TfrmDigCliente.pCarregaDadosConsumidor(strCodCli: String);
  Var
    qryCadCli: TUniQuery;
Begin
  qryCadCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCli.Text);
  With regConsum, qryCadCli Do
  Begin
    strCliEnd := FieldByName('CLI_ENDERE').AsString + ', ' +
                 FieldByName('CLI_ENDNUM').AsString + '  ' +  // - Endereco
                 FieldByName('CLI_ENDCOM').AsString;
    strCliBai := FieldByName('CLI_BAIRRO').AsString;          // - Bairro
    strCliCep := FieldByName('CLI_C_E_P_').AsString;          // - Cep
    strCodCid := FieldByName('CLI_CODCID').AsString;          // - Cód. Cidade
    strCliTel := FieldByName('CLI_FONE01').AsString;          // - Telefone
    strCliCid := fRetNomCidade(strCodCid);                    // - Cidade
    strCliEst := fRetNomCidade(strCodCid, 1);                 // - Estado

    strCliNom := FieldByName('CLI_NOMCLI').AsString;          // - Nome
    strCliCgc := FieldByName('CLI_C_G_C_').AsString;          // - CNPJ
    strCliIes := FieldByName('CLI_I_E_S_').AsString;          // - Ins.Estadual
    strCli_Rg := FieldByName('CLI_NUMR_G').AsString;          // - RG

    If fEmptyStr(FieldByName('CLI_CGCCPF').AsString) Then
      intCgcCpf := 0
    Else
      intCgcCpf := FieldByName('CLI_CGCCPF').AsInteger;       // - CGC/CPF
    strCliEml := FieldByName('CLI_EMAIL_').AsString;          // - E-mail
    strCodReg := FieldByName('CLI_CODREG').AsString;          // - Código da Região
    strCodAti := FieldByName('CLI_CODATI').AsString;          // - Código de Atividade
    strCodCac := FieldByName('CLI_CODCAC').AsString;          // - Canal de Acesso

  End;
  FreeAndNil(qryCadCli);
end;

procedure TfrmDigCliente.pValidarPreenchimentoCliente;
begin
  If (fEmptyStr(strCodCli)) Then
    Exit;

  edtCodCli.Text := strCodCli;
  fValidaCampos(edtCodCli, True);
end;

procedure TfrmDigCliente.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  if blnChamadaVeioDoOrcamento Or blnChamadaVeioDoF11 then
  begin
    If fValidaCampos(edtCodCli, True) Then
    Begin
      ModalResult := mrOk;
    End;
  end
  else
  begin
    If fVerificaCampos Then
    Begin
      ModalResult := mrOk;
    End;
  end;
end;

end.
