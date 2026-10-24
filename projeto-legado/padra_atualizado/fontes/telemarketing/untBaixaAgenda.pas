unit untBaixaAgenda;

interface

uses
  Windows, Classes, Controls, Forms, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  DB, Uni, Mask, MaskEditFocus, DBCtrls, DBMemoFocus, untModulo, untFuncoes,
  untAtendimento, AppEvnts, EditFocus, DBEditFocus, BitBtnLockedIncrem, UniClientDataSet,
  MemDS, DBAccess, frxClass, frxExportCSVTestabilidade, QColorLabel,
  untTypesSistema;

type
  TfrmBaixaAgenda = class(TfrmPai)
    dbmObsBai: TDBMemoFocus;
    Label1: TLabel;
    dscAgeTel: TDataSource;
    qryAgeTel: TUniQuery;
    Label2: TLabel;
    Label3: TLabel;
    pnlReagendar: TPanel;
    chkReagendar: TCheckBox;
    mskDtaAge: TMaskEditFocus;
    dbeCodTpa: TDBEditFocus;
    edtDesTpa: TEditFocus;
    lblTipAte: TLabel;
    btnGravar: TBitBtnLocked;
    btnPesqMerc: TBitBtnLocked;
    dbeNomCli: TDBEditFocus;
    dbeDtaAge: TDBEditFocus;
    lblInformaPesquisaRealizada: TColorLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkReagendarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeCodTpaKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesqMercClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    tagTipAge: TTipoAgendamento;
    blnPesMer: Boolean;

    function fIncluiAgendamento: Boolean;
    function fTemAgendamento: Boolean;
    function fBaixaAgendamento(blnReagendar : Boolean): Boolean;
    function fGetIntervaloAgeCli(strCodCli: String): Integer;
    function fGravaAgePes(var cdsCons:TUniClientDataSet): Boolean;

    function fPesquisaRealizada: Boolean;

  public
    { Public declarations }
    regConsum: TRegistroConsumidor;
    frmAtendimento : TfrmAtendimento;
    cdsRespPesq: TUniClientDataSet;
    blnHisAte : Boolean; // Define se apenas vai registrar o historico, quando True, apenas grava o registro sem baixar. req. 33217
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmBaixaAgenda: TfrmBaixaAgenda;

implementation

uses SysUtils, untConsultas, untFuncoesSimples, untPreenchePesquisa;

{$R *.dfm}

procedure TfrmBaixaAgenda.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(dbeDtaAge);
  pSetFocus(dbmObsBai);    

  If (fCfgSis('TIPATE', varBoolean)) And (Not blnHisAte) Then
  Begin
    Self.ClientHeight := 345;
    lblTipAte.Visible := True;
    dbeCodTpa.Visible := True;
    edtDesTpa.Visible := True;
  End
  Else
  Begin
    Self.ClientHeight := 303;
    lblTipAte.Visible := False;
    dbeCodTpa.Visible := False;
    edtDesTpa.Visible := False;
  End;

  Case StrToIntDef(fCfgSis('TELAGE'),0) Of
    1: tagTipAge := taDiaInicio;
    2: tagTipAge := taContinuo;
    3: tagTipAge := taManual;
    4: tagTipAge := taAutomatico;
  End;

  pnlReagendar.Visible := tagTipAge <> taAutomatico;

  if blnHisAte then
  Begin
    tagTipAge := taManual;
    pnlReagendar.Visible := False;
    Self.Caption := 'Histórico de Atendimento';
  End;

  If Not pnlReagendar.Visible Then
    ClientHeight := ClientHeight - pnlReagendar.Height;

  dbeDtaAge.DataSource := frmAtendimento.dtsConsulta;
  dbeNomCli.DataSource := frmAtendimento.dtsConsulta;

  qryAgeTel.ParamByName('AUTOIN').AsString := frmAtendimento.cdsConsulta.fieldByName('AUTOINCREM').AsString;
  qryAgeTel.Open;
  qryAgeTel.Edit;

  lblInformaPesquisaRealizada.Visible := fPesquisaRealizada;

  Application.ProcessMessages;  
end;

function TfrmBaixaAgenda.fGetIntervaloAgeCli(strCodCli: String): Integer;
  Var
    qryGen: TUniQuery;
Begin
  Result := 0;

  Try
    qryGen := fCriaQuery;

    With qryGen, Sql Do
    Begin
      Close;
      Clear;
      Add('SELECT CLI_INTERV FROM CADCLI WHERE CLI_CODCLI = :CODCLI');
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('CLI_INTERV').AsInteger;

    End;

  Except
    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmBaixaAgenda.fGetIntervaloAgeCli]');
      Result := 0;
    End;
  End;

  FreeAndNil(qryGen);
End;

function TfrmBaixaAgenda.fGravaAgePes(var cdsCons: TUniClientDataSet): Boolean;
  Var
    qryAux: TUniQuery;
begin
  Result := True;
  Try
    qryAux := fCriaQuery(Self);

    cdsCons.First;
    while not cdsCons.Eof Do
    Begin
      With qryAux Do
      Begin
        SQL.Clear;
        SQL.Add('INSERT INTO     ');
        SQL.Add('  AGEPES (      ');
        SQL.Add('    AUTOINCREM, ');        
        SQL.Add('    AGE_CODEMP, ');
        SQL.Add('    AGE_DTAENT, ');
        SQL.Add('    AGE_HORENT, ');
        SQL.Add('    AGE_CODPES, ');
        SQL.Add('    AGE_CODPER, ');
        SQL.Add('    AGE_CODRES, ');
        SQL.Add('    AGE_CODAGE) ');
        SQL.Add('  VALUES (      ');
        SQL.Add('    :AUTINC,    ');        
        SQL.Add('    :CODEMP,    ');
        SQL.Add('    :DTAENT,    ');
        SQL.Add('    :HORENT,    ');
        SQL.Add('    :CODPES,    ');
        SQL.Add('    :CODPER,    ');
        SQL.Add('    :CODRES,    ');
        SQL.Add('    :CODAGE)    ');

        ParamByName('AUTINC').AsString   := fRetAutoIncrem('AGEPES', VS_strCodEmp);        
        ParamByName('CODEMP').AsString   := VS_strCodEmp;
        ParamByName('DTAENT').AsDateTime := VS_Date;
        ParamByName('HORENT').AsDateTime := fTime();
        ParamByName('CODPES').AsString   := cdsCons.FieldByName('CODPES').AsString;
        ParamByName('CODPER').AsString   := cdsCons.FieldByName('CODPER').AsString;
        ParamByName('CODRES').AsString   := cdsCons.FieldByName('RESPOS').AsString;
        ParamByName('CODAGE').AsString   := qryAgeTel.FieldByName('AUTOINCREM').AsString;

        ExecSQL;
      End;

      cdsCons.Next;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      FreeAndNil(qryAux);      
      pMensagensErro(E.Message, '[fGravaAgePes - frmPreenchePesquisa]');
    End;
  End;

  FreeAndNil(qryAux);
end;

function TfrmBaixaAgenda.fIncluiAgendamento: Boolean;
  Var
    qryGen   : TUniQuery;
    strAutoIn: String;
Begin
  Try
    qryGen := fCriaQuery;
    With qryGen, Sql Do
    Begin
      Close;
      Clear;
      Add('INSERT INTO AGETEL ');
      Add('(AUTOINCREM, AGE_CODEMP, AGE_CODVEN, AGE_CODCLI, AGE_DTAAGE, AGE_DTABAI, AGE_HORBAI, AGE_OBSERV)');
      Add('VALUES');
      Add('(:AUTOIN, :CODEMP, :CODVEN, :CODCLI, :DTAAGE, NULL, NULL, NULL)');

      strAutoIn := fRetAutoIncrem('AGETEL', VS_strCodEmp);

      ParamByName('AUTOIN').AsString   := strAutoIn;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('CODVEN').AsString   := frmAtendimento.strCodVen;
      ParamByName('CODCLI').AsString   := frmAtendimento.cdsConsulta.fieldByName('CLI_CODCLI').AsString;

      If tagTipAge = taAutomatico Then
        ParamByName('DTAAGE').AsDate     := Date + fGetIntervaloAgeCli(ParamByName('CODCLI').AsString)
      Else
        ParamByName('DTAAGE').AsDate     := StrToDate(mskDtaAge.Text);

      ExecSQL;
      {*****************************}
      {* GRAVA DADOS DO CONSUMIDOR *}
      {**************************RV*}
      If (regConsum.strCliNom <> '') Then
      Begin
        Close;
        Clear;

        Add('INSERT INTO CONAGE                                                       ');
        Add('(AUTOINCREM, CON_CODEMP, CON_NOMCON, CON_ENDCON, CON_BAICON, CON_CEPCON, CON_RG_CON, ');
        Add(' CON_CODCID, CON_TELCON, CON_CGCCPF, CON_CGCCON, CON_IESCON, CON_EMLCON, CON_SEQGER, CON_CODREG) ');
        Add('VALUES                                                                   ');
        Add('(:AUTOIN, :CODEMP, :NOMCON, :ENDCON, :BAICON, :CEPCON, :RG_CON,          ');
        Add(' :CODCID, :TELCON, :CGCCPF, :CGCCON, :IESCON, :EMLCON, :SEQGER, :CODREG) ');

        ParamByName('AUTOIN').AsString  := fRetAutoIncrem('CONAGE', VS_strCodEmp);
        ParamByName('SEQGER').AsString  := strAutoIn;
        ParamByName('CODEMP').AsString  := VS_strCodEmp;
        ParamByName('NOMCON').AsString  := regConsum.strCliNom;
        ParamByName('ENDCON').AsString  := regConsum.strCliEnd;
        ParamByName('BAICON').AsString  := regConsum.strCliBai;
        ParamByName('CEPCON').AsString  := regConsum.strCliCep;
        ParamByName('RG_CON').AsString  := regConsum.strCli_Rg;
        ParamByName('CODCID').AsString  := regConsum.strCodCid;
        ParamByName('TELCON').AsString  := regConsum.strCliTel;
        ParamByName('CGCCPF').AsInteger := regConsum.intCgcCpf;
        ParamByName('CGCCON').AsString  := regConsum.strCliCgc;
        ParamByName('IESCON').AsString  := regConsum.strCliIes;
        ParamByName('EMLCON').AsString  := regConsum.strCliEml;
        ParamByName('CODREG').AsString  := regConsum.strCodReg;

        ExecSQL;
      End;
    End;
    Result := True;
  Except
    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmBaixaAgenda.fIncluiAgendamento]');
      Result := False;
    End;
  End;

  FreeAndNil(qryGen);
End;

function TfrmBaixaAgenda.fTemAgendamento: Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;
    With qryGen, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT                    ');
      Add(' COUNT(*) AS QTDAGE       ');
      Add('FROM                      ');
      Add(' AGETEL                   ');

      If (regConsum.strCliNom <> '') Then
        Add(' LEFT JOIN CONAGE ON AGETEL.AUTOINCREM = CON_SEQGER ');

      Add('WHERE                     ');
      Add(' AGE_CODEMP = :CODEMP AND ');
      Add(' AGE_CODVEN = :CODVEN AND ');
      Add(' AGE_CODCLI = :CODCLI AND ');

      If (regConsum.strCliNom <> '') Then
        Add(' CON_NOMCON = :NOMCON AND ');

      Add(' AGE_DTAAGE = :DTAAGE AND ');
      Add(' AGE_DTABAI IS NULL       ');

      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('CODVEN').AsString   := frmAtendimento.strCodVen;
      ParamByName('CODCLI').AsString   := frmAtendimento.cdsConsulta.fieldByName('CLI_CODCLI').AsString;

      If (regConsum.strCliNom <> '') Then
        ParamByName('NOMCON').AsString := regConsum.strCliNom;

      ParamByName('DTAAGE').AsDate     := StrToDate(mskDtaAge.Text);

      Open;

      Result := FieldByName('QTDAGE').AsInteger > 0;

      Close;
    End;
  Except
    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmBaixaAgenda.fTemAgendamento]');
      Result := FALSE;
    End;
  End;

  FreeAndNil(qryGen);
End;

procedure TfrmBaixaAgenda.dbeCodTpaKeyPress(Sender: TObject; var Key: Char);
  Var
    arrTpaAte: TConsultasArray;
begin
  inherited;
  {****************************************}
  {* NOVA CONSULTA DE TIPO DE ATENDIMENTO *}
  {*************************************MM*}
  If fPesqTipoAtendimento(Self, dbeCodTpa, edtDesTpa, Nil, Key, arrTpaAte) Then
  Begin
    if fValidaCampos(dbeCodTpa, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmBaixaAgenda.fBaixaAgendamento(blnReagendar : Boolean): Boolean;
Begin
  Try
    {******************************************}
    {* CASO O OPERADOR ESQUEÇA DE PREENCHER A *}
    {* PESQUISA                               *}
    {****************************************VA}
    If (not blnHisAte) then
    Begin

      {******************************************}
      {* GRAVA PESQUISA DE MERCADO CASO TENHA   *}
      {* SIDO RESPONDIDA                        *}
      {****************************************VA}
      If not cdsRespPesq.IsEmpty Then
        fGravaAgePes(cdsRespPesq);

      If not (qryAgeTel.State in [dsEdit, dsInsert]) Then
        qryAgeTel.Edit;

      qryAgeTel.fieldByName('AGE_DTABAI').AsDateTime := VS_Date;
      qryAgeTel.fieldByName('AGE_HORBAI').AsDateTime := fTime();

      If (blnReagendar) Then
        qryAgeTel.FieldByName('AGE_REAGEN').AsString := 'S'
      Else
        qryAgeTel.FieldByName('AGE_REAGEN').AsString := 'N';
    End;

    qryAgeTel.Post;
    Result := TRUE;

  Except
    On E : Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmBaixaAgenda.fBaixaAgendamento]');
      Result := False;
    End;
  End;
End;

procedure TfrmBaixaAgenda.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbmObsBai);
end;

procedure TfrmBaixaAgenda.FormClose(Sender: TObject;
  var Action: TCloseAction);
  Var
    blnIncluirAge: boolean;
    blnComitar   : boolean;
begin
  inherited;
  blnIncluirAge := tagTipAge = taAutomatico;

  If ModalResult = mrOk Then
  Begin
    If fVerificaCampos Then
    Begin

      If pnlReagendar.Visible And chkReagendar.Checked Then
      Begin
        If fTemAgendamento Then
        Begin

          If fMensagem('', 'Já existe um agendamento para esse cliente nessa data. Deseja mesmo assim reagendar?', ['&Sim', '&Não']) = 1 Then
          Begin
            blnIncluirAge := TRUE;
          End Else
          Begin

            Action := caNone;
            Exit;
          End;

        End

        Else blnIncluirAge := TRUE;
      End;

      Try

        pnlInfo.Caption := 'Gravando registro! Aguarde....';

        blnComitar := TRUE;

        If blnPesMer Then
        Begin
          If cdsRespPesq.IsEmpty and fPergunta('Realizar Pesquisa de Mercado?') Then
          Begin
            btnPesqMerc.Click;
            btnGravar.Click;
          End;
        End;

        fStartTransaction;

        If blnIncluirAge Then
          blnComitar := blnComitar And fIncluiAgendamento;

        blnComitar := blnComitar And fBaixaAgendamento(blnIncluirAge);

        If blnComitar Then
        Begin
          fCommit;
          If tagTipAge = taAutomatico Then
            fMensagem('', 'Registro baixado e reagendado com sucesso!', ['&OK']);
        End
        Else
          fRollBack;

      Except
        On E : Exception Do
        Begin
					pMensagensErro(E.Message,'[TfrmBaixaAgenda.FormClose]');
          fRollBack;
        End;
      End;

    End
    Else
    Begin

     Action := caNone;
    End;
  End
  Else
  Begin
    If ((not cdsRespPesq.IsEmpty) or (Trim(dbmObsBai.Text) <> '')) and
       (fMensagem('', 'Você preencheu observações sobre a baixa e/ou pesquisa de mercado mas, não confirmou! '+
                      'Deseja descartar todas as informações ?', ['&Não', '&Sim']) = 1) Then
    Begin
      Action := caNone;
    End
    Else
    Begin
      qryAgeTel.Cancel;
    End;
  End;
end;

procedure TfrmBaixaAgenda.FormCreate(Sender: TObject);
begin
  inherited;
  blnPesMer           := fCfgSis('PESQME',varBoolean);
  cdsRespPesq         := TUniClientDataSet.Create(Nil);
  btnPesqMerc.Enabled := blnPesMer;
  blnHisAte           := False;
end;

procedure TfrmBaixaAgenda.FormDestroy(Sender: TObject);
begin
  If Assigned(cdsRespPesq) Then
    FreeAndNil(cdsRespPesq);
end;

procedure TfrmBaixaAgenda.btnGravarClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(dbmObsBai, True) Then
  Begin
    ModalResult := mrNone;
    Exit;
  End;

  inherited;
end;

procedure TfrmBaixaAgenda.btnPesqMercClick(Sender: TObject);
begin
  If blnPesMer Then
  Begin
    Try
      pCriarFormularios(TfrmPreenchePesquisa, frmPreenchePesquisa);
      Try
        frmPreenchePesquisa.strCodAge := qryAgeTel.FieldByName('AUTOINCREM').AsString;
        frmPreenchePesquisa.ShowModal;

        if frmPreenchePesquisa.cdsResp <> nil then
          cdsRespPesq.Data := frmPreenchePesquisa.cdsResp.Data;

        btnPesqMerc.Enabled := cdsRespPesq.IsEmpty;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
    Finally
      pFreeAndNil(frmPreenchePesquisa);
    End;
  End;
end;

procedure TfrmBaixaAgenda.chkReagendarClick(Sender: TObject);
begin
  inherited;

  mskDtaAge.Enabled := chkReagendar.Checked;

  if Not mskDtaAge.Enabled Then
    mskDtaAge.Clear;
end;

function TfrmBaixaAgenda.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaAge) And mskDtaAge.Enabled Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaAge.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data de agendamento deve ser preenchida!', ['&O k']);
        Result := False;
      End

      Else If StrToDate(mskDtaAge.Text) < VS_Date Then
      Begin
        fMensagem('ATENÇÃO!', 'A data de agendamento deve ser maior ou igual a data atual!', ['&O k']);
        Result := False;
      End

    End;

    If (Sender = dbeCodTpa) And dbeCodTpa.Visible Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(dbeCodTpa.Text)) Then
      Begin
        edtDesTpa.Text := fRetNomTipoAtend(dbeCodTpa.Text);
        If fEmptyStr(edtDesTpa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este tipo de atendimento não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O tipo de atendimento deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End;

    If (Sender = dbmObsBai) Then
    Begin
      If (fCfgSis('OBPROB', varBoolean)) And (chkReagendar.Checked) And (fEmptyStr(dbmObsBai.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Observações da Baixa" deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaAgenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: Close;
    VK_F12   : btnPesqMerc.Click;
  End;
end;

function TfrmBaixaAgenda.fPesquisaRealizada: Boolean;
var
  QryTemp: TUniQuery;
const
  sPESQUISA_ATIVA_SIM = 'S';
begin
  QryTemp := fCriaQuery;
  Try
    QryTemp.Close;
    QryTemp.SQL.Text :=
      'SELECT 1' + sLineBreak +
      '  FROM AGEPES' + sLineBreak +
      '  JOIN AGETEL' + sLineBreak +
      '    ON AGETEL.AUTOINCREM = AGEPES.AGE_CODAGE' + sLineBreak +
      '  JOIN CADPES' + sLineBreak +
      '    ON CADPES.PES_CODPES = AGEPES.AGE_CODPES' + sLineBreak +
      ' WHERE CADPES.PES_ATIVO_ = :ATIVO' + sLineBreak +
      '   AND AGETEL.AGE_CODCLI = :CODCLI';

    QryTemp.ParamByName('ATIVO').AsString := sPESQUISA_ATIVA_SIM;
    QryTemp.ParamByName('CODCLI').AsString := frmAtendimento.cdsConsulta.fieldByName('CLI_CODCLI').AsString;
    QryTemp.Open;
    result := Not QryTemp.IsEmpty;
    QryTemp.Close;
  Finally
    if Assigned(QryTemp) then
      FreeAndNil(QryTemp);
  End;
end;

end.

