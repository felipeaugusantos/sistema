unit untCadMetasFaturamentoServicoPorFaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, Data.DB,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.Buttons, BitBtnLockedIncrem, cxProgressBar;

type
  TfrmCadMetasFaturamentoServicoPorFaixa = class(TfrmPaiOrdena)
    pnlMesAnoOrigem: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    mskDtaOrigem: TMaskEditFocus;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    Label3: TLabel;
    mskDtaAtual: TMaskEditFocus;
    Label2: TLabel;
    cdsConsultaMSF_CODOPE: TStringField;
    cdsConsultaOPE_NOMOPE: TStringField;
    cdsConsultaOPE_FUNCAO: TStringField;
    cdsConsultaMSF_VLRSER: TFloatField;
    cdsConsultaMSF_VLRADI: TFloatField;
    cdsConsultaMSF_VLRSPM: TFloatField;
    cdsConsultaMSF_PERSPM: TFloatField;
    cdsConsultaAUTOINCREM: TStringField;
    cdsConsultaMSF_CODEMP: TStringField;
    cdsConsultaMSF_MESANO: TStringField;
    btnConfirmar: TBitBtnLocked;
    btnCopiarMetas: TBitBtnLocked;
    pnlDadosAdicionais: TPanel;
    Label4: TLabel;
    edtValorPagamentoAdicional: TEditFocus;
    Label5: TLabel;
    edtValorAdicionalGerenteSubGerente: TEditFocus;
    cdsConsultaMSF_VLRMIN: TFloatField;
    cdsConsultaMSF_VLRMGS: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCopiarMetasClick(Sender: TObject);
    procedure mskDtaAtualKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure pnlTailEnter(Sender: TObject);
    procedure pnlTailExit(Sender: TObject);
  private
    { Private declarations }
    FMesAno  : String;
    FMesAnoOri: String;
    function  fIncluiRegistros(pgbProgresso: TcxProgressBar = Nil): Boolean;
    procedure pStepStatusGravacao(pgbProgresso: TcxProgressBar);
    procedure pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);
    function  fGravaMeta(pgbProgresso: TcxProgressBar = Nil): Boolean;
    procedure pAbreConsulta;
    Function  fCopiaMeta: Boolean;
    procedure pCopiaMeta;
    function  fValidaEdicao(Sender: TObject): Boolean;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadMetasFaturamentoServicoPorFaixa: TfrmCadMetasFaturamentoServicoPorFaixa;

implementation

uses untFuncoesSimples, untGravando, untTypesSistema, untFuncoesConsulta, StrUtils,
     untConsultas;

{$R *.dfm}

{ TfrmCadMetasFaturamentoServicoPorFaixa }

procedure TfrmCadMetasFaturamentoServicoPorFaixa.btnConfirmarClick(Sender: TObject);
begin
  inherited;

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

procedure TfrmCadMetasFaturamentoServicoPorFaixa.btnCopiarMetasClick(Sender: TObject);
begin
  inherited;

  If (Not fValidaEdicao(Sender)) Then
    Exit;

  If pnlMesAnoOrigem.Visible Then
  Begin
    pnlMesAnoOrigem.Visible := False;
    mskDtaOrigem.Clear;
  End Else
  Begin
    pnlMesAnoOrigem.Visible := True;
    blnMudarFoco := True;
    pSetFocus(mskDtaOrigem);
  End;
end;

procedure TfrmCadMetasFaturamentoServicoPorFaixa.dbgConsultaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TfrmCadMetasFaturamentoServicoPorFaixa.edtCodEmpExit(Sender: TObject);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');

  If Not cdsConsulta.IsEmpty Then
  Begin

    If (Not fEmptyStr(edtCodEmp.Text)) Then
      If (fRetEmpresaOperador(cdsConsulta.FieldByName('MSF_CODOPE').AsString)) <> edtCodEmp.Text Then
        If fMensagem('','A empresa foi alterada, deseja recarregar as metas?', ['&Sim','&Não']) = 1 Then
          fValidaCampos(edtCodEmp, True);
  End;
end;

procedure TfrmCadMetasFaturamentoServicoPorFaixa.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
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

function TfrmCadMetasFaturamentoServicoPorFaixa.fCopiaMeta: Boolean;
  Var
    LqryCadMet: TUniQuery;
begin
  Result := False;

  LqryCadMet := fCriaQuery;
  Try
    Try
      cdsConsulta.DisableControls;

      LqryCadMet.Sql.Text := ' SELECT * FROM CADMSF '+
                             '  LEFT JOIN CADOPE O ON O.OPE_CODOPE = MSF_CODOPE '+
                             ' WHERE MSF_MESANO = :MESANO AND ';

      If Not fEmptyStr(edtCodEmp.Text) Then
        LqryCadMet.Sql.Add('  O.OPE_CODEMP = :CODEMP')
      Else
        LqryCadMet.Sql.Add('  LOCATE(O.OPE_CODEMP, :CODEMP) > 0');

      LqryCadMet.ParamByName('MESANO').AsString := FMesAnoOri;

      If Not fEmptyStr(edtCodEmp.Text) Then
        LqryCadMet.ParamByName('CODEMP').AsString := edtCodEmp.Text
      Else
        LqryCadMet.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;

      LqryCadMet.Open;

      if not LqryCadMet.IsEmpty  then
      begin
        While Not LqryCadMet.Eof Do
        Begin
          If cdsConsulta.Locate('MSF_CODOPE', LqryCadMet.FieldByName('MSF_CODOPE').AsString, []) Then
          Begin
            cdsConsulta.Edit;
            cdsConsulta.FieldByName('MSF_VLRSER').AsFloat := LqryCadMet.FieldByName('MSF_VLRSER').AsFloat;
            cdsConsulta.FieldByName('MSF_VLRADI').AsFloat := LqryCadMet.FieldByName('MSF_VLRADI').AsFloat;
            cdsConsulta.FieldByName('MSF_VLRSPM').AsFloat := LqryCadMet.FieldByName('MSF_VLRSPM').AsFloat;
            cdsConsulta.FieldByName('MSF_PERSPM').AsFloat := LqryCadMet.FieldByName('MSF_PERSPM').AsFloat;
            cdsConsulta.Post;

            Result := True;
          End;

          LqryCadMet.Next;
        End;

        edtValorPagamentoAdicional.Text         := FloatToStr(LqryCadMet.FieldByName('MSF_VLRMIN').AsFloat);
        edtValorAdicionalGerenteSubGerente.Text := FloatToStr(LqryCadMet.FieldByName('MSF_VLRMGS').AsFloat);
      end;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[fCopiaMeta]');
      End;
    End;

  Finally
    FreeAndNil(LqryCadMet);
  End;

  cdsConsulta.First;
  cdsConsulta.EnableControls;
end;

function TfrmCadMetasFaturamentoServicoPorFaixa.fGetSql(blnLike: Boolean): String;
begin
  Result :=
  'SELECT M.AUTOINCREM, '+
  '       M.MSF_CODOPE, '+
  '       M.MSF_VLRSER, '+
  '       M.MSF_VLRADI, '+
  '       M.MSF_VLRSPM, '+
  '       M.MSF_PERSPM, '+
  '       M.MSF_CODEMP, '+
  '       M.MSF_MESANO, '+
  '       M.MSF_VLRMIN, '+
  '       M.MSF_VLRMGS, '+
  '       CASE '+
  '        WHEN IFNULL(O.OPE_INTEXT, "") = "G" THEN "GERENTE" '+
  '        WHEN IFNULL(O.OPE_INTEXT, "") = "S" THEN "SUB-GERENTE" '+
  '        WHEN IFNULL(O.OPE_INTEXT, "") = "M" THEN "MECANICO" '+
  '        ELSE "VENDEDOR" '+
  '       END AS OPE_FUNCAO, '+
  '       O.OPE_NOMOPE '+
  '  FROM CADMSF M '+
  '  LEFT JOIN CADOPE O ON O.OPE_CODOPE = M.MSF_CODOPE '+
  'WHERE M.MSF_MESANO = :MESANO        AND '+
  '      O.OPE_STATUS = "A"            AND '+
  '      O.OPE_INTEXT IN ("I","E","D","G","S","M") AND ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    Result := Result + '  O.OPE_CODEMP = :CODEMP '
  Else
    Result := Result + '  LOCATE(O.OPE_CODEMP, :CODEMP) > 0 ';

  Result := Result + ' GROUP BY M.MSF_MESANO, M.MSF_CODOPE ';
end;

function TfrmCadMetasFaturamentoServicoPorFaixa.fGravaMeta(pgbProgresso: TcxProgressBar): Boolean;
  Var
    bkmMarca: TBookmark;
    LqryUpdate: TUniQuery;
begin
  Result := True;

  LqryUpdate := fCriaQuery(Self);
  Try
    fStartTransaction;

    bkmMarca := cdsConsulta.GetBookmark;
    cdsConsulta.DisableControls;

    Try
      pInfoStatusGravacao('Aguarde... Gravando Metas', pgbProgresso);

      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := cdsConsulta.RecordCount + 1;

      LqryUpdate.Sql.Text := ' UPDATE CADMSF '+
                             '   SET MSF_VLRSER  = :VLRSER, '+
                             '       MSF_VLRADI  = :VLRADI, '+
                             '       MSF_VLRSPM  = :VLRSPM, '+
                             '       MSF_PERSPM  = :PERSPM, '+
                             '       MSF_VLRMIN  = :VLRMIN, '+
                             '       MSF_VLRMGS  = :VLRMGS  '+
                             ' WHERE  AUTOINCREM = :AUTINC ';
      cdsConsulta.First;
      While Not cdsConsulta.Eof Do
      Begin
        LqryUpdate.ParamByName('VLRSER').AsFloat  := cdsConsulta.FieldByName('MSF_VLRSER').AsFloat;
        LqryUpdate.ParamByName('VLRADI').AsFloat  := cdsConsulta.FieldByName('MSF_VLRADI').AsFloat;
        LqryUpdate.ParamByName('VLRSPM').AsFloat  := cdsConsulta.FieldByName('MSF_VLRSPM').AsFloat;
        LqryUpdate.ParamByName('PERSPM').AsFloat  := cdsConsulta.FieldByName('MSF_PERSPM').AsFloat;
        LqryUpdate.ParamByName('VLRMIN').AsFloat  := fStrToFloat(edtValorPagamentoAdicional.Text);
        LqryUpdate.ParamByName('VLRMGS').AsFloat  := fStrToFloat(edtValorAdicionalGerenteSubGerente.Text);
        LqryUpdate.ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
        LqryUpdate.ExecSQL;

        pStepStatusGravacao(pgbProgresso);

        cdsConsulta.Next;
      End;

      fCommit;

      cdsConsulta.GotoBookmark(bkmMarca);
      cdsConsulta.FreeBookmark(bkmMarca);
      cdsConsulta.EnableControls;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, '[pGravarMetas]');
      End;
    End;

    pStepStatusGravacao(pgbProgresso);

  Finally
    freeAndNil(LqryUpdate);
  End;
end;

function TfrmCadMetasFaturamentoServicoPorFaixa.fIncluiRegistros(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LqryCadMet: TUniQuery;
    LqryCadIns: TUniQuery;
Begin
  LqryCadIns := fCriaQuery;
  LqryCadMet := fCriaQuery;

  Try
    LqryCadIns.Sql.Add(' INSERT INTO CADMSF '+
                       '  (AUTOINCREM, MSF_CODOPE, MSF_VLRSER, MSF_VLRADI, MSF_VLRSPM, MSF_PERSPM, MSF_CODEMP, MSF_MESANO, MSF_VLRMIN, MSF_VLRMGS) '+
                       ' VALUES '+
                       '  (:AUTOIN, :CODOPE, 0, 0, 0, 0, :CODEMP, :MESANO, 0, 0) ');

    LqryCadMet.Sql.Add(' SELECT OPE_CODOPE FROM CADOPE '+
                       ' LEFT JOIN CADMSF ON OPE_CODOPE = MSF_CODOPE '+
                       '                 AND MSF_MESANO = :MESANO '+
                       ' WHERE MSF_CODOPE IS NULL AND '+
                       '   OPE_INTEXT IN ("I","E","D","G","S","M") ');
    LqryCadMet.ParamByName('MESANO').AsString := FMesAno;
    LqryCadMet.Open;
    LqryCadMet.First;

    Result := Not LqryCadMet.IsEmpty;

    If Assigned(pgbProgresso) Then
    Begin
      pInfoStatusGravacao('Aguarde... Carregando Metas', pgbProgresso);
      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := LqryCadMet.RecordCount;

      if Not Result then
        pgbProgresso.Position := 100;
    End;

    While Not LqryCadMet.Eof Do
    Begin
      LqryCadIns.Close;
      LqryCadIns.ParamByName('CODOPE').AsString := LqryCadMet.FieldByName('OPE_CODOPE').AsString;
      LqryCadIns.ParamByName('MESANO').AsString := FMesAno;
      LqryCadIns.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LqryCadIns.ParamByName('AUTOIN').AsString := fRetAutoIncrem('CADMSF', VS_strCodEmp);
      LqryCadIns.ExecSQL;

      pStepStatusGravacao(pgbProgresso);

      LqryCadMet.Next;
    End;

    LqryCadMet.Close;
  Finally
    FreeAndNil(LqryCadMet);
    FreeAndNil(LqryCadIns);
  End;
end;

procedure TfrmCadMetasFaturamentoServicoPorFaixa.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaAtual);
end;

procedure TfrmCadMetasFaturamentoServicoPorFaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If cdsConsulta.Active Then
    cdsConsulta.CancelUpdates;

  If pnlMesAnoOrigem.Visible Then
  Begin
    pnlMesAnoOrigem.Visible := False;
    Action := caNone;
    pAbreConsulta;
  End;
end;

procedure TfrmCadMetasFaturamentoServicoPorFaixa.FormCreate(Sender: TObject);
begin
  inherited;
  mskDtaAtual.Text := FormatDateTime('mm/yyyy', VS_Date);
  FMesAno          := AnsiReplaceStr(mskDtaAtual.Text, '/', '');
end;

procedure TfrmCadMetasFaturamentoServicoPorFaixa.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) Then
    btnConfirmar.Click

  ELse If (Key = VK_F11) Then
    btnCopiarMetas.Click;
end;

procedure TfrmCadMetasFaturamentoServicoPorFaixa.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Key = '-' Then
    Key := #0;
end;

procedure TfrmCadMetasFaturamentoServicoPorFaixa.FormShow(Sender: TObject);
  var
    LqryEmpOpe: TUniQuery;
begin
  inherited;

  blnSempreRelerBanco := False;
  blnTemSelecao       := False;
  pnlTail.Visible     := False;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  pAbreConsulta;

  LqryEmpOpe := fCriaQuery;
  try
    with LqryEmpOpe do
    begin
      Close;
      SQL.Add('SELECT OPE_CODEMP FROM CADOPE WHERE OPE_CODOPE = :CODOPE');
      ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      Open;
      if not IsEmpty then
      begin
        edtCodEmp.Text := FieldByName('OPE_CODEMP').AsString;
        fValidaCampos(edtCodEmp);
      end;
    end;
  finally
    FreeAndNil(LqryEmpOpe);
  end;
end;

function TfrmCadMetasFaturamentoServicoPorFaixa.fSetParametros: Boolean;
begin
  Result := True;
  qryConsulta.ParamByName('MESANO').AsString := FMesAno;

  If Not fEmptyStr(edtCodEmp.Text) Then
    qryConsulta.ParamByName('CODEMP').AsString := edtCodEmp.Text
  Else
    qryConsulta.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;
end;

function TfrmCadMetasFaturamentoServicoPorFaixa.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
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
      End Else
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

          If Not SameText(fTiraCaracEspeciais(mskDtaAtual.Text), FMesAno) Then
          Begin
            FMesAno := fTiraCaracEspeciais(mskDtaAtual.Text);
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

function TfrmCadMetasFaturamentoServicoPorFaixa.fValidaEdicao(Sender: TObject): Boolean;
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


procedure TfrmCadMetasFaturamentoServicoPorFaixa.mskDtaAtualKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Key = Char(VK_RETURN) Then
    pSetFocus(edtCodEmp);
end;

procedure TfrmCadMetasFaturamentoServicoPorFaixa.pAbreConsulta;
begin
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

  if fAbreConsulta then
  begin
    edtValorPagamentoAdicional.Text         := FloatToStr(cdsConsulta.FieldByName('MSF_VLRMIN').AsFloat);
    edtValorAdicionalGerenteSubGerente.Text := FloatToStr(cdsConsulta.FieldByName('MSF_VLRMGS').AsFloat);
    cdsConsulta.FieldByName('MSF_VLRSER').FocusControl;
  end;
end;

procedure TfrmCadMetasFaturamentoServicoPorFaixa.pCopiaMeta;
  Var
    strAno: String;
    strMes: String;
begin
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

    FMesAnoOri := AnsiReplaceStr(mskDtaOrigem.Text, '/', '');

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

procedure TfrmCadMetasFaturamentoServicoPorFaixa.pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCadMetasFaturamentoServicoPorFaixa.pnlTailEnter(Sender: TObject);
begin
  inherited;
  blnMudarFoco := False;
end;

procedure TfrmCadMetasFaturamentoServicoPorFaixa.pnlTailExit(Sender: TObject);
begin
  inherited;
  blnMudarFoco := True;
end;

procedure TfrmCadMetasFaturamentoServicoPorFaixa.pStepStatusGravacao(pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) Then
  Begin
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;
end;

end.
