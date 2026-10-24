unit untCfgOcoFid;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, DB, Grids, DBGridCitel,
  DBGrids, StdCtrls, EditFocus, AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls,
  UniDataSetProvider, UniClientDataSet, Uni, BitBtnLockedIncrem, Provider,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmCfgOcoFid = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    edtCodOco: TEditFocus;
    dbgOcorrencia: TDBGridCitel;
    btnInserir: TBitBtnLocked;
    dtsOcoFid: TDataSource;
    edtDesOco: TEditFocus;
    procedure btnInserirClick(Sender: TObject);
    procedure dbgOcorrenciaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure edtCodOcoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodOcoExit(Sender: TObject);
  private
    qryOcoFid : TUniQuery;
    function fOcorrenciaCadastrada(strCodOco: String): Boolean;
    function fInsereOcorrencia(strCodOco: String): Boolean;
    function fRemoverOcorrencia(strCodOco: String): Boolean;
    procedure pCarregarOcorrencias;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, untFuncoesSimples, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCfgOcoFid.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodOco);
end;

procedure TfrmCfgOcoFid.FormCreate(Sender: TObject);
begin
  inherited;
  qryOcoFid := fCriaQuery(Self);
  dtsOcoFid.DataSet := qryOcoFid;
end;

procedure TfrmCfgOcoFid.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryOcoFid);
  inherited;
end;

procedure TfrmCfgOcoFid.FormShow(Sender: TObject);
begin
  inherited;
  pCarregarOcorrencias;
end;

function TfrmCfgOcoFid.fRemoverOcorrencia(strCodOco: String): Boolean;
  Var
    qryDeleta : TUniQuery;
begin
  qryDeleta := fCriaQuery(Self);
  Try
    Try
      qryDeleta.SQL.Add(' DELETE ');
      qryDeleta.SQL.Add('   FROM OCOFID ');
      qryDeleta.SQL.Add('  WHERE OCO_CODGOC = :CODCOG ');
      qryDeleta.SQL.Add('    AND OCO_CODEMP = :CODEMP ');
      qryDeleta.ParamByName('CODCOG').AsString := strCodOco;
      qryDeleta.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryDeleta.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmCfgOcoFid.fRemoverOcorrencia]');
      End;
    End;
  Finally
    FreeAndNil(qryDeleta);
  End;
end;

procedure TfrmCfgOcoFid.pCarregarOcorrencias;
begin
  qryOcoFid.Close;
  qryOcoFid.SQL.Clear;
  qryOcoFid.SQL.Add(' SELECT OCOFID.OCO_CODGOC, CADGOC.GOC_DESGOC ');
  qryOcoFid.SQL.Add('   FROM OCOFID ');
  qryOcoFid.SQL.Add('   JOIN CADGOC ON CADGOC.GOC_CODGOC = OCOFID.OCO_CODGOC ');
  qryOcoFid.SQL.Add('  WHERE OCOFID.OCO_CODEMP = ' + QuotedStr(VS_strCodEmp));
  qryOcoFid.Open;
end;

procedure TfrmCfgOcoFid.btnInserirClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodOco.Text) Then
  Begin
    fMensagem('ATENÇÃO!','Favor informar uma ocorrência para a inserção!',['&OK']);
    pSetFocus(edtCodOco);
    Exit;
  End;

  If fEmptyStr(edtDesOco.Text) Then
  Begin
    fMensagem('ATENÇÃO!','ocorrência não encontrada!',['&OK']);
    pSetFocus(edtCodOco);
    Exit;
  End;

  If (fOcorrenciaCadastrada(edtCodOco.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','Essa ocorrência já está cadastrada!',['&OK']);
    pSetFocus(edtCodOco);
    Exit;
  End;

  If fInsereOcorrencia(edtCodOco.Text) Then
  Begin
    edtCodOco.Clear;
    edtDesOco.Clear;
    pSetFocus(edtCodOco);
    pCarregarOcorrencias;
  End
  Else
    fMensagem('ATENÇÃO!','Falha na gravação da ocorrência!',['&OK']);
end;

procedure TfrmCfgOcoFid.dbgOcorrenciaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (Not qryOcoFid.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!', Format('Deseja realmente excluir a ocorrência "%s"?', [qryOcoFid.FieldByName('GOC_DESGOC').AsString]), ['&Sim','&Não'], 2) = 1) Then
    Begin
      If fRemoverOcorrencia(qryOcoFid.FieldByName('OCO_CODGOC').AsString) Then
        pCarregarOcorrencias;
    End;
  End;
end;

procedure TfrmCfgOcoFid.edtCodOcoExit(Sender: TObject);
begin
  inherited;
  edtDesOco.Text := fRetDescGoc(edtCodOco.Text);
end;

procedure TfrmCfgOcoFid.edtCodOcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrOco : TConsultasArray;
begin
  If fPesqGruposOcorrencias(Self, edtCodOco, edtDesOco, Nil, Key, arrOco, True) Then
    pSetFocus(btnInserir);
end;

function TfrmCfgOcoFid.fInsereOcorrencia(strCodOco: String): Boolean;
  Var
    qryInsert : TUniQuery;
begin
  qryInsert := fCriaQuery(Self);
  Try
    Try
      qryInsert.SQL.Text := 'SELECT * FROM OCOFID WHERE FALSE';
      qryInsert.Open;
      qryInsert.Insert;
      qryInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('OCOFID', VS_strCodEmp);
      qryInsert.FieldByName('OCO_CODEMP').AsString := VS_strCodEmp;
      qryInsert.FieldByName('OCO_CODGOC').AsString := strCodOco;
      qryInsert.Post;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[TfrmCfgOcoFid.fInsereOcorrencia]');
      End;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;
end;

function TfrmCfgOcoFid.fOcorrenciaCadastrada(strCodOco: String): Boolean;
  Var
    qryBusca : TUniQuery;
begin
  qryBusca := fCriaQuery(Self);
  Try
    qryBusca.SQL.Add('SELECT * ');
    qryBusca.SQL.Add('  FROM OCOFID ');
    qryBusca.SQL.Add(' WHERE OCO_CODGOC = :CODCOG ');
    qryBusca.SQL.Add('   AND OCO_CODEMP = :CODEMP ');
    qryBusca.ParamByName('CODCOG').AsString := strCodOco;
    qryBusca.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryBusca.Open;
    Result := (Not qryBusca.IsEmpty);
    qryBusca.Close;
  Finally
    FreeAndNil(qryBusca);
  End;
end;

end.
