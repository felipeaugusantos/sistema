{******************************}
{* UNITS USADA NOS RELATÓRIOS *}
{* CUIDADO AO ADICIONAR UNITS *}
{* NO USES                    *}
{***************************AF*}

unit untExcel;

interface

uses Classes, Dialogs, ComObj, Variants;

type
  TCorExcel = (Preto, Branco, Cinza, CinzaEscuro, Amarelo, Verde_Mar, Verde, Lima, Azul, Vermelho);
  TAlinhamentoExcel = (Esquerda, Centro, Direita);
  TAlinhamentoVertical = (xlsTop, xlsCenter, xlsBottom);
  TOrientacao = (Paisagem, Retrato);
  TFonteExcel = (Arial, Courier, CourierNew, Times);

type
  TExcel = Class(TComponent)
  private
    FTestaArq,
    FErroArq: Boolean;
    FSheet: Integer;
    FWorkBook: Integer;

  protected
    FSvdXls: TSaveDialog;
    FNomArq: String;
    FAbrirArquivoExistente: Boolean;

    FExcel : Variant;

    FLinAnt: Integer;
    FColAnt: Integer;

    procedure SalvarPosicao; Virtual; Abstract;
    procedure VoltarPosicao; Virtual; Abstract;

    function getLinAtu: Integer; Virtual; Abstract;
    function getColAtu: Integer; Virtual; Abstract;

    procedure setLinAtu(Linha: Integer);  Virtual; Abstract;
    procedure setColAtu(Coluna: Integer); Virtual; Abstract;

    function RetornaCor(Cor: TCorExcel): Integer; Virtual; Abstract;
    function RetornaFonte(Fonte: TFonteExcel): String; Virtual; Abstract;
    function fRetornaAlinhamento(Alinhamento: TAlinhamentoExcel): Integer; Virtual; Abstract;
    function fRetornaAlinhamentoVertical(Alinhamento: TAlinhamentoVertical): Integer; Virtual; Abstract;

    procedure setSheet(const Value: Integer); virtual;

    function fGetLetraAlfa(intCol: Integer): String;
  public
    arrDados: Variant;
    blnEscreverArray: Boolean;

    class function fCriarExcel(Owner: TComponent): TExcel;
    destructor Destroy; override;

    function ProximaLinha: Integer; Virtual; Abstract;

    procedure ValidarCelulas(CelulaInicial, CelulaFinal, ValorMinimo, ValorMaximo: String); Virtual; Abstract;
    procedure BloquearCelulas(CelulaInicial, CelulaFinal: String; Bloquear: Boolean = True); Virtual; Abstract;
    procedure ProtegerPlanilha(Senha: String); Virtual; Abstract;
    procedure DesprotegerPlanilha(Senha: String); Virtual; Abstract;
    procedure DesprotegerEstrutura(Senha: String); Virtual; Abstract;
    procedure ProtegerEstrutura(Senha: String); Virtual; Abstract;
    procedure ExcluirPlanilha(Index: Integer); Virtual; Abstract;

    function LocalizarCelula(Texto: String): Boolean; Virtual; Abstract;

    function MaximodeLinhas: Integer; Virtual; Abstract;

    function Ler_Celula(Celula: String): String; Virtual; Abstract;

    procedure Escrever(linha, coluna: Integer; Valor: Variant); Virtual; Abstract;
    procedure FormatoNumerico(Linha, Coluna: Integer; Formato: String = '#.##0,00');overload; Virtual; Abstract;
    procedure FormatoNumerico(CelulaInicial, CelulaFinal: String; Formato: String = '#.##0,00');overload; Virtual; Abstract;
    procedure Mesclar(CelulaInicial, CelulaFinal: String); Virtual; Abstract;
    procedure Negrito(Linha, Coluna: Integer; blnNegrito: Boolean);overload; Virtual; Abstract;
    procedure Negrito(CelulaInicial, CelulaFinal: String; blnNegrito: Boolean);overload; Virtual; Abstract;
    procedure CorFundo(CelulaInicial, CelulaFinal: String; CorFundo: TCorExcel); overload; Virtual; Abstract;
    procedure CorFundo(CelulaInicial, CelulaFinal: String; CorFundo: Cardinal); overload; Virtual; Abstract;
    procedure CorFonte(CelulaInicial, CelulaFinal: String; CorFonte: TCorExcel); Virtual; Abstract;
    procedure PintarTudo(CorFundo: TCorExcel); Virtual; Abstract;
    procedure DefinirFonte(Fonte: TFonteExcel; Tamanho: Integer);overload; Virtual; Abstract;
    procedure DefinirFonte(CelulaInicial, CelulaFinal: String; Fonte: TFonteExcel; Tamanho: Integer);overload; Virtual; Abstract;
    procedure Alinhamento(CelulaInicial, CelulaFinal: String; Alinhamento: TAlinhamentoExcel);overload; Virtual; Abstract;
    procedure Alinhamento(Linha, Coluna: Integer; Alinhamento: TAlinhamentoExcel);overload; Virtual; Abstract;
    procedure AlinhamentoVertical(CelulaInicial, CelulaFinal: String; Alinhamento: TAlinhamentoVertical);overload; Virtual; Abstract;
    procedure AlinhamentoVertical(Linha, Coluna: Integer; Alinhamento: TAlinhamentoVertical);overload; Virtual; Abstract;
    procedure Bordas(CelulaInicial, CelulaFinal: String);overload; Virtual; Abstract;
    procedure Bordas(CelulaInicial, CelulaFinal: String; Esquerda, Direita, Superior, Inferior: Boolean);overload; Virtual; Abstract;
    procedure OrientacaoPagina(Orientacao: TOrientacao);Virtual; Abstract;
    procedure CongelarPaines(Celula: String);Virtual; Abstract;
    procedure AutoAjuste;Virtual; Abstract;

    function AbrirArquivo(Nome_Arquivo: String): Boolean;Virtual; Abstract;
    function CriarArquivo: Boolean; Overload;Virtual; Abstract;
    function CriarArquivo(Nome_Arquivo: String): Boolean; Overload;Virtual; Abstract;

    procedure SalvarArquivo;Virtual; Abstract;
    procedure FecharArquivo;Virtual; Abstract;

    procedure SetaNomePlanilha(intPlanilha: Integer; strNome: String); Virtual; Abstract;
    procedure AdicionaPlanilha; Virtual; Abstract;

    procedure EscreveVarios(CelulaInicial, CelulaFinal: String); Virtual; Abstract;
  published

    property LinhaAtual: Integer   read getLinAtu write setLinAtu;
    property ColunaAtual: Integer  read getColAtu write setColAtu;
    property Excel: Variant        read FExcel  write FExcel;
    property NomeArquivo: String   read FNomArq;
    property blnAbrirArquivoExistente: Boolean Read FAbrirArquivoExistente Write FAbrirArquivoExistente;

    property WorkBookIndex: Integer read FWorkBook write FWorkBook;
    property SheetIndex: Integer read FSheet write setSheet;

    property blnErroArq: Boolean read FErroArq write FErroArq;
    property blnTestaArq: Boolean read FTestaArq write FTestaArq;
  end;

implementation

uses SysUtils, untExcelBRO, untExcelOfc, System.UITypes;

destructor TExcel.Destroy;
begin
  FreeAndNil(FSvdXls);
  inherited Destroy;
end;

class function TExcel.fCriarExcel(Owner: TComponent): TExcel;
  Var
    test: Variant;
begin

  Try
    test := CreateOleObject('Excel.Application');
    test.quit;

    Result := TExcelOfc.Create(Owner);
  Except
    Try
      Result := TExcelBRO.Create(Owner);
    Except
      MessageDlg('É suportado Office até 2007 ou BROffice!' + #10#13 + 'Não foi possível carregar aplicativo!', mtWarning, [mbOK], 0);
      Result := Nil;
    End
  End;

  If Assigned(Result) Then
  Begin
    Result.blnEscreverArray := False;
  End;

end;

procedure TExcel.setSheet(const Value: Integer);
begin
  FSheet := Value;
end;

function TExcel.fGetLetraAlfa(intCol: Integer): String;
  Var
    strLetra : String;
    intLetra1: Integer;
    intLetra2: Integer;
    fltValor : Double;

    function fFloatToInt(fltNumero: Double): Integer;
    begin
      Result := StrToIntDef(FloatToStrF(fltNumero, ffFixed, 12, 0), 0);
    end;
begin
  strLetra := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  If intCol > 26 Then
  Begin
    fltValor  := (intCol / 26);
    intLetra1 := fFloatToInt(fltValor - Frac(fltValor));
    intLetra2 := fFloatToInt(intcol Mod 26);

    If intLetra2 = 0 Then
    Begin
      Dec(intLetra1);
      intLetra2 := 26;
    End;

    Result    := strLetra[intLetra1] + strLetra[intLetra2];
  End
  Else
    Result   := strLetra[intCol];

end;

end.
