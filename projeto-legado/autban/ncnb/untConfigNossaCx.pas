unit untConfigNossaCx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus,
  Buttons, ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni,
  BitBtnLockedIncrem, JvExMask, JvToolEdit, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, 
  untFrameDirectoryEditFocus;

type
  TfrmConfigNossaCx = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    lblTipCob: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lblCodAgenc: TLabel;
    lblDiasProt: TLabel;
    lblIdentBanco: TLabel;
    lblModalidade: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    lblResp: TLabel;
    lblTaxaEfetiva: TLabel;
    ColorLabel1: TColorLabel;
    ColorLabel2: TColorLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtTipoCob: TEditFocus;
    edtCodigoAgencia: TEditFocus;
    edtContaCor: TEditFocus;
    edtDiasProt: TEditFocus;
    edtDigContaCor: TEditFocus;
    edtDigitoAgencia: TEditFocus;
    edtModalidade: TEditFocus;
    fraPathRemessaNCNB: TfraDirectoryEditFocus;
    fraPathRetornoNCNB: TfraDirectoryEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtResp: TEditFocus;
    edtTacTar: TEditFocus;
    edtTaxaEfetiva: TEditFocus;
    edtInstrucao1: TEditFocus;
    edtInstrucao2: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesCtaBai: TEditFocus;
    edtCtaBai: TEditFocus;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    Label14: TLabel;
    edtDiasCred: TEditFocus;
    ColorLabel3: TColorLabel;
    edtProAce: TEditFocus;
    Label13: TLabel;
    lblCodCart: TLabel;
    edtCodCar: TEditFocus;
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
  frmConfigNossaCx: TfrmConfigNossaCx;

implementation

uses untfuncoesSimples,
     untPesqAux, untCfgGenericas_AutBan,  untConsultas;

{$R *.dfm}

procedure TfrmConfigNossaCx.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  edtProxNumArqRem.Text  := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'PROXNUM','');
  edtModalidade.Text     := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'MODALID','');
  edtCodigoAgencia.Text  := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'CODAGEN','');
  edtDigitoAgencia.Text  := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'DIGAGEN','');
  edtContaCor.Text       := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'NUMCTAC','');
  edtDigContaCor.Text    := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'DIGCTAC','');
  edtTaxaEfetiva.Text    := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'TAXAEFE','');
  edtTacTar.Text         := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'TACTARC','');
  edtTipoCob.Text        := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'TIPCOBR','');
  edtDiasProt.Text       := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'DIAPROT','');
  edtResp.Text           := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'RESPONS','');
  edtInstrucao1.Text     := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1','');
  edtInstrucao2.Text     := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU2','');
  edtCodCar.Text         := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'CODCART','');

  edtObservacao1.Text    := fArqIniAutban(0, 'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text    := fArqIniAutban(0, 'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text    := fArqIniAutban(0, 'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text    := fArqIniAutban(0, 'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text    := fArqIniAutban(0, 'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');

  fraPathRemessaNCNB.edtDirectory.text:= fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'PATHREM','');
  fraPathRetornoNCNB.edtDirectory.text:= fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'PATHRET','');
  edtCodPor.Text         := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'PORBAI_','');
  edtCtaBai.Text         := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'CTABAI_','');
  edtDiasCred.Text       := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'DIACRED','');
  edtProAce.Text         := fArqIniAutban(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'PROACEI', '');
  edtInfAdi.Text         := fArqIniAutBan(0,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'INFADIC', '');                                                                                                             


  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCtaBai.Text ) Then
    pCarregaCentroCusto(edtCtaBai.Text, edtDesCtaBai);


end;

procedure TfrmConfigNossaCx.btnGravarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    Try
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'PROXNUM',edtProxNumArqRem.Text );
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'MODALID',edtModalidade.Text    );
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'CODAGEN',edtCodigoAgencia.Text );
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'DIGAGEN',edtDigitoAgencia.Text );
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'NUMCTAC',edtContaCor.Text      );
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'DIGCTAC',edtDigContaCor.Text   );
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'TAXAEFE',edtTaxaEfetiva.Text   );
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'TACTARC',edtTacTar.Text        );
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'TIPCOBR',edtTipoCob.Text       );
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'DIAPROT',edtDiasProt.Text      );
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'RESPONS',edtResp.Text          );
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1',edtInstrucao1.Text    );
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU2',edtInstrucao2.Text    );

      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text);
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text);
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text);
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text);
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text);
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'CODCART',edtCodCar.Text        );

      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'PATHREM',fraPathRemessaNCNB.edtDirectory.text);
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'PATHRET',fraPathRetornoNCNB.edtDirectory.text);
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'PORBAI_',edtCodPor.Text         );
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'CTABAI_',edtCtaBai.Text         );

      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'DIACRED',edtDiasCred.Text       );
      fArqIniAutban(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'PROACEI', edtProAce.Text        );
      fArqIniAutBan(1,'CONFIG151-' + IntToStr(tabCarteira.TabIndex + 1),'INFADIC', edtInfAdi.Text        );

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
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

function TfrmConfigNossaCx.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtProxNumArqRem Then
    Begin
      If fEmptyStr(edtProxNumArqRem.Text) Then
      Begin
        fMensagem('', 'O Próximo Núm. Arq. Remessa deve conter um valor!',['&O K']);
        Result := False;
      End

      Else If StrToInt(edtProxNumArqRem.Text) <= 0 Then
      Begin
        fMensagem('', 'O Próximo Núm. Arq. Remessa deve ser maior que zero!',['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'E') And (edtResp.Text <> 'B') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser E ou B!',['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;
    End
    

    Else If Sender = edtTipoCob Then
    Begin

      If (edtTipoCob.Text <> 'S') And (edtTipoCob.Text <> 'D') Then
      Begin
        fMensagem('','O campo Tipo de Cobrança deve ser S ou D!',['&O K']);
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

    Else If Sender = fraPathRemessaNCNB Then
    Begin

      If fEmptyStr(fraPathRemessaNCNB.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de Remessa',['&O K']);
        Result := False;
      End;

    End

    Else If Sender = fraPathRetornoNCNB Then
    Begin

      If fEmptyStr(fraPathRetornoNCNB.edtDirectory.text) Then
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

End;

procedure TfrmConfigNossaCx.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);  
  pCarregaDados;
  pSetFocus(edtProxNumArqRem);

end;

procedure TfrmConfigNossaCx.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigNossaCx.edtCodPorKeyPress(Sender: TObject;
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

    If pConsultaComp(Self, qryCadPor, 'CADPOR',strSQL,stlCamIndPor, stlDesIndPor) Then
    Begin
      edtCodPor.Text := qryCadPor.FieldByName('POR_CODPOR').AsString;
      pCarregaPortador(edtCodPor.Text, edtDesPor);
      Self.SelectNext(ActiveControl, True, True);
    End;

  End;

  FreeAndNil(stlCamIndPor);
  FreeAndNil(stlDesIndPor);

end;

procedure TfrmConfigNossaCx.edtCtaBaiKeyPress(Sender: TObject;
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

procedure TfrmConfigNossaCx.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    edtDesCtaBai.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigNossaCx.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigNossaCx.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;
end;

procedure TfrmConfigNossaCx.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try

    Application.CreateForm(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '151';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigNossaCx.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\151240p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\151240p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

end.
