unit untCadIdentificacaoImpressora;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, DB, Grids, DBGridCitel,
  DBGrids, StdCtrls,
  EditFocus, AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, UniDataSetProvider,
  UniClientDataSet, Uni, BitBtnLockedIncrem, Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, QColorLabel;

type
  TfrmCadIdentificacaoImpressora = class(TfrmPaiSimples)
    Panel1: TPanel;
    dbgIdeImp: TDBGridCitel;
    btnInserir: TBitBtnLocked;
    dtsIdeImp: TDataSource;
    Label3: TLabel;
    edtExpressao: TEditFocus;
    FlowPanel1: TFlowPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInserirClick(Sender: TObject);
    procedure dbgIdeImpKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    qryIdeImp: TUniQuery;
    procedure pCarregaExpressoes;
  protected
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, untFuncoesSimples, untPai;

{$R *.dfm}

procedure TfrmCadIdentificacaoImpressora.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaExpressoes;
  pSetFocus(edtExpressao);
end;

procedure TfrmCadIdentificacaoImpressora.pCarregaExpressoes;
begin
  qryIdeImp := fCriaQuery(Self);
  qryIdeImp.Close;
  qryIdeImp.SQL.Clear;
  qryIdeImp.SQL.Add('SELECT * FROM IDEIMP');
  qryIdeImp.Open;
  qryIdeImp.IndexFieldNames := 'IDE_EXPRES';
  dtsIdeImp.DataSet := qryIdeImp;
end;

procedure TfrmCadIdentificacaoImpressora.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryIdeImp);
  inherited;
end;

procedure TfrmCadIdentificacaoImpressora.btnInserirClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtExpressao.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'A expressão deve ser informada!', ['&O k']);
    pSetFocus(edtExpressao);
    Exit;
  End;

  If Pos('NOME_IMPRESSORA', edtExpressao.Text) <= 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'A expressão deve conter a palavra ' +
      '"NOME_IMPRESSORA" para correta identificação!', ['&O k']);
    pSetFocus(edtExpressao);
    Exit;
  End;

  If qryIdeImp.Locate('IDE_EXPRES', edtExpressao.Text, []) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa expressão já foi cadastrada!', ['&O k']);
    pSetFocus(edtExpressao);
    Exit;
  End;

  qryIdeImp.Append;
  qryIdeImp.FieldByName('AUTOINCREM').AsString :=
    fRetAutoIncrem('IDEIMP', VS_strCodEmp);
  qryIdeImp.FieldByName('IDE_EXPRES').AsString := edtExpressao.Text;
  qryIdeImp.Post;

  edtExpressao.Clear;
  pSetFocus(edtExpressao);
end;

procedure TfrmCadIdentificacaoImpressora.dbgIdeImpKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (Not qryIdeImp.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!', 'Deseja realmente excluir a expressão?',
      ['&Sim', '&Não'], 2) = 1) Then
    Begin
      fVerificaIntegridade(Self.Name, 'IDEIMP', qryIdeImp);
      qryIdeImp.Delete;
    End;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    edtExpressao.Clear;
    pSetFocus(edtExpressao);
  End;
end;

function TfrmCadIdentificacaoImpressora.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtExpressao) Then
  Begin
    If fEmptyStr(edtExpressao.Text) And (Not qryIdeImp.IsEmpty) Then
    Begin
      pSetFocus(dbgIdeImp);
      blnMudarFoco := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
