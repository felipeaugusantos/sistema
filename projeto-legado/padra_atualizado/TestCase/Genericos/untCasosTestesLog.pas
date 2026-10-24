unit untCasosTestesLog;

interface

uses System.Classes, System.SysUtils, Vcl.Forms, untICasosTestesLog,
  untFuncoes, untModulo, untTypes, System.StrUtils, Shared.Functions.Funcoes.Faturamento;


type
  TCasosTestesLog = class(TInterfacedObject, ICasosTestesLog)
  private
    FStlDeclaracaoMetodoAcertos  : TStringList;
    FStlDeclaracaoMetodoErros    : TStringList;
    FStlDeclaracaoMetodoIgnorados: TStringList;
    FStlIgual             : TStringList;
    FStlIgualMD5          : TStringList;
    FStlDiferente         : TStringList;
    FStlDiferenteMD5      : TStringList;
    FStlIgnorado          : TStringList;
    FStlIgnoradoMD5       : TStringList;
    FNomeClasse           : String;
    FArquivoCount         : Integer;
    FArquivoErrCount      : Integer;
    FArquivoIgnoradoCount : Integer;
    FResumo               : String;
    FResumoAnterior       : String;

    procedure MontarResumo(const AFolder: String);


    function RetornarDiretorio(const AFolder: String): string;
    function RetornarNomeDoArquivo: string;

    function RetornarEscopoUnit : String;
    function RetornarReplaceArredondamentoIcms(AFolder : String): String;
    function RetornarConteudoUnit(ANomeUnit, AImposto,AMetodos, ADeclaracaoMetodos, AAssunto: String): String;
    procedure AdicionarDeclaracaoDosMetodos(AResultadoGeracao,ANomeDoMetodo: String);
    function ValidarNomeEmpresa(AValor : String) : String;
    function RetornarReplaceRecordDifalFcp(AFolder : String): String;
    function RetornarAssunto(const AFolder: String): String;
    function RetirarBarraDiretorio(const AFolder: String): String;
    function RetornarNomeImpostoUses(const AImpostoUses: String): String;

  public
    function Add(AParametros: IParametrosCasosTestesLog): ICasosTestesLog; overload;
    function GerarLog(AFolder: String): ICasosTestesLog; overload;
    function RetornarNomeMetodo(AParametros: IParametrosCasosTestesLog; ACount : Integer; AResultadoGeracao : String) : String;
    function RetornarLinhaSelectDocumento(const AParametros: IParametrosCasosTestesLog): string;
    function TestarLogIgualExistente(const ALog: string): boolean;
    function TestarLogDiferenteExistente(const ALog: string): boolean;
    function TestarLogIgnoradoExistente(const ALog: string): boolean;

    constructor Create;
    destructor Destroy; override;

    class function New(): ICasosTestesLog;
  end;

implementation

{ TCasosTestesLog }

function TCasosTestesLog.Add(
  AParametros: IParametrosCasosTestesLog): ICasosTestesLog;
Var
  LArquivo         : String;
begin

  case AParametros.ResultadoComparacao of
    rcoTrue: Begin
               if (TestarLogIgualExistente(AParametros.Log)) then
               Begin
                 frmModulo.IncrementarRegistrosProcessadosDuplicados;
                 Exit;
               End;

               FArquivoCount := FArquivoCount + 1;
               LArquivo := RetornarNomeMetodo(AParametros, FArquivoCount, 'Acerto') + #13#10 + AParametros.Log;
               FStlIgual.Add(LArquivo);
               frmModulo.IncrementarRegistrosProcessadosAcertos;
             End;

    rcoFalse: Begin
                if (TestarLogDiferenteExistente(AParametros.Log)) then
                Begin
                  frmModulo.IncrementarRegistrosProcessadosDuplicados;
                  Exit;
                End;

                FArquivoErrCount := FArquivoErrCount + 1;
                LArquivo := RetornarNomeMetodo(AParametros, FArquivoErrCount, 'Erro') + #13#10 + AParametros.Log;
                FStlDiferente.Add(LArquivo);
                frmModulo.IncrementarRegistrosProcessadosErros;
              End;

    rcoIgnorado: Begin
                   if (TestarLogIgnoradoExistente(AParametros.Log)) then
                   Begin
                     frmModulo.IncrementarRegistrosProcessadosDuplicados;
                     Exit;
                   End;

                   FArquivoIgnoradoCount := FArquivoIgnoradoCount + 1;
                   LArquivo := RetornarNomeMetodo(AParametros, FArquivoIgnoradoCount,'Ignorado') + #13#10 + AParametros.Log;
                   FStlIgnorado.Add(LArquivo);
                   frmModulo.IncrementarRegistrosProcessadosIgnorados;
                 End;
  end;
end;

constructor TCasosTestesLog.Create;
begin
  FStlDeclaracaoMetodoAcertos  := TStringList.Create;
  FStlDeclaracaoMetodoErros    := TStringList.Create;
  FStlDeclaracaoMetodoIgnorados:= TStringList.Create;


  FStlIgual    := TStringList.Create;
  FStlIgualMD5 := TStringList.Create;

  FStlDiferente    := TStringList.Create;
  FStlDiferenteMD5 := TStringList.Create;

  FStlIgnorado    := TStringList.Create;
  FStlIgnoradoMD5 := TStringList.Create;

  FArquivoCount         := 0;
  FArquivoErrCount      := 0;
  FArquivoIgnoradoCount := 0;
end;

destructor TCasosTestesLog.Destroy;
begin
  FreeAndNil(FStlDeclaracaoMetodoAcertos);
  FreeAndNil(FStlDeclaracaoMetodoErros);
  FreeAndNil(FStlDeclaracaoMetodoIgnorados);

  FreeAndNil(FStlIgual);
  FreeAndNil(FStlIgualMD5);
  FreeAndNil(FStlDiferente);

  FreeAndNil(FStlDiferenteMD5);
  FreeAndNil(FStlIgnorado);
  FreeAndNil(FStlIgnoradoMD5);

  inherited;
end;

function TCasosTestesLog.RetornarDiretorio(Const AFolder: String): string;
begin
  Result := ExtractFilePath(Application.ExeName) + PATH + AFolder;

  if (not frmModulo.ExecutandoPeloJenkins) then
    Exit;

  Result := Result + '\' + FormatDateTime('yyyy-mm-dd', frmModulo.FPeriodoFinal);
end;

function TCasosTestesLog.RetornarEscopoUnit: String;
Var
  LEscopo : String;
begin
  LEscopo := LEscopo + 'unit <NOME_UNIT>;' +#13#10;
  LEscopo := LEscopo + ''+#13#10;
  LEscopo := LEscopo + '<RESUMO>'+#13#10;
  LEscopo := LEscopo + ''+#13#10;
  LEscopo := LEscopo + 'interface'+#13#10;
  LEscopo := LEscopo + ''+#13#10;
  LEscopo := LEscopo + 'uses'+#13#10;
  LEscopo := LEscopo + 'TestFramework,'+#13#10;
  LEscopo := LEscopo + 'Shared.Functions.FloatUtils,'+#13#10;
  LEscopo := LEscopo + 'Shared.Functions.Funcoes.Faturamento,'+#13#10;
  LEscopo := LEscopo + 'Shared.Functions.Types,'+#13#10;
  LEscopo := LEscopo + 'untFuncoes,'+#13#10;
  LEscopo := LEscopo + 'Faturamento.<ASSUNTO>.Calculos.<IMPOSTO>,'+#13#10;
  LEscopo := LEscopo + 'Faturamento.<ASSUNTO>.Tipos.<IMPOSTO>,'+#13#10;
  LEscopo := LEscopo + 'Faturamento.<ASSUNTO>.Interfaces.<IMPOSTO>;'+#13#10;
  LEscopo := LEscopo + ''+#13#10;
  LEscopo := LEscopo + 'type'+#13#10;
  LEscopo := LEscopo + '<NOME_CLASSE> = class(TTestCase)' +#13#10;
  LEscopo := LEscopo + 'strict private' +#13#10;
  LEscopo := LEscopo + 'private' +#13#10;
  LEscopo := LEscopo + '' +#13#10;
	LEscopo := LEscopo + '<METODO_ARREDONDAMENTO>' +#13#10;
	LEscopo := LEscopo + '<METODO_RECORD_DIFALFCP>' +#13#10;
  LEscopo := LEscopo + '' +#13#10;
  LEscopo := LEscopo + '' +#13#10;
  LEscopo := LEscopo + 'published' +#13#10;
  LEscopo := LEscopo + '' +#13#10;
  LEscopo := LEscopo + '<DECLARACAO_METODOS>' +#13#10;
  LEscopo := LEscopo + '' +#13#10;
  LEscopo := LEscopo + 'public' +#13#10;
  LEscopo := LEscopo + '  procedure SetUp; override;' +#13#10;
  LEscopo := LEscopo + '  procedure TearDown; override;' +#13#10;
  LEscopo := LEscopo + 'end;' +#13#10;
  LEscopo := LEscopo + '' +#13#10;
  LEscopo := LEscopo + 'implementation' +#13#10;
  LEscopo := LEscopo + '' +#13#10;
  LEscopo := LEscopo + 'procedure <NOME_CLASSE>.SetUp;' +#13#10;
  LEscopo := LEscopo + 'begin' +#13#10;
  LEscopo := LEscopo + 'end;' +#13#10;
  LEscopo := LEscopo + '' +#13#10;
  LEscopo := LEscopo + 'procedure <NOME_CLASSE>.TearDown;' +#13#10;
  LEscopo := LEscopo + 'begin' +#13#10;
  LEscopo := LEscopo + 'end;' +#13#10;
  LEscopo := LEscopo + '' +#13#10;
  LEscopo := LEscopo + '<METODOS>' +#13#10;
  LEscopo := LEscopo + '' +#13#10;
  LEscopo := LEscopo + 'initialization' +#13#10;
  LEscopo := LEscopo + '  RegisterTest(<NOME_CLASSE>.Suite);' +#13#10;
  LEscopo := LEscopo + 'end.' +#13#10;

  Result := LEscopo;
end;

function TCasosTestesLog.RetornarNomeDoArquivo: string;
begin
  Result := fTiraCaracEspeciaisPonto(Trim(leftStr(frmModulo.FNomeEmpresa,15)))+ '_Lj' + frmModulo.FCodEmp + '_'+FormatDateTime('yyyymmdd', FrmModulo.FPeriodoFinal);
  Result := StringReplace(Result, ' ','_',[rfReplaceAll]);
  Result := ValidarNomeEmpresa(Result);
end;

function TCasosTestesLog.RetornarNomeImpostoUses(
  const AImpostoUses: String): String;
begin
  Result := AImpostoUses;

  If Pos('PrecoCusto\', AImpostoUses) > 0 Then
    Result := 'PrecoCusto';

  If Pos('MargemVenda', AImpostoUses) > 0 Then
    Result := 'MargemVenda';

end;

function TCasosTestesLog.RetornarReplaceArredondamentoIcms(AFolder: String): String;
begin
  If AFolder = 'Icms' Then
  begin
    Result := '  FMetodoArredondamentoICMSECF: TMetodoArredondamentoICMSECF;';
    Exit;
  end;

  Result := '';
end;

function TCasosTestesLog.RetornarReplaceRecordDifalFcp(AFolder: String): String;
begin
  If Pos(AFolder,'Fcp_Difal') > 0 Then
  begin
    Result := '  FRecordDifalFCP: TRecDifalFCP;';
    Exit;
  end;

  Result := '';
end;

function TCasosTestesLog.GerarLog(AFolder: String): ICasosTestesLog;
Const
  LOG_IGUAL = '\Acertos';
  LOG_DIFERENTE = '\Erros';
  LOG_IGNORADO = '\Ignorados';
Var
  LNameFile   : String;
  LDiretorio  : String;
  LConteudo   : String;
  LAssunto    : String;
begin
  LAssunto := RetornarAssunto(AFolder);
  LNameFile := 'TestFaturamento.' + LAssunto + '.Calculos.' + RetirarBarraDiretorio(AFolder) + '.' + RetornarNomeDoArquivo;
  LDiretorio := RetornarDiretorio(AFolder);

  If Not DirectoryExists(LDiretorio) Then
    ForceDirectories(LDiretorio);

  Try
    frmModulo.FHoraFim := Now;

    MontarResumo(AFolder);

    If FStlIgual.Count > 0 Then
    begin
      If Not DirectoryExists(LDiretorio + LOG_IGUAL) Then
        ForceDirectories(LDiretorio + LOG_IGUAL);

      LConteudo := '';
      LConteudo := RetornarConteudoUnit(LNameFile, AFolder, FStlIgual.Text, FStlDeclaracaoMetodoAcertos.Text, LAssunto);

      FStlIgual.Clear;
      FStlIgual.Add(LConteudo);
      FStlIgual.SaveToFile(LDiretorio + LOG_IGUAL +'\'+ LNameFile + '.pas');
    end;

    If FStlDiferente.Count > 0 Then
    begin
      If Not DirectoryExists(LDiretorio + LOG_DIFERENTE) Then
        ForceDirectories(LDiretorio + LOG_DIFERENTE);

      LConteudo := '';
      LConteudo := RetornarConteudoUnit(LNameFile, AFolder, FStlDiferente.Text, FStlDeclaracaoMetodoErros.Text, LAssunto);

      FStlDiferente.Clear;
      FStlDiferente.Add(LConteudo);
      FStlDiferente.SaveToFile(LDiretorio + LOG_DIFERENTE +'\'+ LNameFile+'.pas');
    end;


    If FStlIgnorado.Count > 0 Then
    begin
      If Not DirectoryExists(LDiretorio + LOG_IGNORADO) Then
        ForceDirectories(LDiretorio + LOG_IGNORADO);

      LConteudo := '';
      LConteudo := RetornarConteudoUnit(LNameFile, AFolder, FStlIgnorado.Text, FStlDeclaracaoMetodoIgnorados.Text, LAssunto);

      FStlIgnorado.Clear;
      FStlIgnorado.Add(LConteudo);
      FStlIgnorado.SaveToFile(LDiretorio + LOG_IGNORADO +'\'+ LNameFile +'.pas');
    end;

  Except
    // Não gerar erro caso não encontre o diretório.

  End;
end;

function TCasosTestesLog.RetirarBarraDiretorio(const AFolder: String): String;
begin
  Result := AFolder;

  If Pos('\', AFolder) > 0 Then
    Result := AnsiReplaceStr(AFolder, '\', '');
end;

function TCasosTestesLog.RetornarAssunto(const AFolder: String): String;
begin
  Result := 'Impostos';

  If Pos('PrecoCusto\', AFolder) > 0 Then
    Result := 'Precos';

  If Pos('MargemVenda', AFolder) > 0 Then
    Result := 'Margem';


end;

function TCasosTestesLog.RetornarConteudoUnit(ANomeUnit, AImposto,AMetodos, ADeclaracaoMetodos, AAssunto: String): String;
Var
  LImpostoUses : String;
begin
  Result := RetornarEscopoUnit;

  LImpostoUses := AImposto;

  LImpostoUses := StringReplace(LImpostoUses, 'FCPDifal', 'FCP' ,[rfReplaceAll]);

  Result := StringReplace(Result,'Faturamento.Impostos.Calculos.FCPDifal','Faturamento.Impostos.Calculos.FCP',[rfReplaceAll]);
  Result := StringReplace(Result,'Faturamento.Impostos.Tipos.FCPDifal', 'Faturamento.Impostos.Tipos.FCP',[rfReplaceAll]);
  Result := StringReplace(Result,'Faturamento.Impostos.Interfaces.FCPDifal', 'Faturamento.Impostos.Interfaces.FCP',[rfReplaceAll]);

  Result := StringReplace(Result, '<NOME_UNIT>', ANomeUnit,[rfReplaceAll]);
  Result := StringReplace(Result, '<RESUMO>', '{' + FResumo + '}',[rfReplaceAll]);
  Result := StringReplace(Result, '<ASSUNTO>', AAssunto,[rfReplaceAll]);
  Result := StringReplace(Result, '<IMPOSTO>', RetornarNomeImpostoUses(LImpostoUses),[rfReplaceAll]);
  Result := StringReplace(Result, '<NOME_CLASSE>', FNomeClasse,[rfReplaceAll]);
  Result := StringReplace(Result, '<METODO_ARREDONDAMENTO>', RetornarReplaceArredondamentoIcms(AImposto),[rfReplaceAll]);
  Result := StringReplace(Result, '<DECLARACAO_METODOS>', ADeclaracaoMetodos,[rfReplaceAll]);
  Result := StringReplace(Result, '<METODOS>', AMetodos,[rfReplaceAll]);
  Result := StringReplace(Result, '<METODO_RECORD_DIFALFCP>', RetornarReplaceRecordDifalFcp(AImposto),[rfReplaceAll]);

  If AImposto  = 'Icms' Then
    Result := StringReplace(Result, '((empty))', '(FMetodoArredondamentoICMSECF)',[rfReplaceAll]);

  If Pos(AImposto,'Fcp_Difal') > 0 Then
    Result := StringReplace(Result, '((record))', '(FRecordDifalFCP)',[rfReplaceAll]);
end;

class function TCasosTestesLog.New: ICasosTestesLog;
begin
  Result := Self.Create;
end;

function TCasosTestesLog.RetornarLinhaSelectDocumento(const AParametros: IParametrosCasosTestesLog): string;
begin
  result := result + 'SELECT * FROM MOVDET ';
  result := result + 'WHERE DET_NUMDOC = "'+AParametros.NumeroDoDocumento+'" AND ';
  result := result + 'DET_ESPDOC = "'+AParametros.EspecieDoDocumento+'" AND ';
  result := result + 'DET_CODEMP = "'+AParametros.CodigoDaEmpresa+'" AND ';
  result := result + 'DET_CODITE = "'+AParametros.CodigoDoItem+'" AND ';
  result := result + 'DET_CODCLI = "'+AParametros.CodigoDoCliente+'";';
end;

function TCasosTestesLog.RetornarNomeMetodo(AParametros: IParametrosCasosTestesLog; ACount : Integer; AResultadoGeracao : String): String;
Var
  LCodEmpresa : String;
  LNomeEmpresa: String;
  LNomeMetodo : String;
begin
  LCodEmpresa := frmModulo.FCodEmp;

  LNomeEmpresa := leftStr(frmModulo.FNomeEmpresa,15);
  LNomeEmpresa := fTiraCaracEspeciaisPonto(fTiraEspacos(LNomeEmpresa));

  FNomeClasse := 'Test'+LNomeEmpresa;

  LNomeMetodo := 'Procedure '+AParametros.RetornarNomeOperacao + '_' + LNomeEmpresa + '_' + fStrZero(IntToStr(ACount),6)+';';

  AdicionarDeclaracaoDosMetodos(AResultadoGeracao, LNomeMetodo);

  LNomeMetodo := 'Procedure '+FNomeClasse+'.'+AParametros.RetornarNomeOperacao + '_' + LNomeEmpresa + '_' + fStrZero(IntToStr(ACount),6)+';';

  LNomeMetodo := LNomeMetodo + #13#10 + '{' + RetornarLinhaSelectDocumento(AParametros);
  LNomeMetodo := LNomeMetodo + #13#10 + '    DOCUMENTO: '+AParametros.NumeroDoDocumento;
  LNomeMetodo := LNomeMetodo + #13#10 + '      ESPECIE: '+AParametros.EspecieDoDocumento;
  LNomeMetodo := LNomeMetodo + #13#10 + '      EMPRESA: '+AParametros.CodigoDaEmpresa;
  LNomeMetodo := LNomeMetodo + #13#10 + '      CLIENTE: '+AParametros.CodigoDoCliente;
  LNomeMetodo := LNomeMetodo + #13#10 + '       ESTADO: '+AParametros.EstadoDoDocumento;
  LNomeMetodo := LNomeMetodo + #13#10 + '         ITEM: '+AParametros.CodigoDoItem;
  LNomeMetodo := LNomeMetodo + #13#10 + ' ITEM SERVIÇO: '+IfThen(TFunctionFuncoesFaturamento.fEhItemServico(AParametros.CodigoDoItem), 'SIM', 'NÃO');
  LNomeMetodo := LNomeMetodo + #13#10 + '         CFOP: '+AParametros.ClassificacaoFiscal;
  LNomeMetodo := LNomeMetodo + #13#10 + 'CODIGO FISCAL: '+AParametros.CodigoFiscal;
  LNomeMetodo := LNomeMetodo + #13#10 + '       IDEPRO: '+AParametros.IdentificacaoDoProduto;
  LNomeMetodo := LNomeMetodo + #13#10 + 'TIPO DA ABREV: '+AParametros.TipoDaAbreviacaoFiscal;
  LNomeMetodo := LNomeMetodo + #13#10 + ' DATA ENTRADA: '+FormatDateTime('DD/MM/YYYY', AParametros.DataEntrada);
  LNomeMetodo := LNomeMetodo + #13#10 + '   AUX_OPCDOC: '+AParametros.OpcaoDocumento +'}';

  Result := LNomeMetodo;
end;


procedure TCasosTestesLog.AdicionarDeclaracaoDosMetodos(AResultadoGeracao : String; ANomeDoMetodo : String);
begin
  If AResultadoGeracao = 'Acerto' Then
  begin
    FStlDeclaracaoMetodoAcertos.Add(ANomeDoMetodo);
    Exit;
  end;

  If AResultadoGeracao = 'Erro' Then
  begin
    FStlDeclaracaoMetodoErros.Add(ANomeDoMetodo);
    Exit;
  end;

  If AResultadoGeracao = 'Ignorado' Then
  begin
    FStlDeclaracaoMetodoIgnorados.Add(ANomeDoMetodo);
    Exit;
  end;

end;

function TCasosTestesLog.TestarLogDiferenteExistente(
  const ALog: string): boolean;
var
  LIndex: integer;
  Lmd5: string;
begin
  Lmd5   := GetMD5(ALog);
  Result := FStlDiferenteMD5.Find(Lmd5, LIndex);

  if (not Result) then
    FStlDiferenteMD5.Add(Lmd5);
end;

function TCasosTestesLog.TestarLogIgnoradoExistente(
  const ALog: string): boolean;
var
  LIndex: integer;
  Lmd5: string;
begin
  Lmd5   := GetMD5(ALog);
  Result := FStlIgnoradoMD5.Find(Lmd5, LIndex);

  if (not Result) then
    FStlIgnoradoMD5.Add(Lmd5);
end;

function TCasosTestesLog.TestarLogIgualExistente(const ALog: string): boolean;
var
  LIndex: integer;
  Lmd5: string;
begin
  Result := True;

  Lmd5 := GetMD5(ALog);
  LIndex := FStlIgualMD5.IndexOf(Lmd5);

  If LIndex < 0 Then
  Begin
    FStlIgualMD5.Add(Lmd5);
    Result := False;
  End;
end;

function TCasosTestesLog.ValidarNomeEmpresa(AValor: String): String;
begin
  Result := '_' + AValor;
  Try
    StrToInt(Copy(AValor,1,3));
  except
    Result := AValor;
  End;
end;

procedure TCasosTestesLog.MontarResumo(const AFolder: String);
begin
  FResumoAnterior := frmModulo.FResumo.Text;

  frmModulo.FResumo.Clear;

  frmModulo.FResumo.Add('--------------------------------------------------------------------------');
  frmModulo.FResumo.Add('                    RESUMO ' + UpperCase(AFolder) + '                 ');
  frmModulo.FResumo.Add('--------------------------------------------------------------------------');
  frmModulo.FResumo.Add('Empresa            : '+ frmModulo.FCodEmp + ' - ' + frmModulo.FNomeEmpresa);
  frmModulo.FResumo.Add('Período Selecionado: '+ FormatDateTime('dd/mm/yyyy', frmModulo.FPeriodoInicial) + ' até ' + FormatDateTime('dd/mm/yyyy', frmModulo.FPeriodoFinal));
  frmModulo.FResumo.Add('Data do Processo   : '+ FormatDateTime('dd/mm/yyyy ', frmModulo.FDataInicio));
  frmModulo.FResumo.Add('Hora Inicio        : '+ FormatDateTime('hh:nn:ss', frmModulo.FHoraInicio));
  frmModulo.FResumo.Add('Hora Fim           : '+ FormatDateTime('hh:nn:ss', frmModulo.FHoraFim));
  frmModulo.FResumo.Add('Tempo Total        : '+ FormatDateTime('hh:nn:ss', (frmModulo.FHoraFim - frmModulo.FHoraInicio)));
  frmModulo.FResumo.Add('                                           ');
  frmModulo.FResumo.Add('Total Registros    : '+IntToStr(frmModulo.Registros) ) ;
  frmModulo.FResumo.Add('Total Processados  : '+IntToStr(frmModulo.RegistrosProcessados) ) ;
  frmModulo.FResumo.Add('Total de Acertos   : '+IntToStr(frmModulo.RegistrosProcessadosAcerto) ) ;
  frmModulo.FResumo.Add('Total de Erros     : '+IntToStr(frmModulo.RegistrosProcessadosErro) ) ;
  frmModulo.FResumo.Add('Total Ignorados    : '+IntToStr(frmModulo.RegistrosProcessadosIgnorados) ) ;
  frmModulo.FResumo.Add('Total Duplicados   : '+IntToStr(frmModulo.RegistrosProcessadosDuplicados) ) ;
  frmModulo.FResumo.Add('--------------------------------------------------------------------------');

  FResumo := frmModulo.FResumo.Text;

  frmModulo.FResumo.text := frmModulo.FResumo.text + FResumoAnterior

end;

end.
