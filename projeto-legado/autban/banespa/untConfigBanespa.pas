unit untConfigBanespa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Mask, DirectoryEditFocus, StrUtils,
  Buttons, ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, AppEvnts, Uni,
  BitBtnLockedIncrem, JvExMask, JvToolEdit, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, 
  untFrameDirectoryEditFocus;

type
  TfrmConfigBanespa = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    lblCodCart: TLabel;
    lblProNum: TLabel;
    lblIdentBanco: TLabel;
    lblCodAgenc: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblResp: TLabel;
    ColorLabel1: TColorLabel;
    Label3: TLabel;
    Label4: TLabel;
    fraPathRemessa: TfraDirectoryEditFocus;
    edtResp: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtIdentBanc: TEditFocus;
    edtDiasProt: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodCar: TEditFocus;
    edtCodAgencia: TEditFocus;
    fraPathRetorno: TfraDirectoryEditFocus;
    edtInstrucao1: TEditFocus;
    edtInstrucao2: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
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
    lbl1: TLabel;
    edtInfAdi: TEditFocus;
    btnGravar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    procedure btnGravarClick(Sender: TObject);
    procedure pCarregaDados;
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
    function fValidaNosNumCADCBI: Boolean;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigBanespa: TfrmConfigBanespa;

implementation

uses untfuncoesSimples,
     untPesqAux, untCfgGenericas_AutBan, DB, untConsultas;

{$R *.dfm}

procedure TfrmConfigBanespa.btnGravarClick(Sender: TObject);
begin
  inherited;

  If Not fValidaNosNumCADCBI Then
    Exit;

  If fVerificaCampos Then
  Begin
    Try
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', edtProxNumArqRem.Text);
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text       );
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', edtIdentBanc.Text    );
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text    );
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', edtInstrucao1.Text   );
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', edtInstrucao2.Text   );

      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text);
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text);
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text);
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text);
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text);

      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessa.edtDirectory.text);
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetorno.edtDirectory.text);
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text     );
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', edtCtaBai.Text     );

      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text   );
      fArqIniAutban(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text     );
      fArqIniAutBan(1, 'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text     );


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

procedure TfrmConfigBanespa.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  edtProxNumArqRem.Text := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'PROXNUM','');
  edtCodCar.Text        := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'CODCART','');
  edtIdentBanc.Text     := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'IDENTBC','');
  edtCodAgencia.Text    := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'CODAGEN','');
  edtContaCorr.Text     := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'NUMCTAC','');
  edtDiasProt.Text      := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'DIAPROT','');
  edtResp.Text          := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'RESPONS','');
  edtInstrucao1.Text    := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU1','');
  edtInstrucao2.Text    := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'INSTRU2','');

  edtObservacao1.Text   := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text   := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text   := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text   := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text   := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');

  fraPathRemessa.edtDirectory.text   := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'PATHREM','' );
  fraPathRetorno.edtDirectory.text   := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'PATHRET','' );
  edtCodPor.Text        := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'PORBAI_','' );
  edtCtaBai.Text        := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'CTABAI_','' );
  edtDiasCred.Text      := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'DIACRED','' );
  edtProAce.Text        := fArqIniAutban(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'PROACEI', '');
  edtInfAdi.Text        := fArqIniAutBan(0,'CONFIG033-' + IntToStr(tabCarteira.TabIndex + 1),'INFADIC', '');                                                                                                             


  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCtaBai.Text ) Then
    pCarregaCentroCusto(edtCtaBai.Text, edtDesCtaBai);

end;

procedure TfrmConfigBanespa.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;
  pSetFocus(edtProxNumArqRem);
  
end;

function TfrmConfigBanespa.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

      If (edtResp.Text <> 'B') And (edtResp.Text <> 'E') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser B ou E!',['&O K']);
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


    Else If Sender = fraPathRemessa Then
    Begin

      If fEmptyStr(fraPathRemessa.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de remessa!',['&O K']);
        Result := False;
      End;
    End

    Else If Sender = fraPathRetorno Then
    Begin

      If fEmptyStr(fraPathRetorno.edtDirectory.text) Then
      Begin
        fMensagem('','Preencha o campo Path de retorno!',['&O K']);
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

procedure TfrmConfigBanespa.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

procedure TfrmConfigBanespa.edtCodPorKeyPress(Sender: TObject;
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

procedure TfrmConfigBanespa.edtCtaBaiKeyPress(Sender: TObject;
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

procedure TfrmConfigBanespa.pCarregaCentroCusto(strCtaBai: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    edtDesCtaBai.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmConfigBanespa.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmConfigBanespa.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
  pCarKeyAutBan;

end;

procedure TfrmConfigBanespa.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try

    Application.CreateForm(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '033';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigBanespa.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\033400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\033400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

{**********************************************}
{* VERIFICA QUANDO RESP. FOR EMPRESA SE  OS   *}
{* REGISTROS DO CADCBI ESTAO TODOS COM NOSNUM *}
{*******************************************JB*}
function TfrmConfigBanespa.fValidaNosNumCADCBI: Boolean;
  Var
    qryRemessa: TUniQuery;
    strSQL    : String;
    strDocErr : String;
begin
  {******************************************************}
  {* QUANDO RESP. POR EMISSAO FOR BANCO IGNORA A ROTINA *}
  {***************************************************JB*}
  If SameText(edtResp.Text, 'B') Then
  Begin
    Result := True;
    Exit;
  End;

  qryRemessa := fCriaQuery(Self);

  strSQL := EmptyStr;
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  B.CBI_NOSNUM AS NOSNUM, ';
  strSQL := strSQL + '  B.CBI_NUMDUP AS NUMDUP  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCBI B ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CBI_CODBCO = "033  "        AND ';
  strSQL := strSQL + '  IFNULL(CBI_NOSNUM,"") = ""      ';

  strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'CADCBI', 'CADCBIX');

  With qryRemessa Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    Result := qryRemessa.IsEmpty;

    strDocErr := EmptyStr;
    While Not Eof Do
    Begin
      If fEmptyStr(strDocErr) Then
        strDocErr := FieldByName('NUMDUP').AsString
      Else
        strDocErr := Concat(strDocErr, ', ', FieldByName('NUMDUP').AsString);

      Next;  
    End;

    If Not Result Then
      fMensagem('Atenção!', 'Não é possivel Exportar Arquivo de Remessa com Resp. por Emissão do tipo "Empresa" quando ha documentos sem Nosso Numero.' + #13 +
                            'Documento(s): ' + strDocErr, ['&O K'], 1, True);
  End;

end;

end.
