unit untCfgCliAti;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, DB, Grids, DBGridCitel,
  DBGrids, StdCtrls, EditFocus, AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls,
  UniDataSetProvider, UniClientDataSet, Uni, BitBtnLockedIncrem, Provider,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient, untTCliAtiRepository;

type
  TfrmCfgCliAti = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    edtCodAti: TEditFocus;
    dbgAtivid: TDBGridCitel;
    btnInserir: TBitBtnLocked;
    dtsCliAti: TDataSource;
    edtDesAti: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure dbgAtividKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    repCliAti : TCliAtiRepository;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, untFuncoesSimples, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCfgCliAti.FormShow(Sender: TObject);
begin
  inherited;
  dtsCliAti.DataSet := repCliAti.qryCliAti;
end;

procedure TfrmCfgCliAti.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodAti);
end;

procedure TfrmCfgCliAti.FormCreate(Sender: TObject);
begin
  inherited;
  repCliAti := TCliAtiRepository.Create(True);
end;

procedure TfrmCfgCliAti.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(repCliAti);
end;

procedure TfrmCfgCliAti.btnInserirClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If fEmptyStr(edtCodAti.Text) Then
  Begin
    fMensagem('ATENÇÃO!','Favor informar uma atividade para a inserção!',['&OK']);
    pSetFocus(edtCodAti);
    Exit;
  End;

  If fEmptyStr(edtDesAti.Text) Then
  Begin
    fMensagem('ATENÇÃO!','Atividade não encontrada!',['&OK']);
    pSetFocus(edtCodAti);
    Exit;
  End;

  If (repCliAti.fAtividadeCadastrada(edtCodAti.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','Essa atividade já está cadastrada!',['&OK']);
    pSetFocus(edtCodAti);
    Exit;
  End;

  If repCliAti.fInsereAtividade(edtCodAti.Text) Then
  Begin
    edtCodAti.Clear;
    edtDesAti.Clear;
    pSetFocus(edtCodAti);
  End
  Else
    fMensagem('ATENÇÃO!','Falha na gravação da atividade!',['&OK']);
end;

procedure TfrmCfgCliAti.dbgAtividKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (Assigned(repCliAti.qryCliAti)) And (Not repCliAti.qryCliAti.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!', Format('Deseja realmente excluir a atividade "%s"?', [repCliAti.qryCliAti.FieldByName('objCadAti.ATI_DESATI').AsString]), ['&Sim','&Não'], 2) = 1) Then
      repCliAti.fRemoverAtividade(repCliAti.qryCliAti.FieldByName('ATI_CODATI').AsString);
  End;
end;

procedure TfrmCfgCliAti.edtCodAtiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrAtiv : TConsultasArray;
begin
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrAtiv, True) Then
    pSetFocus(btnInserir);
end;

function TfrmCfgCliAti.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodAti) Then
  Begin
    If (fEmptyStr(edtCodAti.Text)) Then
      edtDesAti.Clear
    Else
      edtDesAti.Text := fRetNomAtividade(edtCodAti.Text);
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
