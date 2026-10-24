unit untDespesasFaturamento;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Forms, UniClientDataSet,
{$ENDIF}
  Classes, DB, DBClient, SysUtils, Uni, strUtils;

Type
  TDespesaFaturamento = class
    private
      FCodigo: String;
      FQuantidade: Double;
      FValorUnitario: Double;

      function fGetDescricao: String;
      function fGetValorTotal: Double;
      function fGetValorUnitarioSugestao: Double;

      procedure pSetCodigo(Value: String);
      procedure pSetQuantidade(Value: Double);
      procedure pSetValorUnitario(Value: Double);

    public
      procedure pLimpar;
      property strCodigo: String Read FCodigo Write pSetCodigo;
      property strDescricao: String Read fGetDescricao;
      property fltQuantidade: Double Read FQuantidade Write pSetQuantidade;
      property fltValorUnitario: Double Read FValorUnitario Write pSetValorUnitario;
      property fltValorUnitarioSugestao: Double Read fGetValorUnitarioSugestao;
      property fltValorTotal: Double Read fGetValorTotal;
  end;

Type
  TDespesasFaturamento = class
    private
      FDespesas: TUniClientDataSet;
      function fGetValorTotal: Double;
      procedure pFormatarValores;
    public
      constructor Create;
      destructor Destroy; override;

      procedure pDeletarDespesa;
      procedure pAdicionarDespesa(despesa: TDespesaFaturamento);

      {$IFNDEF LINUX}
      procedure pExibirDigitacaoDespesas;
      {$ENDIF}

      procedure pCarregarDespesas(const strSeqGer, strTabGer: String);
      function fGravarDespesas(const strSeqGer, strTabGer: String): Boolean;

      property cdsDespesas: TUniClientDataSet Read FDespesas;
      property fltValorTotal: Double Read fGetValorTotal;
  end;


implementation

uses
{$IFDEF LINUX}
  Shared.Core,
{$ELSE}
  untFuncoesSimples,
  untConsultas,
  untDigDespesasFaturamento,
{$ENDIF}
  untConstantes, untTypesSistema;

{ TDespesaFaturamento }

function TDespesaFaturamento.fGetDescricao: String;
begin
  Result := fCampoTabela('DES_DESCRI', 'CADDES', ['DES_CODIGO'], [strCodigo]);
end;

function TDespesaFaturamento.fGetValorTotal: Double;
begin
  Result := fFormataFloat(fltQuantidade * fltValorUnitario, 2);
end;

function TDespesaFaturamento.fGetValorUnitarioSugestao: Double;
begin
  Result := fCampoTabela('DES_VALDES', 'CADDES', ['DES_CODIGO'], [strCodigo]);
end;

procedure TDespesaFaturamento.pLimpar;
begin
  FCodigo := '';
  FQuantidade := 0;
  FValorUnitario := 0;
end;

procedure TDespesaFaturamento.pSetCodigo(Value: String);
begin
  FCodigo := Value;

  If fEmptyStr(strCodigo) Then
    Raise ExceptionAutcom.Create('Não foi informado o codigo da despesa!')

  Else If fEmptyStr(strDescricao) Then
    Raise ExceptionAutcom.Create('Não foi encontrada nenhuma despesa com este codigo!');

end;

procedure TDespesaFaturamento.pSetValorUnitario(Value: Double);
begin
  FValorUnitario := Value;

  If fltValorUnitario = 0  Then
    Raise ExceptionAutcom.Create('Não foi informado o valor unitário da despesa!')

  Else If fltValorUnitario < 0  Then
    Raise ExceptionAutcom.Create('O valor unitário da despesa não pode ser negativo!');

end;

procedure TDespesaFaturamento.pSetQuantidade(Value: Double);
begin
  FQuantidade := Value;

  If fltQuantidade = 0  Then
    Raise ExceptionAutcom.Create('Não foi informada a quantidade da despesa!')

  Else If fltQuantidade < 0  Then
    Raise ExceptionAutcom.Create('A quantidade da despesa não pode ser negativa!');

end;

{ TDespesasFaturamento }

constructor TDespesasFaturamento.Create;
begin
  FDespesas := TUniClientDataSet.Create(nil);
  FDespesas.FieldDefs.Add('codigo', ftString, 5);
  FDespesas.FieldDefs.Add('descricao', ftString, 50);
  FDespesas.FieldDefs.Add('quantidade', ftFloat);
  FDespesas.FieldDefs.Add('valorunitario', ftFloat);
  FDespesas.FieldDefs.Add('valortotal', ftFloat);
  FDespesas.CreateDataSet;
  FDespesas.Open;
end;

destructor TDespesasFaturamento.Destroy;
begin
  FreeAndNil(FDespesas);
  inherited;
end;

function TDespesasFaturamento.fGetValorTotal: Double;
  Var
    cdsAux: TUniClientDataSet;
begin
  cdsAux := TUniClientDataSet.Create(nil);
  cdsAux.Data := FDespesas.Data;
  Result := 0.00;

  With cdsAux Do
  Begin
    First;
    While Not Eof Do
    Begin
      Result := Result + FieldByName('valortotal').AsFloat;
      Next;
    End;
    First;
  End;

  FreeAndNil(cdsAux);
end;

procedure TDespesasFaturamento.pAdicionarDespesa(despesa: TDespesaFaturamento);
begin
  With FDespesas Do
  Begin
    Append;
    FieldByName('codigo').AsString := despesa.strCodigo;
    FieldByName('descricao').AsString := despesa.strDescricao;
    FieldByName('quantidade').AsFloat := despesa.fltQuantidade;
    FieldByName('valorunitario').AsFloat := despesa.fltValorUnitario;
    FieldByName('valortotal').AsFloat := despesa.fltValorTotal;
    Post;
  End;
end;

procedure TDespesasFaturamento.pDeletarDespesa;
begin
  With FDespesas Do
  Begin
    If IsEmpty Then
      Exit;

    If fPergunta('Deseja realmente excluir a despesa "' + FieldByName('descricao').AsString  + '" ?') Then
      FDespesas.Delete;
  End;
end;

{$IFNDEF LINUX}
procedure TDespesasFaturamento.pExibirDigitacaoDespesas;
  Var
    oleDespesas: OleVariant;
begin
  pFormatarValores;
  oleDespesas := FDespesas.Data;

  Try
    pCriarFormularios(TfrmDigDespesasFaturamento, frmDigDespesasFaturamento);
    frmDigDespesasFaturamento.objDespesasFaturamento := Self;
    frmDigDespesasFaturamento.ShowModal;
    If Not (frmDigDespesasFaturamento.blnConfirma) Then
      FDespesas.Data := oleDespesas;
  Except
    On E: Exception Do
    Begin
      FDespesas.Data := oleDespesas;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmDigDespesasFaturamento);
end;
{$ENDIF}

procedure TDespesasFaturamento.pFormatarValores;
begin
  TFloatField(FDespesas.FieldByName('quantidade')).DisplayFormat    := fMskDigitos(2);
  TFloatField(FDespesas.FieldByName('valorunitario')).DisplayFormat := fMskDigitos(2);
  TFloatField(FDespesas.FieldByName('valortotal')).DisplayFormat    := fMskDigitos(2);
end;

function TDespesasFaturamento.fGravarDespesas(const strSeqGer, strTabGer: String): Boolean;
  Var
    qryAux: TUniQuery;
    strTabela: String;
begin
  Result := False;

  Try

    If strTabGer = 'FATGOR'  Then
      strTabela := 'DESGOR'

    Else If strTabGer = 'MOVGER'  Then
      strTabela := 'DESMOV'

    Else
      Raise Exception.Create('Erro ao gravar despesas para faturamento. Tabela não informada!');

    qryAux := fCriaQuery;

    With qryAux, SQL Do
    Begin
      Add('SELECT * FROM ' + strTabela + ' WHERE DES_SEQGER = ' + QuotedStr(strSeqGer));
      Open;

      While Not IsEmpty Do
        qryAux.Delete;
    End;

    With FDespesas Do
    Begin
      First;
      While Not Eof Do
      Begin
        qryAux.Append;
        qryAux.FieldByName('DES_SEQGER').AsString := strSeqGer;
        qryAux.FieldByName('DES_CODDES').AsString := FieldByName('codigo').AsString;
        qryAux.FieldByName('DES_QTDDES').AsFloat  := FieldByName('quantidade').AsFloat;
        qryAux.FieldByName('DES_VALDES').AsFloat  := FieldByName('valorunitario').AsFloat;
        qryAux.FieldByName('DES_TOTDES').AsFloat  := FieldByName('valortotal').AsFloat;
        qryAux.Post;
        Next;
      End;
      First;
    End;

    FreeAndNil(qryAux);

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TDespesasFaturamento.pCarregarDespesas(const strSeqGer, strTabGer: String);
  Var
    qryAux: TUniQuery;
    strTabela: String;
    objDespesa: TDespesaFaturamento;
begin
  If strTabGer = 'FATGOR'  Then
    strTabela := 'DESGOR'

  Else If strTabGer = 'MOVGER'  Then
    strTabela := 'DESMOV'

  Else
    Raise Exception.Create('Erro ao carregar despesas para faturamento. Tabela não informada!');

  qryAux := fCriaQuery;

  With qryAux, SQL Do
  Begin
    Add('SELECT * FROM ' + strTabela + ' WHERE DES_SEQGER = ' + QuotedStr(strSeqGer));
    Open;

    FDespesas.EmptyDataSet;
    objDespesa := TDespesaFaturamento.Create;

    First;
    While Not Eof Do
    Begin
      objDespesa.strCodigo := FieldByName('DES_CODDES').AsString;
      objDespesa.fltQuantidade := FieldByName('DES_QTDDES').AsFloat;
      objDespesa.fltValorUnitario := FieldByName('DES_VALDES').AsFloat;
      pAdicionarDespesa(objDespesa);
      Next;
    End;

    FreeAndNil(objDespesa);
  End;

  FreeAndNil(qryAux);
end;

end.
