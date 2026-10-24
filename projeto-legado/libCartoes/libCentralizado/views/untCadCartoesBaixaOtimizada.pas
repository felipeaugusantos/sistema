unit untCadCartoesBaixaOtimizada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, untDadosDeBaixaOtimizadaCartoes, EditFocus,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Uni, UniClientDataSet, untPaiConfirma;

type
  TfrmCadCartoesBaixaOtimizada = class(TfrmPaiConfirma)
    pnlFundo: TPanel;
    lblEmpresa: TLabel;
    dbeCodEmpOtimizada: TDBEditFocus;
    edtDesEmpOtimizada: TEditFocus;
    fraDadosPorEmpresa: TfraDadosDeBaixaOtimizadaCartoes;
    dtsConPor: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure fraDadosPorEmpresadbeCtaAntKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraDadosPorEmpresadbeCtaFreteKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraDadosPorEmpresadbeCtaCupKeyPress(Sender: TObject;
      var Key: Char);
  private
    qryCadEmp: TUniQuery;

    FExibeCampoFrete,
    FExibeCampoCupom: Boolean;

    function fValidaEmpresaOtimizada: Boolean;

    procedure pAcertaDadosExibicaoGridPortadores;
    procedure pAcertaDadosExibicaoGridPlanoDeContas;
    procedure pAcertaDadosExibicaoGridCentroDeCustos;
    procedure pAcertaDadosExibicaoGridFornecedorTaxa;
    { Private declarations }
  public
    cdsValidaConPor: TUniCLientDataSet;

    property ExibeCampoFrete: Boolean read  FExibeCampoFrete write FExibeCampoFrete;
    property ExibeCampoCupom: Boolean read  FExibeCampoCupom write FExibeCampoCupom;

    procedure pCarregaEmpresa;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation
Uses untConsultas, untPesqAux, untFuncoesSimples;

procedure TfrmCadCartoesBaixaOtimizada.btnSairClick(Sender: TObject);
begin
  inherited;
  dtsConPor.Dataset.Cancel;
end;

procedure TfrmCadCartoesBaixaOtimizada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If ModalResult = mrOK Then
  Begin
    If (Not fVerificaCampos) Or
       (Not fValidaEmpresaOtimizada) Or
       (Not fraDadosPorEmpresa.fVerificaCampos) Then
    Begin
      Action := CaNone;
      Exit;
    End;

    pAcertaDadosExibicaoGridPortadores;
    pAcertaDadosExibicaoGridPlanoDeContas;
    pAcertaDadosExibicaoGridCentroDeCustos;
    pAcertaDadosExibicaoGridFornecedortaxa;

    If dtsConPor.Dataset.FieldByName('AUTOINCREM').AsString.IsEmpty Then
    Begin
      dtsConPor.Dataset.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CONPOR', VS_strCodEmp);
      dtsConPor.Dataset.FieldByName('CON_DTACAD').AsDateTime := VS_DATE;
      dtsConPor.Dataset.FieldByName('CON_CODOPE').AsString := strLoginUsuarioLogado;
    End;

    dtsConPor.Dataset.Post;
  End
  Else If ModalResult = mrCancel Then
    dtsConPor.Dataset.Cancel;

  inherited;

  If Assigned(qryCadEmp) Then
    FreeAndNil(qryCadEmp);
end;

procedure TfrmCadCartoesBaixaOtimizada.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE');

  fraDadosPorEmpresa.OnFormCreate(Self);

  FExibeCampoFrete := False;
  FExibeCampoCupom := False;
end;

procedure TfrmCadCartoesBaixaOtimizada.FormShow(Sender: TObject);
begin
  inherited;
  fraDadosPorEmpresa.pCarregaDados;

  pSetFocus(dbeCodEmpOtimizada);
  If dtsConPor.Dataset.State <> dsInsert Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
    dbeCodEmpOtimizada.Enabled := False;
  End;

  fraDadosPorEmpresa.dbeCtaCar.Field.EditMask := '99.99.999;0;_';
  fraDadosPorEmpresa.dbeCtaTax.Field.EditMask := '99.99.999;0;_';
  fraDadosPorEmpresa.dbeCtaBad.Field.EditMask := '99.99.999;0;_';
  fraDadosPorEmpresa.dbeCtaAju.Field.EditMask := '99.99.999;0;_';
  fraDadosPorEmpresa.dbeCtaAnt.Field.EditMask := '99.99.999;0;_';
  fraDadosPorEmpresa.dbeCtaCup.Field.EditMask := '99.99.999;0;_';

  fraDadosPorEmpresa.grpFretes.Visible := FExibeCampoFrete;
  fraDadosPorEmpresa.grpCupons.Visible := FExibeCampoCupom;
  fraDadosPorEmpresa.OnFormShow(Self);
end;

function TfrmCadCartoesBaixaOtimizada.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodEmpOtimizada) Then
    Begin

      If fEmptyStr(dbeCodEmpOtimizada.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A empresa deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaEmpresa;
        If (qryCadEmp.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Pos(dbeCodEmpOtimizada.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
          Result := False;
        End
        Else If qryCadEmp.FieldByName('EMP_EMPATI').AsString = 'N' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esta empresa está inativa no Cadastro de Empresas.' + #13#10 +
                    'Não é possível utilizá-la nesta rotina.', ['&O k']);
          Result := False;
        End;
      End;

    End;

    If Not Result Then
      pSetFocus(Sender);
  End;
end;

procedure TfrmCadCartoesBaixaOtimizada.fraDadosPorEmpresadbeCtaFreteKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  fraDadosPorEmpresa.dbeCtaFreteKeyPress(Sender, Key);

end;

procedure TfrmCadCartoesBaixaOtimizada.fraDadosPorEmpresadbeCtaAntKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  fraDadosPorEmpresa.dbeCtaAntKeyPress(Sender, Key);

end;

procedure TfrmCadCartoesBaixaOtimizada.fraDadosPorEmpresadbeCtaCupKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  fraDadosPorEmpresa.dbeCtaCupKeyPress(Sender, Key);

end;

procedure TfrmCadCartoesBaixaOtimizada.pCarregaEmpresa;
Begin
  pPesquisaCadEmp(Nil, qryCadEmp, dbeCodEmpOtimizada.Text);
  edtDesEmpOtimizada.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;

  If (Not fEmptyStr(edtDesEmpOtimizada.Text)) Then
    fraDadosPorEmpresa.strEmpresa := dbeCodEmpOtimizada.Text;
End;

function TfrmCadCartoesBaixaOtimizada.fValidaEmpresaOtimizada: Boolean;
begin
  Result := (dtsConPor.DataSet.State <> dsInsert) Or
            (Not cdsValidaConPor.Locate('CON_CODEMP', dbeCodEmpOtimizada.Text, []));

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'Os dados de baixa otimizada da empresa selecionada já estão cadastrados!', ['&OK']);
    pSetFocus(dbeCodEmpOtimizada);
  End;
end;

procedure TfrmCadCartoesBaixaOtimizada.pAcertaDadosExibicaoGridCentroDeCustos;
begin
  dtsConPor.Dataset.FieldByName('DESEVECRE').Clear;
  If (Not fEmptyStr(fraDadosPorEmpresa.dbeEventoBaixa.Text)) Then
    dtsConPor.Dataset.FieldByName('DESEVECRE').AsString := fraDadosPorEmpresa.dbeEventoBaixa.Text + '-' +
                                                           fraDadosPorEmpresa.edtEventoBaixa.Text;

  dtsConPor.Dataset.FieldByName('DESEVETAX').Clear;
  If (Not fEmptyStr(fraDadosPorEmpresa.dbeEventoTaxaBaixa.Text)) Then
    dtsConPor.Dataset.FieldByName('DESEVETAX').AsString := fraDadosPorEmpresa.dbeEventoTaxaBaixa.Text + '-' +
                                                           fraDadosPorEmpresa.edtEventoTaxaBaixa.Text;

  dtsConPor.Dataset.FieldByName('DESEVEDEB').Clear;
  If (Not fEmptyStr(fraDadosPorEmpresa.dbeEveDeb.Text)) Then
    dtsConPor.Dataset.FieldByName('DESEVEDEB').AsString := fraDadosPorEmpresa.dbeEveDeb.Text + '-' +
                                                           fraDadosPorEmpresa.edtDesEve.Text;
end;

procedure TfrmCadCartoesBaixaOtimizada.pAcertaDadosExibicaoGridFornecedorTaxa;
begin
  dtsConPor.Dataset.FieldByName('DESFORTAX').Clear;
  If (Not fEmptyStr(fraDadosPorEmpresa.dbeFortax.Text)) Then
    dtsConPor.Dataset.FieldByName('DESFORTAX').AsString := fraDadosPorEmpresa.dbeForTax.Text + '-' +
                                                           fraDadosPorEmpresa.edtForTax.Text;
end;

procedure TfrmCadCartoesBaixaOtimizada.pAcertaDadosExibicaoGridPlanoDeContas;
begin
  dtsConPor.Dataset.FieldByName('DESCTACRE').Clear;
  If (Not fEmptyStr(fraDadosPorEmpresa.dbeCtaCar.Text)) Then
    dtsConPor.Dataset.FieldByName('DESCTACRE').AsString := fraDadosPorEmpresa.dbeCtaCar.Text + '-' +
                                                   fraDadosPorEmpresa.edtCtaCar.Text;

  dtsConPor.Dataset.FieldByName('DESCTATAX').Clear;
  If (Not fEmptyStr(fraDadosPorEmpresa.dbeCtaTax.Text)) Then
    dtsConPor.Dataset.FieldByName('DESCTATAX').AsString := fraDadosPorEmpresa.dbeCtaTax.Text + '-' +
                                                           fraDadosPorEmpresa.edtCtaTax.Text;

  dtsConPor.Dataset.FieldByName('DESCTADEB').Clear;
  If (Not fEmptyStr(fraDadosPorEmpresa.dbeCtaBad.Text)) Then
    dtsConPor.Dataset.FieldByName('DESCTADEB').AsString := fraDadosPorEmpresa.dbeCtaBad.Text + '-' +
                                                           fraDadosPorEmpresa.edtCtabad.Text;

  dtsConPor.Dataset.FieldByName('DESCTAAJU').Clear;
  If (Not fEmptyStr(fraDadosPorEmpresa.dbeCtaAju.Text)) Then
    dtsConPor.Dataset.FieldByName('DESCTAAJU').AsString := fraDadosPorEmpresa.dbeCtaAju.Text + '-' +
                                                           fraDadosPorEmpresa.edtCtaAju.Text;

  dtsConPor.Dataset.FieldByName('DESCTAANT').Clear;
  If (Not fEmptyStr(fraDadosPorEmpresa.dbeCtaAnt.Text)) Then
    dtsConPor.Dataset.FieldByName('DESCTAANT').AsString := fraDadosPorEmpresa.dbeCtaAnt.Text + '-' +
                                                           fraDadosPorEmpresa.edtCtaAnt.Text;

  dtsConPor.Dataset.FieldByName('DESCTAFRE').Clear;
  If (Not fEmptyStr(fraDadosPorEmpresa.dbeCtaFrete.Text)) Then
    dtsConPor.Dataset.FieldByName('DESCTAFRE').AsString := fraDadosPorEmpresa.dbeCtaFrete.Text + '-' +
                                                           fraDadosPorEmpresa.edtDescricaoCtaFrete.Text;

  dtsConPor.Dataset.FieldByName('DESCTACUP').Clear;
  If (Not fEmptyStr(fraDadosPorEmpresa.dbeCtaCup.Text)) Then
    dtsConPor.Dataset.FieldByName('DESCTACUP').AsString := fraDadosPorEmpresa.dbeCtaCup.Text + '-' +
                                                           fraDadosPorEmpresa.edtDescricaoCupons.Text;
end;

procedure TfrmCadCartoesBaixaOtimizada.pAcertaDadosExibicaoGridPortadores;
begin
  dtsConPor.Dataset.FieldByName('DESPORCRE').Clear;
  If (Not fEmptyStr(fraDadosPorEmpresa.dbePorBai.Text)) Then
    dtsConPor.Dataset.FieldByName('DESPORCRE').AsString := fraDadosPorEmpresa.dbePorBai.Text + '-' +
                                                           fraDadosPorEmpresa.edtPorBai.Text;

  dtsConPor.Dataset.FieldByName('DESPORTAX').Clear;
  If (Not fEmptyStr(fraDadosPorEmpresa.dbePorTax.Text)) Then
    dtsConPor.Dataset.FieldByName('DESPORTAX').AsString := fraDadosPorEmpresa.dbePorTax.Text + '-' +
                                                           fraDadosPorEmpresa.edtPorTax.Text;

  dtsConPor.Dataset.FieldByName('DESPORDEB').Clear;
  If (Not fEmptyStr(fraDadosPorEmpresa.dbePorBad.Text)) Then
    dtsConPor.Dataset.FieldByName('DESPORDEB').AsString := fraDadosPorEmpresa.dbePorBad.Text + '-' +
                                                           fraDadosPorEmpresa.edtPorBad.Text;
end;

{$R *.dfm}

end.
