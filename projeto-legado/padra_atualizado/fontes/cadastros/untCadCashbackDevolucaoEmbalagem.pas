unit untCadCashbackDevolucaoEmbalagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass, untConsultas,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, System.StrUtils,
  untTypesSistema, Vcl.DBCtrls, DBEditFocus, MaskEditFocus, untMskC_G_C_,
  untMskTelefone, Data.DB;

type
  TfrmCadCashbackDevolucaoEmbalagem = class(TfrmPaiCad)
    pnlCliente: TPanel;
    lblCliFor: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    pnlTelefone: TPanel;
    pnlCpfCnpj: TPanel;
    pnlDadosDevolucaoEmbalagem: TPanel;
    edtTelefone: TMaskEditTelefone;
    Label16: TLabel;
    Label12: TLabel;
    edtCgcCpf: TEditFocus;
    edtCpfDev: TMaskEditC_G_C_;
    lblDigita: TLabel;
    edtNomDig: TEditFocus;
    lblQuantidade: TLabel;
    edtQtdEmb: TEditFocus;
    lblVlrUnit: TLabel;
    Label15: TLabel;
    edtValorTotal: TEditFocus;
    lblSaldoTotalCashback: TLabel;
    edtSenDig: TEditFocus;
    edtUnitar: TEditFocus;
    lblDadosCashback: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtCgcCpfChange(Sender: TObject);

  private
    { Private declarations }
    FarrClientes : TConsultasArray;
    FState       : TDataSetState;
    FAutInc      : String;
    FCodigoCsh   : String;
    FValorCsh    : Double;
    FSaldoCsh    : Double;

    procedure pCarregarDados;

    procedure pHabilitarDesabilitarCamposClienteConsumidor;
    function fExisteRegraCashBackVigenteParaCliente: Boolean;
    function fRetornaSaldoDisponivelCashbackCliente: String;
    function fRetornaValorUnitarioCashbackVigente: String;

    procedure pConfiguraBotoesControles(const AState: TDataSetState;
      const AEnabled: Boolean; const AComponentFocus: TObject=nil);

    procedure pLimparCamposFormulario;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pOnStateChange; override;

  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesGenerica, untFuncoesSimples, untFuncoesConsulta, Cashback.Classes,
  Cashback.Controle, Uni, untLiberacao;

{$R *.dfm}

procedure TfrmCadCashbackDevolucaoEmbalagem.btnCancelaClick(Sender: TObject);
begin
  FAutInc    := EmptyStr;
  FCodigoCsh := EmptyStr;
  FValorCsh  := 0;
  FSaldoCsh  := 0;

  pLimparCamposFormulario;
  pConfiguraBotoesControles(dsBrowse, False, IIF(btnIncluir.CanFocus, btnIncluir, IIF(btnPesquisa.CanFocus, btnPesquisa, nil)));
end;

procedure TfrmCadCashbackDevolucaoEmbalagem.btnExcluirClick(Sender: TObject);
var
  controle     : TControleCashback;
  objLiberacao : TLiberacao;
begin
  If fEmptyStr(FAutInc) Then
  Begin
    pMensagemOk('Houve um problema para excluir o Cashback '
               +'de Devolução de Embalagens. Contate a Citel.');
    Exit;
  End;

  objLiberacao := nil;
  Try
    objLiberacao := TLiberacao.Create;

    objLiberacao.Clear;
    objLiberacao.objMsgRemota.strDirAce := 'LIBDVECSH';

    objLiberacao.objMsgLibera.pAddTexto('Permitir excluir Cashback de Devolução de Embalagem');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTexto('Cliente.......: ' + edtCodCli.Text + '-' + edtNomCli.Text);
    objLiberacao.objMsgLibera.pAddTexto('Código........: ' + FCodigoCsh);
    objLiberacao.objMsgLibera.pAddTexto('Valor Cashback: ' + FormatFloat(',0.00', FValorCsh));
    objLiberacao.objMsgLibera.pAddTexto('Saldo Cashback: ' + FormatFloat(',0.00', FSaldoCsh));

    objLiberacao.strDirAce  := 'LIBDVECSH';
    objLiberacao.strMsgSen  := 'Permitir excluir Cashback de Devolução de Embalagem';
    objLiberacao.strCodOpe  := strLoginUsuarioLogado;

    If Not objLiberacao.fLibera Then
      Exit;
  Finally
    FreeAndNil(objLiberacao);
  End;

  Try
    controle := nil;
    Try
      fStartTransaction;

      controle := TControleCashback.Create;
      controle.fCancelaCashbackGeradoDevolucaoEmbalagem(FAutInc);

      fCommit;

      pMensagemOk('Cashback excluído com sucesso.');
      btnCancela.Click;
    Finally
      FreeAndNil(controle);
    End;
  Except
    On E: Exception Do
    Begin
      If fInTransaction Then
        fRollBack;
      pMensagensErro(E.Message, '[TfrmCadCashbackDevolucaoEmbalagem.btnExcluirClick]');
    End;
  End;
end;

procedure TfrmCadCashbackDevolucaoEmbalagem.btnGravarClick(Sender: TObject);
var
  controle : TControleCashback;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  Try
    controle := nil;
    Try
      fStartTransaction;

      controle := TControleCashback.Create;
      controle.strCodEmp := VS_strCodEmp;
      controle.strCodOpe := strLoginUsuarioLogado;
      controle.strCodCli := edtCodCli.Text;
      controle.fltQtdEmb := fStrToFloat(edtQtdEmb.Text);
      controle.strOrigem := 'E';
      controle.strFonCli := edtTelefone.Text;
      controle.strCgcCpf := edtCgcCpf.Text;
      controle.strCpfCli := edtCpfDev.Text;
      controle.fGerarCashBack;

      fCommit;

      pMensagemOk('Cashback gerado com sucesso.');
      btnIncluir.Click;
    Finally
      FreeAndNil(controle);
    End;
  Except
    On E: Exception Do
    Begin
      If fInTransaction Then
        fRollBack;
      pMensagensErro(E.Message, '[TfrmCadCashbackDevolucaoEmbalagem.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadCashbackDevolucaoEmbalagem.btnIncluirClick(Sender: TObject);
begin
  FAutInc    := EmptyStr;
  FCodigoCsh := EmptyStr;
  FValorCsh  := 0;
  FSaldoCsh  := 0;

  pLimparCamposFormulario;
  blnUsaProCodigo := False;
  pConfiguraBotoesControles(dsInsert, True, edtCodCli);
end;

procedure TfrmCadCashbackDevolucaoEmbalagem.btnPesquisaClick(Sender: TObject);
var
  chrKey: Char;
begin
  chrKey := '/';

  if fPesqCashbackDevolucaoEmbalagem(Self, FAutInc, chrKey) then
    pCarregarDados;
end;

procedure TfrmCadCashbackDevolucaoEmbalagem.edtCgcCpfChange(Sender: TObject);
begin
  inherited;
  edtCpfDev.Clear;
end;

procedure TfrmCadCashbackDevolucaoEmbalagem.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqCliente(conCliAgrupDup, Self, edtCodCli, edtNomCli, Nil, Key, FarrClientes, False) Then
    Begin
      If fValidaCampos(edtCodCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

function TfrmCadCashbackDevolucaoEmbalagem.fExisteRegraCashBackVigenteParaCliente: Boolean;
var
  controle : TControleCashback;
begin
  controle := nil;
  Try
    controle := TControleCashback.Create;
    controle.strCodCli := edtCodCli.Text;
    controle.fltQtdEmb := 1;
    controle.strOrigem := 'E';

    Result := controle.ExisteRegraCashBackDevolucaoEmbalagemVigenteParaCliente;
  Finally
    FreeAndNil(controle);
  End;
end;

procedure TfrmCadCashbackDevolucaoEmbalagem.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela := 'VENCSH';
  strNomeCampo  := 'AUTOINCREM';

  blnUsaAutInc := False;

  qryTabela := fCriarQuery('SELECT * FROM VENCSH ', Self);
end;

procedure TfrmCadCashbackDevolucaoEmbalagem.FormShow(Sender: TObject);
begin
  inherited;
  FState := dsBrowse;
  pOnStateChange;

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Text := 'SELECT * FROM VENCSH '
                      + ' WHERE VCB_ORIGEM = "E" ';
  qryTabela.Open;

  pSetFocus(btnIncluir);

  btnAlterar.Enabled := False;
  btnAlterar.Visible := False;

  pnlTelefone.Visible := False;
  pnlCpfCnpj.Visible  := False;
end;

function TfrmCadCashbackDevolucaoEmbalagem.fRetornaSaldoDisponivelCashbackCliente: String;
var
  controle : TControleCashback;
begin
  controle := nil;
  Try
    controle := TControleCashback.Create;
    controle.strCodCli := edtCodCli.Text;
    controle.strFonCli := edtTelefone.Text;
    controle.strCpfCli := edtCpfDev.Text;
    controle.fltQtdEmb := 1;

    Result := 'Cashback - Saldo Total: '
            + FormatFloat(',0.00', controle.fRetornaSaldoCashbackDevolucaoEmbalagemCliente);
  Finally
    FreeAndNil(controle);
  End;
end;

function TfrmCadCashbackDevolucaoEmbalagem.fRetornaValorUnitarioCashbackVigente: String;
var
  controle : TControleCashback;
begin
  controle := nil;
  Try
    controle := TControleCashback.Create;
    controle.strCodCli := edtCodCli.Text;
    controle.strOrigem := 'E';

    Result := FormatFloat(',0.00', controle.ValorUnitarioRegraCashBackDevolucaoEmbalagemVigenteParaCliente);
  Finally
    FreeAndNil(controle);
  End;
end;

function TfrmCadCashbackDevolucaoEmbalagem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  blnRecalcularTotalizadores: Boolean;
begin
  Result := True;
  blnRecalcularTotalizadores := False;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Cliente deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pEdtCodSelectExit(edtCodCli, edtNomCli, FarrClientes, nil, fRetNomCliente, 'do Cliente');

        If fEmptyStr(edtNomCli.Text) Then
          Result := False;
      End;

      If Result Then
      Begin
        pHabilitarDesabilitarCamposClienteConsumidor;

        If Not fExisteRegraCashBackVigenteParaCliente Then
        Begin
          fMensagem('ATENÇÃO!', 'O cliente informado não pode gerar cashback conforme regra vigente. Verifique!', ['&Ok']);
          edtCodCli.Text := EmptyStr;
          edtNomCli.Text := EmptyStr;
          Result := False;
        End;
      End;

      blnRecalcularTotalizadores := Result;
    End

    Else If (Sender = edtSenDig) Then
    Begin
      If fEmptyStr(edtSenDig.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O digitador deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtNomDig.Text := fRetNomVendRep(fRetCodVendedor(edtSenDig.Text));
        If fEmptyStr(edtNomDig.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtTelefone) And pnlTelefone.Visible Then
    Begin
      If (not fEmptyStr(edtTelefone.Text)) and (Not fValidaCelular(edtTelefone.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um celular válido!', ['&Ok']);
        Result := False;
      End;

      blnRecalcularTotalizadores := Result;
    End

    Else If (Sender = edtCgcCpf) And pnlCpfCnpj.Visible Then
    Begin
      If (Not MatchStr(edtCgcCpf.Text, ['1','2'])) Then
      Begin
        fMensagem('ATENÇÃO', 'O tipo de documento deve ser preenchido com um valor válido.', ['&Ok']);
        Result := False;
      End;

      If Result Then
      Begin
        If edtCgcCpf.Text = '1' Then
        Begin
          edtCpfDev.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
          edtCpfDev.MaxLength := 18;
        End
        Else If edtCgcCpf.Text = '2' Then
        Begin
          edtCpfDev.EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);
          edtCpfDev.MaxLength := 14;
        End;
      End;
    End

    Else If (Sender = edtCpfDev) And pnlCpfCnpj.Visible Then
    Begin
      If fEmptyStr(edtCpfDev.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O número do documento não pode ser vazio', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        Result := fValidaCnpjCpf(edtCgcCpf.Text, edtCpfDev.Text, False);
      End;

      blnRecalcularTotalizadores := Result;
    End

    Else If (Sender = edtQtdEmb) Then
    Begin
      If (fStrToFloat(edtQtdEmb.Text, 0) <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'A quantidade de embalagem deve ser preenchida '
                           + 'com valor maior que zero', ['&Ok']);
        Result := False;
      End;

      blnRecalcularTotalizadores := Result;
    End;

    If Result And blnRecalcularTotalizadores Then
    Begin
      edtUnitar.Text                := fRetornaValorUnitarioCashbackVigente;

      edtValorTotal.Text            := FormatFloat(',0.00', fStrToFloat(edtQtdEmb.Text, 0)
                                                          * fStrToFloat(edtUnitar.Text, 0));

      lblSaldoTotalCashback.Caption := fRetornaSaldoDisponivelCashbackCliente;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadCashbackDevolucaoEmbalagem.pCarregarDados;
var
  qryDados: TUniQuery;
begin
  If fEmptyStr(FAutInc) Then
  Begin
    pMensagemOk('Houve um problema para carregar as informações do Cashback '
               +'de Devolução de Embalagens. Contate a Citel.');
    Exit;
  End;

  pLimparCamposFormulario;
  qryDados := nil;
  Try
    qryDados := fCriaQuery;
    qryDados.Close;
    qryDados.SQL.Text := 'SELECT * FROM VENCSH '
                       + ' WHERE AUTOINCREM = :AUTINC ';
    qryDados.ParamByName('AUTINC').AsString := FAutInc;
    qryDados.Open;

    edtCodCli.Text           := qryDados.FieldByName('VCB_CODCLI').AsString;
    edtTelefone.Text         := qryDados.FieldByName('VCB_TELCON').AsString;
    edtCgcCpf.Text           := qryDados.FieldByName('VCB_CGCCPF').AsString;
    edtCpfDev.Text           := qryDados.FieldByName('VCB_CGCCON').AsString;
    edtSenDig.PasswordChar   := #0;
    edtSenDig.Text           := qryDados.FieldByName('VCB_CODOPE').AsString;
    edtQtdEmb.Text           := FormatFloat(',0.00', qryDados.FieldByName('VCB_QTDEMB').AsFloat);
    FCodigoCsh               := qryDados.FieldByName('VCB_NUMCSH').AsString;
    FValorCsh                := qryDados.FieldByName('VCB_VLRCSH').AsFloat;
    FSaldoCsh                := qryDados.FieldByName('VCB_VLRDSP').AsFloat;
    lblDadosCashback.Caption := Format('Código: %s - Data Cad.: %s',
                                       [qryDados.FieldByName('VCB_NUMCSH').AsString,
                                        FormatDateTime('dd/mm/yyyy', qryDados.FieldByName('VCB_DTAENT').AsDateTime)]);

    fVerificaCampos;
    pEnabled(Self, False);

    pnlTelefone.Enabled := False;
    pnlCpfCnpj.Enabled  := False;
  Finally
    FreeAndNil(qryDados);
  End;
end;

procedure TfrmCadCashbackDevolucaoEmbalagem.pConfiguraBotoesControles(
  const AState: TDataSetState; const AEnabled: Boolean;
  const AComponentFocus: TObject);
var
  objFocus  : TWinControl;
begin
  objFocus  := nil;

  If AComponentFocus is TWinControl Then
  Begin
    If Assigned(AComponentFocus) Then
      objFocus := TWinControl(AComponentFocus);
  End;

  FState := AState;

  If blnChangeEnabledButton Then
    pOnStateChange;

  pEnabled(Self, AEnabled);

  If Assigned(objFocus) Then
  Begin
    If objFocus.CanFocus Then
      pSetFocus(objFocus)
  End;
end;

procedure TfrmCadCashbackDevolucaoEmbalagem.pHabilitarDesabilitarCamposClienteConsumidor;
var
  LEhClienteConsumidor: Boolean;
begin
  lblSaldoTotalCashback.Caption := EmptyStr;

  LEhClienteConsumidor := (Not fEmptyStr(edtNomCli.Text)) And
                          fClienteConsumidor(edtNomCli.Text, True, True);

  pnlTelefone.Enabled := LEhClienteConsumidor And (fCfgSis('CLCCSH') = '1');
  pnlTelefone.Visible := pnlTelefone.Enabled;

  pnlCpfCnpj.Enabled := LEhClienteConsumidor And (fCfgSis('CLCCSH') = '2');
  pnlCpfCnpj.Visible := pnlCpfCnpj.Enabled;
end;

procedure TfrmCadCashbackDevolucaoEmbalagem.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
end;

procedure TfrmCadCashbackDevolucaoEmbalagem.pLimparCamposFormulario;
begin
  pLimparCampos;

  edtTelefone.Clear;
  edtCgcCpf.Clear;
  edtCpfDev.Clear;
  lblDadosCashback.Caption := EmptyStr;
  edtSenDig.PasswordChar   := '*';

  pHabilitarDesabilitarCamposClienteConsumidor;
end;

procedure TfrmCadCashbackDevolucaoEmbalagem.pOnStateChange;
begin
  pSetButton(FState, btnIncluir, btnGravar, btnExcluir, btnCancela, btnAlterar, btnPesquisa, btnSair);
end;

end.
