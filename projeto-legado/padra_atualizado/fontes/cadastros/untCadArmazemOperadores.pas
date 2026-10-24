unit untCadArmazemOperadores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, untFuncoesSimples,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxButtonEdit, System.Actions, Vcl.ActnList, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView,
  cxGrid, untZClient, untConsultas, untTypesSistema, EditFocus, Uni, cxGridCitel,
  untPai, cxCheckBox, untGravando, cxProgressBar;

type
  TTipoOperacao = (toNavegacao, toInsercao, toAlteracao);
  TfrmCadArmazemOperadores = class(TfrmPai)
    dtsArmazens: TDataSource;
    pnlInformacoes: TPanel;
    gpbInfoAmz: TGroupBox;
    gridArmazensView: TcxGridDBTableView;
    cxGridArmazensLevel1: TcxGridLevel;
    cxGridArmazens: TcxGrid;
    gridArmazensViewCODAMZ: TcxGridDBColumn;
    gpbOperadores: TGroupBox;
    gridArmazensViewDESAMZ: TcxGridDBColumn;
    pnlRodapeOperadores: TPanel;
    cxGridOperadoresAUTOINCREM: TcxGridDBColumn;
    pnlInfoAmz: TPanel;
    lblEmpAmz: TLabel;
    lblAmz: TLabel;
    edtCodAmz: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtDesAmz: TEditFocus;
    pnlOperadores: TPanel;
    pnlBotoesOpe: TPanel;
    lblLegenda: TLabel;
    cxGridOperadores: TcxGrid;
    gridOperadoresView: TcxGridDBTableView;
    gridOperadoresViewCODOPE: TcxGridDBColumn;
    gridOperadoresViewNOMOPE: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    gridOperadoresViewACESSO: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    gridArmazensViewCODEMP: TcxGridDBColumn;
    dtsOperadores: TDataSource;
    btnCancela: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    btnMarTodos: TBitBtnLocked;
    btnDesmarTodos: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gridArmazensViewDblClick(Sender: TObject);
    procedure edtCodAmzKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnMarTodosClick(Sender: TObject);
    procedure btnDesmarTodosClick(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    cdsArmazens,
    cdsOperadores: TZClient;
    FIntRecNoAmz: Integer;
    FBlnMarcar: Boolean;
    FStrAutIncAmz: String;
    function fGetSQLOperadores(AOperacao: TTipoOperacao = toNavegacao): String;
    function fGetSQLArmazens: String;
    procedure pAbrirQuerys;
    procedure pAlterarModoCdsOperadores(AModo: TTipoOperacao; AStrAutIncArmazem: String = '');
    procedure pGravar;
    procedure pHabilitarDesabilitarCampos(ABlnHabilitar: Boolean);
    procedure pAfterScrollArmazens(DataSet: TDataSet);
    procedure pRemoverArmazem;
    procedure pInserirArmazem;
    procedure pCancelarAlteracao;
    procedure pConfirmar;
    function fGetQtdSelecionados: Integer;
    function fGravarAux(pgbProgresso: TCxProgressBar): Boolean;
    procedure pLimparCampos;
    procedure pMarcarDesmarcarTodos(ABlnMarcar: Boolean = True);
    function fMarcarDesmarcarTodosAux(pgbProgresso: TCxProgressBar): Boolean;
  public
    class function fOperadorComAcesso(AStrCodAmz: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;override;
  end;

var
  frmCadArmazemOperadores: TfrmCadArmazemOperadores;

implementation

{$R *.dfm}

{ TfrmCadArmazemOperadores }

procedure TfrmCadArmazemOperadores.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitarDesabilitarCampos(True);
end;

procedure TfrmCadArmazemOperadores.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCancelarAlteracao;
end;

procedure TfrmCadArmazemOperadores.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
    pConfirmar;
end;

procedure TfrmCadArmazemOperadores.btnDesmarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcarTodos(False);
end;

procedure TfrmCadArmazemOperadores.btnGravarClick(Sender: TObject);
begin
  inherited;
  If btnGravar.Visible Then
    pConfirmar;
end;

function TfrmcadArmazemOperadores.fGetQtdSelecionados: Integer;
begin
  Try
    cdsOperadores.Filter := 'ACESSO = 1';
    cdsOperadores.Filtered := True;
    Result := cdsOperadores.RecordCount;
  Finally
    cdsOperadores.Filter := '';
    cdsOperadores.Filtered := False;
  End;
end;

procedure TfrmCadArmazemOperadores.pConfirmar;
var
  blnProsseguir: Boolean;
begin
  blnProsseguir := True;
  If fGetQtdSelecionados = 0 Then
  Begin
    blnProsseguir := False;
    pMensagemOk('Nenhum operador foi selecionado, não será possível prosseguir');
  End;

  If Not blnProsseguir Then
    Exit;

  If (fMensagem('', 'Confirma gravação dessa relação armazém x operadores?', ['&Sim', '&Não']) = 1) Then
    pGravar;
end;

function TfrmCadArmazemOperadores.fGravarAux(pgbProgresso: TCxProgressBar):Boolean;
var
  qryIns,
  qryDel: TUniQuery;
begin
  Result := False;
  qryIns := fCriaQuery;
  qryIns.SQL.Clear;
  qryIns.SQL.Add('INSERT INTO OPEAMZ (AUTOINCREM,OPE_CODAMZ, OPE_CODOPE, OPE_DTAULT, OPE_HRAULT) ');
  qryIns.SQL.Add('            VALUES(:AUTINC,:CODAMZ, :CODOPE, CURRENT_DATE, CURRENT_TIME)');

  qryDel := fCriaQuery;
  qryDel.SQL.Clear;
  qryDel.SQL.Add('DELETE FROM OPEAMZ WHERE AUTOINCREM = :AUTINC');

  cdsOperadores.DisableControls;

  pgbProgresso.Properties.Max := cdsOperadores.RecordCount;
  pgbProgresso.Position := 0;

  Try
    fStartTransaction;
    Try
      cdsOperadores.First;
      While Not cdsOperadores.Eof Do
      Begin
        If cdsOperadores.FieldByName('ACESSO_ORIGINAL').AsInteger = cdsOperadores.FieldByName('ACESSO').AsInteger Then
        Begin
          cdsOperadores.Next;
          Continue;
        End;

        If (cdsOperadores.FieldByName('ACESSO_ORIGINAL').AsInteger = 1) And (cdsOperadores.FieldByName('ACESSO').AsInteger = 0) Then
        Begin
          qryDel.ParamByName('AUTINC').AsString := cdsOperadores.FieldByName('AUTOINCREM').AsString;
          qryDel.ExecSQL;
        End
        Else
        Begin
          qryIns.ParamByName('AUTINC').AsString := fRetAutoIncrem('OPEAMZ', VS_strCodEmp);

          If pnlInfoAmz.Visible Then
            qryIns.ParamByName('CODAMZ').AsString := fCampoTabela('AUTOINCREM', 'CADAMZ', ['AMZ_CODAMZ', 'AMZ_CODEMP'], [edtCodAmz.Text, edtCodEmp.Text])
          Else
            qryIns.ParamByName('CODAMZ').AsString := FStrAutIncAmz;

          qryIns.ParamByName('CODOPE').AsString := cdsOperadores.FieldByName('OPE_CODOPE').AsString;
          qryIns.ExecSQL;
        End;
        cdsOperadores.Next;
        pgbProgresso.Position := pgbProgresso.Position + 1;
      End;

      Result := fCommit;
      If Result Then
        pMensagemOk('Alterações confirmadas com sucesso');
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadArmazemOperadores.fGravarAux]');
      End;
    End;
  Finally
    cdsOperadores.EnableControls;
    FreeAndNil(qryIns);
    FreeAndNil(qryDel);
  End;
end;

class function TfrmCadArmazemOperadores.fOperadorComAcesso(
  AStrCodAmz: String): Boolean;
var
  qryCons: TUniQuery;
begin
  Result := False;
  qryCons := fCriaQuery;
  Try
    Try
      qryCons.SQL.Clear;
      qryCons.SQL.Add(' SELECT SQL_NO_CACHE O.AUTOINCREM   ');
      qryCons.SQL.Add('   FROM OPEAMZ O                    ');
      qryCons.SQL.Add(' INNER JOIN CADAMZ Z                ');
      qryCons.SQL.Add('   ON Z.AUTOINCREM = O.OPE_CODAMZ   ');
      qryCons.SQL.Add(' WHERE Z.AMZ_CODAMZ = :CODAMZ       ');
      qryCons.SQL.Add('   AND O.OPE_CODOPE = :CODOPE       ');
      qryCons.SQL.Add('   AND Z.AMZ_CODEMP = :CODEMP       ');
      qryCons.SQL.Add(' LIMIT 1                            ');
      qryCons.ParamByName('CODAMZ').AsString := AStrCodAmz;
      qryCons.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryCons.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryCons.Open;
      Result := Not qryCons.IsEmpty;
    Except On
      E:Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadArmazemOperadores.fOperadorComAcesso]');
      End;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

procedure TfrmCadArmazemOperadores.pGravar;
begin
  Try
    TfrmGravando.fExecutarModalA(fGravarAux, 'Gravando alterações...', '');
  Finally
    pAbrirQuerys;
    cdsArmazens.fAbreClient(True, 'TfrmCadArmazemOperadores.pGravar');
    cdsArmazens.RecNo := FIntRecNoAmz;
    edtCodEmp.Clear;
    edtNomEmp.Clear;
    edtCodAmz.Clear;
    edtDesAmz.Clear;
    gridOperadoresView.DataController.Filter.Clear;
  End;
end;

procedure TfrmCadArmazemOperadores.pHabilitarDesabilitarCampos(ABlnHabilitar: Boolean);
begin
  edtCodAmz.Enabled := ABlnHabilitar;
  gpbOperadores.Enabled := ABlnHabilitar;
  If Not gpbOperadores.Visible Then
    gpbOperadores.Visible := True;
end;

procedure TfrmCadArmazemOperadores.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitarDesabilitarCampos(True);
  pSetFocus(edtCodAmz);
  cdsOperadores.Close;
end;

procedure TfrmCadArmazemOperadores.btnMarDesClick(Sender: TObject);
begin
  inherited;
  cdsOperadores.Edit;
  cdsOperadores.FieldByName('ACESSO').AsInteger := IIF(cdsOperadores.FieldByName('ACESSO').AsInteger = 0, 1, 0);
  cdsOperadores.Post;
end;

procedure TfrmCadArmazemOperadores.btnMarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcarTodos;
end;

procedure TfrmCadArmazemOperadores.pMarcarDesmarcarTodos(ABlnMarcar: Boolean = True);
begin
  FBlnMarcar := ABlnMarcar;
  TFrmGravando.fExecutarModalA(fMarcarDesmarcarTodosAux, IIF(ABlnMarcar, 'Marcando', 'Desmarcando') + ' todos...', '');
end;

function TfrmCadArmazemOperadores.fMarcarDesmarcarTodosAux(pgbProgresso: TCxProgressBar): Boolean;
begin
  Try
    Result := False;
    pgbProgresso.Properties.Max := cdsOperadores.RecordCount;
    pgbProgresso.Position := 0;

    cdsOperadores.DisableControls;
    cdsOperadores.First;
    While Not cdsOperadores.Eof Do
    Begin
      cdsOperadores.Edit;
      cdsOperadores.FieldByName('ACESSO').AsInteger := IIF(FBlnMarcar, 1,0);
      cdsOperadores.Post;

      cdsOperadores.Next;
      pgbProgresso.Position := pgbProgresso.Position + 1;
    End;

    Result := True;
  Finally
    cdsOperadores.EnableControls;
  End;
End;

procedure TfrmCadArmazemOperadores.edtCodAmzKeyPress(Sender: TObject;
  var Key: Char);
 Var
    arrAmz: TConsultasArray;
begin
  inherited;
  If fPesqArmazem(Self, edtCodAmz, edtDesAmz, nil, Key, arrAmz, True, '', edtCodEmp.Text, True) Then
  Begin
    If fValidaCampos(edtCodAmz, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadArmazemOperadores.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
 Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadArmazemOperadores.fGetSQLArmazens: String;
begin
  Result := '';
  Result := Result + '    SELECT CADAMZ.AMZ_CODAMZ,                                       ';
  Result := Result + '         AMZ_DESCRI,                                                ';
  Result := Result + '         AMZ_CODEMP ,                                               ';
  Result := Result + '         CADAMZ.AUTOINCREM                                          ';
  Result := Result + '    FROM OPEAMZ                                                     ';
  Result := Result + '      INNER JOIN CADOPE ON OPEAMZ.OPE_CODOPE = CADOPE.OPE_CODOPE    ';
  Result := Result + '      INNER JOIN CADAMZ ON CADAMZ.AUTOINCREM = OPE_CODAMZ           ';
  Result := Result + '    GROUP BY CADAMZ.AUTOINCREM                                      ';
end;

function TfrmCadArmazemOperadores.fGetSQLOperadores(AOperacao: TTipoOperacao = toNavegacao): String;
begin
  Result := '';
  Case AOperacao Of
    toNavegacao: Begin
                   Result := Result + ' SELECT                                              ';
                   Result := Result + '   CADOPE.OPE_CODOPE,                                ';
                   Result := Result + '   OPE_NOMOPE,                                       ';
                   Result := Result + '   IF(OPEAMZ.AUTOINCREM IS NULL, 0, 1) AS ACESSO,    ';
                   Result := Result + '   OPEAMZ.OPE_CODAMZ,                                ';
                   Result := Result + '   OPEAMZ.AUTOINCREM                                 ';
                   Result := Result + ' FROM                                                ';
                   Result := Result + '   CADOPE                                            ';
                   Result := Result + '   INNER JOIN OPEAMZ                                 ';
                   Result := Result + '     ON OPEAMZ.OPE_CODOPE = CADOPE.OPE_CODOPE        ';
                   Result := Result + '   INNER JOIN CADAMZ                                 ';
                   Result := Result + '     ON CADAMZ.AUTOINCREM = OPE_CODAMZ               ';
                   Result := Result + ' WHERE OPEAMZ.OPE_CODAMZ = :CODAMZ                   ';
                 End;
    toInsercao : Begin
                   Result := Result + 'SELECT CADOPE.OPE_CODOPE, OPE_NOMOPE,0 ACESSO_ORIGINAL, 0 ACESSO FROM CADOPE ORDER BY OPE_CODOPE';
                 End;
    toAlteracao: Begin
                   Result := Result + '  SELECT                                             ';
                   Result := Result + '    CADOPE.OPE_CODOPE,                               ';
                   Result := Result + '    OPE_NOMOPE,                                      ';
                   Result := Result + '    1 AS ACESSO,                                     ';
                   Result := Result + '    1 ACESSO_ORIGINAL,                               ';
                   Result := Result + '    OPEAMZ.OPE_CODAMZ,                               ';
                   Result := Result + '    OPEAMZ.AUTOINCREM                                ';
                   Result := Result + '  FROM                                               ';
                   Result := Result + '    OPEAMZ                                           ';
                   Result := Result + '    INNER JOIN CADOPE                                ';
                   Result := Result + '      ON OPEAMZ.OPE_CODOPE = CADOPE.OPE_CODOPE       ';
                   Result := Result + '    INNER JOIN CADAMZ                                ';
                   Result := Result + '      ON CADAMZ.AUTOINCREM = OPE_CODAMZ              ';
                   Result := Result + '  WHERE (                                            ';
                   Result := Result + '      OPEAMZ.OPE_CODAMZ = :CODAMZ                    ';
                   Result := Result + '    )                                                ';
                   Result := Result + '  UNION                                              ';
                   Result := Result + '  SELECT                                             ';
                   Result := Result + '    CADOPE.OPE_CODOPE,                               ';
                   Result := Result + '    OPE_NOMOPE,                                      ';
                   Result := Result + '    0 ACESSO,                                        ';
                   Result := Result + '    0 ACESSO_ORIGINAL,                               ';
                   Result := Result + '    "" OPE_CODAMZ,                                   ';
                   Result := Result + '    "" AUTOINCREM                                    ';
                   Result := Result + '  FROM                                               ';
                   Result := Result + '    CADOPE                                           ';
                   Result := Result + '  WHERE OPE_CODOPE NOT IN                            ';
                   Result := Result + '    (SELECT                                          ';
                   Result := Result + '      OPE_CODOPE                                     ';
                   Result := Result + '    FROM                                             ';
                   Result := Result + '      OPEAMZ                                         ';
                   Result := Result + '    WHERE OPEAMZ.OPE_CODAMZ = :CODAMZ)               ';
                 End;
  End;
end;

procedure TfrmCadArmazemOperadores.pAfterScrollArmazens(DataSet: TDataSet);
begin
  pAlterarModoCdsOperadores(toNavegacao, DataSet.FieldByName('AUTOINCREM').AsString);
end;

procedure TfrmCadArmazemOperadores.pAlterarModoCdsOperadores(AModo: TTipoOperacao; AStrAutIncArmazem: String);
begin
  cdsOperadores.Close;
  cdsOperadores.qryQuery.SQL.Clear;
  cdsOperadores.qryQuery.SQL.Add(fGetSQLOperadores(AModo));

  If Assigned(cdsOperadores.qryQuery.Params.FindParam('CODAMZ')) Then
    cdsOperadores.qryQuery.ParamByName('CODAMZ').AsString := AStrAutIncArmazem;

  cdsOperadores.fAbreClient(True, 'TfrmCadArmazemOperadores.pAlterarModoCdsOperadores');

  pnlInfoAmz.Visible := AModo = toInsercao;

  If pnlInfoAmz.Visible Then
    cdsArmazens.AfterScroll := Nil
  Else
    cdsArmazens.AfterScroll := pAfterScrollArmazens;

  gridOperadoresViewACESSO.Options.Editing := Not (AModo = toNavegacao);
  pnlBotoesOpe.Visible := Not (AModo = toNavegacao);
  If gridOperadoresViewACESSO.Options.Editing Then
    pSetFocus(cxGridOperadores);

  FIntRecNoAmz := cdsArmazens.RecNo;
  FStrAutIncAmz := AStrAutIncArmazem;
End;

procedure TfrmCadArmazemOperadores.pAbrirQuerys;
begin
  cdsArmazens.qryQuery.SQL.Clear;
  cdsArmazens.qryQuery.SQL.Add(fGetSQLArmazens);
  cdsArmazens.fAbreClient(True, 'TfrmCadArmazemOperadores.pAbrirQuerys');
  dtsArmazens.DataSet := cdsArmazens;

  cdsOperadores.qryQuery.SQL.Clear;
  cdsOperadores.qryQuery.SQL.Add(fGetSQLOperadores);
  cdsOperadores.fAbreClient(True, 'TfrmCadArmazemOperadores.pAbrirQuerys');
  dtsOperadores.DataSet := cdsOperadores;

  cdsArmazens.AfterScroll := pAfterScrollArmazens;
  pAfterScrollArmazens(cdsArmazens);
end;

procedure TfrmCadArmazemOperadores.FormCreate(Sender: TObject);
begin
  inherited;
  cdsOperadores := TZClient.Create(Self);
  cdsArmazens   := TZClient.Create(Self);

  pAbrirQuerys;

end;

procedure TfrmCadArmazemOperadores.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsOperadores);
  FreeAndNil(cdsArmazens);
end;

procedure TfrmCadArmazemOperadores.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //inherited;
  Case Key Of
    VK_DELETE: pRemoverArmazem;
    VK_INSERT: pInserirArmazem;
    VK_SPACE: btnMarDes.Click;
    VK_F2: btnMarTodos.Click;
    VK_F3: btnDesmarTodos.Click;
    VK_F10: btnGravar.Click;
  End;
end;

procedure TfrmCadArmazemOperadores.pCancelarAlteracao;
begin
  cdsOperadores.Cancel;
  FIntRecNoAmz := -1;
  pAfterScrollArmazens(cdsArmazens);

  pLimparCampos;
end;

procedure TfrmCadArmazemOperadores.pLimparCampos;
begin
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  edtCodAmz.Clear;
  edtDesAmz.Clear;
end;

procedure TfrmCadArmazemOperadores.pInserirArmazem;
begin
  pAlterarModoCdsOperadores(toInsercao);
  pSetFocus(edtCodEmp);
end;

procedure TfrmCadArmazemOperadores.pRemoverArmazem;
var
  qryDel: TUniQuery;
begin
  If edtCodEmp.Focused Then
    Exit;

  If edtCodAmz.Focused Then
    Exit;

  If Not (fMensagem('', 'Confirma exclusão dessa relação armazém x operadores?', ['&Sim', '&Não']) = 1) Then
    Exit;

  qryDel := fCriaQuery;
  Try
    qryDel.SQL.Clear;
    qryDel.SQL.Add('DELETE FROM OPEAMZ WHERE OPE_CODAMZ = :AUTINC');
    qryDel.ParamByName('AUTINC').AsString := cdsArmazens.FieldByName('AUTOINCREM').AsString;

    Try
      fStartTransaction;
      qryDel.ExecSQL;
      If fCommit Then
        pMensagemOk('Armazém excluído com sucesso');
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadArmazemOperadores.pRemoverArmazem]');
      End;
    End;
  Finally
    pAbrirQuerys;
    pLimparCampos;
    FreeAndNil(qryDel);
  End;
end;

function TfrmCadArmazemOperadores.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = edtCodEmp) And pnlInfoAmz.Visible Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodAmz) And pnlInfoAmz.Visible Then
    Begin
      If Not fEmptyStr(edtCodAmz.Text) Then
      Begin
        edtDesAmz.Text := fRetNomeArmazemPorEmpresa(edtCodAmz.Text, edtCodEmp.Text);
        If fEmptyStr(edtDesAmz.Text) Then
        Begin
          pMensagemOk('Nenhum armazém encontrado com este código para a empresa informada!');
          Result := False;
        End
        Else If cdsArmazens.Locate('AMZ_CODAMZ;AMZ_CODEMP', VarArrayOf([edtCodAmz.Text, edtCodEmp.Text]), [loCaseInsensitive]) Then
        Begin
          pMensagemOk('O armazém informado já possui relação com operadores, dê dois cliques no grid superior para editar!');
          edtCodAmz.Clear;
          edtDesAmz.Clear;
          Result := False;
        End;
      End
      Else
      Begin
        pMensagemOk('Código do armazém deve ser informado!');
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadArmazemOperadores.gridArmazensViewDblClick(Sender: TObject);
begin
  inherited;
  pAlterarModoCdsOperadores(toAlteracao, cdsArmazens.FieldByName('AUTOINCREM').AsString);
end;

end.
