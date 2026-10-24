unit untCadMaterialConsumo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, DB, QColorLabel, EditFocus, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, untTypesSistema,
  untFramePlanoDeContasDBEditFocus;

type
  TfrmCadMaterialConsumo = class(TfrmPaiCad)
    Panel1: TPanel;
    dbeCodMco: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dbePreCom: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dtsCadMco: TDataSource;
    ColorLabel4: TColorLabel;
    dbeMcoAti: TDBEditFocus;
    Label67: TLabel;
    Label7: TLabel;
    dbeCodFor: TDBEditFocus;
    edtNomFor: TEditFocus;
    Label8: TLabel;
    dbeCodFab: TDBEditFocus;
    Label9: TLabel;
    dbeCodBar: TDBEditFocus;
    fraPlanoDeContasPla: TfraPlanoDeContasDBEditFocus;
    fraPlanoDeContasSec: TfraPlanoDeContasDBEditFocus;

    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure fraPlanoDeContasPladbeCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasSecdbeCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasSecdbeCodCtaExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }

    arrPlanoCta,
    arrFornec: TConsultasArray;

    strPlCta, strPlCtaSec : String;

    Procedure pCarregaDados;

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;


implementation

uses untPai, StrUtils,
     untFuncoesSimples, untConsultas, untFuncoesConsulta, untConstantes;

{$R *.dfm}

Procedure TfrmCadMaterialConsumo.pCarregaDados;
Begin
  edtNomFor.Text := fRetNomFornecedor(dbeCodFor.Text);
  fraPlanoDeContasPla.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasPla.dbeCodCta.Text);
  fraPlanoDeContasSec.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasSec.dbeCodCta.Text);

End;

procedure TfrmCadMaterialConsumo.fraPlanoDeContasPladbeCodCtaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqCentroCusto(Self, fraPlanoDeContasPla.dbeCodCta, fraPlanoDeContasPla.edtDesCta, Nil, Key, arrPlanoCta, False) Then
  Begin
    If fValidaCampos(fraPlanoDeContasPla.dbeCodCta, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMaterialConsumo.fraPlanoDeContasSecdbeCodCtaExit(
  Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraPlanoDeContasSec.dbeCodCta, fraPlanoDeContasSec.edtDesCta, arrPlanoCta, fRetNomeConta, Nil, 'do Plano de Contas', 7);

  fraPlanoDeContasSec.dbeCodCtaExit(Sender);
end;

procedure TfrmCadMaterialConsumo.fraPlanoDeContasSecdbeCodCtaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCentroCusto(Self, fraPlanoDeContasSec.dbeCodCta, fraPlanoDeContasSec.edtDesCta, Nil, Key, arrPlanoCta) Then
  Begin
    If fValidaCampos(fraPlanoDeContasSec.dbeCodCta, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadMaterialConsumo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dbeCodFor) Then
  Begin

    If fEmptyStr(dbeCodFor.Text) Then
    Begin
      edtNomFor.Clear;
    End Else
    Begin

      edtNomFor.Text := fRetNomFornecedor(dbeCodFor.Text);

      If fEmptyStr(edtNomFor.Text) Then
      Begin
        Result := False;
        pMensagemOk('Fornecedor não encontrado!');
      End;
    End;

  End

  Else If (Sender = dbeCodMco) Then
  Begin

    If (fEmptyStr(dbeCodMco.Text)) And (dbeCodMco.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do Material de Consumo deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
    Begin
      If Not fBuscaPorCamposChave Then
        pLimparCampos;
    End;

  End
  Else If (Sender = dbeDescri) Then
  Begin

    If fEmptyStr(dbeDescri.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição do Material de Consumo deve ser preenchido!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = dbeMcoAti) Then
  Begin
    If Not fValidoSimNao((Sender As TDBEditFocus).Text) Then
    Begin
      Result := False;
      fMensagem('', 'O campo ativo deve ser "S" ou "N"!', ['&Ok']);
    End;
  End

  {*****************************************}
  {* VALIDA O PREÇO DE COMPRA              *}
  {**************************************CI*}
  Else If (Sender = dbePreCom) Then
  Begin
    If fEmptyStr(dbePreCom.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Preço de Compra deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbePreCom.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Preço de Compra deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = fraPlanoDeContasPla.dbeCodCta) Then
  Begin

    If fEmptyStr(fraPlanoDeContasPla.dbeCodCta.Text) Then
    Begin
      fraPlanoDeContasPla.edtDesCta.Clear
    End Else
    Begin
      fraPlanoDeContasPla.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasPla.dbeCodCta.Text);

      If fEmptyStr(fraPlanoDeContasPla.edtDesCta.Text) Then
      Begin
        pMensagemOk('Plano de contas não encontrado!');
        Result := False;
      End

      Else If SameText(RightStr(fraPlanoDeContasPla.dbeCodCta.Text, 3), '000') Then
      Begin
        fMensagem('ATENÇÃO!', 'Plano de Contas não permitido por se tratar de um grupo!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        if (qryTabela.State in [dsInsert]) or  (strPlCta <> fraPlanoDeContasPla.dbeCodCta.Text) then
          Result := PlanoDeContasAtivo(fraPlanoDeContasPla.dbeCodCta.Text,True);

      End;
    End;
  End
  Else If (Sender = fraPlanoDeContasSec.dbeCodCta) Then
  Begin

    If fEmptyStr(fraPlanoDeContasSec.dbeCodCta.Text) Then
    Begin
      fraPlanoDeContasSec.edtDesCta.Clear
    End Else
    Begin
      fraPlanoDeContasSec.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasSec.dbeCodCta.Text);

      If fEmptyStr(fraPlanoDeContasSec.edtDesCta.Text) Then
      Begin
        pMensagemOk('Plano de contas não encontrado!');
        Result := False;
      End

      Else If SameText(RightStr(fraPlanoDeContasSec.dbeCodCta.Text, 3), '000') Then
      Begin
        fMensagem('ATENÇÃO!', 'Plano de Contas não permitido por se tratar de um grupo!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        if (qryTabela.State in [dsInsert]) or  (strPlCtaSec <> fraPlanoDeContasSec.dbeCodCta.Text) then
          Result := PlanoDeContasAtivo(fraPlanoDeContasSec.dbeCodCta.Text,True);

      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadMaterialConsumo.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

end;

procedure TfrmCadMaterialConsumo.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela     := 'CADMCO';
  strNomeCampo      := 'MCO_CODMCO';
  qryTabela         := fCriarQuery('SELECT * FROM CADMCO', Self);
  dtsCadMco.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodMco;

  strPlCta    := '';
  strPlCtaSec := '';

  TFloatField(qryTabela.FieldByName('MCO_PRECOM')).DisplayFormat := '#,##0.00';
  qryTabela.FieldByName('MCO_CODCTA').EditMask := MASC_CODCTA;
  qryTabela.FieldByName('MCO_CODCT2').EditMask := MASC_CODCTA;
end;

procedure TfrmCadMaterialConsumo.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);

end;

procedure TfrmCadMaterialConsumo.btnCancelaClick(Sender: TObject);
begin
  inherited;

  pCarregaDados;
end;

procedure TfrmCadMaterialConsumo.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMaterialConsumo.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadMaterialConsumo.btnGravarClick(Sender: TObject);
begin

  With qryTabela Do
  Begin
    If fEmptyStr(dbeCodFor.Text) Then
      FieldByName('MCO_CODFOR').Clear;

    If fEmptyStr(fraPlanoDeContasPla.dbeCodCta.Text) Then
      FieldByName('MCO_CODCTA').Clear;

    If fEmptyStr(dbeCodBar.Text) Then
      FieldByName('MCO_CODBAR').Clear;

    If fEmptyStr(dbeCodFab.Text) Then
      FieldByName('MCO_CODFAB').Clear;

    If fEmptyStr(FieldByName('MCO_CODCT2').AsString) Then
      FieldByName('MCO_CODCT2').Clear;
  End;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadMaterialConsumo.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pCarregaDados;

end;

procedure TfrmCadMaterialConsumo.btnIncluirClick(Sender: TObject);
begin
  inherited;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodMco, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodMco, dbeDescri, True);

  qryTabela.FieldByName('MCO_MCOATI').AsString := 'S';
  qryTabela.FieldByName('MCO_PRECOM').AsFloat  := 0.00;
  TFloatField(qryTabela.FieldByName('MCO_PRECOM')).DisplayFormat := '#,##0.00';

  pCarregaDados;

  strPlCta    := '';
  strPlCtaSec := '';
end;


procedure TfrmCadMaterialConsumo.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrMco: TConsultasArray;
begin

  {**************************************}
  {* NOVA CONSULTA DE MATERIAL CONSUMO  *}
  {***********************************CI*}
  chrKey := '/';
  If fPesqMaterialConsumo(Self, Nil, Nil, qryTabela, chrKey, arrMco) Then
  Begin
    If btnAlterar.CanFocus Then
      pSetFocus(btnAlterar);

    pCarregaDados;
  End;

  TFloatField(qryTabela.FieldByName('MCO_PRECOM')).DisplayFormat := '#,##0.00';
  qryTabela.FieldByName('MCO_CODCTA').EditMask := '99.99.999;0;_';
  qryTabela.FieldByName('MCO_CODCT2').EditMask := '99.99.999;0;_';
end;

procedure TfrmCadMaterialConsumo.dbeCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, dbeCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbeCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadMaterialConsumo.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodMco, dbeDescri, False);
  strPlCta    := qryTabela.FieldByName('MCO_CODCTA').asString;
  strPlCtaSec := qryTabela.FieldByName('MCO_CODCT2').asString;
end;

end.
