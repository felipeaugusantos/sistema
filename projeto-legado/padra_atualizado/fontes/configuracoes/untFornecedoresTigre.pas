unit untFornecedoresTigre;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, untTypesSistema,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, UniDataSetProvider, Provider, Uni, UniClientDataSet;

type
  TfrmFornecedoresTigre = class(TfrmPaiSimples)
    Panel1: TPanel;
    Label1: TLabel;
    edtCodForTigre: TEditFocus;
    btnInserir: TBitBtnLocked;
    edtDescForTigre: TEditFocus;
    dbgForTigre: TDBGridCitel;
    dtsForTigre: TDataSource;
    procedure edtCodForTigreKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgForTigreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnInserirClick(Sender: TObject);
  private
    cdsForTigre: TUniClientDataSet;

    procedure pCarregaFornecedorTigre;
    function  fInsereFornecedorTigre(strCodForTigre: String): Boolean;
    function  fApagaForTigre(strCodForTigre, strCodEmpTigre: String): Boolean;
    function  fFornecedorTigreCadastrado(strCodForTigre, strCodEmpTigre: String): Boolean;
    { Private declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples,  untPai, untConsultas;

{$R *.dfm}

{ TfrmFornecedoresTigre }

procedure TfrmFornecedoresTigre.btnInserirClick(Sender: TObject);
begin
  inherited;
  if (not fEmptyStr(edtCodForTigre.Text)) and (not fEmptyStr(edtDescForTigre.Text)) then
  begin
    if fFornecedorTigreCadastrado(edtCodForTigre.Text,VS_strCodEmp) then
    begin
      fMensagem('ATENÇÃO!','Fornecedor já cadastrado para esta empresa!',['&O k']);
      pSetFocus(edtCodForTigre);
    end
    else
    begin
      if fInsereFornecedorTigre(edtCodForTigre.Text) then
      begin
        cdsForTigre.Append;
        cdsForTigre.FieldByName('CODEMP').AsString := VS_strCodEmp;
        cdsForTigre.FieldByName('CODFOR').AsString := edtCodForTigre.Text;
        cdsForTigre.FieldByName('NOMFOR').AsString := edtDescForTigre.Text;
        cdsForTigre.Post;
      end;
    end;
    edtCodForTigre.Clear;
    edtDescForTigre.Clear;
    pSetFocus(edtCodForTigre);
  end
  else
  begin
    fMensagem('ATENÇÃO!','Código e descrição do fornecedor deve ser preenchido!',['&O k']);
    pSetFocus(edtCodForTigre);
  end;
end;

procedure TfrmFornecedoresTigre.dbgForTigreKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key = VK_DELETE) and (not cdsForTigre.IsEmpty) then
  begin
    if (fMensagem('ATENÇÃO!','Deseja realmente excluir o registro?', ['&Sim','&Não'], 2) = 1) then
    begin
      if fApagaForTigre(cdsForTigre.FieldByName('CODFOR').AsString, cdsForTigre.FieldByName('CODEMP').AsString) then
      begin
        cdsForTigre.Delete;
      end;
    end;
  end;
end;

procedure TfrmFornecedoresTigre.edtCodForTigreKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodForTigre, edtDescForTigre, Nil, Key, arrFornec) Then
  Begin
    fValidaCampos(edtCodForTigre, True);
  End;
end;

function TfrmFornecedoresTigre.fApagaForTigre(strCodForTigre, strCodEmpTigre: String): Boolean;
Var
  strSQL: String;
  qryForTigre: TUniQuery;
begin
  Result := False;

  Try

    qryForTigre := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  FORTIG    ';
    strSQL := strSQL + 'WHERE       ';
    strSQL := strSQL + '  TIG_CODEMP = :CODEMP ';
    strSQL := strSQL + '  AND TIG_CODFOR = :CODFOR ';

    With qryForTigre Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmpTigre;
      ParamByName('CODFOR').AsString := strCodForTigre;
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFornecedoresTigre.fApagaForTigre]');
  End;

  FreeAndNil(qryForTigre);
end;

function TfrmFornecedoresTigre.fFornecedorTigreCadastrado(strCodForTigre,
  strCodEmpTigre: String): Boolean;
begin
  if cdsForTigre.Locate('CODEMP;CODFOR',VarArrayOf([strCodEmpTigre, strCodForTigre]),[]) then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

function TfrmFornecedoresTigre.fInsereFornecedorTigre(
  strCodForTigre: String): Boolean;
Var
  strSQL: String;
  qryForTigre: TUniQuery;
begin
  Result := False;

  Try

    qryForTigre := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + '  FORTIG(             ';
    strSQL := strSQL + '         TIG_CODEMP,  ';
    strSQL := strSQL + '         TIG_CODFOR,  ';
    strSQL := strSQL + '         AUTOINCREM   ';
    strSQL := strSQL + '         )            ';
    strSQL := strSQL + '  VALUES(             ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :CODFOR,     ';
    strSQL := strSQL + '         :AUTOIN      ';
    strSQL := strSQL + '         )            ';

    With qryForTigre Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODFOR').AsString := strCodForTigre;
      ParamByName('AUTOIN').AsString := fRetAutoIncrem('FORTIG', VS_strCodEmp);
      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmFornecedoresTigre.fInsereFornecedorTigre]');
  End;

  FreeAndNil(qryForTigre);
end;

procedure TfrmFornecedoresTigre.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(cdsForTigre);
  inherited;
end;

procedure TfrmFornecedoresTigre.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaFornecedorTigre;
  pSetFocus(edtCodForTigre);
end;

function TfrmFornecedoresTigre.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if Sender = edtCodForTigre then
  begin
    if (fEmptyStr(edtCodForTigre.Text)) then
    begin
      edtDescForTigre.Clear;
    end
    else
    begin
      edtDescForTigre.Text := fRetNomFornecedor(edtCodForTigre.Text);
    end;
  end;

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmFornecedoresTigre.pCarregaFornecedorTigre;
Var
  strSQL: String;
  qryForTigre: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + ' T.TIG_CODEMP AS CODEMP, ';
    strSQL := strSQL + ' T.TIG_CODFOR AS CODFOR, ';
    strSQL := strSQL +  'F.FOR_NOMFOR AS NOMFOR ';
    strSQL := strSQL + ' FROM FORTIG T ';
    strSQL := strSQL + ' INNER JOIN CADFOR F';
    strSQL := strSQL + ' ON(T.TIG_CODFOR = F.FOR_CODFOR) ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + ' T.TIG_CODEMP = :CODEMP ';

    qryForTigre  := fCriaQuery(Self);

    With qryForTigre Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      pSetaClient(qryForTigre);
    End;

    cdsForTigre := fCriaClientDatSet(qryForTigre);
    dtsForTigre.DataSet := cdsForTigre;

    FreeAndNil(qryForTigre);
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TfrmFornecedoresTigre.pCarregaFornecedorTigre]');
  End
end;

end.
