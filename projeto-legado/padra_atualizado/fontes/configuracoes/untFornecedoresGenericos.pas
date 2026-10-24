unit untFornecedoresGenericos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, untTypesSistema,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, UniDataSetProvider, Provider, Uni, UniClientDataSet;

type
  TfrmFornecedoresGenericos = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    edtCodFor: TEditFocus;
    btnInserir: TBitBtnLocked;
    edtDescFor: TEditFocus;
    dbgForGen: TDBGridCitel;
    dtsForGen: TDataSource;
    Panel2: TPanel;
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgForGenKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnInserirClick(Sender: TObject);
  private
    cdsForGen: TUniClientDataSet;

    procedure pCarregaFornecedoresGenericos;
    function  fInsereFornecedor(strCodFor: String): Boolean;
    function  fApagaFornecedor(strCodFor, strCodEmp: String): Boolean;
    function  fFornecedorCadastrado(strCodFor, strCodEmp: String): Boolean;
    { Private declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples,  untPai, untConsultas;

{$R *.dfm}

{ TfrmFornecedoresGenericos }

procedure TfrmFornecedoresGenericos.btnInserirClick(Sender: TObject);
begin
  inherited;
  if (not fEmptyStr(edtCodFor.Text)) and (not fEmptyStr(edtDescFor.Text)) then
  begin
    if fFornecedorCadastrado(edtCodFor.Text,VS_strCodEmp) then
    begin
      fMensagem('ATENÇÃO!','Fornecedor já cadastrado para esta empresa!',['&O k']);
      pSetFocus(edtCodFor);
    end
    else
    begin
      if fInsereFornecedor(edtCodFor.Text) then
      begin
        cdsForGen.Append;
        cdsForGen.FieldByName('CODEMP').AsString := VS_strCodEmp;
        cdsForGen.FieldByName('CODFOR').AsString := edtCodFor.Text;
        cdsForGen.FieldByName('NOMFOR').AsString := edtDescFor.Text;
        cdsForGen.Post;
      end;
    end;
    edtCodFor.Clear;
    edtDescFor.Clear;
    pSetFocus(edtCodFor);
  end
  else
  begin
    fMensagem('ATENÇÃO!','Código e descrição do fornecedor deve ser preenchido!',['&O k']);
    pSetFocus(edtCodFor);
  end;
end;

procedure TfrmFornecedoresGenericos.dbgForGenKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = VK_DELETE) and (not cdsForGen.IsEmpty) then
  begin
    if (fMensagem('ATENÇÃO!','Deseja realmente excluir o registro?', ['&Sim','&Não'], 2) = 1) then
    begin
      if fApagaFornecedor(cdsForGen.FieldByName('CODFOR').AsString, cdsForGen.FieldByName('CODEMP').AsString) then
      begin
        cdsForGen.Delete;
      end;
    end;
  end;
end;

procedure TfrmFornecedoresGenericos.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDescFor, Nil, Key, arrFornec) Then
  Begin
    fValidaCampos(edtCodFor, True);
  End;
end;

function TfrmFornecedoresGenericos.fApagaFornecedor(strCodFor, strCodEmp: String): Boolean;
Var
  strSQL: String;
  qryForGen: TUniQuery;
begin
  Result := False;

  Try

    qryForGen := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  FORGEN    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  GEN_CODEMP = :CODEMP ';
    strSQL := strSQL + '  AND GEN_CODFOR = :CODFOR ';

    With qryForGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODFOR').AsString := strCodFor;
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFornecedoresGenericos.fApagaFornecedor]');
  End;

  FreeAndNil(qryForGen);
end;

function TfrmFornecedoresGenericos.fFornecedorCadastrado(strCodFor, strCodEmp: String): Boolean;
begin
  if cdsForGen.Locate('CODEMP;CODFOR',VarArrayOf([strCodEmp, strCodFor]),[]) then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

function TfrmFornecedoresGenericos.fInsereFornecedor(strCodFor: String): Boolean;
Var
  strSQL: String;
  qryForGen: TUniQuery;
begin
  Result := False;

  Try

    qryForGen := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + '  FORGEN(             ';
    strSQL := strSQL + '         GEN_CODEMP,  ';
    strSQL := strSQL + '         GEN_CODFOR,  ';
    strSQL := strSQL + '         AUTOINCREM   ';
    strSQL := strSQL + '         )            ';
    strSQL := strSQL + '  VALUES(             ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :CODFOR,     ';
    strSQL := strSQL + '         :AUTOIN      ';
    strSQL := strSQL + '         )            ';

    With qryForGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('AUTOIN').AsString := fRetAutoIncrem('FORGEN', VS_strCodEmp);
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmFornecedoresGenericos.fInsereFornecedor]');
  End;

  FreeAndNil(qryForGen);
end;

procedure TfrmFornecedoresGenericos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(cdsForGen);
  inherited;
end;

procedure TfrmFornecedoresGenericos.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaFornecedoresGenericos;
  pSetFocus(edtCodFor);
end;

function TfrmFornecedoresGenericos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if Sender = edtCodFor then
  begin
    if (fEmptyStr(edtCodFor.Text)) then
    begin
      edtDescFor.Clear;
    end
    else
    begin
      edtDescFor.Text := fRetNomFornecedor(edtCodFor.Text);
    end;
  end;

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmFornecedoresGenericos.pCarregaFornecedoresGenericos;
Var
  strSQL: String;
  qryForGen: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + ' G.GEN_CODEMP AS CODEMP, ';
    strSQL := strSQL + ' G.GEN_CODFOR AS CODFOR, ';
    strSQL := strSQL +  'F.FOR_NOMFOR AS NOMFOR ';
    strSQL := strSQL + ' FROM FORGEN G ';
    strSQL := strSQL + ' INNER JOIN CADFOR F';
    strSQL := strSQL + ' ON(G.GEN_CODFOR = F.FOR_CODFOR) ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + ' G.GEN_CODEMP = :CODEMP ';

    qryForGen  := fCriaQuery(Self);

    With qryForGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      pSetaClient(qryForGen);
    End;

    cdsForGen := fCriaClientDatSet(qryForGen);
    dtsForGen.DataSet := cdsForGen;

    FreeAndNil(qryForGen);
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmFornecedoresGenericos.pCarregaFornecedoresGenericos]');
  End
end;

end.
