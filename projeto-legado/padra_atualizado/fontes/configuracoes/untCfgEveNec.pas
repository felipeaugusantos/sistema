unit untCfgEveNec;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, EditFocus, Uni, untTypesSistema, untFuncoesSimples,
  untFrameCentroCustoEditFocus;

type
  TfrmCfgEveNec = class(TfrmPaiSimples)
    Panel1: TPanel;
    btnInserir: TBitBtnLocked;
    dbgEventos: TDBGridCitel;
    dtsEveNec: TDataSource;
    fraCentroCusto: TfraCentroCustoEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure dbgEventosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
    procedure fraCentroCustoedtCodEveKeyPress(Sender: TObject; var Key: Char);
  private
    qryEveNec: TUniQuery;
    function fEventoCadastrado(strCodEve: String): Boolean;
    function fInsereEvento(strCodEve: String): Boolean;
    function fRemoverEvento(strCodEve: String): Boolean;
    procedure pCarregaEvento;
  public
    { Public declarations }
  end;

implementation

uses
  untConsultas;

{$R *.dfm}

{ TfrmCfgEveNec }

procedure TfrmCfgEveNec.btnInserirClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
  Begin
    fMensagem('ATENÇÃO!','Favor informar um Centro de Custos para a inserção!',['&OK']);
    pSetFocus(fraCentroCusto.edtCodEve);
    Exit;
  End;

  If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
  Begin
    fMensagem('ATENÇÃO!','Centro de Custos não encontrado!',['&OK']);
    pSetFocus(fraCentroCusto.edtCodEve);
    Exit;
  End;

  If (fEventoCadastrado(fraCentroCusto.edtCodEve.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','Esse Centro de Custos já está cadastrado!',['&OK']);
    pSetFocus(fraCentroCusto.edtCodEve);
    Exit;
  End;

  If fInsereEvento(fraCentroCusto.edtCodEve.Text) Then
  Begin
    fraCentroCusto.edtCodEve.Clear;
    fraCentroCusto.edtDesEve.Clear;
    pSetFocus(fraCentroCusto.edtCodEve);
    pCarregaEvento;
  End
  Else
    fMensagem('ATENÇÃO!','Falha na gravação do Centro de Custos!',['&OK']);
end;

procedure TfrmCfgEveNec.dbgEventosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (Not qryEveNec.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!', Format('Deseja realmente excluir o Centro de Custos "%s"?', [qryEveNec.FieldByName('EVE_DESEVE').AsString]), ['&Sim','&Não'], 2) = 1) Then
    Begin
      fRemoverEvento(qryEveNec.FieldByName('ENE_CODEVE').AsString);
      pCarregaEvento;
    End;
  End;
end;

function TfrmCfgEveNec.fEventoCadastrado(strCodEve: String): Boolean;
  Var
    qryTab : TUniQuery;
begin
  qryTab := fCriaQuery(Self);
  Try
    qryTab.Close;
    qryTab.SQL.Clear;
    qryTab.SQL.Add('SELECT ');
    qryTab.SQL.Add('  COUNT(*) CNT ');
    qryTab.SQL.Add('FROM ');
    qryTab.SQL.Add('  EVENEC ');
    qryTab.SQL.Add('WHERE ');
    qryTab.SQL.Add('  ENE_CODEVE = :CODEVE ');
    qryTab.SQL.Add('  AND ENE_CODEMP = :CODEMP ');
    qryTab.ParamByName('CODEVE').AsString := strCodEve;
    qryTab.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTab.Open;
    Result := (qryTab.FieldByName('CNT').AsInteger > 0);
    qryTab.Close;
  Finally
    FreeAndNil(qryTab);
  End;
end;

function TfrmCfgEveNec.fInsereEvento(strCodEve: String): Boolean;
  Var
    qryTab : TUniQuery;
begin
  qryTab := fCriaQuery(Self);
  Try
    qryTab.Close;
    qryTab.SQL.Clear;
    qryTab.SQL.Add(' SELECT * ');
    qryTab.SQL.Add('   FROM EVENEC ');
    qryTab.SQL.Add('  WHERE FALSE ');
    qryTab.Open;

    qryTab.Insert;
    qryTab.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EVENEC', VS_strCodEmp);
    qryTab.FieldByName('ENE_CODEVE').AsString := strCodEve;
    qryTab.FieldByName('ENE_CODEMP').AsString := VS_strCodEmp;
    qryTab.Post;

    qryTab.Close;

    Result := True;
  Finally
    FreeAndNil(qryTab);
  End;
end;

procedure TfrmCfgEveNec.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(fraCentroCusto.edtCodEve);
end;

procedure TfrmCfgEveNec.FormCreate(Sender: TObject);
begin
  inherited;
  qryEveNec := fCriaQuery(Self);
end;

procedure TfrmCfgEveNec.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryEveNec);
  inherited;
end;

procedure TfrmCfgEveNec.FormShow(Sender: TObject);
begin
  inherited;
  dtsEveNec.DataSet := qryEveNec;
  pCarregaEvento;
end;

procedure TfrmCfgEveNec.fraCentroCustoedtCodEveExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);
end;

procedure TfrmCfgEveNec.fraCentroCustoedtCodEveKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fraCentroCusto.edtCodEveKeyPress(Sender, Key);

end;

function TfrmCfgEveNec.fRemoverEvento(strCodEve: String): Boolean;
  Var
    qryTab : TUniQuery;
begin
  qryTab := fCriaQuery(Self);
  Try
    qryTab.Close;
    qryTab.SQL.Clear;
    qryTab.SQL.Add('DELETE FROM EVENEC ');
    qryTab.SQL.Add('WHERE ');
    qryTab.SQL.Add('  ENE_CODEVE = :CODEVE ');
    qryTab.SQL.Add('  AND ENE_CODEMP = :CODEMP ');
    qryTab.ParamByName('CODEVE').AsString := strCodEve;
    qryTab.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTab.ExecSQL;
    Result := True;
  Finally
    FreeAndNil(qryTab);
  End;
end;

procedure TfrmCfgEveNec.pCarregaEvento;
begin
  qryEveNec.Close;
  qryEveNec.SQL.Clear;
  qryEveNec.SQL.Add('SELECT ');
  qryEveNec.SQL.Add('  ENE_CODEVE, EVE_DESEVE ');
  qryEveNec.SQL.Add('FROM ');
  qryEveNec.SQL.Add('  EVENEC ');
  qryEveNec.SQL.Add('  JOIN CADEVE ON EVE_CODEVE = ENE_CODEVE ');
  qryEveNec.SQL.Add('WHERE ');
  qryEveNec.SQL.Add('  ENE_CODEMP = :CODEMP ');
  qryEveNec.SQL.Add('ORDER BY ');
  qryEveNec.SQL.Add('  EVE_DESEVE ');
  qryEveNec.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryEveNec.Open;
end;

end.
