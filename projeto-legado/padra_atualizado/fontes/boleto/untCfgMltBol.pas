unit untCfgMltBol;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, Spin, EditFocus, DB, DBClient, Grids, DBGrids, frxClass,
  frxExportCSVTestabilidade, Uni, untTypesSistema,UniDataSetProvider,
  UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxTextEdit,
  cxClasses, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGridLevel, cxGrid;

type
  TfrmCfgMltBol = class(TfrmPai)
    Panel1: TPanel;
    Label4: TLabel;
    btnAdicionar: TBitBtnLocked;
    dtsMltBol: TDataSource;
    edtQtdDia: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnCancel: TBitBtnLocked;
    gbNF: TGroupBox;
    Label5: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    edtCodPorNF: TEditFocus;
    edtNomPorNF: TEditFocus;
    edtCodBcoNF: TEditFocus;
    edtNomBanNF: TEditFocus;
    edtCarteiNF: TEditFocus;
    gbFF: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    edtCodPorFF: TEditFocus;
    edtNomPorFF: TEditFocus;
    edtCodBcoFF: TEditFocus;
    edtNomBanFF: TEditFocus;
    edtCarteiFF: TEditFocus;
    dbgBancos: TcxGrid;
    dbgBancosLevel1: TcxGridLevel;
    dbgBancosDBTableView1: TcxGridDBTableView;
    dbgBancosDBTableView1CODPOR: TcxGridDBColumn;
    dbgBancosDBTableView1DESPOR: TcxGridDBColumn;
    dbgBancosDBTableView1CODBCO: TcxGridDBColumn;
    dbgBancosDBTableView1DESBCO: TcxGridDBColumn;
    dbgBancosDBTableView1CARTEI: TcxGridDBColumn;
    dbgBancosDBTableView1POR_FF: TcxGridDBColumn;
    dbgBancosDBTableView1PODEFF: TcxGridDBColumn;
    dbgBancosDBTableView1BCO_FF: TcxGridDBColumn;
    dbgBancosDBTableView1BCDEFF: TcxGridDBColumn;
    dbgBancosDBTableView1CAR_FF: TcxGridDBColumn;
    dbgBancosDBTableView1QTDDIA: TcxGridDBColumn;
    procedure edtCodPorNFKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorFFKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodBcoNFKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodBcoFFKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodBcoNFExit(Sender: TObject);
    procedure edtCodBcoFFExit(Sender: TObject);
    procedure dbgBancosDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgBancosDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    blnAltera : Boolean;
    cdsMltBol: TUniClientDataSet;
    intCorZeb: Integer;
    strRetBcoNF : String;
    intRetCarNF : Integer;

    strRetBcoFF : String;
    intRetCarFF : Integer;

    procedure pLimparEdits;
    function GetSql : String;
    procedure CriaTemporaria;
  public
    { Public declarations }

  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; override;
  end;

implementation

uses untFuncoesSimples, untConsultas;

{$R *.dfm}

{ TfrmCfgMltBol }

procedure TfrmCfgMltBol.btnAdicionarClick(Sender: TObject);
  Var
    LRecNo : Integer;
begin
  inherited;
  LRecNo := -1;
  Try
    If Not cdsMltBol.IsEmpty Then
      LRecNo := cdsMltBol.RecNo;

    if not fVerificaCampos Then
      Exit;

     cdsMltBol.DisableControls;

    If cdsMltBol.Locate('QTDDIA', edtQtdDia.Text, [] ) And (not blnAltera) Then
    Begin
      If (fMensagem('', 'Já existe um registro com este prazo deseja Alterá-lo?', ['&Sim', '&Não'],2) = 1) Then
        cdsMltBol.Edit
      Else
        Exit;
    End
    Else
    If blnAltera Then
      cdsMltBol.Edit
    Else
      cdsMltBol.Append;

    cdsMltBol.FieldByName('CODPOR').Value := edtCodPorNF.Text;
    cdsMltBol.FieldByName('DESPOR').Value := edtNomPorNF.Text;
    cdsMltBol.FieldByName('CODBCO').Value := edtCodBcoNF.Text;
    cdsMltBol.FieldByName('DESBCO').Value := edtNomBanNF.Text;
    cdsMltBol.FieldByName('CARTEI').Value := StrToIntDef(edtCarteiNF.Text,0);
    cdsMltBol.FieldByName('BCOINI').Value := strRetBcoNF;

    cdsMltBol.FieldByName('POR_FF').Value := edtCodPorFF.Text;
    cdsMltBol.FieldByName('PODEFF').Value := edtNomPorFF.Text;
    cdsMltBol.FieldByName('BCO_FF').Value := edtCodBcoFF.Text;
    cdsMltBol.FieldByName('BCDEFF').Value := edtNomBanFF.Text;
    cdsMltBol.FieldByName('CAR_FF').Value := StrToIntDef(edtCarteiFF.Text,0);
    cdsMltBol.FieldByName('INI_FF').Value := strRetBcoFF;

    cdsMltBol.FieldByName('QTDDIA').Value := StrToIntDef(edtQtdDia.Text,0);

    cdsMltBol.Post;

    pLimparEdits;
  Finally
    If LRecNo <> -1 Then
      cdsMltBol.RecNo := LRecNo;
    cdsMltBol.EnableControls;
  End;

end;

procedure TfrmCfgMltBol.btnCancelClick(Sender: TObject);
begin
  inherited;
  pLimparEdits;
end;

procedure TfrmCfgMltBol.btnConfirmaClick(Sender: TObject);
  Var
    qryInsert : TUniQuery;
    LRecNo : Integer;
begin
  inherited;
  LRecNo := 0;
  Try
    qryInsert := fCriaQuery(Self);
    Try
      fStartTransaction;

      qryInsert.Close;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add(' DELETE FROM CFGBOL WHERE CFB_CODEMP = :CODEMP ');
      qryInsert.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryInsert.ExecSQL;

      qryInsert.Close;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add(' INSERT INTO CFGBOL(AUTOINCREM, ');
      qryInsert.SQL.Add('                    CFB_CODPOR, ');
      qryInsert.SQL.Add('                    CFB_CODBCO, ');
      qryInsert.SQL.Add('                    CFB_POR_FF, ');
      qryInsert.SQL.Add('                    CFB_BCO_FF, ');
      qryInsert.SQL.Add('                    CFB_QTDDIA, ');
      qryInsert.SQL.Add('                    CFB_BCOINI, ');
      qryInsert.SQL.Add('                    CFB_INI_FF, ');
      qryInsert.SQL.Add('                    CFB_CARTEI, ');
      qryInsert.SQL.Add('                    CFB_CAR_FF, ');
      qryInsert.SQL.Add('                    CFB_CODEMP) ');
      qryInsert.SQL.Add('             VALUES(:AUTINC,    ');
      qryInsert.SQL.Add('                    :CODPOR,    ');
      qryInsert.SQL.Add('                    :CODBCO,    ');
      qryInsert.SQL.Add('                    :POR_FF,    ');
      qryInsert.SQL.Add('                    :BCO_FF,    ');
      qryInsert.SQL.Add('                    :QTDDIA,    ');
      qryInsert.SQL.Add('                    :BCOINI,    ');
      qryInsert.SQL.Add('                    :INI_FF,    ');
      qryInsert.SQL.Add('                    :CARTEI,    ');
      qryInsert.SQL.Add('                    :CAR_FF,    ');
      qryInsert.SQL.Add('                    :CODEMP)    ');

      cdsMltBol.DisableControls;
      LRecNo := cdsMltBol.RecNo;
      cdsMltBol.First;
      While not cdsMltBol.Eof Do
      Begin

        qryInsert.ParamByName('AUTINC').AsString  := fRetAutoIncrem('CFGBOL', vs_strCodEmp);
        qryInsert.ParamByName('CODPOR').Value     := cdsMltBol.FieldByName('CODPOR').Value;
        qryInsert.ParamByName('CODBCO').Value     := cdsMltBol.FieldByName('CODBCO').Value;
        qryInsert.ParamByName('CARTEI').Value     := cdsMltBol.FieldByName('CARTEI').Value;
        qryInsert.ParamByName('POR_FF').Value     := cdsMltBol.FieldByName('POR_FF').Value;
        qryInsert.ParamByName('BCO_FF').Value     := cdsMltBol.FieldByName('BCO_FF').Value;
        qryInsert.ParamByName('BCOINI').Value     := cdsMltBol.FieldByName('BCOINI').Value;
        qryInsert.ParamByName('INI_FF').Value     := cdsMltBol.FieldByName('INI_FF').Value;
        qryInsert.ParamByName('CAR_FF').Value     := cdsMltBol.FieldByName('CAR_FF').Value;
        qryInsert.ParamByName('QTDDIA').Value     := cdsMltBol.FieldByName('QTDDIA').Value;
        qryInsert.ParamByName('CODEMP').Value     := VS_strCodEmp;

        qryInsert.ExecSQL;

        cdsMltBol.Next;
      End;

      If fCommit Then
        ModalResult := MrOk;

    Except
      On E : Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCfgMltBol.btnConfirmaClick]');
      End;
    End;
  Finally
    cdsMltBol.RecNo := LRecNo;
    cdsMltBol.EnableControls;
    FreeAndNil(qryInsert);
  End;

end;

procedure TfrmCfgMltBol.CriaTemporaria;
  Var
    qryCarrega : TUniQuery;
    dspMltBol: TUniDataSetProvider;
begin
  Try
    cdsMltBol.Filtered := False;
    cdsMltBol.Close;
    qryCarrega := fCriaQuery(Self);
    dspMltBol:= TUniDataSetProvider.Create(Self);
    dspMltBol.DataSet := qryCarrega;
    cdsMltBol.SetProvider(dspMltBol);

    qryCarrega.Close;
    qryCarrega.SQL.Clear;
    qryCarrega.SQL.Add(GetSql);
    qryCarrega.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCarrega.Open;

    pSetaClient(qryCarrega);
    cdsMltBol.Open;
    cdsMltBol.IndexFieldNames := 'QTDDIA';
    cdsMltBol.First;

  Finally
    cdsMltBol.SetProvider(nil);
    FreeAndNil(dspMltBol);
    FreeAndNil(dspMltBol);
  End;
end;

procedure TfrmCfgMltBol.dbgBancosDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (not AViewInfo.Selected) Then
  Begin
    If Odd(AViewInfo.GridRecord.Index) Then
      ACanvas.Brush.Color := intCorZeb
    Else
      ACanvas.Brush.Color := clWindow;
  End;
end;

procedure TfrmCfgMltBol.dbgBancosDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Delete) And cdsMltBol.Active And (cdsMltBol.RecordCount > 0) And
     (fMensagem('ATENÇÃO', 'Deseja Deletar o Registro Atual?', ['&Sim', '&Não'], 2) = 1) Then
    cdsMltBol.Delete;

  If (Key = VK_Return) Then
  Begin

    edtCodPorNF.Text := cdsMltBol.FieldByName('CODPOR').AsString;
    edtNomPorNF.Text := cdsMltBol.FieldByName('DESPOR').AsString;
    edtCodBcoNF.Text := cdsMltBol.FieldByName('CODBCO').AsString;
    edtNomBanNF.Text := cdsMltBol.FieldByName('DESBCO').AsString;
    edtCarteiNF.Text := cdsMltBol.FieldByName('CARTEI').AsString;
    strRetBcoNF      := cdsMltBol.FieldByName('BCOINI').AsString;

    edtCodPorFF.Text := cdsMltBol.FieldByName('POR_FF').AsString;
    edtNomPorFF.Text := cdsMltBol.FieldByName('PODEFF').AsString;
    edtCodBcoFF.Text := cdsMltBol.FieldByName('BCO_FF').AsString;
    edtNomBanFF.Text := cdsMltBol.FieldByName('BCDEFF').AsString;
    edtCarteiFF.Text := cdsMltBol.FieldByName('CAR_FF').AsString;
    strRetBcoFF      := cdsMltBol.FieldByName('INI_FF').AsString;

    edtQtdDia.Text   := cdsMltBol.FieldByName('QTDDIA').AsString;

    blnAltera := True;
    pSetFocus(edtCodPorNF);
  End;

  If (Key = VK_Escape) Then
    pLimparEdits;

end;

procedure TfrmCfgMltBol.edtCodBcoFFExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodBcoFF.Text) Then
    Exit;

  strRetBcoFF := '';
  intRetCarFF := 0;

  If fVer_Banco_Carteira(edtCodBcoFF.Text,'', strRetBcoFF, intRetCarFF, True, VS_strCodEmp) Then
  Begin
    edtCarteiFF.Text := IntToStr(intRetCarFF);
  End
  Else
    pSetFocus(edtCodBcoFF);

end;

procedure TfrmCfgMltBol.edtCodBcoFFKeyPress(Sender: TObject; var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;
  If fPesqBanco(Self, edtCodBcoFF, edtNomBanFF, Nil, Key, arrBancos) Then
  Begin
    If fValidaCampos(edtCodBcoFF, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCfgMltBol.edtCodBcoNFExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodBcoNF.Text) Then
    Exit;

  If fVer_Banco_Carteira(edtCodBcoNF.Text,'', strRetBcoNF, intRetCarNF, True, VS_strCodEmp) Then
  Begin
    edtCarteiNF.Text := IntToStr(intRetCarNF);
  End
  Else
    pSetFocus(edtCodBcoNF);

end;

procedure TfrmCfgMltBol.edtCodBcoNFKeyPress(Sender: TObject; var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;
  If fPesqBanco(Self, edtCodBcoNF, edtNomBanNF, Nil, Key, arrBancos) Then
  Begin
    If fValidaCampos(edtCodBcoNF, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCfgMltBol.edtCodPorFFKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqPortador(conSimples, Self, edtCodPorFF, edtNomPorFF, nil, Key, arrSel) Then
  Begin
    if fValidaCampos(edtCodPorFF, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCfgMltBol.edtCodPorNFKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqPortador(conSimples, Self, edtCodPorNF, edtNomPorNF, nil, Key, arrSel) Then
  Begin
    if fValidaCampos(edtCodPorNF, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCfgMltBol.GetSql : String;
  Var
    LSql: String;
Begin

  LSql := '';
  LSql := LSql + 'SELECT                       ';
  LSql := LSql + '  CFB_CODPOR AS CODPOR,      ';
  LSql := LSql + '  CFB_CODBCO AS CODBCO,      ';
  LSql := LSql + '  CFB_CARTEI AS CARTEI,      ';
  LSql := LSql + '  CFB_POR_FF AS POR_FF,      ';
  LSql := LSql + '  CFB_BCO_FF AS BCO_FF,      ';
  LSql := LSql + '  CFB_CAR_FF AS CAR_FF,      ';
  LSql := LSql + '  CFB_QTDDIA AS QTDDIA,      ';
  LSql := LSql + '  CFB_INI_FF AS INI_FF,      ';
  LSql := LSql + '  CFB_BCOINI AS BCOINI,      ';
  LSql := LSql + '  (SELECT POR_NOMPOR FROM CADPOR WHERE POR_CODPOR = CFB_CODPOR) AS DESPOR,  ';
  LSql := LSql + '  (SELECT POR_NOMPOR FROM CADPOR WHERE POR_CODPOR = CFB_POR_FF) AS PODEFF,  ';
  LSql := LSql + '  (SELECT BCO_NOMBCO FROM CADBCO WHERE BCO_CODBCO = CFB_CODBCO) AS DESBCO,  ';
  LSql := LSql + '  (SELECT BCO_NOMBCO FROM CADBCO WHERE BCO_CODBCO = CFB_BCO_FF) AS BCDEFF   ';
  LSql := LSql + 'FROM                         ';
  LSql := LSql + '  CFGBOL                     ';
  LSql := LSql + 'WHERE CFB_CODEMP = :CODEMP   ';

  Result := LSql;
End;

procedure TfrmCfgMltBol.FormCreate(Sender: TObject);
begin
  inherited;
  cdsMltBol := TUniClientDataSet.Create(Self);
  dtsMltBol.DataSet := cdsMltBol;
end;

procedure TfrmCfgMltBol.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_Escape) And (not dbgBancos.Focused) Then
    Close;

end;

procedure TfrmCfgMltBol.FormShow(Sender: TObject);
begin
  inherited;

  CriaTemporaria;

  blnAltera := False;

  pLimparEdits;

  intCorZeb := fCfgSis('CORZEB', varInteger);
end;

function TfrmCfgMltBol.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin

    if (Sender = edtCodPorNF) Then
    Begin
      edtNomPorNF.Text := fRetNomPortador(edtCodPorNF.Text);

      If fEmptyStr(edtNomPorNF.Text) Then
      Begin
        fMensagem('', 'Portador não Cadastrado!', ['&OK']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtCodBcoNF) Then
    Begin
      edtNomBanNF.Text := fRetNomBanco(edtCodBcoNF.Text);

      If fEmptyStr(edtNomBanNF.Text) Then
      Begin
        fMensagem('', 'Banco não Cadastrado!', ['&OK']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtCodPorFF) And gbFF.Visible Then
    Begin
      edtNomPorFF.Text := fRetNomPortador(edtCodPorFF.Text);

      If fEmptyStr(edtNomPorFF.Text) Then
      Begin
        fMensagem('', 'Portador não Cadastrado!', ['&OK']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtCodBcoFF) And gbFF.Visible Then
    Begin
      edtNomBanFF.Text := fRetNomBanco(edtCodBcoFF.Text);

      If fEmptyStr(edtNomBanFF.Text) Then
      Begin
        fMensagem('', 'Banco não Cadastrado!', ['&OK']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtQtdDia) Then
    Begin
      Result := fValidaEscala(edtQtdDia.Text, 0, 999999);
    End

    Else
    If (Sender = edtCarteiNF) Then
    Begin
      Result := fValidaEscala(edtCarteiNF.Text, 1, 9);
    End

    Else
    If (Sender = edtCarteiFF) And gbFF.Visible Then
    Begin
      Result := fValidaEscala(edtCarteiFF.Text, 1, 9);
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCfgMltBol.pLimparEdits;
begin
  edtCodPorNF.Clear;
  edtNomPorNF.Clear;
  edtCodBcoNF.Clear;
  edtNomBanNF.Clear;
  edtCodPorFF.Clear;
  edtNomPorFF.Clear;
  edtCodBcoFF.Clear;
  edtNomBanFF.Clear;
  edtQtdDia.Text := '0';
  edtCarteiNF.Text := '0';
  edtCarteiFF.Text := '0';

  blnAltera := False;
  pSetFocus(edtCodPorNF);
end;


end.
