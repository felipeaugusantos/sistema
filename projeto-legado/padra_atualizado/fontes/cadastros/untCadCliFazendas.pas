 unit untCadCliFazendas;

interface

uses
  Windows, Classes, Controls, Forms, DB, UniClientDataSet, Uni, AppEvnts, Menus,
  StdCtrls, Mask, Grids, DBGridCitel, DBGrids, ComCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls,
  DBCtrls, DBEditFocus, untPaiOrdenaEdit, untModulo, untFuncoesSimples, MemDS, DBAccess,
  Provider, UniDataSetProvider, EditFocus, MaskEditFocus, frxClass, strUtils,
  frxExportCSVTestabilidade, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, cxButtons, Datasnap.DBClient,
  untCfgGrid;

type
  TfrmCadCliFazendas = class(TfrmPaiOrdenaEdit)
    cdsConsultaFAZ_CODCLI: TStringField;
    cdsConsultaFAZ_CODCID: TStringField;
    cdsConsultaFAZ_ENDERE: TStringField;
    cdsConsultaFAZ_BAIRRO: TStringField;
    cdsConsultaFAZ_C_E_P_: TStringField;
    cdsConsultaFAZ_ENDCOM: TStringField;
    Label57: TLabel;
    Label58: TLabel;
    Label60: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label149: TLabel;
    dbeEndere: TDBEditFocus;
    dbeCodCid: TDBEditFocus;
    dbeEndCep: TDBEditFocus;
    dbeBairro: TDBEditFocus;
    dbeEndCom: TDBEditFocus;
    dbeEstado: TDBEditFocus;
    dbeNomCid: TDBEditFocus;
    btnConfAlteracoes: TBitBtnLocked;
    cdsConsultaAUTOINCREM: TStringField;
    qryCadCid: TUniQuery;
    pnlAviso: TPanel;
    cdsConsultaCID_NOMCID: TStringField;
    cdsConsultaCID_ESTADO: TStringField;
    Label3: TLabel;
    dbeCodFaz: TDBEditFocus;
    Label4: TLabel;
    dbeNomfaz: TDBEditFocus;
    cdsConsultaFAZ_CODFAZ: TStringField;
    cdsConsultaFAZ_NOMFAZ: TStringField;
    cdsConsultaFAZ_ENDNUM: TStringField;
    Label189: TLabel;
    dbeEndNum: TDBEditFocus;
    Label12: TLabel;
    dbeCgcCpf: TDBEditFocus;
    dbeNuCnpj: TDBEditFocus;
    Label10: TLabel;
    dbeNumIes: TDBEditFocus;
    cdsConsultaFAZ_CGCCPF: TIntegerField;
    cdsConsultaFAZ_C_G_C_: TStringField;
    cdsConsultaFAZ_I_E_S_: TStringField;
    Label64: TLabel;
    dbeNomCon: TDBEditFocus;
    Label65: TLabel;
    dbeTelCon: TDBEditFocus;
    cdsConsultaFAZ_NOMCON: TStringField;
    cdsConsultaFAZ_TELCON: TStringField;
    Label2: TLabel;
    dbeCoIbge: TDBEditFocus;
    cdsConsultaCID_COIBGE: TStringField;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure dbeEndCepKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfAlteracoesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnCancelaClick(Sender: TObject);
    procedure cdsConsultaCID_NOMCIDGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure cdsConsultaCID_ESTADOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    function dbeCodCidChamaCadastro(Key: Word): string;
    procedure dbeCgcCpfExit(Sender: TObject);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure cdsConsultaCID_COIBGEGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    blnLiberou  : Boolean;
    strCodCid   : String;
    strEndCom   : String;
    strEndere   : String;
    strBairro   : String;
    strNomCid   : String;
    strEstado   : String;
    strCepAnt   : String;

    Function fTemAcesso: Boolean;
    function fPodeExcluirFazenda: Boolean;

    procedure pCarregaCidade(qryConsulta: TUniQuery; dbeCep: TDBEditFocus; Var strCepAnt: String);
  protected
    function fGetSql(blnLike: Boolean): String;override;
    function fGetOrderBy: String; override;
    function fSetParametros: Boolean; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;

  public
    { Public declarations }
    blnConfirma: Boolean;

    blnVendas: Boolean;
    blnDockPanel: Boolean;

    strCodCli: String;
    strCodFaz: String;

    procedure pGravarFazendasCliente;
    procedure pCancelaAlteracoes;
  end;


implementation

uses SysUtils, Variants, Graphics, untPaiOrdena, untFuncoesGenerica, untPai,
  untCadCidades, untPesqAux, untCadCid, untConsultas, untFuncIns2, untTypesSistema;

{$R *.dfm}

function TfrmCadCliFazendas.fGetSql(blnLike: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT        ';
  Result := Result + '   REPEAT(" ", 40) AS CID_NOMCID,  ';
  Result := Result + '   REPEAT(" ", 02) AS CID_ESTADO,  ';
  Result := Result + '   REPEAT(" ", 30) AS CID_COIBGE,  ';
  Result := Result + '   CADFAZ.*     ';
  Result := Result + ' FROM          ';
  Result := Result + '   CADFAZ      ';
  Result := Result + ' WHERE         ';
  Result := Result + '   FAZ_CODCLI = :CODCLI ';
end;

function TfrmCadCliFazendas.fGetOrderBy: String;
begin
  Result := '';
  Result := Result + ' ORDER BY      ';
  Result := Result + '   FAZ_CODCLI, ';
  Result := Result + '   FAZ_CODFAZ  ';
end;

function TfrmCadCliFazendas.fSetParametros: Boolean;
begin
  Result := inherited fSetParametros;

  qryConsulta.ParamByName('CODCLI').AsString := strCodCli;
end;

procedure TfrmCadCliFazendas.btnGravarClick(Sender: TObject);
begin
  If (cdsConsulta.State in [dsInsert,dsEdit]) Then
  Begin
    cdsConsulta.FieldByName('FAZ_CODCLI').AsString := strCodCli;
    If fEmptyStr(dbeCodCid.Text) Then
      dbeCodCid.Field.Value := Null;
  End;
  inherited;
end;

procedure TfrmCadCliFazendas.FormShow(Sender: TObject);
begin
  inherited;
  Caption := Caption + ' ' + fRetNomCliente(strCodCli);

  If blnDockPanel Then
  Begin
    pnlTail.Visible   := False;
    btnSair.Visible   := False;
    pnlStatus.Visible := False;
  End;

  If blnVendas Then
  Begin
    btnConfAlteracoes.Caption := '[ F10 ] Selecionar Fazenda';
    pSetFocus(dbgConsulta);
  End
  Else
    pSetFocus(btnIncluir);

  If Not fEmptyStr(strCodFaz) Then
  Begin
    cdsConsulta.Locate('FAZ_CODFAZ', strCodFaz, []);
  End;

  pnlAviso.Visible := blnVendas And fEmptyStr(strCodFaz);
end;

procedure TfrmCadCliFazendas.FormCreate(Sender: TObject);
begin
  inherited;
  strCamChave           := 'FAZ_CODFAZ';
  blnLiberou            := False;
  blnConfirma           := False;
  blnVendas             := False;
  blnDockPanel          := False;
  blnTemSelecao         := False;
  blnSelecionaComEspaco := False;
  blnUsaProxCodVirtual  := False;

  With qryCadCid, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT CID_CODCID, CID_NOMCID, CID_ESTADO, CID_C_E_P_, CID_CODCOR FROM CADCID WHERE FALSE');
    Open;
  End;

  objCfgGrid  := TCfgGrid.Create(Self, dbgConsulta,  'Cadastro Fazendas do Cliente', [250, 90, 64, 64, 64, 64,
                                                                                      64, 64, 64, 64, 64,
                                                                                      64, 64, 64, 64, 90,
                                                                                      90, 90], '', False, False);
end;

function TfrmCadCliFazendas.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    blnAtualizar: Boolean;

    LCodigoCorreio: String;
begin
  Result := True;
  blnAtualizar := False;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (sender = dbeCodFaz) Then
    Begin
      If fEmptyStr(dbeCodFaz.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o código da Fazenda!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (sender = dbeNomFaz) Then
    Begin
      If fEmptyStr(dbeNomFaz.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o nome da Fazenda!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodCid) Then
    Begin
      dbeNomCid.Clear;
      dbeEstado.Clear;
      If Not fEmptyStr(dbeCodCid.Text) Then
      Begin
        pCarregaCidade(qryCadCid, dbeEndCep, strCepAnt);
        If qryCadCid.FieldByName('CID_CODCID').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'A cidade deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeEndere) Then
    Begin
      If fEmptyStr(dbeEndere.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o endereço!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeBairro) Then
    Begin
      If fEmptyStr(dbeBairro.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o bairro!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeEndCep) Then
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(dbeEndCep.Text))) Then
      Begin
        If Length(Trim(fTiraCaracEspeciais(dbeEndCep.Text))) < 8 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Cep deve ser vazio ou com 8 digitos.', ['&Ok']);
          Result := False;
        End;
      End;

      If (Result) And (Not fEmptyStr(dbeEndCep.Text)) And (fCfgSis('USACEP', varBoolean)) Then
      Begin

        If (Not fCadCepDadosCep(dbeEndCep.Text, strCodCid, strEndere, strBairro, strNomCid, strEstado, LCodigoCorreio,
                                                qryCadCid.FieldByName('CID_ESTADO').AsString,
                                                qryCadCid.FieldByName('CID_CODCOR').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
        End
        Else
        Begin

          If (fEmptyStr(strCodCid)) Then
          Begin

            If Not fVerificaAcessoSistema('frmCadCidades') Then
            Begin
              fMensagem('ATENÇÃO!', fMensagemTravaAcessoCadCid(dbeCodCid.Text, dbeNomCid.Text), ['&Ok']);

              Result := False;

            End

            Else

            If Not fEmptyStr(fRetNomCidade(dbeCodCid.Text)) Then
            Begin

              If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + dbeNomCid.Text + ' está em branco.' + #13#10 +
                           'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?', ['&Sim', '&Não']) = 1 Then
              Begin
                pAtualizaCodigoCorreios(dbeCodCid.Text, dbeEndCep.Text);
                strCodCid := dbeCodCid.Text;
              End

              Else Result := False;

            End
            Else
            Begin
              fMensagem('ATENÇÃO!', 'Esse CEP não tem nenhum endereço associado no cadastro do AutCom.' + #13#10 +
                                    'Será aberto o Cadastro de Cidades para o preenchimento do Código Correios.', ['&Ok']);
              pCriarForm(TfrmCadCidades);

              Result := False;
            End;

          End
          Else If (Not fEmptyStr(strNomCid)) And (fEmptyStr(dbeEndere.Field.AsString)) Then
            dbeEndere.Field.AsString := strNomCid;

          If Result Then
          Begin
            blnAtualizar := False;
            If (strCepAnt <> dbeEndCep.Text) Then
            Begin
              If fTiraCaracEspeciais(strCepAnt) = '' Then
              Begin
                blnAtualizar := True;
              End
              Else
              If fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1 Then
              Begin
                blnAtualizar := True;
              End;
            End;

            If fEmptyStr(dbeCodCid.Text) Or (blnAtualizar) Then
            Begin
              dbeCodCid.Field.AsString := strCodCid;
              pCarregaCidade(qryCadCid, Nil, strCepAnt);
            End;

            If fEmptyStr(dbeEndere.Text) Or (blnAtualizar) Then
              dbeEndere.Field.AsString := strEndere;

            If fEmptyStr(dbeBairro.Text) Or (blnAtualizar) Then
              dbeBairro.Field.AsString := strBairro;

            If fEmptyStr(dbeEndCom.Text) Or (blnAtualizar) Then
              dbeEndCom.Field.AsString := strEndCom;

          End;

        End;

        If (Result) Then
        Begin
          strCepAnt := dbeEndCep.Text;
          If blnAtualizar Then
          Begin
            pSetFocus(dbeEndNum);
            blnMudarFoco := False;
          End;
        End;

      End;

    End

    {*****************************************}
    {* VALIDA O CAMPO CNPJ / CPF             *}
    {**************************************MV*}
    Else If (Sender = dbeCgcCpf) And (dbeCgcCpf.Enabled) Then
    Begin
      If (fEmptyStr(dbeCgcCpf.Text)) Or (dbeCgcCpf.Text = '0') Then
      Begin
        fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (dbeCgcCpf.Text <> '1') And (dbeCgcCpf.Text <> '2') Then
          Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA CNPJ / CPF                     *}
    {**************************************MV*}
    Else If (Sender = dbeNuCnpj) And (dbeNuCnpj.Enabled) Then
    Begin
      If fEmptyStr(dbeNuCnpj.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        blnMudarFoco := False;
        Result := fValidaCampos(dbeCgcCpf, True);
        blnMudarFoco := True;

        If (Result) Then
          Result := fValidaCnpjCpf(dbeCgcCpf.Text, dbeNuCnpj.Text, False, True);

        If Not Result Then
          Sender := dbeCgcCpf;
      End;
    End

    {*****************************************}
    {* VALIDA INSCRIÇÃO ESTADUAL             *}
    {**************************************MV*}
    Else If (Sender = dbeNumIes) Then
    Begin
      If (Not fEmptyStr(dbeNumIes.Text))    And
         (Not fEmptyStr(dbeEstado.Text)) Then
      Begin
        dbeNumIes.Text := AnsiReplaceStr(dbeNumIes.Text, ',', '.');
        If Not fValidaIES(dbeNumIes.Text, dbeEstado.Text) Then
        Begin
          fMensagem('ATENÇÃO', dbeNumIes.Text + ' não é uma Inscrição Estadual válida!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If dbeEstado.Text = 'RS' Then
          Begin
            dbeNumIes.Text := fRetornaZerosNumIes(dbeNumIes.Text) + dbeNumIes.Text;
          End;
        End;
      End
      Else
      Begin
        dbeNumIes.Clear;
      End;
    End

    Else If (Sender = dbeTelCon) Then
    Begin
      If (Not fEmptyStr(TDBEditFocus(Sender).Text)) And
         (Not fValidaTelefone(TDBEditFocus(Sender).Text)) Then
      Begin
        fMensagem('','Informe o telefone corretamente!', ['&Ok']);
        Result := False;
      End
      Else
        TDBEditFocus(Sender).Text := fAcertaMaskTel(TDBEditFocus(Sender).Text);
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender)

  Else If blnDockPanel And blnMudarFoco Then
  Begin
    blnMudarFoco := False;
    SelectNext(Sender, True, True);
  End;

end;

procedure TfrmCadCliFazendas.pCarregaCidade(qryConsulta: TUniQuery; dbeCep: TDBEditFocus; Var strCepAnt: String);
begin
  If cdsConsulta.State In [dsInsert, dsEdit] Then
  Begin
    pPesquisaCadCid(qryCadCid, qryConsulta, dbeCodCid.Text);
    With qryConsulta Do
    Begin
      dbeNomCid.Field.AsString := FieldByName('CID_NOMCID').AsString;
      dbeEstado.Field.AsString := FieldByName('CID_ESTADO').AsString;
      dbeCoIbge.Field.AsString := fRetornaCodIBGE(dbeCodCid.Text);

      dbeNomCid.Text := FieldByName('CID_NOMCID').AsString;
      dbeEstado.Text := FieldByName('CID_ESTADO').AsString;
      dbeCoIbge.Text := fRetornaCodIBGE(dbeCodCid.Text);

      If (Assigned(dbeCep)) And (dbeCep.Field <> Nil) And (dbeCep.Field.IsNull) Then
      Begin
        dbeCep.Field.AsString := FieldByName('CID_C_E_P_').AsString;
        dbeCep.Text := FieldByName('CID_C_E_P_').AsString;
        strCepAnt := FieldByName('CID_C_E_P_').AsString;
      End;
    End;
  End;
end;

procedure TfrmCadCliFazendas.dbeCgcCpfExit(Sender: TObject);
begin
  inherited;
  If (dbeCgcCpf.Text = '1') Then
    cdsConsulta.FieldByName('FAZ_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else
    cdsConsulta.FieldByName('FAZ_C_G_C_').EditMask := '999.999.999-99;0;';
end;

function TfrmCadCliFazendas.dbeCodCidChamaCadastro(Key: Word): string;
begin
  inherited;
  If fVerificaAcessoSistema('frmCadCidades') Then
    Result := fChamaCadCid(Key)
  Else
    fMensagem('','Sem permissão para Cadastro de Cidades!',['&Ok']);
end;

procedure TfrmCadCliFazendas.dbeCodCidKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  If Not dbeCodCid.ReadOnly Then
  Begin
    If fPesqCidade(Self, dbeCodCid, nil, nil, qryCadCid, Key, arrSel) Then
    Begin
      If fValidaCampos(dbeCodCid, True) Then
        If Not blnDockPanel Then
          SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadCliFazendas.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If cdsConsultaFAZ_CODFAZ.AsString = strCodFaz Then
    dbgConsulta.Canvas.Font.Style := [fsBold];

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmCadCliFazendas.dbeEndCepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Key := #0;
    dbeEndCep.Field.AsString := fConsultarCep(Self, dbeEndCep.Text, dbeEndCep);
  End;
end;

procedure TfrmCadCliFazendas.pGravarFazendasCliente;
  Var
    strIndex: String;
begin
  btnCancela.Click;
  pSetFilterDefault;

  With cdsConsulta Do
  Begin
    DisableControls;  
    strIndex := IndexFieldNames;
    IndexFieldNames := 'FAZ_CODFAZ';
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('FAZ_CODCLI').AsString  := strCodCli;
      Post;
      Next;
    End;
    ApplyUpdates(-1);

    IndexFieldNames := strIndex;
    First;        

    If Not blnDockPanel Then
    Begin
      If cdsConsulta.IsEmpty Or Not Locate('FAZ_CODFAZ', strCodFaz, []) Then
        strCodFaz := '';
    End;

    ApplyUpdates(-1);
    EnableControls;
  End;

  pSetFilterDefault;
end;

procedure TfrmCadCliFazendas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  cdsConsultaAfterScroll(cdsConsulta);
end;

procedure TfrmCadCliFazendas.btnConfAlteracoesClick(Sender: TObject);
begin
  inherited;

  If cdsConsulta.IsEmpty Then
    strCodFaz := ''
  Else
    strCodFaz := cdsConsulta.FieldByName('FAZ_CODFAZ').AsString;

  If blnDockPanel Then Exit;

  pSetFilterDefault;

  If (cdsConsulta.ChangeCount = 0) Or (fMensagem('','Confirma alterações?', ['','']) = 1)  Then
  Begin
    If fValidaCampos(dbeEndere) And
       fValidaCampos(dbeBairro) Then
    Begin
      blnConfirma := True;
      pGravarFazendasCliente;

      If blnVendas Then
        Close
      Else
        pIniciaPesquisa;
    End;
  End;
end;

procedure TfrmCadCliFazendas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If (Key = VK_F4) And (Shift = [ssAlt]) And blnDockPanel Then
  Begin
    Key := 0;
    //PARA NAO FECHAR O FORM COM ALT + F4
  End
  Else

  If (Key = VK_ESCAPE) And (Not (cdsConsulta.State In [dsInsert, dsEdit])) And blnDockPanel Then
  Begin
    Key := 0;
    //PARA NAO FECHAR O FORM COM ESC...
  End
  Else
    inherited;

  If Key = VK_F10 Then
  Begin
    Key := 0; 
    btnConfAlteracoes.Click;
  End;  
end;

procedure TfrmCadCliFazendas.btnSairClick(Sender: TObject);
begin
  If blnDockPanel Then Exit;
  inherited;
end;

procedure TfrmCadCliFazendas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If cdsConsulta.IsEmpty Or Not cdsConsulta.Locate('FAZ_CODFAZ', strCodFaz, []) Then
    strCodFaz := '';

  If blnDockPanel Then Action := caNone else inherited;
  freeAndNil(ObjCfgGrid);
end;

procedure TfrmCadCliFazendas.cdsConsultaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cdsConsulta.FieldByName('FAZ_TELCON').EditMask := fRetMascaraFonePais;
end;

procedure TfrmCadCliFazendas.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  With DataSet Do
  Begin
    If (dbeCgcCpf.Text = '1') Then
      FieldByName('FAZ_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
    Else
      FieldByName('FAZ_C_G_C_').EditMask := '999.999.999-99;0;';

    strCepAnt          := FieldByName('FAZ_C_E_P_').AsString;

    dbeCodFaz.ReadOnly := True;
    dbeNomCid.ReadOnly := True;
    dbeEstado.ReadOnly := True;
    dbeCoIbge.ReadOnly := True;

    dbeCodFaz.TabStop  := False;
    dbeNomCid.TabStop  := False;
    dbeEstado.TabStop  := False;
    dbeCoIbge.TabStop  := False;

    dbeNomCid.Text     := fRetNomCidade(dbeCodCid.Text);
    dbeEstado.Text     := fRetNomCidade(dbeCodCid.Text, 1);
    dbeCoIbge.Text     := fRetornaCodIBGE(dbeCodCid.Text);

    dbeNomFaz.Enabled  := Not (DataSet.State = dsBrowse);
    dbeCodCid.Enabled  := Not (DataSet.State = dsBrowse);
    dbeEndCep.Enabled  := Not (DataSet.State = dsBrowse);
    dbeEndere.Enabled  := Not (DataSet.State = dsBrowse);
    dbeEndNum.Enabled  := Not (DataSet.State = dsBrowse);
    dbeBairro.Enabled  := Not (DataSet.State = dsBrowse);
    dbeEndCom.Enabled  := Not (DataSet.State = dsBrowse);
    dbeNomCon.Enabled  := Not (DataSet.State = dsBrowse);
    dbeTelCon.Enabled  := Not (DataSet.State = dsBrowse);
    dbeCgcCpf.Enabled  := Not (DataSet.State = dsBrowse);
    dbeNuCnpj.Enabled  := Not (DataSet.State = dsBrowse);
    dbeNumIes.Enabled  := Not (DataSet.State = dsBrowse);
  End;
end;

procedure TfrmCadCliFazendas.cdsConsultaCID_COIBGEGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := fRetornaCodIBGE(cdsConsultaFAZ_CODCID.AsString);
end;

procedure TfrmCadCliFazendas.cdsConsultaCID_ESTADOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := fRetNomCidade(cdsConsultaFAZ_CODCID.AsString, 1);
end;

procedure TfrmCadCliFazendas.cdsConsultaCID_NOMCIDGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := fRetNomCidade(cdsConsultaFAZ_CODCID.AsString);
end;

procedure TfrmCadCliFazendas.pEscapePressed;
begin
  If Not blnDockPanel Then Inherited;
end;

procedure TfrmCadCliFazendas.pCancelaAlteracoes;
Begin
  With cdsConsulta Do
  If Active And (ChangeCount > 0) Then
    CancelUpdates;
End;

function TfrmCadCliFazendas.fPodeExcluirFazenda: Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Result:=True;
  If Not fEmptyStr(cdsConsulta.FieldByName('FAZ_CODFAZ').AsString) Then
  Begin
    qryGen := fCriaQuery(Self);
    Try
      With qryGen, SQL Do
      Begin
        Clear;
        Add('SELECT AUX_CODFAZ FROM AUXMOV ');
        Add('WHERE AUX_CODFAZ = :CODFAZ ');
        Add('UNION ');
        Add('SELECT AUX_CODFAZ FROM AUXNOT');
        Add('WHERE AUX_CODFAZ = :CODFAZ ');
        Add('UNION ');
        Add('SELECT FGO_CODFAZ FROM EXTGOR');
        Add('WHERE FGO_CODFAZ = :CODFAZ ');

        ParamByName('CODFAZ').AsString := cdsConsulta.FieldByName('FAZ_CODFAZ').AsString;
        Open;

        Result := IsEmpty;

        Close;
      End;
    Finally
      FreeAndNil(qryGen);
    End;
  End;
End;

procedure TfrmCadCliFazendas.btnExcluirClick(Sender: TObject);
begin
  If fTemAcesso Then
  Begin
    If fPodeExcluirFazenda Then
      inherited
    Else
      pMensagemOk('Há vendas/orçamentos para essa Fazenda!');
  End;
end;

Function TfrmCadCliFazendas.fTemAcesso: Boolean;
Begin
  Result := (Not blnVendas) Or blnLiberou Or
            (ffrmSenha(strSenha) And Not fEmptyStr(strSenha) And
             fVerificaAcessoSistema('ALFZCL', fRetCodVendedor(strSenha)));

  blnLiberou := Result;
End;

procedure TfrmCadCliFazendas.btnIncluirClick(Sender: TObject);
begin
  If fTemAcesso Then
  Begin
    If fClienteConsumidor(fRetNomCliente(strCodCli), True) Then
    Begin
      pMensagemOk('Não é permitido incluir fazendas para este cliente!');
      Exit;
    End;
    inherited;
    If (cdsConsulta.State in [dsInsert]) Then
    Begin
      cdsConsulta.FieldByName('FAZ_CODFAZ').AsString := fAtualizaProCod('CADFAZ', 'FAZ_CODFAZ');
      cdsConsulta.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADFAZ', VS_strCodEmp);
    End;
  End;
end;

procedure TfrmCadCliFazendas.btnAlterarClick(Sender: TObject);
begin
  If fTemAcesso Then
   inherited;
  cdsConsultaAfterScroll(cdsConsulta);
end;

end.
