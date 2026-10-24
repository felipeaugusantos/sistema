
unit ImportacaoDados.Model.ImportacaoArquivo;

interface

uses
  ImportacaoDados.Interfaces, Uni, untTValidaExcel, cxProgressBar, System.Generics.Collections,
  Classes, SysUtils, DB, UniClientDataSet, Windows, Forms, untTypesSistema;

Type
  TCampoLinha = Class;
  TValidacaoDadosImportacao = class;

  TLinha = Class(TInterfacedObject, ILinha)
  private
    FLinha: TList<ICampoLinha>;
    FNumeroLinha: Integer;
    FblnTabelaPrincipal: Boolean;
    FStrNomTab: String;

    function GetLinha: TList<ICampoLinha>;
    function GetNumeroLinha: Integer;
    procedure SetLinha(Const aValue: TList<ICampoLinha>);
    procedure SetNumeroLinha(Const aValue: Integer);
    function GetblnTabP: Boolean;
    procedure SetblnTabP(const aValue: Boolean);
    function GetNomTab: String;
    procedure SetNomTab(const aValue: String);

  public
    constructor Create;
    destructor Destroy; override;
    property Campos: TList<ICampoLinha> read GetLinha  write SetLinha;
    property NumeroLinha: Integer read GetNumeroLinha write SetNumeroLinha;
    class function New: ILinha;
    function AddCampo: ICampoLinha;
    property blnTabelaPrincipal: Boolean read GetblnTabP write SetblnTabP;
    property strNomeTabela: String read GetNomTab write SetNomTab;
  End;

  TCampoLinha = Class(TInterfacedObject, ICampoLinha)
  [weak]
  private
    FCampo: TCampoPlanilha;
    FLinha: ILinha;
    function GetPropriedades: TCampoPlanilha;
    procedure SetPropriedades(Const aValue: TCampoPlanilha);
  public
    constructor Create(Parent: ILinha);
    class function Add(Const aLinha: ILinha): ICampoLinha;

    property Propriedades: TCampoPlanilha read GetPropriedades write SetPropriedades;
  End;

  TInconsistencia = Class(TInterfacedObject, IInconsistencia)
  private
    FLinhas : TList<ILinha>;
    FListaInconsistencias: TList<TRegInconsistencia>;
    function GetLinha: TList<ILinha>;
    procedure SetLinha(const aValue: TList<ILinha>);
    function GetInconsistencias: TList<TRegInconsistencia>;
    procedure SetInconsistencias(const aValue: TList<TRegInconsistencia>);
  public
    constructor Create;
    destructor Destroy; override;

    function AddLinha: ILinha;
    function Add: TRegInconsistencia;

    property Linhas: TList<ILinha> read GetLinha write SetLinha;
    property Inconsistencias: TList<TRegInconsistencia> read GetInconsistencias write SetInconsistencias;
  End;

  TImportaPlanilha = Class(TInterfacedObject, IImportaPlanilha)
  Private
    FEstadoTela: TTipoEstadoTela;
    FCaminhoArquivo: string;
    FModeloArquivo: IModeloArquivoImportacao;
    objValidaExcel: TValidadorExcel;
    FPosicaoInicial: Integer;
    FcxProgresso: TCxProgressBar;
    FLinhasImportadas : TList<ILinha>;
    FLinhasImportadasTab : TList<ILinha>;
    FValida: IValidaDados;
    FModeloTabela: IModeloArquivoImportacao;
    FncCancelouOperacao : TReferenceBooleanFunction;
    function GetCaminhoArquivo: String;
    procedure SetCaminhoArquivo(Const aValue: String);
    function GetEstadoTela: TTipoEstadoTela;
    procedure SetEstadoTela(Const aValue: TTipoEstadoTela);
    function GetLinha: TList<ILinha>;
    procedure SetLinha(const aValue: TList<ILinha>);
    function GetModelo: IModeloArquivoImportacao;
    function GetValida: IValidaDados;
    procedure SetValida(Const aValue: IValidaDados);
    function GetProgresso: TCxProgressBar;
    procedure SetProgresso(Const aValue: TCxProgressBar);
    function fProcessarImportacaoArquivo(const ACxProgresso: TCxProgressBar; const FncCancelouOperacao : TReferenceBooleanFunction): Boolean;
    function fPreparaLinha(aCampo: TCampoPlanilha; intLinha: integer;
      strLinha, strColuna: string): String;
    function fRetornaCampoLinhaTabela(aModelo: IModeloArquivoImportacao; var aConteudo: String;
      strNomeTabela: String; intPos: Integer; blnCampoLig: Boolean = False): TCampoPlanilha;
    function fRetornaModeloTabela(const aNomeTabela: String): IModeloArquivoImportacao;
    function fCalculaNroLinhasTabela(const strLinha: String): Integer;
    function fVerificaAdicionarLinhaTab(aModelo: IModeloArquivoImportacao; intQtdLinhasTab: Integer;
      intNroLinha: Integer): Boolean;
    procedure pProcessarLinhaTabela(aLinha: ILinha; aCampo: TCampoPlanilha; strConteudoLinha: String; strCmpLig: String);
    procedure pAdicionarLinhasImportadasTabela(aLinha: ILinha);
    function fCancelouOperacao(const FncCancelouOperacao : TReferenceBooleanFunction) : Boolean;
   public
    constructor Create(Const aModelo: IModeloArquivoImportacao; const ACancelouOperacao : TReferenceBooleanFunction); virtual;
    destructor Destroy; override;

    function fProcessarArquivo(Const aCaminhoArquivo: String): Boolean; overload; virtual;
    function fProcessarArquivo(Const aCaminhoArquivo: String; const ACxProgresso: TCxProgressBar; const FncCancelouOperacao : TReferenceBooleanFunction): Boolean; overload; virtual;
    function fReprocessarArquivo: Boolean; virtual;
    function fInserirCadastros: Boolean; virtual; abstract;
    function fAtualizarDadosImportados(Const aCds: TUniClientDataSet): Boolean; virtual;
    procedure pLimparCampos;
    procedure pLimparProcessamento(const blnApenasTabelaPrincipal: Boolean = False);
    property CaminhoArquivo: string read GetCaminhoArquivo write SetCaminhoArquivo;
    property EstadoTela: TTipoEstadoTela read GetEstadoTela write SetEstadoTela;
    property LinhasImportadas: TList<ILinha> read GetLinha write SetLinha;
    property Modelo: IModeloArquivoImportacao read GetModelo;
    property Valida: IValidaDados read GetValida write SetValida;
    property cxProgresso: TCxProgressBar read GetProgresso write SetProgresso;
  End;

  TValidacaoDadosImportacao =  Class(TInterfacedObject, IValidaDados)
    FInconsistencias: IInconsistencia;
    FArquivoImportacao: IImportaPlanilha;
  private
    function GetInconsistencias: IInconsistencia;
    procedure SetInconsistencias(const aValue: IInconsistencia);
    function GetArquivoImportacao: IImportaPlanilha;
    procedure SetArquivoImportacao(const aValue: IImportaPlanilha);
    function fValidarCampoObrigatorio(const aObrigatorio: Boolean; const aConteudo: String): Boolean;
    function fValidarTipoCampo(const aFieldType: TFieldType; const aConteudo: String): Boolean;
    function fConvertVazioToFloat(aValue: String): Double;
    function fValidarTamanhoCampo(const aPropriedades: TCampoPlanilha): Boolean;
    procedure pAdicionaInconsistencia(Const aLinha: ILinha; Const Coluna, Campo, Mensagem: String);virtual;
    procedure pSetarLinhaPadraoModelo;
  public
    constructor Create(aArquivoImportacao: IImportaPlanilha);virtual;
    destructor Destroy; override;
    function fValidar: Boolean; virtual;
    function fValidarLinha(Const aLinha: ILinha): Boolean; virtual;
    procedure pAtualizarParametrosValidacao; virtual;
    procedure pLimpar; virtual;
    property Arquivo: IImportaPlanilha read GetArquivoImportacao write SetArquivoImportacao;
    property Inconsistencias: IInconsistencia read GetInconsistencias write SetInconsistencias;
    function fAdicionaInconsistenciaLista(Const aLinha: ILinha; Const Coluna, Campo, Mensagem: String): IInconsistencia;
    function fRetornaCampoCodigo(const strCodTmp: String; intTamCampo: Integer): String; virtual;

  const
    cstValidacaoCampoObrigatorio = 'Campo obrigatório deve ser informado.';
    cstValidacaoTipoCampo        = 'Dados incompatíveis com o tipo de campo da coluna.';
    cstValidacaoTamanhoCampo     = 'Texto informado excede o tamanho do campo permitido no banco de dados.';
    cstValidacaoCampoData        = 'Campo tipo "Data" inválido. Informe a data no formato DD/MM/YYYY.';
  End;

implementation

uses
  untFuncoesSimples, strUtils, untGravando;

{ TImportaPlanilha }

constructor TImportaPlanilha.Create(Const aModelo: IModeloArquivoImportacao; const ACancelouOperacao : TReferenceBooleanFunction);
begin
  FModeloArquivo := aModelo;
  FcxProgresso := TCxProgressBar.Create(nil);
  FLinhasImportadas := TList<ILinha>.Create;
  FLinhasImportadasTab := TList<ILinha>.Create;
  FncCancelouOperacao := ACancelouOperacao;
end;

destructor TImportaPlanilha.Destroy;
begin
  inherited;

  cxProgresso.Parent := Nil;
  FreeAndNil(FcxProgresso);
  FreeAndNil(FLinhasImportadas);
  FreeAndNil(FLinhasImportadasTab);
end;

function TImportaPlanilha.fAtualizarDadosImportados(
  const aCds: TUniClientDataSet): Boolean;
var
  intLinha: integer;
  strLinha: string;
  intCnt: Integer;
  Campo: ICampoLinha;
  xLinha,
  xLinhatTAB: ILinha;
  xCampo: TCampoPlanilha;
  IndiceLinhaAux: Integer;
begin
  aCds.DisableControls;
  Try
    Try
      intLinha := 0;

      pLimparProcessamento(True);

      aCds.First;
      While not(aCds.Eof) Do
      Begin
        xLinha := TLinha.New;
        Inc(intLinha);
        xLinha.NumeroLinha := intLinha;
        xLinha.strNomeTabela := FModeloArquivo.strNomTabela;

        For intCnt := 0 to FModeloArquivo.Campos.Count-1  Do
        Begin
          If Not fEmptyStr(FModeloArquivo.Campos[intCnt].Coluna) And (Not FModeloArquivo.Campos[intCnt].blnTabela) Then
          Begin
            Campo := xLinha.AddCampo;
            strLinha := aCds.FieldByName(FModeloArquivo.Campos[intCnt].NomeCampo).AsString;

            xCampo.NomeCampo := FModeloArquivo.Campos[intCnt].NomeCampo;
            xCampo.DescricaoCampo := FModeloArquivo.Campos[intCnt].Descricao;
            xCampo.Coluna := FModeloArquivo.Campos[intCnt].Coluna;
            xCampo.Posicao := FModeloArquivo.Campos[intCnt].Posicao;
            xCampo.Obrigatorio := FModeloArquivo.Campos[intCnt].Obrigatorio;
            xCampo.TipoCampo := FModeloArquivo.Campos[intCnt].TipoCampo;
            xCampo.Tamanho := FModeloArquivo.Campos[intCnt].Tamanho;
            xCampo.blnTabela := FModeloArquivo.Campos[intCnt].blnTabela;
            xCampo.blnExibirTextoPuro := IIF(FModeloArquivo.Campos[intCnt].NomeCampo = 'ITE_NUMLOT', True, False);
            xCampo.Conteudo := strLinha;

            If (FModeloArquivo.Campos[intCnt].blnTabela) or (FModeloArquivo.Campos[intCnt].Tamanho = 0) Then
            Begin
              xCampo.blnValidarTamanho := False;
            End
            Else
              xCampo.blnValidarTamanho := True;
            Campo.Propriedades := xCampo;
          End;
        End;

        If Assigned(FValida) Then
          FValida.fValidarLinha(xLinha);

        FLinhasImportadas.Add(xLinha);

        FcxProgresso.Position := FcxProgresso.Position + 1;

        For IndiceLinhaAux:=0 To FLinhasImportadasTab.Count-1 Do
        Begin
          xLinhatTAB := FLinhasImportadasTab[IndiceLinhaAux];
          If xLinhatTAB.NumeroLinha = xLinha.NumeroLinha Then
          Begin
            FValida.fValidarLinha(xLinhatTAB);
            FLinhasImportadas.Add(xLinhatTAB);
          End;
        End;

        aCds.Next;
      End;

      Result := FValida.Inconsistencias.Inconsistencias.Count <= 0;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[TImportaPlanilha.fAtualizarDadosImportados]');
      End;
    End;
  Finally
    aCds.EnableControls;
  End;
end;

function TImportaPlanilha.fCalculaNroLinhasTabela(
  const strLinha: String): Integer;
var
  strConteudo: String;
  intPos: Integer;
  intQtd: Integer;
begin
  strConteudo := strLinha;
  intQtd := 0;
  Repeat

    intPos := Pos(',', strConteudo);
    strConteudo   := Copy(strConteudo, intPos+ 1, Length(strConteudo));

    If intPos <= 0 Then
      strConteudo := EmptyStr;

    Inc(intQtd);

  Until  (strConteudo = EmptyStr);

  Result :=  intQtd;

end;

function TImportaPlanilha.fRetornaCampoLinhaTabela(aModelo: IModeloArquivoImportacao; var aConteudo: String;
  strNomeTabela: String; intPos: Integer; blnCampoLig: Boolean = False): TCampoPlanilha;
var
  xCampo: TCampoPlanilha;
  strConteudo: String;
  intPosSep: Integer;
  intTam: Integer;
begin
  If blnCampoLig Then
  Begin
    strConteudo := aConteudo;
  End
  Else
  Begin
    intPosSep := Pos(',', aConteudo);
    intTam    := IIF(intPosSep > 0,  intPosSep-1, Length(aConteudo));
    strConteudo := Copy(aConteudo, 0, intTam);
    aConteudo   := Copy(aConteudo, intPosSep+ 1, Length(aConteudo));

    If intPosSep <= 0 Then
      aConteudo := EmptyStr;
  End;

  xCampo.NomeCampo := aModelo.Campos[intPos].NomeCampo;
  xCampo.DescricaoCampo := aModelo.Campos[intPos].Descricao;
  xCampo.Coluna := aModelo.Campos[intPos].Coluna;
  xCampo.Posicao := aModelo.Campos[intPos].Posicao;
  xCampo.Obrigatorio := aModelo.Campos[intPos].Obrigatorio;
  xCampo.TipoCampo := aModelo.Campos[intPos].TipoCampo;
  xCampo.Tamanho := aModelo.Campos[intPos].Tamanho;
  xCampo.Conteudo := strConteudo;

  Result := xCampo;
end;

function TImportaPlanilha.fRetornaModeloTabela(
  const aNomeTabela: String): IModeloArquivoImportacao;
var
  intCnt: Integer;
begin
  For intCnt:=0 To FModeloArquivo.ListaModeloTabelas.Count-1 Do
  Begin
    If Pos(FModeloArquivo.ListaModeloTabelas[intCnt].strNomTabela, aNomeTabela) > 0 Then
    Begin
      Result := FModeloArquivo.ListaModeloTabelas[intCnt];
      Break;
    End;
  End;
end;

function TImportaPlanilha.fVerificaAdicionarLinhaTab(
  aModelo: IModeloArquivoImportacao; intQtdLinhasTab: Integer;
  intNroLinha: Integer): Boolean;
var
  intCnt: Integer;
  intQtdLinhasCriadas: Integer;
begin
  intQtdLinhasCriadas := 0;
  For intCnt := 0 To FLinhasImportadasTab.Count-1 Do
  Begin
    If (aModelo.strNomTabela = FLinhasImportadasTab[intCnt].strNomeTabela) And
       (FLinhasImportadasTab[intCnt].NumeroLinha = intNroLinha) Then
    Begin
      Inc(intQtdLinhasCriadas);
    End;
  End;

  Result := Not(intQtdLinhasTab = intQtdLinhasCriadas);
end;

function TImportaPlanilha.fProcessarArquivo(const aCaminhoArquivo: String): Boolean;
begin
  pLimparCampos;
  FCaminhoArquivo := aCaminhoArquivo;
  Result := fProcessarImportacaoArquivo(FcxProgresso, FncCancelouOperacao);
end;

function TImportaPlanilha.fProcessarArquivo(Const aCaminhoArquivo: String; const ACxProgresso: TCxProgressBar; const FncCancelouOperacao : TReferenceBooleanFunction): Boolean;
begin
  pLimparCampos;
  FCaminhoArquivo := aCaminhoArquivo;
  Result := fProcessarImportacaoArquivo(ACxProgresso, FncCancelouOperacao);
end;

function TImportaPlanilha.fReprocessarArquivo: Boolean;
begin
  Result := fProcessarImportacaoArquivo(FcxProgresso, FncCancelouOperacao);
end;

function TImportaPlanilha.fPreparaLinha(aCampo: TCampoPlanilha; intLinha: integer;
  strLinha, strColuna: string): String;
begin
  If Not Assigned(objValidaExcel) Then
    Exit;

  Try
    Try
      strLinha := objValidaExcel.fGetValueCSV(intLinha, strColuna);
      If Pos('@', strLinha) > 0 Then
      Begin
        strLinha := AnsiReplaceStr(strLinha, '"', '');
      End;

      Case aCampo.TipoCampo Of
        ftFloat : Begin
                    If (strLinha.Contains(FormatSettings.ThousandSeparator) And strLinha.Contains(FormatSettings.DecimalSeparator)) Then
                      strLinha := strLinha.Replace('.', '');
                    strLinha := strLinha.Replace('.', ',');

                    strLinha := fTiraCaracEspeciais(strLinha,True,True,False,True,True,False);
                  End;
        ftDateTime:Begin
                    strLinha := strLinha;
                   End;
        Else
        Begin
          If Not aCampo.blnTabela Then
          Begin
            If (Not aCampo.blnExibirTextoPuro) And (Not Pos('@', strLinha) > 0) Then
              strLinha := fTiraCaracEspeciais(strLinha);
          End;
        End;
      End;

    Except
      strLinha := EmptyStr;
    End;
  Finally
    Result := strLinha;
  End;
end;

function TImportaPlanilha.fProcessarImportacaoArquivo(const ACxProgresso: TCxProgressBar; const FncCancelouOperacao : TReferenceBooleanFunction): Boolean;
var
  intLinha: integer;
  strColuna: string;
  strLinha: string;
  intCnt: Integer;
  Campo: ICampoLinha;
  xLinha: ILinha;
  xCampo: TCampoPlanilha;
  strCmpLig: String;
  strNomeArquivo : String;

begin
  Result := False;

  pLimparProcessamento;

  If FCaminhoArquivo = EmptyStr Then
  Begin
    Raise Exception.Create('Arquivo de importação não foi informado');
    Exit;
  End;

  If fEmptyStr(FModeloArquivo.AutoIncrem) Then
  Begin
    Raise Exception.Create('Modelo do arquivo de importação não foi informado');
    Exit;
  End;

  If fCancelouOperacao(FncCancelouOperacao) Then
    Exit(False);

  objValidaExcel := TValidadorExcel.Create(FCaminhoArquivo, 0, '', '', FPosicaoInicial);
  Try
    Try
      ACxProgresso.Properties.Max := objValidaExcel.ArquivoCSV.Count;
      ACxProgresso.Position := 0;
      Application.ProcessMessages;

      FModeloArquivo.fCarregarCampos;

      For intLinha := 0 To (objValidaExcel.ArquivoCSV.Count -1) Do
      Begin
        If fCancelouOperacao(FncCancelouOperacao) Then
          Exit(False);

        If objValidaExcel.fLinhaVazia(intLinha) Then
        Begin
          ACxProgresso.Position := ACxProgresso.Position + 1;
          Application.ProcessMessages;
          Continue;
        End;

        xLinha := TLinha.New;
        xLinha.NumeroLinha := intLinha +1;
        xLinha.strNomeTabela := FModeloArquivo.strNomTabela;
        For intCnt := 0 to FModeloArquivo.Campos.Count-1  Do
        Begin
          If fCancelouOperacao(FncCancelouOperacao) Then
            Exit(False);

          strColuna := FModeloArquivo.Campos[intCnt].Coluna;
          {Se a coluna for preenchida será feita a importação do campo, senão ele não será considerado no modelo.
          Alteração realizada pois existem modelos que não terá os demais campos não obrigatórios,
          portanto deve permitir ao usuário excluir a coluna ou adicionar a coluna caso for usar o campo - KM}
          If (Not(fEmptyStr(FModeloArquivo.Campos[intCnt].Codigo))) And  (not fEmptyStr(strColuna)) Then
          Begin
            Campo := xLinha.AddCampo;

            xCampo.NomeCampo := FModeloArquivo.Campos[intCnt].NomeCampo;
            xCampo.DescricaoCampo := FModeloArquivo.Campos[intCnt].Descricao;
            xCampo.Coluna := FModeloArquivo.Campos[intCnt].Coluna;
            xCampo.Posicao := FModeloArquivo.Campos[intCnt].Posicao;
            xCampo.Obrigatorio := FModeloArquivo.Campos[intCnt].Obrigatorio;
            xCampo.TipoCampo := FModeloArquivo.Campos[intCnt].TipoCampo;
            xCampo.Tamanho := FModeloArquivo.Campos[intCnt].Tamanho;
            xCampo.blnTabela := FModeloArquivo.Campos[intCnt].blnTabela;
            xCampo.blnExibirTextoPuro := IIF(FModeloArquivo.Campos[intCnt].NomeCampo = 'ITE_NUMLOT', True, False);
            strLinha := fPreparaLinha(xCampo, intLinha, strLinha, strColuna);
            xCampo.Conteudo := strLinha;
            xCampo.blnValidarTamanho := IIF((FModeloArquivo.Campos[intCnt].blnTabela) or (FModeloArquivo.Campos[intCnt].Tamanho = 0), False, True);

            If FModeloArquivo.Campos[intCnt].blnCmpLig Then
            Begin
              xCampo.blnCmpLig := FModeloArquivo.Campos[intCnt].blnCmpLig;
              strLinha := IIF(Not fEmptyStr(strLinha), strLinha, '');
              xCampo.Conteudo := strLinha;
              strCmpLig := xCampo.Conteudo;
            End;
            Campo.Propriedades := xCampo;
            pProcessarLinhaTabela(xLinha, xCampo, strLinha, strCmpLig);
          End;
        End;

        If Assigned(FValida) Then
        Begin
          FValida.pAtualizarParametrosValidacao;
          FValida.fValidarLinha(xLinha);
        End;
        FLinhasImportadas.Add(xLinha);

        pAdicionarLinhasImportadasTabela(xLinha);

        ACxProgresso.Position := ACxProgresso.Position + 1;
        Application.ProcessMessages;

      End;

      If Assigned(FValida) Then
        Result := FValida.Inconsistencias.Inconsistencias.Count <= 0;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[TImportaPlanilha.fProcessarArquivo]');
      End;
    End;
  Finally
    If (Not fCancelouOperacao(FncCancelouOperacao)) Then
    Begin
      strNomeArquivo := ChangeFileExt(FCaminhoArquivo, '.imp');
      RenameFile(FCaminhoArquivo, strNomeArquivo);
    End;
    FreeAndNil(objValidaExcel);
  End;
End;

function TImportaPlanilha.GetCaminhoArquivo: String;
begin
  Result := FCaminhoArquivo;
end;

function TImportaPlanilha.GetEstadoTela: TTipoEstadoTela;
begin
  Result := FEstadoTela;
end;

function TImportaPlanilha.GetLinha: TList<ILinha>;
begin
  Result := FLinhasImportadas;
end;

function TImportaPlanilha.GetModelo: IModeloArquivoImportacao;
begin
  Result := FModeloArquivo;
end;

function TImportaPlanilha.GetProgresso: TCxProgressBar;
begin
  Result := FcxProgresso;
end;

function TImportaPlanilha.GetValida: IValidaDados;
begin
  Result := FValida;
end;

procedure TImportaPlanilha.pAdicionarLinhasImportadasTabela(aLinha: ILinha);
var
  IndiceLinhaAux: Integer;
  xLinhaTAB: ILinha;
  xModeloTabela: IModeloArquivoImportacao;
  intCont: Integer;
  xCampoTab: TCampoPlanilha;
  CampoTab: ICampoLinha;
  strConteudoCampo: String;
begin
  For IndiceLinhaAux:=0 To FLinhasImportadasTab.Count-1 Do
  Begin
    xLinhaTAB := FLinhasImportadasTab[IndiceLinhaAux];
    xModeloTabela   := fRetornaModeloTabela(xLinhaTAB.strNomeTabela);
    If (xLinhaTAB.strNomeTabela = xModeloTabela.strNomTabela) And
       (xLinhaTAB.NumeroLinha = aLinha.NumeroLinha) Then
    Begin
      For intCont := 0 to xModeloTabela.Campos.Count-1  Do
      Begin
        If (xModeloTabela.Campos[intCont].blnPreAut)  Then
        Begin
          strConteudoCampo := '';
          CampoTab := xLinhaTAB.AddCampo;
          xCampoTab := fRetornaCampoLinhaTabela(xModeloTabela, strConteudoCampo, xModeloTabela.strNomTabela, intCont);
          CampoTab.Propriedades := xCampoTab;
        End;
      End;
      FValida.fValidarLinha(xLinhaTAB);
      FLinhasImportadas.Add(xLinhaTAB);
    End;
  End;
end;

procedure TImportaPlanilha.pLimparCampos;
begin
  FcxProgresso.Position := 0;
  FCaminhoArquivo := EmptyStr;
  FLinhasImportadas.Clear;
  FLinhasImportadasTab.Clear;

  If Assigned(FValida) Then
    FValida.pLimpar;
end;

procedure TImportaPlanilha.pLimparProcessamento(const blnApenasTabelaPrincipal: Boolean = False);
begin
  FcxProgresso.Position := 0;
  FLinhasImportadas.Clear;

  If Not blnApenasTabelaPrincipal Then
    FLinhasImportadasTab.Clear;

  If Assigned(FValida) Then
    FValida.pLimpar;
end;

procedure TImportaPlanilha.pProcessarLinhaTabela(aLinha: ILinha;
  aCampo: TCampoPlanilha; strConteudoLinha: String; strCmpLig: String);
var
  strLinhaAuxTab: String;
  intNroLinhasTab: Integer;
  blnAdicionarLinhaTab: Boolean;
  xLinhatTAB: ILinha;
  xCampoTab: TCampoPlanilha;
  intCont: Integer;
  intAux: Integer;
  CampoTab: ICampoLinha;
  IndiceLinhaAux: Integer;
begin
  If Not aCampo.blnTabela Then
    Exit;

  If fEmptyStr(strConteudoLinha) Then
    Exit;

  strLinhaAuxTab  := strConteudoLinha;
  FModeloTabela   := fRetornaModeloTabela(aCampo.NomeCampo);


  intNroLinhasTab := fCalculaNroLinhasTabela(strConteudoLinha);
  blnAdicionarLinhaTab := fVerificaAdicionarLinhaTab(FModeloTabela, intNroLinhasTab, aLinha.NumeroLinha);

  If blnAdicionarLinhaTab Then
  Begin
    For intAux :=0 To intNroLinhasTab-1 Do
    Begin
      xLinhatTAB := TLinha.New;
      xLinhatTAB.blnTabelaPrincipal := False;
      xLinhatTAB.strNomeTabela := FModeloTabela.strNomTabela;
      xLinhatTAB.NumeroLinha := aLinha.NumeroLinha;

      CampoTab := xLinhatTAB.AddCampo;
      xCampoTab := fRetornaCampoLinhaTabela(FModeloTabela, strCmpLig, FModeloTabela.strNomTabela, 0, True);
      CampoTab.Propriedades := xCampoTab;

      FLinhasImportadasTab.Add(xLinhatTAB);
    End;
  End;

  If (Pos(FModeloTabela.strNomTabela, aCampo.NomeCampo) > 0) Then
  Begin
    For IndiceLinhaAux:=0 To FLinhasImportadasTab.Count-1 Do
    Begin
      If (FLinhasImportadasTab[IndiceLinhaAux].strNomeTabela = FModeloTabela.strNomTabela) And
         (FLinhasImportadasTab[IndiceLinhaAux].NumeroLinha = aLinha.NumeroLinha) Then
      Begin
        xLinhatTAB := FLinhasImportadasTab[IndiceLinhaAux];
        For intCont := 0 to FModeloTabela.Campos.Count-1  Do
        Begin
          If (FModeloTabela.Campos[intCont].Posicao > 0) Then
          Begin
            If (Pos(FModeloTabela.Campos[intCont].NomeCampo, aCampo.NomeCampo) > 0 ) Then
            Begin
              CampoTab := xLinhatTAB.AddCampo;
              xCampoTab := fRetornaCampoLinhaTabela(FModeloTabela, strLinhaAuxTab, FModeloTabela.strNomTabela, intCont);
              CampoTab.Propriedades := xCampoTab;
            End;
          End;
        End;
      End;
    End;
  End;
end;

procedure TImportaPlanilha.SetCaminhoArquivo(const aValue: String);
begin
  FCaminhoArquivo := aValue;
end;

procedure TImportaPlanilha.SetEstadoTela(const aValue: TTipoEstadoTela);
begin
  FEstadoTela :=  aValue;
end;

procedure TImportaPlanilha.SetLinha(const aValue: TList<ILinha>);
begin
  FLinhasImportadas := aValue;
end;

procedure TImportaPlanilha.SetProgresso(const aValue: TCxProgressBar);
begin
  FcxProgresso := aValue;
end;

procedure TImportaPlanilha.SetValida(const aValue: IValidaDados);
begin
  FValida := aValue;
end;

function TImportaPlanilha.fCancelouOperacao(
  const FncCancelouOperacao: TReferenceBooleanFunction): Boolean;
begin
  Result := False;
  If (Not Assigned(FncCancelouOperacao)) Then
    Exit;
  Result := FncCancelouOperacao;
end;

{ TLinha }

function TLinha.AddCampo: ICampoLinha;
var
  intCont: Integer;
begin
  FLinha.Add(TCampoLinha.Create(Self));
  intCont := FLinha.Count -1;
  Result := FLinha[intCont];
end;

constructor TLinha.Create;
begin
  FLinha := TList<ICampoLinha>.Create;
  FblnTabelaPrincipal := True;
end;

destructor TLinha.Destroy;
begin
  FreeAndNil(FLinha);

  inherited;
end;

function TLinha.GetblnTabP: Boolean;
begin
  Result := FblnTabelaPrincipal;
end;

function TLinha.GetLinha: TList<ICampoLinha>;
begin
  Result := FLinha;
end;

function TLinha.GetNomTab: String;
begin
  Result := FStrNomTab;
end;

function TLinha.GetNumeroLinha: Integer;
begin
  Result := FNumeroLinha;
end;

class function TLinha.New: ILinha;
begin
  Result := Self.Create;
end;

procedure TLinha.SetblnTabP(const aValue: Boolean);
begin
  FblnTabelaPrincipal := aValue;
end;

procedure TLinha.SetLinha(const aValue: TList<ICampoLinha>);
begin
  FLinha := aValue;
end;

procedure TLinha.SetNomTab(const aValue: String);
begin
  FStrNomTab := aValue;
end;

procedure TLinha.SetNumeroLinha(const aValue: Integer);
begin
  FNumeroLinha := aValue;
end;

{ TCampoLinha }

Class function TCampoLinha.Add(Const aLinha: ILinha): ICampoLinha;
begin
   Result := Self.Create(aLinha);
end;

constructor TCampoLinha.Create(Parent: ILinha);
begin
  FLinha := Parent;
end;

function TCampoLinha.GetPropriedades: TCampoPlanilha;
begin
  Result := FCampo;
end;

procedure TCampoLinha.SetPropriedades(const aValue: TCampoPlanilha);
begin
  FCampo :=  aValue;
end;

{ TInconsistencia }

function TInconsistencia.AddLinha: ILinha;
var
  intCont: Integer;
begin
  FLinhas.Add(TLinha.Create);
  intCont := FLinhas.Count -1;
  Result := FLinhas[intCont];
end;

function TInconsistencia.Add: TRegInconsistencia;
var
  intCont: Integer;
  xReg: TRegInconsistencia;
begin
  FListaInconsistencias.Add(xReg);
  intCont := FListaInconsistencias.Count -1;
  Result := FListaInconsistencias[intCont];
end;

constructor TInconsistencia.Create;
begin
  FLinhas := TList<ILinha>.Create;
  FListaInconsistencias := TList<TRegInconsistencia>.Create;
end;

destructor TInconsistencia.Destroy;
begin
  FreeAndNil(FListaInconsistencias);
  FreeAndNil(FLinhas);

  inherited;
end;

function TInconsistencia.GetInconsistencias: TList<TRegInconsistencia>;
begin
  Result := FListaInconsistencias;
end;

function TInconsistencia.GetLinha: TList<ILinha>;
begin
  Result := FLinhas;
end;

procedure TInconsistencia.SetInconsistencias(
  const aValue: TList<TRegInconsistencia>);
begin
  FListaInconsistencias := aValue;
end;

procedure TInconsistencia.SetLinha(const aValue: TList<ILinha>);
begin
  FLinhas := aValue;
end;

{ TValidacaoDadosImportacao }

constructor TValidacaoDadosImportacao.Create(
  aArquivoImportacao: IImportaPlanilha);
begin
  FArquivoImportacao := aArquivoImportacao;
  FInconsistencias := TInconsistencia.Create;
end;

destructor TValidacaoDadosImportacao.Destroy;
begin
  FreeAndNil(FInconsistencias);

  inherited;
end;

function TValidacaoDadosImportacao.GetArquivoImportacao: IImportaPlanilha;
begin
  Result := FArquivoImportacao;
end;

function TValidacaoDadosImportacao.GetInconsistencias: IInconsistencia;
begin
  Result := FInconsistencias;
end;

procedure TValidacaoDadosImportacao.pAdicionaInconsistencia(
  const aLinha: ILinha; const Coluna, Campo, Mensagem: String);
var
  xInconsistencia : TRegInconsistencia;
Begin
  xInconsistencia.NumeroLinha := aLinha.NumeroLinha;
  xInconsistencia.Coluna := Coluna;
  xInconsistencia.Campo := Campo;
  xInconsistencia.Descricao := Mensagem;
  FInconsistencias.Inconsistencias.Add(xInconsistencia);
End;

procedure TValidacaoDadosImportacao.pAtualizarParametrosValidacao;
begin
  pSetarLinhaPadraoModelo;
end;

procedure TValidacaoDadosImportacao.pLimpar;
begin
  FInconsistencias.Inconsistencias.Clear;
end;

procedure TValidacaoDadosImportacao.pSetarLinhaPadraoModelo;
var
  xLinha: ILinha;
  intCnt: Integer;
  xCampo: ICampoLinha;
  xPropriedade: TCampoPlanilha;
begin

  xLinha := TLinha.New;
  xLinha.strNomeTabela := Self.Arquivo.Modelo.strNomTabela;
  For intCnt := 0 to Self.Arquivo.Modelo.Campos.Count-1  Do
  Begin
    xCampo := xLinha.AddCampo;
    xPropriedade.NomeCampo  := Self.Arquivo.Modelo.Campos[intCnt].NomeCampo;
    xCampo.Propriedades := xPropriedade;
  End;
end;

procedure TValidacaoDadosImportacao.SetArquivoImportacao(
  const aValue: IImportaPlanilha);
begin
  FArquivoImportacao := aValue;
end;

procedure TValidacaoDadosImportacao.SetInconsistencias(
  const aValue: IInconsistencia);
begin
  FInconsistencias := aValue
end;

function TValidacaoDadosImportacao.fValidar: Boolean;
var
  intCnt: Integer;
  xLinha: ILinha;
begin
  Try
    For intCnt := 0 To Arquivo.LinhasImportadas.Count  -1 Do
    Begin
      xLinha:= Arquivo.LinhasImportadas[intCnt];
      fValidarLinha(xLinha);
    End;
    Result := True;
  Except
    Result := False;
  End;
end;

function TValidacaoDadosImportacao.fValidarCampoObrigatorio(const aObrigatorio: Boolean; const aConteudo: String): Boolean;
begin
  Result := True;

  If Not aObrigatorio Then
    Exit;

  If fEmptyStr(aConteudo) Then
    Result := False;
end;

function TValidacaoDadosImportacao.fValidarLinha(const aLinha: ILinha): Boolean;
var
  intCnt: Integer;
  xInconsistencia : TRegInconsistencia;
  strErro: String;
begin
  Result := True;

  Try
    For intCnt := 0 To aLinha.Campos.Count-1 Do
    Begin
      strErro :=  aLinha.Campos[intCnt].Propriedades.DescricaoCampo + ' Conteudo: ' + aLinha.Campos[intCnt].Propriedades.Conteudo;

      If Not(fValidarTipoCampo(aLinha.Campos[intCnt].Propriedades.TipoCampo, aLinha.Campos[intCnt].Propriedades.Conteudo))  Then
      Begin
        Result := False;
        Case aLinha.Campos[intCnt].Propriedades.TipoCampo  of
          ftDateTime : xInconsistencia.Descricao := cstValidacaoCampoData;
          Else
            xInconsistencia.Descricao := cstValidacaoTipoCampo;
        End;
        xInconsistencia.NumeroLinha := aLinha.NumeroLinha;
        xInconsistencia.Coluna := aLinha.Campos[intCnt].Propriedades.Coluna;
        xInconsistencia.Campo := aLinha.Campos[intCnt].Propriedades.DescricaoCampo;
        FInconsistencias.Inconsistencias.Add(xInconsistencia);
      End
      Else
      Begin
        If Not(fValidarCampoObrigatorio(aLinha.Campos[intCnt].Propriedades.Obrigatorio = 'S',
                                        aLinha.Campos[intCnt].Propriedades.Conteudo)) Then
        Begin
          Result := False;
          xInconsistencia.Descricao := cstValidacaoCampoObrigatorio;
          xInconsistencia.NumeroLinha := aLinha.NumeroLinha;
          xInconsistencia.Coluna := aLinha.Campos[intCnt].Propriedades.Coluna;
          xInconsistencia.Campo := aLinha.Campos[intCnt].Propriedades.DescricaoCampo;
          FInconsistencias.Inconsistencias.Add(xInconsistencia);
        End;

        If Not(fValidarTamanhoCampo(aLinha.Campos[intCnt].Propriedades))  Then
        Begin
          Result := False;
          xInconsistencia.Descricao := cstValidacaoTamanhoCampo + ' Tamanho máximo de caracteres: ' + IntToStr(aLinha.Campos[intCnt].Propriedades.Tamanho)  ;
          xInconsistencia.NumeroLinha := aLinha.NumeroLinha;
          xInconsistencia.Coluna := aLinha.Campos[intCnt].Propriedades.Coluna;
          xInconsistencia.Campo := aLinha.Campos[intCnt].Propriedades.DescricaoCampo;
          FInconsistencias.Inconsistencias.Add(xInconsistencia);
        End;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(strErro +':' + E.Message,'[TValidacaoDadosImportacao.fValidarLinha]');
    End;
  End;
end;

function TValidacaoDadosImportacao.fValidarTamanhoCampo(const aPropriedades: TCampoPlanilha): Boolean;
begin
  If Not aPropriedades.blnValidarTamanho Then
  Begin
    Result := True;
    Exit;
  End;

  If aPropriedades.Tamanho  < 0 Then
  Begin
    Result := True;
    Exit;
  End;

  Result := Length(aPropriedades.Conteudo) <= aPropriedades.Tamanho;
end;

function TValidacaoDadosImportacao.fValidarTipoCampo(
  const aFieldType: TFieldType; const aConteudo: String): Boolean;
begin
  Result := True;
  try
    case aFieldType of
      ftInteger:  Begin
                    If Not fEmptyStr(aConteudo) Then
                      Result := StrToInt(aConteudo) >= 0;
                  End;
      ftFloat,
      ftCurrency: Begin
                    fConvertVazioToFloat(aConteudo);
                  End;
      ftDateTime: Begin
                    If Not fEmptyStr(aConteudo) Then
                      Result := StrToDateTime(aConteudo) >= 0;
                  End;
    end;
  except
     Result := False;
  end;

end;

function TValidacaoDadosImportacao.fAdicionaInconsistenciaLista(
  const aLinha: ILinha; const Coluna, Campo, Mensagem: String): IInconsistencia;
var
  xInconsistencia : TRegInconsistencia;
Begin
  xInconsistencia.NumeroLinha := aLinha.NumeroLinha;
  xInconsistencia.Coluna := Coluna;
  xInconsistencia.Campo := Campo;
  xInconsistencia.Descricao := Mensagem;
  FInconsistencias.Inconsistencias.Add(xInconsistencia);
End;

function TValidacaoDadosImportacao.fConvertVazioToFloat(aValue: String): Double;
Begin
  aValue := AnsiReplaceStr(AnsiReplaceStr(aValue, '%', ''), 'R$', '');
  If aValue = '' Then
    Result := 0
  Else
    Result := StrToFloatDef(aValue, 0);
End;

function TValidacaoDadosImportacao.fRetornaCampoCodigo(
  const strCodTmp: String; intTamCampo: Integer): String;
var
  strAuxCod: String;
begin
  Result := EmptyStr;

  If fEmptyStr(strCodTmp) Then
    Exit;

  strAuxCod := fTiraCaracEspeciaisPonto(strCodTmp);
  strAuxCod := fPadL(strAuxCod, intTamCampo, '0');
  Result := strAuxCod;
end;

end.


