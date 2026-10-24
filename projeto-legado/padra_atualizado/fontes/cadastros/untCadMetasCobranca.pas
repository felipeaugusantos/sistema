unit untCadMetasCobranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, Data.DB,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.Buttons, BitBtnLockedIncrem, cxProgressBar;

type
  TfrmCadMetasCobranca = class(TfrmPaiOrdena)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    shpCodEmp: TShape;
    edtNomEmp: TEditFocus;
    pnlMesAnoOrigem: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    mskDtaOrigem: TMaskEditFocus;
    mskDtaAtual: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    cdsConsultaMET_CODOPE: TStringField;
    cdsConsultaOPE_NOMOPE: TStringField;
    cdsConsultaMET_METREC: TFloatField;
    cdsConsultaMET_COMSIM: TFloatField;
    cdsConsultaMET_COMNAO: TFloatField;
    Panel2: TPanel;
    cdsConsultaAUTOINCREM: TStringField;
    btnConfirmar: TBitBtnLocked;
    btnCopiarMetas: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNomEmpKeyPress(Sender: TObject; var Key: Char);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnCopiarMetasClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    strMesAnoOri: String;
    strMesAno   : String;
    blnEstavaFiltrado: Boolean;

    function fCopiaMeta: Boolean;
    function fCopiaMetaMetCob: Boolean;
    function fVerificaOperadorLogado(strCodOpe: String): String;
    function fIncluiRegistros(pgbProgresso: TcxProgressBar = Nil): Boolean;
    function fGetSqlCadMetCob: String;
    function fValidaEdicao(Sender: TObject): Boolean;
    function fGravaMeta(pgbProgresso: TcxProgressBar = Nil): Boolean;

    procedure pCopiaMeta;
    procedure pAbreConsulta;
    procedure pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);
    procedure pStepStatusGravacao(pgbProgresso: TcxProgressBar);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
  end;


implementation

uses StrUtils,untPai, untConsultas, untTypesSistema,untFuncoesSimples, untFuncoesConsulta, untGravando;

{$R *.dfm}

{ TfrmCadMetasCobranca }

procedure TfrmCadMetasCobranca.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(fTiraCaracEspeciais(mskDtaAtual.Text)) Then
  Begin
    fMensagem('', 'Informar o mês / ano atual !', ['&O k']);
    pSetFocus(mskDtaAtual);
    Exit;
  End
  Else
  Begin
    Try
      mskDtaAtual.Text := fTrataAnoDataMesAno(mskDtaAtual.Text);
      strToDate('01/' + mskDtaAtual.Text);
      SameText(fTiraCaracEspeciais(mskDtaAtual.Text), strMesAno);
    Except
      fMensagem('', 'Mês / Ano inválido !', ['&O k']);
      pSetFocus(mskDtaAtual);
      Exit;
    End;
  End;


  If Not fEmptyStr(edtCodEmp.Text) And (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
    pSetFocus(edtCodEmp);
    Exit;
  End;

  If (Not fValidaEdicao(Sender)) Then
    Exit;

  If fMensagem('','Confirma a gravação das metas?',['&Sim','&Não']) = 2 Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravaMeta;
    frmGravando.ShowModal;
    pFreeAndNil(frmGravando);
  Except
    On E: Exception Do
    Begin
      pFreeAndNil(frmGravando);
      pMensagensErro(E.Message, '');
    End;
  End;

  pnlMesAnoOrigem.Visible := False;
end;

procedure TfrmCadMetasCobranca.btnCopiarMetasClick(Sender: TObject);
begin
  inherited;
  If (Not fValidaEdicao(Sender)) Then
    Exit;

  If pnlMesAnoOrigem.Visible Then
  Begin
    pnlMesAnoOrigem.Visible := False;
    mskDtaOrigem.Clear;
  End
  Else
  Begin
    pnlMesAnoOrigem.Visible := True;
    blnMudarFoco := True;
    pSetFocus(mskDtaOrigem);
  End;
end;

procedure TfrmCadMetasCobranca.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key In [VK_Return, VK_TAB]) And
     (dbgConsulta.DataSource.DataSet <> Nil) And
     (dbgConsulta.DataSource.DataSet.Active) And
     (dbgConsulta.DataSource.DataSet.RecNo = dbgConsulta.DataSource.DataSet.RecordCount) And
     (dbgConsulta.SelectedField <> Nil) And
     (dbgConsulta.DataSource.DataSet.FindField(dbgConsulta.Columns.Items[dbgConsulta.Columns.Count - 1].FieldName) <> Nil) And
     (dbgConsulta.SelectedField = dbgConsulta.DataSource.DataSet.FieldByName(dbgConsulta.Columns.Items[dbgConsulta.Columns.Count - 1].FieldName)) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMetasCobranca.edtCodEmpExit(Sender: TObject);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmCadMetasCobranca.edtNomEmpKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, True, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadMetasCobranca.fCopiaMeta: Boolean;
begin
  cdsConsulta.DisableControls;
  Try
    Result := fCopiaMetaMetCob;
  Except
  On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[fCopiaMeta]');
    End;
  End;
  cdsConsulta.First;
  cdsConsulta.EnableControls;
end;

function TfrmCadMetasCobranca.fCopiaMetaMetCob: Boolean;
Var
  qryMetCob: TUniQuery;
     strSql: String;
begin
  Try
    Result := False;
    qryMetCob := fCriaQuery;

    strSql := 'SELECT *  ';
    strSql := strSql + 'FROM METCOB  ';
    strSql := strSql + 'LEFT JOIN CADOPE O   ';
    strSql := strSql + 'ON O.OPE_CODOPE = MET_CODOPE  ';
    strSql := strSql + 'WHERE  ';
    strSql := strSql + 'MET_MESANO = :MESANO  ';
    If Not fEmptyStr(edtCodEmp.Text) Then
      strSql := strSql +'AND  O.OPE_CODEMP = :CODEMP'
    Else
      strSql := strSql +'AND LOCATE(O.OPE_CODEMP, :CODEMP) > 0';


    With qryMetCob Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSql);
      ParamByName('MESANO').AsString := strMesAnoOri;
      If Not fEmptyStr(edtCodEmp.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmp.Text
      Else
        ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;
      Open;

      While Not Eof Do
      Begin
        If cdsConsulta.Locate('MET_CODOPE', FieldByName('MET_CODOPE').AsString, []) Then
        Begin
          cdsConsulta.Edit;
          cdsConsulta.FieldByName('MET_METREC').AsFloat := FieldByName('MET_METREC').AsFloat;
          cdsConsulta.FieldByName('MET_COMSIM').AsFloat := FieldByName('MET_COMSIM').AsFloat;
          cdsConsulta.FieldByName('MET_COMNAO').AsFloat := FieldByName('MET_COMNAO').AsFloat;
          cdsConsulta.Post;
          Result := True;
        End;
        Next;
      End;
    End;
  Finally
    FreeAndNil(qryMetCob);
  end;
end;

function TfrmCadMetasCobranca.fGetSql(blnLike: Boolean): String;
Var
  strSql : String;
begin
  strSql := '';
  strSql := strSql + 'SELECT *  ';
  strSql := strSql + 'FROM METCOB  ';
  strSql := strSql + 'LEFT JOIN CADOPE ';
  strSql := strSql + 'ON OPE_CODOPE = MET_CODOPE  ';
  strSql := strSql + 'WHERE  ';
  strSql := strSql + 'MET_MESANO = :MESANO  ';
  strSql := strSql + 'AND OPE_STATUS = "A" ';
  If Not fEmptyStr(edtCodEmp.Text) Then
    strSql := strSql +'AND OPE_CODEMP = :CODEMP  '
  Else
   strSql := strSql + 'AND  LOCATE(OPE_CODEMP, :CODEMP) > 0  ';

  Result := strSql;
end;

function TfrmCadMetasCobranca.fGetSqlCadMetCob: String;
Var
  strSql : String;
begin
  strSql := '';
  strSql := strSql + 'INSERT INTO METCOB  ';
  strSql := strSql + '(AUTOINCREM,  ';
  strSql := strSql + ' MET_CODOPE,  ';
  strSql := strSql + ' MET_CODEMP,  ';
  strSql := strSql + ' MET_METREC,  ';
  strSql := strSql + ' MET_COMSIM,  ';
  strSql := strSql + ' MET_COMNAO,  ';
  strSql := strSql + ' MET_MESANO)  ';
  strSql := strSql + ' VALUES(  ';
  strSql := strSql + ' :AUTOIN, ';
  strSql := strSql + ' :CODOPE, ';
  strSql := strSql + ' :CODEMP, ';
  strSql := strSql + ' 0, ';
  strSql := strSql + ' 0, ';
  strSql := strSql + ' 0, ';
  strSql := strSql + ' :MESANO) ';
  Result := strSql;
end;

function TfrmCadMetasCobranca.fIncluiRegistros(pgbProgresso: TcxProgressBar): Boolean;
Var
  qryCadOpe,
  qryMetCob:TUniQuery;
  strSql   :String;
begin
  qryMetCob := fCriaQuery;
  qryCadOpe := fCriaQuery;
  Try
    With qryMetCob Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSqlCadMetCob);
    End;

    strSql := '';
    strSql := strSql + 'SELECT  ';
    strSql := strSql + 'OPE_CODOPE  ';
    strSql := strSql + 'FROM  ';
    strSql := strSql + 'CADOPE  ';
    strSql := strSql + 'LEFT JOIN METCOB  ';
    strSql := strSql + 'ON OPE_CODOPE = MET_CODOPE  ';
    strSql := strSql + 'AND MET_MESANO = :MESANO    ';
    strSql := strSql + 'WHERE  ';
    strSql := strSql + 'MET_CODOPE IS NULL   ';
    If Not fEmptyStr(edtCodEmp.Text) Then
      strSql := strSql + 'AND OPE_CODEMP = :CODEMP   ';

    With qryCadOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSql);
      ParamByName('MESANO').AsString := strMesAno;
      If Not fEmptyStr(edtCodEmp.Text) Then
        ParamByName('CODEMP').AsString := edtCodEmp.Text;
      Open;
      First;
      Result := Not IsEmpty;

      If Assigned(pgbProgresso) Then
      Begin
        pInfoStatusGravacao('Aguarde... Carregando Metas', pgbProgresso);
        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := RecordCount;

        if Not Result then
          pgbProgresso.Position := 100;
      End;

      While Not Eof Do
      Begin
        qryMetCob.Close;
        qryMetCob.ParamByName('AUTOIN').AsString := fRetAutoIncrem('METCOB', VS_strCodEmp);
        qryMetCob.ParamByName('CODOPE').AsString := FieldByName('OPE_CODOPE').AsString;
        qryMetCob.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryMetCob.ParamByName('MESANO').AsString := strMesAno;
        qryMetCob.ExecSQL;
        pStepStatusGravacao(pgbProgresso);
        Next;
      End;
      Close;
    End;
  Finally
    Begin
      pFreeAndNil(qryMetCob);
      pFreeAndNil(qryCadOpe);
    End;
  End;
end;

procedure TfrmCadMetasCobranca.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaAtual);
end;

procedure TfrmCadMetasCobranca.FormCreate(Sender: TObject);
begin
  inherited;
  mskDtaAtual.Text := FormatDateTime('mm/yyyy', VS_Date);
  strMesAno        := AnsiReplaceStr(mskDtaAtual.Text, '/', '');
end;

procedure TfrmCadMetasCobranca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
    btnConfirmar.Click

  ELse If (Key = VK_F11) Then
    btnCopiarMetas.Click;
end;

procedure TfrmCadMetasCobranca.FormShow(Sender: TObject);
begin
  inherited;
  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  blnTemSelecao := False;
  If Not fEmptyStr(fVerificaOperadorLogado(strLoginUsuarioLogado))Then
  Begin
   edtCodEmp.Text := fVerificaOperadorLogado(strLoginUsuarioLogado);
   fValidaCampos(edtCodEmp);
  End;
end;

function TfrmCadMetasCobranca.fSetParametros: Boolean;
begin
  Result := True;
  qryConsulta.ParamByName('MESANO').AsString := strMesAno;

  If Not fEmptyStr(edtCodEmp.Text) Then
    qryConsulta.ParamByName('CODEMP').AsString := edtCodEmp.Text
  Else
    qryConsulta.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;
end;

function TfrmCadMetasCobranca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {**************************************}
    {* VALIDA DATA DE ORIGEM              *}
    {***********************************RL*}
    If (Sender = mskDtaOrigem) Then
    Begin
      If pnlMesAnoOrigem.Visible Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaOrigem.Text)) Then
        Begin
          fMensagem('', 'Informar o mês / ano de origem !', ['&O k']);
          Result := False;
        End
        Else
        Begin
          Try
            strToDate('01/' + mskDtaOrigem.Text);
          Except
            fMensagem('', 'Mês / Ano inválido !', ['&O k']);
            Result := False;
          End;
          If Result Then
            pCopiaMeta;
        End;
      End
      Else
      Begin
        mskDtaOrigem.Clear;
      End;
    End
    {**************************************}
    {* VALIDA DATA ATUAL                  *}
    {***********************************RL*}
    Else If (Sender = mskDtaAtual) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaAtual.Text)) Then
      Begin
        fMensagem('', 'Informar o mês / ano atual !', ['&O k']);
        Result := False;
      End
      Else
      Begin
        Try
          mskDtaAtual.Text := fTrataAnoDataMesAno(mskDtaAtual.Text);
          strToDate('01/' + mskDtaAtual.Text);
          If Not SameText(fTiraCaracEspeciais(mskDtaAtual.Text), strMesAno) Then
          Begin
            strMesAno := fTiraCaracEspeciais(mskDtaAtual.Text);
            cdsConsulta.Close;
            pAbreConsulta;
            pSetFocus(mskDtaAtual);
          End;
        Except
          fMensagem('', 'Mês / Ano inválido !', ['&O k']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodEmp) Then
    Begin
      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
        If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
          Result := False;
        End
        Else
        Begin
          cdsConsulta.Close;
          pAbreConsulta;
          pSetFocus(edtCodEmp);
        End;
      End
      Else
      Begin
        cdsConsulta.Close;
        pAbreConsulta;
        pSetFocus(edtCodEmp);
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadMetasCobranca.fVerificaOperadorLogado(
  strCodOpe: String): String;
Var
  qryEmpOpe : TUniQuery;
begin
  Try
    qryEmpOpe := fCriaQuery;
    With qryEmpOpe do
    Begin
      Close;
      SQL.Add('SELECT OPE_CODEMP FROM CADOPE WHERE OPE_CODOPE = :CODOPE');
      ParamByName('CODOPE').AsString := strCodOpe;
      Open;
      If Not IsEmpty Then
      Begin
        Result := FieldByName('OPE_CODEMP').AsString;
      End
      Else
        Result := '';
    end;
  Finally
    FreeAndNil(qryEmpOpe);
  end;
end;



procedure TfrmCadMetasCobranca.pAbreConsulta;
Begin
  If cdsConsulta.Active Then
    cdsConsulta.CancelUpdates;
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fIncluiRegistros;
    frmGravando.ShowModal;
    pFreeAndNil(frmGravando);
  Except
    On E: Exception Do
    Begin
      pFreeAndNil(frmGravando);
      pMensagensErro(E.Message, '');
    End;
  End;
  fAbreConsulta;
End;


procedure TfrmCadMetasCobranca.pCopiaMeta;
  Var
    strAno: String;
    strMes: String;
begin
 {***********************************************
  * COMPLETA O ANO PARA 4 DÍGITOS CASO O USUÁRIO*
  * DIGITE APENAS DOIS DÍGITOS NO ANO. EX:      *
  * SE FOR DIGITADO 07, COMPLETA PARA 2007      *
  ***********************************************}
  If (RightStr(mskDtaOrigem.Text,4) <> '') And (LeftStr(mskDtaOrigem.Text,2) <> '') Then
  Begin
    strMes := Trim(LeftStr(mskDtaOrigem.Text,2));
    strAno := Trim(RightStr(mskDtaOrigem.Text,4));

    If Length(strAno) = 1 Then
      mskDtaOrigem.Text := strMes + '/200' + strAno
    Else If Length(strAno) = 2 Then
      mskDtaOrigem.Text := strMes + '/20' + strAno
    Else If Length(strAno) = 3 Then
      mskDtaOrigem.Text := strMes + '/2' + strAno;

    strMesAnoOri := AnsiReplaceStr(mskDtaOrigem.Text, '/', '');

    If fCopiaMeta Then
    Begin
      pMensagemOK('Metas copiadas com sucesso!');
      mskDtaOrigem.Clear;
      pnlMesAnoOrigem.Visible := False;
    End
    Else
      pMensagemOK('Não há metas cadastradas para o Mês Origem informado!');
  End;

end;

procedure TfrmCadMetasCobranca.pInfoStatusGravacao(strInformacao: String;pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCadMetasCobranca.pStepStatusGravacao(pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) Then
  Begin
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;
end;

function TfrmCadMetasCobranca.fValidaEdicao(Sender: TObject): Boolean;
begin
  Try
    If (cdsConsulta.State = dsEdit) Then
    Begin
      cdsConsulta.Post;
      Result := True;
    End
    Else
      Result := True;
  Except
    Result := False;
  End;
end;

function TfrmCadMetasCobranca.fGravaMeta(pgbProgresso: TcxProgressBar): Boolean;
  Var
    intNroErr: Integer;
    strSql   : String;
    qryCadMet: TUniQuery;
begin
  Try
    intNroErr := 0;
    pInfoStatusGravacao('Aguarde... Gravando Metas', pgbProgresso);
    blnEstavaFiltrado := cdsConsulta.Filtered;
    qryCadMet := fCriaQuery(Self);

    fStartTransaction;

    With cdsConsulta Do
    Begin
      DisableControls;
      Try
        If blnEstavaFiltrado Then
          cdsConsulta.Filtered := False;

        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := RecordCount + 1;

        strSql := '';
        strSql := strSql + 'UPDATE METCOB  ';
        strSql := strSql + 'SET MET_METREC = :METREC,  ';
        strSql := strSql + '    MET_COMSIM = :COMSIM,  ';
        strSql := strSql + '    MET_COMNAO = :COMNAO  ';
        strSql := strSql + ' WHERE ';
        strSql := strSql + '   AUTOINCREM = :AUTINC ';
        First;

        While Not Eof Do
        Begin
          qryCadMet.Close;
          qryCadMet.SQL.Clear;
          qryCadMet.Params.Clear;
          qryCadMet.SQL.Add(strSql);
          qryCadMet.ParamByName('METREC').AsFloat  := FieldByName('MET_METREC').AsFloat;
          qryCadMet.ParamByName('COMSIM').AsFloat  := FieldByName('MET_COMSIM').AsFloat;
          qryCadMet.ParamByName('COMNAO').AsFloat  := FieldByName('MET_COMNAO').AsFloat;
          qryCadMet.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
          qryCadMet.ExecSQL;
          pStepStatusGravacao(pgbProgresso);
          Next;
        End;
        FreeAndNil(qryCadMet);

        If blnEstavaFiltrado Then
          cdsConsulta.Filtered := True;
        EnableControls;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[Inserir Registro]');
          intNroErr := 1;
        End;
      End;
    End;
    If intNroErr = 0 Then
    Begin
      fCommit;
      Result := True;
    End
    Else
    Begin
      fRollBack;
      Result := False;
    End;
    pStepStatusGravacao(pgbProgresso);
  Except
    On E : Exception Do
    Begin
      fRollBack;
       Result := False;
      pMensagensErro(E.Message, '[pGravarMetas]');
    End;
  End;
end;

end.
