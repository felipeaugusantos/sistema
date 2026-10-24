unit untCadEndPartidaConsFrete;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdenaEdit, Data.DB,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus,
  Vcl.Mask, MaskEditFocus, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.ComCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.DBCtrls, QColorLabel,
  DBEditFocus, cxProgressBar, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadEndPartidaConsFrete = class(TfrmPaiOrdenaEdit)
    lblDescri: TLabel;
    dbeDescri: TDBEditFocus;
    lblSituacao: TLabel;
    dbeSituac: TDBEditFocus;
    lblAtivoInativo: TColorLabel;
    lblCepEnd: TLabel;
    dbeCepEnd: TDBEditFocus;
    lblCidade: TLabel;
    dbeCodCid: TDBEditFocus;
    dbeNomCid: TDBEditFocus;
    lblEstado: TLabel;
    dbeEstado: TDBEditFocus;
    lblEndere: TLabel;
    dbeEndere: TDBEditFocus;
    lblNumero: TLabel;
    dbeNumero: TDBEditFocus;
    lblBairro: TLabel;
    dbeBairro: TDBEditFocus;
    dbckEndPad: TDBCheckBox;
    btnConfirma: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cdsConsultaNewRecord(DataSet: TDataSet);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbgConsultaTitleClick(Column: TColumn);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    strCepAnt: String;
    function fValidaEnderecoAtivo: Boolean;
    function fValidaEnderecoPadrao: Boolean;
    function fAtualizaEnderecoPeloCEP: Boolean;
    function fConfirmaGravacao(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCarregaCidade;
  public
    { Public declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; override;
    function fSetParametros: Boolean; override;
    procedure pMascaraValor; override;
    procedure pOnStateChange; override;
  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas, untCadCid;

{$R *.dfm}

procedure TfrmCadEndPartidaConsFrete.btnIncluirClick(Sender: TObject);
begin
  inherited;
  strCepAnt := '';
end;

procedure TfrmCadEndPartidaConsFrete.btnAlterarClick(Sender: TObject);
begin
  inherited;
  strCepAnt := dbeCepEnd.Text;
end;

procedure TfrmCadEndPartidaConsFrete.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If cdsConsulta.RecordCount = 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum endereço cadastrado!', ['&Ok']);
    Exit;
  End;

  If (Not fValidaEnderecoAtivo) Then
    Exit;

  If (Not fValidaEnderecoPadrao) Then
    Exit;

  If (Not fPergunta('Confirma a gravação?')) Then
    Exit;

  If fExecutarModal(fConfirmaGravacao, 'Aguarde, gravando...', '') Then
    ModalResult := mrOk;
end;

procedure TfrmCadEndPartidaConsFrete.cdsConsultaNewRecord(DataSet: TDataSet);
begin
  inherited;
  cdsConsulta.FieldByName('END_SITUAC').AsString := 'A';
  cdsConsulta.FieldByName('END_ENDPAD').AsString := IIF(cdsConsulta.RecordCount = 0, 'S', 'N');
end;

procedure TfrmCadEndPartidaConsFrete.dbeCodCidKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqCidade(Self, dbeCodCid, nil, nil, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(dbeCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEndPartidaConsFrete.dbgConsultaTitleClick(Column: TColumn);
begin
 // inherited;
end;

procedure TfrmCadEndPartidaConsFrete.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  If ModalResult <> mrOk Then
    CanClose := fPergunta('Deseja realmente cancelar?');
end;

procedure TfrmCadEndPartidaConsFrete.FormCreate(Sender: TObject);
begin
  inherited;
  btnSair.Align         := alRight;
  strCamChave           := 'AUTOINCREM';
  blnTemPesquisa        := False;
  blnSelecionaComEspaco := False;
  blnUsaProxCodVirtual  := False;
end;

procedure TfrmCadEndPartidaConsFrete.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    If btnConfirma.Enabled Then
      btnConfirma.Click;
end;

function TfrmCadEndPartidaConsFrete.fAtualizaEnderecoPeloCEP: Boolean;
  Var
    strCodCid, strEndere, strBairro, strNomCid, strEstado, strCodCor: String;
    strCidadesComMesmoCodCor: String;
    blnAtualizar: Boolean;
begin
  Result := True;

  If (Not fCadCepDadosCep(dbeCepEnd.Text, strCodCid, strEndere, strBairro, strNomCid, strEstado, strCodCor)) Then
  Begin
    If (fCfgSis('INVCEP', varInteger) = 1) Then
    Begin
      Result := fPergunta('CEP não encontrado!' + sLineBreak + 'Deseja continuar mesmo assim?', False);
      Exit;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'CEP não encontrado! Verifique o cadastro de cidades e depois tente novamente.', ['&Ok']);
      Exit(False);
    End;
  End;

  If fEmptyStr(strCodCid) Then
  Begin
    If Not fEmptyStr(fRetNomCidade(dbeCodCid.Text)) Then
    Begin
      If fPergunta('O Código Correios da cidade ' + dbeNomCid.Text + ' está em branco.' + sLineBreak +
                   'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?') Then
        pAtualizaCodigoCorreios(dbeCodCid.Text, dbeCepEnd.Text)
      Else
        Exit(False);
    End
  End;

  blnAtualizar := False;

  If fTiraCaracEspeciais(strCepAnt) <> fTiraCaracEspeciais(dbeCepEnd.Text) Then
  Begin
    If (fTiraCaracEspeciais(strCepAnt) = '') Or
       (fPergunta('O CEP foi alterado, deseja atualizar o endereço?')) Then
      blnAtualizar := True;
  End;

  If fEmptyStr(dbeCodCid.Text) Or ((blnAtualizar) And (Not fEmptyStr(strCodCid))) Then
  Begin
    dbeCodCid.Field.AsString := strCodCid;
    pCarregaCidade;
  End;

  If fEmptyStr(dbeEndere.Text) Or (blnAtualizar) Then
    dbeEndere.Field.AsString := strEndere;

  If fEmptyStr(dbeBairro.Text) Or (blnAtualizar) Then
    dbeBairro.Field.AsString := strBairro;

  If (Not fEmptyStr(strNomCid)) And (fEmptyStr(dbeEndere.Field.AsString)) Then
    dbeEndere.Field.AsString := fTiraCaracEspeciais(strNomCid);

  If (strCodCid <> dbeCodCid.Text) And (Not fEmptyStr(strCodCid)) Then
  Begin
    strCidadesComMesmoCodCor := RetornaCodigosDeCidadesComOMesmoCodCor(strCodCid, strEstado, strCodCor);

    If Pos(dbeCodCid.Text + '_', strCidadesComMesmoCodCor) = 0 Then
    Begin
      pMensagemOk('O CEP informado não pertence a cidade de ' + fRetNomCidade(dbeCodCid.Text) + '!');
      Exit(False);
    End;
  End;

  strCepAnt := dbeCepEnd.Text;

  If blnAtualizar Then
  Begin
    pSetFocus(dbeNumero);
    blnMudarFoco := False;
  End;
end;

function TfrmCadEndPartidaConsFrete.fConfirmaGravacao(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryGrava: TUniQuery;
begin
  Result := True;

  qryGrava := fCriaQuery;
  cdsConsulta.DisableControls;
  Try
    Try
      fStartTransaction;

      qryGrava.SQL.Add('DELETE FROM ENPAFR WHERE END_CODEMP = :CODEMP');
      qryGrava.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGrava.ExecSQL;

      qryGrava.Close;
      qryGrava.SQL.Clear;
      qryGrava.SQL.Add('INSERT INTO ENPAFR(');
      qryGrava.SQL.Add('  AUTOINCREM,');
      qryGrava.SQL.Add('  END_CODEMP,');
      qryGrava.SQL.Add('  END_DESCRI,');
      qryGrava.SQL.Add('  END_SITUAC,');
      qryGrava.SQL.Add('  END_C_E_P_,');
      qryGrava.SQL.Add('  END_CODCID,');
      qryGrava.SQL.Add('  END_ENDERE,');
      qryGrava.SQL.Add('  END_NUMERO,');
      qryGrava.SQL.Add('  END_BAIRRO,');
      qryGrava.SQL.Add('  END_ENDPAD)');
      qryGrava.SQL.Add('VALUES(');
      qryGrava.SQL.Add('  :AUTINC,');
      qryGrava.SQL.Add('  :CODEMP,');
      qryGrava.SQL.Add('  :DESCRI,');
      qryGrava.SQL.Add('  :SITUAC,');
      qryGrava.SQL.Add('  :C_E_P_,');
      qryGrava.SQL.Add('  :CODCID,');
      qryGrava.SQL.Add('  :ENDERE,');
      qryGrava.SQL.Add('  :NUMERO,');
      qryGrava.SQL.Add('  :BAIRRO,');
      qryGrava.SQL.Add('  :ENDPAD)');

      pgbProgresso.Properties.Max := cdsConsulta.RecordCount;

      cdsConsulta.First;
      While Not cdsConsulta.Eof Do
      Begin
        pStepStatusGravacao(pgbProgresso);

        qryGrava.Close;
        qryGrava.ParamByName('AUTINC').AsString := fRetAutoIncrem('ENPAFR', VS_strCodEmp);
        qryGrava.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryGrava.ParamByName('DESCRI').AsString := cdsConsulta.FieldByName('END_DESCRI').AsString;
        qryGrava.ParamByName('SITUAC').AsString := cdsConsulta.FieldByName('END_SITUAC').AsString;
        qryGrava.ParamByName('C_E_P_').AsString := cdsConsulta.FieldByName('END_C_E_P_').AsString;
        qryGrava.ParamByName('CODCID').AsString := cdsConsulta.FieldByName('END_CODCID').AsString;
        qryGrava.ParamByName('ENDERE').AsString := cdsConsulta.FieldByName('END_ENDERE').AsString;
        qryGrava.ParamByName('NUMERO').AsString := cdsConsulta.FieldByName('END_NUMERO').AsString;
        qryGrava.ParamByName('BAIRRO').AsString := cdsConsulta.FieldByName('END_BAIRRO').AsString;
        qryGrava.ParamByName('ENDPAD').AsString := cdsConsulta.FieldByName('END_ENDPAD').AsString;
        qryGrava.ExecSQL;

        cdsConsulta.Next;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollback;
        Result := False;
        pMensagensErro(E.Message, '[TfrmCadEndPartidaConsFrete.fConfirmaGravacao]');
      End;
    End;
  Finally
    FreeAndNil(qryGrava);
    cdsConsulta.EnableControls;
  End;
end;

function TfrmCadEndPartidaConsFrete.fGetSql(blnLike: Boolean): String;
begin
  inherited;
  Result := '';
  Result := Result + 'SELECT ENPAFR.AUTOINCREM, ';
  Result := Result + '       END_CODEMP, ';
  Result := Result + '       END_DESCRI, ';
  Result := Result + '       END_SITUAC, ';
  Result := Result + '       END_C_E_P_, ';
  Result := Result + '       END_CODCID, ';
  Result := Result + '       END_ENDERE, ';
  Result := Result + '       END_NUMERO, ';
  Result := Result + '       END_BAIRRO, ';
  Result := Result + '       END_ENDPAD, ';
  Result := Result + '       CID_NOMCID, ';
  Result := Result + '       CID_ESTADO  ';
  Result := Result + 'FROM ENPAFR ';
  Result := Result + 'LEFT JOIN CADCID ON CID_CODCID = END_CODCID ';
  Result := Result + 'WHERE END_CODEMP = :CODEMP ';
end;

function TfrmCadEndPartidaConsFrete.fSetParametros: Boolean;
begin
  inherited;
  Result := True;
  qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
end;

procedure TfrmCadEndPartidaConsFrete.pMascaraValor;
begin
  inherited;
  cdsConsulta.FieldByName('END_C_E_P_').EditMask := '99999-999;0;_';
end;

procedure TfrmCadEndPartidaConsFrete.pOnStateChange;
begin
  inherited;
  btnConfirma.Enabled := Not (cdsConsulta.State In dsEditModes);
end;

function TfrmCadEndPartidaConsFrete.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin

    If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeSituac) Then
    Begin
      If Pos(dbeSituac.Text, 'AI') = 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A situação do endereço deve ser preenchida com "A" ou "I"!', ['&Ok']);
        Result := False;
      End

      Else If (dbeSituac.Text = 'I') Then
      Begin
        If (cdsConsulta.FieldByName('END_ENDPAD').AsString = 'S') Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido inativar o endereço padrão!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeCepEnd) Then
    Begin
      If Length(Trim(fTiraCaracEspeciais(dbeCepEnd.Text))) < 8 Then
      Begin
        fMensagem('ATENÇÃO!', 'O CEP deve conter 8 dígitos.', ['&Ok']);
        Result := False;
      End;

      If (Result) And (fCfgSis('USACEP', varBoolean)) And (dbeEstado.Text <> 'EX') Then
        Result := fAtualizaEnderecoPeloCEP;
    End

    Else If (Sender = dbeCodCid) Then
    Begin
      pCarregaCidade;

      If fEmptyStr(dbeCodCid.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A cidade deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If fEmptyStr(cdsConsulta.FieldByName('CID_NOMCID').AsString) Then
      Begin
        fMensagem('ATENÇÃO!', 'Cidade não cadastrada!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeEndere) Then
    Begin
      If fEmptyStr(dbeEndere.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O endereço deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeNumero) Then
    Begin
      If fEmptyStr(dbeNumero.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O número deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeBairro) Then
    Begin
      If fEmptyStr(dbeBairro.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O bairro deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadEndPartidaConsFrete.fValidaEnderecoAtivo: Boolean;
  Var
    cdsClone: TUniClientDataSet;
begin
  Result := True;
  cdsClone := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsClone, cdsConsulta);

    cdsClone.Filtered := False;
    cdsClone.Filter   := 'END_SITUAC = ''A''';
    cdsClone.Filtered := True;

    If cdsClone.RecordCount = 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Pelo menos um endereço deve estar ativo no cadastro!', ['&Ok']);
      Exit(False);
    End;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TfrmCadEndPartidaConsFrete.fValidaEnderecoPadrao: Boolean;
  Var
    cdsClone: TUniClientDataSet;
begin
  Result := True;
  cdsClone := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsClone, cdsConsulta);

    cdsClone.Filtered := False;
    cdsClone.Filter   := 'END_ENDPAD = ''S''';
    cdsClone.Filtered := True;

    If cdsClone.RecordCount = 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Deve haver um endereço padrão no cadastro!', ['&Ok']);
      Exit(False);
    End;

    If cdsClone.RecordCount > 1 Then
    Begin
      fMensagem('ATENÇÃO!', 'Deve haver somente um endereço padrão cadastrado!', ['&Ok']);
      Exit(False);
    End;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

procedure TfrmCadEndPartidaConsFrete.pCarregaCidade;
  Var
    strNomCid, strEstado: String;
begin
  cdsConsulta.FieldByName('CID_NOMCID').Clear;
  cdsConsulta.FieldByName('CID_ESTADO').Clear;

  If fEmptyStr(dbeCodCid.Text) Then
    Exit;

  strNomCid := fRetNomCidade(dbeCodCid.Text, 0);
  strEstado := fRetNomCidade(dbeCodCid.Text, 1);

  cdsConsulta.FieldByName('CID_NOMCID').AsString := strNomCid;
  cdsConsulta.FieldByName('CID_ESTADO').AsString := strEstado;
end;

end.
