unit untEditorMetasRepository;

interface

uses System.Generics.Collections, untTypesSistema;

type
  TEditorMetasRegistrosDto = record
    CodigoVendedor : String;
    CodigoDigitador : String;
    CodigoRepresentante : String;
    CodigoMarca : String;
    CodigoLinhaGrupo : String;
    CodigoAtividade : String;
    CodigoFornecedor : String;
    CodigoDepartamento : String;
    CodigoProduto : String;
    PosicaoClientes : Integer;
    ItensPorNota : Integer;
    ValorDeVenda : Double;
    VolumeVendasLitros : Double;
    VolumeVendasUnidade : Double;
    MargemLucro : Double;
  End;

  TEditorMetasEmpresaDto = record
    CodigoEmpresa : String;
  End;

  TEditorMetasCabecalhoDto = record
    Codigo: String;
    Descricao: String;
    DataInicial : TDate;
    DataFinal : TDate;
    PositivacaoDeClientes : Integer;
    ItensPorNota : Integer;
    ValorDeVenda : Double;
    VolumeDeVendasEmLitros : Double;
    VolumeDeVendasEmUnidades : Double;
    MargemDeLucro : Double;
  End;

  TEditorMetasRepository = class
  public
    function CarregarMetasCabecalho(const AAutoincrem: String) : TEditorMetascabecalhoDto;
    function CarregarEmpresas(const AAutoincrem: String) : TList<TEditorMetasEmpresaDto>;
    procedure ExcluirEmpresas(const AAutoincrem: String);
    procedure GravarEmpresas(const AAutoincrem : String; const AEditorMetasEmpresaDto : TList<TEditorMetasEmpresaDto>);
    procedure GravarDadosMeta(const ACodigoMeta : String; const AListMetas : TList<TEditorMetasRegistrosDto>);
    procedure ExcluirMetas(const ACodigoMeta : String);
    function CarregarDadosMeta(const ACodigoMeta : String): TList<TEditorMetasRegistrosDto>;
    function CarregaFiltroDasMetas(const ACodigoMeta : String; const AFieldName : String) : TConsultasArray;
    function GetCamposMetasPreenchidos(const ACodigoMeta : String): TArray<String>;
  End;

implementation

uses untFuncoesSimples, System.SysUtils, Uni, Variants;

{ TEditorMetasRepository }

function TEditorMetasRepository.CarregaFiltroDasMetas(const ACodigoMeta : String; const AFieldName : String): TConsultasArray;
  Var
    LQryMarca : TUniQuery;
begin
  LQryMarca := fCriaQuery(nil);
  Try
    LQryMarca.SQL.Add(' SELECT DISTINCT ' + AFieldName);
    LQryMarca.SQL.Add('   FROM EDMREG ');
    LQryMarca.SQL.Add('  WHERE REG_CODMET = :CODMET ');
    LQryMarca.SQL.Add('    AND ' + AFieldName + ' IS NOT NULL ');
    LQryMarca.ParamByName('CODMET').AsString := ACodigoMeta;
    LQryMarca.Open;
    SetLength(Result, LQryMarca.RecordCount);
    If (Not LQryMarca.IsEmpty) Then
    Begin
      LQryMarca.First;
      While Not LQryMarca.Eof Do
      Begin
        Result[Pred(LQryMarca.RecNo)].strCodigo := LQryMarca.FieldByName(AFieldName).AsString;
        LQryMarca.Next;
      End;
    End;
  Finally
    FreeAndNil(LQryMarca);
  End;
end;

function TEditorMetasRepository.CarregarMetasCabecalho(
  const AAutoincrem: String): TEditorMetasCabecalhoDto;
  Var
    LQryEditor : TUniQuery;
begin
  LQryEditor := fCriaQuery(nil);
  Try
    LQryEditor.SQL.Add(' SELECT * ');
    LQryEditor.SQL.Add('   FROM EDIMET ');
    LQryEditor.SQL.Add('  WHERE AUTOINCREM = :AUTINC ');
    LQryEditor.ParamByName('AUTINC').AsString := AAutoincrem;
    LQryEditor.Open;
    FillChar(Result, SizeOf(Result), #0);
    If (Not LQryEditor.IsEmpty) Then
    Begin
      Result.Codigo := LQryEditor.FieldByName('MET_CODIGO').AsString;
      Result.Descricao := LQryEditor.FieldByName('MET_DESMET').AsString;
      Result.DataInicial := LQryEditor.FieldByName('MET_DTAINI').AsDateTime;
      Result.DataFinal := LQryEditor.FieldByName('MET_DTAFIN').AsDateTime;
      Result.PositivacaoDeClientes := LQryEditor.FieldByName('MET_POSCLI').AsInteger;
      Result.ItensPorNota := LQryEditor.FieldByName('MET_ITENOT').AsInteger;
      Result.ValorDeVenda := LQryEditor.FieldByName('MAT_VALVEN').AsFloat;
      Result.VolumeDeVendasEmLitros := LQryEditor.FieldByName('MET_VOLLIT').AsFloat;
      Result.VolumeDeVendasEmUnidades := LQryEditor.FieldByName('MET_VOLUNI').AsFloat;
      Result.MargemDeLucro := LQryEditor.FieldByName('MET_MARLUC').AsFloat;
    End;
  Finally
    FreeAndNil(LQryEditor);
  End;
end;

function TEditorMetasRepository.GetCamposMetasPreenchidos(const ACodigoMeta: String): TArray<String>;
  Var
    LQryMetas : TUniQuery;
    LContador : Integer;
begin
  LQryMetas := fCriaQuery(nil);
  Try
    SetLength(Result, 0);
    LQryMetas.SQL.Add(' SELECT DISTINCT ');
    LQryMetas.SQL.Add('        IF(REG_POSCLI IS NULL, "N", "S") AS REG_POSCLI, ');
    LQryMetas.SQL.Add('        IF(REG_ITENOT IS NULL, "N", "S") AS REG_ITENOT, ');
    LQryMetas.SQL.Add('        IF(REG_VALVEN IS NULL, "N", "S") AS REG_VALVEN, ');
    LQryMetas.SQL.Add('        IF(REG_VOLLIT IS NULL, "N", "S") AS REG_VOLLIT, ');
    LQryMetas.SQL.Add('        IF(REG_VOLUNI IS NULL, "N", "S") AS REG_VOLUNI, ');
    LQryMetas.SQL.Add('        IF(REG_MARLUC IS NULL, "N", "S") AS REG_MARLUC  ');
    LQryMetas.SQL.Add('   FROM EDMREG ');
    LQryMetas.SQL.Add('  WHERE REG_CODMET = :CODMET ');
    LQryMetas.ParamByName('CODMET').AsString := ACodigoMeta;
    LQryMetas.Open;
    If (Not LQryMetas.IsEmpty) Then
    Begin
      LQryMetas.First;
      While Not LQryMetas.Eof Do
      Begin
        For LContador := 0 To Pred(LQryMetas.FieldCount) Do
        Begin
          If (LQryMetas.Fields[LContador].AsString = 'N') Then
            Continue;
          If fElementoJaExiste(LQryMetas.Fields[LContador].FieldName, Result) Then
            Continue;
          SetLength(Result, Succ(Length(Result)));
          Result[Pred(Length(Result))] := LQryMetas.Fields[LContador].FieldName;
        End;
        LQryMetas.Next;
      End;
    End;
  Finally
    FreeAndNil(LQryMetas);
  End;
end;

function TEditorMetasRepository.CarregarDadosMeta(
  const ACodigoMeta: String): TList<TEditorMetasRegistrosDto>;
  Var
    LQryDadosMeta : TUniQuery;
    LMetasRegistros : TEditorMetasRegistrosDto;
begin
  LQryDadosMeta := fCriaQuery(nil);
  Try
    Result := TList<TEditorMetasRegistrosDto>.Create;
    LQryDadosMeta.SQL.Add(' SELECT *  ');
    LQryDadosMeta.SQL.Add('   FROM EDMREG ');
    LQryDadosMeta.SQL.Add('  WHERE REG_CODMET = :CODMET ');
    LQryDadosMeta.ParamByName('CODMET').AsString := ACodigoMeta;
    LQryDadosMeta.Open;
    If LQryDadosMeta.IsEmpty Then
      Exit;
    LQryDadosMeta.First;
    While Not LQryDadosMeta.Eof Do
    Begin
      FillChar(LMetasRegistros, Sizeof(LMetasRegistros), #0);
      LMetasRegistros.CodigoVendedor := LQryDadosMeta.FieldByName('REG_CODVEN').AsString;
      LMetasRegistros.CodigoDigitador := LQryDadosMeta.FieldByName('REG_CODDIG').AsString;
      LMetasRegistros.CodigoRepresentante := LQryDadosMeta.FieldByName('REG_CODREP').AsString;
      LMetasRegistros.CodigoMarca := LQryDadosMeta.FieldByName('REG_CODMAR').AsString;
      LMetasRegistros.CodigoLinhaGrupo := LQryDadosMeta.FieldByName('REG_CODGRU').AsString;
      LMetasRegistros.CodigoAtividade := LQryDadosMeta.FieldByName('REG_CODATI').AsString;
      LMetasRegistros.CodigoFornecedor := LQryDadosMeta.FieldByName('REG_CODFOR').AsString;
      LMetasRegistros.CodigoDepartamento := LQryDadosMeta.FieldByName('REG_CODDEP').AsString;
      LMetasRegistros.CodigoProduto := LQryDadosMeta.FieldByName('REG_CODITE').AsString;
      LMetasRegistros.PosicaoClientes := LQryDadosMeta.FieldByName('REG_POSCLI').AsInteger;
      LMetasRegistros.ItensPorNota := LQryDadosMeta.FieldByName('REG_ITENOT').AsInteger;
      LMetasRegistros.ValorDeVenda := LQryDadosMeta.FieldByName('REG_VALVEN').AsFloat;
      LMetasRegistros.VolumeVendasLitros := LQryDadosMeta.FieldByName('REG_VOLLIT').AsFloat;
      LMetasRegistros.VolumeVendasUnidade := LQryDadosMeta.FieldByName('REG_VOLUNI').AsFloat;
      LMetasRegistros.MargemLucro := LQryDadosMeta.FieldByName('REG_MARLUC').AsFloat;
      Result.Add(LMetasRegistros);
      LQryDadosMeta.Next;
    End;
  Finally
    FreeAndNil(LQryDadosMeta);
  End;
end;

function TEditorMetasRepository.CarregarEmpresas(const AAutoincrem: String) : TList<TEditorMetasEmpresaDto>;
  Var
    LQryEmpresa : TUniQuery;
    LEditorMetasEmpresa : TEditorMetasEmpresaDto;
begin
  LQryEmpresa := fCriaQuery(nil);
  Try
    Result := TList<TEditorMetasEmpresaDto>.Create;
    LQryEmpresa.SQL.Text := 'SELECT EMP_CODEMP FROM EDMEMP WHERE EMP_SEQEDM = :SEQEDM ORDER BY EMP_CODEMP';
    LQryEmpresa.ParamByName('SEQEDM').AsString := AAutoincrem;
    LQryEmpresa.Open;
    If LQryEmpresa.IsEmpty Then
      Exit;
    LQryEmpresa.First;
    While Not LQryEmpresa.Eof Do
    Begin
      FillChar(LEditorMetasEmpresa, Sizeof(LEditorMetasEmpresa), #0);
      LEditorMetasEmpresa.CodigoEmpresa := LQryEmpresa.FieldByName('EMP_CODEMP').AsString;
      Result.Add(LEditorMetasEmpresa);
      LQryEmpresa.Next;
    End;
  Finally
    FreeAndNil(LQryEmpresa);
  End;
end;

procedure TEditorMetasRepository.ExcluirEmpresas(const AAutoincrem: String);
  Var
    LQryEmpresa : TUniQuery;
begin
  LQryEmpresa := fCriaQuery(nil);
  Try
    LQryEmpresa.SQL.Text := 'DELETE FROM EDMEMP WHERE EMP_SEQEDM = :SEQEDM';
    LQryEmpresa.ParamByName('SEQEDM').AsString := AAutoincrem;
    LQryEmpresa.ExecSQL;
  Finally
    FreeAndNil(LQryEmpresa);
  End;
end;

procedure TEditorMetasRepository.ExcluirMetas(const ACodigoMeta: String);
  Var
    LQryMetas : TUniQuery;
begin
  LQryMetas := fCriaQuery(nil);
  Try
    LQryMetas.SQL.Text := 'DELETE FROM EDMREG WHERE REG_CODMET = :CODMET';
    LQryMetas.ParamByName('CODMET').AsString := ACodigoMeta;
    LQryMetas.ExecSQL;
  Finally
    FreeAndNil(LQryMetas);
  End;
end;

procedure TEditorMetasRepository.GravarDadosMeta(const ACodigoMeta : String; const AListMetas : TList<TEditorMetasRegistrosDto>);
  Var
    LQryMetas : TUniQuery;
    LContador : Integer;
    LMeta : TEditorMetasRegistrosDto;
begin
  LQryMetas := fCriaQuery(nil);
  Try
    LQryMetas.SQL.Add(' INSERT INTO EDMREG (REG_CODMET, REG_CODVEN, REG_CODDIG, ');
    LQryMetas.SQL.Add('                     REG_CODREP, REG_CODMAR, REG_CODGRU, ');
    LQryMetas.SQL.Add('                     REG_CODATI, REG_CODFOR, REG_CODDEP, ');
    LQryMetas.SQL.Add('                     REG_CODITE, REG_POSCLI, REG_ITENOT, ');
    LQryMetas.SQL.Add('                     REG_VALVEN, REG_VOLLIT, REG_VOLUNI, ');
    LQryMetas.SQL.Add('                     REG_MARLUC)  ');
    LQryMetas.SQL.Add('   VALUES (:CODMET, :CODVEN, :CODDIG, ');
    LQryMetas.SQL.Add('           :CODREP, :CODMAR, :CODGRU, ');
    LQryMetas.SQL.Add('           :CODATI, :CODFOR, :CODDEP, ');
    LQryMetas.SQL.Add('           :CODITE, :POSCLI, :ITENOT, ');
    LQryMetas.SQL.Add('           :VALVEN, :VOLLIT, :VOLUNI, ');
    LQryMetas.SQL.Add('           :MARLUC)  ');
    For LContador := 0 To Pred(AListMetas.Count) Do
    Begin
      LMeta := AListMetas[LContador];
      LQryMetas.ParamByName('CODMET').AsString := ACodigoMeta;

      If LMeta.CodigoVendedor.IsEmpty Then
        LQryMetas.ParamByName('CODVEN').Value := Null
      Else
        LQryMetas.ParamByName('CODVEN').AsString := LMeta.CodigoVendedor;

      If LMeta.CodigoDigitador.IsEmpty Then
        LQryMetas.ParamByName('CODDIG').Value := Null
      Else
        LQryMetas.ParamByName('CODDIG').AsString := LMeta.CodigoDigitador;

      If LMeta.CodigoRepresentante.IsEmpty Then
        LQryMetas.ParamByName('CODREP').Value := Null
      Else
        LQryMetas.ParamByName('CODREP').AsString := LMeta.CodigoRepresentante;

      If LMeta.CodigoMarca.IsEmpty Then
        LQryMetas.ParamByName('CODMAR').Value := Null
      Else
        LQryMetas.ParamByName('CODMAR').AsString := LMeta.CodigoMarca;

      If LMeta.CodigoLinhaGrupo.IsEmpty Then
        LQryMetas.ParamByName('CODGRU').Value := Null
      Else
        LQryMetas.ParamByName('CODGRU').AsString := LMeta.CodigoLinhaGrupo;

      If LMeta.CodigoAtividade.IsEmpty Then
        LQryMetas.ParamByName('CODATI').Value := Null
      Else
        LQryMetas.ParamByName('CODATI').AsString := LMeta.CodigoAtividade;

      If LMeta.CodigoFornecedor.IsEmpty Then
        LQryMetas.ParamByName('CODFOR').Value := Null
      Else
        LQryMetas.ParamByName('CODFOR').AsString := LMeta.CodigoFornecedor;

      If LMeta.CodigoDepartamento.IsEmpty Then
        LQryMetas.ParamByName('CODDEP').Value := Null
      Else
        LQryMetas.ParamByName('CODDEP').AsString := LMeta.CodigoDepartamento;

      If LMeta.CodigoProduto.IsEmpty Then
        LQryMetas.ParamByName('CODITE').Value := Null
      Else
        LQryMetas.ParamByName('CODITE').AsString := LMeta.CodigoProduto;

      If LMeta.PosicaoClientes = 0 Then
        LQryMetas.ParamByName('POSCLI').Value := Null
      Else
        LQryMetas.ParamByName('POSCLI').AsInteger := LMeta.PosicaoClientes;

      If LMeta.ItensPorNota = 0 Then
        LQryMetas.ParamByName('ITENOT').Value := Null
      Else
        LQryMetas.ParamByName('ITENOT').AsInteger := LMeta.ItensPorNota;

      If LMeta.ValorDeVenda = 0 Then
        LQryMetas.ParamByName('VALVEN').Value := Null
      Else
        LQryMetas.ParamByName('VALVEN').AsFloat := LMeta.ValorDeVenda;

      If LMeta.VolumeVendasLitros = 0 Then
        LQryMetas.ParamByName('VOLLIT').Value := Null
      Else
        LQryMetas.ParamByName('VOLLIT').AsFloat := LMeta.VolumeVendasLitros;

      If LMeta.VolumeVendasUnidade = 0 Then
        LQryMetas.ParamByName('VOLUNI').Value := Null
      Else
        LQryMetas.ParamByName('VOLUNI').AsFloat := LMeta.VolumeVendasUnidade;

      If LMeta.MargemLucro = 0 Then
        LQryMetas.ParamByName('MARLUC').Value := Null
      Else
        LQryMetas.ParamByName('MARLUC').AsFloat := LMeta.MargemLucro;

      LQryMetas.ExecSQL;
    End;
  Finally
    FreeAndNil(LQryMetas);
  End;
end;

procedure TEditorMetasRepository.GravarEmpresas(const AAutoincrem : String;
  const AEditorMetasEmpresaDto: TList<TEditorMetasEmpresaDto>);
  Var
    LQryEmpresa : TUniQuery;
    LContador : Integer;
begin
  LQryEmpresa := fCriaQuery(nil);
  Try
    LQryEmpresa.SQL.Text := 'INSERT INTO EDMEMP (EMP_SEQEDM, EMP_CODEMP) VALUES (:SEQEDM, :CODEMP)';
    For LContador := 0 To Pred(AEditorMetasEmpresaDto.Count) Do
    Begin
      LQryEmpresa.ParamByName('SEQEDM').AsString := AAutoincrem;
      LQryEmpresa.ParamByName('CODEMP').AsString := AEditorMetasEmpresaDto[LContador].CodigoEmpresa;
      LQryEmpresa.ExecSQL;
    End;
  Finally
    FreeAndNil(LQryEmpresa);
  End;
end;

end.
