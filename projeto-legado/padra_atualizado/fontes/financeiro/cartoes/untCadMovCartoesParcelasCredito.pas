unit untCadMovCartoesParcelasCredito;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  untFramePlanoDeContasMaskEdit, EditFocus, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator, Uni, UniClientDataset,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, untTypesSistema,
  cxCurrencyEdit;

type
  TfrmCadMovCartoesParcelasCredito = class(TfrmPai)
    pnlDados: TPanel;
    lblCliente: TLabel;
    edtCodigoCliente: TEditFocus;
    edtNomeCliente: TEditFocus;
    lblCadastro: TLabel;
    lblCadastroA: TLabel;
    lblVencimento: TLabel;
    lblVencimentoA: TLabel;
    edtDataInicialCadastro: TcxDateEdit;
    edtDataFinalCadastro: TcxDateEdit;
    edtDataInicialVencimento: TcxDateEdit;
    edtDataFinalVencimento: TcxDateEdit;
    btnCarrCartoes: TBitBtnLocked;
    grdCreditos: TcxGridCitel;
    grdCreditosDados: TcxGridDBTableViewCitel;
    grdCreditosDadosCTR_NUMDUP: TcxGridDBColumn;
    grdCreditosDadosCTR_PARCEL: TcxGridDBColumn;
    grdCreditosDadosCTR_DTACAD: TcxGridDBColumn;
    grdCreditosDadosCTR_DTAVEN: TcxGridDBColumn;
    grdCreditosDadosCTR_ESPDOC: TcxGridDBColumn;
    grdCreditosDadosCTR_CODEMP: TcxGridDBColumn;
    grdCreditosDadosCLIENTE: TcxGridDBColumn;
    grdCreditosDadosCTR_VALDUP: TcxGridDBColumn;
    grdCreditosNivel: TcxGridLevel;
    btnVincular: TBitBtnLocked;
    lblEmpresa: TLabel;
    edtCodigoEmpresa: TEditFocus;
    edtNomeEmpresa: TEditFocus;
    dtsCreditos: TDataSource;
    procedure edtCodigoEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnCarrCartoesClick(Sender: TObject);
    procedure btnVincularClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FArrayEmpresa,
    FArrayCliente: TConsultasArray;

    FDatasetCreditos: TUniClientDataset;

    FQuantidadeParcelas: Integer;

    FValorVendaOriginal,
    FValorCreditoSelecionado: Double;

    FAutoIncremCreditoSelecionado,
    FChaveCreditoSelecionado: String;

    procedure CarregaCliente;
    procedure CarregaEmpresa;

    procedure CriaTemporaria;

    function ValidarCreditoSelecionado: Boolean;

    { Private declarations }
  public
    { Public declarations }
    property QuantidadeParcelas: Integer read FQuantidadeParcelas write FQuantidadeParcelas;
    property ValorVendaOriginal: Double read FValorVendaOriginal write FValorVendaOriginal;

    property ValorCreditoSelecionado: Double read FValorCreditoSelecionado;
    property AutoIncremCreditoSelecionado: String read FAutoIncremCreditoSelecionado;
    property ChaveCreditoSelecionado: String read FChaveCreditoSelecionado;
   protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

Uses untFuncoesSimples, untConsultas, untPesqAux, untFuncoes, untGravando,
     untCadRec;

{$R *.dfm}

{ TfrmCadMovCartoesParcelasCredito }

procedure TfrmCadMovCartoesParcelasCredito.btnCarrCartoesClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(CriaTemporaria, 'Aguarde... Carregando créditos.', EmptyStr);
end;

procedure TfrmCadMovCartoesParcelasCredito.btnVincularClick(Sender: TObject);
begin
  inherited;

  If Not ValidarCreditoSelecionado Then
  Begin
    pSetFocus(grdCreditos);

    Exit;
  End;

  FValorCreditoSelecionado := FDatasetCreditos.FieldByName('CTR_VALDUP').AsFloat;
  FAutoIncremCreditoSelecionado := FDatasetCreditos.FieldByName('AUTOINCREM').AsString;

  Self.Close;

  Self.ModalResult := mrOk;
end;

procedure TfrmCadMovCartoesParcelasCredito.btnSairClick(Sender: TObject);
begin
  inherited;
  Self.ModalResult := mrCancel;
end;

procedure TfrmCadMovCartoesParcelasCredito.CarregaCliente;
begin
  edtNomeCliente.Text := fCampoTabela('CLI_NOMCLI',
                                      'CADCLI',
                                      ['CLI_CODCLI'],
                                      [edtCodigoCliente.Text]);
end;

procedure TfrmCadMovCartoesParcelasCredito.CarregaEmpresa;
begin
  edtNomeEmpresa.Text := fCampoTabela('EMP_NOMEMP',
                                      'CADEMP',
                                      ['EMP_CODEMP'],
                                      [edtCodigoEmpresa.Text]);
end;

procedure TfrmCadMovCartoesParcelasCredito.CriaTemporaria;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := untCadRec.RetornaSQLDuplicatasDVCCVincularMovCar;

    If Not fEmptyStr(edtCodigoCliente.Text) Then
      LConsulta.SQL.Add('  AND R.CTR_CODCLI IN (' + fRetArrToSQLIn(FArrayCliente, edtCodigoCliente.Text) + ') ');

    If Not fEmptyStr(edtCodigoEmpresa.Text) Then
      LConsulta.SQL.Add('  AND R.CTR_CODEMP IN (' + fRetArrToSQLIn(FArrayEmpresa, edtCodigoEmpresa.Text) + ') ')
    Else
      LConsulta.SQL.Add('  AND R.CTR_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ');

    If StrToInt64Def(fRetSomenteNumeros(edtDataInicialCadastro.Text), 0) <> 0 Then
    Begin
      LConsulta.SQL.Add('  AND R.CTR_DTACAD BETWEEN :DTACADINI AND :DTACADFIN ');
      LConsulta.ParamByName('DTACADINI').AsDateTime := edtDataInicialCadastro.Date;
      LConsulta.ParamByName('DTACADFIN').AsDateTime := edtDataFinalCadastro.Date;
    End;

    If StrToInt64Def(fRetSomenteNumeros(edtDataInicialVencimento.Text), 0) <> 0 Then
    Begin
      LConsulta.SQL.Add('  AND R.CTR_DTAVEN BETWEEN :DTAVENINI AND :DTAVENFIN ');
      LConsulta.ParamByName('DTAVENINI').AsDateTime := edtDataInicialVencimento.Date;
      LConsulta.ParamByName('DTAVENFIN').AsDateTime := edtDataFinalVencimento.Date;
    End;

    LConsulta.Open;

    FDatasetCreditos := fCriaClientDatSet(LConsulta);
    FDatasetCreditos.Open;
    FDatasetCreditos.First;

    dtsCreditos.Dataset := FDatasetCreditos;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmCadMovCartoesParcelasCredito.edtCodigoClienteKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodigoCliente, edtNomeCliente, Nil, Key, FArrayCliente, False) Then
  Begin
    If fValidaCampos(edtCodigoCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovCartoesParcelasCredito.edtCodigoEmpresaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodigoEmpresa, edtNomeEmpresa, Nil, Key, FArrayEmpresa, False) Then
  Begin
    If fValidaCampos(edtCodigoEmpresa) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovCartoesParcelasCredito.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FDatasetCreditos.Close;

  FreeAndNil(FDatasetCreditos);
end;

procedure TfrmCadMovCartoesParcelasCredito.FormCreate(Sender: TObject);
begin
  inherited;
  FDatasetCreditos := fCriaClientDataset('SELECT * FROM CADREC WHERE FALSE');

  FValorCreditoSelecionado := 0;
  FAutoIncremCreditoSelecionado := EmptyStr;
  FChaveCreditoSelecionado := EmptyStr;
end;

procedure TfrmCadMovCartoesParcelasCredito.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnVincular.Click;
end;

procedure TfrmCadMovCartoesParcelasCredito.FormShow(Sender: TObject);
begin
  inherited;
  CarregaCliente;

  pSetFocus(edtCodigoCliente);
end;

function TfrmCadMovCartoesParcelasCredito.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodigoCliente) Then
    Begin
      edtNomeCliente.Clear;

      If (Not fEmptyStr(edtCodigoCliente.Text)) Then
      Begin
        If Not SameText(edtCodigoCliente.Text, '00000000') Then
        Begin
          SetLength(FArrayCliente, 0);

          CarregaCliente;
          If fEmptyStr(edtNomeCliente.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtCodigoEmpresa) Then
    Begin
      If fEmptyStr(edtCodigoEmpresa.Text) Then
        edtNomeEmpresa.Clear
      Else If Not SameText(edtCodigoEmpresa.Text, '000') Then
      Begin
        SetLength(FArrayEmpresa, 0);

        CarregaEmpresa;
        If fEmptyStr(edtCodigoEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Not strEmpAcessoUsuarioLogado.Contains(edtCodigoEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtDataFinalCadastro) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtDataFinalCadastro.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(edtDataInicialCadastro.Text))) Then
      Begin
        fMensagem('ATENÇÃO', 'O campo Data Final de cadastro deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(edtDataFinalCadastro.Text))) And fEmptyStr(fTiraCaracEspeciais(edtDataInicialCadastro.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'O campo Data Inicial de cadastro deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(edtDataFinalCadastro.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(edtDataInicialCadastro.Text))) Then
          Begin
            If not fValidaPeriodo(edtDataInicialCadastro.Text, edtDataFinalCadastro.Text) Then
            Begin
              fMensagem('ATENÇÃO','A Data Inicial de cadastro deve ser menor que a data final de cadastro!',['&O K']);
              Result := False;
            End;
          End;
        End;
      End;
    End

    Else If (Sender = edtDataFinalVencimento) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtDataFinalVencimento.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(edtDataInicialVencimento.Text))) Then
      Begin
        fMensagem('ATENÇÃO', 'O campo Data Final de vencimento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(edtDataFinalVencimento.Text))) And fEmptyStr(fTiraCaracEspeciais(edtDataInicialVencimento.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'O campo Data Inicial de vencimento deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(edtDataFinalVencimento.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(edtDataInicialVencimento.Text))) Then
          Begin
            If not fValidaPeriodo(edtDataInicialVencimento.Text, edtDataFinalVencimento.Text) Then
            Begin
              fMensagem('ATENÇÃO','A Data Inicial de vencimento deve ser menor que a data final de vencimento!',['&O K']);
              Result := False;
            End;
          End;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadMovCartoesParcelasCredito.ValidarCreditoSelecionado: Boolean;
begin
  Result := False;

  If FDatasetCreditos.isEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar um registro para realizar o  vínculo.', ['&Ok']);

    Exit;
  End;

  If Abs(FDatasetCreditos.FieldByName('CTR_VALDUP').AsFloat) > fFormataFloat(FValorVendaOriginal, 2) Then
  Begin
    fMensagem('ATENÇÃO', 'O valor positivo do crédito não pode ser maior que ' + FormatFloat(',0.00', FValorVendaOriginal) + '.', ['&Ok']);

    Exit;
  End;

  FChaveCreditoSelecionado := 'CADREC' +
                              FDatasetCreditos.FieldByName('CTR_NUMDUP').AsString +
                              FDatasetCreditos.FieldByName('CTR_ESPDOC').AsString +
                              FDatasetCreditos.FieldByName('CTR_CODEMP').AsString +
                              FDatasetCreditos.FieldByName('CTR_CODCLI').AsString +
                              FDatasetCreditos.FieldByName('CTR_PARCEL').AsString;

  If Not fLock_Unlock(FChaveCreditoSelecionado,
                      True,
                      False,
                      False,
                      EmptyStr,
                      True) Then
  Begin
    FChaveCreditoSelecionado := EmptyStr;

    fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(FChaveCreditoSelecionado), ['&Ok']);

    Exit;
  End;

  Result := True;
end;

end.
