unit untTPerfilDespachanteAduaneiro;

interface

uses System.Classes, System.SysUtils, uni, Data.DB;
type
  TComposicaoValorContabil = (
    tcvcVR_PRODUTOS,
    tcvcFRETE,
    tcvcSEGURO,
    tcvcVR_ICMS,
    tcvcPIS,
    tcvcCOFINS,
    tcvcIPI,
    tcvcII,
    tcvcSISCOMEX,
    tcvcAFRMM,
    tcvcDESPESAS_ADUANEIRAS,
    tcvcIOF
  );
  TComposicaoValorContabilSet = set of TComposicaoValorContabil;

  TComposicaoValorOutras = (tcvoPIS,
                            tcvoCOFINS,
                            tcvoIOF,
                            tcvoSISCOMEX,
                            tcvoAFRMM,
                            tcvoDESPESAS_ADUANEIRAS);

  TComposicaoValorOutrasSet = set of TComposicaoValorOutras;

  TIdentificacaoUnitario = (iduBaseCalculo, iduUnitarioComercial);


  TPerfilDespachanteAduaneiro = class(TComponent)
  private
    FComposicaoValorContabilSet: TComposicaoValorContabilSet;
    FComposicaoValorOutrasSet: TComposicaoValorOutrasSet;
    FIdentificacaoUnitario: TIdentificacaoUnitario;
    FCasasDecimaisArquivo: Integer;
    FCodigoPerfil: string;
    FDescricaoPerfil: string;
    FqryPerfil: TUniQuery;
    FDestroyQuery: Boolean;
  protected
   procedure SetPerfil(const Value: string);
   function fRetornaImpostoDeImportacao: Boolean;
  public
    class function ComposicaoValorContabilToInt(Value: TComposicaoValorContabilSet): Integer;
    class function IntToComposicaoValorContabilSet(Value: Integer): TComposicaoValorContabilSet;
    class function IntToTComposicaoValorOutrasSet(Value: Integer): TComposicaoValorOutrasSet;
    class function ComposicaoValorOutrasSetToInt(Value: TComposicaoValorOutrasSet): Integer;

    constructor Create(AOwner: TComponent; qryTabela: TUniQuery = nil); reintroduce;
    destructor Destroy; override;
    function GetConfiguracoesText: string;
    procedure pSetaPerfilDefault;
    procedure pPreencheValoresTabela(ADataSet: TDataSet);

    property CodigoPerfil: string read FCodigoPerfil write SetPerfil;
    property ComposicaoValorContabil: TComposicaoValorContabilSet read FComposicaoValorContabilSet;
    property ComposicaoValorOutras: TComposicaoValorOutrasSet read FComposicaoValorOutrasSet;
    property IdentificacaoUnitario: TIdentificacaoUnitario read FIdentificacaoUnitario;
    property CasasDecimaisArquivo: Integer read FCasasDecimaisArquivo write FCasasDecimaisArquivo;
  end;


implementation

uses untFuncoesSimples;

class function TPerfilDespachanteAduaneiro.ComposicaoValorContabilToInt(Value: TComposicaoValorContabilSet): Integer;
var
  Val: TComposicaoValorContabil;
begin
  Result := 0;
  for Val in Value do
    Result := Result or (1 shl Ord(Val));
end;

constructor TPerfilDespachanteAduaneiro.Create(AOwner: TComponent; qryTabela: TUniQuery = nil);
begin
  inherited Create(AOwner);
  FDestroyQuery := False;
  If Assigned(qryTabela) Then
    FqryPerfil := qryTabela
  else
  begin
    FDestroyQuery := True;
    FqryPerfil := fCriaQuery;
  end;

end;

destructor TPerfilDespachanteAduaneiro.Destroy;
begin
  If FDestroyQuery then
    FreeAndNil(FqryPerfil);
  inherited;
end;

function TPerfilDespachanteAduaneiro.GetConfiguracoesText: string;
var ComposicaoValorContabil: TComposicaoValorContabil;
    ComposicaoValorOutras: TComposicaoValorOutras;
begin
  Result:= 'Perfil ' + FCodigoPerfil + '-' + FDescricaoPerfil + char(13);
  Result := Result + 'Forma de Calculo do Valor Unitário[' + char(13);
  If FIdentificacaoUnitario = iduBaseCalculo then
    Result := Result + '  Base de Calculo do II = Tag <det><imposto><II><vBC> Dividio Pela Quantidade Comercial <det><prod><qCom>' + char(13)
  Else
    Result := Result + '  Valor Unitário Comercial = Tag <det><prod><vUnCom>' +char(13);
  result := result +']'+ char(13);

  result := result +'Composição do Valor Contabil:[' + char(13);
  For ComposicaoValorContabil in FComposicaoValorContabilSet do
  begin
    case ComposicaoValorContabil of
      tcvcVR_PRODUTOS: result := result + ' Valor do Produto' + char(13);
      tcvcFRETE: result := result + ' Frete' + char(13);
      tcvcSEGURO: result := result + ' Seguro' + char(13);
      tcvcVR_ICMS: result := result + ' ICMS' + char(13);
      tcvcPIS: result := result + ' PIS' + char(13);
      tcvcCOFINS: result := result + ' COFINS' + char(13);
      tcvcIPI: result := result + ' IPI' + char(13);
      tcvcII: result := result + ' Imposto Importação(II)' + char(13);
      tcvcSISCOMEX: result := result + ' Siscomex' + char(13);
      tcvcAFRMM: result := result + ' AFRMM' + char(13);
      tcvcDESPESAS_ADUANEIRAS: result := result + ' Despesas Aduaneira' + char(13);
      //tcvcOUTROS: result := result + ' Valor Outros' + char(13);
      tcvcIOF: result := result + ' IOF' + char(13);
    end;
  end;
  result := result +']'+ char(13);
  result := Result + 'Composição do Valor Outras:[' + char(13);
  For ComposicaoValorOutras in FComposicaoValorOutrasSet do
  begin
    case ComposicaoValorOutras of
      tcvoSISCOMEX: result := result + ' Siscomex' + char(13);
      tcvoAFRMM: result := result + ' AFRMM' + char(13);
      tcvoPIS: result := result + ' PIS' + char(13);
      tcvoCOFINS: result := result + ' COFINS' + char(13);
      tcvoIOF: result := result + ' IOF' + char(13);
      tcvoDESPESAS_ADUANEIRAS: result := result + ' Despesas Aduaneiras' + char(13);
    end;
  end;
  result := result +']'+ char(13);
end;

class function TPerfilDespachanteAduaneiro.IntToComposicaoValorContabilSet(Value: Integer): TComposicaoValorContabilSet;
var
  i: Integer;
begin
  Result := [];
  for i := 0 to Ord(High(TComposicaoValorContabil)) do
    if (Value and (1 shl i)) <> 0 then
      Include(Result, TComposicaoValorContabil(i));
end;

class function TPerfilDespachanteAduaneiro.IntToTComposicaoValorOutrasSet(Value: Integer): TComposicaoValorOutrasSet;
var
  i: Integer;
begin
  Result := [];
  for i := 0 to Ord(High(TComposicaoValorOutras)) do
    if (Value and (1 shl i)) <> 0 then
      Include(Result, TComposicaoValorOutras(i));
end;

procedure TPerfilDespachanteAduaneiro.pPreencheValoresTabela(
  ADataSet: TDataSet);
begin
    ADataSet.FieldByName('ADU_COMPUN').AsInteger := IIF(FIdentificacaoUnitario = iduBaseCalculo, 0, 1);
    ADataSet.FieldByName('ADU_COVLCO').AsInteger := TPerfilDespachanteAduaneiro.ComposicaoValorContabilToInt(Self.ComposicaoValorContabil);
    ADataSet.FieldByName('ADU_COVLOU').AsInteger := TPerfilDespachanteAduaneiro.ComposicaoValorOutrasSetToInt(Self.FComposicaoValorOutrasSet);
end;

function TPerfilDespachanteAduaneiro.fRetornaImpostoDeImportacao: Boolean;
begin
  Result := True;

  If fCfgSis('NFISII', varBoolean) Then
    Exit;

  If not fCfgSis('IIPPRO', varBoolean) Then
     Exit;

  Result := False;
end;

procedure TPerfilDespachanteAduaneiro.pSetaPerfilDefault;
begin
  FqryPerfil.SQL.Clear;
  FqryPerfil.SQL.Add('SELECT * FROM PERADU WHERE ADU_CODPER = "000"');
  FqryPerfil.Open;
  FCasasDecimaisArquivo := 4;
  If FqryPerfil.IsEmpty then
  begin
    Try
      If fCfgSis('NISSEG', varString) = 'N' then
        FComposicaoValorContabilSet := FComposicaoValorContabilSet - [tcvcSEGURO];
    Except
      //Caso a configuração nao exista nada deve ser feito
    End;


    Try
      If Not fRetornaImpostoDeImportacao then
        FComposicaoValorContabilSet := FComposicaoValorContabilSet - [tcvcII];
    Except
      //Caso a configuração nao exista nada deve ser feito
    End;


    Try
      If fCfgSis('IIPPRO', varString) = 'N' then
        FIdentificacaoUnitario := iduBaseCalculo
      Else
        FIdentificacaoUnitario := iduUnitarioComercial
    Except
      //Caso a configuração nao exista nada deve ser feito
    End;

    FComposicaoValorContabilSet := [tcvcVR_PRODUTOS,
                                    tcvcFRETE,
                                    tcvcSEGURO,
                                    tcvcVR_ICMS,
                                    tcvcPIS,
                                    tcvcCOFINS,
                                    tcvcIPI,
                                    tcvcII,
                                    tcvcSISCOMEX,
                                    tcvcAFRMM,
                                    tcvcDESPESAS_ADUANEIRAS,
                                    tcvcIOF];
    FComposicaoValorOutrasSet := [tcvoPIS,
                                  tcvoCOFINS,
                                  tcvoIOF,
                                  tcvoSISCOMEX,
                                  tcvoAFRMM,
                                  tcvoDESPESAS_ADUANEIRAS];
    FIdentificacaoUnitario := iduBaseCalculo;



    FqryPerfil.Insert;
    pPreencheValoresTabela(FqryPerfil);
    FqryPerfil.FieldByName('ADU_CODPER').AsString := '000';
    FqryPerfil.FieldByName('ADU_DESPER').AsString := 'GERADO AUTOMATICAMENTE PELO SITEMA';
    FqryPerfil.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PERADU', VS_StrCodEmp);
    FqryPerfil.Post;
  end
  Else
    Self.CodigoPerfil := '000';

end;

class function TPerfilDespachanteAduaneiro.ComposicaoValorOutrasSetToInt(Value: TComposicaoValorOutrasSet): Integer;
var
  Val: TComposicaoValorOutras;
begin
  Result := 0;
  for Val in Value do
    Result := Result or (1 shl Ord(Val));
end;

procedure TPerfilDespachanteAduaneiro.SetPerfil(const Value: string);
begin
  FCodigoPerfil := '';
  FComposicaoValorContabilSet := [];
  FComposicaoValorOutrasSet := [];
  FqryPerfil.Close;
  FqryPerfil.SQL.Text :=  'SELECT * FROM PERADU WHERE ADU_CODPER = "'+Value+'"';
  FqryPerfil.Open;
  If FqryPerfil.IsEmpty then
    Exit;

  FCodigoPerfil := Value;
  FComposicaoValorContabilSet := IntToComposicaoValorContabilSet(FqryPerfil.FieldByName('ADU_COVLCO').AsInteger);
  FComposicaoValorOutrasSet := IntToTComposicaoValorOutrasSet(FqryPerfil.FieldByName('ADU_COVLOU').AsInteger);
  FDescricaoPerfil := FqryPerfil.FieldByName('ADU_DESPER').AsString;
  case FqryPerfil.FieldByName('ADU_COMPUN').AsInteger of
    0: FIdentificacaoUnitario := iduBaseCalculo;
    1: FIdentificacaoUnitario := iduUnitarioComercial;
  end;
end;

end.


