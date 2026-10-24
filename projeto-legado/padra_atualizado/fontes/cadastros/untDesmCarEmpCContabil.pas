unit untDesmCarEmpCContabil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, Grids, DBGridCitel, DBGrids, EditFocus, DB, DBClient,
  Provider, Uni, UniClientDataSet, Mask, DBCtrls,
  DBEditFocus, frxClass, frxExportCSVTestabilidade, untTypesSistema;

type
  TfrmDesmCarEmpCContabil = class(TfrmPaiCad)
    pnlDados: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    dbgCarEmp: TDBGridCitel;
    dtsEmpCar: TDataSource;
    edtCodEmp: TDBEditFocus;
    edtConcon: TDBEditFocus;
    dtsAux: TDataSource;
    edtNomEmp: TEditFocus;
    cdsAux: TUniClientDataSet;
    cdsAuxCCC_CODEMP: TStringField;
    cdsAuxEMP_NOMEMP: TStringField;
    cdsAuxCCC_CONCON: TStringField;
    cdsAuxAUTOINCREM: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbgCarEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    FCodCar: String;

    procedure pAtualizaGrid;
    procedure pLimpaCampos;
  public
    property strCodCar: String read FCodCar write FCodCar;

    procedure pInicializaIndices; override;
  end;

var
  frmDesmCarEmpCContabil: TfrmDesmCarEmpCContabil;

implementation

uses untFuncoes, untFuncoesSimples, untConsultas, untModulo;

{$R *.dfm}

procedure TfrmDesmCarEmpCContabil.btnAlterarClick(Sender: TObject);
begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add('SELECT * FROM CCCARE WHERE AUTOINCREM = :AUTOINCREM');
  qryTabela.ParamByName('AUTOINCREM').AsString := cdsAuxAUTOINCREM.AsString;
  qryTabela.Open;

  edtNomEmp.Text := fRetNomeEmpresaSelec(qryTabela.FieldByName('CCC_CODEMP').AsString);

  inherited;
  
  pSetFocus(edtCodEmp);
end;

procedure TfrmDesmCarEmpCContabil.btnCancelaClick(Sender: TObject);
begin
  If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
  Begin
    Try
      qryTabela.Cancel;
      pOnStateChange;
      pEnabled(Self, False);
      If btnIncluir.CanFocus Then
        pSetFocus(btnIncluir)

      Else If btnPesquisa.CanFocus Then
        pSetFocus(btnPesquisa);
        
      pnlInfo.Caption := '';
      pLimpaCampos;      
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'Cancelar operação');
      End;
    End;
  End;
end;

procedure TfrmDesmCarEmpCContabil.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM CCCARE WHERE AUTOINCREM = :AUTOINCREM');
    qryTabela.ParamByName('AUTOINCREM').AsString := cdsAuxAUTOINCREM.AsString;
    qryTabela.Open;

    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untDesmCarEmpCContabil.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pAtualizaGrid;
  pLimpaCampos;
end;

procedure TfrmDesmCarEmpCContabil.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    If dtsEmpCar.State in [dsInsert] Then
    Begin
      qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CCCARE', VS_strCodEmp);
      qryTabela.FieldByName('CCC_CODCAR').AsString := FCodCar;
    End;

    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untDesmCarEmpCContabil.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pAtualizaGrid;
  pSetFocus(dbgCarEmp);
end;

procedure TfrmDesmCarEmpCContabil.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pLimpaCampos;
  pSetFocus(edtCodEmp);
end;

procedure TfrmDesmCarEmpCContabil.dbgCarEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If (qryTabela.State <> dsInsert) And (Key = #13) Then
    btnAlterarClick(Sender);
end;

procedure TfrmDesmCarEmpCContabil.edtCodEmpExit(Sender: TObject);
  Var
    qryAux: TUniQuery;
    strSql: String;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    qryAux := fCriaQuery;
    Try
      strSql := 'SELECT EMP_CODEMP, EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = :CODEMP';

      qryAux.SQL.Text := strSql;
      qryAux.ParamByName('CODEMP').AsString := edtCodEmp.Text;
      qryAux.Open;

      edtCodEmp.Text := qryAux.FieldByName('EMP_CODEMP').AsString;
      edtNomEmp.Text := qryAux.FieldByName('EMP_NOMEMP').AsString;
    Finally
      qryAux.Free;
    End;
  End
  Else
    edtNomEmp.Clear;
end;

procedure TfrmDesmCarEmpCContabil.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmpresa : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
    Begin
      If fValidaCampos(edtCodEmp, False) Then
        pSetFocus(edtConCon)
      Else
        pSetFocus(edtCodEmp);
    End;
  End;
end;

procedure TfrmDesmCarEmpCContabil.FormCreate(Sender: TObject);
begin
  inherited;

  cdsAux.CreateDataSet;

  pValidaProCod('CCCARE');

  strNomeTabela := 'CCCARE';
  strNomeCampo  := 'AUTOINCREM';

  blnUsaAutInc := False;

  qryTabela := fCriarQuery('SELECT * FROM CCCARE WHERE CCC_CODCAR = :CODCAR ', Self);
  qryTabela.ParamByName('CODCAR').AsString := FCodCar;

  dtsEmpCar.DataSet := qryTabela;
end;

procedure TfrmDesmCarEmpCContabil.FormShow(Sender: TObject);
begin
  inherited;

  pAtualizaGrid;
end;

procedure TfrmDesmCarEmpCContabil.pAtualizaGrid;
  Var
    qryAuxEmp: TUniQuery;
begin
  qryAuxEmp := fCriaQuery(Nil);
  Try
    cdsAux.EmptyDataSet;

    qryAuxEmp.Close;
    qryAuxEmp.SQL.Add('SELECT EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = :CODEMP ');

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM CCCARE WHERE CCC_CODCAR = :CODCAR ORDER BY CCC_CODEMP');
    qryTabela.ParamByName('CODCAR').AsString := FCodCar;
    qryTabela.Open;

    qryTabela.First;
    While Not qryTabela.Eof Do
    Begin
      qryAuxEmp.Close;
      qryAuxEmp.ParamByName('CODEMP').AsString := qryTabela.FieldByName('CCC_CODEMP').AsString;
      qryAuxEmp.Open;

      cdsAux.Append;
      cdsAuxCCC_CODEMP.AsString := qryTabela.FieldByName('CCC_CODEMP').AsString;
      cdsAuxEMP_NOMEMP.AsString := qryAuxEmp.FieldByName('EMP_NOMEMP').AsString;
      cdsAuxCCC_CONCON.AsString := qryTabela.FieldByName('CCC_CONCON').AsString;
      cdsAuxAUTOINCREM.AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      cdsAux.Post;

      edtNomEmp.Text := qryAuxEmp.FieldByName('EMP_NOMEMP').AsString;

      Application.ProcessMessages;

      qryTabela.Next;
    End;
  Finally
    qryAuxEmp.Free;
  End;
end;

procedure TfrmDesmCarEmpCContabil.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;

  stlCampos.Add('CCC_CODCAR');
  stlCampos.Add('CCC_CODEMP');
  stlCampos.Add('CCC_CONCON');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CCC_CODCAR');
end;

procedure TfrmDesmCarEmpCContabil.pLimpaCampos;
begin
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  edtConcon.Clear;
end;

end.
