unit untCfgFpfAti;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, DB, Grids, DBGridCitel,
  DBGrids, StdCtrls, EditFocus, AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls,
  UniDataSetProvider, UniClientDataSet, Uni, BitBtnLockedIncrem, Provider,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient, untTypesSistema;

type
  TfrmCfgFpfAti = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    edtCodGat: TEditFocus;
    dbgAtivid: TDBGridCitel;
    btnInserir: TBitBtnLocked;
    dtsFpfAti: TDataSource;
    edtDesAti: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure dbgAtividKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodGatKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodGatExit(Sender: TObject);
  private
    FTIP_FJ: String;
    qryGpoAti: TUniQuery;
    function fAtividadeCadastrada(strCodGpa: String): Boolean;
    function fInsereAtividade(strCodGpa: String): Boolean;
    function fRemoverAtividade(strCodGpa: String): Boolean;
    procedure pCarregaGrupoDeAtividade;
  public
    { Public declarations }
    procedure pSetaTabelTip_FJ(strTip_FJ: String);
    class procedure pChamaTelaDeAmarracaoFidelidadeGrupoDeAtividade(Tipo: TTipoPessoaFideliza);
  end;

implementation

uses SysUtils, untFuncoesSimples, untPai, untConsultas;

{$R *.dfm}

procedure TfrmCfgFpfAti.FormShow(Sender: TObject);
begin
  inherited;
  dtsFpfAti.DataSet := qryGpoAti;
  pCarregaGrupoDeAtividade;
end;

procedure TfrmCfgFpfAti.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodGat);
end;

procedure TfrmCfgFpfAti.FormCreate(Sender: TObject);
begin
  inherited;
  qryGpoAti := fCriaQuery(Self);
end;

procedure TfrmCfgFpfAti.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryGpoAti);
  inherited;
end;

procedure TfrmCfgFpfAti.btnInserirClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodGat.Text) Then
  Begin
    fMensagem('ATENÇÃO!','Favor informar um grupo de atividade para a inserção!',['&OK']);
    pSetFocus(edtCodGat);
    Exit;
  End;

  If fEmptyStr(edtDesAti.Text) Then
  Begin
    fMensagem('ATENÇÃO!','Grupo de Atividade não encontrado!',['&OK']);
    pSetFocus(edtCodGat);
    Exit;
  End;

  If (fAtividadeCadastrada(edtCodGat.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','Esse grupo de atividade já está cadastrado!',['&OK']);
    pSetFocus(edtCodGat);
    Exit;
  End;

  If fInsereAtividade(edtCodGat.Text) Then
  Begin
    edtCodGat.Clear;
    edtDesAti.Clear;
    pSetFocus(edtCodGat);
    pCarregaGrupoDeAtividade;
  End
  Else
    fMensagem('ATENÇÃO!','Falha na gravação do grupo de atividade!',['&OK']);
end;

procedure TfrmCfgFpfAti.dbgAtividKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (Not qryGpoAti.IsEmpty) Then
  Begin
    If (fMensagem('ATENÇÃO!', Format('Deseja realmente excluir o grupo de atividade "%s"?', [qryGpoAti.FieldByName('GAT_DESCRI').AsString]), ['&Sim','&Não'], 2) = 1) Then
    Begin
      fRemoverAtividade(qryGpoAti.FieldByName('FID_CODGPA').AsString);
      pCarregaGrupoDeAtividade;
    End;
  End;
end;

procedure TfrmCfgFpfAti.edtCodGatExit(Sender: TObject);
begin
  inherited;
  edtDesAti.Text := fRetDescGrupoAtividade(edtCodGat.Text);
end;

procedure TfrmCfgFpfAti.edtCodGatKeyPress(Sender: TObject; var Key: Char);
  Var
    arrAtiv : TConsultasArray;
begin
  If fPesqGrupoAtividade(Self, edtCodGat, edtDesAti, Nil, Key, arrAtiv, True) Then
    pSetFocus(btnInserir);
end;

function TfrmCfgFpfAti.fAtividadeCadastrada(strCodGpa: String): Boolean;
  Var
    qryTab : TUniQuery;
begin
  qryTab := fCriaQuery(Self);
  Try
    With qryTab Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT COUNT(*) CNT ');
      SQL.Add('   FROM GPAFID ');
      SQL.Add('  WHERE FID_CODGPA = :CODGPA ');
      SQL.Add('    AND FID_CODEMP = :CODEMP ');
      SQL.Add('    AND FID_FISJUR = :TIP_FJ ');
      ParamByName('CODGPA').AsString := strCodGpa;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('TIP_FJ').AsString := FTIP_FJ;
      Open;
      Result := (FieldByName('CNT').AsInteger > 0);
      Close;
    End;
  Finally
    FreeAndNil(qryTab);
  End;
end;

function TfrmCfgFpfAti.fInsereAtividade(strCodGpa: String): Boolean;
  Var
    qryTab : TUniQuery;
begin
  qryTab := fCriaQuery(Self);
  Try
    With qryTab Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT * ');
      SQL.Add('   FROM GPAFID ');
      SQL.Add('  WHERE FALSE ');
      Open;

      Insert;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('GPAFID', VS_strCodEmp);
      FieldByName('FID_CODGPA').AsString := strCodGpa;
      FieldByName('FID_CODEMP').AsString := VS_strCodEmp;
      FieldByName('FID_FISJUR').AsString := FTIP_FJ;
      Post;

      Close;

      Result := True;
    End;
  Finally
    FreeAndNil(qryTab);
  End;
end;

function TfrmCfgFpfAti.fRemoverAtividade(strCodGpa: String): Boolean;
  Var
    qryTab : TUniQuery;
begin
  qryTab := fCriaQuery(Self);
  Try
    With qryTab Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' DELETE ');
      SQL.Add('   FROM GPAFID ');
      SQL.Add('  WHERE FID_CODGPA = :CODGPA ');
      SQL.Add('    AND FID_CODEMP = :CODEMP ');
      SQL.Add('    AND FID_FISJUR = :FISJUR ');
      ParamByName('CODGPA').AsString := strCodGpa;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('FISJUR').AsString := FTIP_FJ;
      ExecSQL;
      Result := True;
    End;
  Finally
    FreeAndNil(qryTab);
  End;
end;

procedure TfrmCfgFpfAti.pCarregaGrupoDeAtividade;
begin
  qryGpoAti.Close;
  qryGpoAti.SQL.Clear;
  qryGpoAti.SQL.Add(' SELECT FID_CODGPA, GAT_DESCRI ');
  qryGpoAti.SQL.Add('   FROM GPAFID ');
  qryGpoAti.SQL.Add('   JOIN CADGAT ON GAT_CODGAT = FID_CODGPA ');
  qryGpoAti.SQL.Add('  WHERE FID_CODEMP = :CODEMP ');
  qryGpoAti.SQL.Add('    AND FID_FISJUR = :FISJUR ');
  qryGpoAti.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryGpoAti.ParamByName('FISJUR').AsString := FTIP_FJ;
  qryGpoAti.Open;
end;

class procedure TfrmCfgFpfAti.pChamaTelaDeAmarracaoFidelidadeGrupoDeAtividade(Tipo: TTipoPessoaFideliza);
  Var
    frmCfgFpfAti: TfrmCfgFpfAti;
begin
  pCriarFormularios(TfrmCfgFpfAti, frmCfgFpfAti);
  Try
    Case Tipo Of
      tpfAutonomo:
      Begin
        frmCfgFpfAti.Caption := 'Regra de Fidelização de Clientes PF Autônomos - Grupo de Atividades';
        frmCfgFpfAti.pSetaTabelTip_FJ('A');
      End;
      tpfFisica:
      Begin
        frmCfgFpfAti.Caption := 'Regra de Fidelização de Clientes PF - Grupo de Atividades';
        frmCfgFpfAti.pSetaTabelTip_FJ('F');
      End;
      tpfJuridica:
      Begin
        frmCfgFpfAti.Caption := 'Regra de Fidelização de Clientes PJ - Grupo de Atividades';
        frmCfgFpfAti.pSetaTabelTip_FJ('J');
      End;
      Else
        Raise Exception.Create('Tipo Pessoa Fideliza Inválido!');
    End;
    frmCfgFpfAti.ShowModal;
  Finally
    pFreeAndNil(frmCfgFpfAti);
  End;
end;

procedure TfrmCfgFpfAti.pSetaTabelTip_FJ(strTip_FJ: String);
begin
  FTIP_FJ := strTip_FJ;
end;

end.
