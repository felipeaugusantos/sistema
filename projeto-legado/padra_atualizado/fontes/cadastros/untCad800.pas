unit untCad800;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  Uni, Clipbrd, IdMessage, IdText, ShellApi, cxProgressBar,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.ExtCtrls, Data.DB, Vcl.StdCtrls,
  EditFocus, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Vcl.Menus, Vcl.ComCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, untZClient, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, untTypesSistema, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.Graphics, Vcl.ImgList, cxEditRepositoryItems, System.ImageList,
  untFuncoesRel, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCad800 = class(TfrmPaiCad)
    Label1: TLabel;
    dbeFone01: TDBEditFocus;
    Label2: TLabel;
    dbeSequen: TDBEditFocus;
    dbeSolici: TDBEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    dbeEndere: TDBEditFocus;
    Label5: TLabel;
    dbeCodCid: TDBEditFocus;
    edtDesCid: TEditFocus;
    Label6: TLabel;
    dbeCodBai: TDBEditFocus;
    edtDesBai: TEditFocus;
    Label7: TLabel;
    dbeMotivo: TDBEditFocus;
    Label8: TLabel;
    dbeCodCac: TDBEditFocus;
    edtDesCac: TEditFocus;
    dtsCad800: TDataSource;
    dbeCodEmp: TDBEditFocus;
    Label9: TLabel;
    dbeDtaCad: TDBEditFocus;
    dbeHorCad: TDBEditFocus;
    Label10: TLabel;
    Label11: TLabel;
    dbeCodOpe: TDBEditFocus;
    Bevel1: TBevel;
    edtDesOpe: TEditFocus;
    edtEstado: TEditFocus;
    dbgBairrosDBTableView: TcxGridDBTableView;
    dbgBairrosLevel: TcxGridLevel;
    dbgBairros: TcxGrid;
    dbgBairrosDBTableViewNOMCLI: TcxGridDBColumn;
    dbgBairrosDBTableViewNOMCID: TcxGridDBColumn;
    dbgBairrosDBTableViewFONE01: TcxGridDBColumn;
    dbgBairrosDBTableViewESTADO: TcxGridDBColumn;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    dbtNomCli: TDBText;
    dbtEndere: TDBText;
    dbtBairro: TDBText;
    dbtFone01: TDBText;
    dbtNomCid: TDBText;
    dbtCep: TDBText;
    dbtFone02: TDBText;
    imgLista: TImageList;
    dbgBairrosDBTableViewMarca: TcxGridDBColumn;
    cxEditRepository1: TcxEditRepository;
    cxEditRepository1ImageComboBoxItem1: TcxEditRepositoryImageComboBoxItem;
    btnRelatorio: TBitBtnLocked;
    btnImprime: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodBaiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCacKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbgBairrosDBTableViewCustomDrawCell
      (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgBairrosDBTableViewMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure dbgBairrosDBTableViewDblClick(Sender: TObject);
    procedure dbgBairrosDBTableViewMouseLeave(Sender: TObject);
    procedure dbgBairrosDBTableViewCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    function dbeCodCidChamaCadastro(Key: Word): string;
    function dbeCodCacChamaCadastro(Key: Word): string;
    function dbeCodBaiChamaCadastro(Key: Word): string;
    procedure btnRelatorioClick(Sender: TObject);
    procedure dbgBairrosDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimeClick(Sender: TObject);
  private
    arrConsulta: TConsultasArray;
    cdsBairros: TZClient;
    stlListSelecao: TStringList;

    procedure pSetaMascaras;
    procedure pLimpaEdits;
    procedure pPreencheSugestao;
    procedure pInverter;

    function fGetSqlBairros: String;
    function fGravaBairros: Boolean;
    procedure pEnviaEmail;
    function fEnviaEmailProgress(cxProgress: TcxProgressBar): Boolean;
  Protected
    intRecNo: Integer;
    procedure pOnStateChange;override;
  public
    { Public declarations }
  Protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesGenerica, untConsultas, untFuncIns2,
  untFuncIns, untWord, untFuncoes, untGravando, untFuncoesRel2, TypesRel,
  untTEnvioEmail;

procedure TfrmCad800.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If qryTabela.RecordCount > 0 Then
  Begin
    fVerificaCampos;
    fValidaCampos(dbeCodBai, True);
  End
  Else
  Begin
    pLimpaEdits;
    cdsBairros.Close;
  End;

end;

procedure TfrmCad800.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCad800.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  If qryTabela.IsEmpty Then
  Begin
    pLimpaEdits;
    cdsBairros.Close;
  End;
end;

procedure TfrmCad800.btnGravarClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  Try

    If (qryTabela.State = dsInsert) And fEmptyStr(qryTabela.FieldByName('TEL_SEQUEN').AsString) Then
      qryTabela.FieldByName('TEL_SEQUEN').AsString := fRetSequencial('PRO800');

    inherited;

    If blnGravou and fGravaBairros Then
      fCommit
    Else
    Begin
      fRollBack;
      Exit;
    End;

    fMensagem('','Sequencial de atendimento número: ' + qryTabela.FieldByName('TEL_SEQUEN').AsString, ['&OK']);

    If FileExists(ExtractFilePath(Application.ExeName) + 'MODELO_EMAIL_TELEATENDIMENTO_0800.docx') And
      (fMensagem('', 'Deseja enviar E-Mail?', ['&Sim', '&Não'],1) = 1) Then
      pEnviaEmail;

  Except
    fRollback;
  End;

end;

function  TfrmCad800.fGravaBairros:Boolean;
  Var
    qryAuxilia : TUniQuery;
Begin
  Result := True;
  Try
    Try
      qryAuxilia := fCriaQuery;
      With qryAuxilia, SQL Do
      Begin
        If not fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
        Begin
          Close;
          Clear;
          Add(' DELETE FROM CLI800 WHERE CL8_SEQGER = :SEQGER ');
          ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
          ExecSQL;
        End;

        Close;
        Clear;
        Add(' INSERT INTO CLI800( AUTOINCREM, CL8_SEQGER, CL8_CODCLI) ');
        Add('             VALUES( :AUTOIN   ,    :SEQGER,    :CODCLI) ');


        cdsBairros.DisableControls;
        cdsBairros.First;
        cdsBairros.Filter := 'MARCA = ' + QuotedStr('S');
        cdsBairros.Filtered:= True;

        If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
          qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CAD800', VS_strCodEmp);

        While Not cdsBairros.Eof Do
        Begin
          ParamByName('AUTOIN').AsString := fRetAutoIncrem('CLI800', VS_strCodEmp);
          ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
          ParamByName('CODCLI').AsString := cdsBairros.FieldByName('CODCLI').AsString;
          ExecSQL;

          cdsBairros.Next;
        End;

      End;
    Finally
      cdsBairros.EnableControls;
      cdsBairros.Filtered:= False;
      cdsBairros.Filter := '';
      cdsBairros.First;
      FreeAndNIl(qryAuxilia);
    End;
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmCad800.fGravaBairros:Boolean');
    End;
  End;
End;

procedure TfrmCad800.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pLimpaEdits;

  If cdsBairros.Active Then
    cdsBairros.EmptyDataSet;

  qryTabela.FieldByName('TEL_CODOPE').AsString := strLoginUsuarioLogado;
  qryTabela.FieldByName('TEL_DTACAD').AsDateTime := VS_Date;
  qryTabela.FieldByName('TEL_HORCAD').AsDateTime := fNow();

  fValidaCampos(dbeCodOpe, True);

  pSetFocus(dbeFone01);
end;

procedure TfrmCad800.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
begin
  // inherited;
  chrKey := '/';
  If fPesqCadAte0800(Self, dbeSequen, Nil, qryTabela, chrKey, arrConsulta) Then
  Begin
    fVerificaCampos;
    fValidaCampos(dbeCodOpe, True);
    fValidaCampos(dbeCodBai, True);
    pSetaMascaras;
    pSetFocus(btnAlterar);
    intRecNo := -2;
  End;

end;

function TfrmCad800.dbeCodBaiChamaCadastro(Key: Word): string;
  Var
    strCodigo : String;
begin
  inherited;
  strCodigo := fChamaCadBai(Key, dbeCodCid.Text);
  If not fEmptyStr(strCodigo) Then
    dbeCodBai.Text := strCodigo;
end;

procedure TfrmCad800.dbeCodBaiKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqBairro(Self, dbeCodBai, edtDesBai, nil, Key, arrConsulta, True, dbeCodCid) then
  Begin
    If qryTabela.State in dsEditModes Then
      dbeCodBai.Field.AsString := dbeCodBai.Text;

    If fValidaCampos(dbeCodBai, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCad800.dbeCodCacChamaCadastro(Key: Word): string;
  Var
    strCodigo : String;
begin
  inherited;
  strCodigo := fChamaCadAce(Key);
  If Not fEmptyStr(strCodigo) Then
    dbeCodCac.Text := strCodigo;

end;

procedure TfrmCad800.dbeCodCacKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCanalAcesso(Self, dbeCodCac, edtDesCac, Nil, Key, arrConsulta) Then
  Begin
    if fValidaCampos(dbeCodCac, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCad800.dbeCodCidChamaCadastro(Key: Word): string;
  Var
    strCodigo : String;
begin
  inherited;
  strCodigo := fChamaCadCid(Key);
  If not fEmptyStr(strCodigo) then
    dbeCodCid.Text := strCodigo;
end;

procedure TfrmCad800.dbeCodCidKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCidade(Self, dbeCodCid, edtDesCid, edtEstado, Nil, Key, arrConsulta) Then
  Begin
    If fValidaCampos(dbeCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCad800.dbgBairrosDBTableViewCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If ACellViewInfo = Nil Then
    Exit;

  If ACellViewInfo.Item = Nil Then
    Exit;

  if intRecNo < 0 Then
    Exit;

  If (AButton = mbLeft) And (ACellViewInfo.Item.Index = dbgBairrosDBTableViewMarca.Index) Then
  Begin
    AHandled := True; //Sem isso da access Violation https://www.devexpress.com/Support/Center/Question/Details/B1681
    pInverter;
  End;


end;

procedure TfrmCad800.dbgBairrosDBTableViewCustomDrawCell
  (Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (intRecNo = AViewInfo.GridRecord.RecordIndex) then
    ACanvas.Brush.Color := clGray
  Else If Odd(AViewInfo.GridRecord.RecordIndex) Then
    ACanvas.Brush.Color := clMoneyGreen;

end;

procedure TfrmCad800.dbgBairrosDBTableViewDblClick(Sender: TObject);
begin
  inherited;
  If intRecNo < 0 Then
    Exit;

  pInverter;
end;

procedure TfrmCad800.dbgBairrosDBTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_SPACE) or (Key = VK_RETURN) Then
    pInverter;

end;

procedure TfrmCad800.dbgBairrosDBTableViewMouseLeave(Sender: TObject);
begin
  inherited;
  intRecNo := -2;
  (Sender as TcxGridSite).Repaint;
end;

procedure TfrmCad800.dbgBairrosDBTableViewMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  Site: TcxGridSite;
  HitTest: TcxCustomGridHitTest;
begin
  Site := Sender as TcxGridSite;
  HitTest := Site.GridView.ViewInfo.GetHitTest(X, Y);
  if HitTest is TcxGridRecordCellHitTest then
  begin
    If TcxGridRecordCellHitTest(HitTest).Item.Index = 0 Then
      Screen.Cursor := crHandPoint
    Else
      Screen.Cursor := crDefault;
    intRecNo := TcxGridRecordCellHitTest(HitTest).GridRecord.RecordIndex;
    Site.Repaint;
  end;

end;

function TfrmCad800.fGetSqlBairros: String;
  Var
    strMarca : String;
begin
  strMarca := '';
  strMarca := strMarca + ' IF((SELECT COUNT(0)                      ';
  strMarca := strMarca + '     FROM CLI800                          ';
  strMarca := strMarca + '     WHERE CL8_SEQGER = :SEQGER           ';
  strMarca := strMarca + '       AND BAT_CODCLI = CL8_CODCLI ) > 0, ';
  strMarca := strMarca + '     "S","N")                             ';

  Result := '';
  Result := Result + ' SELECT CONCAT(CLI_CODCLI, " - ", CLI_NOMCLI) AS NOMCLI,                                   ';
  Result := Result + '        CLI_CODCLI AS CODCLI,                                                              ';
  Result := Result + '        CONCAT(CLI_ENDERE, IF(CLI_ENDNUM <> "", CONCAT(", ", CLI_ENDNUM), ""),             ';
  Result := Result + '                           IF(CLI_ENDCOM <> "", CONCAT(" - ", CLI_ENDCOM),""))  AS ENDERE, ';
  Result := Result + '        CLI_BAIRRO AS BAIRRO,                                                              ';
  Result := Result + '        CONCAT(CID_NOMCID, " - ", CID_ESTADO) AS NOMCID,                                   ';
  Result := Result + '        CID_ESTADO AS ESTADO,                                                              ';
  Result := Result + '        CLI_FONE01 AS FONE01,                                                              ';
  Result := Result + '        CLI_FONE02 AS FONE02,                                                              ';
  Result := Result + '        CLI_C_E_P_ AS C_E_P_,                                                              ';
  Result := Result + '        ' + strMarca + ' AS MARCA                                                          ';
  Result := Result + ' FROM CLIBAT                                                                               ';
  Result := Result + '   INNER JOIN CADCLI ON CLI_CODCLI = BAT_CODCLI                                            ';
  Result := Result + '   INNER JOIN CADCID ON CID_CODCID = CLI_CODCID                                            ';
  Result := Result + ' WHERE BAT_CODBAI = :CODBAI                                                                ';
  Result := Result + ' ORDER BY CLI_NOMCLI                                                                       ';

end;

procedure TfrmCad800.FormCreate(Sender: TObject);
begin
  inherited;
  stlListSelecao    := TStringList.Create;
  intRecNo          := -2;
  strNomeTabela     := 'CAD800';
  strNomeCampo      := 'TEL_SEQUEN';
  qryTabela         := fCriaQuery(Self);
  dtsCad800.DataSet := qryTabela;
  blnUsaProCodigo   := False;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeSequen;
  arrCamposChave[1] := dbeCodEmp;

  cdsBairros := TZClient.Create(Self, fGetSqlBairros);
  dbgBairrosDBTableView.DataController.DataSource := cdsBairros.dtsSource;
  dbtNomCli.DataSource := cdsBairros.dtsSource;
  dbtEndere.DataSource := cdsBairros.dtsSource;
  dbtBairro.DataSource := cdsBairros.dtsSource;
  dbtFone01.DataSource := cdsBairros.dtsSource;
  dbtFone02.DataSource := cdsBairros.dtsSource;
  dbtCep.DataSource    := cdsBairros.dtsSource;
  dbtNomCid.DataSource := cdsBairros.dtsSource;

  pConfiguraPopup(btnRelatorio);
  pConfiguraPopup(btnImprime);

end;

procedure TfrmCad800.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlListSelecao);
  FreeAndNil(cdsBairros);
  inherited;
end;

procedure TfrmCad800.FormShow(Sender: TObject);
begin
  inherited;
  pSetaMascaras;
end;

function TfrmCad800.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = dbeCodOpe) Then
    Begin
      edtDesOpe.Text := fRetNomeOperador(dbeCodOpe.Text);
    End

    Else If (Sender = dbeFone01) Then
    Begin
      if fEmptyStrEspeciais(dbeFone01.Text) Then
      Begin
        Result := False;
        fMensagem('',
          'Informe o número do telefone, campo obrigatório!', ['&OK']);
      End
      Else
      Begin
        if blnBuscaPorChave Then
          TDBEditFocus(Sender).Field.AsString := fAcertaMaskTel(TDBEditFocus(Sender).Text);

        if (qryTabela.State = dsInsert) And blnBuscaPorChave Then
        Begin
          pPreencheSugestao;
        End;

      End;
    End

    Else If (Sender = dbeSolici) Then
    Begin
      If fEmptyStr(dbeSolici.Text) Then
      Begin
        Result := False;
        fMensagem('', 'Informe o solicitante, campo obrigatório!', ['&OK']);
      End;

    End

    Else If (Sender = dbeEndere) Then
    Begin
      If fEmptyStr(dbeEndere.Text) Then
      Begin
        Result := False;
        fMensagem('', 'Informe o endereço, campo obrigatório!', ['&OK']);
      End;

    End

    Else If (Sender = dbeCodCid) Then
    Begin
      If fEmptyStr(dbeCodCid.Text) Then
      Begin
        Result := False;
        fMensagem('', 'Informe o código da cidade, campo obrigatório!',
          ['&OK']);
      End
      Else
      Begin
        edtDesCid.Text := fRetNomCidade(dbeCodCid.Text);
        edtEstado.Text := fRetNomCidade(dbeCodCid.Text, 1);
        If fEmptyStr(edtDesCid.Text) Then
        Begin
          Result := False;
          fMensagem('',
            'Cidade não encontrada, informe um código válido!', ['&OK']);
        End;
      End;

    End

    Else If (Sender = dbeCodBai) Then
    Begin
      If fEmptyStr(dbeCodBai.Text) Then
      Begin
        Result := False;
        fMensagem('', 'Informe o código do bairro, campo obrigatório!',
          ['&OK']);
      End
      Else
      Begin
        edtDesBai.Text := fRetNomBairro(dbeCodBai.Text, opcDescri);
        If fEmptyStr(edtDesBai.Text) Then
        Begin
          Result := False;
          fMensagem('',
            'Bairro não encontrado, informe um código válido!', ['&OK']);
        End
        Else If (fRetNomBairro(dbeCodBai.Text, opcCodCid) <>
          dbeCodCid.Text) Then
        Begin
          Result := False;
          fMensagem('', 'Este bairro não pertence a cidade informada, informe um código da cidade escolhida!', ['&OK']);
        End;

      End;

      if Result And blnBuscaPorChave Then
      Begin
        cdsBairros.Close;
        cdsBairros.qryQuery.ParamByName('CODBAI').AsString := dbeCodBai.Text;
        cdsBairros.qryQuery.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
        cdsBairros.fAbreClient(True, 'TfrmCad800.fValidaCampos');
        pSetaMascaras;
      End;

    End

    Else If (Sender = dbeMotivo) Then
    Begin
      If fEmptyStr(dbeMotivo.Text) Then
      Begin
        Result := False;
        fMensagem('', 'Informe o motivo, campo obrigatório!', ['&OK']);
      End;

    End

    Else If (Sender = dbeCodCac) Then
    Begin
      If fEmptyStr(dbeCodCac.Text) Then
      Begin
        Result := False;
        fMensagem('', 'Informe como conheceu, campo obrigatório!', ['&OK']);
      End
      Else
      Begin
        edtDesCac.Text := fRetNomCanalAcesso(dbeCodCac.Text);
        If fEmptyStr(edtDesCac.Text) Then
        Begin
          Result := False;
          fMensagem('', 'Como conheceu não encontrado, informe um código válido!', ['&OK']);
        End;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCad800.pInicializaIndices;
begin
  inherited;


end;

procedure TfrmCad800.pInverter;
begin
  if cdsBairros.Active And (cdsBairros.RecordCount > 0) Then
  Begin
    cdsBairros.Edit;
    If cdsBairros.FieldByName('MARCA').AsString = 'S' Then
      cdsBairros.FieldByName('MARCA').AsString := 'N'
    Else
      cdsBairros.FieldByName('MARCA').AsString := 'S';
    cdsBairros.Post;
  End;
end;

procedure TfrmCad800.pLimpaEdits;
begin
  edtDesOpe.Clear;
  edtDesCid.Clear;
  edtEstado.Clear;
  edtDesCac.Clear;
  edtDesBai.Clear;

end;

procedure TfrmCad800.pOnStateChange;
begin
  inherited;
  dbgBairros.Enabled := (qryTabela.State in dsEditModes);
end;

procedure TfrmCad800.pPreencheSugestao;
  Var
    qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery(Self);
  Try
    With qryConsulta, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT SQL_NO_CACHE        ');
      Add('        TEL_SOLICI,         ');
      Add('        TEL_ENDERE,         ');
      Add('        TEL_CODCID,         ');
      Add('        TEL_CODBAI,         ');
      Add('        TEL_CODCAC,         ');
      Add('        TEL_MOTIVO          ');
      Add(' FROM CAD800                ');
      Add(' WHERE TEL_FONE01 = :FONE01 ');
      Add(' ORDER BY TEL_SEQUEN DESC   ');

      ParamByName('FONE01').AsString := dbeFone01.Text;

      Open;

      If Not IsEmpty Then
      Begin
        If fEmptyStr(dbeSolici.Text) Then
          dbeSolici.Field.AsString := FieldByName('TEL_SOLICI').AsString;

        If fEmptyStr(dbeEndere.Text) Then
          dbeEndere.Field.AsString := FieldByName('TEL_ENDERE').AsString;

        If fEmptyStr(dbeCodCid.Text) Then
        Begin
          dbeCodCid.Field.AsString := FieldByName('TEL_CODCID').AsString;
          fValidaCampos(dbeCodCid, True);
        End;

        If fEmptyStr(dbeCodBai.Text) Then
        Begin
          dbeCodBai.Field.AsString := FieldByName('TEL_CODBAI').AsString;
          fValidaCampos(dbeCodBai, True);
        End;

        If fEmptyStr(dbeCodCac.Text) Then
        Begin
          dbeCodCac.Field.AsString := FieldByName('TEL_CODCAC').AsString;
          fValidaCampos(dbeCodCac, True);
        End;

        If fEmptyStr(dbeMotivo.Text) Then
          dbeMotivo.Field.AsString := FieldByName('TEL_MOTIVO').AsString;

      End;

      Close;

    End;

  Finally
    FreeAndNil(qryConsulta);
  End;

end;

procedure TfrmCad800.pSetaMascaras;
begin
  TStringField(qryTabela.FieldByName('TEL_FONE01')).EditMask := fRetMascaraFonePais;

  If cdsBairros.Active then
  Begin
    TStringField(cdsBairros.FieldByName('FONE01')).EditMask := fRetMascaraFonePais;
    TStringField(cdsBairros.FieldByName('FONE02')).EditMask := fRetMascaraFonePais;
    TStringField(cdsBairros.FieldByName('C_E_P_')).EditMask := '99999-999;0;_';
  End;
end;

procedure TfrmCad800.pEnviaEmail;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fEnviaEmailProgress;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
End;

function TfrmCad800.fEnviaEmailProgress(cxProgress : TcxProgressBar): Boolean;
  Var
    objWord : TWord;
    qryDados: TUniQuery;
    intIndex: Integer;
    strEmail: String;
    arrArquivos, arrDestinatarios: TStringArray;
Begin
  Result := True;
  Try
    frmGravando.lblGravando.Caption := 'Gerando arquivo HTML...';

    objWord := TWord.fCriarWord(Self);

    qryDados := fCriaQuery(Self);
    With qryDados, SQL Do
    Begin
      Close;
      Clear;

      Add(' SELECT TEL_SEQUEN AS SEQUEN,                   ');
      Add('        TEL_DTACAD AS DTACAD,                   ');
      Add('        TEL_HORCAD AS HORCAD,                   ');
      Add('        TEL_CODOPE AS CODOPE,                   ');
      Add('        OPE_NOMOPE AS NOMOPE,                   ');
      Add('        TEL_FONE01 AS FONE01,                   ');
      Add('        TEL_SOLICI AS SOLICI,                   ');
      Add('        TEL_ENDERE AS ENDERE,                   ');
      Add('        TEL_CODCID AS CODCID,                   ');
      Add('        CID_NOMCID AS NOMCID,                   ');
      Add('        CID_ESTADO AS ESTADO,                   ');
      Add('        TEL_CODBAI AS CODBAI,                   ');
      Add('        BAI_DESCRI AS NOMBAI,                   ');
      Add('        TEL_MOTIVO AS MOTIVO,                   ');
      Add('        TEL_CODCAC AS CODCAC,                   ');
      Add('        CAC_NOMCAC AS NOMCAC                    ');
      Add(' FROM CAD800                                    ');
      Add('   INNER JOIN CADOPE ON OPE_CODOPE = TEL_CODOPE ');
      Add('   INNER JOIN CADCID ON CID_CODCID = TEL_CODCID ');
      Add('   INNER JOIN CADBAI ON BAI_CODBAI = TEL_CODBAI ');
      Add('   INNER JOIN CADCAC ON CAC_CODCAC = TEL_CODCAC ');
      Add(' WHERE CAD800.AUTOINCREM = :AUTOIN              ');

      ParamByName('AUTOIN').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

      Open;

      TStringField(FieldByName('FONE01')).EditMask := fRetMascaraFonePais;
      TDateField(FieldByName('DTACAD')).EditMask := '99/99/9999;1;_';
      TTimeField(FieldByName('DTACAD')).EditMask := '99:99;1;_';
    End;

    If Not qryDados.IsEmpty Then
    Begin
      objWord.AbrirArquivo( ExtractFilePath(Application.ExeName) + 'MODELO_EMAIL_TELEATENDIMENTO_0800.docx' );

      For intIndex := 0 To qryDados.Fields.Count -1 Do
      Begin
        objWord.pReplace( '['+qryDados.Fields[intIndex].FieldName+']', qryDados.Fields[intIndex].AsString );
      End;

      objWord.pSaveAsHtml;
      objWord.pFechar;

      Try
        cdsBairros.DisableControls;
        cdsBairros.First;
        cdsBairros.Filter := 'MARCA = ' + QuotedStr('S');
        cdsBairros.Filtered:= True;

        frmGravando.pgbStatus.Position := 0;
        frmGravando.pgbStatus.Properties.Max := cdsBairros.RecordCount;

        While not cdsBairros.Eof Do
        Begin
          frmGravando.lblGravando.Caption := 'Enviando E-Mail... ' + IntToStr(cdsBairros.RecNo) + '/' + IntToStr(cdsBairros.RecordCount);

          strEmail := fRetEmailCliente(cdsBairros.FieldByName('CODCLI').AsString);

          If not fEmptyStr(strEmail) Then Begin
            pCriarArrayAnexosEDestinatarios(ExtractFilePath(Application.ExeName) + 'MODELO_EMAIL_TELEATENDIMENTO_0800.html',
                                            strEmail,
                                            arrDestinatarios,
                                            arrArquivos);

            TEnvioEmail.EnviarEmail(Self,
                                    strLoginUsuarioLogado,
                                    fCadEmp('NOMFAN') + ' - ATENDIMENTO 0800 - CHAMADO nº ' + qryDados.FieldByName('SEQUEN').AsString,
                                    arrDestinatarios,
                                    [],
                                    [],
                                    [],
                                    arrArquivos);
          End;
          cdsBairros.Next;

          frmGravando.pgbStatus.Position := cdsBairros.RecNo;

        End;

        fMensagem('', 'Fim do envio de e-mail', ['&OK']);

      Finally
        cdsBairros.Filtered:= False;
        cdsBairros.Filter := '';
        cdsBairros.First;
        cdsBairros.EnableControls;
      End;

    End;

  Finally
    FreeAndNil(objWord);
    FreeAndNil(qryDados);
  End;

End;

procedure TfrmCad800.btnRelatorioClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(2, 120, [116,117,118,119,120,121],
                        [],
                        [],
                        Sender);
end;

procedure TfrmCad800.btnImprimeClick(Sender: TObject);
Begin
{  Retirada a obrigatóriedade de carregar um atendimento para impressão
   Agora o cliente pode informar o numero do atendimento através da consulta.
   Caso exista algum registro carregado o sistema ira utiliza-lo para imporessão.

  If fEmptyStr(qryTabela.FieldByName('TEL_SEQUEN').AsString) Then
  Begin
    fMensagem('', 'Registro sem sequencial, grave para imprimir!', ['&OK']);
    Exit;
  End;
 }
    If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(3, 124, [124,125],
                        ['SEQUEN'],
                        [qryTabela.FieldByName('TEL_SEQUEN').AsString],
                        Sender);
end;


end.


