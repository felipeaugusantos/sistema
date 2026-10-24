unit untCfgGenericas_AutBan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, QColorLabel,
  EditFocus, AppEvnts, UniClientDataSet, DB, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, Uni, StrUtils, UniDataSetProvider, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, dxScreenTip, dxCustomHint, cxHint,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  untFrameCentroCustoEditFocus, cxTextEdit, ComboBoxFocus, Vcl.ComCtrls;

type
  TfrmCfgGenericas_AutBan = class(TfrmPai)
    pnlFundo: TPanel;
    Label13: TLabel;
    edtRemSomAtu: TEditFocus;
    ColorLabel3: TColorLabel;
    pnlTopo: TPanel;
    lblJuros: TLabel;
    edtJuros: TEditFocus;
    lblDesconto: TLabel;
    edtDesconto: TEditFocus;
    Label2: TLabel;
    dtsRetOco: TDataSource;
    btnGravar: TBitBtnLocked;
    edtBaiDivAut: TEditFocus;
    ColorLabel1: TColorLabel;
    Label5: TLabel;
    HintControler: TcxHintStyleController;
    btnInfo: TBitBtnLocked;
    pgcDadosConfiguracoes: TPageControl;
    tabOcorrencias: TTabSheet;
    Panel1: TPanel;
    dbgEventos: TcxGrid;
    dbgEventosView: TcxGridDBTableView;
    dbgEventosViewCODOCO: TcxGridDBColumn;
    dbgEventosViewMOTOCO: TcxGridDBColumn;
    dbgEventosViewDESEVE: TcxGridDBColumn;
    dbgEventosViewDESPOR: TcxGridDBColumn;
    dbgEventosLevel1: TcxGridLevel;
    Panel3: TPanel;
    Label4: TLabel;
    Panel2: TPanel;
    gpbRetorno: TGroupBox;
    lblDescOco: TLabel;
    Label6: TLabel;
    edtCodOco: TEditFocus;
    btnConfirma: TBitBtnLocked;
    chkAtuPor: TCheckBox;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    fraCentroCusto: TfraCentroCustoEditFocus;
    edtMotOco: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtJurosEnter(Sender: TObject);
    procedure edtJurosExit(Sender: TObject);
    procedure chkAtuPorClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure chkAtuPorEnter(Sender: TObject);
    procedure chkAtuPorExit(Sender: TObject);
    procedure ApplicationEventsActivate(Sender: TObject);
    procedure fraCentroCustoedtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure btnInfoClick(Sender: TObject);
  private
    { Private declarations }
    qryRetOco : TUniQuery;
    cdsRetOco : TUniClientDataSet;
    dspRetOco : TUniDataSetProvider;
    qryCadPor : TUniQuery;

    FConfiguracao: String;

    procedure pCarregaEvento;
    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pHideHint;
    function fGravaOcoRet: Boolean;
    function fCarregaCfg(strCodBco: String;Var stlCampos: TStringList): String;
    procedure pGravouOcoRet(Var strCmpAlt: String);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure AjustaFormParaBancoAPI;
    procedure UsaAtualizacaoPorOcorrenciaEMotivo;

    function RetornaConfiguracao(ANomeFormulario: String): String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;

  public
    { Public declarations }
    strNomForm : String;
    strCodBco  : String;
    strCartei  : String;

    function fRetRemessaLocal: String;
    function fRetJuros: String;
    function fRetDesconto: String;
    function fRetBaixaDivAutomatica: String;

  end;

var
  frmCfgGenericas_AutBan: TfrmCfgGenericas_AutBan;

implementation

uses untfuncoesSimples, untConsultas, untPesqAux, untMemo;


{$R *.dfm}


procedure TfrmCfgGenericas_AutBan.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    pHideHint;

    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPor, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCfgGenericas_AutBan.edtJurosEnter(Sender: TObject);
begin
  inherited;
  edtJuros.Hint := 'O percentual (%) de juros ao mês deve acompanhar a '+#13#10+
                   '[CFG_TAXDIA], configurada em AUTCOM > Útil > Configurações.' ;

  pShowHint(edtJuros, 'Juros');
end;

procedure TfrmCfgGenericas_AutBan.edtJurosExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

function TfrmCfgGenericas_AutBan.fCarregaCfg(strCodBco: String; var stlCampos: TStringList): String;
begin
  Result := '';
  Result := Result + 'Gera Remessa local:' +  fGetBancoConfig(0, FConfiguracao, 'RELOCAL', '') + #13+#10;
  stlCampos.Add('Gera Remessa local:' + fGetBancoConfig(0, FConfiguracao, 'RELOCAL', ''));
  Result := Result +'Juros (%)         :' +  fGetBancoConfig(0, FConfiguracao, 'JUROSDI', '') + #13+#10;
  stlCampos.Add('Juros (%)         :' + fGetBancoConfig(0, FConfiguracao, 'JUROSDI', ''));

  If edtDesconto.Visible Then
  Begin
    Result := Result +'Desconto (%)         :' +  fGetBancoConfig(0, FConfiguracao, 'DESCONT', '') + #13+#10;
    stlCampos.Add('Desconto (%)         :' + fGetBancoConfig(0, FConfiguracao, 'DESCONT', ''));
  End;

  Result := Result + 'Não deixa val div :' +  fGetBancoConfig(0, FConfiguracao, 'BAIDIVAUT','');
  stlCampos.Add('Não deixa val div :' + fGetBancoConfig(0, FConfiguracao, 'BAIDIVAUT', ''));
end;

function TfrmCfgGenericas_AutBan.fGravaOcoRet: Boolean;
  Var
    qryAux: TUniQuery;

begin

  Result := True;

  Try
    fStartTransaction;

    qryAux := fCriaQuery(Nil);

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' DELETE FROM OCORET WHERE RET_CODBCO = :CODBCO AND RET_CODEMP = :CODEMP ');
      If (Not fEmptyStr(strCartei)) Then
         SQL.Add(' AND RET_CARTEI = :CARTEI ');
      ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If (Not fEmptyStr(strCartei)) Then
         ParamByName('CARTEI').AsString := strCartei;

      ExecSQL;
    End;

    cdsRetOco.First;

    While Not cdsRetOco.Eof Do
    Begin
      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' INSERT INTO OCORET (RET_CODOCO, RET_CODEVE, RET_CODBCO, RET_CODEMP, RET_CODPOR, RET_MOTOCO ');

        If (Not fEmptyStr(strCartei)) Then
           SQL.Add(' ,RET_CARTEI');

        SQL.Add(' ) ');

        SQL.Add(' VALUES (:CODOCO, :CODEVE, :CODBCO, :CODEMP, :CODPOR, :MOTOCO ');

        If (Not fEmptyStr(strCartei)) Then
           SQL.Add(' ,:CARTEI');

        SQL.Add(' ) ');

        ParamByName('CODOCO').AsString := cdsRetOco.FieldByName('CODOCO').AsString;
        ParamByName('MOTOCO').AsString := cdsRetOco.FieldByName('MOTOCO').AsString;
        ParamByName('CODEVE').AsString := cdsRetOco.FieldByName('CODEVE').AsString;
        ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODPOR').Value    := IIF(fEmptyStr(cdsRetOco.FieldByName('CODPOR').AsString),
                                              Null,
                                              cdsRetOco.FieldByName('CODPOR').AsString);

        If (Not fEmptyStr(strCartei)) Then
           ParamByName('CARTEI').AsString := strCartei;

        ExecSQL;
      End;

      cdsRetOco.Next;
    End;

    fCommit;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmCfgGenericas_AutBan.fGravaOcoRet');
      fRollBack;
      Result := False;
    End;
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmCfgGenericas_AutBan.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsRetOco);
  FreeAndNil(qryRetOco);

end;

procedure TfrmCfgGenericas_AutBan.FormCreate(Sender: TObject);
begin
  inherited;

  cdsRetOco := TUniClientDataSet.Create(Self);
  dspRetOco := TUniDataSetProvider.Create(Self);
  dtsRetOco.DataSet := cdsRetOco;
  dbgEventosView.DataController.DataSource := dtsRetOco;
  qryCadPor := fCriaQuery(Self);

end;

procedure TfrmCfgGenericas_AutBan.FormShow(Sender: TObject);
  Var
    strSQL : String;

begin
  inherited;
  pgcDadosConfiguracoes.TabIndex := 0;

  FConfiguracao := RetornaConfiguracao(strNomform);

  edtRemSomAtu.Text := fRetRemessaLocal;
  edtJuros.Text     := fRetJuros;

  If strNomform = 'frmConfigBrasil7d_frmConfigSafra_' Then
    edtDesconto.Text  := fRetDesconto
  Else
  Begin
    lblDesconto.Visible := False;
    edtDesconto.Visible := False;
  End;

  edtBaiDivAut.Text := fRetBaixaDivAutomatica;

  qryRetOco := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                           ';
  strSQL := strSQL + '   RET_CODOCO AS CODOCO,                       ';
  strSQL := strSQL + '   RET_MOTOCO AS MOTOCO,                       ';
  strSQL := strSQL + '   RET_CODPOR AS CODPOR,                       ';
  strSQL := strSQL + '   RET_CODEVE AS CODEVE,                       ';
  strSQL := strSQL + '   EVE_DESEVE AS DESEVE,                       ';
  strSQL := strSQL + '   CONCAT(RET_CODEVE," - ",EVE_DESEVE) AS CENTRO_CUSTO, ';
  strSQL := strSQL + '   CONCAT(RET_CODPOR," - ",POR_NOMPOR) AS PORTADOR,     ';
  strSQL := strSQL + '   POR_NOMPOR AS DESPOR                        ';
  strSQL := strSQL + ' FROM                                          ';
  strSQL := strSQL + '   OCORET                                      ';
  strSQL := strSQL + '   JOIN CADEVE ON EVE_CODEVE = RET_CODEVE      ';
  strSQL := strSQL + '   LEFT JOIN CADPOR ON POR_CODPOR = RET_CODPOR ';
  strSQL := strSQL + ' WHERE                                         ';
  strSQL := strSQL + '   RET_CODBCO =:CODBCO AND RET_CODEMP =:CODEMP ';

  If (Not fEmptyStr(strCartei)) Then
     strSQL := strSQL + ' AND RET_CARTEI = :CARTEI ';

  With qryRetOco Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    If (Not fEmptyStr(strCartei)) Then
       ParamByName('CARTEI').AsString := strCartei;

    Open;

    pSetaClient(qryRetOco);

    First;

    dspRetOco.DataSet := qryRetOco;

    cdsRetOco.SetProvider(dspRetOco);
    cdsRetOco.Open;

  End;

  AjustaFormParaBancoAPI;
  UsaAtualizacaoPorOcorrenciaEMotivo;
end;

procedure TfrmCfgGenericas_AutBan.AjustaFormParaBancoAPI;
begin
  If MatchStr(strNomform, ['frmConfigBancoDoBrasilAPI', 'frmConfigCredisisAPI', 'frmConfigBradescoAPI']) Then
  Begin
    edtBaiDivAut.Top     := edtRemSomAtu.Top;
    Label5.Top           := Label13.Top;
    edtRemSomAtu.Visible := False;
    Label13.Visible      := False;
    lblJuros.Visible     := False;
    edtJuros.Visible     := False;
    edtDesconto.Visible  := False;
    edtRemSomAtu.Visible := False;
    Label2.Visible       := False;
    ColorLabel1.Visible  := False;
    Self.Height          := 485;
  End;
end;

procedure TfrmCfgGenericas_AutBan.ApplicationEventsActivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmCfgGenericas_AutBan.btnConfirmaClick(Sender: TObject);
  Var
    LMsg : String;
begin
  inherited;

  If (Not fValidaCampos(edtCodOco)) Or (Not fValidaCampos(edtCodPor)) Or
     (Not fValidaCampos(fraCentroCusto.edtCodEve)) Then
    Exit;

  If cdsRetOco.Locate('CODOCO;MOTOCO',VarArrayOf([edtCodOco.Text, edtMotOco.Text]), []) Then
  Begin
    LMsg := 'Ocorrência já cadastrada para este banco!';

    If edtMotOco.Visible Then
      LMsg := 'Ocorrência/Motivo já cadastrado para este banco!';

    fMensagem('AVISO',LMsg, ['&OK']);
    pSetFocus(edtCodOco);
    Exit;
  End;

  cdsRetOco.Insert;

  cdsRetOco.FieldByName('CODOCO').AsString := edtCodOco.Text;
  cdsRetOco.FieldByName('MOTOCO').AsString := edtMotOco.Text;
  cdsRetOco.FieldByName('CODEVE').AsString := fraCentroCusto.edtCodEve.Text;
  cdsRetOco.FieldByName('DESEVE').AsString := fraCentroCusto.edtDesEve.Text;
  cdsRetOco.FieldByName('CENTRO_CUSTO').AsString := Concat(fraCentroCusto.edtCodEve.Text, ' - ',fraCentroCusto.edtDesEve.Text);
  cdsRetOco.FieldByName('CODPOR').AsString := edtCodPor.Text;
  cdsRetOco.FieldByName('DESPOR').AsString := edtDesPor.Text;
  cdsRetOco.FieldByName('PORTADOR').AsString := Concat(edtCodPor.Text, ' - ',edtDesPor.Text);

  cdsRetOco.Post;

  edtCodOco.Clear;
  edtMotOco.Clear;
  fraCentroCusto.edtCodEve.Clear;
  edtCodPor.Clear;
  fraCentroCusto.edtDesEve.Clear;
  edtDesPor.Clear;
  chkAtuPor.Checked := False;

  cdsRetOco.ApplyUpdates(0);
  Application.ProcessMessages;

  pSetFocus(edtCodOco);

end;

procedure TfrmCfgGenericas_AutBan.btnGravarClick(Sender: TObject);
  Var
    strCfgAnt,
    strCfgAtu,
    strCmpAlt,
    strRetAlt: String;
    stlCfgAnt,
    stlCfgAtu: TStringList;
    intCont,
    intIndice: Integer;
begin
  //Não pode usar o fVerificaCampos aqui
  If (Not fValidaCampos(edtBaiDivAut)) Or
     (Not fValidaCampos(edtRemSomAtu)) Or
     (Not fValidaCampos(edtJuros)) Or
     (Not fValidaCampos(edtDesconto)) Then
    Exit;

  pGravouOcoRet(strRetAlt);
  inherited;
  strCfgAnt := '';
  strCfgAtu := '';
  strCmpAlt := '';
  stlCfgAnt := TStringList.Create;
  stlCfgAtu := TStringList.Create;

  If FConfiguracao.IsEmpty Then
    FConfiguracao := RetornaConfiguracao(strNomForm);

  strCfgAnt := fCarregaCfg(strCodBco, stlCfgAnt);

  fGetBancoConfig(1, FConfiguracao, 'RELOCAL', edtRemSomAtu.Text);
  fGetBancoConfig(1, FConfiguracao, 'JUROSDI', edtJuros.Text);
  fGetBancoConfig(1, FConfiguracao, 'BAIDIVAUT',edtBAIDIVAUT.Text);

  If edtDesconto.Visible Then
    fGetBancoConfig(1, FConfiguracao, 'DESCONT', edtDesconto.Text);

  strCfgAtu := fCarregaCfg(strCodBco, stlCfgAtu);

  For intCont := 0 To stlCfgAtu.Count - 1 Do
  Begin
    If stlCfgAnt.Strings[intCont] <> stlCfgAtu.Strings[intCont] Then
    Begin
      intIndice := Pos(':', stlCfgAnt.Strings[intCont]);

      If Not fEmptyStr(strCmpAlt) Then
        strCmpAlt := strCmpAlt + #13+#10;

      strCmpAlt := strCmpAlt + Copy(stlCfgAnt.Strings[intCont], 1, intIndice) +
                  ' Valor Anterior - ' + Copy(stlCfgAnt.Strings[intCont], intIndice + 1, Length(stlCfgAnt.Strings[intCont]) - intIndice) +
                  ' Valor Atual - ' + Copy(stlCfgAtu.Strings[intCont], intIndice + 1, Length(stlCfgAtu.Strings[intCont]) - intIndice);
    End;
  End;

  If Not fEmptyStr(strCmpAlt) Or
     Not fEmptyStr(strRetAlt) Then
    pGravaLogAtb(LeftStr(strCodBco, 3), fRetNomBanco(LeftStr(strCodBco, 3)), FConfiguracao,
                 strLoginUsuarioLogado, VS_StrCodEmp, strCfgAnt, strCfgAtu, strCmpAlt + IIF(Not fEmptyStr(strRetAlt), #13+#10 + strRetAlt, ''));

  If Not fGravaOcoRet Then
  Begin
    fMensagem('','Não foi possível gravar as ocorrências!', ['&O K']);
    Exit;
  End
  Else
  Begin
    fMensagem('','Dados gravados com sucesso!',['&O K']);
    btnSair.Click;
  End;

  FreeAndNil(stlCfgAnt);
  FreeAndNil(stlCfgAtu);
end;



procedure TfrmCfgGenericas_AutBan.btnInfoClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;

  If strNomform = 'frmConfigSafra' Then
  Begin
    pHideHint;

    strDetalhe := #13#10 +
                  'Motivo: 98 - Transferência da conta vinculada.' + #13#10 +
                  'Motivo: 99 - Desconto das ocorrências.' + #13#10 +
                  #13#10 +
                  'Pressione Esc para voltar à tela de configurações.';

    TfrmMemo.pShowMessage('Banco 422 - Banco Safra - Informações dos motivos fixos para importar as ocorrências.' + #13#10 +
                          strDetalhe);

    Exit;
  End;

  If strNomform.Equals('frmConfigItauApi') Then
  Begin
    pHideHint;

    strDetalhe := #13#10 +
                  'Para o banco Itaú Online, são tratadas apenas as ocorrências: '  + #13#10 +
                  '02 - Entrada confirmada;' + #13#10 +
                  '32 - Transferência de título para cartório.' + #13#10 +
                  #13#10 +
                  'Pressione Esc para voltar à tela de configurações.';

    TfrmMemo.pShowMessage('Banco 341 Online - Banco Itaú - Informações das ocorrências fixas.' + #13#10 +
                          strDetalhe);
  End;

end;

procedure TfrmCfgGenericas_AutBan.chkAtuPorClick(Sender: TObject);
begin
  inherited;
  edtCodPor.Enabled := chkAtuPor.Checked;
  edtCodPor.Text := IIF(chkAtuPor.Checked, edtCodPor.Text, '');
  pCarregaPortador(edtCodPor.Text, edtDesPor);
end;

procedure TfrmCfgGenericas_AutBan.chkAtuPorEnter(Sender: TObject);
begin
  inherited;
  HintControler.ShowHint(Self.Left + TControl(Sender).Left + 30,
                        20 + Self.Top + Panel2.Top + TControl(Sender).Top + TControl(Sender).Height,
                        'Alteração do Portador:',
                        'Quando um Portador estiver vinculado a Ocorrência, ' + #13 +
                        'ao realizar a Baixa/Atualização do registro, ' + #13 +
                        'será atualizado o Portador da duplicata.');
end;

procedure TfrmCfgGenericas_AutBan.chkAtuPorExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

function TfrmCfgGenericas_AutBan.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
Begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtRemSomAtu) And (edtRemSomAtu.visible) Then
    Begin
      If Pos(edtRemSomAtu.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Gerar Remessa somente para Empresa Local deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtJuros) and (edtJuros.visible) Then
    Begin
      If (fEmptyStr(edtJuros.Text)) Or (fStrToFloat(edtJuros.Text) < 0) Then
      Begin
        fMensagem('','O campo Juros deve ser maior ou igual a 0 !',['&O K']);
        Result := False;
      End;
    End
    Else If (Sender = edtDesconto) And (edtDesconto.Visible) Then
    Begin
      If (fEmptyStr(edtDesconto.Text)) Or (fStrToFloat(edtDesconto.Text) < 0) Then
      Begin
        fMensagem('','O campo Desconto deve ser maior ou igual a 0 !',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        pCarregaEvento;
        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!', ['&O K']);
          Result := False;
        End;

        btnConfirma.Enabled := Result;
      End
      Else
      Begin
        fMensagem('', 'O campo Centro de Custos deve ser preenchido!', ['&O K']);
        fraCentroCusto.edtDesEve.Clear;
        Result := False;
      End;
    End

    Else If (Sender = edtCodOco) Then
    Begin
      If fEmptyStr(edtCodOco.Text) Then
      Begin
        fMensagem('', 'O Código da ocorrência deve ser preenchido!', ['&O K']);
        Result := False;
      End
      Else If FConfiguracao.Equals('CONFIG341API') Then
      Begin
        If Not MatchStr(edtCodOco.Text, ['32', '02']) Then
        Begin
          fMensagem('', 'O código da ocorrência digitado não é válido!' + #13#10 +
                        'Códigos válidos:' + #13#10 +
                        '"02" - Entrada confirmada;' + #13#10 +
                        '"32" - Transferência de título para cartório.', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtBAIDIVAUT Then
    Begin
      If Pos(edtBAIDIVAUT.Text, 'SN') <= 0 Then
      Begin
        fMensagem('','O campo Não baixar automaticamente se houver divergência de valores deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodPor) And (chkAtuPor.Checked) Then
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
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);

End;


procedure TfrmCfgGenericas_AutBan.pCarregaEvento;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmCfgGenericas_AutBan.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := IIF(fEmptyStr(strCodPor), '', FieldByName('POR_NOMPOR').AsString);
  End;
end;

procedure TfrmCfgGenericas_AutBan.pGravouOcoRet(var strCmpAlt: String);
  Var
    strSQL : String;
    qryAux : TUniQuery;
begin
  qryAux := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   RET_CODOCO, ';
  strSQL := strSQL + '   RET_CODEVE, ';
  strSQL := strSQL + '   EVE_DESEVE  ';
  strSQL := strSQL + ' FROM          ';
  strSQL := strSQL + '   OCORET,                  ';
  strSQL := strSQL + '   CADEVE                   ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   EVE_CODEVE = RET_CODEVE  ';
  strSQL := strSQL + '   AND RET_CODBCO = :CODBCO ';
  strSQL := strSQL + '   AND RET_CODEMP = :CODEMP ';

  With qryAux Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;

  cdsRetOco.DisableControls;

  strCmpAlt := '';

  cdsRetOco.First;
  While Not cdsRetOco.Eof Do
  Begin
    If Not qryAux.Locate('RET_CODOCO;RET_CODEVE', VarArrayOf([cdsRetOco.FieldByName('CODOCO').AsString,cdsRetOco.FieldByName('CODEVE').AsString]), []) Then
      strCmpAlt := strCmpAlt + 'Ocorrência ' + cdsRetOco.FieldByName('CODOCO').AsString + ' - ' + 'Centro de Custos ' + cdsRetOco.FieldByName('CODEVE').AsString + ' - ' +
                               cdsRetOco.FieldByName('DESEVE').AsString + ' *** ADICIONADO ***' + #13+#10;

    cdsRetOco.Next;
  End;

  qryAux.First;
  While Not qryAux.Eof Do
  Begin
    If Not cdsRetOco.Locate('CODOCO;CODEVE', VarArrayOf([qryAux.FieldByName('RET_CODOCO').AsString,qryAux.FieldByName('RET_CODEVE').AsString]), []) Then
      strCmpAlt := strCmpAlt + 'Ocorrência ' + qryAux.FieldByName('RET_CODOCO').AsString + ' - ' + 'Centro de Custos ' + qryAux.FieldByName('RET_CODEVE').AsString + ' - ' +
                               qryAux.FieldByName('EVE_DESEVE').AsString + ' *** EXCLUIDO ***' + #13+#10;

    qryAux.Next;
  End;

  cdsRetOco.EnableControls;
  FreeAndNil(qryAux);
end;

procedure TfrmCfgGenericas_AutBan.pHideHint;
begin
   HintControler.HideHint;
end;

procedure TfrmCfgGenericas_AutBan.pShowHint(edtEdit: TEditFocus;
  strTitulo: String);
begin
  HintControler.ShowHint(Self.Left + edtEdit.Left,
  Self.Top + 5 + edtEdit.Top + edtEdit.Height, strTitulo, edtEdit.Hint);
end;

function TfrmCfgGenericas_AutBan.RetornaConfiguracao(ANomeFormulario: String): String;
begin
  If ANomeFormulario = 'frmConfigBanespa' Then
    Result := 'CONFIG033'

  Else If ANomeFormulario = 'frmConfigSantander' Then
    Result := 'CONFIG353'

  Else If SameText(ANomeFormulario,'frmConfigSantanderBan') Then
    Result := 'CONFIG033B'

  Else If SameText(ANomeFormulario, 'frmConfigSantanderAPI') Then
    Result := 'CONFIG033API'

  Else If SameText(ANomeFormulario, 'frmConfigBradescoAPI') Then
    Result := 'CONFIG237API'

  Else If SameText(ANomeFormulario,'frmConfigSantander240p') Then
    Result := 'CONFIG033B240p'

  Else If SameText(ANomeFormulario,'frmConfigBanestes') Then
    Result := 'CONFIG021'

  Else If ANomeFormulario = 'frmConfigSafra' Then
    Result := 'CONFIG422'

  Else If ANomeFormulario = 'frmConfigBradesco' Then
    Result := 'CONFIG237'

  Else If ANomeFormulario = 'frmConfigMultibank' Then
    Result := 'CONFIG983'

  Else If ANomeFormulario = 'frmConfigMultiplike' Then
    Result := 'CONFIG981'

  Else If ANomeFormulario.Equals('frmConfigJpiFidc') Then
    Result := 'CONFIG906'

  Else If ANomeFormulario.Equals('frmConfigCapitalFinancas') Then
    Result := 'CONFIG978'

  Else If ANomeFormulario.Equals('frmConfigSRM') Then
    Result := 'CONFIG990'

  Else If ANomeFormulario.Equals('frmConfigFidussia') Then
    Result := 'CONFIG970'

  Else If ANomeFormulario = 'frmConfigBradesco240Vendor' Then
    Result := 'CONFIG237_VENDOR'

  Else If ANomeFormulario = 'frmConfigBrasil' Then
    Result := 'CONFIG001'

  Else If ANomeFormulario = 'frmConfigBrasil7d' Then
    Result := 'CONFIG001D7'

  Else If ANomeFormulario = 'frmConfigBancoDoBrasilAPI' Then
    Result := 'CONFIG001API'

  Else If ANomeFormulario = 'frmConfigCredisisAPI' Then
    Result := 'CONFIG097API'

  Else If ANomeFormulario = 'frmConfigSicrediAPI' Then
    Result := 'CONFIG748API'

  Else If ANomeFormulario = 'frmConfigSafraAPI' Then
    Result := 'CONFIG422API'

  Else If ANomeFormulario = 'frmConfigCxFederal' Then
    Result := 'CONFIG104'

  Else If ANomeFormulario = 'frmConfigCxFederal7D' Then
    Result := 'CONFIG1047D'

  Else If ANomeFormulario = 'frmConfigCxFederal400p' Then
    Result := 'CONFIG104p400'

  Else If ANomeFormulario = 'frmConfigHsbc' Then
    Result := 'CONFIG399'

  Else If ANomeFormulario = 'frmConfigBancoInter' Then
    Result := 'CONFIG077'

  Else If ANomeFormulario = 'frmConfigUnicred400' Then
    Result := 'CONFIG090_400p'

  Else If ANomeFormulario = 'frmConfigUnicred400_136' Then
    Result := 'CONFIG136_400p'

  Else If ANomeFormulario = 'frmConfigItau' Then
    Result := 'CONFIG341'

  Else If ANomeFormulario = 'frmConfigDaycoval' Then
    Result := 'CONFIG995'

  Else If ANomeFormulario = 'frmConfigDaycoval_707' Then
    Result := 'CONFIG707'

  Else If ANomeFormulario = 'frmConfigSBCredito' Then
    Result := 'CONFIG988'

  Else If ANomeFormulario = 'frmConfigSBCredito_Bradesco' Then
    Result := 'CONFIG987'

  Else If ANomeFormulario = 'frmConfigABCBrasil' Then
    Result := 'CONFIG246'

  Else If ANomeFormulario = 'frmConfigSerrana' Then
    Result := 'CONFIG991'

  Else If ANomeFormulario = 'frmConfigRubi' Then
    Result := 'CONFIG989'

  Else If ANomeFormulario = 'frmConfigReal' Then
    Result := 'CONFIG356'

  Else If ANomeFormulario = 'frmConfigMerc' Then
    Result := 'CONFIG389'

  Else If ANomeFormulario = 'frmConfigNossaCx' Then
    Result := 'CONFIG151'

  Else If ANomeFormulario = 'frmConfigRibPreto' Then
    Result := 'CONFIG741'

  Else If ANomeFormulario = 'frmConfigUnibanco' Then
    Result := 'CONFIG409'

  Else If ANomeFormulario = 'frmConfigBanrisul' Then
    Result := 'CONFIG041'

  Else If ANomeFormulario = 'frmConfigBanrisul240' Then
    Result := 'CONFIG041_240p'

  Else If ANomeFormulario = 'frmConfigSofisa' Then
    Result := 'CONFIG637'

  Else If ANomeFormulario = 'frmConfigBRB400p' Then
    Result := 'CONFIG070p400'

  Else If ANomeFormulario = 'frmConfigBancoob' Then
    Result := 'CONFIG756'

  Else If ANomeFormulario = 'frmConfigBancoob240' Then
    Result := 'CONFIG756_240p'

  Else If SameText(ANomeFormulario, 'frmConfigSicoobApi') Then
    Result := 'CONFIG756API'

  Else If ANomeFormulario = 'frmConfigSicredi' Then
    Result := 'CONFIG748'

  Else If ANomeFormulario = 'frmConfigRedasset' Then
    Result := 'CONFIG993'

  Else If ANomeFormulario = 'frmConfigCreditBrasil' Then
    Result := 'CONFIG992'

  Else If ANomeFormulario = 'frmConfigGarsonCredito' Then
    Result := 'CONFIG997'

  Else If ANomeFormulario = 'frmConfigSifra' Then
    Result := 'CONFIG998'

  Else If ANomeFormulario = 'frmConfigGrupoSifra' Then
    Result := 'CONFIG979'

  Else If ANomeFormulario = 'frmConfigSicredi_240' Then
    Result := 'CONFIG748_240'

  Else If ANomeFormulario = 'frmConfigSantanderCta' Then
    Result := 'CONFIGCTA033'

  Else If ANomeFormulario = 'frmConfigBancoobCta' Then
    Result := 'CONFIGCTA756'

  Else If ANomeFormulario = 'frmConfigBradescoCta' Then
    Result := 'CONFIGCTA237'

  Else If ANomeFormulario = 'frmConfigBanrisulCta' Then
    Result := 'CONFIGCTA041'

  Else If ANomeFormulario = 'frmConfigABCBrasilCta' Then
    Result := 'CONFIGCTA246'

  Else If ANomeFormulario = 'frmConfigItauCta' Then
    Result := 'CONFIGCTA341'

  Else If ANomeFormulario = 'frmConfigItauAPI' Then
    Result := 'CONFIG341API'

  Else If SameText(ANomeFormulario,'frmConfigSofisa_444') Then
    Result := 'CONFIG637_444p'

  Else If SameText(ANomeFormulario,'frmConfigBtgPactual_240p') Then
    Result := 'CONFIG208'

  Else If SameText(ANomeFormulario,'frmConfigSparti') Then
    Result := 'CONFIG982'

  Else If SameText(ANomeFormulario,'frmConfigBancoLecca') Then
    Result := 'CONFIG984'

  Else If ANomeFormulario.Equals('frmConfigBMPMoneyPlus') Then
    Result := 'CONFIG274'

  Else If ANomeFormulario.Equals('frmConfigSisprime') Then
    Result := 'CONFIG084'

  Else If ANomeFormulario = 'frmConfigLakeBank' Then
    Result := 'CONFIG977'

  Else If ANomeFormulario = 'frmConfigLotus' Then
    Result := 'CONFIG976'

  Else If ANomeFormulario = 'frmConfigJPCapital' Then
    Result := 'CONFIG975'

  Else If ANomeFormulario = 'frmConfigOlam' Then
    Result := 'CONFIG974'

  Else If ANomeFormulario = 'frmConfigBelaVista' Then
    Result := 'CONFIG973'

  Else If SameText(ANomeFormulario,'frmConfigSofisa_LP_444') Then
    Result := 'CONFIG637LP444p'

  Else If SameText(ANomeFormulario,'frmConfigBMPMoneyPlus_LP_400') Then
    Result := 'CONFIG274LP400p'

  Else If SameText(ANomeFormulario,'frmConfigFinanceiraFormula') Then
    Result := 'CONFIG964'

  Else If ANomeFormulario = 'frmConfigBancoCredVale' Then
    Result := 'CONFIG962'

  //Esse tem que ficar por último
  Else If (Not fEmptyStr(strCodBco)) Then
    Result := 'CONFIG' + strCodBco;
end;

procedure TfrmCfgGenericas_AutBan.UsaAtualizacaoPorOcorrenciaEMotivo;
begin
  dbgEventosViewMOTOCO.Visible := False;
  If strNomform = 'frmConfigBradesco' Then
  Begin
    lblDescOco.Caption := 'Ocorrência / Motivo:';
    edtMotOco.Visible := True;
    dbgEventosViewMOTOCO.Visible := True;
  End
  Else
  If strNomform = 'frmConfigSafra' Then
  Begin
    lblDescOco.Caption := 'Ocorrência / Motivo:';
    edtMotOco.Visible := True;
    dbgEventosViewMOTOCO.Visible := True;
    btnInfo.visible := True;
  End;

end;

function TfrmCfgGenericas_AutBan.fRetRemessaLocal: String;
begin
  If FConfiguracao.IsEmpty Then
    FConfiguracao := RetornaConfiguracao(strNomForm);

  Result := fGetBancoConfig(0, FConfiguracao, 'RELOCAL', '');

  If strNomform = 'frmConfigBanespa' Then
  Begin
    pnlTopo.Caption := 'Configuração 033 - Banespa';
  End

  Else If strNomform = 'frmConfigSantander' Then
  Begin
    pnlTopo.Caption := 'Configuração 353 - Santander';
  End

  Else If SameText(strNomform,'frmConfigSantanderBan') Then
  Begin
    pnlTopo.Caption := 'Configuração 033 - Santander';
  End

  Else If SameText(strNomform,'frmConfigSantanderAPI') Then
  Begin
    pnlTopo.Caption := 'Configuração 033 - Santander [Online]';
  End

  Else If SameText(strNomform,'frmConfigBradescoAPI') Then
  Begin
    pnlTopo.Caption := 'Configuração 237 - Bradesco [Online]';
  End

  Else If SameText(strNomform,'frmConfigSantander240p') Then
  Begin
    pnlTopo.Caption := 'Configuração 033 - Santander[240p]';
  End

  Else If SameText(strNomform,'frmConfigBanestes') Then
  Begin
    pnlTopo.Caption := 'Configuração 021 - Banestes';
  End

  Else If strNomForm = 'frmConfigSafra' Then
  Begin
    pnlTopo.Caption := 'Configuração 422 - Safra';
  End

  Else If strNomform = 'frmConfigBradesco' Then
  Begin
    pnlTopo.Caption := 'Configuração 237 - Bradesco';
  End

  Else If strNomform = 'frmConfigMultibank' Then
  Begin
    pnlTopo.Caption := 'Configuração 983 - Multibank';
  End

  Else If strNomform = 'frmConfigMultiplike' Then
  Begin
    pnlTopo.Caption := 'Configuração 981 - Multiplike';
  End

  Else If strNomform = 'frmConfigJpiFidc' Then
  Begin
    pnlTopo.Caption := 'Configuração 906 - Banco FIDC';
  End

  Else If strNomform = 'frmConfigCapitalFinancas' Then
  Begin
    pnlTopo.Caption := 'Configuração 978 - Capital Finanças';
  End

  Else If strNomform = 'frmConfigSRM' Then
  Begin
    pnlTopo.Caption := 'Configuração 990 - Banco SRM';
  End

  Else If strNomform = 'frmConfigFidussia' Then
  Begin
    pnlTopo.Caption := 'Configuração 970 - Banco Fidussia';
  End

  Else If strNomform = 'frmConfigBancoInter' Then
  Begin
    pnlTopo.Caption := 'Configuração 077 - Banco Inter';
  End

  Else If strNomform = 'frmConfigBradesco240Vendor' Then
  Begin
    pnlTopo.Caption := 'Configuração 237 - Bradesco 240p Vendor';
  End

  //*************************************************//
  // BANCO DO BRASIL DE 6 DIGITOS                    //
  //**********************************************ED*//
  Else If strNomform = 'frmConfigBrasil' Then
  Begin
    pnlTopo.Caption := 'Configuração 001 - Brasil';
  End

  //*************************************************//
  // BANCO DO BRASIL DE 7 DIGITOS                    //
  //**********************************************ED*//
  Else If strNomform = 'frmConfigBrasil7d' Then
  Begin
    pnlTopo.Caption := 'Configuração 001 - Brasil7d';
  End

  {**************************
  * BANCO DO BRASIL [API]   *
  ************************MT*}
  Else If strNomform = 'frmConfigBancoDoBrasilAPI' Then
  Begin
    pnlTopo.Caption := 'Configuração 001 - Banco do Brasil [Online]';
  End

  {**************************
  * BANCO CREDISIS [API]   *
  ************************MT*}
  Else If strNomform = 'frmConfigCredisisAPI' Then
  Begin
    pnlTopo.Caption := 'Configuração 097 - Banco Credisis [Online]';
  End

  {**************************
  * BANCO SICREDI [API]   *
  ************************MT*}
  Else If strNomform = 'frmConfigSicrediAPI' Then
  Begin
    pnlTopo.Caption := 'Configuração 748 - Banco Sicredi [Online]';
  End

  {**************************
  * BANCO SICREDI [API]   *
  ************************MT*}
  Else If strNomform = 'frmConfigSafraAPI' Then
  Begin
    pnlTopo.Caption := 'Configuração 422 - Banco Safra [Online]';
  End

  //*************************************************//
  // CAIXA ECONOMICA FEDERAL 240 POSICOES            //
  //**********************************************ED*//
  Else If strNomform = 'frmConfigCxFederal' Then
  Begin
    pnlTopo.Caption := 'Configuração 104 - Caixa Fed.';
  End

  Else If strNomform = 'frmConfigCxFederal7D' Then
  Begin
    pnlTopo.Caption := 'Configuração 104 - Caixa Fed.[7D]';
  End

  //*************************************************//
  // CAIXA ECONOMICA FEDERAL 400 POSICOES            //
  //**********************************************ED*//
  Else If strNomform = 'frmConfigCxFederal400p' Then
  Begin
    pnlTopo.Caption := 'Configuração 104 - Caixa Fed.400p';
  End

  Else If strNomform = 'frmConfigHsbc' Then
  Begin
    pnlTopo.Caption := 'Configuração 399 - HSBC';
  End

  Else If strNomform = 'frmConfigItau' Then
  Begin
    pnlTopo.Caption := 'Configuração 341 - Itaú';
  End

  Else If strNomform = 'frmConfigItauApi' Then
  Begin
    pnlTopo.Caption := 'Configuração 341 - Itaú [Online]';
  End

  Else If strNomform = 'frmConfigDaycoval' Then
  Begin
    pnlTopo.Caption := 'Configuração 995 - DAYCOVAL';
  End

  Else If strNomform = 'frmConfigDaycoval_707' Then
  Begin
    pnlTopo.Caption := 'Configuração 707 - DAYCOVAL';
  End

  Else If strNomform = 'frmConfigSBCredito_988' Then
  Begin
    pnlTopo.Caption := 'Configuração 988 - SB CREDITO';
  End

  Else If strNomform = 'frmConfigSBCredito_Bradesco' Then
  Begin
    pnlTopo.Caption := 'Configuração 987 - SB CREDITO BRADESCO';
  End

  Else If strNomform = 'frmConfigABCBrasil' Then
  Begin
    pnlTopo.Caption := 'Configuração 246 - ABC BRASIL';
  End

  Else If strNomform = 'frmConfigSerrana' Then
  Begin
    pnlTopo.Caption := 'Configuração 991 - SERRANA';
  End

  Else If strNomform = 'frmConfigRubi' Then
  Begin
    pnlTopo.Caption := 'Configuração 989 - DATA VENIA';
  End

  Else If strNomform = 'frmConfigUnicred400' Then
  Begin
    pnlTopo.Caption := 'Configuração 090 - Unicred 400p';
  End

  Else If strNomform = 'frmConfigUnicred400_136' Then
  Begin
    pnlTopo.Caption := 'Configuração 136 - Unicred 400p';
  End

  Else If strNomform = 'frmConfigReal' Then
  Begin
    pnlTopo.Caption := 'Configuração 356 - Real';
  End

  Else If strNomform = 'frmConfigMerc' Then
  Begin
    pnlTopo.Caption := 'Configuração 389 - Mercantil';
  End

  Else If strNomform = 'frmConfigNossaCx' Then
  Begin
    pnlTopo.Caption := 'Configuração 151 - N.C.N.B.';
  End

  Else If strNomform = 'frmConfigRibPreto' Then
  Begin
    pnlTopo.Caption := 'Configuração 741 - Rib. Preto';
  End

  Else If strNomform = 'frmConfigUnibanco' Then
  Begin
    pnlTopo.Caption := 'Configuração 409 - Unibanco';
  End

  Else If strNomform = 'frmConfigBanrisul' Then
  Begin
    pnlTopo.Caption := 'Configuração 041 - Banrisul';
  End

  Else If strNomform = 'frmConfigBanrisul240' Then
  Begin
    pnlTopo.Caption := 'Configuração 041 - Banrisul 240p';
  End

  Else If strNomForm = 'frmConfigSofisa' Then
  Begin
    pnlTopo.Caption := 'Configuração 637 - Sofisa';
  End

  Else If strNomform = 'frmConfigBRB400p' Then
  Begin
    pnlTopo.Caption := 'Configuração 070 - BRB';
  End

  Else If strNomform = 'frmConfigBancoob' Then
  Begin
    pnlTopo.Caption := 'Configuração 756 - Bancoob';
  End

  Else If SameText(strNomform,'frmConfigSicoobApi') Then
  Begin
    pnlTopo.Caption := 'Configuração 756 - Sicoob [Online]';
  End

  Else If strNomform = 'frmConfigRedasset' Then
  Begin
    pnlTopo.Caption := 'Configuração 993 - Redasset';
  End

  Else If strNomform = 'frmConfigCreditBrasil' Then
  Begin
    pnlTopo.Caption := 'Configuração 992 - Credit Brasil';
  End

  Else If strNomform = 'frmConfigGarsonCredito' Then
  Begin
    pnlTopo.Caption := 'Configuração 997 - Garson Crédito';
  End

  Else If strNomform = 'frmConfigSifra' Then
  Begin
    pnlTopo.Caption := 'Configuração 998 - Sifra';
  End

  Else If strNomform = 'frmConfigGrupoSifra' Then
  Begin
    pnlTopo.Caption := 'Configuração 979 - Sifra';
  End

  Else If strNomform = 'frmConfigBancoob240' Then
  Begin
    pnlTopo.Caption := 'Configuração 756 - Bancoob 240p';
  End

  Else If strNomform = 'frmConfigSicredi' Then
  Begin
    pnlTopo.Caption := 'Configuração 748 - Sicredi';
  End

  Else If strNomform = 'frmConfigSicredi_240' Then
  Begin
    pnlTopo.Caption := 'Configuração 748 - Sicredi [240p]';
  End

  Else If strNomform = 'frmConfigSantanderCta'  Then
  Begin
    pnlTopo.Caption := 'Configuração Contas a Pagar - 033 - Santander';
  End

  Else If strNomform = 'frmConfigBancoobCta'  Then
  Begin
    pnlTopo.Caption := 'Configuração Contas a Pagar - 756 - Bancoob';
  End

  Else If strNomform = 'frmConfigBradescoCta'  Then
  Begin
    pnlTopo.Caption := 'Configuração Contas a Pagar - 237 - Bradesco';
  End

  Else If strNomform = 'frmConfigBanrisulCta'  Then
  Begin
    pnlTopo.Caption := 'Configuração Contas a Pagar - 041 - Banrisul';
  End

  Else If strNomform = 'frmConfigABCBrasilCta'  Then
  Begin
    pnlTopo.Caption := 'Configuração Contas a Pagar - 246 - ABC Brasil';
  End

  Else If strNomform = 'frmConfigItauCta'  Then
  Begin
    pnlTopo.Caption := 'Configuração Contas a Pagar - 341 - Itau';
  End

  Else If strNomform = 'frmConfigSofisa_444' Then
  Begin
    pnlTopo.Caption := 'Configuração 637 - BANCO SOFISA 444p';
  End

  Else If strNomform = 'frmConfigSofisa_LP_444' Then
  Begin
    pnlTopo.Caption := 'Configuração 637 - BANCO SOFISA LP 444p';
  End

  Else If strNomform = 'frmConfigBMPMoneyPlus_LP_400' Then
  Begin
    pnlTopo.Caption := 'Configuração 274 - BANCO BMP Money Plus LP 444p';
  End

  Else If strNomform = 'frmConfigBMPMoneyPlus' Then
  Begin
    pnlTopo.Caption := 'Configuração 274 - Banco BMP Money Plus - 400p';
  End

  Else If strNomform = 'frmConfigSparti' Then
  Begin
    pnlTopo.Caption := 'Configuração 982 - Sparti';
  End

  Else If strNomform = 'frmConfigBancoLecca' Then
  Begin
    pnlTopo.Caption := 'Configuração 984 - Banco Lecca';
  End

  Else If strNomform = 'frmConfigSisprime' Then
  Begin
    pnlTopo.Caption := 'Configuração 084 - Sisprime';
  End

  Else If strNomform = 'frmConfigLakeBank' Then
  Begin
    pnlTopo.Caption := 'Configuração 977 - Lake Bank';
  End

  Else If strNomform = 'frmConfigLotus' Then
  Begin
    pnlTopo.Caption := 'Configuração 976 - Lotus';
  End

  Else If strNomform = 'frmConfigJPCapital' Then
  Begin
    pnlTopo.Caption := 'Configuração 975 - JP Capital';
  End

  Else If strNomform = 'frmConfigOlam' Then
  Begin
    pnlTopo.Caption := 'Configuração 974 - Olam';
  End

  Else If strNomform = 'frmConfigBelaVista' Then
  Begin
    pnlTopo.Caption := 'Configuração 973 - Bela Vista';
  End

  Else If strNomform = 'frmConfigFinanceiraFormula' Then
  Begin
    pnlTopo.Caption := 'Configuração 964 - Financeira Formula';
  End

  Else If strNomform = 'frmConfigBancoCredVale' Then
  Begin
    pnlTopo.Caption := 'Configuração 962 - Banco Cred Vale';
  End


  //Esse tem que ficar por último
  Else If (Not fEmptyStr(strCodBco)) Then
  Begin
    pnlTopo.Caption := 'Configuração ' + strCodBco + ' - ' + fRetNomBanco(strCodBco);
  End;

end;

function TfrmCfgGenericas_AutBan.fRetJuros: String;
begin
  If FConfiguracao.IsEmpty Then
    FConfiguracao := RetornaConfiguracao(strNomForm);

  Result := fGetBancoConfig(0, FConfiguracao, 'JUROSDI', '');
end;

procedure TfrmCfgGenericas_AutBan.fraCentroCustoedtCodEveKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  fraCentroCusto.edtCodEveKeyPress(Sender, Key);

end;

function TfrmCfgGenericas_AutBan.fRetBaixaDivAutomatica: String;
begin
  If FConfiguracao.IsEmpty Then
    FConfiguracao := RetornaConfiguracao(strNomForm);

  Result := fGetBancoConfig(0, FConfiguracao, 'BAIDIVAUT', '');
end;

function TfrmCfgGenericas_AutBan.fRetDesconto: String;
begin

  If strNomform = 'frmConfigBrasil7d' Then
    Result := fGetBancoConfig(0,'CONFIG001D7', 'DESCONT', '')

  Else If strNomForm = 'frmConfigSofisa' Then
    Result := fGetBancoConfig(0,'CONFIG637', 'DESCONT', '')

  Else If strNomForm = 'frmConfigSafra' Then
    Result := fGetBancoConfig(0,'CONFIG422', 'DESCONT', '');

end;


end.


