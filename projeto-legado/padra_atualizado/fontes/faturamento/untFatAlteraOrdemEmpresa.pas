unit untFatAlteraOrdemEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, MemDS, DBAccess, Uni;

type
  TfrmFatAlteraOrdemEmpresa = class(TfrmPaiEdit)
    cxgEmpresas: TcxGrid;
    cxgEmpresasView: TcxGridDBTableView;
    cxgEmpresasLevel1: TcxGridLevel;
    btnConfirmar: TBitBtnLocked;
    dtsEmpresas: TDataSource;
    cdsEmpresas: TUniClientDataSet;
    cdsEmpresasORDEM_: TIntegerField;
    cdsEmpresasCODEMP: TStringField;
    cdsEmpresasNOMEMP: TStringField;
    cxgEmpresasORDEM_: TcxGridDBColumn;
    cxgEmpresasCODEMP: TcxGridDBColumn;
    cxgEmpresasNOMEMP: TcxGridDBColumn;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgEmpresasViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function fEmpresaEstaNaOrdenacao(ACodEmp: string): Boolean;
    function fconfirmaAteracaoOrdem: Boolean;
    function fVaiAlterarOrdemEmpresa(ASobe: Boolean): Boolean;
    procedure pAlteraOrdemEmpresa(ASobe: Boolean);
  public
    stlCodEmp: TStringList;
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatAlteraOrdemEmpresa.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if fconfirmaAteracaoOrdem then
    Self.ModalResult := mrOk;
end;

procedure TfrmFatAlteraOrdemEmpresa.cxgEmpresasViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Shift = [ssCtrl] then
  begin
    case key of
      VK_UP: pAlteraOrdemEmpresa(True);
      VK_DOWN: pAlteraOrdemEmpresa(False);
    end;
  end;
end;

function TfrmFatAlteraOrdemEmpresa.fconfirmaAteracaoOrdem: Boolean;
var
  LQuery: TUniQuery;
  LSQL: string;
begin
  stlCodEmp.Clear;
  LQuery := fCriaQuery;

  try
    try
      LSQL := EmptyStr;
      LSQL := LSQL + 'SELECT EMP_CODEMP' + sLineBreak +
                     'FROM CADEMP' + sLineBreak +
                     'LEFT JOIN CONEMP ON CON_EMPDES = EMP_CODEMP AND CON_EMPORI = :EMPORI' + sLineBreak +
                     'WHERE CON_SEQTRA IS NULL' + sLineBreak +
                     'OR CON_SEQTRA <= 0' + sLineBreak +
                     'ORDER BY CON_SEQTRA';

      LQuery.Close;
      LQuery.SQL.Clear;
      LQuery.SQL.Add(LSQL);

      LQuery.ParamByName('EMPORI').AsString := VS_strCodEmp;

      LQuery.Open;

      //Adiciona as empresas que não estão ordenadas primeiro para manter o padrão de como era antes da criação desta nova tela.
      if not LQuery.IsEmpty then
      begin
        LQuery.First;
        while not LQuery.Eof do
        begin
          stlCodEmp.Add(LQuery.FieldByName('EMP_CODEMP').AsString);
          LQuery.Next;
        end;
      end;

      if not cdsEmpresas.IsEmpty then
      begin
        cdsEmpresas.DisableControls;
        try
          cdsEmpresas.First;

          while not cdsEmpresas.Eof do
          begin
            stlCodEmp.Add(cdsEmpresasCODEMP.AsString);
            cdsEmpresas.Next;
          end;
        finally
          cdsEmpresas.EnableControls;
        end;
      end;

      Result := stlCodEmp.Count > 0;
    except
      Result := False;
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

function TfrmFatAlteraOrdemEmpresa.fEmpresaEstaNaOrdenacao(
  ACodEmp: string): Boolean;
var
  LQuery: TUniQuery;
  LSQL: string;
begin
  LQuery := fCriaQuery;

  try
    try
      LSQL := EmptyStr;
      LSQL := LSQL + 'SELECT EMP_CODEMP' + sLineBreak +
                     'FROM CADEMP' + sLineBreak +
                     'LEFT JOIN CONEMP ON CON_EMPDES = EMP_CODEMP AND CON_EMPORI = :EMPORI' + sLineBreak +
                     'WHERE CON_EMPDES = :EMPSEQ' + sLineBreak +
                     'AND CON_SEQTRA IS NOT NULL' + sLineBreak +
                     'AND CON_SEQTRA > 0' + sLineBreak;

      LQuery.Close;
      LQuery.SQL.Clear;
      LQuery.SQL.Add(LSQL);

      LQuery.ParamByName('EMPORI').AsString := VS_strCodEmp;
      LQuery.ParamByName('EMPSEQ').AsString := ACodEmp;

      LQuery.Open;

      Result := Not LQuery.IsEmpty;
    except
      Result := False;
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

procedure TfrmFatAlteraOrdemEmpresa.FormCreate(Sender: TObject);
begin
  inherited;
  stlCodEmp := TStringList.Create;
  cdsEmpresas.CreateDataSet;
end;

procedure TfrmFatAlteraOrdemEmpresa.FormDestroy(Sender: TObject);
begin
  stlCodEmp.Free;
  inherited;
end;

procedure TfrmFatAlteraOrdemEmpresa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10: btnConfirmar.Click;
  End;
end;

procedure TfrmFatAlteraOrdemEmpresa.FormShow(Sender: TObject);
var
  LOrdem: integer;
  LCodEmp: string;
begin
  inherited;
  LOrdem := 0;
  cdsEmpresas.Close;
  cdsEmpresas.Open;
  cdsEmpresas.EmptyDataSet;
  cdsEmpresas.DisableControls;

  try
    for LCodEmp in stlCodEmp do
    begin
      if fEmpresaEstaNaOrdenacao(LCodEmp) then
      begin
        Inc(LOrdem);
        cdsEmpresas.Append;
        cdsEmpresasORDEM_.AsInteger := LOrdem;
        cdsEmpresasCODEMP.AsString := LCodEmp;
        cdsEmpresasNOMEMP.AsString := fRetNomeEmpresa(LCodEmp);
        cdsEmpresas.Post;
      end;
    end;

    cdsEmpresas.IndexFieldNames := 'ORDEM_';
    cdsEmpresas.First;
  finally
    cdsEmpresas.EnableControls;
  end;
end;

function TfrmFatAlteraOrdemEmpresa.fVaiAlterarOrdemEmpresa(
  ASobe: Boolean): Boolean;
begin
  Result := False;

  if cdsEmpresas.RecordCount < 2 then
    exit;

  if cdsEmpresas.RecNo < 1 then
    exit;

  if cdsEmpresasORDEM_.AsInteger = 1 then
    if ASobe then
      exit;

  if cdsEmpresasORDEM_.AsInteger = cdsEmpresas.RecordCount then
    if not ASobe then
      exit;

  Result := True;
end;

procedure TfrmFatAlteraOrdemEmpresa.pAlteraOrdemEmpresa(ASobe: Boolean);
var
  intOrdemAtual: integer;
begin
  if not fVaiAlterarOrdemEmpresa(ASobe) then
    exit;

  cdsEmpresas.DisableControls;

  try
    intOrdemAtual := cdsEmpresasORDEM_.AsInteger;

    if ASobe then
    begin
      cdsEmpresas.Prior;
      cdsEmpresas.Edit;
      cdsEmpresasORDEM_.AsInteger := Succ(cdsEmpresasORDEM_.AsInteger);
      cdsEmpresas.Post;

      if cdsEmpresas.Locate('ORDEM_', intOrdemAtual, []) then
      begin
        cdsEmpresas.Edit;
        cdsEmpresasORDEM_.AsInteger := Pred(cdsEmpresasORDEM_.AsInteger);
        cdsEmpresas.Post;
      end;

      cdsEmpresas.Next;
    end
    else
    begin
      cdsEmpresas.Next;
      cdsEmpresas.Edit;
      cdsEmpresasORDEM_.AsInteger := Pred(cdsEmpresasORDEM_.AsInteger);
      cdsEmpresas.Post;

      if cdsEmpresas.Locate('ORDEM_', intOrdemAtual, []) then
      begin
        cdsEmpresas.Edit;
        cdsEmpresasORDEM_.AsInteger := Succ(cdsEmpresasORDEM_.AsInteger);
        cdsEmpresas.Post;
      end;

      cdsEmpresas.Prior;
    end;
  finally
    cdsEmpresas.EnableControls;
  end;
end;

end.
