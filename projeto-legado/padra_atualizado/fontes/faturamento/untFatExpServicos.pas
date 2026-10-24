unit untFatExpServicos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, UniClientDataSet,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, Grids, DBGridCitel, DBGrids, DB, EditFocus,
  Uni, StrUtils, frxClass, frxExportCSVTestabilidade, untLiberacao, untMsgLiberacao,
  untTLock;

type
  TfrmFatExpServicos = class(TfrmPai)
    pnlFundo: TPanel;
    dbgPedidos: TDBGridCitel;
    dtsPedidos: TDataSource;
    btnExpedir: TBitBtnLocked;
    lblInfo: TLabel;
    GroupBox1: TGroupBox;
    btnFiltrar: TBitBtnLocked;
    Label3: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    Label2: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lblPedSel: TLabel;
    btnVoltarItens: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure dbgPedidosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbgPedidosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnExpedirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnVoltarItensClick(Sender: TObject);
  private
    qryPedidos: TUniQuery;
    stlPedidos: TStringList;
    objLiberacao : TLiberacao;
    objLock: TLock;
    procedure pOpenPedidos(strCodEmp, strCodCli, strCodVen: String);
    procedure pExpedePedidos(cdsItensExp: TUniClientDataSet);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples, untConsultas, untFatExpServicosConferencia, untFatExpServicosDigPed,
  untFuncFat, untTypesSistema, untFatExpServicosSelItens;

{$R *.dfm}

procedure TfrmFatExpServicos.btnExpedirClick(Sender: TObject);
begin
  pCriarFormularios(TfrmFatExpServicosConferencia, frmFatExpServicosConferencia);
  Try
    frmFatExpServicosConferencia.pSetaPedidos(VS_strCodEmp, stlPedidos);

    If frmFatExpServicosConferencia.ShowModal = mrOk Then
    Begin
      pExpedePedidos(frmFatExpServicosConferencia.cdsItens);
      objLock.pDestravarTodos;
      fMensagem('', 'Pedidos '+ stlPedidos.CommaText + ' expedidos com sucesso!', ['&Ok']);
      stlPedidos.Clear;
      lblPedSel.Caption := '';
      btnExpedir.Enabled := False;
      pOpenPedidos(VS_strCodEmp, edtCodCli.Text, edtCodVen.Text);
    End
    
  Finally
    pFreeAndNil(frmFatExpServicosConferencia);
  End;
end;

procedure TfrmFatExpServicos.btnFiltrarClick(Sender: TObject);
begin
  If fVerificaCampos Then
  Begin
    pOpenPedidos(VS_strCodEmp, edtCodCli.Text, edtCodVen.Text);
  End;

end;

procedure TfrmFatExpServicos.btnVoltarItensClick(Sender: TObject);
  Var
    blnResult: Boolean;
    cdsItens: TUniClientDataSet;
    qryItens,
    qryInsert: TUniQuery;
begin
  pCriarFormularios(TfrmFatExpServicosDigPed, frmFatExpServicosDigPed);
  Try
    If frmFatExpServicosDigPed.ShowModal = mrOk Then
    Begin
      objLiberacao.Clear;
      objliberacao.objMsgLibera.pAddTexto('Retornar itens expedidos do pedido!');
      objliberacao.objMsgLibera.pAddTextoCaption('PD', frmFatExpServicosDigPed.edtNumPed.Text);

      objLiberacao.strDirAce := 'RETITEEXP';
      objLiberacao.strSenLib := fCfgSis('SEREEX');
      objLiberacao.strMsgSen := 'Permitir retornar itens expedidos do pedido!';

      If Not objLiberacao.fLibera Then
        Exit;

      // Insere itens
      qryItens := fCriaQuery;
      qryInsert := fCriaQuery;
      Try
        qryItens.SQL.Clear;
        qryItens.SQL.Add('SELECT FDO_CODEMP,');
        qryItens.SQL.Add('       FDO_CODCLI,');
        qryItens.SQL.Add('       FDO_SEQINC,');
        qryItens.SQL.Add('       FDO_CODITE,');
        qryItens.SQL.Add('       ITE_DESITE,');
        qryItens.SQL.Add('       ITE_CODUNI,');
        qryItens.SQL.Add('       SUM(FDO_QTDITE * IF(FDO_ENTSAI = "S", 1, -1)) AS QTDMAX,');
        qryItens.SQL.Add('       SUM(FDO_QTDITE * IF(FDO_ENTSAI = "S", 1, -1)) AS QTDITE ');
        qryItens.SQL.Add(' FROM FDOSEP');
        qryItens.SQL.Add('      INNER JOIN CADITE ON FDO_CODITE = ITE_CODITE');
        qryItens.SQL.Add(' WHERE FDO_CODEMP = :CODEMP');
        qryItens.SQL.Add('   AND FDO_NUMDOC = :NUMDOC');
        qryItens.SQL.Add('   AND FDO_PENDEN = 0      ');
        qryItens.SQL.Add(' GROUP BY FDO_CODITE,FDO_SEQINC');
        qryItens.SQL.Add('HAVING QTDITE > 0');

        qryItens.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryItens.ParamByName('NUMDOC').AsString := frmFatExpServicosDigPed.edtNumPed.Text;
        qryItens.Open;

        cdsItens := fCriaClientDatSet(qryItens);

        qryInsert.SQL.Add('INSERT INTO FDOSEP(');
        qryInsert.SQL.Add('  AUTOINCREM,');
        qryInsert.SQL.Add('  FDO_CODEMP,');
        qryInsert.SQL.Add('  FDO_NUMDOC,');
        qryInsert.SQL.Add('  FDO_CODCLI,');
        qryInsert.SQL.Add('  FDO_SEQINC,');
        qryInsert.SQL.Add('  FDO_CODITE,');
        qryInsert.SQL.Add('  FDO_QTDITE,');
        qryInsert.SQL.Add('  FDO_ENTSAI,');
        qryInsert.SQL.Add('  FDO_PENDEN');
        qryInsert.SQL.Add(') VALUES (  ');
        qryInsert.SQL.Add('  :AUTINC,');
        qryInsert.SQL.Add('  :CODEMP,');
        qryInsert.SQL.Add('  :NUMDOC,');
        qryInsert.SQL.Add('  :CODCLI,');
        qryInsert.SQL.Add('  :SEQINC,');
        qryInsert.SQL.Add('  :CODITE,');
        qryInsert.SQL.Add('  :QTDITE,');
        qryInsert.SQL.Add('  :ENTSAI,');
        qryInsert.SQL.Add('  :PENDEN');
        qryInsert.SQL.Add(')');

        blnResult := Not cdsItens.IsEmpty;

        If blnResult Then
        Begin
          Try
            pCriarFormularios(TfrmFatExpServicosSelItens, frmFatExpServicosSelItens);
            frmFatExpServicosSelItens.cdsItens := cdsItens;
            blnResult := frmFatExpServicosSelItens.ShowModal = mrOk;
          Except
            On E: Exception Do
            Begin
              blnResult := False;
              pMensagensErro(E.Message, '');
            End;
          End;
          pFreeAndNil(frmFatExpServicosSelItens);
        End;

        If Not blnResult Then
          cdsItens.EmptyDataSet;

        If blnResult Then
        Begin
          cdsItens.Filtered := False;
          cdsItens.Filter   := 'QTDITE > 0';
          cdsItens.Filtered := True;
          blnResult         := Not cdsItens.IsEmpty;
        End;

        While Not cdsItens.Eof Do
        Begin
          // Insere item para entrada
          qryInsert.ParamByName('AUTINC').AsString := fRetAutoIncrem('FDOSEP', vs_strCodEmp);
          qryInsert.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryInsert.ParamByName('NUMDOC').AsString := frmFatExpServicosDigPed.edtNumPed.Text;
          qryInsert.ParamByName('CODCLI').AsString := cdsItens.FieldByName('FDO_CODCLI').AsString;
          qryInsert.ParamByName('SEQINC').AsString := cdsItens.FieldByName('FDO_SEQINC').AsString;
          qryInsert.ParamByName('CODITE').AsString := cdsItens.FieldByName('FDO_CODITE').AsString;
          qryInsert.ParamByName('QTDITE').AsString := cdsItens.FieldByName('QTDITE').AsString;
          qryInsert.ParamByName('ENTSAI').AsString := 'E';
          qryInsert.ParamByName('PENDEN').AsString := '1';
          qryInsert.ExecSQL;

          cdsItens.Next;
        End;

        If blnResult Then
          fMensagem('', 'Os produtos do pedido estão prontos para conferência de entrada!', ['&Ok'])
        Else
          fMensagem('', 'Não há produtos para conferência de entrada!', ['&Ok']);

        pOpenPedidos(VS_strCodEmp, edtCodCli.Text, edtCodVen.Text);
      Finally
        FreeAndNil(cdsItens);
        FreeAndNil(qryItens);
        FreeAndNil(qryInsert);
      End;
    End;
  Finally
    pFreeAndNil(frmFatExpServicosDigPed);
  End;
end;

procedure TfrmFatExpServicos.dbgPedidosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  procedure pBColor(cl: TColor; clF: TColor = clNone);
  begin
    dbgPedidos.Canvas.Brush.Color := cl;

    If clF <> clNone Then
      dbgPedidos.Canvas.Font.Color := clF;
  End;
begin

  If stlPedidos.IndexOf(qryPedidos.FieldByName('NUMDOC').AsString) <> -1 Then
    pBColor(clBlue, clWhite)

  Else If qryPedidos.FieldByName('URGENT').AsString = 'S' Then
    pbColor(clRed, clBlack);

  dbgPedidos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFatExpServicos.dbgPedidosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  Var
    strNumPed: String;
begin
  If Key = VK_Return Then
  Begin
    strNumPed := qryPedidos.FieldByName('NUMDOC').AsString;
    If stlPedidos.IndexOf(strNumPed) <> -1 Then
    Begin
      objLock.fLock_Unlock('FATGOR' + strNumPed + qryPedidos.FieldByName('ESPDOC').AsString + VS_strCodEmp, False, False);
      stlPedidos.Delete(stlPedidos.IndexOf(strNumPed))
    End
    Else
    Begin
      objLock.fLock_Unlock('FATGOR' + strNumPed + qryPedidos.FieldByName('ESPDOC').AsString + VS_strCodEmp, True, False);
      stlPedidos.Add(strNumPed);
    End;

    lblPedSel.Caption := 'Pedidos Selecionados: '+ stlPedidos.CommaText;

    If stlPedidos.Count <= 0 Then
      lblPedSel.Caption := '';  

    btnExpedir.Enabled := stlPedidos.Count > 0;

    dbgPedidos.Refresh;
  End;
end;

procedure TfrmFatExpServicos.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodCli) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExpServicos.edtCodVenKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodVen) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatExpServicos.FormCreate(Sender: TObject);
begin
  inherited;
  qryPedidos := fCriaQuery;
  dtsPedidos.Dataset := qryPedidos;
  stlPedidos := TStringList.Create;
  objLiberacao := TLiberacao.Create;
  objLock := TLock.Create;

  qryPedidos.SQL.Add('SELECT FGO_CODEMP AS CODEMP,');
  qryPedidos.SQL.Add('       FGO_CODVEN AS CODVEN,');
  qryPedidos.SQL.Add('       FGO_DTAENT AS DTAENT,');
  qryPedidos.SQL.Add('       FGO_HORENT AS HORENT,');
  qryPedidos.SQL.Add('       FGO_NUMDOC AS NUMDOC,');
  qryPedidos.SQL.Add('       FGO_ESPDOC AS ESPDOC,');
  qryPedidos.SQL.Add('       FGO_CODEMP AS CODEMP,');
  qryPedidos.SQL.Add('       FGO_CODCLI AS CODCLI,');
  qryPedidos.SQL.Add('       CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS NOMCLI,');
  qryPedidos.SQL.Add('       FGO_VLRCON AS VLRCON,');
  qryPedidos.SQL.Add('       FGO_ENTURG AS URGENT');
  qryPedidos.SQL.Add('  FROM FATGOR');
  qryPedidos.SQL.Add('  JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM');
  qryPedidos.SQL.Add('  JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI');
  qryPedidos.SQL.Add(' WHERE FGO_CODEMP = :CODEMP');
  qryPedidos.SQL.Add('   AND IF(:CODCLI = "", "", FGO_CODCLI) = :CODCLI');
  qryPedidos.SQL.Add('   AND IF(:CODVEN = "", "", FGO_CODVEN) = :CODVEN');
  qryPedidos.SQL.Add('   AND FGO_ESPDOC = "PD"');
  qryPedidos.SQL.Add('   AND FGO_NUMDOC IN (SELECT DISTINCT NUMDOC');
  qryPedidos.SQL.Add('                        FROM (SELECT FDO_NUMDOC AS NUMDOC,');
  qryPedidos.SQL.Add('                                     SUM(FDO_QTDITE * IF(FDO_ENTSAI = "S", 1, -1)) AS QTDITE');
  qryPedidos.SQL.Add('                                FROM FDOSEP');
  qryPedidos.SQL.Add('                               WHERE FDO_PENDEN = 1');
  qryPedidos.SQL.Add('                               GROUP BY FDO_NUMDOC,');
  qryPedidos.SQL.Add('                                     FDO_CODEMP,');
  qryPedidos.SQL.Add('                                     FDO_SEQINC) TAB');
  qryPedidos.SQL.Add('                        WHERE QTDITE <> 0)');
end;

procedure TfrmFatExpServicos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryPedidos);
  FreeAndNil(stlPedidos);
  FreeAndNil(objLock);
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  inherited;
end;

procedure TfrmFatExpServicos.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  
  If Key = VK_F10 Then
  Begin
    If btnExpedir.Enabled Then
      btnExpedir.Click;
  End

  Else If Key = VK_F9 Then
  Begin
    If btnVoltarItens.Enabled Then
      btnVoltarItens.Click;
  End;
end;

procedure TfrmFatExpServicos.FormShow(Sender: TObject);
begin
  inherited;

  pOpenPedidos(VS_strCodEmp, '', '');
end;

function TfrmFatExpServicos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    strMsg: String;
begin
  Result := True;

  If Sender = edtCodCli Then
  Begin
    If fEmptyStr(edtCodCli.Text) Then
      edtNomCli.Text := 'TODOS'
    Else
    Begin
      edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

      If fEmptyStr(edtNomCli.Text) Then
        strMsg := 'Cliente não encontrado!'
    End;
  End

  Else If Sender = edtCodVen Then
  Begin
    If fEmptyStr(edtCodVen.Text) Then
      edtNomVen.Text := 'TODOS'
    Else
    Begin
      edtNomVen.Text := fRetNomeOperador(edtCodVen.Text);

      If fEmptyStr(edtNomVen.Text) Then
        strMsg := 'Vendedor não encontrado!'
    End;
  End;

  If Not fEmptyStr(strMsg) Then
  Begin
    Result := False;
    fMensagem('', strMsg, ['&Ok']);
  End;

end;

procedure TfrmFatExpServicos.pExpedePedidos(cdsItensExp: TUniClientDataSet);
  Var
    qryUpd: TUniQuery;
    qryIns: TUniQuery;
    qryLoc: TUniQuery;
begin
  qryUpd := fCriaQuery;
  qryUpd.SQL.Add('UPDATE FDOSEP');
  qryUpd.SQL.Add('   SET FDO_PENDEN = 0');
  qryUpd.SQL.Add(' WHERE FDO_CODEMP = :CODEMP');
  qryUpd.SQL.Add('   AND FDO_NUMDOC = :NUMDOC');
  qryUpd.SQL.Add('   AND FDO_SEQINC = :SEQINC');

  qryIns := fCriaQuery;
  qryIns.SQL.Add('INSERT INTO FDOSEP(');
  qryIns.SQL.Add('  AUTOINCREM,');
  qryIns.SQL.Add('  FDO_CODEMP,');
  qryIns.SQL.Add('  FDO_NUMDOC,');
  qryIns.SQL.Add('  FDO_CODCLI,');
  qryIns.SQL.Add('  FDO_SEQINC,');
  qryIns.SQL.Add('  FDO_CODITE,');
  qryIns.SQL.Add('  FDO_QTDITE,');
  qryIns.SQL.Add('  FDO_ENTSAI,');
  qryIns.SQL.Add('  FDO_PENDEN');
  qryIns.SQL.Add(') VALUES (  ');
  qryIns.SQL.Add('  :AUTINC,');
  qryIns.SQL.Add('  :CODEMP,');
  qryIns.SQL.Add('  :NUMDOC,');
  qryIns.SQL.Add('  :CODCLI,');
  qryIns.SQL.Add('  :SEQINC,');
  qryIns.SQL.Add('  :CODITE,');
  qryIns.SQL.Add('  :QTDITE,');
  qryIns.SQL.Add('  :ENTSAI,');
  qryIns.SQL.Add('  :PENDEN');
  qryIns.SQL.Add(')');

  qryLoc := fCriaQuery;
  qryLoc.SQL.Add('SELECT AUTOINCREM FROM FATDOR');
  qryLoc.SQL.Add(' WHERE FDO_NUMDOC = :NUMDOC');
  qryLoc.SQL.Add('   AND FDO_CODEMP = :CODEMP');
  qryLoc.SQL.Add('   AND FDO_CODITE = :CODITE');

  Try
    fStartTransaction;
    cdsItensExp.First;

    While Not cdsItensExp.Eof Do
    Begin
      qryUpd.ParamByName('CODEMP').AsString := cdsItensExp.FieldByName('CODEMP').AsString;
      qryUpd.ParamByName('NUMDOC').AsString := cdsItensExp.FieldByName('NUMDOC').AsString;
      qryUpd.ParamByName('SEQINC').AsInteger:= cdsItensExp.FieldByName('SEQINC').AsInteger;

      qryUpd.ExecSQL;

      If cdsItensExp.FieldByName('ENTSAI').AsString = 'E' Then
      Begin
        qryLoc.ParamByName('CODEMP').AsString := cdsItensExp.FieldByName('CODEMP').AsString;
        qryLoc.ParamByName('NUMDOC').AsString := cdsItensExp.FieldByName('NUMDOC').AsString;
        qryLoc.ParamByName('CODITE').AsInteger:= cdsItensExp.FieldByName('CODITE').AsInteger;
        qryLoc.Open;

        If Not qryLoc.IsEmpty Then
        Begin
          // A quantidade devolvida fica disponivel para saida novamente
          qryIns.ParamByName('AUTINC').AsString := fRetAutoIncrem('FDOSEP', vs_strCodEmp);
          qryIns.ParamByName('CODEMP').AsString := cdsItensExp.FieldByName('CODEMP').AsString;
          qryIns.ParamByName('NUMDOC').AsString := cdsItensExp.FieldByName('NUMDOC').AsString;
          qryIns.ParamByName('CODCLI').AsString := cdsItensExp.FieldByName('CODCLI').AsString;
          qryIns.ParamByName('SEQINC').AsInteger:= cdsItensExp.FieldByName('SEQINC').AsInteger;
          qryIns.ParamByName('CODITE').AsString := cdsItensExp.FieldByName('CODITE').AsString;
          qryIns.ParamByName('QTDITE').AsFloat  := cdsItensExp.FieldByName('QTDITE').AsFloat;
          qryIns.ParamByName('ENTSAI').AsString := 'S';
          qryIns.ParamByName('PENDEN').AsString := '1';
          qryIns.ExecSQL;
        End;
      End;

      cdsItensExp.Next;
    End;

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(qryUpd);
  FreeAndNil(qryIns);
  FreeAndNil(qryLoc);
end;

procedure TfrmFatExpServicos.pOpenPedidos(strCodEmp, strCodCli, strCodVen: String);
begin
  qryPedidos.Close;
  qryPedidos.ParamByName('CODEMP').AsString := strCodEmp;
  qryPedidos.ParamByName('CODCLI').AsString := strCodCli;
  qryPedidos.ParamByName('CODVEN').AsString := strCodVen;
  qryPedidos.Open;

  TFloatField(qryPedidos.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';
end;

end.
