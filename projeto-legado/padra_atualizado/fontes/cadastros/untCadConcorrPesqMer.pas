unit untCadConcorrPesqMer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, QColorLabel, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, Data.DB, EditFocus, Uni;

type
  TfrmCadConcorrPesqMer = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    lbl1: TLabel;
    dbeStatus: TDBEditFocus;
    lbl2: TColorLabel;
    Label2: TLabel;
    DBENOMCON: TDBEditFocus;
    Label3: TLabel;
    DBEENDERE: TDBEditFocus;
    Label4: TLabel;
    DBEENDNUM: TDBEditFocus;
    Label6: TLabel;
    DBEENDCMP: TDBEditFocus;
    Label5: TLabel;
    DBEBAIRRO: TDBEditFocus;
    dtsCadConcorr: TDataSource;
    Label7: TLabel;
    DBECIDADE: TDBEditFocus;
    edtNomCid: TEditFocus;
    Label10: TLabel;
    edtEstado: TEditFocus;
    Label9: TLabel;
    dbeNumCEp: TDBEditFocus;
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    function DBECIDADEChamaCadastro(Key: Word): string;
    procedure DBECIDADEKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryConCid: TUniQuery;
    qryCadCid: TUniQuery;
    strCepAnt: String;
  public
    { Public declarations }
    strCodConcorrenteIniciarCadastro : String;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pLimpaEditsCidade;
    procedure pCarregaCidade;
    procedure pAtualizaCidade(qryConsulta: TUniQuery; edtCidade, edtEstado: TEdit;
      dbeCidade, dbeCep: TDBEditFocus; Var strCepAnt: String);
  end;

var
  frmCadConcorrPesqMer: TfrmCadConcorrPesqMer;

implementation

uses untPai, untFuncoesSimples, untConsultas, untTypesSistema, untPesqAux, untFuncIns2, untCadCid, untCadCidades;

{$R *.dfm}

procedure TfrmCadConcorrPesqMer.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeNomCon, False);
end;

procedure TfrmCadConcorrPesqMer.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadConcorPesqMer.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadConcorrPesqMer.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadConcorPesqMer.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadConcorrPesqMer.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pLimpaEditsCidade;
  QryTabela.fieldbyname('CCR_STATUS').Asstring := 'A';
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeNomCon, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeNomCon, True);
end;

procedure TfrmCadConcorrPesqMer.btnPesquisaClick(Sender: TObject);

  Var
    chrKey: Char;
    arrConcor: TConsultasArray;
begin
  chrKey := '/';
  If fPesqConcorrente(Self, dbeCodigo, Nil, qryTabela, chrKey, arrConcor) Then
  begin
    pCarregaCidade;
    pSetFocus(btnAlterar);
  end;
end;


function TfrmCadConcorrPesqMer.DBECIDADEChamaCadastro(Key: Word): string;
begin
  inherited;
  Result    := fChamaCadCid(Key);
  qryConCid := qryCadCid;
end;

procedure TfrmCadConcorrPesqMer.DBECIDADEKeyPress(Sender: TObject; var Key: Char);
Var
    arrCidade: TConsultasArray;
begin
  inherited;

  If fPesqCidade(Self, dbeCidade, edtNomCid, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeCidade, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadConcorrPesqMer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If (Action <> caNone) Then
  Begin
    FreeAndNil(qryCadCid);
  End;
end;

procedure TfrmCadConcorrPesqMer.FormCreate(Sender: TObject);
begin
  inherited;
  strCodConcorrenteIniciarCadastro := '';

  strNomeTabela         := 'CADCCR';
  strNomeCampo          := 'CCR_CODIGO';
  qryTabela             := fCriarQuery('SELECT * FROM CADCCR', Self);
  dtsCadConcorr.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

function TfrmCadConcorrPesqMer.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
    blnAtualizar: Boolean;
    strCodCid: string;
    strEndere: string;
    strBairro: string;
    strNomCid: string;
    strEstado: string;
    LCodigoCorreio: String;
begin
  Result := True;

  If (Sender = dbeCodigo) Then
  Begin
    If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do Concorrente deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (blnBuscaPorChave) Then
     Begin
       If Not fBuscaPorCamposChave Then
         pLimparCampos;
     End;

  End
  Else If (Sender = dbeNomCon) Then
  Begin

    If fEmptyStr(dbeNomCon.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Nome do Concorrente deve ser preenchido!', ['&Ok']);
      Result := False;
    End;

  End
  Else If (Sender = dbeStatus) Then
  Begin

    If fEmptyStr(dbeStatus.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Situação deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If ((dbeStatus.Text <> 'A') and (dbeStatus.Text <> 'I')) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo Situação deve ser preenchido com ''A'' ou ''I''!', ['&Ok']);
      Result := False;
    End;

  End
  Else If (Sender = dbeCidade) Then
  Begin
    If Not fEmptyStr(dbeCidade.Text) Then
    Begin
      If Not fEmptyStr(fRetNomCidade(dbeCidade.Text)) Then
      Begin
        pCarregaCidade;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Length(dbeCidade.Text) > 0) And (Length(dbeCidade.Text) < dbeCidade.Field.Size) Then
    Begin
      fMensagem('ATENÇÃO!', 'O código da cidade deve ter ' + IntToStr(dbeCidade.Field.Size) + ' caracteres!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pLimpaEditsCidade;
    End;
  End
  Else If (Sender = dbeNumCep) Then
  Begin

    If (Not fEmptyStr(fTiraCaracEspeciais(dbeNumCep.Text))) Then
    Begin
      If Length(Trim(fTiraCaracEspeciais(dbeNumCep.Text))) < 8 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Cep deve ser vazio ou com 8 digitos.', ['&Ok']);
        Result := False;
      End;
    End;

    If (Result) And (fCfgSis('USACEP', varBoolean)) And (Not fEmptyStr(fTiraCaracEspeciais(dbeNumCep.Text))) Then
    Begin

      If (Not fCadCepDadosCep(dbeNumCep.Text,
                              strCodCid,
                              strEndere,
                              strBairro,
                              strNomCid,
                              strEstado,
                              LCodigoCorreio,
                              '',
                              '')) Then
      Begin
        Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
      End
      Else
      Begin

        If (fEmptyStr(dbeCidade.Text)) Then
        Begin

          If Not fEmptyStr(fRetNomCidade(dbeCidade.Text)) Then
          Begin

            If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + edtNomCid.Text + ' está em branco.' + #13#10 +
                         'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?', ['&Sim', '&Não']) = 1 Then
            Begin
              pAtualizaCodigoCorreios(dbeCidade.Text, dbeNumCep.Text);
            End

            Else
              Result := False;

          End
          Else
          Begin
            fMensagem('ATENÇÃO!', 'Esse CEP não tem nenhum endereço associado no cadastro do AutCom.' + #13#10 +
                                  'Será aberto o Cadastro de Cidades para o preenchimento do Código Correios.', ['&Ok']);
            pCriarForm(TfrmCadCidades);

            Result := False;
          End;
        End

        {***********************************}
        {* CASO O CEP NÃO POSSUIR ENDERECO *}
        {********************************JB*}
        Else If (Not fEmptyStr(edtNomCid.Text)) And (fEmptyStr(dbeEndere.Field.AsString)) Then
        Begin
          dbeEndere.Field.AsString := fTiraCaracEspeciais(edtNomCid.Text);
          strEndere                := dbeEndere.Field.AsString;
        End;

        If (Result) Then
        Begin

          blnAtualizar := False;
          If fTiraCaracEspeciais(strCepAnt) <> fTiraCaracEspeciais(dbeNumCep.Text) Then
          Begin
            If fTiraCaracEspeciais(strCepAnt) = '' Then
            Begin
              blnAtualizar := True;
            End
            Else
            If fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1 Then
            Begin
              blnAtualizar := True;
            End

          End;

          If fEmptyStr(dbeCidade.Text) Or (blnAtualizar) Then
          Begin
            dbeCidade.Field.AsString := strCodCid;
            pAtualizaCidade(qryConCid, edtNomCid, edtEstado, dbeCidade, Nil, strCepAnt);
          End;

          If fEmptyStr(dbeEndere.Text) Or (blnAtualizar) Then
            dbeEndere.Field.AsString := strEndere;

          If fEmptyStr(dbeBairro.Text) Or (blnAtualizar) Then
            dbeBairro.Field.AsString := strBairro;

          If (strCodCid <> dbeCidade.Text) And (Not fEmptyStr(strCodCid)) And (Not fEmptyStr(DbeNumCep.text)) Then
          Begin
            Result := False;
            pMensagemOk('O CEP informado não pertence a cidade de ' + fRetNomCidade(dbeCidade.Text) + '!');
          End;

        End;

      End;

      If (Result) Then
        strCepAnt := dbeNumCep.Text;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadConcorrPesqMer.pAtualizaCidade(qryConsulta: TUniQuery; edtCidade,
  edtEstado: TEdit; dbeCidade, dbeCep: TDBEditFocus; var strCepAnt: String);
begin
  pPesquisaCadCid(qryCadCid, qryConsulta, dbeCidade.Text);

  edtCidade.Text := qryConsulta.FieldByName('CID_NOMCID').AsString;
  edtEstado.Text := qryConsulta.FieldByName('CID_ESTADO').AsString;

  If (Assigned(dbeNumCEp)) And (dbeNumCEp.Field <> Nil) And (dbeNumCEp.Field.IsNull) Then
  Begin
    dbeNumCEp.Text := qryConsulta.FieldByName('CID_C_E_P_').AsString;
    strCepAnt   := qryConsulta.FieldByName('CID_C_E_P_').AsString;
  End;
end;

procedure TfrmCadConcorrPesqMer.pCarregaCidade;
begin
  pPesquisaCadCid(qryCadCid, qryConCid, dbeCidade.Text);
  With qryConCid Do
  Begin
    edtNomCid.Text := FieldByName('CID_NOMCID').AsString;
    edtEstado.Text := FieldByName('CID_ESTADO').AsString;
    If (dbeNumCEp.Field <> Nil) And (dbeNumCEp.Field.IsNull) Then
      dbeNumCEp.Text := qryConCid.FieldByName('CID_C_E_P_').AsString;
  End;
end;

procedure TfrmCadConcorrPesqMer.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CCR_CODIGO');
  stlCampos.Add('CCR_NOMCON');
  stlCampos.Add('CCR_STATUS');
  stlCampos.Add('CCR_ENDERE');
  stlCampos.Add('CCR_ENDNUM');
  stlCampos.Add('CCR_ENDCOM');
  stlCampos.Add('CCR_BAIRRO');
  stlCampos.Add('CCR_C_E_P_');
  stlCampos.Add('CCR_CODCID');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CCR_NOMCON');
  stlCamInd.Add('CCR_CODIGO');
  stlCamInd.Add('CCR_STATUS');
  stlCamInd.Add('CCR_ENDERE');
  stlCamInd.Add('CCR_ENDNUM');
  stlCamInd.Add('CCR_ENDCOM');
  stlCamInd.Add('CCR_BAIRRO');
  stlCamInd.Add('CCR_C_E_P_');
  stlCamInd.Add('CCR_CODCID');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
  stlDesInd.Add('Status');
  stlDesInd.Add('Endereço');
  stlDesInd.Add('Número');
  stlDesInd.Add('Complemento');
  stlDesInd.Add('Bairro');
  stlDesInd.Add('CEP');
  stlDesInd.Add('Cidade');

  qryCadCid := fCriaQuery(Self);
  qryConCid := qryCadCid;
end;

procedure TfrmCadConcorrPesqMer.pLimpaEditsCidade;
begin
  edtNomCid.Clear;
  edtEstado.Clear;
end;

end.
