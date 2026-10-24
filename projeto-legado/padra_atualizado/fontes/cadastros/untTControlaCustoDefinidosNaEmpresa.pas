unit untTControlaCustoDefinidosNaEmpresa;

interface
  uses System.Classes, System.SysUtils, Vcl.Controls,untTabelasDoItemEmpresaFrame, untZClient, Data.DB, Uni;


type
  TControlaCustoDefinidosNaEmpresa = class(TObject)
  private
    FDados: TZClient;
    FDataSource: TDataSource;
    frmTabelasDoItemEmpresa : TfrmTabelasDoItemEmpresaFrame;
    FCodEmp: String;
    Owner: TComponent;
    procedure pMontaSQL;
    procedure pSQLTabela(ATabela: String);
    procedure pSetCodEmp(const Value: string);
    function fTeveAlteracao: Boolean;
    procedure OnAfterPost(DataSet: TDataSet);
    procedure pReplicaSubFed_ImpFed;
    function fValoresIguais: Boolean;
    function GetTeveAlteracao: Boolean;
    procedure pPersisteDadosNoBanco;
    procedure pSetaAutoincrem;
    procedure pMontaCDSDados;
  public
    constructor Create(AOwner: TComponent; ControleContainer: TWinControl); Reintroduce;
    function fGravar(ACodEmp: String): Boolean;
    procedure pAbrirStatusEdicao(blnEditar: Boolean);
    procedure pIniciaDadosInclusao;
    property strCodEmp: string write pSetCodEmp;
    property blnTeveAlteracao: Boolean read  GetTeveAlteracao;
  end;

implementation

uses untFuncoesSimples;

{ TControlaCustoDefinidosNaEmpresa }

constructor TControlaCustoDefinidosNaEmpresa.Create(AOwner: TComponent; ControleContainer: TWinControl);
begin
  FCodemp := VS_StrCodEmp;
  Owner := AOwner;
  FDataSource := TDataSource.Create(Owner);
  pMontaCDSDados;
  frmTabelasDoItemEmpresa := TfrmTabelasDoItemEmpresaFrame.Create(Owner);
  frmTabelasDoItemEmpresa.Dock(ControleContainer, ControleContainer.BoundsRect);
  frmTabelasDoItemEmpresa.pInicializaDados(FDataSource);
end;

function TControlaCustoDefinidosNaEmpresa.fValoresIguais: Boolean;
begin
  result := True;
  If FDados.FieldByName('IMPFED_OLD').AsFloat <> FDados.FieldByName('CUS_IMPFED').AsFloat then
    Exit(False);
  If FDados.FieldByName('SUBFED_OLD').AsFloat <> FDados.FieldByName('CUS_SUBFED').AsFloat then
    Exit(False);
  If FDados.FieldByName('ICMSAI_OLD').AsFloat <> FDados.FieldByName('CUS_ICMSAI').AsFloat then
    Exit(False);
  If FDados.FieldByName('DESOPE_OLD').AsFloat <> FDados.FieldByName('CUS_DESOPE').AsFloat then
    Exit(False);
  If FDados.FieldByName('OUTVAL_OLD').AsFloat <> FDados.FieldByName('CUS_OUTVAL').AsFloat then
    Exit(False);
End;

function TControlaCustoDefinidosNaEmpresa.GetTeveAlteracao: Boolean;
begin
  Result:= fTeveAlteracao;
end;

procedure TControlaCustoDefinidosNaEmpresa.pSetaAutoincrem;
begin

  While not FDados.Eof Do
  Begin
    If FDados.FieldByname('AUTOINCREM').AsString = '' Then
    begin
      FDados.Edit;
      FDados.FieldByname('AUTOINCREM').AsString := fRetAutoIncrem('CUSEMP', VS_strCodEmp);
      FDados.post;
    End;
    FDados.Next;
  End;

End;

procedure TControlaCustoDefinidosNaEmpresa.pPersisteDadosNoBanco;
var qryComand : TUniQuery;
begin
  FDados.First;
  qryComand :=  fCriaQuery;
  qryComand.SQL.Add('REPLACE INTO CUSEMP');
  qryComand.SQL.Add('(AUTOINCREM,');
  qryComand.SQL.Add(' CUS_CODEMP,');
  qryComand.SQL.Add(' CUS_IMPFED,');
  qryComand.SQL.Add(' CUS_SUBFED,');
  qryComand.SQL.Add(' CUS_ICMSAI,');
  qryComand.SQL.Add(' CUS_DESOPE,');
  qryComand.SQL.Add(' CUS_OUTVAL,');
  qryComand.SQL.Add(' CUS_TABELA');
  qryComand.SQL.Add(') VALUES ');
  qryComand.SQL.Add('(:AUTOINCREM,');
  qryComand.SQL.Add(' :CUS_CODEMP,');
  qryComand.SQL.Add(' :CUS_IMPFED,');
  qryComand.SQL.Add(' :CUS_SUBFED,');
  qryComand.SQL.Add(' :CUS_ICMSAI,');
  qryComand.SQL.Add(' :CUS_DESOPE,');
  qryComand.SQL.Add(' :CUS_OUTVAL,');
  qryComand.SQL.Add(' :CUS_TABELA');
  qryComand.SQL.Add(')');
  While not FDados.eof do
  Begin
    qryComand.ParamByName('AUTOINCREM').Value := FDados.FieldByName('AUTOINCREM').Value;
    qryComand.ParamByName('CUS_CODEMP').Value := FCodEmp;
    qryComand.ParamByName('CUS_IMPFED').Value := FDados.FieldByName('CUS_IMPFED').Value;
    qryComand.ParamByName('CUS_SUBFED').Value := FDados.FieldByName('CUS_SUBFED').Value;
    qryComand.ParamByName('CUS_ICMSAI').Value := FDados.FieldByName('CUS_ICMSAI').Value;
    qryComand.ParamByName('CUS_DESOPE').Value := FDados.FieldByName('CUS_DESOPE').Value;
    qryComand.ParamByName('CUS_OUTVAL').Value := FDados.FieldByName('CUS_OUTVAL').Value;
    qryComand.ParamByName('CUS_TABELA').Value := FDados.FieldByName('TABELA').Value;
    qryComand.ExecSQL;
    FDados.Next;
  End;

End;


function TControlaCustoDefinidosNaEmpresa.fGravar(ACodEmp: String): Boolean;
begin
  FCodEmp := ACodEmp;
  Result := true;
  Try
    pPersisteDadosNoBanco;
  Except
    on e: Exception do
      raise e;

  End;
end;

function TControlaCustoDefinidosNaEmpresa.fTeveAlteracao: Boolean;
begin
  FDados.First;
  Result := False;
  While not FDados.Eof do
  Begin
    If Not fValoresIguais then
      Exit(True);
    FDados.Next;
  End;
end;

procedure TControlaCustoDefinidosNaEmpresa.OnAfterPost(DataSet: TDataSet);
begin
  FDados.AfterPost:= nil;
  pReplicaSubFed_ImpFed;
  FDados.AfterPost:= OnAfterPost;

end;

procedure TControlaCustoDefinidosNaEmpresa.pAbrirStatusEdicao(
  blnEditar: Boolean);
begin
  frmTabelasDoItemEmpresa.pHabilitaCampos(blnEditar)
end;

procedure TControlaCustoDefinidosNaEmpresa.pIniciaDadosInclusao;
var intContador: integer;
begin
  FCodEmp := '';
  FDados.AfterPost:= nil;
  Try

    FDados.First;
    While not FDados.IsEmpty do
    Begin
      FDados.Delete;
    End;

    For intContador := 1 To 7 Do
    Begin
      If VS_strTabPrc[intContador] = 'S' Then
      Begin
        FDados.Insert;
        FDados.FieldByName('TABELA').AsInteger := intContador;
        FDados.Post;
      End;
    End;

    pSetaAutoincrem;
  Finally
    FDados.AfterPost:= OnAfterPost;
  End;
end;

procedure TControlaCustoDefinidosNaEmpresa.pMontaCDSDados;
begin
  If Assigned(FDados) Then
    FreeAndNil(FDados);
  FDados := TZClient.Create(Owner, '');
  pMontaSQL;
  FDados.fAbreClient(False, 'TControlaCustoDefinidosNaEmpresa.Create');
  FDataSource.DataSet := FDados;
  pSetaAutoincrem;
  FDados.AfterPost:= OnAfterPost;
end;

procedure TControlaCustoDefinidosNaEmpresa.pMontaSQL;
var intContador: integer;
begin
  FDados.qryQuery.SQL.Clear;
  For intContador := 1 To 7 Do
    If VS_strTabPrc[intContador] = 'S' Then
    Begin
      If Not fEmptyStr(FDados.qryQuery.SQL.Text) Then
       FDados.qryQuery.SQL.Add(' UNION ALL ');

      pSQLTabela(IntToStr(intContador));
    End;

end;

procedure TControlaCustoDefinidosNaEmpresa.pReplicaSubFed_ImpFed;
  var
    intRecNo : integer;
    fltValImpFed, fltValSUBFED: Double;
begin
  FDados.DisableControls;
  fltValSUBFED := FDados.FieldByname('CUS_SUBFED').AsFloat;
  fltValImpFed := FDados.FieldByname('CUS_IMPFED').AsFloat;

  intRecNo := FDados.RecNO;
  FDados.First;
  While not FDados.Eof do
  Begin
    If FDados.RecNo <> intRecNo then
    Begin
      FDados.Edit;
      FDados.FieldByname('CUS_SUBFED').AsFloat := fltValSUBFED;
      FDados.FieldByname('CUS_IMPFED').AsFloat := fltValImpFed;

      FDados.Post;

    End;
    FDados.Next;
  End;

  FDados.RecNO := intRecNo;
  FDados.EnableControls;

end;

procedure TControlaCustoDefinidosNaEmpresa.pSetCodEmp(const Value: string);
begin
  FCodEmp :=  Value;
  pMontaCDSDados;
end;

procedure TControlaCustoDefinidosNaEmpresa.pSQLTabela(ATabela: String);
begin
  FDados.qryQuery.SQL.Add('SELECT CAST('+ATabela+' AS CHAR(1)) AS TABELA, CUSEMP.*, ');
  FDados.qryQuery.SQL.Add('       CUSEMP.CUS_IMPFED AS IMPFED_OLD,');
  FDados.qryQuery.SQL.Add('       CUSEMP.CUS_SUBFED AS SUBFED_OLD,');
  FDados.qryQuery.SQL.Add('       CUSEMP.CUS_ICMSAI AS ICMSAI_OLD,');
  FDados.qryQuery.SQL.Add('       CUSEMP.CUS_DESOPE AS DESOPE_OLD,');
  FDados.qryQuery.SQL.Add('       CUSEMP.CUS_OUTVAL AS OUTVAL_OLD');
  FDados.qryQuery.SQL.Add('    FROM CADEMP  ');
  FDados.qryQuery.SQL.Add('    LEFT JOIN CUSEMP ON CUS_CODEMP =  EMP_CODEMP AND CUS_TABELA = '+ATabela);
  FDados.qryQuery.SQL.Add('   WHERE EMP_CODEMP = "'+FCodEmp+'"');
end;

end.
