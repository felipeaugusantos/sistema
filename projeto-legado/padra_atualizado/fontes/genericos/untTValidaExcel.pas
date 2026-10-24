unit untTValidaExcel;

interface

uses Forms, System.Win.ComObj,SysUtils, System.Variants, untTLog,
  System.Classes, untFuncoesSimples, Uni, cxProgressBar, Dialogs,
 DateUtils, UniClientDataSet, System.StrUtils, windows, System.Character,
 fs_iinterpreter, Data.DB;

Type
  TCampoEmbalagem = record
    strCodBar: String;
    strCodFor: String;
    fltEmbala: Double;
    blnPrinci: Boolean;
    blnCompra: Boolean;
    blnExbFat: Boolean;
    intTabPre: integer;
    fltPreVen: Double;
    strDescri: String;
    fltAltura: Double;
    fltLargur: Double;
    fltProfun: Double;
    intLastro: Integer;
    intCamada: Integer;
    intEmpMax: Integer;
    fltPesoBR: Double;
    fltPesoLQ: Double;
    blnAtuCodBarCadIte: Boolean;
    blnLeituraEfetuada: Boolean;
  end;


  TCampoIteEmbalagem = record
    strITB_CODITE: string;
    strITB_CODEMP: string;
    strITB_QTDEMB: string;
    strITB_DESCON: string;
    strITB_TABPRE: String
  end;

  TTipoReplaceEnter = (trcetml, trceSQL);

  TCampoEmbalagemArr = Array of TCampoEmbalagem;
  TCampoIteEmbalagemArr = Array of TCampoIteEmbalagem;

  TValidaCodigo =  function (strColuna, strTabela, strCampo, strValor: string; var strMensagem: String): boolean of object;
  TValidacaoLista = function(strValores :Array of variant; inLinhaAtual: Integer; var strMensagem: string): boolean of Object;
  TValidacaoCampoEmbalagem = function (objValores : TCampoEmbalagem; inLinhaAtual: Integer; var strMensagem: string): boolean of Object;
  TValidacaoCampoDescontoEmbalagem = function (objValores : TCampoIteEmbalagem; inLinhaAtual: Integer; var strMensagem: string): boolean of Object;
  TValidacaoCampoTipoProdutoSped = function (strValor: String; inLinhaAtual: Integer; var strMensagem: string): boolean of Object;
  TValidacaoExterna = function (strValor: Variant; inLinhaAtual: Integer; var strMensagem: string): boolean of Object;


  TTipoCampo = (tcInteger, tcFloat, tcString, tcLista, tcChar_SN, tcGirNiv, tcValidacaoLista, tcCampoEmbalagem, tcChar_IR, tcCampoTipoProdutoSped, tcNivCri, tcMltRca, tcPercen, tcCampoDescontoEmbalagem);
  TAtualizaStatus =  Procedure of Object;

  TCampo = record
    FTipo: TTipoCampo;
    FintTamanho: integer;
    FblnTamanhoFixo: boolean; //Quando estiver marcado o campo tem que ter o tamanho fixo, senão apenas não pode ultrapassar
    FstrColuna: string;
    FvalidaCodigo: TValidaCodigo;
    FObrigatorio: boolean;
    FcharSeparador: char;
    FTabela: String;
    FCampoTabela: String;
    FDescricao: String;
    FValidacaoLista: TValidacaoLista;
    FValidacaoCampoEmbalagem: TValidacaoCampoEmbalagem;
    FValidacaoCampoDescontoEmbalagem : TValidacaoCampoDescontoEmbalagem;
    FCompletaZerosAEsquerda: Boolean;
    FValidacaoExterna: TValidacaoExterna;
    FValidacaoCampoTipoProdutoSped: TValidacaoCampoTipoProdutoSped;
    FArrColunas: Array of variant;
    FArrColunasOpc: Array of variant;
    procedure pInit;
  end;

  TCamposReplaceCharEspecial = Record
    FColuna: String;
    TipoReplaceEnter: TTipoReplaceEnter;
  End;

  TArrCamposReplaceCharEspecial = array of  TCamposReplaceCharEspecial;

  TValidadorExcel = class
    private
      frmLog: TfrmLog;
      blnCSV: Boolean;
      FintQtdLinhas,
      FintQtdColunas: Integer;
      FQtdColunasDef: integer;
      FCampos: array of TCampo;
      FArquivoCSV: TStringList;
      FLocalizaValorCSV: TStringList;
      FListaCodigo: TStringList;
      FLog: TStringList;
      FQueryConsulta: TUniQuery;
      FcdsCodigosValidos: TUniClientDataSet;
      cdsErros: TUniClientDataSet;
      blnUsaCdsErros: Boolean;
      FstrColunaValidaTitulo: string;
      FSenha: String;
      FLinhaTitulo: integer;
      const xlCellTypeLastCell = $0000000B;
      const xlCSV = $00000006;
      procedure pCriaCamposCdsCodigosValidos;
      function  fValidaCamposAux(pgbProgresso: TcxProgressBar): Boolean;
      function  fTrataTextoTempo(segundos: Integer): String;
      function  fValidaTipo(strValor: string; tccampo: TTipoCampo; blnObrigatorio: Boolean): boolean;
      function  fValidaTamanho(strvalor: string; intTamanho: integer; blnTamanhoFixo: Boolean): boolean;
      function  fValidaCampoVazio(strValor: string; blnObrigatorio: Boolean): boolean;
      function  fValidaListaCodigo(strValor: string; Campo: TCampo; intCol, intRow: integer): String;
      function  fValidaCodigoInt(strColuna, strTabela, strCampo, strValor: string; var strMensagem: string): boolean;
      function  fRetTipoString(tccampo: TTipoCampo): string;
      function  fRetString(value: string): string;
      function  fQtdColunasCSV: integer;
      function  fGetValueCSV(intLinha: integer; strColuna: string; var posIniCampo: integer): string; overload;
      function  fResolverFormula(intLinha: Integer; Value: String): String;
      procedure pSalvaCSV_MSOffice(strCaminhoDoArquivo: string; LinhaInicial: integer = 0);
      procedure pSalvaCSV_BROffice(strCaminhoDoArquivo: string; LinhaInicial: integer = 0);
      function  fLocalizaColuna(strTitulo: string; var Index: integer; intLinha : Integer = -1): Boolean;
      procedure pProcessaValidacaoLista(ACampo: TCampo; intLinha: integer);
      procedure pProcessaValidacaoCampoEmbalagem(ACampo: TCampo; intLinha: integer);
      procedure pProcessaValidacaoCampoDescontoEmbalagem(ACampo: TCampo; intLinha: integer);
      function  fTrataDecimal(strValue: string): String;
      procedure pProcessaValidacaoCampoTipoProdutoSped(ACampo: TCampo; intLinha: integer);
      Function  fRetCampo(strColuna: String ): TCampo;
      procedure pCriaCdsErros;
      procedure pIncluiCampoCds(var cdsDados: TUniClientDataSet; objFieldClass: TFieldClass; strFieldName, strName: String; intSize: Integer);
    public
      ValidacoesPorSegundo: Integer;
      TempoExtimado: String;
      FAtualizaStatus: TAtualizaStatus;
      blnCancela: Boolean;
      NomeArquivo : String;
      FArrCamposReplaceCharEspecial : TArrCamposReplaceCharEspecial;
      constructor Create(strCaminhoDoArquivo: string; intQtdColunas: integer; strColunaValidaTitulo: string; Senha: string; LinhaInicial: integer = 0; ArrCamposReplaceCharEspecial: TArrCamposReplaceCharEspecial = []; blnUsaCdsErros: Boolean = False);overload;
      constructor Create; overload;
      function fRetEmbalagens(strValorCampo: String): TCampoEmbalagemArr;
      function fRetDescontoEmbalagemFechada(strValorCampo: String): TCampoIteEmbalagemArr;

      destructor  Destroy; override;
      procedure pAddCampo(Campo: TCampo);
      function fGetValueCSV(intLinha: integer; strColuna: string): string; overload;
      function fValidaCampos(blnExibirLog: boolean; ProgressBar : TcxProgressBar =  Nil): boolean;
      function fMontaCampoInt(strDescricao, strColuna: string;
                              blnObrigatorio: boolean = false): TCampo;
      function fMontaCampoFloat(strDescricao, strColuna: string;
                                blnObrigatorio: boolean = false;
                                funcValidacao: TValidacaoExterna = nil): TCampo;
      function fMontaCampoListaCodigo(strDescricao, strColuna: string;
                                      blnObrigatorio: boolean;
                                      strTabela: String;
                                      strCampoTabela: String;
                                      charSeparador: char = ','): TCampo;
      function fMontaCampoString(strDescricao, strColuna: String;
                                 intTamanho: integer = 0;
                                 blnTamanhoFixo: boolean = False;  //Quando estiver marcado o campo tem que ter o tamanho fixo, senão apenas não pode ultrapassar
                                 blnObrigatorio: boolean = false;
                                 strTabela: String ='';
                                 strCampoTabela: String = '';
                                 CompletaZerosAEsquerda: Boolean= False;
                                 funcValidacaoExterna: TValidacaoExterna = nil): TCampo;Overload;
      function fMontaCampoString(strDescricao, strColuna: String;
                                 intTamanho: integer = 0;
                                 blnTamanhoFixo: boolean = False;  //Quando estiver marcado o campo tem que ter o tamanho fixo, senão apenas não pode ultrapassar
                                 blnObrigatorio: boolean = false;
                                 funcValidacao: TValidaCodigo = nil): TCampo; overload;

      function fMontaCampo(tcTipo: TTipoCampo;
                           strDescricao, strColuna: string;
                           intTamanho: integer = 0;
                           blnTamanhoFixo: boolean = False;  //Quando estiver marcado o campo tem que ter o tamanho fixo, senão apenas não pode ultrapassar
                           blnObrigatorio: boolean = false;
                           strTabela: String ='';
                           strCampoTabela: String= ''): TCampo; overload;

      function fMontaValidacaoLista(IdentLista: String; arrColunas: Variant; arrColunasOpcionais: Variant; funcValidacaoLista: TValidacaoLista): TCampo;
      function fMontaValidacaoCampoEmbalagem(IdentLista: String; strColuna: String; funcValidacaoCampoEmbalagem: TValidacaoCampoEmbalagem): TCampo;
      function fMontaValidacaoCampoDescontoEmbalagem(IdentLista: String; strColuna: String; funcValidacaoCampoDescontoEmbalagem : TValidacaoCampoDescontoEmbalagem): TCampo;
      function fMontaValidacaoCampoTipoProdutoSped(IdentLista: String; strColuna: String; funcValidacaoCampoTipoProdutoSped: TValidacaoCampoTipoProdutoSped): TCampo;

      function fTemTitulo(strCampo: string; blnTestaComoFloat: Boolean = False): Boolean;
      procedure pSalvaCSV(strCaminhoDoArquivo: string; LinhaInicial: integer = 0);
      function fLocalizaColunaCSV(strTitulo: string; var Index: integer; intLinha: Integer = -1): Boolean; Overload;
      function fLocalizaColunaCSV(strTitulo: String; Var strColuna: string; intLinha: Integer = -1): Boolean; Overload;
      property ArquivoCSV: TStringList read FArquivoCSV;
      property LinhaTitulos: integer read FLinhaTitulo;
      property intQtdLinhas: integer read FintQtdLinhas;
      function fExecutaExpressao(strExpressao: String; Var blnErro: Boolean): Double;
      class function  fRetValorNumericoColuna(strColuna: string): integer;
      function getCdsErros: TUniClientDataSet;
      procedure pIncluirErroCds(strDescricao, strColuna, strLinha, strMensagem: String);
      function RetornaQuantdadeColunasLinha(const Alinha: Integer): Integer;
      function  fLinhaVazia(intLinha: integer): Boolean;
  end;

implementation

{ TValidador }

uses untGravando, untExcel;

function TValidadorExcel.fValidaCodigoInt(strColuna, strTabela, strCampo, strValor: string; var strMensagem: string): boolean;
Begin
  Result := True;

  strMensagem := '';

  Try
    If Not FcdsCodigosValidos.FindKey([strColuna + strValor]) Then
    Begin
      FQueryConsulta.SQL.Clear;
      FQueryConsulta.SQL.Add('SELECT COUNT(1) QTD FROM ' + strTabela + ' WHERE ' + strCampo + ' = :' + strCampo );
      FQueryConsulta.ParamByName(strCampo).Value := strValor;
      FQueryConsulta.Open;
      Result := FQueryConsulta.FieldByName('QTD').AsInteger > 0;
      FcdsCodigosValidos.Insert;
      FcdsCodigosValidos.Fields[0].AsString := strColuna + strValor;
      If Result Then
        FcdsCodigosValidos.Fields[1].AsInteger := 1
      Else
        FcdsCodigosValidos.Fields[1].AsInteger := 0;
     FcdsCodigosValidos.Post;
    End
    Else
      Result := FcdsCodigosValidos.Fields[1].AsInteger = 1;
  Except
    on E: Exception do
      pMensagensErro(E.Message, '[TValidadorExcel.fValidaCodigoINt]');
  end;
End;

function TValidadorExcel.fValidaListaCodigo(strValor: string; Campo: TCampo; intCol, intRow: integer): String;
var i: integer;
    strMensagem: string;
begin
  If (Campo.FObrigatorio) And (strValor = '') Then
  Begin
    If blnCSV then
      Exit('A informação ' + Campo.FDescricao + ' na coluna [' + IntToStr(intCol) + '] Linha [' + IntToStr(intRow + 1) + ' é obrigatória. Verificar o manual!')
    Else
      Exit('O campo ' + Campo.FDescricao + ' [' + Campo.FstrColuna + IntToStr(intRow) + ']  é obrigatório. Verifique o manual!')
  End;
  If (strValor = '') Then
    Exit('');

  FListaCodigo.Delimiter := campo.FcharSeparador;
  FListaCodigo.CommaText := strValor;

  For i := 0 To FListaCodigo.Count - 1 do
  Begin
    If FListaCodigo[i] <> '' Then
    Begin
      If Not fValidaCodigoInt(Campo.FstrColuna ,Campo.FTabela, Campo.FCampoTabela, FListaCodigo[i], strMensagem) Then
      Begin
        If blnCSV then
          Exit(Campo.FDescricao + ' informação da coluna [' + IntToStr(intCol) + '] Linha [' + IntToStr(intRow + 1) + '] valor [' + FListaCodigo[i] + '] não foi encontrada no cadastro!')
        Else
          Exit(Campo.FDescricao + ' [' + Campo.FstrColuna + IntToStr(intRow) + '] valor [' + FListaCodigo[i] + '] não foi encontrada no cadastro!')
      End;
    End;
  End;
end;

constructor TValidadorExcel.Create(strCaminhoDoArquivo: string; intQtdColunas: integer; strColunaValidaTitulo: string; Senha: string; LinhaInicial: integer = 0; ArrCamposReplaceCharEspecial: TArrCamposReplaceCharEspecial =[]; blnUsaCdsErros: Boolean = False);
begin
  Create;
  Self.blnUsaCdsErros := blnUsaCdsErros;

  If (blnUsaCdsErros) Then
    pCriaCdsErros;

  FArrCamposReplaceCharEspecial := ArrCamposReplaceCharEspecial;
  FstrColunaValidaTitulo := strColunaValidaTitulo;
  FQtdColunasDef := intQtdColunas;
  FcdsCodigosValidos := TUniClientDataSet.Create(nil);
  pCriaCamposCdsCodigosValidos;
  blnCSV := (UpperCase(ExtractFileExt(strCaminhoDoArquivo)) = '.CSV');
  NomeArquivo := strCaminhoDoArquivo;
  FSenha := Senha;
  If (Uppercase(ExtractFileExt(strCaminhoDoArquivo)) = '.XLSX') or
     (Uppercase(ExtractFileExt(strCaminhoDoArquivo)) = '.XLS') oR
     (Uppercase(ExtractFileExt(strCaminhoDoArquivo)) = '.TXT') Then
  Begin
    pSalvaCSV(strCaminhoDoArquivo, LinhaInicial);
  End;
  //Dentro do SalvaCSV o Arquivo será renomeado com CSV
  If UpperCase(ExtractFileExt(NomeArquivo)) = '.CSV' Then
  begin
    FArquivoCSV.LoadFromFile(NomeArquivo);
    FintQtdLinhas := FArquivoCSV.Count -1;
    FintQtdColunas := fQtdColunasCSV + 1;
    FLinhaTitulo := -1;
  end
  Else
  begin
    frmLog.pAddLinha('Arquivo inválido: ' + ExtractFileName(strCaminhoDoArquivo));
    frmLog.pAddLinha('Suportado apenas arquivos [*.xlsx, *.xls, *.csv(separado por ponto e virgula)]');
    frmLog.Showmodal;
  end;
end;

constructor TValidadorExcel.Create;
begin
  frmLog := TfrmLog.Create(nil);
  FQueryConsulta := fCriaQuery;
  FLog := TStringList.Create;
  FArquivoCSV := TStringList.Create;
  FListaCodigo := TStringList.Create;
  FLocalizaValorCSV := TStringList.Create;
end;

destructor TValidadorExcel.Destroy;
begin
  FreeAndNil(frmLog);
  FreeAndNil(FQueryConsulta);
  FreeAndNil(FLog);
  FreeAndNil(FArquivoCSV);
  FreeAndNil(FListaCodigo);
  FreeAndNil(FLocalizaValorCSV);
  FreeAndNil(FcdsCodigosValidos);

  If Assigned(cdsErros) Then
    FreeAndNil(cdsErros);

  If (Not blnCSV) And (NomeArquivo <> '') And (UpperCase(ExtractFileExt(NomeArquivo)) = '.CSV')Then
    DeleteFile(pWideChar(NomeArquivo));
  inherited;
end;

function TValidadorExcel.fGetValueCSV(intLinha: integer; strColuna: string; var posIniCampo: integer): string;
  var
    i, intCont, x, intColuna: integer;
    Campo: TCampo;
begin
  Result := '';
  intColuna := 0;
  If strColuna = '' Then
    Exit('');
  If AnsireplaceStr(FArquivoCSV[intLinha], ';', '') = '' Then
    Exit('');

  FLocalizaValorCSV.Text := AnsiReplaceStr(FArquivoCSV[intLinha], ';',  #13#10 );

  //Ajusta caso falte alguma coluna;
  For i := FLocalizaValorCSV.Count -1 to FQtdColunasDef + 1 Do
    FLocalizaValorCSV.Add(#13#10);

  If Pos('CALC(', UpperCase(strColuna)) > 0 Then
    Result := fResolverFormula(intLinha, strColuna)
  Else
  Begin
    intColuna := fRetValorNumericoColuna(strColuna) -1;

    If intColuna <= FLocalizaValorCSV.Count Then
    Begin
      If FLocalizaValorCSV[intColuna] <> #13#10 Then
        Result := FLocalizaValorCSV[intColuna];
    End
    Else
     Result := '';
  End;
  intCont := 0;

  if (Result <> '') And (fRetCampo(strColuna).FTipo = tcFloat) then
    Result := StringReplace(Result, '.', '', []);

  If Result <> '' Then
  Begin
    Campo := fRetCampo(strColuna);
    If Campo.FstrColuna <> '' Then
    Begin
     If Campo.FCompletaZerosAEsquerda Then
       Result := fStrZero(Result, campo.FintTamanho);
    End;
  End;

  if (Result <> '') And (fRetCampo(strColuna).FTipo = tcString) then
    If (Result.StartsWith('"')) and (Result.EndsWith('"')) Then
    begin
      Result := Copy(Result, 2, result.Length -2);
      Result := AnsiReplaceStr(result , '""', '"');
    End;

  If blnCSV Then
  Begin
     for  x := 0 To Length(FArquivoCSV[intLinha]) do
     Begin
       If FArquivoCSV[intLinha].Length > 0 Then
       Begin
         If FArquivoCSV[intLinha][x] = ';' Then
           inc(intCont);
         If intCont = intColuna Then
         begin
           posIniCampo := x + 1;
           break;
         end;
       End;
     End
  End;
end;

function TValidadorExcel.fGetValueCSV(intLinha: integer; strColuna: string): string;
  var
   posinicampo: integer;
begin
   result := fGetValueCSV(intLinha, strColuna, posIniCampo);
end;

function TValidadorExcel.fLinhaVazia(intLinha: integer): Boolean;
begin
  Result :=  AnsiReplaceStr(FArquivoCSV[intLinha], ';', '') = '';
end;

function TValidadorExcel.fLocalizaColuna(strTitulo: string; var Index: integer; intLinha: Integer = -1): Boolean;
var i, iPos : integer;
    tmp: string;
begin
  index := -1;
  Result := False;
  iPos := -1;
  If intLinha > -1 Then
    iPos := Pos(strTitulo, FArquivoCSV.Strings[intLinha])
  Else
  Begin
    If FLinhaTitulo = -1 Then
    Begin
      for i := 0 To FArquivoCSV.Count -1 do
      Begin
        iPos := Pos(strTitulo, FArquivoCSV.Strings[i]);
        If iPos > 0 Then
        Begin
          FLinhaTitulo := i;
          Break;
        End;
      end;
    End
    Else If FLinhaTitulo > -1 Then
      iPos := Pos(strTitulo, FArquivoCSV.Strings[FLinhaTitulo]);
  End;

  If ((intLinha > - 1) Or (FLinhaTitulo > -1)) And (iPos > 0) Then
  Begin
    If intLinha > -1 Then
      tmp := Copy(FArquivoCSV.Strings[intLinha], 0, iPos)
    Else
      tmp := Copy(FArquivoCSV.Strings[FLinhaTitulo], 0, iPos);
    Index:= tmp.CountChar(';') + 1;
    Result := True;
  End
End;

function TValidadorExcel.fLocalizaColunaCSV(strTitulo: string; var Index: integer; intLinha: Integer = -1): Boolean;
begin
  Result := fLocalizaColuna(strTitulo, Index, intLinha);
end;

function TValidadorExcel.fLocalizaColunaCSV(strTitulo: String; Var strColuna: string; intLinha: Integer = -1): Boolean;
var index: integer;
Begin
  Result := fLocalizaColuna(strTitulo, index, intLinha);
  If Result Then
    strColuna := fGetLetraAlfa(index)
  Else
    strColuna := '';
End;


function TValidadorExcel.fMontaCampo(tcTipo: TTipoCampo;
                         strDescricao, strColuna: string;
                         intTamanho: integer = 0;
                         blnTamanhoFixo: boolean = False;  //Quando estiver marcado o campo tem que ter o tamanho fixo, senão apenas não pode ultrapassar
                         blnObrigatorio: boolean = false;
                         strTabela: String ='';
                         strCampoTabela: String= ''): TCampo;
begin
  Result.FTipo := tcTipo;
  Result.FintTamanho := intTamanho;
  Result.FblnTamanhoFixo := blnTamanhoFixo;
  Result.FstrColuna := strColuna;
  Result.FObrigatorio := blnObrigatorio;
  Result.FTabela := strTabela;
  Result.FCampoTabela := strCampoTabela;
  Result.FDescricao := strDescricao;
end;

function TValidadorExcel.fMontaCampoString(strDescricao, strColuna: String;
                                           intTamanho: integer = 0;
                                           blnTamanhoFixo: boolean = False;
                                           blnObrigatorio: boolean = false;
                                           strTabela: String ='';
                                           strCampoTabela: String = '';
                                           CompletaZerosAEsquerda: Boolean= False;
                                           funcValidacaoExterna: TValidacaoExterna = nil): TCampo;
Begin
  Result.FTipo := tcString;
  Result.FintTamanho := intTamanho;
  Result.FblnTamanhoFixo := blnTamanhoFixo;
  Result.FstrColuna := strColuna;
  Result.FObrigatorio := blnObrigatorio;
  Result.FTabela := strTabela;
  Result.FCampoTabela := strCampoTabela;
  Result.FDescricao := strDescricao;
  Result.FValidacaoExterna := funcValidacaoExterna;
  Result.fCompletaZerosAEsquerda := CompletaZerosAEsquerda;
End;

function TValidadorExcel.fMontaCampoListaCodigo(strDescricao, strColuna: string;
                                                blnObrigatorio: boolean;
                                                strTabela: String;
                                                strCampoTabela: String;
                                                charSeparador: char = ','): TCampo;
Begin
  Result.FTipo := tcLista;
  Result.FcharSeparador := charSeparador;
  Result.FstrColuna := strColuna;
  Result.FObrigatorio := blnObrigatorio;
  Result.FTabela := strTabela;
  Result.FCampoTabela := strCampoTabela;
  Result.FDescricao := strDescricao;
End;


function TValidadorExcel.fMontaCampoString(strDescricao, strColuna: String;
  intTamanho: integer; blnTamanhoFixo, blnObrigatorio: boolean;
  funcValidacao: TValidaCodigo): TCampo;
begin
  Result.FTipo := tcString;
  Result.FintTamanho := intTamanho;
  Result.FblnTamanhoFixo := blnTamanhoFixo;
  Result.FstrColuna := strColuna;
  Result.FObrigatorio := blnObrigatorio;
  Result.FvalidaCodigo := funcValidacao;
  Result.FDescricao := strDescricao;
end;

function TValidadorExcel.fMontaValidacaoLista(IdentLista: String;
  arrColunas:  variant; arrColunasOpcionais: Variant; funcValidacaoLista: TValidacaoLista): TCampo;
begin
  Result.FTipo := tcValidacaoLista;
  Result.FArrColunas := arrColunas;
  Result.FArrColunasOpc := arrColunasOpcionais;
  Result.FValidacaoLista := funcValidacaoLista;
  Result.FDescricao := IdentLista;
end;

function TValidadorExcel.fMontaValidacaoCampoEmbalagem(IdentLista: String; strColuna: String; funcValidacaoCampoEmbalagem: TValidacaoCampoEmbalagem): TCampo;
begin
  Result.FTipo := tcCampoEmbalagem;
  Result.FstrColuna := strColuna;
  Result.FDescricao := IdentLista;
  Result.FValidacaoCampoEmbalagem := funcValidacaoCampoEmbalagem;
end;

function TValidadorExcel.fMontaValidacaoCampoDescontoEmbalagem(IdentLista: String; strColuna: String; funcValidacaoCampoDescontoEmbalagem: TValidacaoCampoDescontoEmbalagem): TCampo;
begin
  Result.FTipo := tcCampoDescontoEmbalagem;
  Result.FstrColuna := strColuna;
  Result.FDescricao := IdentLista;
  Result.FValidacaoCampoDescontoEmbalagem  := funcValidacaoCampoDescontoEmbalagem
end;

function TValidadorExcel.fMontaValidacaoCampoTipoProdutoSped(IdentLista: String; strColuna: String; funcValidacaoCampoTipoProdutoSped: TValidacaoCampoTipoProdutoSped): TCampo;
begin
  Result.FTipo := tcCampoTipoProdutoSped;
  Result.FstrColuna := strColuna;
  Result.FDescricao := IdentLista;
  Result.FValidacaoCampoTipoProdutoSped := funcValidacaoCampoTipoProdutoSped;
end;

function TValidadorExcel.fMontaCampoFloat(strDescricao, strColuna: string; blnObrigatorio: boolean = false; funcValidacao: TValidacaoExterna = nil): TCampo;
begin
  Result.FTipo := tcFloat;
  Result.FstrColuna := strColuna;
  Result.FObrigatorio := blnObrigatorio;
  Result.FDescricao := strDescricao;
  Result.FValidacaoExterna := funcValidacao;
End;

function TValidadorExcel.fMontaCampoInt(strDescricao, strColuna: string; blnObrigatorio: boolean = false): TCampo;
begin
  Result.FTipo := tcInteger;
  Result.FstrColuna := strColuna;
  Result.FObrigatorio := blnObrigatorio;
  Result.FDescricao := strDescricao;
End;

function TValidadorExcel.fQtdColunasCSV: integer;
begin
  Result := FArquivoCSV[0].CountChar(';');
end;

function TValidadorExcel.fResolverFormula(intLinha: Integer; Value: String): String;
var strColuna: String;
    valCol: string;
    strFormulaTemp: String;
    i, PosIni: Integer;
    blnErro: Boolean;
    const
      Arr: TCharArray = ['$','%','&','=','#','@','!','¨'];
begin

 Value := AnsiReplaceStr(UpperCase(Value), 'CALC', '');

 If Value = '' Then
  Exit('');
 //Reescreve valores
 strColuna :=  '';
 PosIni := -1;
 i := 1;
 while (i <=  Length(Value)) Do
 Begin
   If Value[i].IsLetter Then
   Begin
     If PosIni = -1 Then
       PosIni := i;
     strColuna := strColuna + Value[i]
   End
   Else
   Begin
     If strColuna <> '' Then
     Begin
       valCol := fGetValueCSV(intLinha, strColuna);
       If ValCol = '' Then
         ValCol := '0';
       strFormulaTemp := Copy(Value, 0, i);
       strFormulaTemp := AnsiReplaceStr(strFormulaTemp, strColuna, valCol);
       Value := strFormulaTemp + Copy(Value, i + 1, Length(Value));
       i := PosIni + Length(ValCol);
       strColuna := '';
       PosIni := -1;
     End;
   End;
   Inc(i);
 End;

 i := 1;
 While i <= length(Value) do
 Begin
   If (Value[i].IsInArray(Arr)) Then
     Delete(value, i, 1)
   Else If (Value[i].IsLetter) Then
     Delete(value, i, 1)
   Else
     inc(i);
 End;
 Value := AnsiReplaceStr(Value , ',', '.');
 FQueryConsulta.SQL.Clear;


 Result := FloatToStr(fExecutaExpressao(Value, blnErro));

end;

function TValidadorExcel.fRetString(value: string): string;
begin
  Result := value;
end;

function TValidadorExcel.fRetTipoString(tccampo: TTipoCampo): string;
begin
  case tccampo of
    tcInteger: exit('Inteiro');
    tcFloat  : exit('Decimal');
    tcChar_SN: exit('"S" ou "N"');
    tcGirNiv : Exit('"A, B ou C"');
    tcChar_IR: EXIT('"I" ou "R"');
    tcNivCri : Exit('"X", "Y", ou "Z"');
    tcMltRca : Exit('"C", "V"');
    tcPercen : Exit('0 a 100');
  end;
end;

class function TValidadorExcel.fRetValorNumericoColuna(strColuna: string): integer;
  var i: integer;

  function fRetValorLetra(strLetra: char): integer;
  begin
    Result := 0;
    Case strLetra Of
      'A': Result :=  1;
      'B': Result :=  2;
      'C': Result :=  3;
      'D': Result :=  4;
      'E': Result :=  5;
      'F': Result :=  6;
      'G': Result :=  7;
      'H': Result :=  8;
      'I': Result :=  9;
      'J': Result :=  10;
      'K': Result :=  11;
      'L': Result :=  12;
      'M': Result :=  13;
      'N': Result :=  14;
      'O': Result :=  15;
      'P': Result :=  16;
      'Q': Result :=  17;
      'R': Result :=  18;
      'S': Result :=  19;
      'T': Result :=  20;
      'U': Result :=  21;
      'V': Result :=  22;
      'W': Result :=  23;
      'X': Result :=  24;
      'Y': Result :=  25;
      'Z': Result :=  26;
    end;
  End;
begin
  Result := 0;

  For I := 0 To Length(strColuna) -1 do
  Begin
    If Result = 0 Then
      Result := 1 * 26;
    Result := Result * fRetValorLetra(strColuna[I]);
  End;
  Result :=  result + fRetValorLetra(strColuna[Length(strColuna)]);

end;

function TValidadorExcel.fTemTitulo(strCampo: string; blnTestaComoFloat: Boolean = False): Boolean;
var intValDef: integer; fltValDef: Double;
begin
  If (FstrColunaValidaTitulo = '') And (strCampo <> '') Then
    FstrColunaValidaTitulo := strCampo;

  If fGetValueCSV(0, FstrColunaValidaTitulo) <> '' Then
  Begin
    If blnTestaComoFloat Then
      Result := Not TryStrToFloat(Trim(fGetValueCSV(0, FstrColunaValidaTitulo)), fltValDef)
    Else
      Result := not TryStrToInt(Trim(fGetValueCSV(0, FstrColunaValidaTitulo)), intValDef);
  End
  Else
    Result := False;
end;

function TValidadorExcel.fTrataDecimal(strValue: string): String;
begin
  Result := AnsiReplaceStr(strValue, '.', ',')
end;

function TValidadorExcel.fTrataTextoTempo(segundos: Integer): String;
var
  Seg, Min, Hora: Cardinal;
begin
  Result := '';
  Hora := Segundos div 3600;
  Seg := Segundos mod 3600;
  Min := Seg div 60;
  Seg := Seg mod 60;
  If Hora > 0 Then
    Result := FormatFloat('00', Hora) + 'hs. ';
  If Min > 0 Then
     Result :=  Result + FormatFloat('00', Min) + 'min.';
  Result :=  Result + FormatFloat('00', Seg) + 'seg.'
end;

function TValidadorExcel.fValidaCampos(blnExibirLog: boolean; ProgressBar : TcxProgressBar =  Nil): boolean;
begin
  Result := True;
  If Assigned(ProgressBar) Then

    fValidaCamposAux(ProgressBar)
  Else
  Begin
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.fExecutarAcao := fValidaCamposAux;
      frmGravando.lblGravando.Caption := 'Aguarde... Validando arquivo.';
      frmGravando.Showmodal;
    Finally
      FreeAndNil(frmGravando)
    End;
  End;

  if blnExibirLog and (frmLog.memLog.Lines.Count > 0)then
    frmLog.ShowModal
  else
    FLog.Text := frmLog.memLog.Lines.Text;
  if frmLog.memLog.Lines.Count > 0 Then
    Result := False;
end;


function TValidadorExcel.fRetCampo(strColuna: String): TCampo;
var blnEncontrou: Boolean;
    Ret: TCampo;
begin
  blnEncontrou := False;
  For Ret in FCampos do
  begin
    If Ret.FstrColuna =  strColuna Then
    Begin
      blnEncontrou:= True;
      Break;
    End
  End;

  result := Ret;

  if Not blnEncontrou then
    Result.pInit;
end;

function TValidadorExcel.fRetEmbalagens(strValorCampo: String): TCampoEmbalagemArr;
var
  Lista: TStringList;
  strValorElemento: String;
  I: Integer;
begin
  SetLength(Result, 0);

  If strValorCampo = '' Then
    Exit;

  Lista := TStringList.Create;
  Try
    Lista.Delimiter := ',';
    Lista.StrictDelimiter := True;
    For I := 0 To Length(strValorCampo) Do
    Begin
      If strValorCampo[i] = '(' Then
      Begin
        strValorElemento := '';
        SetLength(Result, Succ(Length(Result)));
      End
      Else If strValorCampo[i] = ')' Then
      begin
        Lista.DelimitedText := strValorElemento;
        strValorElemento := '';

        If Lista.Count > 0 Then
          Result[High(Result)].blnLeituraEfetuada := True;

        If Lista.Count >= 1 Then
          Result[High(Result)].strCodBar := TrimLeft(Lista.Strings[0]);
        If Lista.Count >= 2 Then
          Result[High(Result)].strCodFor := TrimLeft(Lista.Strings[1]);
        If Lista.Count >= 3 Then
          Result[High(Result)].fltEmbala := StrToFloatDef(fTrataDecimal(TrimLeft(Lista.Strings[2])), 1);
        If Lista.Count >= 4 Then
          Result[High(Result)].blnPrinci := UpperCase(TrimLeft(Lista.Strings[3])) = 'S';
        If Lista.Count >= 5 Then
          Result[High(Result)].blnCompra := UpperCase(TrimLeft(Lista.Strings[4])) = 'S';
        If Lista.Count >= 6 Then
          Result[High(Result)].blnExbFat := UpperCase(TrimLeft(Lista.Strings[5])) = 'S';
        If Lista.Count >= 7 Then
          Result[High(Result)].blnAtuCodBarCadIte := UpperCase(TrimLeft(Lista.Strings[6])) = 'S';
        If Lista.Count >= 8 Then
          Result[High(Result)].intTabPre := StrToIntDef(TrimLeft(Lista.Strings[7]), 0);
        If Lista.Count >= 9 Then
          Result[High(Result)].fltPreVen := StrToFloatDef(fTrataDecimal(TrimLeft(Lista.Strings[8])), 0);
        If Lista.Count >= 10 Then
          Result[High(Result)].strDescri := TrimLeft(Lista.Strings[9]);
        If Lista.Count >= 11 Then
          Result[High(Result)].fltAltura := StrToFloatDef(fTrataDecimal(TrimLeft(Lista.Strings[10])), 0);
        If Lista.Count >= 12 Then
          Result[High(Result)].fltLargur := StrToFloatDef(fTrataDecimal(TrimLeft(Lista.Strings[11])), 0);
        If Lista.Count >= 13 Then
          Result[High(Result)].fltProfun := StrToFloatDef(fTrataDecimal(TrimLeft(Lista.Strings[12])), 0);
        If Lista.Count >= 14 Then
          Result[High(Result)].intLastro := StrToIntDef(TrimLeft(Lista.Strings[13]), 0);
        If Lista.Count >= 15 Then
          Result[High(Result)].intCamada := StrToIntDef(TrimLeft(Lista.Strings[14]), 0);
        If Lista.Count >= 16 Then
          Result[High(Result)].intEmpMax := StrToIntDef(TrimLeft(Lista.Strings[15]), 0);
        If Lista.Count >= 17 Then
          Result[High(Result)].fltPesoBR := StrToFloatDef(fTrataDecimal(TrimLeft(Lista.Strings[16])), 0);
        If Lista.Count >= 18 Then
          Result[High(Result)].fltPesoLQ := StrToFloatDef(fTrataDecimal(TrimLeft(Lista.Strings[17])), 0);
      End
      Else
        strValorElemento := strValorElemento + strValorCampo[i];
    End;
  Finally
    FreeAndNil(Lista);
  End
End;


function TValidadorExcel.fRetDescontoEmbalagemFechada(strValorCampo: String): TCampoIteEmbalagemArr;
var
  Lista: TStringList;
  strValorElemento: String;
  I: Integer;
begin
  SetLength(Result, 0);

  If strValorCampo = '' Then
    Exit;

  Lista := TStringList.Create;
  Try
    Lista.Delimiter := ',';
    Lista.StrictDelimiter := True;
    For I := 0 To Length(strValorCampo) Do
    Begin
      If strValorCampo[i] = '(' Then
      Begin
        strValorElemento := '';
        SetLength(Result, Succ(Length(Result)));
      End
      Else If strValorCampo[i] = ')' Then
      begin
        Lista.DelimitedText := strValorElemento;
        strValorElemento := '';

//        If Lista.Count > 0 Then
//          Result[High(Result)].strITB_QTDEMB := StrToFloatDef(fTrataDecimal(TrimLeft(Lista.Strings[0])), 0);
//        If Lista.Count >= 1 Then
//          Result[High(Result)].strITB_DESCON := StrToFloatDef(fTrataDecimal(TrimLeft(Lista.Strings[1])), 0);
//        If Lista.Count >= 2 Then
//          Result[High(Result)].strITB_TABPRE := TrimLeft(Lista.Strings[2]);

        If Lista.Count > 0 Then
          Result[High(Result)].strITB_QTDEMB := TrimLeft(Lista.Strings[0]);
        If Lista.Count >= 1 Then
          Result[High(Result)].strITB_DESCON := TrimLeft(Lista.Strings[1]);
        If Lista.Count >= 2 Then
          Result[High(Result)].strITB_TABPRE := upperCase(TrimLeft(Lista.Strings[2]));
      End
      Else
        strValorElemento := strValorElemento + strValorCampo[i];
    End;
  Finally
    FreeAndNil(Lista);
  End
End;


procedure TValidadorExcel.pProcessaValidacaoCampoEmbalagem(ACampo: TCampo; intLinha: integer);
var strDivergencia,
    strValorCampo: string;
    intElemento: Integer;
    arrEmbalagens: TCampoEmbalagemArr;
begin
  strValorCampo := fGetValueCSV(intLinha, ACampo.FstrColuna);
  If strValorCampo <> '' Then
  Begin
    arrEmbalagens := fRetEmbalagens(strValorCampo);
    For intElemento := 0 To High(arrEmbalagens) Do
    Begin
      If Not ACampo.FValidacaoCampoEmbalagem(arrEmbalagens[intElemento], intLinha, strDivergencia) Then
      Begin
        frmLog.pAddLinha('A lista agrupada identificada como : ' + ACampo.FDescricao +  ' Linha [' + IntToStr(intLinha + 1) + '], a embalagem ' + intToStr(intElemento + 1) + ' foi encontrado divergencia:');
        frmLog.pAddLinha(strDivergencia);
      End;
    End;
  End;
End;

procedure TValidadorExcel.pProcessaValidacaoCampoDescontoEmbalagem(ACampo: TCampo; intLinha: integer);
var strDivergencia,
    strValorCampo: string;
    intElemento: Integer;
    arrIteEmbalagens: TCampoIteEmbalagemArr;
begin
  strValorCampo := fGetValueCSV(intLinha, ACampo.FstrColuna);
  If strValorCampo <> '' Then
  Begin
    arrIteEmbalagens := fRetDescontoEmbalagemFechada(strValorCampo);
    For intElemento := 0 To High(arrIteEmbalagens) Do
    Begin
      If Not ACampo.FValidacaoCampoDescontoEmbalagem(arrIteEmbalagens[intElemento], intLinha, strDivergencia) Then
      Begin
        frmLog.pAddLinha('A lista agrupada identificada como : ' + ACampo.FDescricao +  ' Linha [' + IntToStr(intLinha + 1) + '], foi encontrado divergencia:');
        frmLog.pAddLinha(strDivergencia);
      End;
    End;
  End;
End;

procedure TValidadorExcel.pProcessaValidacaoCampoTipoProdutoSped(
  ACampo: TCampo; intLinha: integer);
var strDivergencia,
    strValorCampo: string;
begin
  strValorCampo := fGetValueCSV(intLinha, ACampo.FstrColuna);
  If strValorCampo <> '' Then
  Begin
    If Not ACampo.FValidacaoCampoTipoProdutoSped(LeftStr(strValorCampo, 2), intLinha, strDivergencia) Then
    Begin
      frmLog.pAddLinha('A lista agrupada identificada como : ' + ACampo.FDescricao +  ' Linha [' + IntToStr(intLinha + 1) + '], tipo de produto(SPED) ' + strValorCampo + ' foi encontrado divergencia:');
      frmLog.pAddLinha(strDivergencia);
    End;
  End;
end;

procedure TValidadorExcel.pProcessaValidacaoLista(ACampo: TCampo; intLinha: integer);
var Pos: Integer;
  arrValues: Array of string;
  arrValuesLinha: Array of variant;
  intCol: Integer;
  Lista: TStringList;
  i,
  intQtdRows: Integer;
  strDivergencia: string;
  blnOpcional: Boolean;
  function fOpcional(strColunaAtual: string): Boolean;
   var loc: integer;
  Begin
    Result := False;
    If High(ACampo.FArrColunasOpc) > -1 Then
    Begin
      For loc := 0 To High(ACampo.FArrColunasOpc) Do
        If strColunaAtual = ACampo.FArrColunasOpc[loc] Then
          Exit(True);
    End;
  End;
begin
  SetLength(arrValues, High(ACampo.FArrColunas) + 1);
  Lista := TStringList.Create;
  Lista.Delimiter := ',';
  Lista.StrictDelimiter := True;
  For pos := 0 To High(ACampo.FArrColunas) do
  Begin
    arrValues[Pos] := fGetValueCSV(intlinha, ACampo.FArrColunas[Pos], intCol);
  End;
  intQtdRows := 0;

  //Verifica se todas as listas tem o mesmo tamanho
  If High(ACampo.FArrColunasOpc) > -1 Then

  For pos := 0 To High(ACampo.FArrColunas) Do
  Begin
    Lista.DelimitedText := arrValues[Pos];
    If intQtdRows = 0 Then
      intQtdRows := Lista.Count
    Else If intQtdRows <> Lista.Count Then
    Begin
      blnOpcional := fOpcional(ACampo.FArrColunas[Pos]);
      If (blnOpcional And (Lista.Count > intQtdRows)) Or (Not(blnOpcional)) Then
      Begin
        frmLog.pAddLinha('A lista agrupada identificada como : ' + ACampo.FDescricao +  ' Linha [' + IntToStr(intLinha + 1) + '] contém quantidade de elementos distintos, devem ter a mesma quantidade. Verifique a Ajuda!');
        Exit;
      End;
    End
  End;

  //Valida a lista
  SetLength(arrValuesLinha, High(ACampo.FArrColunas) + 1);
  For i := 0 To intQtdRows -1 Do
  Begin
    For pos := 0 To High(ACampo.FArrColunas) Do
    Begin
      Lista.DelimitedText := arrValues[Pos];
      If i < Lista.Count Then
        arrValuesLinha[Pos] := Lista.Strings[i]
      Else
        arrValuesLinha[Pos] := '';
    End;
    strDivergencia := '';
    If Not ACampo.FValidacaoLista(arrValuesLinha, intLinha, strDivergencia) Then
    begin
      frmLog.pAddLinha('A lista agrupada identificada como : ' + ACampo.FDescricao +  ' Linha [' + IntToStr(intLinha + 1) + '], na posição ' + intToStr(i) + ' foi encontrado divergencia:');
      frmLog.pAddLinha(strDivergencia);
    end;
  End;
end;

function TValidadorExcel.fValidaCamposAux(
  pgbProgresso: TcxProgressBar): Boolean;
   var
     Campo: TCampo;
     intRow, intCol: integer;
     value : Variant;
     ValidacoesPorSegundo,
     intPosIni: integer;
     horIni: TTime;
     qtdSegundos: Double;
     intQtdProcess: Integer;
     strMensagem: String;

begin
  blnCancela := False;
//  if blnCSV then
  If fTemTitulo(FstrColunaValidaTitulo) Then
    intPosIni := 1
  else
    intPosIni := 0;

  intQtdProcess := 0;
  pgbProgresso.Properties.Max := FintQtdLinhas * (High(FCampos) + 1);
  horIni := fTime();
  For intRow := intPosIni to FintQtdLinhas do
  begin
    For Campo in FCampos do
    begin
      If blnCancela Then
      Begin
        frmLog.pAddLinha('Validação cancelada pelo usuario.');
        Exit(False);
      end;

      If fLinhaVazia(intRow) Then
        Continue;

      If Campo.FTipo = tcValidacaoLista Then
      Begin
        if Assigned(Campo.FValidacaoLista) then
        Begin
          pProcessaValidacaoLista(Campo, intRow);
        End;
      End
      Else If Campo.FTipo = tcCampoEmbalagem Then
      Begin
        if Assigned(Campo.FValidacaoCampoEmbalagem) then
        Begin
          pProcessaValidacaoCampoEmbalagem(Campo, intRow);
        End;

      end
      Else If Campo.FTipo = tcCampoDescontoEmbalagem Then
      Begin
        if Assigned(Campo.FValidacaoCampoDescontoEmbalagem) then
        Begin
          pProcessaValidacaoCampoDescontoEmbalagem(Campo, intRow);
        End;

      end
      Else If Campo.FTipo = tcCampoTipoProdutoSped Then
      Begin
        if Assigned(Campo.FValidacaoCampoTipoProdutoSped) then
        Begin
          pProcessaValidacaoCampoTipoProdutoSped(Campo, intRow);
        End;

      end
      Else
      Begin
        value := fGetValueCSV(intRow, Campo.FstrColuna, intCol);

        If Campo.FTipo = tcLista Then //Se for uma lista de codigo, faz as validções Na rotina especifica porque tem que quebrar a lista;
          frmLog.pAddLinha(fValidaListaCodigo(Value, campo, intCol, intRow))
        Else
        Begin
          If (campo.FObrigatorio) And (Not fValidaCampoVazio(value, campo.FObrigatorio)) Then
          Begin
            if blnCSV then
              frmLog.pAddLinha(Campo.FDescricao + ' informação na coluna [' + IntToStr(intCol) + '] Linha [' + IntToStr(intRow + 1) + '] esta vazio, porém o valor é obrigatório, verificar manual')
            else
              frmLog.pAddLinha(Campo.FDescricao + ' informação na coluna [' + Campo.FstrColuna + IntToStr(intRow + 1) + '] esta vazio, porém o valor é obrigatório, verificar manual');
          End
          Else
          Begin
          //Apenas se tiver tamanho definido calcula ele
            If Campo.FintTamanho > 0 Then
            Begin
              If Not fValidaTamanho(value, Campo.FintTamanho, Campo.FblnTamanhoFixo) then
              begin
                if blnCSV then
                  frmLog.pAddLinha(campo.FDescricao + ' informação da coluna [' + IntToStr(intCol) + '] Linha [' + IntToStr(intRow + 1) + '] valor [' + VarToStr(value) + '] esta com tamanho errado, esperado = ' + IntToStr(Campo.FintTamanho))
                else
                  frmLog.pAddLinha(campo.FDescricao + ' informação do campo [' + Campo.FstrColuna + IntToStr(intRow + 1) + '] valor [' + VarToStr(value) + '] esta com tamanho errado, esperado = ' + IntToStr(Campo.FintTamanho));
              End;
            End;
            //O tipo só é preciso se for diferente de String
            If campo.FTipo <> tcString Then
            Begin
              if Not fValidaTipo(value, Campo.FTipo, campo.FObrigatorio) then
              begin
                if blnCSV then
                  frmLog.pAddLinha(Campo.FDescricao + ' informação na coluna [' + IntToStr(intCol) + ']  Linha [' + IntToStr(intRow + 1) + '] valor [' + VarToStr(value) + '] esta com tipo de dado errado, esperado = ' + fRetTipoString(Campo.FTipo))
                else
                  frmLog.pAddLinha(Campo.FDescricao + ' informação na coluna [' + Campo.FstrColuna + IntToStr(intRow + 1) + '] valor [' + VarToStr(value) + '] esta com tipo de dado errado, esperado = ' + fRetTipoString(Campo.FTipo));
              end;
            End;
            //Se tiver as informações de campo e tabela então valida
            if Assigned(Campo.FvalidaCodigo) then
            begin
               strMensagem := '';
               If not Campo.FvalidaCodigo(campo.FstrColuna, campo.FTabela, campo.FCampoTabela, value, strMensagem) Then
               begin
                 if (value <> '') then
                 Begin
                   If strMensagem <> '' Then
                   Begin
                     If Not blnCsv Then
                       frmLog.pAddLinha(campo.FDescricao + ' informação da coluna [' + Campo.FStrColuna + '] Linha [' + IntToStr(intRow + 1) + '] valor [' + fRetString(value) + ']' +  strMensagem)
                     Else
                       frmLog.pAddLinha(campo.FDescricao + ' informação da coluna [' + IntToStr(IntCol) + '] Linha [' + IntToStr(intRow + 1) + '] valor [' + fRetString(value) + ']' +  strMensagem);
                   End
                   Else If blnCSV then
                     frmLog.pAddLinha(campo.FDescricao + ' informação da coluna [' + IntToStr(intCol) + '] Linha [' + IntToStr(intRow + 1) + '] valor [' + fRetString(value) + '] não foi encontrado no cadastro, verificar manual e cadastro')
                   else
                     frmLog.pAddLinha(campo.FDescricao + ' informação do campo [' + Campo.FstrColuna + IntToStr(intRow + 1) + '] valor [' + fRetString(value) + '] não foi encontrado no cadastro, verificar manual e cadastro');
                 end;
               end;

            end;
            if Assigned(Campo.FValidacaoExterna) then
            begin
               strMensagem := '';
               If not Campo.FValidacaoExterna(Value, intRow, strMensagem) Then
               begin
                 if (value <> '') then
                 Begin
                   If strMensagem <> '' Then
                   Begin
                     If Not blnCsv Then
                       frmLog.pAddLinha(campo.FDescricao + ' informação da coluna [' + Campo.FStrColuna + '] Linha [' + IntToStr(intRow + 1) + '] valor [' + fRetString(value) + ']' + strMensagem)
                     Else
                       frmLog.pAddLinha(campo.FDescricao + ' informação da coluna [' + IntToStr(IntCol) + '] Linha [' + IntToStr(intRow + 1) + '] valor [' + fRetString(value) + ']' +  strMensagem);

                     If (blnUsaCdsErros) Then
                       pIncluirErroCds(campo.FDescricao, IIF(blnCsv, IntToStr(IntCol), Campo.FStrColuna), IntToStr(intRow + 1), strMensagem);
                   End
                 end;
               end;
            end;
          End;
        End;
      End;
      inc(intQtdProcess);
    end;
    Application.ProcessMessages;
    pgbProgresso.Position := intQtdProcess;
    If Assigned(FAtualizaStatus) Then
    Begin
      qtdSegundos := SecondsBetween(fTime(), HorIni);
      ValidacoesPorSegundo := Round(intQtdProcess/qtdSegundos);
      TempoExtimado := fTrataTextoTempo(Trunc((pgbProgresso.Properties.Max - intQtdProcess)/ValidacoesPorSegundo));
      TempoExtimado := 'Qtd. Por Segundo: ' + IntToStr(ValidacoesPorSegundo) + ' Tempo Estimado: ' + TempoExtimado;
      FAtualizaStatus;
      Application.ProcessMessages;
    End;
  end;
  Result := True
end;

function TValidadorExcel.fValidaCampoVazio(strValor: string;
  blnObrigatorio: Boolean): boolean;
begin
  if not blnObrigatorio then
     Exit(True);
  Exit(strValor <> '');
end;

function TValidadorExcel.fValidaTamanho(strvalor: string; intTamanho: integer; blnTamanhoFixo: Boolean): boolean;
{  var
    intDef: integer;
  function PreencheZeroEsquerda(Texto: string; Quant: integer): String;
  begin
    Result := Texto;
    Quant := intTamanho - Length(strvalor);
    if Quant > 0 then
       Result := StringOfChar('0', Quant) + strvalor;
  end;}
begin
  if (intTamanho = 0) or (strvalor =  '') then
    exit(True);
//  if blnCSV and TryStrToInt(strvalor, intDef) then
//    strvalor := PreencheZeroEsquerda(strvalor, intTamanho);
  If blnTamanhoFixo Then
    Result := Length(strvalor) = intTamanho
  Else
    Result := Length(strvalor) <= intTamanho;
end;

function TValidadorExcel.fValidaTipo(strValor: string; tccampo: TTipoCampo; blnObrigatorio: Boolean): boolean;
var intRet: integer;
    fltRet: Double;
begin
  intRet := 0;
  fltRet := 0;
  if strValor = '' Then
    Exit(True);
  if strValor <> '' then
  begin
    case tccampo of
      tcInteger: exit(TryStrToInt(strValor, intRet));
      tcFloat  : exit(TryStrToFloat(strValor, fltRet));
      tcChar_SN: Begin
                    If ((strValor = '') And (Not blnObrigatorio)) Then
                      Exit(True)
                    Else
                      exit((strValor = 'S') Or (strValor = 'N'));
                 End;
       tcGirNiv: Begin
                   If ((strValor = '') And (Not blnObrigatorio)) Then
                      Exit(True)
                   Else
                     exit((strValor = 'A') Or (strValor = 'B') Or (strValor = 'C'));
                 End;
      tcChar_IR: Begin
                    If ((strValor = '') And (Not blnObrigatorio)) Then
                      Exit(True)
                    Else
                      exit((strValor = 'I') Or (strValor = 'R'));
                 End;
       tcNivCri: Begin
                   If ((strValor = '') And (Not blnObrigatorio)) Then
                      Exit(True)
                   Else
                     exit((strValor = 'X') Or (strValor = 'Y') Or (strValor = 'Z'));
                 End;
       tcMltRca: Begin
                   If ((strValor = '') And (Not blnObrigatorio)) Then
                     Exit(True)
                   Else
                     exit((strValor = 'C') Or (strValor = 'V'));
                 End;
       tcPercen: Begin
                   If ((strValor = '') And (Not blnObrigatorio)) Then
                     Exit(True)
                   Else
                     If TryStrToFloat(strValor, fltRet) then
                       exit((StrToFloatDef(strValor, 0) >= 0) and (StrToFloatDef(strValor, 0) <= 100));
                 End;

    End;
  end;
  Result := True
end;

procedure TValidadorExcel.pAddCampo(Campo: TCampo);
begin
  SetLength(FCampos, Length(FCampos) + 1);
  If (campo.FTabela <> '') And (campo.FCampoTabela <> '') Then
     Campo.FvalidaCodigo := Self.fValidaCodigoInt;
  FCampos[Length(FCampos) -1] := Campo;

  If FQtdColunasDef < High(FCampos) Then
    FQtdColunasDef := High(FCampos) + 1;

end;

procedure TValidadorExcel.pCriaCamposCdsCodigosValidos;
begin
  FcdsCodigosValidos.FieldDefs.Add('ID', ftString, 20);
  FcdsCodigosValidos.FieldDefs.Add('VALIDO', FtInteger);
  FcdsCodigosValidos.CreateDataSet;
  FcdsCodigosValidos.IndexFieldNames := 'ID';
  FcdsCodigosValidos.LogChanges := False;
end;

procedure TValidadorExcel.pSalvaCSV(strCaminhoDoArquivo: string; LinhaInicial: integer = 0);
var FLApp: OLEVariant;
  blnBrOffice: Boolean;
  strTiPla: String;
begin
  strTiPla := fCfgSis('TIPPLA');

  If strTiPla.IsEmpty Or SameText(strTiPla, '1') Or SameText(strTiPla, '3') Then
  Begin
    blnBrOffice := False;

    Try
      Try
        FLApp := CreateOleObject('Excel.Application');
      Except
        blnBrOffice := True;
      End
    Finally
      If Not blnBrOffice Then
        FLApp.Quit;
    End;

  End Else
  Begin
    blnBrOffice := True;
  End;


  Try
    If blnBrOffice Then
       pSalvaCSV_BROffice(strCaminhoDoArquivo, LinhaInicial)
     Else
       pSalvaCSV_MSOffice(strCaminhoDoArquivo, LinhaInicial);
  Except
    On E: Exception Do
      raise Exception.Create(E.message + #$A#$D + 'Não foi possível criar o arquivo CSV.');
  End;

End;


procedure TValidadorExcel.pSalvaCSV_BROffice(strCaminhoDoArquivo: string; LinhaInicial: integer = 0);
var
  BrOffice,
  Dispatcher,
  Desktop,
  parametro,
  FPlanilha,
  Frame,
  Documento: Variant;
  x, i,intMaximoDeLinhas: integer;
  strValue: String;
  arqTmp: TStringList;
  blnGerou: Boolean;
  function fAtribuiProperty(Nome: String; Valor : Variant): Variant;
  var
    Reflec : Variant;
  begin
    Reflec := BrOffice.createInstance('com.sun.star.reflection.CoreReflection');
    Reflec.forName('com.sun.star.beans.PropertyValue').createObject(result);
    result.Name := Nome;
    result.Value:= Valor;
  end;

  function fFormataDir(strArquivo: String): String;
  begin
    Result:= '';
    If AnsiLowerCase(Copy(strArquivo,1,8)) <> 'file:///' Then
      Result := 'file:///';
    Result := Result + StringReplace(strArquivo, '\', '/', [rfReplaceAll, rfIgnoreCase]);
  End;

  function DummyArray: Variant;
  begin
    Result := VarArrayCreate([0, -1], varVariant);
  end;

  procedure pExecuta(Comand, ParametroNome: string; ParametroValor: Variant; blnVarArray: Boolean = False);
  Begin
    If Not blnVarArray Then
    Begin
      parametro := Unassigned;
      parametro := VarArrayCreate([0, 0], varVariant);
      parametro[0] := fAtribuiProperty(ParametroNome, ParametroValor);
      dispatcher.executeDispatch(Frame, Comand, '', 0, parametro);
    End
    Else
      dispatcher.executeDispatch(Frame, Comand, '', 0, DummyArray);
  end;

begin
  intMaximoDeLinhas := 0;
  BrOffice  := CreateOleObject('com.sun.star.ServiceManager');
  Desktop   := BrOffice.CreateInstance('com.sun.star.frame.Desktop');
  Try

    If FindWindow(nil, 'LibreOffice') > 0 Then
      ShowWindow(FindWindow(nil, 'LibreOffice'),SW_HIDE);

    If (uppercase(ExtractFileExt(strCaminhoDoArquivo)) = '.TXT') Then
    Begin
      parametro    := VarArrayCreate([0, 2], varVariant);
      parametro[0] := fAtribuiProperty('FilterName', 'Text - txt - csv (StarCalc)');
      parametro[1] := fAtribuiProperty('Hidden', True);

       parametro[2] := fAtribuiProperty('FilterOptions', '9');
    End
    Else
    Begin
      parametro    := VarArrayCreate([0, 0], varVariant);
      parametro[0] := fAtribuiProperty('Hidden', True);
    End;

    Documento := Desktop.LoadComponentFromURL(fFormataDir(strCaminhoDoArquivo), '_blank', 0, parametro);

    Documento.getCurrentController.getFrame.getContainerWindow.setVisible(False);

    If Not (uppercase(ExtractFileExt(strCaminhoDoArquivo)) = '.TXT') And
       Not (uppercase(ExtractFileExt(strCaminhoDoArquivo)) = '.CSV') Then
    Begin
      FPlanilha := Documento.getSheets.getByIndex(0);

      Documento.getCurrentController.getFrame.getContainerWindow.setVisible(False);


      Frame      := Documento.getCurrentController.getFrame;
      Dispatcher := BrOffice.createInstance('com.sun.star.frame.DispatchHelper');
      pExecuta('.uno:GoToEndOfData', '', '', True);
      intMaximoDeLinhas := Documento.getCurrentSelection.getCellAddress.Row + 1;



      If FSenha <> '' Then
      Begin
        FPlanilha.unprotect(FSenha);
        Documento.unprotect(FSenha);
      End;
      If LinhaInicial > 1 Then
      Begin
        Frame      := Documento.getCurrentController.getFrame;
        Dispatcher := BrOffice.createInstance('com.sun.star.frame.DispatchHelper');
        pExecuta('.uno:GoToEndOfData', '', '', True);
        intMaximoDeLinhas := Documento.getCurrentSelection.getCellAddress.Row + 1;

        pExecuta('.uno:GoToCell','ToPoint','$A$1');
        pExecuta('.uno:GoToStart', 'Sel', False);
        pExecuta('.uno:GoToEndOfRow', 'Sel', True);
        pExecuta('.uno:GoDownSel', 'By', LinhaInicial -2);
        pExecuta('.uno:Cut', '', '', True);
        pExecuta('.uno:GoToCell', 'ToPoint', '$A$' + IntToStr(intMaximoDeLinhas + 1));
        pExecuta('.uno:Paste', '', '', True);
        For i := 1 To LinhaInicial -1 Do
        Begin
          parametro := Unassigned;
          parametro := VarArrayCreate([0, 0], varVariant);
          parametro[0] := fAtribuiProperty('ToPoint', '$A$1');
          dispatcher.executeDispatch(Frame, '.uno:GoToCell', '', 0, parametro);

          parametro := Unassigned;
          parametro := VarArrayCreate([0, 0], varVariant);
          parametro[0] := fAtribuiProperty('Sel', '$A$1');
          dispatcher.executeDispatch(Frame, '.uno:GoToEndOfRow', '', 0, parametro);

          dispatcher.executeDispatch(Frame, '.uno:DeleteRows', '', 0, DummyArray);
        End;
      End;
    end;

    If High(FArrCamposReplaceCharEspecial) > 0 Then
    Begin

     For i := 1 To intMaximoDeLinhas Do
     Begin
       For x := 0 To High(FArrCamposReplaceCharEspecial) do
       Begin
          strValue :=   FPlanilha.getCellRangeByName(FArrCamposReplaceCharEspecial[x].FColuna + IntToStr(i)).getFormula;
          strValue := StringReplace(strValue, #$D#$A, IIf(FArrCamposReplaceCharEspecial[x].TipoReplaceEnter = trcetml, '<br>','<<csq>>'), [rfReplaceAll]);
          strValue := StringReplace(strValue, #$D#$A, IIf(FArrCamposReplaceCharEspecial[x].TipoReplaceEnter = trcetml, '<br>','<<csq>>'), [rfReplaceAll]);
          strValue := StringReplace(strValue, #$A, IIf(FArrCamposReplaceCharEspecial[x].TipoReplaceEnter = trcetml, '<br>','<<csq>>'), [rfReplaceAll]);
          strValue := StringReplace(strValue, #13#10, IIf(FArrCamposReplaceCharEspecial[x].TipoReplaceEnter = trcetml, '<br>','<<csq>>'), [rfReplaceAll]);
          strValue := StringReplace(strValue, #13, IIf(FArrCamposReplaceCharEspecial[x].TipoReplaceEnter = trcetml, '<br>','<<csq>>'), [rfReplaceAll]);
          strValue := StringReplace(strValue, ';', '.', [rfReplaceAll]);
          FPlanilha.getCellByPosition(fRetValorNumericoColuna(FArrCamposReplaceCharEspecial[x].FColuna)-1, i-1).String := strValue;
        End;
      End;
    End;

    parametro := Unassigned;
    parametro := VarArrayCreate([0, 2], varVariant);
    strCaminhoDoArquivo := AnsiReplaceStr(strCaminhoDoArquivo, ExtractFileExt(strCaminhoDoArquivo), '.csv');
    NomeArquivo := strCaminhoDoArquivo;

    parametro[0] := fAtribuiProperty('URL', NomeArquivo);
    parametro[1] := fAtribuiProperty('FilterName', 'Text - txt - csv (StarCalc)');
    parametro[2] := fAtribuiProperty('FilterOptions', '59,0,65535,1');
    Documento.StoreAsUrl(fFormataDir(strCaminhoDoArquivo), parametro);
    blnGerou := True;
  Finally
    Documento.Close(false);
    parametro := Unassigned;
    FPlanilha := Unassigned;
    Documento := Unassigned;
    Desktop.Terminate;
    Desktop:=Unassigned;
    BrOffice  := Unassigned;
  End;
  If (blnGerou) and (LinhaInicial > 1) Then
  Begin
    arqTmp :=TStringList.Create;
    Try
      arqTmp.LoadFromFile(strCaminhoDoArquivo);
      For i := 1 To LinhaInicial +1  do
      Begin
        arqTmp.Delete(arqTmp.Count -1)
      End;
      arqTmp.SaveToFile(strCaminhoDoArquivo);
    Finally
      FreeAndNil(arqTmp)
    End;
  End;
End;

procedure TValidadorExcel.pSalvaCSV_MSOffice(strCaminhoDoArquivo: string; LinhaInicial: integer = 0);
  var
    FLApp,
    FSheet: OLEVariant;
    x, i: integer;
    blnGerou: Boolean;
    arqTmp: TStringList;
    blnErro: Boolean;
    strValue: String;
    Celula: string;

begin
  blnErro := False;
  FLApp := CreateOleObject('Excel.Application');
  Try
    FLApp.Visible:=False;
    FLApp.DisplayAlerts := False;
    //Abre o Workbook
    Try
      FLApp.Workbooks.Open(strCaminhoDoArquivo);
    except
      on e: Exception do
      Begin
        blnErro:= True;
        blnGerou := False;
        raise Exception.Create(e.Message);
      End;

    End;

    FSheet:=FLApp.Workbooks[ExtractFileName(strCaminhoDoArquivo)].WorkSheets[1];
    strCaminhoDoArquivo := AnsiReplaceStr(strCaminhoDoArquivo, ExtractFileExt(strCaminhoDoArquivo), '.csv');

    If FSenha <> '' Then
    Begin
      FLApp.ActiveSheet.Unprotect(Password := FSenha);
      FLApp.ActiveWorkbook.Unprotect(Password := FSenha);
    End;

    NomeArquivo := strCaminhoDoArquivo;
    Try
       FSheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
    Except
      (*Erro silenciado quando a planilha for protegida por senha*)
    End;
    //Pegar o número da última linha
    FintQtdLinhas:= FLApp.ActiveCell.Row;
    //Pegar o número da última coluna
    FintQtdColunas:=FLApp.ActiveCell.Column;
    If LinhaInicial > 1 Then
    Begin
      FLApp.ActiveSheet.Range['A1', fGetLetraAlfa(FintQtdColunas) + IntToStr(LinhaInicial -1)].Select;
      FLApp.Selection.Cut;
      FLApp.ActiveSheet.Range['A' + IntToStr(FintQtdLinhas + 1)].Select;
      FLApp.ActiveSheet.Paste;

      If LinhaInicial > 0 Then
      Begin
        For i := 1 To LinhaInicial -1 Do
        Begin
          FLApp.ActiveWorkBook.ActiveSheet.Rows[1].delete;
        End;
      End;
    End;

    For i := 1 To FintQtdColunas do
    Begin
      Celula :=  FSheet.cells[1, i].Text;
      If Celula = '' Then
        FSheet.cells[1, i] := ''''
      Else
        Break;
    End;

    If High(FArrCamposReplaceCharEspecial) > 0 Then
    Begin

      For i := 1 To FintQtdLinhas Do
      Begin
        For x := 0 To High(FArrCamposReplaceCharEspecial) do
        Begin
          strValue := FSheet.cells[i, fRetValorNumericoColuna(FArrCamposReplaceCharEspecial[x].FColuna)].Text;
          strValue := StringReplace(strValue, #$D#$A, IIf(FArrCamposReplaceCharEspecial[x].TipoReplaceEnter = trcetml, '<br>','<<csq>>'), [rfReplaceAll]);
          strValue := StringReplace(strValue, #$D#$A, IIf(FArrCamposReplaceCharEspecial[x].TipoReplaceEnter = trcetml, '<br>','<<csq>>'), [rfReplaceAll]);
          strValue := StringReplace(strValue, #$A, IIf(FArrCamposReplaceCharEspecial[x].TipoReplaceEnter = trcetml, '<br>','<<csq>>'), [rfReplaceAll]);
          strValue := StringReplace(strValue, #13#10, IIf(FArrCamposReplaceCharEspecial[x].TipoReplaceEnter = trcetml, '<br>','<<csq>>'), [rfReplaceAll]);
          strValue := StringReplace(strValue, #13, IIf(FArrCamposReplaceCharEspecial[x].TipoReplaceEnter = trcetml, '<br>','<<csq>>'), [rfReplaceAll]);
          strValue := StringReplace(strValue, ';', '.', [rfReplaceAll]);
          FSheet.Cells[i, fRetValorNumericoColuna(FArrCamposReplaceCharEspecial[x].FColuna)] := strValue;
        End;
      End;
    End;

    FSheet.SaveAs(strCaminhoDoArquivo,
                  xlCSV,
                  Null,
                  Null,
                  False,
                  False,
                  1,
                  2,
                  False,
                  True);   //parametro responsavel por salver em CSV
    blnGerou := True;

  Finally
    If not blnErro Then
      FLApp.Workbooks[ExtractFileName(strCaminhoDoArquivo)].Close(True);
    FLApp.Quit;
    FLAPP:=Unassigned;
    FSheet:=Unassigned;
  End;
  If (blnGerou) and (LinhaInicial > 1) Then
  Begin
    arqTmp :=TStringList.Create;
    Try
      arqTmp.LoadFromFile(strCaminhoDoArquivo);
      For i := 1 To LinhaInicial +1  do
      Begin
        arqTmp.Delete(arqTmp.Count -1)
      End;
      arqTmp.SaveToFile(strCaminhoDoArquivo);
    Finally
      FreeAndNil(arqTmp)
    End;
  End;

end;

function TValidadorExcel.RetornaQuantdadeColunasLinha(
  const Alinha: Integer): Integer;
begin
  if FArquivoCSV.Count > 0 then
    Result := FArquivoCSV[Alinha].CountChar(';') + 1
  else
    Result := 0;
end;

Function TValidadorExcel.fExecutaExpressao(strExpressao: String; Var blnErro: Boolean): Double;
  Var
    strExpres: String;
    fscScript : TfsScript;
Begin
  Result := 0;
  blnErro := False;
  fscScript := TfsScript.Create(Nil);
  Try
    fscScript.SyntaxType := 'PascalScript';
    strExpres := Trim(strExpressao);
    fscScript.AddType('Double' , fvtFloat);
    fscScript.Lines.Clear;
    fscScript.Lines.Add('Function Expressao: Double;');
    fscScript.Lines.Add('Begin');
    fscScript.Lines.Add('  Result := ');
    fscScript.Lines.Add(strExpres);
    fscScript.Lines.Add('End;');
    fscScript.Lines.Add('Begin');
    fscScript.Lines.Add('End.');
    Try
       blnErro := Not fscScript.Compile;

      If Not blnErro Then
        Result := fscScript.Evaluate(strExpressao);


    Except
      On E: Exception Do
      Begin
        Result := 0;
        pMensagensErro(strExpressao + ' - ' + E.Message, '[TValidadorExcel.fExecutaExpressao]');
      End;
    End
  Finally
    FreeAndNil(fscScript);
  End
End;

procedure TValidadorExcel.pCriaCdsErros;
begin
  cdsErros := TUniClientDataSet.Create(Nil);
  pIncluiCampoCds(cdsErros, TStringField, 'LOG_DESCRI', 'cdsErrosDESCRICAO', 20);
  pIncluiCampoCds(cdsErros, TStringField, 'LOG_NUMCOL', 'cdsErrosCOLUNA', 1);
  pIncluiCampoCds(cdsErros, TStringField, 'LOG_NUMLIN', 'cdsErrosLINHA', 5);
  pIncluiCampoCds(cdsErros, TStringField, 'LOG_MENSAG', 'cdsErrosMENSAGEM', 100);
  cdsErros.CreateDataSet;
end;

procedure TValidadorExcel.pIncluiCampoCds(Var cdsDados: TUniClientDataSet; objFieldClass: TFieldClass; strFieldName, strName: String; intSize: Integer);
  Var
    objField: TField;
begin
  objField := objFieldClass.Create(Nil);
  objField.FieldName := strFieldName;
  objField.Name := strName;
  objField.Size := intSize;
  objField.DataSet := cdsDados;
end;

procedure TValidadorExcel.pIncluirErroCds(strDescricao, strColuna, strLinha, strMensagem: String);
begin
  cdsErros.Append;
  cdsErros.FieldByName('LOG_DESCRI').AsString := strDescricao;
  cdsErros.FieldByName('LOG_NUMCOL').AsString := strColuna;
  cdsErros.FieldByName('LOG_NUMLIN').AsString := strLinha;
  cdsErros.FieldByName('LOG_MENSAG').AsString := strMensagem;
  cdsErros.Post;
end;

function TValidadorExcel.getCdsErros: TUniClientDataSet;
begin
  Result := cdsErros;
end;

{ TCampo }

procedure TCampo.pInit;
begin
  FTipo := tcString;
  FintTamanho := 0;
  FblnTamanhoFixo := False;
  FstrColuna := '';
  FvalidaCodigo := nil;
  FObrigatorio := False;
  FcharSeparador := #0;
  FTabela := '';
  FCampoTabela := '';
  FDescricao := '';
  FValidacaoLista := nil;
  FValidacaoCampoEmbalagem := nil;
  FValidacaoCampoDescontoEmbalagem := nil;
  FCompletaZerosAEsquerda  := False;
  FValidacaoExterna        := nil;
  FValidacaoCampoTipoProdutoSped := nil;
end;

end.
