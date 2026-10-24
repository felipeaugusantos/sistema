unit untAltNumLote;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Uni, DB, UniClientDataSet, untCadLote, untFuncoesSimples, untTypesSistema,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmAltNumLote = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    lbl1: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtLotAtu: TEditFocus;
    lblLotAtu: TLabel;
    edtLotNov: TEditFocus;
    lblLotNov: TLabel;
    btnGravar: TBitBtnLocked;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtLotAtuKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryTabelasIgnora,
    qryTabelaSemCodEmp,
    qryTabelaSemCodIte: TUniQuery;
    qryCadLot: TUniQuery;
    objCadLot: TCadLot;
    cdsTables: TUniClientDataSet;
    cdsFields: TUniClientDataSet;
    intConfir: Integer;
    procedure pLimpaTela;
    procedure pRetornaTables;
    procedure pRetornaFields;
    procedure pCriaClientTables;
    procedure pCriaClientFields;
    function fGravaAltNumLote: Boolean;
    function fPesquisaLote(Sender: TObject; Var Key: Char; arrNumLot: TStringArray = Nil): Boolean;
    function fLocalteIgnoraTabela(ATabela: String): Boolean;
    function fLocalteTabelaSemCodEmp(ATabela: String; var SQLJoin: string): Boolean;
    function fLocalteTabelaSemCodIte(ATabela: String; var SQLJoin: string): Boolean;
    function fMontaUpdEQLDET(AUsaDel: Boolean): string;
    function fMontaUpdACLDET(AUsaDel: Boolean): string;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmAltNumLote: TfrmAltNumLote;

implementation

uses untConsultas, untPanelCxCadLote, untPnlDadosCadLote, untWaitWindow, StrUtils, System.Masks;

{$R *.dfm}

procedure TfrmAltNumLote.btnGravarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  If (InterlockedIncrement(intConfir) = 0) Then
  Begin
    Try
      If fGravaAltNumLote Then
        fMensagem('ATENÇÃO!', 'Alteração realizada com sucesso!', ['&O k'])
      Else
        fMensagem('ERRO!', 'Problemas na alteração do Número do ' + objCadLot.strTitLab + '!', ['&O k']);
      InterlockedDecrement(intConfir);
      pLimpaTela;
      pSetFocus(edtCodIte);
    Except
      InterlockedDecrement(intConfir);
    End;
  End
  Else
    InterlockedDecrement(intConfir)
end;

procedure TfrmAltNumLote.edtCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrLotes_: TConsultasArray;
begin
  If fEntraCons(Key) Then
  Begin
    If fPesqLoteItens(Self, edtLotAtu, edtCodIte, fCfgSis('DECUNI'), qryCadLot, Key, arrLotes_) Then
    Begin
      edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
      Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmAltNumLote.edtLotAtuKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesquisaLote(Sender, Key) And fValidaCampos(edtLotAtu, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltNumLote.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadLot);
  FreeAndNil(objCadLot);
end;

procedure TfrmAltNumLote.FormCreate(Sender: TObject);
begin
  inherited;
  intConfir := -1;
  qryCadLot := fCriaQuery;
  objCadLot := TCadLot.Create(Self);
  lblLotAtu.Caption := objCadLot.strTitLab + ' atual';
  lblLotNov.Caption := 'Novo ' + objCadLot.strTitLab;
  qryTabelasIgnora := fCriaQuery;
  qryTabelasIgnora.SQL.Add('SELECT TABELA_REGRA, AJUSTE_SQL FROM CONFIG_ALTNUMLOT WHERE IGNORA_TABELA = 1');
  qryTabelasIgnora.Open;


  qryTabelaSemCodEmp := fCriaQuery;
  qryTabelaSemCodEmp.SQL.Add('SELECT TABELA_REGRA, AJUSTE_SQL FROM CONFIG_ALTNUMLOT WHERE SEM_CADEMP = 1');
  qryTabelaSemCodEmp.Open;

  qryTabelaSemCodIte := fCriaQuery;
  qryTabelaSemCodIte.SQL.Add('SELECT TABELA_REGRA, AJUSTE_SQL FROM CONFIG_ALTNUMLOT WHERE SEM_CODITE = 1');
  qryTabelaSemCodIte.Open;

  pCriaClientTables;
  pCriaClientFields;
  pSetaCodIte(edtCodIte);
end;

procedure TfrmAltNumLote.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryTabelasIgnora);
  FreeAndNil(qryTabelaSemCodEmp);
  FreeAndNil(qryTabelaSemCodIte);
end;

procedure TfrmAltNumLote.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If edtCodIte.Focused Then
    inherited
  Else
  Begin
    If (Key = VK_ESCAPE) Then
    Begin
      pLimpaTela;
      pSetFocus(edtCodIte);
    End;
  End;
end;

procedure TfrmAltNumLote.FormShow(Sender: TObject);
begin
  inherited;
  Screen.Cursor := crHourGlass;
  Try
    pCriarFormularios(TfrmWaitWindow, frmWaitWindow);
    frmWaitWindow.lblTexto.Caption := 'Aguarde, Processando ... ';
    frmWaitWindow.tmrWait.Enabled  := False;
    AnimateWindow(frmWaitWindow.Handle, 200, AW_BLEND);
    frmWaitWindow.Show;
    frmWaitWindow.Refresh;
    pRetornaTables;
    pRetornaFields;
    frmWaitWindow.Close;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[]');
    End;
  End;
  pFreeAndNil(frmWaitWindow);
  Screen.Cursor := crDefault;
end;

function TfrmAltNumLote.fPesquisaLote(Sender: TObject; var Key: Char;
  arrNumLot: TStringArray): Boolean;
  var
    objfrmPnl: TPanelCxCadLote;
begin
  inherited;
  Try
    objfrmPnl := TPanelCxCadLote.Create(TfrmPnlDadosCadLote);
    objfrmPnl.strCodIte := edtCodIte.Text;
    Result := objCadLot.fedtNumLotKeyPress(edtCodIte.Text, Sender, Key, edtLotAtu, Self, False, False,
                                           objfrmPnl, arrNumLot, VS_strCodEmp);
  Finally
    FreeAndNil(objfrmPnl);
  End;
end;

function TfrmAltNumLote.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodIte) Then
    Begin
      If fEmptyStr(edtCodIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Escolha um Produto para alterar o ' + objCadLot.strTitLab + '!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
        If fEmptyStr(edtDesIte.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Produto não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtLotAtu) Then
    Begin
      If fEmptyStr(edtLotAtu.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Número do ' + objCadLot.strTitLab + ' Atual!', ['&Ok']);
        Result := False;
      End
      Else If Not objCadLot.fExisteLote(edtCodIte.Text, VS_strCodEmp, edtLotAtu.Text) Then
      Begin
        fMensagem('ATENÇÃO!', objCadLot.strTitLab + ' não encontrado!', ['&Ok']);
        Result := False;
      End
      Else If edtLotAtu.Text = 'A DEFINIR' Then
      Begin
        fMensagem('ATENÇÃO!', 'O Lote não pode ser "A DEFINIR"!.', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtLotNov) Then
    Begin
      If fEmptyStr(edtLotNov.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Novo Número do ' + objCadLot.strTitLab + '!', ['&Ok']);
        Result := False;
      End
      Else If objCadLot.fExisteLote(edtCodIte.Text, VS_strCodEmp, edtLotNov.Text) Then
      Begin
        fMensagem('ATENÇÃO!', objCadLot.strTitLab + ' já cadastrado para este Produto!', ['&Ok']);
        Result := False;
      End;
    End;
  End;
  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmAltNumLote.fGravaAltNumLote: Boolean;
  Const
    strUpdESPDET = 'UPDATE   ' +
                   '  ESPDET ' +
                   '  INNER JOIN ESPGER ON (ESPGER.AUTOINCREM = ESPDET.DET_SEQGER) ' +
                   'SET                               ' +
                   '  ESPDET.DET_NUMLOT = :LOTNOV     ' +
                   'WHERE ESPGER.GER_CODEMP = :CODEMP ' +
                   '  AND ESPDET.DET_CODITE = :CODITE ' +
                   '  AND ESPDET.DET_NUMLOT = :LOTATU ';

    strUpdDEL_ESPDET = 'UPDATE       ' +
                       '  DEL_ESPDET ' +
                       '  INNER JOIN DEL_ESPGER ON (DEL_ESPGER.AUTOINCREM = DEL_ESPDET.DET_SEQGER) ' +
                       'SET                                   ' +
                       '  DEL_ESPDET.DET_NUMLOT = :LOTNOV     ' +
                       'WHERE DEL_ESPGER.GER_CODEMP = :CODEMP ' +
                       '  AND DEL_ESPDET.DET_CODITE = :CODITE ' +
                       '  AND DEL_ESPDET.DET_NUMLOT = :LOTATU ';

  Var
    strLotCor : String;
    strSQL: String;
    qryUpd: TUniQuery;
    strSQLJoin: string;
    blnSemCodEmp,
    blnSemCodIte: Boolean;
    strUpdEQLDET     : string;
    strUpdACLDET     : string;
    strUpdDEL_EQLDET : string;
    strUpdDEL_ACLDET : string;
begin
  Result := False;
  qryUpd := fCriaQuery(Self);
  Try
    Try

      strUpdEQLDET     := fMontaUpdEQLDET(False);
      strUpdDEL_EQLDET := fMontaUpdEQLDET(True);
      strUpdACLDET     := fMontaUpdACLDET(False);
      strUpdDEL_ACLDET := fMontaUpdACLDET(True);

    Try
      fStartTransaction;
      With cdsFields Do
      Begin
        First;
        While Not Eof Do
        Begin
          strSQL := '';
          If (FieldByName('TABELA').AsString  = 'CORDET') Or (FieldByName('TABELA').AsString  = 'DEL_CORDET') then
          begin
            If FieldByName('TABELA').AsString = 'CORDET' Then
               strLotCor :=  'LOTCOR'
             Else
               strLotCor :=  'DEL_LOTCOR';

            strSQL := strSQL + 'UPDATE                     ';
            strSQL := strSQL + '  ' + cdsFields.FieldByName('TABELA').AsString + '  ';
            strSQL := strSQL + '  INNER JOIN ' + strLotCor + ' ON ' + strLotCor + '.AUTOINCREM = ' + FieldByName('TABELA').AsString + '.DET_SEQCOR ';
            strSQL := strSQL + 'SET                        ';
            strSQL := strSQL + '  ' + FieldByName('ABREV').AsString  + 'NUMLOT = :LOTNOV     ';
            strSQL := strSQL + 'WHERE TRUE ';
            strSQL := strSQL + 'AND COR_CODITE = :CODITE ';
            strSQL := strSQL + 'AND COR_CODEMP = :CODEMP';

          End
          Else
          Begin
            blnSemCodEmp := fLocalteTabelaSemCodEmp(FieldByName('TABELA').AsString, strSQLJoin);
            blnSemCodIte := fLocalteTabelaSemCodIte(FieldByName('TABELA').AsString, strSQLJoin);
            strSQL := strSQL + 'UPDATE                     ';
            strSQL := strSQL + '  ' + FieldByName('TABELA').AsString + '  ';
            If strSQLJoin <> '' Then
              strSQL := strSQL + ' ' + strSQLJoin + ' ';
            strSQL := strSQL + 'SET                        ';
            strSQL := strSQL + '  ' + FieldByName('ABREV').AsString  + 'NUMLOT = :LOTNOV     ';
            strSQL := strSQL + 'WHERE TRUE ';

            If SameText('LOTDOR', FieldByName('TABELA').AsString) Or SameText('DEL_LOTDOR', FieldByName('TABELA').AsString) Then
            Begin
              strSQL := strSQL + ' AND LDO_SEQFDO IN (SELECT AUTOINCREM FROM '+ IIF(FieldByName('TABELA').AsString='DEL_LOTDOR', 'DEL_', '') +
                                 'FATDOR WHERE FDO_CODITE = :CODITE AND FDO_CODEMP = :CODEMP ) ';
            End
            Else If SameText('LOCDOR', FieldByName('TABELA').AsString) Or SameText('DEL_LOCDOR', FieldByName('TABELA').AsString) Then
            Begin
              strSQL := strSQL + ' AND LCD_SEQFDO IN (SELECT AUTOINCREM FROM '+ IIF(FieldByName('TABELA').AsString='DEL_LOCDOR', 'DEL_', '') +
                                 'FATDOR WHERE FDO_CODITE = :CODITE AND FDO_CODEMP = :CODEMP ) ';
            End
            Else If SameText('DORLOC', FieldByName('TABELA').AsString) Or SameText('DEL_DORLOC', FieldByName('TABELA').AsString) Then
            Begin
              strSQL := strSQL + ' AND LTD_INCDOR IN (SELECT '+
                                 IIF(FieldByName('TABELA').AsString = 'DEL_DORLOC', 'DEL_LOTDOR', 'LOTDOR') +
                                 '.AUTOINCREM FROM '+
                                 IIF(FieldByName('TABELA').AsString = 'DEL_DORLOC', 'DEL_LOTDOR', 'LOTDOR') +
                                 ' INNER JOIN '+
                                 IIF(FieldByName('TABELA').AsString = 'DEL_DORLOC', 'DEL_FATDOR', 'FATDOR') +
                                 ' ON ' +
                                 IIF(FieldByName('TABELA').AsString = 'DEL_DORLOC', 'DEL_LOTDOR', 'LOTDOR') +
                                 '.LDO_SEQFDO ='+
                                 IIF(FieldByName('TABELA').AsString = 'DEL_DORLOC', 'DEL_FATDOR', 'FATDOR') +
                                 '.AUTOINCREM  WHERE FDO_CODITE = :CODITE AND FDO_CODEMP = :CODEMP ) ';
            End
            Else
            Begin

              If SameText('PREPTE', FieldByName('TABELA').AsString) Or SameText('DEL_PREPTE', FieldByName('TABELA').AsString) Then
                strSQL := strSQL + ' AND PRE_EMPORI = :CODEMP '

              Else If Not blnSemCodEmp Then
                strSQL := strSQL + ' AND ' + FieldByName('ABREV').AsString  + 'CODEMP = :CODEMP ';

              If (SameText('DEICOR', FieldByName('TABELA').AsString)) Or  (SameText('DEL_DEICOR', FieldByName('TABELA').AsString)) Then
                strSQL := strSQL + ' AND DMT_ITESUB = :CODITE '

              Else If (SameText('DETPRO', FieldByName('TABELA').AsString)) Or (SameText('DEL_DETPRO', FieldByName('TABELA').AsString)) Then
                strSQL := strSQL + ' AND DOP_ITESUB = :CODITE '

              Else If Not blnSemCodIte Then
                strSQL := strSQL + ' AND ' + FieldByName('ABREV').AsString  + 'CODITE = :CODITE ';

            End;
          End;

          strSQL := strSQL + ' AND ' + FieldByName('ABREV').AsString  + 'NUMLOT = :LOTATU     ';

          If SameText(FieldByName('TABELA').AsString, 'PREPRQ') Or
             SameText(FieldByName('TABELA').AsString, 'DEL_PREPRQ') Then
            strSQL := AnsiReplaceStr(strSQL, 'PRQ_CODEMP', 'PRQ_EMPREQ');

          With qryUpd Do
          Begin
            Close;
            SQL.Clear;

            If cdsFields.FieldByName('TABELA').AsString = 'DEL_ESPDET' Then
              SQL.Add(strUpdDEL_ESPDET)
            Else
            If cdsFields.FieldByName('TABELA').AsString = 'ESPDET' Then
              SQL.Add(strUpdESPDET)
            Else
            If cdsFields.FieldByName('TABELA').AsString = 'EQLDET' Then
              SQL.Add(strUpdEQLDET)
            Else
            If cdsFields.FieldByName('TABELA').AsString = 'DEL_EQLDET' Then
              SQL.Add(strUpdDEL_EQLDET)
            Else
            If cdsFields.FieldByName('TABELA').AsString = 'ACLDET' Then
              SQL.Add(strUpdACLDET)
            Else
            If cdsFields.FieldByName('TABELA').AsString = 'DEL_ACLDET' Then
              SQL.Add(strUpdDEL_ACLDET)
            Else
              SQL.Add(strSQL);

            If Assigned(Params.FindParam('CODEMP')) Then
              ParamByName('CODEMP').AsString := VS_strCodEmp;

            ParamByName('CODITE').AsString := edtCodIte.Text;
            ParamByName('LOTNOV').AsString := edtLotNov.Text;
            ParamByName('LOTATU').AsString := edtLotAtu.Text;

            ExecSQL;
          End;

          Next;
        End;
      End;
      fCommit;
      Result := True;
    Except
      On E: Exception do
        Raise Exception.Create('Tabela : ' + cdsFields.FieldByName('TABELA').AsString + ' ' + E.Message);
    End;
    Except On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmAltNumLote.fGravaAltNumLote]');
        pMensagemOk(E.Message);
        fRollBack;
      End;
    End;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

function TfrmAltNumLote.fMontaUpdEQLDET(AUsaDel: Boolean): string;
var
  strPre: string;
begin
  strPre := IfThen(AUsaDel, 'DEL_', '');

  Result :=
    'UPDATE ' + strPre + 'CONEQL ' +
    'INNER JOIN ' + strPre + 'EQLDET E  ON E.EQD_SEQCON = ' + strPre + 'CONEQL.AUTOINCREM ' +
    'INNER JOIN ' + strPre + 'CADEQL CE ON E.EQD_SEQEQL  = CE.EQL_CODIGO ' +
    'SET EQD_NUMLOT = :LOTNOV ' +
    'WHERE TRUE ' +
    '  AND EQL_CODITE = :CODITE ' +
    '  AND EQD_NUMLOT = :LOTATU ' +
    '  AND EQL_CODEMP = :CODEMP ';
end;

function TfrmAltNumLote.fMontaUpdACLDET(AUsaDel: Boolean): string;
var
  strPre: string;
begin
  strPre := IfThen(AUsaDel, 'DEL_', '');

  Result :=
    'UPDATE ' + strPre + 'CONEQL ' +
    'INNER JOIN ' + strPre + 'ACLDET ON ' + strPre + 'ACLDET.EQD_SEQCON = ' + strPre + 'CONEQL.AUTOINCREM ' +
    'INNER JOIN ' + strPre + 'CADACL ON ' + strPre + 'ACLDET.EQD_SEQACL  = ACL_CODIGO ' +
    'SET EQD_NUMLOT = :LOTNOV ' +
    'WHERE TRUE ' +
    '  AND ACL_CODITE = :CODITE ' +
    '  AND EQD_NUMLOT = :LOTATU ' +
    '  AND EQL_CODEMP = :CODEMP ';
end;

function TfrmAltNumLote.fLocalteIgnoraTabela(ATabela: String): Boolean;
begin
  qryTabelasIgnora.First;
  Result := qryTabelasIgnora.Locate('TABELA_REGRA', ATabela, []);

end;

function TfrmAltNumLote.fLocalteTabelaSemCodEmp(ATabela: String; var SQLJoin: string): Boolean;
begin
  SQLJoin := '';
  qryTabelaSemCodEmp.First;
  Result := qryTabelaSemCodEmp.Locate('TABELA_REGRA', ATabela, []);
  If Result Then
     SQLJoin := qryTabelaSemCodEmp.FieldByName('AJUSTE_SQL').AsString;

  If Result And (fEmptyStr(SQLJoin)) Then
  Begin
    raise Exception.Create('Tabela CONFIG_ALTNUMLOT com excessão para campo empresa sem comando SQL (join) de ajuste definido');
    pMensagemOk('')
  End;
end;

function TfrmAltNumLote.fLocalteTabelaSemCodIte(ATabela: String; var SQLJoin: string): Boolean;
begin
  SQLJoin := '';
  qryTabelaSemCodIte.First;
  Result := qryTabelaSemCodIte.Locate('TABELA_REGRA', ATabela, []);
  If Result Then
     SQLJoin := qryTabelaSemCodIte.FieldByName('AJUSTE_SQL').AsString;

  If Result And (fEmptyStr(SQLJoin)) Then
  Begin
    raise Exception.Create('Tabela CONFIG_ALTNUMLOT com excessão para campo empresa sem comando SQL (join) de ajuste definido');
    pMensagemOk('')
  End;
end;

procedure TfrmAltNumLote.pCriaClientFields;
begin
  If Not Assigned(cdsFields) Then
  Begin
    cdsFields := TUniClientDataSet.Create(Self);
    With cdsFields Do
    Begin
      With FieldDefs.AddFieldDef Do
      Begin
        Name     := 'TABELA';
        DataType := ftString;
        Size     := 50;
      End;
      With FieldDefs.AddFieldDef Do
      Begin
        Name     := 'ABREV';
        DataType := ftString;
        Size     := 4;
      End;
      With FieldDefs.AddFieldDef Do
      Begin
        Name     := 'CAMPO';
        DataType := ftString;
        Size     := 50;
      End;
    End;
    cdsFields.CreateDataSet;
  End;
end;

procedure TfrmAltNumLote.pCriaClientTables;
begin
  If Not Assigned(cdsTables) Then
  Begin
    cdsTables := TUniClientDataSet.Create(Self);
    With cdsTables Do
    Begin
      With FieldDefs.AddFieldDef Do
      Begin
        Name     := 'TABELA';
        DataType := ftString;
        Size     := 50;
      End;
      With FieldDefs.AddFieldDef Do
      Begin
        Name     := 'ABREV';
        DataType := ftString;
        Size     := 4;
      End;
      With FieldDefs.AddFieldDef Do
      Begin
        Name     := 'EXISTE';
        DataType := ftString;
        Size     := 1;
      End;
    End;
    cdsTables.CreateDataSet;
  End;
end;

procedure TfrmAltNumLote.pLimpaTela;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtLotAtu.Clear;
  edtLotNov.Clear;
end;

procedure TfrmAltNumLote.pRetornaFields;

  Var
    qryFields: TUniQuery;
begin
  qryFields := nil;
  Try

    Try

      qryFields := fCriaQuery;
      cdsTables.First;
      While Not cdsTables.Eof Do
      Begin
        With qryFields Do
        Begin
          Close;
          SQL.Clear;
          SQL.Text := ' DESC `' + cdsTables.FieldByName('TABELA').AsString + '`';
          Open;
          First;
          While Not Eof Do
          Begin

            If (Copy(FieldByName('Field').AsString, 5, Length(FieldByName('Field').AsString)) = 'NUMLOT') And
               (Not fLocalteIgnoraTabela(UpperCase(cdsTables.FieldByName('TABELA').AsString))) Then
            Begin
              cdsFields.Append;
              cdsFields.FieldByName('TABELA').AsString := cdsTables.FieldByName('TABELA').AsString;
              cdsFields.FieldByName('ABREV').AsString  := Copy(FieldByName('Field').AsString, 1, 4);
              cdsFields.FieldByName('CAMPO').AsString  := FieldByName('Field').AsString;
              cdsFields.Post;
            End;


            Application.ProcessMessages;
            Next;
          End;
        End;
        cdsTables.Next;
      End;

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmAltNumLote.pRetornaFields;]');
      End;

    End;


  Finally
    FreeAndNil(qryFields);
  End;
end;

procedure TfrmAltNumLote.pRetornaTables;
var
  qryTables, qryConfig: TUniQuery;
  lstRegras: TStringList;
  i: Integer;
  Ignorar: Boolean;
  strBcoDad, TableName: String;
begin
  strBcoDad := fArqIni(0,'BANCO','NOMBAN','');
  qryTables := nil;
  qryConfig := nil;
  lstRegras := nil;
  try
    qryTables := fCriaQuery;
    qryConfig := fCriaQuery;
    lstRegras := TStringList.Create;
    // Carrega todas as regras de rejeição de uma vez
    qryConfig.SQL.Text :=
      'SELECT TABELA_REGRA FROM CONFIG_ALTNUMLOT WHERE REJEITA_TABELA = 1';
    qryConfig.Open;

    while not qryConfig.Eof do
    begin
      lstRegras.Add(Trim(qryConfig.Fields[0].AsString));
      qryConfig.Next;
    end;

    // Busca todas as tabelas do banco
    qryTables.SQL.Text := 'SHOW FULL TABLES WHERE Table_Type = "BASE TABLE"';
    qryTables.Open;

    cdsTables.DisableControls;
    try
      while not qryTables.Eof do
      begin
        TableName := qryTables.FieldByName('Tables_in_' + strBcoDad).AsString;
        Ignorar := False;

        // Verifica se alguma regra bate com o nome da tabela
        for i := 0 to lstRegras.Count - 1 do
        begin
          if MatchesMask(TableName, lstRegras[i]) then
          begin
            Ignorar := True;
            Break;
          end;
        end;

        // Se não estiver nas regras, nem for TMP_ ou LOGDOR => adiciona
        if (not Ignorar) and
           (not AnsiStartsStr('TMP_', TableName)) and
           (not SameText('LOGDOR', TableName)) then
        begin
          cdsTables.Append;
          cdsTables.FieldByName('TABELA').AsString := TableName;
          cdsTables.Post;
        end;

        qryTables.Next;
      end;
    finally
      cdsTables.EnableControls;
    end;
  finally
    FreeAndNil(qryTables);
    FreeAndNil(qryConfig);
    lstRegras.Free;
  end;
end;

end.

