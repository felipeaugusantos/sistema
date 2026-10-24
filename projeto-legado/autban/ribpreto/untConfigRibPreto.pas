unit untConfigRibPreto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, QColorLabel, ComCtrls, ShellApi, Uni,
  AppEvnts, BitBtnLockedIncrem, JvExMask, JvToolEdit, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, 
  untFrameDirectoryEditFocus;

type
  TfrmConfigRibPreto = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    lblDiasProt: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblResp: TLabel;
    ColorLabel1: TColorLabel;
    lblCodCart: TLabel;
    lblProNum: TLabel;
    Label7: TLabel;
    lblCodAgenc: TLabel;
    lblIdentBanco: TLabel;
    Label1: TLabel;
    edtResp: TEditFocus;
    fraPathRetornoCXF: TfraDirectoryEditFocus;
    fraPathRemessaCXF: TfraDirectoryEditFocus;
    edtDiasProt: TEditFocus;
    edtCodCar: TEditFocus;
    edtDigAgenciaCob: TEditFocus;
    edtCodAgenciaCob: TEditFocus;
    edtIdentBanc: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtInstrucao1: TEditFocus;
    edtInstrucao2: TEditFocus;
    Label8: TLabel;
    edtObservacao2: TEditFocus;
    Label9: TLabel;
    edtCodEmpr: TEditFocus;
    Label10: TLabel;
    Label11: TLabel;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesCtaBai: TEditFocus;
    edtCtaBai: TEditFocus;
    Label14: TLabel;
    edtDiasCred: TEditFocus;
    Label12: TLabel;
    edtUsoBan: TEditFocus;
    lbl1: TLabel;
    edtInfAdi: TEditFocus;
    btnGravar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;

    procedure pCarregaDados;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tabCarteiraChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCtaBaiKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
  private
    { Private declarations }

    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;

    procedure pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigRibPreto: TfrmConfigRibPreto;

implementation

uses untfuncoesSimples,
     untPesqAux, untCfgGenericas_AutBan, untConsultas;

{$R *.dfm}

{ TfrmConfigRibPreto }

procedure TfrmConfigRibPreto.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************LB*}
  edtProxNumArqRem.Text  := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
  edtCodCar.Text         := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  edtIdentBanc.Text      := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', '');
  edtCodEmpr.Text        := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', '');
  edtCodAgenciaCob.Text  := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtDigAgenciaCob.Text  := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', '');
  edtInstrucao1.Text     := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '');
  edtInstrucao2.Text     := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '');
  edtObservacao1.Text    := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text    := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text    := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text    := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text    := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');
  edtDiasProt.Text       := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtResp.Text           := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');
  fraPathRemessaCXF.edtDirectory.text := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetornoCXF.edtDirectory.text := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtCodPor.Text         := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCtaBai.Text         := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtUsoBan.Text         := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'USOBANC', '');
  edtInfAdi.Text         := fArqIniAutBan(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');                                                                                                             

  edtDiasCred.Text       := fArqIniAutban(0, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');

  If Not fEmptyStr(edtCodPor.Text) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr(edtCtaBai.Text) Then
    pCarregaCentroCusto(edtCtaBai.Text, edtDesCtaBai);

end;

procedure TfrmConfigRibPreto.btnGravarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    Try
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text  );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text         );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', edtIdentBanc.Text      );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'CODEMPR', edtCodEmpr.Text        );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgenciaCob.Text  );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGAGEN', edtDigAgenciaCob.Text  );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', edtInstrucao1.Text     );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', edtInstrucao2.Text     );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text    );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text    );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text    );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text    );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text    );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text       );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text           );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaCXF.edtDirectory.text );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoCXF.edtDirectory.text );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text         );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', edtCtaBai.Text         );
      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'USOBANC', edtUsoBan.Text         );

      fArqIniAutban(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text       );
      fArqIniAutBan(1, 'CONFIG741-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text         );

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        blnMudarFoco := True;
      End
      Else
      Begin
        Close;
        ModalResult := mrOk;
      End;

    Except
      On E:Exception Do
      Begin
        fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
      End;
    End;
  End;

end;

function TfrmConfigRibPreto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtProxNumArqRem) Then
    Begin

      If fEmptyStr(edtProxNumArqRem.Text) Then
      Begin
        fMensagem('', 'O Próximo Núm. Arq. Remessa deve conter um valor!',['&O K']);
        Result := False;
      End

      Else
      If StrToInt(edtProxNumArqRem.Text) <= 0 Then
      Begin
        fMensagem('', 'O Próximo Núm. Arq. Remessa deve ser maior que zero!',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtInstrucao1) Then
    Begin

      If fEmptyStr(edtInstrucao1.Text) Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!',['&OK']);
        Result := False;
      End

    End

    Else If (Sender = edtInstrucao2) Then
    Begin

      If fEmptyStr(edtInstrucao2.Text) Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!',['&OK']);
        Result := False;
      End

    End

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'E') And (edtResp.Text <> 'B') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser E ou B!',['&O K']);
        Result := False;
      End;

    End

    Else If Sender = fraPathRemessaCXF Then
    Begin

      If fEmptyStr(fraPathRemessaCXF.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Remessa',['&O K']);
        Result := False;
      End;

    End

    Else If Sender = fraPathRetornoCXF Then
    Begin

      If fEmptyStr(fraPathRetornoCXF.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Retorno',['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = edtCodPor) Then
    Begin

      If fEmptyStr(edtCodPor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!', ['&Ok']);
        edtDesPor.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaPortador(edtCodPor.Text, edtDesPor);
        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este operador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtCtaBai) Then
    Begin

      If fEmptyStr(edtCtaBai.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Centro de Custo deve ser preenchido!', ['&Ok']);
        edtDesCtaBai.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(edtCtaBai.Text, edtDesCtaBai);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);              

end;

procedure TfrmConfigRibPreto.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  
  pCarregaDados;
  pSetFocus(edtProxNumArqRem);

end;

procedure TfrmConfigRibPreto.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigRibPreto.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlCamIndPor: TStringList;
    stlDesIndPor: TStringList;
    strSQL: String;
begin
  inherited;

    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  POR_CODPOR AS "Código", ';
    strSQL := strSQL + '  POR_NOMPOR AS "Nome", ';
    strSQL := strSQL + '  AUTOINCREM  ';
    strSQL := strSQL + 'FROM  ';
    strSQL := strSQL + '  CADPOR  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TRUE  ';


  stlCamIndPor := TStringList.Create;
  stlDesIndPor := TStringList.Create;

  If fEntraCons(Key) Then
  Begin
    Key := #0;

    stlCamIndPor.Add('POR_CODPOR');
    stlCamIndPor.Add('POR_NOMPOR');

    stlDesIndPor.Add('Código');
    stlDesIndPor.Add('Nome');

    If pConsultaComp(Self, qryCadPor, 'CADPOR',strSQL, stlCamIndPor, stlDesIndPor) Then
    Begin
      edtCodPor.Text := qryCadPor.FieldByName('POR_CODPOR').AsString;
      pCarregaPortador(edtCodPor.Text, edtDesPor);
      Self.SelectNext(ActiveControl, True, True);
    End;

  End;

  FreeAndNil(stlCamIndPor);
  FreeAndNil(stlDesIndPor);

end;

procedure TfrmConfigRibPreto.edtCtaBaiKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, edtCtaBai, edtDesCtaBai, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(edtCtaBai) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfigRibPreto.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    edtDesCtaBai.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigRibPreto.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigRibPreto.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
end;

procedure TfrmConfigRibPreto.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try

    Application.CreateForm(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '741';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigRibPreto.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\741400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\741400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

end.
