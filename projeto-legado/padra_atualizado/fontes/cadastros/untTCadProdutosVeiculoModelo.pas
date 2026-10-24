unit untTCadProdutosVeiculoModelo;

interface

uses
  Classes, strUtils, DB, System.SysUtils, DateUtils, uni, Variants, untZClient,
  {$IFNDEF LINUX}

    untFuncoesSimples
  {$ELSE}
    Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
    Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
    Services.Core.Types, Services.Core.Task.Monitor, Posix.Unistd
  {$ENDIF LINUX};

Type

  TAcaoRegistro = (taIndefinido, taCadastrado, taCadastrarGeral, taCadastrarRelacao, taRemoverRelacao);
  {taCadastrado -> O registro foi apenas carregado;
   taCadastrarGeral -> O registro foi inserido e deve ser gravado tanto na tabela de relação quanto de cadastro
   taCadastrarRelacao -> O cadastro já existe, deve ser apenas cadastrada a relação entre modelo e produto
   taRemoverRelacao -> Remove a relação entre o produto e o modelo}

  TCamposVeiculo = Record
    strCodMarca: string;
    strDescrMarca: string;
    strCodModelo: string;
    strDescrModelo: string;
    intAnoIni: integer;
    intAnoFim: integer;
    IntValvulas: integer;
    strCilindrada: String;
    intPotencia: integer;
    strCombustivel: string;
    strObservacoes: String;
    strObservacoesProduto: String;
    strCodIte: string;
  End;

  TCadProdutosVeiculoModelo = Class
  private
    FCodigoProduto: string;
    FDataSource: TDataSource;
    FQryCadastro: TZClient;
    FQryExec: TUniQuery;
    intContador: integer;
    intRegistroEmEdicao: integer;
    FListaCombustivel: TStringList;
    FGravarUtilizandoSomenteArray: Boolean;
    FCatalagoFraga: Boolean;
    procedure pRecriaQryCadastro;
    procedure pSetarFiltroDefault;
    function fGravaModelo(strCodMarca: String): string;
    function fGravaMarca: string;
    function fRetornaMarca (const strDesMar: String): String;
    function fRetornaModelo(const strDesMod, strCodMarca: String): string;
  protected
    function fTAcaoRegistroToInt(AAcaoRegistro: TAcaoRegistro): Integer;
    function fIntegerToAcaoRegistro(value: integer): TAcaoRegistro;
    function fGetSQLCadastro(strCodIte: String = ''; strCodIteHerdado: string =''): string;
    function fModeloDetalheJaExiste(AValores: TCamposVeiculo;
      var strAutIncDetEncontrado: string ): Boolean;
    function fRetTipoAcaoRegistroInserido(AValores: TCamposVeiculo;
      var strAutIncDetEncontrado: string): TAcaoRegistro;

    function fRegistroJaInserido(AValores: TCamposVeiculo): Boolean;
    procedure pCadastrarGeral;
    procedure pCadastrarRelacao(strAutIncModDet: String; strObservacao: String = '');
    procedure pRemoverRelacao;
    procedure pAlimentaListaCombustivel;

  //  function fGetDataSet: TDataSet
  Public
    constructor Create;
    destructor Destroy; override;

    property  DataSource: TDataSource read FDataSource;
    procedure pIniciaProcesso(AstrCodigoProduto: String; strCodIteHerdado: string; AblnCatalogoFraga: Boolean = False);
    procedure pDelete;
    function fGravar(AstrCodigoProduto: String = ''): Boolean;
    function fGravarComArrayCamposVeiculo: Boolean;
    function fModeloPertenceAMarca(strCodModelo, strCodMarca: string): Boolean;
    function fModelosPertenceAsMarcas(strMarca, strModelo : String): Boolean;
    function fBuscaDadosVeic(strCodModelo: string): TArray<String>;
    function fAdicionar(AValores: TCamposVeiculo): Boolean;
    function fModeloExiste(var AValores: TCamposVeiculo): Boolean;
    function fCombustivelExiste(ACombustivel: string): Boolean;

    procedure pCarregaDadosRegistroEdicao(var recCamposVeiculo: TCamposVeiculo);
    procedure pCancelaEdicao;
    function  fRetListaCombustivel: string;
    function fRetListaCombustivelComoLista: TStringList;
    class function fZeroToVazio(intValor: Integer; blnRetNull: Boolean = False): string;

End;

implementation

{ TCadProdutosVeiculoModelo }

constructor TCadProdutosVeiculoModelo.Create;
begin
  FQryCadastro := TZClient.Create(Nil, '');
  FDataSource := TDataSource.Create(Nil);
  FDataSource.DataSet := FQryCadastro;
  FQryExec := {$IFNDEF LINUX}fCriaQuery{$ELSE}TUniQuery(fCriaQueryObject(nil)){$ENDIF LINUX};
  FListaCombustivel := TStringList.Create;
  pAlimentaListaCombustivel;
  FGravarUtilizandoSomenteArray := False;
end;

destructor TCadProdutosVeiculoModelo.Destroy;
begin
  FreeAndNil(FQryCadastro);
  FreeAndNil(FDataSource);
  FreeAndNil(FQryExec);
  FreeAndNil(FListaCombustivel);
  Inherited;
end;

function TCadProdutosVeiculoModelo.fGetSQLCadastro(strCodIte: String = ''; strCodIteHerdado: string =''): string;
begin
  Result := '';
  Result := Result + '  SET @CONTADOR := 0;';
  Result := Result + '  SELECT MOD_CODMAR,';
  Result := Result + '         MAR_DESMAR,';
  Result := Result + '         DETMOD.MOD_CODMOD,';
  Result := Result + '         MOD_DESMOD,';
  Result := Result + '         MOD_ANOINI,';
  Result := Result + '         MOD_ANOFIN,';
  Result := Result + '         MOD_VALVUL,';
  Result := Result + '         MOD_CILIND,';
  Result := Result + '         MOD_POTENC,';
  Result := Result + '         MOD_COMBUS,';
  Result := Result + '         MOD_OBSERV,';
  Result := Result + '         VEIPRO.VEI_OBSERV, ';
  If strCodIteHerdado <> '' Then
    Result := Result + ' "' + strCodIteHerdado + '" AS VEI_CODITE,'
  Else
    Result := Result + '         VEI_CODITE,';
  Result := Result + '         @CONTADOR := @CONTADOR  + 1 AS CONTADOR, ';
  Result := Result + '         DETMOD.AUTOINCREM AS CHAVE_MODELO,';
  Result := Result + '         VEIPRO.AUTOINCREM AS CHAVE_MODELO_PRODUTO,';
  If strCodIteHerdado <> '' Then
    Result := Result + '       ' + IntToStr(fTAcaoRegistroToInt(taCadastrarRelacao))  + ' AS TIPREG'
  Else
    Result := Result + '       ' + IntToStr(fTAcaoRegistroToInt(taCadastrado))  + ' AS TIPREG';
  Result := Result + '    FROM DETMOD';
  Result := Result + '   INNER JOIN MODVEI ON MODVEI.MOD_CODMOD = DETMOD.MOD_CODMOD';
  If strCodIteHerdado <> '' Then
    Result := Result + '   INNER JOIN VEIPRO ON VEIPRO.VEI_CODMOD = DETMOD.AUTOINCREM AND VEI_CODITE = "' + strCodIteHerdado + '"'
  Else
    Result := Result + '   INNER JOIN VEIPRO ON VEIPRO.VEI_CODMOD = DETMOD.AUTOINCREM AND VEI_CODITE = "' + strCodIte + '"';

  Result := Result + '   INNER JOIN MARVEI ON MAR_CODMAR = MOD_CODMAR';
  Result := Result + '   ORDER BY MOD_DESMOD ';
end;

function TCadProdutosVeiculoModelo.fIntegerToAcaoRegistro(
  value: integer): TAcaoRegistro;
begin
  case value of
    0: Result := taCadastrado;
    1: Result := taCadastrarGeral;
    2: Result := taCadastrarRelacao;
    3: Result := taRemoverRelacao;
  Else
    Result := taIndefinido;
  end
end;

function TCadProdutosVeiculoModelo.fTAcaoRegistroToInt(
  AAcaoRegistro: TAcaoRegistro): Integer;
begin
  case AAcaoRegistro of
    taCadastrado: Result := 0;
    taCadastrarGeral: Result := 1;
    taCadastrarRelacao: Result := 2;
    taRemoverRelacao: Result := 3;
  Else
    Result := -1;
  end
end;

function TCadProdutosVeiculoModelo.fModeloDetalheJaExiste(
  AValores: TCamposVeiculo; var strAutIncDetEncontrado: string): Boolean;
begin
  FQryExec.SQL.Clear;
  FQryExec.SQL.Add('SELECT MOD_CODMOD,');
  FQryExec.SQL.Add('       MOD_ANOINI,');
  FQryExec.SQL.Add('       MOD_ANOFIN,');
  FQryExec.SQL.Add('       MOD_VALVUL,');
  FQryExec.SQL.Add('       MOD_CILIND,');
  FQryExec.SQL.Add('       MOD_POTENC,');
  FQryExec.SQL.Add('       MOD_COMBUS,');
  FQryExec.SQL.Add('       MOD_OBSERV,');
  FQryExec.SQL.Add('       AUTOINCREM');
  FQryExec.SQL.Add(' FROM DETMOD ');
  FQryExec.SQL.Add('WHERE MOD_CODMOD = :CODMOD');
  FQryExec.SQL.Add('  AND MOD_ANOINI = :ANOINI');
  FQryExec.SQL.Add('  AND IFNULL(MOD_ANOFIN, 0) = :ANOFIN');
  FQryExec.SQL.Add('  AND IFNULL(MOD_VALVUL, 0) = :VALVUL');
  FQryExec.SQL.Add('  AND IFNULL(MOD_CILIND, "") = :CILIND');
  FQryExec.SQL.Add('  AND IFNULL(MOD_POTENC, 0) = :POTENC');
  FQryExec.SQL.Add('  AND IFNULL(MOD_COMBUS, "") = :COMBUS');
  FQryExec.ParamByName('CODMOD').Value := AValores.strCodModelo;
  FQryExec.ParamByName('ANOINI').Value := AValores.intAnoIni;
  FQryExec.ParamByName('ANOFIN').Value := AValores.intAnoFim;
  FQryExec.ParamByName('VALVUL').Value := AValores.IntValvulas;
  FQryExec.ParamByName('CILIND').Value := AValores.strCilindrada;
  FQryExec.ParamByName('POTENC').Value := AValores.intPotencia;
  FQryExec.ParamByName('COMBUS').Value := AValores.strCombustivel;

  FQryExec.Open;
  If FQryExec.IsEmpty Then
    Exit(False);

  Result := True;
  strAutIncDetEncontrado := FQryExec.FieldByName('AUTOINCREM').AsString;
end;


function TCadProdutosVeiculoModelo.fModeloPertenceAMarca(strCodModelo,
  strCodMarca: string): Boolean;
begin
  If (strCodModelo = '') Or
     (strCodMarca = '') Then
     Exit(True);
  FQryExec.SQL.Clear;
  FQryExec.SQL.Add('SELECT COUNT(1) AS QTD FROM MODVEI');
  FQryExec.SQL.Add('  LEFT JOIN MARVEI ON MAR_CODMAR = MOD_CODMAR');
  FQryExec.SQL.Add(' WHERE MOD_CODMOD = "'+ strCodModelo + '"');
  FQryExec.SQL.Add('   AND MOD_CODMAR = "' + strCodMarca + '"');
  FQryExec.Open;

  Exit(FQryExec.FieldByName('QTD').AsInteger > 0);
end;

function TCadProdutosVeiculoModelo.fModelosPertenceAsMarcas(strMarca, strModelo : String): Boolean;
begin
  If (fEmptyStr(strModelo)) or (fEmptyStr(strMarca))  Then
     Exit(True);

  FQryExec.SQL.Clear;
  FQryExec.SQL.Add('SELECT COUNT(1) AS QTD FROM MODVEI');
  FQryExec.SQL.Add('  LEFT JOIN MARVEI ON MAR_CODMAR = MOD_CODMAR');
  FQryExec.SQL.Add(' WHERE MOD_CODMOD IN( '+ strModelo + ')');
  FQryExec.SQL.Add('   AND MOD_CODMAR IN (' + strMarca + ')');
  FQryExec.Open;

  Exit(FQryExec.FieldByName('QTD').AsInteger > 0);
end;

function TCadProdutosVeiculoModelo.fBuscaDadosVeic(strCodModelo: string): TArray<String>;
var arrDadosVeic : TArray<String>;
begin

  setLength(arrDadosVeic, 4);

  FQryExec.SQL.Clear;
  FQryExec.SQL.Add('SELECT MOD_CODMAR,MOD_CODMOD, MOD_DESMOD, MAR_DESMAR FROM MODVEI');
  FQryExec.SQL.Add('  LEFT JOIN MARVEI ON MAR_CODMAR = MOD_CODMAR');
  FQryExec.SQL.Add(' WHERE MOD_CODMOD = "'+ strCodModelo + '"');
  FQryExec.Open;

  arrDadosVeic[0] := FQryExec.FieldByName('MOD_CODMAR').AsString;
  arrDadosVeic[1] := FQryExec.FieldByName('MOD_CODMOD').AsString;
  arrDadosVeic[2] := FQryExec.FieldByName('MAR_DESMAR').AsString;
  arrDadosVeic[3] := FQryExec.FieldByName('MOD_DESMOD').AsString;

  result := arrDadosVeic;
end;

function TCadProdutosVeiculoModelo.fCombustivelExiste(
  ACombustivel: string): Boolean;
var
  lIndice: Integer;
begin
  Result := False;
  for lIndice := 1 to FListaCombustivel.count - 1 do
  begin
    Result := FListaCombustivel[lIndice].ToUpper = ACombustivel.ToUpper;
    if Result then
      Break;
  end;
end;

function TCadProdutosVeiculoModelo.fRetTipoAcaoRegistroInserido(
  AValores: TCamposVeiculo; var strAutIncDetEncontrado: string): TAcaoRegistro;
begin
  strAutIncDetEncontrado := '';
  If fModeloDetalheJaExiste(AValores, strAutIncDetEncontrado) Then
    Result := taCadastrarRelacao
  Else
    Result := taCadastrarGeral
end;


function TCadProdutosVeiculoModelo.fModeloExiste(var AValores: TCamposVeiculo): Boolean;
var strAutInc: String;
begin
   Result := fModeloDetalheJaExiste(AValores, strAutInc);
   If Result Then
     AValores.strObservacoes := FQryExec.FieldByName('MOD_OBSERV').AsString;
end;


function TCadProdutosVeiculoModelo.fAdicionar(AValores: TCamposVeiculo): Boolean;
  var strAutIncModelo: string;
begin
  Try
    If intRegistroEmEdicao > -1 Then
      pDelete;

    If (fEmptyStr(AValores.strCodMarca)) Then
      AValores.strCodMarca := fRetornaMarca(AValores.strDescrMarca);

    If (fEmptyStr(AValores.strCodModelo)) and (not fEmptyStr(AValores.strCodMarca)) Then
      AValores.strCodModelo := fRetornaModelo(AValores.strDescrModelo, AValores.strCodMarca);

    If fRegistroJaInserido(AValores)  And (Not(intRegistroEmEdicao > -1)) Then
    Begin
      {$IFNDEF LINUX};
      fMensagem('', 'Relação já inserida.', ['&Ok']);
      {$ENDIF LINUX}
      Exit(True);
    End;

    FQryCadastro.Append;
    FQryCadastro.FieldByName('MOD_CODMAR').AsString  := AValores.strCodMarca;
    FQryCadastro.FieldByName('MAR_DESMAR').AsString  := AValores.strDescrMarca;
    FQryCadastro.FieldByName('MOD_CODMOD').AsString  := AValores.strCodModelo;
    FQryCadastro.FieldByName('MOD_DESMOD').AsString  := AValores.strDescrModelo;
    FQryCadastro.FieldByName('MOD_ANOINI').AsInteger := AValores.intAnoIni;

    If AValores.intAnoFiM <> 0 Then
      FQryCadastro.FieldByName('MOD_ANOFIN').AsInteger := AValores.intAnoFim
    Else
      FQryCadastro.FieldByName('MOD_ANOFIN').Value := Null;

    If AValores.IntValvulas <> 0 Then
      FQryCadastro.FieldByName('MOD_VALVUL').AsInteger := AValores.IntValvulas
    Else
      FQryCadastro.FieldByName('MOD_VALVUL').Value := Null;

    If AValores.strCilindrada <> '' Then
      FQryCadastro.FieldByName('MOD_CILIND').AsString := AValores.strCilindrada
    Else
      FQryCadastro.FieldByName('MOD_CILIND').Value := Null;

    If AValores.intPotencia <> 0 Then
      FQryCadastro.FieldByName('MOD_POTENC').AsInteger := AValores.intPotencia
    Else
      FQryCadastro.FieldByName('MOD_POTENC').Value := Null;

    If AValores.strCodIte <> '' Then
      FQryCadastro.FieldByName('VEI_CODITE').AsString := AValores.strCodIte
    Else
      FQryCadastro.FieldByName('VEI_CODITE').AsString  := FCodigoProduto;

    inc(intContador);
    FQryCadastro.FieldByName('CONTADOR').AsInteger := intContador;
    FQryCadastro.FieldByName('MOD_COMBUS').AsString  := AValores.strCombustivel;
    FQryCadastro.FieldByName('MOD_OBSERV').AsString  := AValores.strObservacoes;
    FQryCadastro.FieldByName('VEI_OBSERV').AsString  := AValores.strObservacoesProduto;
    FQryCadastro.FieldByName('TIPREG').AsInteger     := fTAcaoRegistroToInt(fRetTipoAcaoRegistroInserido(AValores, strAutIncModelo));

    If strAutIncModelo <> '' Then
      FQryCadastro.FieldByName('CHAVE_MODELO').AsString := strAutIncModelo;

    FQryCadastro.Post;
    Result := True;
    intRegistroEmEdicao := -1;
  Except
    on E: Exception do
    begin
      {$IFNDEF LINUX};
      pMensagensErro(E.Message, 'TCadProdutosVeiculoModelo.fAdiciona');
      {$ENDIF LINUX}
      Result := False;
    End;
  End;
end;

procedure TCadProdutosVeiculoModelo.pAlimentaListaCombustivel;
begin
  FListaCombustivel.Clear;
  FListaCombustivel.Add('');
  FListaCombustivel.Add('ETANOL');
  FListaCombustivel.Add('GASOLINA');
  FListaCombustivel.Add('GNV');
  FListaCombustivel.Add('DIESEL');
  FListaCombustivel.Add('FLEX');
  FListaCombustivel.Add('ELETRICO');
end;

procedure TCadProdutosVeiculoModelo.pCadastrarGeral;
var strAutInc_DETMOD: string;
    strCodMarca: string;
    strCodModelo: String;
begin
  Try
    If (FQryCadastro.FieldByName('MOD_CODMAR').AsString = '') Then
      strCodMarca := fGravaMarca
    Else
      strCodMarca := FQryCadastro.FieldByName('MOD_CODMAR').AsString;

    If (FQryCadastro.FieldByName('MOD_CODMOD').AsString = '') Then
      strCodModelo := fGravaModelo(strCodMarca)
    Else
      strCodModelo := FQryCadastro.FieldByName('MOD_CODMOD').AsString;



    FQryExec.SQL.Clear;
    FQryExec.SQL.Add('INSERT INTO DETMOD(');
    FQryExec.SQL.Add('    MOD_CODMOD, ');
    FQryExec.SQL.Add('    MOD_ANOINI, ');
    FQryExec.SQL.Add('    MOD_ANOFIN, ');
    FQryExec.SQL.Add('    MOD_VALVUL, ');
    FQryExec.SQL.Add('    MOD_CILIND, ');
    FQryExec.SQL.Add('    MOD_POTENC, ');
    FQryExec.SQL.Add('    MOD_COMBUS, ');
    FQryExec.SQL.Add('    MOD_OBSERV, ');
    FQryExec.SQL.Add('    MOD_FRAGA_, ');
    FQryExec.SQL.Add('    AUTOINCREM ');
    FQryExec.SQL.Add('    ) VALUES (');
    FQryExec.SQL.Add('    :CODMOD, ');
    FQryExec.SQL.Add('    :ANOINI, ');
    FQryExec.SQL.Add('    :ANOFIN, ');
    FQryExec.SQL.Add('    :VALVUL, ');
    FQryExec.SQL.Add('    :CILIND, ');
    FQryExec.SQL.Add('    :POTENC, ');
    FQryExec.SQL.Add('    :COMBUS, ');
    FQryExec.SQL.Add('    :OBSERV, ');
    FQryExec.SQL.Add('    :FRAGA_, ');
    FQryExec.SQL.Add('    :AUTINC)');

    strAutInc_DETMOD := fRetAutoIncrem('DETMOD', VS_strCodEmp);

    FQryExec.ParamByName('CODMOD').Value := strCodModelo;
    FQryExec.ParamByName('ANOINI').Value := FQryCadastro.FieldByName('MOD_ANOINI').Value;
    FQryExec.ParamByName('ANOFIN').Value := FQryCadastro.FieldByName('MOD_ANOFIN').Value;
    FQryExec.ParamByName('VALVUL').Value := FQryCadastro.FieldByName('MOD_VALVUL').Value;
    FQryExec.ParamByName('CILIND').Value := FQryCadastro.FieldByName('MOD_CILIND').Value;
    FQryExec.ParamByName('POTENC').Value := FQryCadastro.FieldByName('MOD_POTENC').Value;
    FQryExec.ParamByName('COMBUS').Value := FQryCadastro.FieldByName('MOD_COMBUS').Value;
    FQryExec.ParamByName('OBSERV').Value := FQryCadastro.FieldByName('MOD_OBSERV').Value;
    FQryExec.ParamByName('FRAGA_').Value := IIF(FCatalagoFraga, 'S', 'N');
    FQryExec.ParamByName('AUTINC').AsString := strAutInc_DETMOD;
    FQryExec.ExecSQL;

    pCadastrarRelacao(strAutInc_DETMOD, FQryCadastro.FieldByName('VEI_OBSERV').Value);
  Except
    on e: Exception do
      raise Exception.Create(e.message);
  End

end;

procedure TCadProdutosVeiculoModelo.pCadastrarRelacao(strAutIncModDet: String; strObservacao: String ='');
begin
  FQryExec.SQL.Clear;
  FQryExec.SQL.Add('INSERT INTO VEIPRO(');
  FQryExec.SQL.Add('VEI_CODITE,  ');
  FQryExec.SQL.Add('VEI_CODMOD, ');
  FQryExec.SQL.Add('VEI_OBSERV, ');
  FQryExec.SQL.Add('AUTOINCREM  ');
  FQryExec.SQL.Add(')VALUES(');
  FQryExec.SQL.Add(':CODITE,');
  FQryExec.SQL.Add(':CODMOD, ');
  FQryExec.SQL.Add(':OBSERV, ');
  FQryExec.SQL.Add(':AUTINC)');
  FQryExec.ParamByName('CODITE').Value := FCodigoProduto;
  FQryExec.ParamByName('CODMOD').Value := strAutIncModDet;
  FQryExec.ParamByName('OBSERV').Value := strObservacao;
  FQryExec.ParamByName('AUTINC').Value := fRetAutoIncrem('VEIPRO', VS_strCodEmp);
  FQryExec.ExecSQL;

  FQryExec.SQL.Clear;
  FQryExec.SQL.Add('UPDATE DETMOD SET MOD_OBSERV = :OBSERV');
  FQryExec.SQL.Add(' WHERE AUTOINCREM = :AUTINC');

  FQryExec.ParamByName('AUTINC').Value := strAutIncModDet;
  FQryExec.ParamByName('OBSERV').Value := FQryCadastro.FieldByName('MOD_OBSERV').Value;
  FQryExec.ExecSQL;

end;

procedure TCadProdutosVeiculoModelo.pCancelaEdicao;
begin
 intRegistroEmEdicao := -1;
end;

procedure TCadProdutosVeiculoModelo.pCarregaDadosRegistroEdicao(
  var recCamposVeiculo: TCamposVeiculo);
begin
  If Not FQryCadastro.IsEmpty Then
  begin
    recCamposVeiculo.strCodIte      := FQryCadastro.FieldByName('VEI_CODITE').Value;
    recCamposVeiculo.strCodMarca    := FQryCadastro.FieldByName('MOD_CODMAR').Value;
    recCamposVeiculo.strDescrMarca  := FQryCadastro.FieldByName('MAR_DESMAR').Value;
    recCamposVeiculo.strCodModelo   := FQryCadastro.FieldByName('MOD_CODMOD').Value;
    recCamposVeiculo.strDescrModelo := FQryCadastro.FieldByName('MOD_DESMOD').Value;
    recCamposVeiculo.intAnoIni      := FQryCadastro.FieldByName('MOD_ANOINI').Value;
    recCamposVeiculo.intAnoFim      := FQryCadastro.FieldByName('MOD_ANOFIN').AsInteger;
    recCamposVeiculo.IntValvulas    := FQryCadastro.FieldByName('MOD_VALVUL').AsInteger;
    recCamposVeiculo.strCilindrada  := FQryCadastro.FieldByName('MOD_CILIND').AsString;
    recCamposVeiculo.intPotencia    := FQryCadastro.FieldByName('MOD_POTENC').AsInteger;
    recCamposVeiculo.strCombustivel := FQryCadastro.FieldByName('MOD_COMBUS').Value;
    recCamposVeiculo.strObservacoes := FQryCadastro.FieldByName('MOD_OBSERV').AsString;
    recCamposVeiculo.strObservacoesProduto := FQryCadastro.FieldByName('VEI_OBSERV').AsString;
    intRegistroEmEdicao := FQryCadastro.FieldByName('CONTADOR').Value;
  End
end;

procedure TCadProdutosVeiculoModelo.pRemoverRelacao;
begin
  FQryExec.SQL.Clear;
  FQryExec.SQL.Text := 'DELETE FROM VEIPRO WHERE AUTOINCREM = "' + FQryCadastro.FieldByName('CHAVE_MODELO_PRODUTO').AsString + '"';
  FQryExec.ExecSQL;
end;

procedure TCadProdutosVeiculoModelo.pDelete;
begin
  FQryCadastro.DisableControls;
  Try
    If intRegistroEmEdicao > -1 Then
      FQryCadastro.Locate('CONTADOR', intRegistroEmEdicao, []);

    If FQryCadastro.FieldByName('TIPREG').AsInteger = fTAcaoRegistroToInt(taCadastrarGeral) Then
      FQryCadastro.Delete
    Else
    Begin
      FQryCadastro.Edit;
      FQryCadastro.FieldByName('TIPREG').AsInteger := fTAcaoRegistroToInt(taRemoverRelacao);
      FQryCadastro.Post;
    End;
  Finally
    FQryCadastro.EnableControls;
  End
end;

function TCadProdutosVeiculoModelo.fRetornaMarca(const strDesMar: String): String;
begin
  Result := EmptyStr;

  FQryExec.SQl.Clear;
  FQryExec.SQl.Add('SELECT * FROM MARVEI WHERE MAR_DESMAR = "' + strDesMar + '"');
  FQryExec.Open;

  If Not FQryExec.IsEmpty Then
    Exit(FQryExec.fieldByName('MAR_CODMAR').AsString);
end;

function TCadProdutosVeiculoModelo.fRetornaModelo(const strDesMod, strCodMarca: String): string;
begin
  Result := EmptyStr;

  FQryExec.SQl.Clear;
  FQryExec.SQl.Add('SELECT * FROM MODVEI WHERE MOD_DESMOD = "' + strDesMod + '"  AND MOD_CODMAR = "' + strCodMarca + '"');
  FQryExec.Open;

  If Not (FQryExec.IsEmpty) Then
    Exit(FQryExec.fieldByName('MOD_CODMOD').AsString);
end;

function TCadProdutosVeiculoModelo.fGravaMarca: string;
var
  strCodMar: String;
begin
  strCodMar := fRetornaMarca(FqryCadastro.fieldByName('MAR_DESMAR').AsString);
  If Not fEmptyStr(strCodMar) Then
    Exit(strCodMar);

  Result := fAtualizaProCod('MARVEI', 'MAR_CODMAR', '', 1, Nil,
    function (const AValue: String) : String
    begin
      Result := fPadL(AValue, 4, '0');
    end
  );
  FQryExec.SQL.clear;
  FQryExec.SQL.Add('INSERT INTO MARVEI(');
  FQryExec.SQL.Add('MAR_CODMAR,');
  FQryExec.SQL.Add('MAR_DESMAR,');
  FQryExec.SQL.Add('MAR_FRAGA_,');
  FQryExec.SQL.Add('AUTOINCREM) VALUES (');
  FQryExec.SQL.Add(':CODMAR,');
  FQryExec.SQL.Add(':DESMAR,');
  FQryExec.SQL.Add(':FRAGA_,');
  FQryExec.SQL.Add(':AUTINC)');
  FQryExec.ParamByName('CODMAR').AsString := Result;
  FQryExec.ParamByName('DESMAR').AsString := FqryCadastro.fieldByName('MAR_DESMAR').AsString;
  FQryExec.ParamByName('FRAGA_').AsString := IIF(FCatalagoFraga, 'S', 'N');
  FQryExec.ParamByName('AUTINC').AsString := fRetAutoIncrem('MARVEI', VS_StrCodEmp);
  FQryExec.ExecSQL;
end;

function TCadProdutosVeiculoModelo.fGravaModelo(strCodMarca: String): string;
var
  strCodMod: String;
begin
  strCodMod := fRetornaModelo(FqryCadastro.fieldByName('MOD_DESMOD').AsString, strCodMarca);
  If Not fEmptyStr(strCodMod) Then
    Exit(strCodMod);

  Result := fAtualizaProCod('MODVEI', 'MOD_CODMOD', '', 1, Nil,
    function (const AValue: String) : String
    begin
      Result := fPadL(AValue, 4, '0');
    end

  );
  FQryExec.SQL.clear;
  FQryExec.SQL.Add('INSERT INTO MODVEI(');
  FQryExec.SQL.Add('MOD_CODMOD, ');
  FQryExec.SQL.Add('MOD_DESMOD, ');
  FQryExec.SQL.Add('AUTOINCREM, ');
  FQryExec.SQL.Add('MOD_FRAGA_,');
  FQryExec.SQL.Add('MOD_CODMAR) VALUES (');
  FQryExec.SQL.Add(':CODMOD, ');
  FQryExec.SQL.Add(':DESMOD, ');
  FQryExec.SQL.Add(':AUTINC, ');
  FQryExec.SQL.Add(':FRAGA_, ');
  FQryExec.SQL.Add(':CODMAR) ');
  FQryExec.ParamByName('CODMOD').AsString := Result;
  FQryExec.ParamByName('DESMOD').AsString := FqryCadastro.fieldByName('MOD_DESMOD').AsString;
  FQryExec.ParamByName('AUTINC').AsString := fRetAutoIncrem('MODVEI', VS_StrCodEmp);
  FQryExec.ParamByName('FRAGA_').AsString := IIF(FCatalagoFraga, 'S', 'N');
  FQryExec.ParamByName('CODMAR').AsString := strCodMarca;
  FQryExec.ExecSQL;
end;

function TCadProdutosVeiculoModelo.fGravar(AstrCodigoProduto: String): Boolean;
begin
  If (AstrCodigoProduto = '') And (FCodigoProduto = '') Then
  Begin
    Result := False;
    {$IFNDEF LINUX}
    pMensagemOk('Não foi definido o código do produto');
    {$ENDIF LINUX};
    Exit;
  End;
  FGravarUtilizandoSomenteArray := False;
  If FCodigoProduto = '' Then
    FCodigoProduto := AstrCodigoProduto;
  FQryCadastro.DisableControls;
  FQryCadastro.Filtered := False;
  Try
    FQryCadastro.First;
    While Not FQryCadastro.Eof Do
    Begin
      case fIntegerToAcaoRegistro(FQryCadastro.FieldByName('TIPREG').AsInteger) of
        taCadastrarGeral   : pCadastrarGeral;
        taCadastrarRelacao : pCadastrarRelacao(FQryCadastro.FieldByName('CHAVE_MODELO').AsString, FQryCadastro.FieldByName('VEI_OBSERV').AsString);
        taRemoverRelacao   : PRemoverRelacao;
      End;
      FQryCadastro.Next;
    End;
    Result := True;
  Finally
    pSetarFiltroDefault;
    FQryCadastro.EnableControls;
  End;

end;

function TCadProdutosVeiculoModelo.fGravarComArrayCamposVeiculo: Boolean;
begin
  FGravarUtilizandoSomenteArray := True;
  FQryCadastro.DisableControls;
  FQryCadastro.Filtered := False;
  Try
    FQryCadastro.First;
    While Not FQryCadastro.Eof Do
    Begin
      FCodigoProduto := FQryCadastro.FieldByName('VEI_CODITE').AsString;
      case fIntegerToAcaoRegistro(FQryCadastro.FieldByName('TIPREG').AsInteger) of
        taCadastrarGeral   : pCadastrarGeral;
        taCadastrarRelacao : pCadastrarRelacao(FQryCadastro.FieldByName('CHAVE_MODELO').AsString, FQryCadastro.FieldByName('VEI_OBSERV').AsString);
        taRemoverRelacao   : PRemoverRelacao;
      End;
      FQryCadastro.Next;
    End;
    Result := True;
  Finally
    pSetarFiltroDefault;
    FQryCadastro.EnableControls;
    FGravarUtilizandoSomenteArray := False;
  End;
end;

procedure TCadProdutosVeiculoModelo.pIniciaProcesso(AstrCodigoProduto: String; strCodIteHerdado: string; AblnCatalogoFraga: Boolean = False);
begin
  pRecriaQryCadastro;
  FCodigoProduto := AstrCodigoProduto;
  FQryCadastro.qryQuery.SQL.Text := fGetSQLCadastro(FCodigoProduto, strCodIteHerdado);
  FQryCadastro.fAbreClient(False, 'TCadProdutosVeiculoModelo.pIniciaProcesso');
  pSetarFiltroDefault;
  intContador := FQryCadastro.RecordCount;
  intRegistroEmEdicao := -1;

  FCatalagoFraga := AblnCatalogoFraga;
end;

procedure TCadProdutosVeiculoModelo.pRecriaQryCadastro;
begin
  FreeAndNil(FQryCadastro);
  FQryCadastro := TZClient.Create(Nil, '');
  FDataSource.DataSet := FQryCadastro;
end;

procedure TCadProdutosVeiculoModelo.pSetarFiltroDefault;
begin
  FQryCadastro.Filtered := False;
  FQryCadastro.Filter := 'TIPREG <> ' + IntToStr(fTAcaoRegistroToInt(taRemoverRelacao));
  FQryCadastro.Filtered := True;
end;


function TCadProdutosVeiculoModelo.fRegistroJaInserido(
  AValores: TCamposVeiculo): Boolean;
  var
    strID: string;
begin
  FQryCadastro.DisableControls;
  Try
    FQryCadastro.Filtered := False;

    FQryCadastro.Filter := ' MOD_CODMOD = ' + QuotedStr(AValores.strCodModelo) +
                           ' AND MOD_ANOINI = ' + fZeroToVazio(AValores.intAnoIni, True) +
                           ' AND MOD_ANOFIN = ' + fZeroToVazio(AValores.intAnoFim, True) +
                           ' AND MOD_VALVUL = ' + fZeroToVazio(AValores.IntValvulas, True) +
                           ' AND MOD_CILIND = ' + fQuotedStr(AValores.strCilindrada) +
                           ' AND MOD_POTENC = ' + fZeroToVazio(AValores.intPotencia, True) +
                           ' AND MOD_COMBUS = ' + QuotedStr(AValores.strCombustivel)+
                           IIF(FCatalagoFraga, ' AND MOD_OBSERV = ' + QuotedStr(AValores.strObservacoes), '');

    If AValores.strCodIte <> '' Then
      FQryCadastro.Filter := FQryCadastro.Filter + ' AND VEI_CODITE = ' + QuotedStr(AValores.strCodIte)
    Else
      FQryCadastro.Filter := FQryCadastro.Filter + ' AND VEI_CODITE = ' + QuotedStr(FCodigoProduto);

    FQryCadastro.Filtered := True;
    Result := Not FQryCadastro.IsEmpty;
    If Result Then
    Begin
      strID := FQryCadastro.FieldByName('CONTADOR').AsString;
      pSetarFiltroDefault;
      FQryCadastro.Locate('CONTADOR', strID, []);
    End;
  Finally
    pSetarFiltroDefault;
    FQryCadastro.EnableControls;
  End;
end;

function TCadProdutosVeiculoModelo.fRetListaCombustivel: string;
begin
  Result := FListaCombustivel.Text;
end;

function TCadProdutosVeiculoModelo.fRetListaCombustivelComoLista: TStringList;
begin
  Result := FListaCombustivel;
end;

class function TCadProdutosVeiculoModelo.fZeroToVazio(intValor: Integer; blnRetNull: Boolean = False): string;
begin
  Result := IntToStr(intValor);
  If Result = '0' Then
    Result := '';
  If (Result = '') And blnRetNull Then
    Result := 'NULL';


end;

end.
