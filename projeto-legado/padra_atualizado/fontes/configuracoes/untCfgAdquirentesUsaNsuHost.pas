unit untCfgAdquirentesUsaNsuHost;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, EditFocus, Uni, untFuncoesSimples;

type
  TfrmCfgAdquirentesUsaNsuHost = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    btnInserir: TBitBtnLocked;
    edtAdquir: TEditFocus;
    dbgAdquirentes: TDBGridCitel;
    dtsAdqNsu: TDataSource;
    procedure btnInserirClick(Sender: TObject);
    procedure dbgAdquirentesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    qryAdqNsu: TUniQuery;
    function fAdquirenteCadastrado(strAdquir: String): Boolean;
    function fInsereAdquirente(strAdquir: String): Boolean;
    function fRemoverAdquirente(strAdquir: String): Boolean;
    procedure pCarregaAdquirente;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TfrmCfgAdquirentesUsaNsuHost }

procedure TfrmCfgAdquirentesUsaNsuHost.btnInserirClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtAdquir.Text) Then
  Begin
    fMensagem('ATENÇÃO!','Favor informar um Adquirente para a inserção!',['&OK']);
    pSetFocus(edtAdquir);
    Exit;
  End;

  If (fAdquirenteCadastrado(edtAdquir.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','Esse Adquirente já está cadastrado!',['&OK']);
    pSetFocus(edtAdquir);
    Exit;
  End;

  If fInsereAdquirente(edtAdquir.Text) Then
  Begin
    edtAdquir.Clear;
    pSetFocus(edtAdquir);
    pCarregaAdquirente;
  End
  Else
    fMensagem('ATENÇÃO!','Falha na gravação do Adquirente!',['&OK']);

end;

procedure TfrmCfgAdquirentesUsaNsuHost.dbgAdquirentesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_DELETE) And (Not qryAdqNsu.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!', Format('Deseja realmente excluir o Adquirente "%s"?', [qryAdqNsu.FieldByName('ANS_ADQUIR').AsString]), ['&Sim','&Não'], 2) = 1) Then
    Begin
      fRemoverAdquirente(qryAdqNsu.FieldByName('ANS_ADQUIR').AsString);
      pCarregaAdquirente;
    End;
  End;
end;

function TfrmCfgAdquirentesUsaNsuHost.fAdquirenteCadastrado(
  strAdquir: String): Boolean;
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
    qryTab.SQL.Add('  ADQNSU ');
    qryTab.SQL.Add('WHERE ');
    qryTab.SQL.Add('  ANS_ADQUIR = :ADQUIR ');
    qryTab.ParamByName('ADQUIR').AsString := strAdquir;
    qryTab.Open;
    Result := (qryTab.FieldByName('CNT').AsInteger > 0);
    qryTab.Close;
  Finally
    FreeAndNil(qryTab);
  End;
end;

function TfrmCfgAdquirentesUsaNsuHost.fInsereAdquirente(
  strAdquir: String): Boolean;
  Var
    qryTab : TUniQuery;
begin
  qryTab := fCriaQuery(Self);
  Try
    qryTab.Close;
    qryTab.SQL.Clear;
    qryTab.SQL.Add(' SELECT * ');
    qryTab.SQL.Add('   FROM ADQNSU ');
    qryTab.SQL.Add('  WHERE FALSE ');
    qryTab.Open;

    qryTab.Insert;
    qryTab.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ADQNSU', VS_strCodEmp);
    qryTab.FieldByName('ANS_ADQUIR').AsString := strAdquir;
    qryTab.Post;

    qryTab.Close;

    Result := True;
  Finally
    FreeAndNil(qryTab);
  End;
end;

procedure TfrmCfgAdquirentesUsaNsuHost.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtAdquir);
end;

procedure TfrmCfgAdquirentesUsaNsuHost.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fMensagem('ATENÇÃO!','Favor fechar e abrir novamente o programa para que as configurações sejam aplicadas!',['&OK']);

  inherited;

end;

procedure TfrmCfgAdquirentesUsaNsuHost.FormCreate(Sender: TObject);
begin
  inherited;
  qryAdqNsu := fCriaQuery(Self);
end;

procedure TfrmCfgAdquirentesUsaNsuHost.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryAdqNsu);
  inherited;
end;

procedure TfrmCfgAdquirentesUsaNsuHost.FormShow(Sender: TObject);
begin
  inherited;
  dtsAdqNsu.DataSet := qryAdqNsu;
  pCarregaAdquirente;
end;

function TfrmCfgAdquirentesUsaNsuHost.fRemoverAdquirente(
  strAdquir: String): Boolean;
  Var
    qryTab : TUniQuery;
begin
  qryTab := fCriaQuery(Self);
  Try
    qryTab.Close;
    qryTab.SQL.Clear;
    qryTab.SQL.Add('DELETE FROM ADQNSU ');
    qryTab.SQL.Add('WHERE ');
    qryTab.SQL.Add('  ANS_ADQUIR = :ADQUIR ');
    qryTab.ParamByName('ADQUIR').AsString := strAdquir;
    qryTab.ExecSQL;
    Result := True;
  Finally
    FreeAndNil(qryTab);
  End;
end;

procedure TfrmCfgAdquirentesUsaNsuHost.pCarregaAdquirente;
begin
  qryAdqNsu.Close;
  qryAdqNsu.SQL.Clear;
  qryAdqNsu.SQL.Add('SELECT ');
  qryAdqNsu.SQL.Add('  ANS_ADQUIR ');
  qryAdqNsu.SQL.Add('FROM ');
  qryAdqNsu.SQL.Add('  ADQNSU ');
  qryAdqNsu.SQL.Add('ORDER BY ');
  qryAdqNsu.SQL.Add('  ANS_ADQUIR ');
  qryAdqNsu.Open;
end;

end.
