unit untGeraExcelHtml;

interface

uses Classes, Dialogs, ComObj, Variants, SysUtils, untExcel, Windows, DateUtils,
     System.Generics.Collections, Vcl.Graphics, Data.DB, Vcl.ComCtrls, Forms, Vcl.Controls,
     cxProgressBar;

type


  TTipoArquivoHTML = (taHtml, taCSV);
  TTipoCampo = (tcTitulo, tcTituloEditavel, TcColuna, tcFiltro, tcTotais);
  TTAlignHTM = (tahtmlLeft, tahtmlRight, tahtmlCenter, tahtmlUndef);
  TSetFonte =  function (AFontSize: integer; AFontName: TFontName;  AFontColor: TColor ): TFont of object ;
  TOnEscreveValorCampo  = procedure (DataSet: TDataSet; AIdentificador: string; Var ATexto: string; var AColorBackGround, AColorFont: TColor) of Object;
  TTrataValorQuebra = function (DataSet: TDataSet; AValor, AFieldName: String): String of Object;

  TValidaValor = record
    FvalorMinimo: Double;
    FValorMaximo: Double;
  End;

  TCampoExcelHtml = class
    FWidth: integer;
    FFont: TFont;
    FFontValues: TFont;
    FColor : TColor;
    FAlign: TTAlignHTM;
    FTipoCampo: TTipoCampo;
    FText: String;
    FObservacao: String;
    FFieldName: string;
    FIdentificador: String;
    FFormato: String;
    FFieldType: TFieldType;
    FBloquear: Boolean;
    FLetra: string;
    FValidaValor: TValidaValor;
    FQuebra: Boolean;
    FValueQuebra: String;
    FApenasQuebra: Boolean;
    procTrataValorQuebra : TTrataValorQuebra;
  End;

  TTotalizador = class
    Referencia: String;
    Identificador: String;
    Valor: Double;
  End;


  TTotaisHTML = class
  private
    FarrTotais: Array of TTotalizador;
    function getTotalizador(index: string): TTotalizador;
    procedure setTotalizador(index: string; const Value: TTotalizador);
  public
    destructor Destroy; override;
    procedure AdicionaTotais(Totalizador: TTotalizador);
    property Totais[index: string]: TTotalizador read getTotalizador write setTotalizador;
  End;

  TOnSomaTotais = procedure(DataSet: TDataSet; var ATotais: TTotaisHTML) of Object;

  TValue = record
    ColSpan: integer;
    Value: string;
    BackgroundColor: TColor;
    FontColor: TColor;
    Size: Integer;
    alinhamento: TTAlignHTM;
    pularLinha: Boolean;
    FontName: TFontName;
  End;


  TOnResumo = procedure(DataSet: TDataSet; ATotais: TTotaisHTML) of object;

  TEscreve = Class abstract
  strict
  protected
    FArquivo: TextFile;
    FListaTitulos: TList<TCampoExcelHtml>;
    FListaTitulosEditaveis: TList<TCampoExcelHtml>;
    FListaCampos : TList<TCampoExcelHtml>;
    FListaFiltros: TList<TCampoExcelHtml>;
    FstrInitialDir: String;
    FNomeArquivo: String;
    FProgressBar: TProgressBar;
    FDataSet: TDataSet;
    FOnEscreveValorCampo: TOnEscreveValorCampo;
    FOnSomaTotais: TOnSomaTotais;
    FOnResumo: TOnResumo;
    FTotais: TTotaisHTML;
    function fEscreveTitulos: Boolean; virtual;abstract;
    function fEscreveTitulosEditaveis: Boolean; virtual;abstract;
    function fEscreveFiltros: Boolean; virtual;abstract;
    function fEscreveCampos: Boolean; virtual;abstract;

    procedure pSaveFile; virtual;abstract;
    function SetFontSize(value: integer): integer;


  Public
    Bloquear : Boolean;
    iniDetalhes: integer;
    protegeEstrutura: Boolean;
    blnShowFrmGravando: Boolean;
    constructor Create;
    destructor Destroy; override;
    function fEscreveLinha(var Value: TValue): boolean; virtual; abstract;
    procedure pFechaLinha; virtual; abstract;
    function GetVirtualWidth(AValue: String; AFont: TFont):integer;
    function fEscreve: Boolean;
    property ListaTitulos : TList<TCampoExcelHtml> read FListaTitulos  write FListaTitulos;
    property ListaTitulosEditaveis : TList<TCampoExcelHtml> read FListaTitulosEditaveis write FListaTitulosEditaveis;
    property ListaCampos  : TList<TCampoExcelHtml> read FListaCampos   write FListaCampos ;
    property ListaFiltros : TList<TCampoExcelHtml> read FListaFiltros  write FListaFiltros;
    property Arquivo      : TextFile read FArquivo       write FArquivo      ;
    property strInitialDir: String        read FstrInitialDir write FstrInitialDir;
    property NomeArquivo  : String        read FNomeArquivo   write FNomeArquivo  ;
    property ProgressBar  : TProgressBar  read FProgressBar   write FProgressBar  ;
    property DataSet      : TDataSet      read FDataSet       write FDataSet;
    property OnEscreveValorCampo: TOnEscreveValorCampo read FOnEscreveValorCampo write FOnEscreveValorCampo;
    property OnSomaTotais : TOnSomaTotais read FOnSomaTotais write FOnSomaTotais;
    property OnResumo: TOnResumo Read FOnResumo write FOnResumo;
    property Totais: TTotaisHTML read FTotais write FTotais;

  End;

  TEscreveHTML = class(TEscreve)
  strict protected
   procedure pSaveFile; override;
   procedure pAjustaPlanilha();
   procedure pIniciaHTML;
   procedure pEscreverTituloCampos;
   Function fEscreveCamposProgresso(cxProgresso: TCxProgressBar): Boolean;
   procedure pEscreveQuebra(Campo: TCampoExcelHtml; AValor: String);

   procedure  pEscreveTitulo(campo: TCampoExcelHtml);
   procedure pSetaTamanhoColunas;
   function fEscreveTitulos: Boolean; override;
   function fEscreveTitulosEditaveis: Boolean; override;
   function fRetTipoHtmpToAlign(campo: TTAlignHTM): string;
   function SizeToHtmlNumber(value: integer): string;

   function fEscreveFiltros: Boolean; override;
   function fEscreveCampos: Boolean; override;
   function ColorToHtml(Cor: TColor): string;
   function fGetQtdColunaVisivel: Integer;
   procedure pBloquearCelulas(Excel: TExcel);
   procedure pCriaValidacao(Excel: TExcel);
 private
   FExcel: TExcel;
   blnProcessouPlanilha: Boolean;
  public
   function fEscreveLinha(var Value: TValue): boolean;override;
   procedure pFechaLinha;override;
  End;

  TEscreveCSV = class(TEscreve)
  strict protected
    procedure pSaveFile; override;
    function fEscreveTitulos: Boolean; override;
    function fEscreveTitulosEditaveis: Boolean; override;
    function fEscreveFiltros: Boolean; override;
    function fEscreveCampos: Boolean; override;
  public
    function fEscreveLinha(var Value: TValue): boolean;override;
    procedure pFechaLinha;override;

  End;


  TGeraArquivo = Class
  private
    FEscreve: TEscreve;
    FSvdXls: TSaveDialog;
    FOnEscreveValorCampo: TOnEscreveValorCampo;
    FOnSomaTotais: TOnSomaTotais;
    FOnResumo: TOnResumo;
    function fSetCampoAlign(AFieldType: TFieldType):TTAlignHTM;
    procedure pAdicionaCampo(AText,
                             AFieldName: string;
                             AFont,
                             AFontValues: TFont;
                             ATipoCampo: TTipoCampo;
                             AWidth: integer;
                             AAlignment: TTAlignHTM = tahtmlUndef;
                             AIdentificador: string = '';
                             AFormato: string = '';
                             AFieldType: TFieldType = ftUnknown;
                             ABloquear: Boolean = True;
                             AValorMinimo: Double = -9999999;
                             AVAlorMaximo: Double = -9999999;
                             ALetra: String = '';
                             AObservacao: String = '';
                             ABlnQuebra: Boolean = False;
                             ATrataValorQuebra: TTrataValorQuebra = nil;
                             AApenasQuebra: Boolean = False);
  Protected
    FblnShowFrmGravando: Boolean;
  public
    protegeEstrutura: Boolean;
    strFile: string;
    blnShowFrmGravando: Boolean;
    DesbloquerTodasAsColunas: Boolean;
    property OnEscreveValorCampo: TOnEscreveValorCampo read FOnEscreveValorCampo write FOnEscreveValorCampo;
    property OnSomaTotais: TOnSomaTotais read FOnSomaTotais write FOnSomaTotais;
    property OnResumo: TOnResumo read FOnResumo write FOnResumo;
    constructor create(ATipoArquivo: TTipoArquivoHTML; ADataSet: TDataSet; AProgressBar: TProgressBar);
    procedure pAddTitulo(AText: String; AFont: TFont);
    function fEscreveLinha(var Value: TValue): boolean;
    procedure pFechaLinha;

    procedure pAddTituloEditavel(AText,
                                 AFieldName: string;
                                 ALetra: String;
                                 AAlignment: TTAlignHTM = tahtmlUndef;
                                 AFieldType: TFieldType = ftUnknown;
                                 ABloquear: Boolean = True;
                                 AObservacao: String = '');

    procedure AddCampo(AFieldName,
                       AFieldTitle: String;
                       AFontTitle: TFont = nil;
                       AFontValues: TFont = nil;
                       AFormato: string ='';
                       AAlignment: TTAlignHTM = tahtmlUndef;
                       ABloquear: Boolean = True;
                       AValorMinimo: Double = -9999999;
                       AVAlorMaximo: Double = -9999999;
                       AObservacao: String = '';
                       ABlnQuebra : Boolean = False;
                       ATrataValorQuebra: TTrataValorQuebra = nil;
                       AApenasQuebra: Boolean = False);

    procedure AddCampoSemDataSet(AIdentificador,
                                          AFieldTitle: String;
                                          AFontTitle,
                                          AFontValues: TFont;
                                          ATipoCampo: TFieldType;
                                          AFormatoDecima: String = '';
                                          AAlignment: TTAlignHTM = tahtmlUndef;
                                          ABloquear: Boolean = True;
                                          AValorMinimo: Double = -9999999;
                                          AVAlorMaximo: Double = -9999999);
    procedure AddTotais(AIdentificador: string; AFieldRef: string);

    class function fSetFont(AFontSize: integer = 10; AFontStyle: TFontStyles = [];
      AFontColor: TColor = clBlack; AFontName: TFontName = 'Arial'): TFont;
    function fGerarRelatorio(blnDirDeskTop: Boolean = False): Boolean;
  End;





{ TGeraArquivo }
implementation

uses
  untGeraExcel, untFuncoesSimples, untConstantes, untGravando;

constructor TGeraArquivo.create(ATipoArquivo: TTipoArquivoHtml; ADataSet: TDataSet; AProgressBar: TProgressBar);
begin
  protegeEstrutura := False;
  Case ATipoArquivo Of
    taHtml: FEscreve := TEscreveHtml.Create();
    taCSV : FEscreve := TEscreveCSV.Create();
  End;

  DesbloquerTodasAsColunas := False;
  FSvdXls := TSaveDialog.Create(Nil);
  FSvdXls.Filter := 'Planilha do Excel|*.xls';
  FSvdXls.DefaultExt := 'xls';

  FEscreve.strInitialDir := '';
  FEscreve.DataSet :=ADataSet;
  FEscreve.ProgressBar := AProgressBar;

end;

class function TGeraArquivo.fSetFont(AFontSize: integer = 10; AFontStyle: TFontStyles = [];
  AFontColor: TColor = clBlack; AFontName: TFontName = 'Arial'): TFont;
begin
  Result := TFont.Create;
  Result.Size := AFontSize;
  Result.Color := AFontColor;
  Result.Name := AFontName;
  Result.Style := AFontStyle;
end;

procedure TGeraArquivo.AddCampo(AFieldName,
                                AFieldTitle: String;
                                AFontTitle: TFont = nil;
                                AFontValues: TFont = nil;
                                AFormato: string ='';
                                AAlignment: TTAlignHTM = tahtmlUndef;
                                ABloquear: Boolean = True;
                                AValorMinimo: Double = -9999999;
                                AVAlorMaximo: Double = -9999999;
                                AObservacao: String = '';
                                ABlnQuebra : Boolean = False;
                                ATrataValorQuebra: TTrataValorQuebra = nil;
                                AApenasQuebra: Boolean = False);
var intWidth: integer;

begin
  intWidth := 64;
  If AFieldName <> '' Then
  Begin
    If Not Assigned(AFontValues) Then
    Begin
      AFontValues := TFont.Create;
      AFontValues.Size := 8;
    End;

    intWidth := FEscreve.GetVirtualWidth(AFieldTitle, AFontValues);
    If FEscreve.DataSet.FieldByName(AFieldName).Size > intWidth Then
      intWidth := FEscreve.DataSet.FieldByName(AFieldName).Size;
  End;

  pAdicionaCampo(AFieldTitle,
                 AFieldName,
                 AFontTitle,
                 AFontValues,
                 tcColuna,
                 intWidth,
                 AAlignment,
                 '',
                 AFormato,
                 FEscreve.DataSet.FieldByName(AFieldName).DataType,
                 ABloquear,
                 AValorMInimo,
                 AValorMaximo,
                 '',
                 '',
                 ABlnQuebra,
                 ATrataValorQuebra,
                 AApenasQuebra);
end;

procedure TGeraArquivo.AddCampoSemDataSet(AIdentificador,
                                          AFieldTitle: String;
                                          AFontTitle,
                                          AFontValues: TFont;
                                          ATipoCampo: TFieldType;
                                          AFormatoDecima: String = '';
                                          AAlignment: TTAlignHTM = tahtmlUndef;
                                          ABloquear: Boolean = True;
                                          AValorMinimo: Double = -9999999;
                                          AVAlorMaximo: Double = -9999999);
  var
    intWidth : integer;
begin
  intWidth := 64;
  If AFieldTitle <> '' Then
  Begin
    If Not Assigned(AFontTitle) Then
    Begin
      AFontTitle := TFont.Create;
      AFontTitle.Size := 8;
    End;
    intWidth := FEscreve.GetVirtualWidth(AFieldTitle, AFontTitle);
  End;

  pAdicionaCampo(AFieldTitle,
                 '',
                 AFontTitle,
                 AFontValues,
                 TcColuna,
                 intWidth,
                 AAlignment,
                 AIdentificador,
                 AFormatoDecima,
                 ATipoCampo,
                 ABloquear,
                 AValorMInimo,
                 AValorMaximo);
end;


procedure TGeraArquivo.AddTotais(AIdentificador, AFieldRef: string);
  var Totalizador: TTotalizador;
begin
  Totalizador := TTotalizador.Create;
  Totalizador.Referencia := AFieldRef;
  Totalizador.Identificador := AIdentificador;
  Totalizador.Valor := 0;
  FEscreve.Totais.AdicionaTotais(Totalizador);
end;

procedure TGeraArquivo.pAddTitulo(AText: String; AFont: TFont);
begin
  pAdicionaCampo(AText,
                 '',
                 Afont,
                 nil,
                 tcTitulo,
                 0);
end;

procedure TGeraArquivo.pAddTituloEditavel(AText,
                                          AFieldName: string;
                                          ALetra: String;
                                          AAlignment: TTAlignHTM = tahtmlUndef;
                                          AFieldType: TFieldType = ftUnknown;
                                          ABloquear: Boolean = True;
                                          AObservacao: String = '');
begin
  pAdicionaCampo(AText,
                 AFieldName,
                 nil,
                 nil,
                 tcTituloEditavel,
                 64,
                 AAlignment,
                 '',
                 '',
                 AFieldType,
                 ABloquear,
                 -9999999,
                 -9999999,
                 ALetra,
                 AObservacao);
end;

procedure TGeraArquivo.pAdicionaCampo(AText,
                                      AFieldName: string;
                                      AFont,
                                      AFontValues: TFont;
                                      ATipoCampo: TTipoCampo;
                                      AWidth: integer;
                                      AAlignment: TTAlignHTM = tahtmlUndef;
                                      AIdentificador: string = '';
                                      AFormato: string = '';
                                      AFieldType: TFieldType = ftUnknown;
                                      ABloquear: Boolean = True;
                                      AValorMinimo: Double = -9999999;
                                      AVAlorMaximo: Double = -9999999;
                                      ALetra: String = '';
                                      AObservacao: String = '';
                                      ABlnQuebra: Boolean = False;
                                      ATrataValorQuebra: TTrataValorQuebra = nil;
                                      AApenasQuebra: Boolean = False);

  var campo: TCampoExcelHtml;
begin
  If ABloquear Then
    FEscreve.Bloquear := True;
  campo := TCampoExcelHtml.Create;
  campo.FFont := AFont;
  campo.FFontValues := AFontValues;
  campo.FText := AText;
  campo.FAlign := AAlignment;
  campo.FTipoCampo := ATipoCampo;
  campo.FFieldName := AFieldName;
  campo.FWidth := AWidth;
  campo.FIdentificador := AIdentificador;
  campo.FFieldType := AFieldType;
  campo.FFormato := AFormato;
  campo.FBloquear := ABloquear;
  campo.FObservacao := AObservacao;
  campo.FValueQuebra := '';
  campo.FApenasQuebra := AApenasQuebra;
  campo.procTrataValorQuebra := ATrataValorQuebra;

  If (Not fEmptyStr(Aletra)) Then
    campo.FLetra := ALetra;
  If ATipoCampo = tcTitulo Then
    campo.FAlign := tahtmlCenter
  Else If (campo.FAlign = tahtmlUndef) And (campo.FFieldType <> ftUnknown) Then
    campo.FAlign := fSetCampoAlign(Campo.FFieldType);


  If AIdentificador = '' Then
    campo.FIdentificador := AFieldName;

  campo.FValidaValor.FvalorMinimo := AValorMinimo;
  campo.FValidaValor.FValorMaximo := AVAlorMaximo;
  campo.FQuebra := ABlnQuebra;


  case ATipoCampo of
    tcTitulo:         FEscreve.ListaTitulos.Add(campo);
    tcTituloEditavel: Begin
                        FEscreve.ListaTitulosEditaveis.Add(campo);
                      End;
    TcColuna:         Begin
                        campo.FLetra := fGetLetraAlfa(FEscreve.ListaCampos.Count + 1);
                        FEscreve.ListaCampos.Add(campo);
                      End;
    tcFiltro:         FEscreve.ListaFiltros.Add(campo);
  end;
end;

procedure TGeraArquivo.pFechaLinha;
begin
  FEscreve.pFechaLinha;
end;

function TGeraArquivo.fSetCampoAlign(AFieldType: TFieldType): TTAlignHTM;
begin
  case AFieldType of
    ftInteger,
    ftFloat,
    ftCurrency,
    ftBCD,
    ftDate,
    ftTime,
    ftDateTime,
    ftTimeStamp,
    ftShortint,
    ftFMTBcd,
    ftSmallint: Result := tahtmlRight;
  Else
    Result := tahtmlLeft;
  end;

end;

function TGeraArquivo.fEscreveLinha(var Value: TValue): boolean;
begin
  Result := FEscreve.fEscreveLinha(Value);

end;

function TGeraArquivo.fGerarRelatorio(blnDirDeskTop: Boolean): Boolean;
var blnErroArq: Boolean;
begin
  Result := True;
  blnErroArq := False;
  If blnDirDeskTop Then
    FEscreve.strInitialDir:= TGeraExcel.fUserDesktop();
  FEscreve.OnEscreveValorCampo := OnEscreveValorCampo;
  FEscreve.OnSomaTotais := OnSomaTotais;
  FEscreve.OnResumo := OnResumo;
  FEscreve.protegeEstrutura := protegeEstrutura;
  FEscreve.blnShowFrmGravando := blnShowFrmGravando;
  FSvdXls.InitialDir := FEscreve.strInitialDir;
  If strFile = '' Then
    FSvdXls.Execute();

  If (FSvdXls.FileName = '') And (strFile = '') Then
    Exit(False);

  If  FileExists(FSvdXls.FileName) Then
  Begin
    If Not DeleteFile(pChar(FSvdXls.FileName)) Then
    Begin
      blnErroArq := True;
      Result := False;
    End;
  End;
  If Not blnErroArq Then
  Begin
    If strFile = '' Then
      FEscreve.NomeArquivo := FSvdXls.FileName
    Else
      FEscreve.NomeArquivo := strFile;

    Result := FEscreve.fEscreve;
    strFile := FEscreve.NomeArquivo;
  End;
end;

{ TEscreve }


function TEscreve.SetFontSize(value: integer): integer;
Begin
  case value of
     7,  8,  9: Result := 7;
    10, 11, 12: Result := 10;
    13, 14, 15: Result := 12;
    16, 17, 18: Result := 14;
    19, 20, 21: Result := 18;
    22, 23, 24: Result := 24;
  else
    Result := 36
  end;

End;

constructor TEscreve.Create;
begin
  Bloquear := False;
  blnShowFrmGravando := False;
  FListaTitulos := TList<TCampoExcelHtml>.Create;
  FListaTitulosEditaveis := TList<TCampoExcelHtml>.Create;
  FListaCampos  := TList<TCampoExcelHtml>.Create;
  FListaFiltros := TList<TCampoExcelHtml>.Create;
  FTotais :=TTotaisHTML.Create;

//  FArquivo := TStringList.Create;
end;

destructor TEscreve.Destroy;
begin
  FreeAndNil(FListaTitulos);
  FreeAndNil(FListaTitulosEditaveis);
  FreeAndNil(FListaCampos);
  FreeAndNil(FListaFiltros);
  FreeAndNil(FTotais);

//  FreeAndNil(FArquivo);

end;

function TEscreve.fEscreve: Boolean;
begin
  result := fEscreveTitulos;
  result := Result And fEscreveTitulosEditaveis;
  Result := Result and fEscreveFiltros;
  Result := Result And fEscreveCampos;
  If Result Then
    pSaveFile;
end;


function TEscreve.GetVirtualWidth(AValue: String; AFont: TFont):integer;
var
  ACanvas : TControlCanvas;
Begin
  ACanvas := TControlCanvas.Create;
  Try
    TControlCanvas(ACanvas).Control := Application.MainForm;
    AFont.Size := SetFontSize(Afont.Size);
    ACanvas.Font.Assign(AFont);

    result:=ACanvas.TextWidth(AValue);
  Finally
    FreeAndNil(ACanvas);
  End;
End;



{ TEscreveCSV }

function TEscreveCSV.fEscreveTitulos: Boolean;
  var campo: TCampoExcelHtml;
begin
  Result := True;
  Try
   For campo  in FListaTitulos do
     Write(FArquivo, campo.FText + ';');
  Except
    Result := False;
  End;
end;

function TEscreveCSV.fEscreveTitulosEditaveis: Boolean;
  var campo: TCampoExcelHtml;
begin
  Result := True;
  Try
   For campo  in FListaTitulosEditaveis do
     Write(FArquivo, campo.FText + ';');
  Except
    Result := False;
  End;
end;

function TEscreveCSV.fEscreveFiltros: Boolean;
  var campo: TCampoExcelHtml;
begin
  Result := True;
  Try
   For campo  in FListaFiltros do
     Write(FArquivo, campo.FText + ';');
  Except
    Result := False;
  End;
end;


function TEscreveCSV.fEscreveLinha(var Value: TValue): boolean;
begin
  Result := True;
end;

function TEscreveCSV.fEscreveCampos: Boolean;
  var campo: TCampoExcelHtml;
     strLinha: String;
begin
  Result := True;
  FProgressBar.Position := FDataSet.RecordCount - 1;
  Try
    strLinha := '';
    For campo  in FListaCampos do
      strLinha := strLinha + campo.FText + ';';
    Write(FArquivo, strLinha);

    FDataSet.First;
    While not FDataSet.Eof Do
    Begin
      strLinha := '';
      For campo  in FListaCampos do
        strLinha := strLinha + FDataSet.FieldByName(campo.FFieldName).AsString + ';';
      Write(FArquivo, strLinha + ';');
      FProgressBar.Position := FProgressBar.Position + 1;
      Application.ProcessMessages;
      FDataSet.Next;
    End;
  Except
    Result := False;
  End;
end;

procedure TEscreveCSV.pFechaLinha;
begin
  {}
end;

procedure TEscreveCSV.pSaveFile;
Begin
{}
End;

{ TEscreveHTML }

procedure TEscreveHTML.pIniciaHTML;
begin
  AssignFile(FArquivo, ChangeFileExt(FNomeArquivo, '.xls'));
  ReWrite(FArquivo);
  Write(FArquivo,  '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">');
  Write(FArquivo,  '<html>');
  Write(FArquivo,  '<head>');
  Write(FArquivo,  '	<meta http-equiv="content-type" content="text/html; charset=windows-1252"/>');
  Write(FArquivo,  '	<title></title>');
  Write(FArquivo,  '	<meta name="generator" content="LibreOffice 5.4.5.1 (Windows)"/>');
  Write(FArquivo,  '	<meta name="created" content="00:00:00"/>');
  Write(FArquivo,  '	<meta name="changed" content="2018-08-27T15:44:39.331000000"/>');
  Write(FArquivo,  '	<style type="text/css">');
  Write(FArquivo,  '		body,div,table,thead,tbody,tfoot,tr,th,td,p { font-family:"Liberation Sans"; font-size:x-small }');
  Write(FArquivo,  '		a.comment-indicator:hover + comment { background:#ffd; position:absolute; display:block; border:1px solid black; padding:0.5em;  }');
  Write(FArquivo,  '		a.comment-indicator { background:red; display:inline-block; border:1px solid black; width:0.5em; height:0.5em;  }');
  Write(FArquivo,  '		comment { display:none;  }');
  Write(FArquivo,  '	</style>');
  Write(FArquivo,  '</head>');
  Write(FArquivo,  '<body>');
end;


procedure  TEscreveHTML.pEscreveTitulo(campo: TCampoExcelHtml);
Begin
End;

procedure TEscreveHTML.pFechaLinha;
begin
  Write(FArquivo,  '</tr>');
end;

function TEscreveHTML.fEscreveTitulos: Boolean;
  var
    campo: TCampoExcelHtml;

begin
  pIniciaHTML;
  Write(FArquivo,  '<table cellspacing="0" border="0">');
  pSetaTamanhoColunas;

  For campo in FListaTitulos do
  Begin

    Write(FArquivo,  '	<tr>');
    Write(FArquivo,  '    <td style="border-top: 1px solid #ffffff; border-bottom: 1px solid #ffffff; ');
    Write(FArquivo,  '        border-left: 1px solid #ffffff; border-right: 1px solid #ffffff" colspan='+IntToStr(fGetQtdColunaVisivel)+' height="26" ');
    Write(FArquivo,  ' align="' + fRetTipoHtmpToAlign(campo.FAlign) + '" ');
    Write(FArquivo,  '        valign=middle bgcolor="#FFF200"><b>');
    Write(FArquivo,  '        <font face="' + campo.FFont.Name + '" '+ SizeToHtmlNumber(campo.FFont.Size)  +' color="#' + ColorToHtml(campo.FFont.Color) + '">' + campo.FText + ' </font></b>');
    Write(FArquivo,  '     </td>');
    Write(FArquivo,  '	</tr>');
  End;

  Result := True;
end;

function TEscreveHTML.fEscreveTitulosEditaveis: Boolean;
  var campos: TCampoExcelHtml;
begin
  For campos in FListaTitulosEditaveis do
  Begin
    Write(FArquivo,  '<tr>');

    Write(FArquivo,  '<td style="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: 1px solid #000000" height="17"');
    Write(FArquivo,  'align="'+fRetTipoHtmpToAlign(campos.FAlign)+'" bgcolor="#FFFFFF">');
    Write(FArquivo,  '   <b><font face="Arial" color="#000000">' + campos.FText + '</font></b></td>');

    Write(FArquivo,  '<td style="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: 1px solid #000000" height="17"');
    Write(FArquivo,  'align="'+fRetTipoHtmpToAlign(campos.FAlign)+'" bgcolor="#FFFFFF">');
    Write(FArquivo,  '   <b><font face="Arial" color="#000000">' + campos.FFieldName + '</font></b></td>');

    Write(FArquivo,  '<td style="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: 1px solid #000000" height="17"');
    Write(FArquivo,  'align="'+fRetTipoHtmpToAlign(campos.FAlign)+'" bgcolor="#FFFFFF">');
    Write(FArquivo,  '   <b><font face="Arial" color="#000000">' + campos.FObservacao+ '</font></b></td>');
    Write(FArquivo,  '</tr>');
  End;
  Result := True;
end;

function TEscreveHTML.fGetQtdColunaVisivel: Integer;
  var campo: TCampoExcelHtml;
begin
  Result := 0;
  For campo in FListaCampos do
    If Not Campo.FApenasQuebra Then
      Inc(Result);
end;

function TEscreveHTML.fRetTipoHtmpToAlign(campo: TTAlignHTM): string;
Begin
  case campo of
    tahtmlUndef,
    tahtmlLeft: result := 'left';
    tahtmlRight: result := 'right';
    tahtmlCenter: result := 'center';
  end;
End;

procedure TEscreveHTML.pSetaTamanhoColunas;
  var campo: TCampoExcelHtml;
begin
  For campo in FListaCampos do
  	Write(FArquivo,  '<colgroup width="' + IntToStr(campo.FWidth) + '"></colgroup>');
End;

function TEscreveHTML.SizeToHtmlNumber(value: integer): string;
begin
  case value of
     7,  8,  9: Result := 'size=1';
    10, 11, 12: Result := 'size=2';
    13, 14, 15: Result := 'size=3';
    16, 17, 18: Result := 'size=4';
    19, 20, 21: Result := 'size=5';
    22, 23, 24: Result := 'size=6';
  else
    Result := 'size=7'
  end;

end;



function TEscreveHTML.fEscreveFiltros: Boolean;
begin
  Result := True;
end;

function TEscreveHTML.fEscreveLinha(var Value: TValue): boolean;
begin
  If Value.pularLinha Then
     Write(FArquivo,  '<tr>');
  Write(FArquivo,  '<td style="border-top: 1px solid #ffffff; border-bottom: 1px solid #ffffff; border-left: 1px solid #ffffff; border-right: 1px solid #ffffff"');
  If Value.ColSpan > 0 Then
    Write(FArquivo,  'colspan=' + IntToStr(Value.ColSpan));
  Write(FArquivo,  ' height="26" align="'+ fRetTipoHtmpToAlign(Value.alinhamento) +'" valign=middle bgcolor="#'+ ColorToHtml(Value.BackgroundColor) +'">');
  Write(FArquivo,  ' <b><font face="'+ Value.FontName+'" '+SizeToHtmlNumber(Value.Size) +' color="#'+ ColorToHtml(Value.FontColor) +'">'+ Value.Value + '</font></b></td>');
  Value.pularLinha := False;
  Result := True;
end;

procedure TEscreveHTML.pBloquearCelulas(Excel: TExcel);
var  campos:  TCampoExcelHtml;
begin
  For campos in FListaTitulosEditaveis do
  Begin
    Excel.BloquearCelulas(campos.FLetra + IntToStr(FListaTitulos.Count + 1), campos.FLetra + IntToStr(FListaTitulos.Count + 2), campos.FBloquear);
  End;

  For campos in FListaCampos do
  Begin
    Excel.BloquearCelulas(campos.FLetra + IntToStr(iniDetalhes), campos.FLetra + IntToStr(DataSet.RecordCount+  iniDetalhes -1), campos.FBloquear);
  End;
end;

procedure TEscreveHTML.pCriaValidacao(Excel: TExcel);
var  campos:  TCampoExcelHtml;
begin
  For campos in FListaCampos do
  Begin
    If (campos.FValidaValor.FvalorMinimo <> -9999999) and
       (campos.FValidaValor.FvalorMinimo <> -9999999) Then
     Excel.ValidarCelulas(campos.FLetra + IntToStr(iniDetalhes), campos.FLetra + IntToStr(DataSet.RecordCount+  iniDetalhes -1), FloatToStr(campos.FValidaValor.FvalorMinimo), FloatToStr(campos.FValidaValor.FValorMaximo));
  End;

End;

procedure TEscreveHTML.pEscreverTituloCampos;
  var campos: TCampoExcelHtml;
begin
  Write(FArquivo,  '<tr>');
  For campos in FListaCampos do
  Begin
    If campos.FApenasQuebra Then
      Continue;
    Write(FArquivo,  '<td style="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: 1px solid #000000" height="17"');
    Write(FArquivo,  'align="'+fRetTipoHtmpToAlign(campos.FAlign)+'" bgcolor="#000000">');
    Write(FArquivo,  '   <b><font face="' + campos.FFont.Name + '" color="#' + ColorToHtml(campos.FFont.Color) + '">' + campos.FText + '</font></b></td>');
  End;
  Write(FArquivo,  '</tr>');
End;

procedure TEscreveHTML.pEscreveQuebra(Campo: TCampoExcelHtml; AValor: String);
begin
  Write(FArquivo,  '	<tr>');
  Write(FArquivo,  '    <td style="border-top: 1px solid #ffffff; border-bottom: 1px solid #ffffff; ');
  Write(FArquivo,  '        border-left: 1px solid #ffffff; border-right: 1px solid #ffffff" colspan='+IntToStr(fGetQtdColunaVisivel)+' height="26" ');
  Write(FArquivo,  ' align="' + fRetTipoHtmpToAlign(tahtmlCenter) + '" ');
  Write(FArquivo,  '        valign=middle bgcolor="#008080"><b>');
  If Assigned(campo.procTrataValorQuebra) Then
    AValor := campo.procTrataValorQuebra(FDataSet, AValor, Campo.FFieldName);

  Write(FArquivo,  '        <font face="' + campo.FFont.Name + '" '+ SizeToHtmlNumber(campo.FFont.Size)  +' color="#' + ColorToHtml(clwhite) + '">' + AValor + ' </font></b>');
  Write(FArquivo,  '     </td>');
  Write(FArquivo,  '	</tr>');
End;

Function TEscreveHTML.fEscreveCamposProgresso(cxProgresso: TCxProgressBar): Boolean;
  var campos: TCampoExcelHtml;
      ColorBackGround: TColor;
      ValueFontColor: TColor;
      Text: String;

begin
  Result := True;
  FDataSet.First;
  pEscreverTituloCampos;

 // Soma As Listas + os titulo das colunas
  iniDetalhes := FListaTitulos.Count + FListaTitulosEditaveis.Count + FListaFiltros.Count + 2;
  If Assigned(FProgressBar) Then
  Begin
    FProgressBar.Visible := True;
    if DataSet.RecordCount > 1 Then
      FProgressBar.Max := DataSet.RecordCount -1
    Else
      FProgressBar.Max := 1;
  End
  Else
  Begin
    If Assigned(cxProgresso) Then
    Begin
      if DataSet.RecordCount > 1 Then
        cxProgresso.Properties.Max := DataSet.RecordCount -1
      Else
        cxProgresso.Properties.Max := 1;
    End;
  End;


  While Not FDataSet.Eof do
  Begin
    For campos in FListaCampos do
    Begin
      If (campos.FQuebra) Then
      Begin
        If campos.FFieldName <> '' Then
           Text  := FDataSet.FieldByName(campos.FFieldName).AsString;

        If (campos.FValueQuebra <> Text) Then
        Begin
          campos.FValueQuebra := Text;
          pEscreveQuebra(campos, Text);
        End;
      End;
    End;

    Write(FArquivo,  '<tr>');
    For campos in FListaCampos do
    Begin
      If campos.FApenasQuebra Then
        Continue;
      Text := '';
      If FDataSet.RecNo Mod 2 = 0 Then
        ColorBackGround := clLtGray
      Else
        ColorBackGround := clWhite;
      ValueFontColor := campos.FFontValues.Color;
      If campos.FFieldName <> '' Then
         Text  := FDataSet.FieldByName(campos.FFieldName).AsString;


      If Assigned(FOnEscreveValorCampo) Then
        FOnEscreveValorCampo(DataSet, campos.FIdentificador, Text, ColorBackGround, ValueFontColor);

      If Campos.FFieldType = ftFloat Then
        Write(FArquivo,  '<td style="border-top: 1px solid #000000;border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: 1px solid #000000" height="17" sdnum="1046;0;#.##0,00"')
      Else
        Write(FArquivo,  '<td style="border-top: 1px solid #000000;border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: 1px solid #000000" height="17" sdnum="1046;0;@"');
      Write(FArquivo,  ' align="' + fRetTipoHtmpToAlign(campos.FAlign) + '" ');
      Write(FArquivo,  'bgcolor="#'+ColorToHtml(ColorBackGround)+'"">');

      If Campos.FFieldType = ftFloat Then
      Begin
        If fEmptyStr(Text) Then
          Text := '0';
        Text := FormatFloat('###,##0.#######', StrToFloat(Text));
      End;
      Write(FArquivo,  '<font face="' + campos.FFontValues.Name + '" color=' + ColorToHtml(ValueFontColor) + '>' + Text + '</font></td>');
    End;
    if Assigned( FOnSomaTotais) then
      FOnSomaTotais(DataSet, FTotais);
    Write(FArquivo,  '</tr>');
    FDataSet.Next;
    If Assigned( FProgressBar) Then
      FProgressBar.Position := FProgressBar.Position + 1
    Else If Assigned(cxProgresso) Then
      cxProgresso.Position := cxProgresso.Position + 1;

    Application.ProcessMessages;
  End;

  If Assigned(FOnResumo) Then
    FOnResumo(DataSet,
              FTotais);


  Write(FArquivo,  '</table>');
  Write(FArquivo,  '</body>');
  Write(FArquivo,  '</html>');

End;



function TEscreveHTML.fEscreveCampos: Boolean;
begin
 If blnShowFrmGravando Then
   Result := TfrmGravando.fExecuta(fEscreveCamposProgresso, frmGravando, 'Salvando dados, aguarde...')
 Else
   Result := fEscreveCamposProgresso(nil) ;

end;


procedure TEscreveHTML.pAjustaPlanilha();
begin
End;



procedure TEscreveHTML.pSaveFile;
var senhaAdm: String;
Begin
  CloseFile(FArquivo);

  FExcel := TExcel.fCriarExcel(nil);

  blnProcessouPlanilha := False;
  If Assigned(FProgressBar) Then
    FProgressBar.Style := pbstMarquee;

  FExcel.AbrirArquivo(ChangeFileExt(FNomeArquivo, '.xls'));
  FExcel.blnShowOnTerminate := False;
  FExcel.SalvarArquivo(True);
  FExcel.FecharArquivo;
  FExcel.AbrirArquivo(ChangeFileExt(FNomeArquivo, '.xls'));
  FExcel.AutoAjuste;
  if Bloquear then
    pBloquearCelulas(FExcel);
  pCriaValidacao(FExcel);
  senhaAdm := '';
  //protege as celulas
  if Bloquear then
    FExcel.ProtegerPlanilha(SEN_ADM);
  If protegeEstrutura Then
  Begin
    //protege a planilha com senha
    FExcel.ProtegerEstrutura(SEN_ADM);
    senhaAdm := SEN_ADM;
  End;

  FExcel.SalvarArquivo(True, True, senhaAdm);
  FExcel.FecharArquivo;
  If Assigned(ProgressBar) Then
    ProgressBar.Visible := False;

  FreeAndNil(FExcel);
  blnProcessouPlanilha := true;
  If Assigned(FProgressBar) Then
  Begin
    FProgressBar.Style := pbstNormal;
    FProgressBar.Position := 0;
    FProgressBar.Max := 0;
  End;

End;


function TEscreveHTML.ColorToHtml( cor: TColor ): string;
begin
 Result := (IntToHex(GetRValue(cor), 2) +
            IntToHex(GetGValue(cor), 2) +
            IntToHex(GetBValue(cor), 2));
end;

{ TTotais }

destructor TTotaisHTML.Destroy;
begin
  SetLength(FarrTotais, 0);
end;

function TTotaisHTML.getTotalizador(index: string): TTotalizador;
var totalizador: TTotalizador;
begin
  Result := nil;
  For totalizador in FarrTotais do
    If totalizador.Identificador = index Then
    Begin
      Result := totalizador;
      Break;
    End;
end;

procedure TTotaisHTML.setTotalizador(index: string; const Value: TTotalizador);
var i: integer;
    blnEncontrou: Boolean;
begin
  blnEncontrou := False;
  For i := 0 To High(FarrTotais) do
  begin
    If FarrTotais[i].Identificador = index Then
    Begin
      FarrTotais[i] := Value;
      blnEncontrou  := True;
      Break;
    End;
  End;
  If Not blnEncontrou Then
     AdicionaTotais(Value);
end;

procedure TTotaisHTML.AdicionaTotais(Totalizador: TTotalizador);
begin
  SetLength(FarrTotais, length(FarrTotais) + 1);
  FarrTotais[High(FarrTotais)] := Totalizador;
end;


end.