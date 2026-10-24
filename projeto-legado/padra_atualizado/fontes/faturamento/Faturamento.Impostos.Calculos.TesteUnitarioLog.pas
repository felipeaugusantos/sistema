unit Faturamento.Impostos.Calculos.TesteUnitarioLog;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Vcl.Forms,
{$ENDIF}
  system.Rtti, System.SysUtils, Classes,
  Shared.Functions.Core, System.StrUtils;

  procedure pGerarLogTesteUnitario(AParamEntrada :TObject; AParamResultado: TObject;
    AParamObjCliente: TObject; ANomeMetodo : String);

  function fGerarLogParametrosEntrada(AParamEntrada :TObject; AParamResultado: TObject;  AParamObjCliente : TObject;
    ANomeMetodo : String; AInterfaceParametros : String; AInterfaceResult : String) : TStringList;

  function fGerarLogParametrosSaida(AParamResultado: TObject) : TStringList;


  function fRetornarNomeInterface(ADescricao : String) : String;

  procedure pCarregarListParametros(AParam : TObject);
  Procedure pCriarObjetos(AParam : TObject);
  Procedure pDestruirObjetos;
  procedure pGravarLogTesteUnitario;
  procedure pGravarArquivoLogTesteUnitario(const AFolder, ALog: string);
  procedure pGerarLog(AParamEntrada, AParamResultado, AParamObjCliente: TObject; ANomeMetodo , LInterfaceIn , LInterfaceOut: string);

  function fGerarArquivoLogImposto(AMetodoImposto : String; Var AArquivoImposto : String;
    AParamEntrada, AParamResultado, AParamObjCliente: TObject; ANomeMetodo , LInterfaceIn , LInterfaceOut: string  ) : Boolean;

  procedure pGravaLogImposto(ALogImposto : String; AFolder : String);

  function fRetornaNomePastaImposto(const ANomeMetodo: string): string;
  procedure pLimparVariaveisTesteUnitario;

  function fTipoNumerico(strValor : String) : Boolean;

implementation

Var

  Ctx : TRttiContext;
  RTT : TRttiType;

  LParamEntrada : TStringList;
  LParamTipos   : TStringList;
  LValorEntrada : TStringList;

  Vs_UtilizarTesteUnitario : String;

  LLogIcmsEfetivo     : string;
  LLogOrgaoPublico    : string;
  LLogIpi             : string;
  LLogSTCustoAquisicao: string;
  LLogIcms            : string;
  LLogSt              : string;
  LLogFcp             : string;
  LLogFcpDifal        : string;
  LLogDifal           : string;



 CONST
  FOLDER_ORGAOPUBLICO     = 'OrgaoPublico';
  FOLDER_ICMSEFETIVO      = 'IcmsEfetivo';
  FOLDER_IPI              = 'Ipi';
  FOLDER_STCUSTOAQUISICAO = 'STCustoAquisicao';
  FOLDER_ICMS             = 'Icms';
  FOLDER_ST               = 'St';
  FOLDER_FCP              = 'Fcp';
  FOLDER_FCPDIFAL         = 'FcpDifal';
  FOLDER_DIFAL            = 'Difal';


function fTipoNumerico(strValor : String) : Boolean;
begin
  Result := true;

  Try
    strToFloat(strValor)
  Except
    Result := false;
  End;

end;



Procedure pCriarObjetos(AParam : TObject);
begin
  Ctx := TRttiContext.Create;

  RTT := Ctx.GetType(AParam.ClassType);

  LParamEntrada := TStringList.Create;
  LParamTipos   := TStringList.Create;
  LValorEntrada := TStringList.Create;
end;


Procedure pCarregarListParametros(AParam : TObject);
Var
  RTM : TRttiMethod;
begin

  For RTM In RTT.GetMethods Do
  Begin
   If (Length(RTM.GetParameters) = 0) Then
   Begin
     Try
       If Pos(RTM.Name, 'New_Destroy')> 0 Then
         Break;

       LParamEntrada.Add(RTM.Name);
       LParamTipos.Add(RTM.ToString);
       LValorEntrada.Add(RTM.Invoke(AParam, []).ToString);
     Except

     End;
   End;

  End;

end;

Procedure pDestruirObjetos;
begin
  Ctx.Free;
  FreeAndNil(LParamEntrada);
  FreeAndNil(LParamTipos);
  FreeAndNil(LValorEntrada);
end;


function fRetornarNomeInterface(ADescricao : String) : String;
Var
  str : String;
begin
  str := Copy(ADescricao, 2, length(ADescricao) -1);
  Result := 'I'+str;
end;


procedure pGravarLogTesteUnitario;
begin
  Exit;
  
  pGravaLogImposto(LLogIcmsEfetivo, FOLDER_ICMSEFETIVO);
  pGravaLogImposto(LLogOrgaoPublico, FOLDER_ORGAOPUBLICO);
  pGravaLogImposto(LLogIpi, FOLDER_IPI );
  pGravaLogImposto(LLogSTCustoAquisicao, FOLDER_STCUSTOAQUISICAO);
  pGravaLogImposto(LLogIcms, FOLDER_ICMS);
  pGravaLogImposto(LLogSt, FOLDER_ST );
  pGravaLogImposto(LLogFcp, FOLDER_FCP );
  pGravaLogImposto(LLogFcpDifal, FOLDER_FCPDIFAL );
  pGravaLogImposto(LLogDifal, FOLDER_DIFAL );
end;

procedure pGravarArquivoLogTesteUnitario(const AFolder, ALog: string);
Const
  PATH = 'TestesUnitarios\faturamento\Outros\Log\';
Var
  LArquivo     : TStringList;
  LNameFile    : String;
  LDiretorio   : String;
begin
  Exit;
  
  LArquivo := TStringList.Create;

  Try
    LNameFile := 'Log_'+FormatDateTime('yyyymmdd', Date) +'_' +FormatDateTime('hhnnsszzz', nOw) +'.txt'; ;
    LDiretorio := ExtractFilePath(Application.ExeName) + path + AFolder;

    If Not DirectoryExists(LDiretorio) Then
      CreateDir(LDiretorio);

    Try
      LArquivo.Add(ALog);
      LArquivo.SaveToFile( LDiretorio +'\' + LNameFile  );
    Except
      // Não gerar erro caso não encontre o diretório.
    End;
  finally
    FreeAndNil(LArquivo);
  end;

end;

function fGerarArquivoLogImposto(AMetodoImposto : String; Var AArquivoImposto : String;  AParamEntrada, AParamResultado, AParamObjCliente: TObject;
  ANomeMetodo , LInterfaceIn , LInterfaceOut: string  ) : Boolean;
begin
  Result := False;

  If (ANomeMetodo =  AMetodoImposto) Then
  begin
    AArquivoImposto := AArquivoImposto + #13#10 + fGerarLogParametrosEntrada(AParamEntrada, AParamResultado,
      AParamObjCliente, ANomeMetodo, LInterfaceIn, LInterfaceOut).Text;

    AArquivoImposto := AArquivoImposto + fGerarLogParametrosSaida(AParamResultado).Text;

    Result := true;
  End;

end;

procedure pGerarLog(AParamEntrada, AParamResultado, AParamObjCliente: TObject;
  ANomeMetodo , LInterfaceIn , LInterfaceOut: string);
begin
  Exit;

  If fGerarArquivoLogImposto('CalcularValorIcmsOrgaoPublico', LLogOrgaoPublico, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorIcmsEfetivo', LLogIcmsEfetivo, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorIPI', LLogIpi, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorSTCustoAquisicao', LLogSTCustoAquisicao, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorIcms', LLogIcms, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorST', LLogSt, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorDifal', LLogDifal, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorFCP', LLogFcp, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorFCPDifal', LLogFcpDifal, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;
end;

procedure pGerarLogTesteUnitario(AParamEntrada :TObject ; AParamResultado :TObject ;
   AParamObjCliente: TObject; ANomeMetodo : String);
var
  LInterfaceIn : String;
  LInterfaceOut: String;
begin
  Exit;
  
  If Vs_UtilizarTesteUnitario = '' Then
    Vs_UtilizarTesteUnitario := objCore.fArqIni(0, 'GERAL', 'EXEC_LOG_TESTE_UNITARIO_BPL', '');

  If (Vs_UtilizarTesteUnitario <> 'S') Then
    Exit;

  LInterfaceIn  := fRetornarNomeInterface(AParamEntrada.ToString);
  LInterfaceOut := fRetornarNomeInterface(AParamResultado.ToString);

  pGerarLog(AParamEntrada, AParamResultado, AParamObjCliente,
    ANomeMetodo, LInterfaceIn, LInterfaceOut);
end;

function fGerarLogParametrosEntrada(AParamEntrada :TObject ; AParamResultado: TObject; AParamObjCliente : TObject;
  ANomeMetodo : String; AInterfaceParametros : String; AInterfaceResult : String) : TStringList;
Var
  IntCont         : Integer;
  LQuantidade     : Integer;
  LAdicionarAspas : Boolean;
begin
  Try
    pCriarObjetos(AParamEntrada);

    // Parametros de Entrada
    Result := TStringList.Create;

    pCarregarListParametros(AParamEntrada);

    Result.Add('Var');
    Result.Add('  ReturnValue: '+ AInterfaceResult +';');
    Result.Add('  AParametros: '+ AInterfaceParametros +';' );
    Result.Add('Begin');
    Result.Add('  AParametros :=');
    Result.Add('    '+ AParamEntrada.ClassName+'.New()');

    LQuantidade := LParamEntrada.Count -1;


    For IntCont := 0 To  LParamEntrada.Count -1 Do
    Begin
      LAdicionarAspas := true;

      If Pos('string', LParamTipos[IntCont]) = 0 Then
        LAdicionarAspas := false;

      If IntCont < LQuantidade Then
      begin
        If LAdicionarAspas Then
          Result.Add('      .'+LParamEntrada[IntCont]+'('''+ AnsiReplaceStr(LValorEntrada[IntCont],',','.')+''')')
        else
          Result.Add('      .'+LParamEntrada[IntCont]+'('+ AnsiReplaceStr(LValorEntrada[IntCont],',','.')+')')
      end
      else
      begin
        If LAdicionarAspas Then
          Result.Add('      .'+LParamEntrada[IntCont]+'('''+ AnsiReplaceStr(LValorEntrada[IntCont],',','.')+''');')
        else
          Result.Add('      .'+LParamEntrada[IntCont]+'('+ AnsiReplaceStr(LValorEntrada[IntCont],',','.')+');')
      end;
    End;

    Result.Add('');

    Result.Add('  ReturnValue := '+ ANomeMetodo+'(AParametros);');

    Result := Result;
  Finally
    pDestruirObjetos;
  End;

end;

function fGerarLogParametrosSaida(AParamResultado: TObject) : TStringList;
Var
  LCont     : Integer;
  LQtdParam : Integer;
begin
  Try
    pCriarObjetos(AParamResultado);

    Result := TStringList.Create;

    pCarregarListParametros(AParamResultado);

    Result.Add('');
    Result.Add('  CheckTrue( ');

    LQtdParam := (LParamEntrada.Count - 1);

    For LCont := 0 To LParamEntrada.Count -1 Do
    begin
      If LCont < LQtdParam Then
      begin
        if fTipoNumerico(LValorEntrada[LCont])Then
        Begin
          If Frac( strToFloat(LValorEntrada[LCont]) ) = 0.00 Then
            Result.Add('           (ReturnValue.'+LParamEntrada[LCont]+ ' = '+  LValorEntrada[LCont]+') And')
          else
            Result.Add('           (ReturnValue.'+LParamEntrada[LCont]+ ' = objCore.fStrToFloat('''+LValorEntrada[LCont]+''')) And')
        End
        else
        If Pos(LValorEntrada[LCont], 'True_False') > 0 Then
          Result.Add('           (ReturnValue.'+LParamEntrada[LCont]+ ' = '+  LValorEntrada[LCont]+') And')
        else
          Result.Add('           (ReturnValue.'+LParamEntrada[LCont]+ ' = '''+  LValorEntrada[LCont]+''') And')
      end
      else
      begin
        if fTipoNumerico(LValorEntrada[LCont])Then
        Begin
          If Frac( strToFloat(LValorEntrada[LCont]) ) = 0.00 Then
            Result.Add('           (ReturnValue.'+LParamEntrada[LCont]+ ' = '+  LValorEntrada[LCont]+'));')
          else
            Result.Add('           (ReturnValue.'+LParamEntrada[LCont]+ ' = objCore.fStrToFloat('''+LValorEntrada[LCont]+''')));')
        End
        Else
        If Pos(LValorEntrada[LCont], 'True_False') > 0 Then
           Result.Add('           (ReturnValue.'+LParamEntrada[LCont]+ ' = '+  LValorEntrada[LCont]+'));')
        Else
          Result.Add('           (ReturnValue.'+LParamEntrada[LCont]+ ' = '''+  LValorEntrada[LCont]+'''));')
      end;
    end;

    Result.Add('end;')

  finally
    pDestruirObjetos;
  end;
end;

function fRetornaNomePastaImposto(const ANomeMetodo: string): string;
begin
  Result := EmptyStr;

  Case AnsiIndexStr(ANomeMetodo, ['CalcularValorIcmsOrgaoPublico', 'CalcularValorIcmsEfetivo','CalcularValorIPI',
                                  'CalcularValorSTCustoAquisicao','CalcularValorIcms', 'CalcularValorST', 'CalcularValorDifal',
                                  'CalcularValorFCP','CalcularValorFCPDifal']) of
    0 : Result := FOLDER_ORGAOPUBLICO;
    1 : Result := FOLDER_ICMSEFETIVO;
    2 : Result := FOLDER_IPI;
    3:  Result := FOLDER_STCUSTOAQUISICAO;
    4:  Result := FOLDER_ICMS;
    5:  Result := FOLDER_ST;
    6:  Result := FOLDER_DIFAL;
    7:  Result := FOLDER_FCP;
    8:  Result := FOLDER_FCPDIFAL;
  end

end;

procedure pLimparVariaveisTesteUnitario;
begin
  LLogIcmsEfetivo      := EmptyStr;
  LLogOrgaoPublico     := EmptyStr;
  LLogIpi              := EmptyStr;
  LLogSTCustoAquisicao := EmptyStr;
  LLogIcms             := EmptyStr;
  LLogSt               := EmptyStr;
  LLogFcp              := EmptyStr;
  LLogFcpDifal         := EmptyStr;
  LLogDifal            := EmptyStr;
end;


procedure pGravaLogImposto(ALogImposto : String; AFolder : String);
begin
  Exit;
  
  if (objCore.fEmptyStr(ALogImposto)) then
    Exit;

  pGravarArquivoLogTesteUnitario(AFolder, ALogImposto);
end;

end.
