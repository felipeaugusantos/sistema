unit untPrioridadeSaidaEstoqueEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Datasnap.DBClient, UniClientDataSet, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, MemDS,
  DBAccess, Uni, System.Math, Vcl.Grids, Vcl.DBGrids;

type
  TfrmPrioridadeSaidaEstoqueEmpresa = class(TfrmPai)
    pnlEmpresaLogadaParaVenda: TPanel;
    lblCodEmp: TLabel;
    edtDesEmp: TEditFocus;
    pnlPrioridadeSaidaEstoque: TPanel;
    Label3: TLabel;
    pnlEmpresaParaSaidaDeEstoque: TPanel;
    lblEmpSai: TLabel;
    edtDesSai: TEditFocus;
    edtCodEmp: TEditFocus;
    edtEmpSai: TEditFocus;
    grdPrioridadeDBTableView: TcxGridDBTableView;
    grdPrioridadeLevel1: TcxGridLevel;
    grdPrioridade: TcxGrid;
    cdsPrioridade: TUniClientDataSet;
    dtsPrioridade: TDataSource;
    cdsPrioridadeAUTINC: TStringField;
    cdsPrioridadeCODEMP: TStringField;
    cdsPrioridadeDESEMP: TStringField;
    cdsPrioridadeEMPSAI: TStringField;
    cdsPrioridadeDESSAI: TStringField;
    cdsPrioridadeARMSAI: TStringField;
    cdsPrioridadeDESARM: TStringField;
    cdsPrioridadeORDEM: TIntegerField;
    grdPrioridadeDBTableViewAUTINC: TcxGridDBColumn;
    grdPrioridadeDBTableViewCODEMP: TcxGridDBColumn;
    grdPrioridadeDBTableViewDESEMP: TcxGridDBColumn;
    grdPrioridadeDBTableViewEMPSAI: TcxGridDBColumn;
    grdPrioridadeDBTableViewDESSAI: TcxGridDBColumn;
    grdPrioridadeDBTableViewARMSAI: TcxGridDBColumn;
    grdPrioridadeDBTableViewDESARM: TcxGridDBColumn;
    grdPrioridadeDBTableViewORDEM: TcxGridDBColumn;
    btnAdicionar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    pnlLegenda: TPanel;
    pnlBotGri: TPanel;
    btnPgDown: TSpeedButton;
    btnPgUp: TSpeedButton;
    edtItem: TEditFocus;
    lblItem: TLabel;
    pnlArmazem: TPanel;
    lblArmSai: TLabel;
    edtDesArm: TEditFocus;
    edtArmSai: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtEmpSaiKeyPress(Sender: TObject; var Key: Char);
    procedure edtArmSaiKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure grdPrioridadeDBTableViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnPgUpClick(Sender: TObject);
    procedure btnPgDownClick(Sender: TObject);
  private

    FCodigoDoItem : String;
    FTabelaTemporaria : String;
    FGravacaoEmTabelaTemporaria : Boolean;

    function fRetornaNomeTabelaEmOperacao : String;

    procedure pCriaTabelaTemp;

    procedure pAdicionaEmpresa;
    function  fRetProximaPosicaoNaOrdem : Integer;

    procedure pDeletaRegistros;
    procedure pIncluiRegistros;

    procedure pCarregaRegistros;
    procedure pCarregaRegistrosQuandoGravacaoEmTabelaTemporaria;

    procedure pValidaEmpSai;
    function fUtilizaEmpresaPrioridadeEstoque: Boolean;
    Function fValidaRegistroExistente: Boolean;
  public
    procedure pAtivarGravacaoEmTabelaTemporaria(const strTabTmp : String;
                                                const strCodIte : String;
                                                const strEmpLog : String);
  protected
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmPrioridadeSaidaEstoqueEmpresa.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  pAdicionaEmpresa;
end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.btnGravarClick(Sender: TObject);
begin
  inherited;
  pIncluiRegistros;
end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.btnPgDownClick(Sender: TObject);
begin
  inherited;
  if (cdsPrioridade.RecordCount > 1) then
  begin
    if (cdsPrioridade.RecNo < cdsPrioridade.RecordCount) then
    begin
      cdsPrioridade.Next;
      cdsPrioridade.Edit;
      cdsPrioridadeORDEM.AsInteger := cdsPrioridadeORDEM.AsInteger - 1;
      cdsPrioridade.Prior;
      cdsPrioridade.Edit;
      cdsPrioridadeORDEM.AsInteger := cdsPrioridadeORDEM.AsInteger + 1;
      cdsPrioridade.Post;
      cdsPrioridade.IndexFieldNames := 'ORDEM';
    end;
  end;
end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.btnPgUpClick(Sender: TObject);
begin
  inherited;
  if (cdsPrioridade.RecordCount > 1) then
  begin
    if (cdsPrioridade.RecNo > 1) then
    begin
      cdsPrioridade.Edit;
      cdsPrioridadeORDEM.AsInteger := cdsPrioridadeORDEM.AsInteger - 1;
      cdsPrioridade.Prior;
      cdsPrioridade.Edit;
      cdsPrioridadeORDEM.AsInteger := cdsPrioridadeORDEM.AsInteger + 1;
      cdsPrioridade.Post;
      cdsPrioridade.IndexFieldNames := 'ORDEM';
    end;
  end;
end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.edtArmSaiKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqArmazem(Self, edtArmSai, edtDesArm, nil, Key, arrSel, True, '', edtEmpSai.Text) Then
  Begin
    If fValidaCampos(edtArmSai, True) Then
      pSetFocus(btnAdicionar);
  End
  Else if key = #13 then
  begin
    If fValidaCampos(edtArmSai, True) Then
      pSetFocus(btnAdicionar);
  end;
end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
    begin
      pCarregaRegistros;
      pSetFocus(edtEmpSai);
    end;
  End
  Else if Key = #13 then
  begin
    if (Length(edtCodEmp.Text) < 3) then
    begin
      if (not fEmptyStr(edtCodEmp.Text)) then
      begin
        edtCodEmp.Text := fStrZero(edtCodEmp.Text, 3);
      end;
    end;

    If fValidaCampos(edtCodEmp) Then
    Begin
      pCarregaRegistros;
      pSetFocus(edtEmpSai);
    End;
  end;
end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.edtEmpSaiKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSai, edtDesSai, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtEmpSai) Then
    begin
      if pnlArmazem.Visible then
      begin
        pSetFocus(edtArmSai);
      end
      else
      begin
        SelectNext(ActiveControl, True, True);
      end;
    end;
  End
  Else if Key = #13 then
  begin
    pValidaEmpSai;
  end;
end;


procedure TfrmPrioridadeSaidaEstoqueEmpresa.FormCreate(Sender: TObject);
begin
  inherited;
  FGravacaoEmTabelaTemporaria := False;
  cdsPrioridade.CreateDataSet;
end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.FormShow(Sender: TObject);
begin
  inherited;
  pnlArmazem.Visible := False;
  pSetFocus(edtCodEmp);
end;

function TfrmPrioridadeSaidaEstoqueEmpresa.fRetornaNomeTabelaEmOperacao: String;
begin
  Result := IIF(FGravacaoEmTabelaTemporaria, FTabelaTemporaria, 'CADEPS');
end;

function TfrmPrioridadeSaidaEstoqueEmpresa.fRetProximaPosicaoNaOrdem: Integer;
  const
    PRIORIDADE_MAXIMA = 1;
  var
    cdsDados : TUniClientDataSet;
begin

  If cdsPrioridade.IsEmpty Then
    Exit(PRIORIDADE_MAXIMA);

  cdsDados := TUniClientDataSet.Create(Nil);

  Try

    pCloneDataSet(cdsDados, cdsPrioridade);

    Result := PRIORIDADE_MAXIMA;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin

      If (cdsDados.FieldByName('ORDEM').AsInteger > Result) Then
        Result := cdsDados.FieldByName('ORDEM').AsInteger;

      cdsDados.Next;

    End;

    Result := Result +1;

  Finally
    FreeAndNil(cdsDados);
  End;

end;

function TfrmPrioridadeSaidaEstoqueEmpresa.fUtilizaEmpresaPrioridadeEstoque: Boolean;
begin
  Result := False;
  if (fCfgSis('UPSEML', varBoolean, edtCodEmp.Text)) then
  begin
    if (fCfgSis('EMPFAT', varBoolean, edtCodEmp.Text)) then
    begin
      Result := True;
    end;
  end;
end;

function TfrmPrioridadeSaidaEstoqueEmpresa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin
    if (Sender = edtCodEmp) then
    begin
      if fEmptyStr(edtCodEmp.Text) then
      begin
        fMensagem('','Informe a empresa logada!', ['&Ok']);
        Result := False;
      end
      else
      begin
        edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

        if fEmptyStr(edtDesEmp.Text) then
        begin
          fMensagem('','Empresa não encontrada!', ['&Ok']);
          edtDesEmp.Clear;
          Result := False;
        end
        else
        begin
          if not fUtilizaEmpresaPrioridadeEstoque then
          begin
            fMensagem('','Empresa não configurada para cadastro de prioridade de estoque!', ['&Ok']);
            edtDesEmp.Clear;
            Result := False;
          end;
        end;
      end;
    end
    else
    if (Sender = edtEmpSai) then
    begin
      if fEmptyStr(edtEmpSai.Text) then
      begin
        fMensagem('','Informe a empresa de saída!', ['&Ok']);
        Result := False;
      end
      else
      begin
        edtDesSai.Text := fRetNomeEmpresa(edtEmpSai.Text);

        if fEmptyStr(edtDesSai.Text) then
        begin
          fMensagem('','Empresa não encontrada!', ['&Ok']);
          edtDesSai.Clear;
          Result := False;
        end
        else
        begin
          pnlArmazem.Visible := (fCfgSis('CTLEST', varString, edtEmpSai.Text) = '2');
        end;
      end;
    end
    else
    if (Sender = edtArmSai) then
    begin
      if pnlArmazem.Visible then
      begin
        if fEmptyStr(edtArmSai.Text) then
        begin
          fMensagem('','Informe o armazém de saída!', ['&Ok']);
          Result := False;
        end
        else
        begin
          edtDesArm.Text := fRetNomeArmazemPorEmpresa(edtArmSai.Text, edtEmpSai.Text);

          if fEmptyStr(edtDesArm.Text) then
          begin
            fMensagem('','Armazém não encontrado!', ['&Ok']);
            edtDesArm.Clear;
            Result := False;
          end;
        end;
      end;
    end;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmPrioridadeSaidaEstoqueEmpresa.fValidaRegistroExistente: Boolean;
begin
  Result := False;

  if pnlArmazem.Visible then
  begin
    if not fValidaCampos(edtArmSai, True) then
      Exit;

    if cdsPrioridade.Locate('CODEMP;EMPSAI;ARMSAI', VarArrayOf([edtCodEmp.Text, edtEmpSai.Text, edtArmSai.Text]), []) then
    begin
      fMensagem('','Empresa e armazém já inseridos anteriormente!', ['&Ok']);
      edtEmpSai.Clear;
      edtDesSai.Clear;
      edtArmSai.Clear;
      edtDesArm.Clear;
      pSetFocus(edtEmpSai);
      Exit;
    end;
  end
  else
  begin
    if cdsPrioridade.Locate('CODEMP;EMPSAI', VarArrayOf([edtCodEmp.Text, edtEmpSai.Text]), []) then
    begin
      fMensagem('','Empresa já inserida anteriormente!', ['&Ok']);
      edtEmpSai.Clear;
      edtDesEmp.Clear;
      pSetFocus(edtEmpSai);
      Exit;
    end;
  end;

  Result := True;
end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.grdPrioridadeDBTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = VK_DELETE) then
  begin
    if (cdsPrioridade.Active) then
    begin
      if (cdsPrioridade.RecordCount > 0) then
      begin
        if (cdsPrioridade.RecNo > 0) then
        begin
          if fMensagem('ATENÇÃO!', 'Deseja excluir o registro selecionado?', ['&Sim', '&Não'],2) = 1 then
          begin
            cdsPrioridade.Delete;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.pAdicionaEmpresa;
  var
    intOrdem : Integer;
begin

  if cdsPrioridade.Active then
  begin
    if not fValidaCampos(edtCodEmp, True) then
      Exit;

    if not fValidaCampos(edtEmpSai, True) then
      Exit;

    if not fValidaRegistroExistente then
      Exit;

    intOrdem := fRetProximaPosicaoNaOrdem;
    cdsPrioridade.Append;

    If Not FGravacaoEmTabelaTemporaria Then
      cdsPrioridadeAUTINC.AsString := fRetAutoIncrem('CADEPS', edtCodEmp.Text);

    cdsPrioridadeCODEMP.AsString := edtCodEmp.Text;
    cdsPrioridadeDESEMP.AsString := edtDesEmp.Text;
    cdsPrioridadeEMPSAI.AsString := edtEmpSai.Text;
    cdsPrioridadeDESSAI.AsString := edtDesSai.Text;

    if pnlArmazem.Visible then
    begin
      cdsPrioridadeARMSAI.AsString := edtArmSai.Text;
      cdsPrioridadeDESARM.AsString := edtDesArm.Text;
    end;

    cdsPrioridadeORDEM.AsInteger := intOrdem;
    cdsPrioridade.Post;

    cdsPrioridade.IndexFieldNames := 'ORDEM';

    edtEmpSai.Clear;
    edtDesSai.Clear;

    if pnlArmazem.Visible then
    begin
      edtArmSai.Clear;
      edtDesArm.Clear;
    end;

    pSetFocus(edtEmpSai);
  end;
end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.pAtivarGravacaoEmTabelaTemporaria(const strTabTmp : String;
                                                                              const strCodIte : String;
                                                                              const strEmpLog : String);
begin

  FCodigoDoItem               := strCodIte;
  FGravacaoEmTabelaTemporaria := True;
  FTabelaTemporaria           := strTabTmp;

  If Not fTabelaExiste(strTabTmp) Then
    pCriaTabelaTemp;

  pDisableEdit(edtCodEmp);
  pDisableEdit(edtDesEmp);

  lblItem.Visible := True;
  edtItem.Visible := True;

  edtItem.Text := '(' + strCodIte + ') ' + fRetNomProduto(strCodIte);

  edtCodEmp.Text := strEmpLog;
  edtDesEmp.Text := fRetFantasiaEmpresa(strEmpLog);

  pCarregaRegistrosQuandoGravacaoEmTabelaTemporaria;

end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.pCarregaRegistros;
var
  qryCarrega: TUniQuery;
begin
  qryCarrega := fCriaQuery;

  try
    cdsPrioridade.EmptyDataSet;
    qryCarrega.Close;
    qryCarrega.SQL.Clear;
    qryCarrega.SQL.Add('SELECT * FROM CADEPS');
    qryCarrega.SQL.Add('WHERE EPS_CODEMP = :CODEMP');
    qryCarrega.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryCarrega.Open;

    if not qryCarrega.IsEmpty then
    begin
      while not qryCarrega.Eof do
      begin
        cdsPrioridade.Append;
        cdsPrioridadeAUTINC.AsString := qryCarrega.FieldByName('AUTOINCREM').AsString;
        cdsPrioridadeCODEMP.AsString := qryCarrega.FieldByName('EPS_CODEMP').AsString;
        cdsPrioridadeDESEMP.AsString := fRetNomeEmpresa(qryCarrega.FieldByName('EPS_CODEMP').AsString);
        cdsPrioridadeEMPSAI.AsString := qryCarrega.FieldByName('EPS_EMPSAI').AsString;
        cdsPrioridadeDESSAI.AsString := fRetNomeEmpresa(qryCarrega.FieldByName('EPS_EMPSAI').AsString);
        cdsPrioridadeARMSAI.AsString := qryCarrega.FieldByName('EPS_ARMSAI').AsString;
        cdsPrioridadeDESARM.AsString := fRetNomeArmazemPorEmpresa(qryCarrega.FieldByName('EPS_ARMSAI').AsString, qryCarrega.FieldByName('EPS_EMPSAI').AsString);
        cdsPrioridadeORDEM.AsInteger := qryCarrega.FieldByName('EPS_ORDEM_').AsInteger;
        cdsPrioridade.Post;

        qryCarrega.Next;
      end;
      cdsPrioridade.IndexFieldNames := 'ORDEM';
    end;
  finally
    FreeAndNil(qryCarrega);
  end;
end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.pCarregaRegistrosQuandoGravacaoEmTabelaTemporaria;
var
  qryCarrega: TUniQuery;
begin

  qryCarrega := fCriaQuery;

  try

    cdsPrioridade.EmptyDataSet;

    qryCarrega.Close;
    qryCarrega.SQL.Clear;
    qryCarrega.SQL.Add('SELECT * FROM CADHIE');
    qryCarrega.SQL.Add('WHERE');
    qryCarrega.SQL.Add('  HIE_CODITE = :CODITE AND ');
    qryCarrega.SQL.Add('  HIE_EMPITE = :EMPITE AND ');
    qryCarrega.SQL.Add('  HIE_EMPLOG = :EMPLOG');
    qryCarrega.ParamByName('CODITE').AsString := FCodigoDoItem;
    qryCarrega.ParamByName('EMPITE').AsString := edtCodEmp.Text;
    qryCarrega.ParamByName('EMPLOG').AsString := edtCodEmp.Text;
    qryCarrega.Open;

    {Carrega registros já gravados em banco}
    qryCarrega.First;
    while not qryCarrega.Eof do
    begin
      cdsPrioridade.Append;
      cdsPrioridadeAUTINC.AsString := qryCarrega.FieldByName('AUTOINCREM').AsString;
      cdsPrioridadeCODEMP.AsString := qryCarrega.FieldByName('HIE_EMPITE').AsString;
      cdsPrioridadeDESEMP.AsString := fRetNomeEmpresa(qryCarrega.FieldByName('HIE_EMPITE').AsString);
      cdsPrioridadeEMPSAI.AsString := qryCarrega.FieldByName('HIE_EMPSAI').AsString;
      cdsPrioridadeDESSAI.AsString := fRetNomeEmpresa(qryCarrega.FieldByName('HIE_EMPSAI').AsString);
      cdsPrioridadeARMSAI.AsString := qryCarrega.FieldByName('HIE_ARMSAI').AsString;
      cdsPrioridadeDESARM.AsString := fRetNomeArmazemPorEmpresa(qryCarrega.FieldByName('HIE_ARMSAI').AsString, qryCarrega.FieldByName('HIE_EMPSAI').AsString);
      cdsPrioridadeORDEM.AsInteger := qryCarrega.FieldByName('HIE_ORDEM_').AsInteger;
      cdsPrioridade.Post;
      qryCarrega.Next;
    end;

    {Carrega registros ainda em tabela temporária}
    qryCarrega.Close;
    qryCarrega.SQL.Clear;
    qryCarrega.SQL.Add('SELECT * FROM ' + FTabelaTemporaria);
    qryCarrega.SQL.Add('WHERE');
    qryCarrega.SQL.Add('  AUTOINCREM = "" AND EPS_CODEMP = :CODEMP');
    qryCarrega.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryCarrega.Open;

    qryCarrega.First;
    while not qryCarrega.Eof do
    begin
      cdsPrioridade.Append;
      cdsPrioridadeAUTINC.AsString := qryCarrega.FieldByName('AUTOINCREM').AsString;
      cdsPrioridadeCODEMP.AsString := qryCarrega.FieldByName('EPS_CODEMP').AsString;
      cdsPrioridadeDESEMP.AsString := fRetNomeEmpresa(qryCarrega.FieldByName('EPS_CODEMP').AsString);
      cdsPrioridadeEMPSAI.AsString := qryCarrega.FieldByName('EPS_EMPSAI').AsString;
      cdsPrioridadeDESSAI.AsString := fRetNomeEmpresa(qryCarrega.FieldByName('EPS_EMPSAI').AsString);
      cdsPrioridadeARMSAI.AsString := qryCarrega.FieldByName('EPS_ARMSAI').AsString;
      cdsPrioridadeDESARM.AsString := fRetNomeArmazemPorEmpresa(qryCarrega.FieldByName('EPS_ARMSAI').AsString, qryCarrega.FieldByName('EPS_EMPSAI').AsString);
      cdsPrioridadeORDEM.AsInteger := qryCarrega.FieldByName('EPS_ORDEM_').AsInteger;
      cdsPrioridade.Post;
      qryCarrega.Next;
    end;

    cdsPrioridade.IndexFieldNames := 'ORDEM';

  finally
    FreeAndNil(qryCarrega);
  end;

end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.pCriaTabelaTemp;
var
  strSQL: String;
begin

  Try
    strSQL := '';
    strSQL := strSQL + ' CREATE TABLE ' + FTabelaTemporaria + ' ( ';
    strSQL := strSQL + '   AUTOINCREM varchar(20) NOT NULL,       ';
    strSQL := strSQL + '   EPS_CODEMP char(3) NOT NULL,           ';
    strSQL := strSQL + '   EPS_EMPSAI char(3) NOT NULL,           ';
    strSQL := strSQL + '   EPS_ARMSAI char(3) DEFAULT NULL,       ';
    strSQL := strSQL + '   EPS_ORDEM_ int(11) DEFAULT NULL,       ';
    strSQL := strSQL + '   KEY IDX_' + FTabelaTemporaria + '_01 (EPS_CODEMP) ';
    strSQL := strSQL + ' ) ENGINE = MEMORY DEFAULT CHARSET=LATIN1 ';

    fExecutaSQL(strSQL);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriaTabelaTemp]');
    End;
  End;

end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.pDeletaRegistros;
var
  qryDeleta: TUniQuery;
begin
  qryDeleta := fCriaQuery;

  try
    qryDeleta.Close;
    qryDeleta.SQL.Clear;
    qryDeleta.SQL.Add('DELETE FROM ' + fRetornaNomeTabelaEmOperacao);
    qryDeleta.SQL.Add('WHERE EPS_CODEMP = :CODEMP');
    qryDeleta.ParamByName('CODEMP').AsString := edtCodEmp.Text;
    qryDeleta.ExecSQL;
  finally
    FreeAndNil(qryDeleta);
  end;
end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.pIncluiRegistros;
var
  qryInsert: TUniQuery;
begin
  if (cdsPrioridade.Active) then
  begin
    qryInsert := fCriaQuery;

    try
      try
        fStartTransaction;

        pDeletaRegistros;

        if cdsPrioridade.RecordCount > 0 then
        begin
          cdsPrioridade.First;

          qryInsert.Close;
          qryInsert.SQL.Clear;
          qryInsert.SQL.Add('INSERT INTO '+fRetornaNomeTabelaEmOperacao+'(AUTOINCREM, EPS_CODEMP, EPS_EMPSAI, EPS_ARMSAI, EPS_ORDEM_)');
          qryInsert.SQL.Add('VALUES(:AUTINC, :CODEMP, :EMPSAI, :ARMSAI, :ORDEM_)');

          while not cdsPrioridade.Eof do
          begin
            qryInsert.Close;
            qryInsert.ParamByName('AUTINC').AsString  := cdsPrioridadeAUTINC.AsString;
            qryInsert.ParamByName('CODEMP').AsString  := cdsPrioridadeCODEMP.AsString;
            qryInsert.ParamByName('EMPSAI').AsString  := cdsPrioridadeEMPSAI.AsString;
            qryInsert.ParamByName('ARMSAI').AsString  := cdsPrioridadeARMSAI.AsString;
            qryInsert.ParamByName('ORDEM_').AsInteger := cdsPrioridadeORDEM.AsInteger;
            qryInsert.Execute;
            cdsPrioridade.Next;
          end;

        end;

        fCommit;

        If Not FGravacaoEmTabelaTemporaria Then
          fMensagem('','Registros ' + IIF(cdsPrioridade.RecordCount > 0, 'gravados com sucesso', 'foram excluídos') + '!', ['&Ok']);

        ModalResult := mrOk;

      except
        fMensagem('','Ocorreu um erro ao gravar os registros!', ['&Ok']);
        fRollBack;
      end;
    finally
      FreeAndNil(qryInsert);
    end;
  end;
end;

procedure TfrmPrioridadeSaidaEstoqueEmpresa.pValidaEmpSai;
begin
  if (Length(edtEmpSai.Text) < 3) then
  begin
    if (not fEmptyStr(edtEmpSai.Text)) then
    begin
      edtEmpSai.Text := fStrZero(edtEmpSai.Text, 3);
    end;
  end;

  If fValidaCampos(edtEmpSai) Then
  Begin
    if pnlArmazem.Visible then
    begin
      pSetFocus(edtArmSai);
    end
    else
    begin
      SelectNext(ActiveControl, True, True);
    end;
  End;
end;

end.
